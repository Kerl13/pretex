{
module Parser (parse) where
import Lexer
import Ast
}

%name parse
%tokentype { Token }
%error { error . show }

%token
  ident       { IDENT _ }
  backslash   { BS }
  '/'         { DIV }
  LP          { LPAR }
  RP          { RPAR }
  LC          { LCRO }
  RC          { RCRO }
  LB          { LBRA }
  RB          { RBRA }
  raw         { RAW _ }

%left '/'

%%

pretex:
  pretex pretex0  { $1 <> $2 }
  | pretex0       { $1 } 

pretex0:
  LP pretex '/' pretex RP { Frac $2 $4 }
  | atom                  { $1 }

atom:
  raw               { let (RAW s) = $1 in (Raw s) }
  | backslash ident { let (IDENT s) = $2 in (Cmd s) }
  | backslash raw   { let (RAW s) = $2 in (Cmd s) }
  | ident           { let (IDENT s) = $1 in (Ident s) }
  | '/' '/'         { EscDiv }
  | delimited       { $1 }

delimited:
  LP pretex RP                        { Delimited Par $2 }
  | LC pretex RC                      { Delimited Cro $2 }
  | backslash LB pretex backslash RB  { Delimited Bra $3 }
  | LB pretex RB                      { Block $2 }

