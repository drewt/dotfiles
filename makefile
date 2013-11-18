
.SUFFIXES:

bash = .bashrc .bash_profile
beets = .config/beets/config.yaml
cmus = .config/cmus/autosave .config/cmus/rc .config/cmus/rc.scm
dwm = dev/dwm/config.h
gtk = .config/gtk-3.0/settings.ini .gtkrc-2.0
mpv = .mpv/config
vim = .vimrc \
      .vim/colors/greenery.vim \
      .vim/ftplugin/erlang.vim \
      .vim/ftplugin/python.vim \
      .vim/ftplugin/scheme.vim \
      .vim/autoload/pathogen.vim
x11 = .xinitrc .Xresources

targets = $(bash) $(beets) $(cmus) $(dwm) $(gtk) $(mpv) $(vim) $(x11)

all: $(targets)

$(targets): %: $(HOME)/%
	mkdir -p ./$(dir $@)
	cp $< $@

clean:
	rm -f $(targets)
