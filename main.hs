module Main (main) where
import Lexer (get_tokens)
import Parser (parse)
import Compile (compile)

run :: String -> String
run = compile . parse . get_tokens

main = interact run
