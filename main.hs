module Main (main) where
import Lexer (get_tokens)
import Parser (parse)
import Compile (compile)

main = do
	c <- getContents
	putStr . compile . parse . get_tokens $ c
