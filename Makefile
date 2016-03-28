BIN=pretex
GENERATED=lexer.hs parser.hs
MODULES=lexer ast parser compile main

all: $(BIN)

$(BIN): $(GENERATED)
	ghc $(MODULES) -o $(BIN)

.SUFFIXES: .hs .x .y

%.hs: %.x
	alex $< 

%.hs: %.y
	happy $<

clean:
	rm -f *.o *.hi
	rm -f $(GENERATED)
	rm -f $(BIN)

exec: $(BIN)
	./$(BIN)
