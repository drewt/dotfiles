
.SUFFIXES:

TARGETS = .xinitrc .Xresources .vimrc .gvimrc .bashrc dwm/config.h

all: $(TARGETS)

$(TARGETS): %: $(HOME)/%
	mkdir -p ./$(dir $@)
	cp $< $@

clean:
	rm -f $(TARGETS)
