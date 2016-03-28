{
module Lexer (Token(..), get_tokens) where
}

%wrapper "basic"

$alpha = [a-zA-Z]
$eol   = [\n]
$otherCars = ~[a-zA-Z\(\)\[\]\{\}\\\/]

@del = "(" | ")" | "[" | "]" | "{" | "}"
@ident = $alpha+
@other = ($eol | $otherCars)+

tokens :-
  @ident    { \s -> IDENT s }
  "\"       { \s -> BS }
  @del      { \s -> selectDel s }
  "/"       { \s -> DIV }
  @other    { \s -> RAW s }
  $eol      ;
  

{
data Token =
  IDENT String |
  BS | DIV |
  LPAR | RPAR | LCRO | RCRO | LBRA | RBRA |
  RAW String
  deriving (Eq, Show)

selectDel :: String -> Token
selectDel "(" = LPAR
selectDel ")" = RPAR
selectDel "[" = LCRO
selectDel "]" = RCRO
selectDel "{" = LBRA
selectDel "}" = RBRA

get_tokens str = go ('\n',[],str)
	where go inp@(_,_bs,str) =
		case alexScan inp 0 of
			AlexEOF -> []
			AlexError s -> error $ show s
			AlexSkip  inp' len     -> go inp'
			AlexToken inp' len act -> act (take len str) : go inp'
}
