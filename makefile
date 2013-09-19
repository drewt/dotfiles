
.SUFFIXES:

bash = .bashrc
cmus = .cmus/autosave .cmus/rc .cmus/rc.scm
dwm = dwm/config.h
vim = .vimrc \
      .vim/colors/greenery.vim \
      .vim/ftplugin/erlang.vim \
      .vim/ftplugin/python.vim \
      .vim/ftplugin/scheme.vim \
      .vim/autoload/pathogen.vim
x11 = .xinitrc .Xresources

targets = $(bash) $(cmus) $(dwm) $(vim) $(x11)

all: $(targets)

$(targets): %: $(HOME)/%
	mkdir -p ./$(dir $@)
	cp $< $@

clean:
	rm -f $(targets)
