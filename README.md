
**WARNING : developpement stopped, you should glance an eye at
[AsciiMath](https://github.com/Kerl13/AsciiMath) instead ;)**

# Pretex

A little compiler from an alternative version of LaTeX's mathematics to LaTeX

## Features

* Some identifiers like "cos" of "exp" do not need the preceding and useless
  `\`. The compiler add it automatically if not specified.
* The `\left` and `\right` commands are added to all pairs of delimiters. The
  compiler raises an error if delimiters do not match.
* Expressions of kind `(` *code* `/` *code* `)` are converted to LaTeX
  fractions using the `\frac` command. The `/` can be escaped by typing `//`.

### Example :
    
    > echo "(1/2)sin(2x) = cos(x)sin(x)" | ./pretex 
    \frac{1}{2}\sin\left(2x\right) = \cos\left(x\right)\sin\left(x\right)

## Todo

* A user-friendly wrapper
* Precise error handling
* Fix a bug with when running `cabal install`
