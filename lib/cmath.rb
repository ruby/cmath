# frozen_string_literal: true
##
# = Trigonometric and transcendental functions for complex numbers.
#
# CMath is a library that provides trigonometric and transcendental
# functions for complex numbers. The functions in this module accept
# integers, floating-point numbers or complex numbers as arguments.
#
# Note that the selection of functions is similar, but not identical,
# to that in module math. The reason for having two modules is that
# some users aren't interested in complex numbers, and perhaps don't
# even know what they are. They would rather have Math.sqrt(-1) raise
# an exception than return a complex number.
#
# For more information you can see Complex class.
#
# == Usage
#
# To start using this library, simply require cmath library:
#
#   require "cmath"

module CMath

  include Math

  # Backup of Math is needed because mathn.rb replaces Math with CMath.
  RealMath = Math # :nodoc:
  private_constant :RealMath

  %w[
    exp
    log
    log2
    log10
    sqrt
    cbrt
    sin
    cos
    tan
    sinh
    cosh
    tanh
    asin
    acos
    atan
    atan2
    asinh
    acosh
    atanh
  ].each do |meth|
    define_method(meth + '!') do |*args, &block|
      warn("CMath##{meth}! is deprecated; use CMath##{meth} or Math##{meth}", uplevel: 1) if $VERBOSE
      RealMath.send(meth, *args, &block)
    end
  end

  ##
  # Math::E raised to the +z+ power
  #
  #   CMath.exp(1.i * Math::PI) #=> (-1.0+1.2246467991473532e-16i)
  def exp(z)
    if z.respond_to?(:real?) and z.real?
      RealMath.exp(z)
    else
      ere = RealMath.exp(z.real)
      Complex(ere * RealMath.cos(z.imag),
              ere * RealMath.sin(z.imag))
    end
  end

  ##
  # Returns the natural logarithm of Complex. If a second argument is given,
  # it will be the base of logarithm.
  #
  #   CMath.log(1 + 4i)     #=> (1.416606672028108+1.3258176636680326i)
  #   CMath.log(1 + 4i, 10) #=> (0.6152244606891369+0.5757952953408879i)
  def log(z, b=::Math::E)
    if z.respond_to?(:negative?) and !z.negative? and !b.negative?
      RealMath.log(z, b)
    else
      Complex(RealMath.log(z.abs), z.arg) / log(b)
    end
  end

  ##
  # Returns the base 2 logarithm of +z+
  #
  #   CMath.log2(-1) => (0.0+4.532360141827194i)
  def log2(z)
    if z.respond_to?(:negative?) and !z.negative?
      RealMath.log2(z)
    else
      log(z) / RealMath.log(2)
    end
  end

  ##
  # Returns the base 10 logarithm of +z+
  #
  #   CMath.log10(-1) #=> (0.0+1.3643763538418412i)
  def log10(z)
    if z.respond_to?(:negative?) and !z.negative?
      RealMath.log10(z)
    else
      log(z) / RealMath.log(10)
    end
  end

  ##
  # Returns the non-negative square root of Complex.
  #
  #   CMath.sqrt(-1 + 0i) #=> 0.0+1.0i
  def sqrt(z)
    if z.respond_to?(:negative?)
      if z.negative?
        Complex(0, RealMath.sqrt(-z))
      else
        RealMath.sqrt(z)
      end
    else
      if z.imag < 0 ||
         (z.imag == 0 && z.imag.to_s[0] == '-')
        sqrt(z.conjugate).conjugate
      else
        r = z.abs
        x = z.real
        Complex(RealMath.sqrt((r + x) / 2.0), RealMath.sqrt((r - x) / 2.0))
      end
    end
  end

  ##
  # Returns the principal value of the cube root of +z+
  #
  #   CMath.cbrt(1 + 4i) #=> (1.449461632813119+0.6858152562177092i)
  def cbrt(z)
    z ** (1.0/3)
  end

  ##
  # Returns the sine of +z+, where +z+ is given in radians
  #
  #   CMath.sin(1 + 1i) #=> (1.2984575814159773+0.6349639147847361i)
  def sin(z)
    if z.respond_to?(:real?) and z.real?
      RealMath.sin(z)
    else
      Complex(RealMath.sin(z.real) * RealMath.cosh(z.imag),
              RealMath.cos(z.real) * RealMath.sinh(z.imag))
    end
  end

  ##
  # Returns the cosine of +z+, where +z+ is given in radians
  #
  #   CMath.cos(1 + 1i) #=> (0.8337300251311491-0.9888977057628651i)
  def cos(z)
    if z.respond_to?(:real?) and z.real?
      RealMath.cos(z)
    else
      Complex(RealMath.cos(z.real) * RealMath.cosh(z.imag),
              -RealMath.sin(z.real) * RealMath.sinh(z.imag))
    end
  end

  ##
  # Returns the tangent of +z+, where +z+ is given in radians
  #
  #   CMath.tan(1 + 1i) #=> (0.27175258531951174+1.0839233273386943i)
  def tan(z)
    if z.respond_to?(:real?) and z.real?
      RealMath.tan(z)
    else
      sin(z) / cos(z)
    end
  end

  ##
  # Returns the hyperbolic sine of +z+, where +z+ is given in radians
  #
  #   CMath.sinh(1 + 1i) #=> (0.6349639147847361+1.2984575814159773i)
  def sinh(z)
    if z.respond_to?(:real?) and z.real?
      RealMath.sinh(z)
    else
      Complex(RealMath.sinh(z.real) * RealMath.cos(z.imag),
              RealMath.cosh(z.real) * RealMath.sin(z.imag))
    end
  end

  ##
  # Returns the hyperbolic cosine of +z+, where +z+ is given in radians
  #
  #   CMath.cosh(1 + 1i) #=> (0.8337300251311491+0.9888977057628651i)
  def cosh(z)
    if z.respond_to?(:real?) and z.real?
      RealMath.cosh(z)
    else
      Complex(RealMath.cosh(z.real) * RealMath.cos(z.imag),
              RealMath.sinh(z.real) * RealMath.sin(z.imag))
    end
  end

  ##
  # Returns the hyperbolic tangent of +z+, where +z+ is given in radians
  #
  #   CMath.tanh(1 + 1i) #=> (1.0839233273386943+0.27175258531951174i)
  def tanh(z)
    if z.respond_to?(:real?) and z.real?
      RealMath.tanh(z)
    else
      sinh(z) / cosh(z)
    end
  end

  ##
  # Returns the arc sine of +z+
  #
  #   CMath.asin(1 + 1i) #=> (0.6662394324925153+1.0612750619050355i)
  def asin(z)
    if z.respond_to?(:real?) and z.real? and (-1..1).cover?(z)
      RealMath.asin(z)
    else
      (-1.0).i * log(1.0.i * z + sqrt(1.0 - z * z))
    end
  end

  ##
  # Returns the arc cosine of +z+
  #
  #   CMath.acos(1 + 1i) #=> (0.9045568943023813-1.0612750619050357i)
  def acos(z)
    if z.respond_to?(:real?) and z.real? and (-1..1).cover?(z)
      RealMath.acos(z)
    else
      (-1.0).i * log(z + 1.0.i * sqrt(1.0 - z * z))
    end
  end

  ##
  # Returns the arc tangent of +z+
  #
  #   CMath.atan(1 + 1i) #=> (1.0172219678978514+0.4023594781085251i)
  def atan(z)
    if z.respond_to?(:real?) and z.real?
      RealMath.atan(z)
    else
      1.0.i * log((1.0.i + z) / (1.0.i - z)) / 2.0
    end
  end

  ##
  # returns the arc tangent of +y+ divided by +x+ using the signs of +y+ and
  # +x+ to determine the quadrant
  #
  #   CMath.atan2(1 + 1i, 0) #=> (1.5707963267948966+0.0i)
  def atan2(y,x)
    if y.respond_to?(:real?) and y.real? and x.respond_to?(:real?) and x.real?
      RealMath.atan2(y,x)
    else
      (-1.0).i * log((x + 1.0.i * y) / sqrt(x * x + y * y))
    end
  end

  ##
  # returns the inverse hyperbolic sine of +z+
  #
  #   CMath.asinh(1 + 1i) #=> (1.0612750619050357+0.6662394324925153i)
  def asinh(z)
    if z.respond_to?(:real?) and z.real?
      RealMath.asinh(z)
    else
      log(z + sqrt(1.0 + z * z))
    end
  end

  ##
  # returns the inverse hyperbolic cosine of +z+
  #
  #   CMath.acosh(1 + 1i) #=> (1.0612750619050357+0.9045568943023813i)
  def acosh(z)
    if z.respond_to?(:real?) and z.real? and z >= 1
      RealMath.acosh(z)
    else
      log(z + sqrt(z * z - 1.0))
    end
  end

  ##
  # returns the inverse hyperbolic tangent of +z+
  #
  #   CMath.atanh(1 + 1i) #=> (0.4023594781085251+1.0172219678978514i)
  def atanh(z)
    if z.respond_to?(:real?) and z.real? and (-1..1).cover?(z)
      RealMath.atanh(z)
    else
      log((1.0 + z) / (1.0 - z)) / 2.0
    end
  end

  module_function :exp!
  module_function :exp
  module_function :log!
  module_function :log
  module_function :log2!
  module_function :log2
  module_function :log10!
  module_function :log10
  module_function :sqrt!
  module_function :sqrt
  module_function :cbrt!
  module_function :cbrt

  module_function :sin!
  module_function :sin
  module_function :cos!
  module_function :cos
  module_function :tan!
  module_function :tan

  module_function :sinh!
  module_function :sinh
  module_function :cosh!
  module_function :cosh
  module_function :tanh!
  module_function :tanh

  module_function :asin!
  module_function :asin
  module_function :acos!
  module_function :acos
  module_function :atan!
  module_function :atan
  module_function :atan2!
  module_function :atan2

  module_function :asinh!
  module_function :asinh
  module_function :acosh!
  module_function :acosh
  module_function :atanh!
  module_function :atanh

  module_function :frexp
  module_function :ldexp
  module_function :hypot
  module_function :erf
  module_function :erfc
  module_function :gamma
  module_function :lgamma

end
