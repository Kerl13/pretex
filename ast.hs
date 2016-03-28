module Ast (DelType(..), Elt(..), (<>)) where

-- Errors locations
data Position =
  Position !Int !Int !Int |
  PositionElement !Int !Int !Int !Int String
instance Show Position where
    show (PositionElement _ line char1 char2 filename) =
        "File \"" ++ filename ++ "\", line "
        ++ (show line) ++ ", characters "
        ++ (show char1) ++ "-" ++ (show (char1 + char2)) ++ ":\n"
    show (Position _ line char1) =
        "File <input>, line "
        ++ (show line) ++ ", starting from "
        ++ (show char1) ++ ":\n"

-- Delimitors
data DelType = Par | Cro | Bra 
instance Show DelType where
  show Par = "Parenthesis"
  show Cro = "Bracket"
  show Bra = "Brace"

-- LaTeX mathematical elements
data Elt =
  Raw String |
  Ident String |
  Cmd String |
  EscDiv |
  Seq Elt Elt |
  Delimited DelType Elt |
  Block Elt |
  Frac Elt Elt
  deriving (Show)

--data PElt = PElt Elt Position deriving (Show)

(<>) e e' = Seq e e'
