
.SUFFIXES:

TARGETS = .xinitrc .Xresources .vimrc .bashrc dwm/config.h \
	  .cmus/autosave .cmus/rc .cmus/rc.scm

all: $(TARGETS)

$(TARGETS): %: $(HOME)/%
	mkdir -p ./$(dir $@)
	cp $< $@

clean:
	rm -f $(TARGETS)
