export TEXINPUTS

TEX_FILES = $(wildcard src/*.tex)
PDF_FILES = $(TEX_FILES:src/%.tex=out/%.pdf)
CLS_FILES = $(wildcard cls/*.cls)

.PHONY: all clean

all: all-tex

all-tex: $(PDF_FILES)

out/%.pdf: src/%.tex $(CLS_FILES)
	bash scripts/build-latex.sh "$<"

out/%-zine.pdf: out/%.pdf
	bash scripts/build-zine.sh "$<"

out/%-a4.pdf: out/%.pdf
	bash scripts/build-a6-to-a4.sh "$<"

clean:
	rm -rf build/
	rm -rf out/
