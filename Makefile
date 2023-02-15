
TEXCOMPILER := pdflatex
SOURCES := $(wildcard *.tex)
PLATFORM := $(shell uname -s)
ifeq ($(PLATFORM), Linux)
	ECHO_FLAGS := "-e"
else
	ECHO_FLAGS := ""
endif

all: vita.pdf vita-nopubs.pdf pubslist.pdf

vita.pdf: $(SOURCES)
	@ echo '' > flags.tex
	@ echo $(ECHO_FLAGS) '\\newboolean{includepubs}' >> flags.tex
	@ echo $(ECHO_FLAGS) '\\setboolean{includepubs}{true}' >> flags.tex
	@ echo '' >> flags.tex
	@ $(TEXCOMPILER) vita
	@ $(TEXCOMPILER) vita

vita-nopubs.pdf: $(SOURCES)
	@ echo '' > flags.tex
	@ echo $(ECHO_FLAGS) '\\newboolean{includepubs}' >> flags.tex
	@ echo $(ECHO_FLAGS) '\\setboolean{includepubs}{false}' >> flags.tex
	@ echo '' >> flags.tex
	@ cp vita.tex vita-nopubs.tex
	@ $(TEXCOMPILER) vita-nopubs
	@ $(TEXCOMPILER) vita-nopubs
	@ rm -f vita-nopubs.tex

pubslist.pdf: $(SOURCES)
	@ echo '' > flags.tex
	@ echo $(ECHO_FLAGS) '\\newboolean{includepubs}' >> flags.tex
	@ echo $(ECHO_FLAGS) '\\setboolean{includepubs}{false}' >> flags.tex
	@ echo '' >> flags.tex
	@ $(TEXCOMPILER) $(basename $@)
	@ $(TEXCOMPILER) $(basename $@)

.PHONY: clean
clean:
	@ for FILESTEM in vita vita-nopubs pubslist ; do \
		rm -f $$FILESTEM.aux ; \
		rm -f $$FILESTEM.log ; \
		rm -f $$FILESTEM.out ; \
		rm -f $$FILESTEM.pdf ; \
	done
