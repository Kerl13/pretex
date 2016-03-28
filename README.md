# Pretex

A little compiler from an alternative version of LaTeX's mathematics to LaTeX

## Features

* Some identifiers like "cos" of "exp" do not need the preceding and useless
  `\`. The compiler add it automatically if not specified.
* The `\left` and `\right` commands are added to all pairs of delimiters. The
  compiler raises an error if delimiters do not match.
* Expressions of kind `(` *code* `/` *code* `)` are converted to LaTeX
  fractions using the `\frac` command. The `/` can be escaped by typing `//`.

## Todo

* A user-friendly wrapper
* Precise error handling
* Fix a bug with when running `cabal install`
