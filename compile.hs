module Compile (compile) where
import Ast
import qualified Data.Set as S

kw :: S.Set String
kw = S.fromList [
  -- Trigo
  "cos", "sin", "tan", "cotan",
  "arccos", "arcsin", "arctan",
  -- Other usuals functions
  "exp", "ln", "log",
  -- Limits
  "lim", "liminf", "limsup"]

compile :: Elt -> String
compile (Raw s) = s
compile (Ident s) = if S.member s kw then "\\" ++ s else s
compile (Cmd s) = "\\" ++ s
compile EscDiv = "/"
compile (Seq e1 e2) = compile e1 ++ compile e2
compile (Delimited t e) = let (l, r) = del t in
  "\\left" ++ l ++ compile e ++ "\\right" ++ r
  where del Par = ("(", ")")
        del Cro = ("[", "]")
        del Bra = ("\\{", "\\}")
compile (Block e) = "{" ++ compile e ++ "}"
compile (Frac e1 e2) = "\\frac{" ++ compile e1 ++ "}{" ++ compile e2 ++ "}"

