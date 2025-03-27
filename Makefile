# Copy files into place and reload ct so any running processes pick up the change
#
DESTDIR = ${HOME}/.config/chromaterm
INSTALL = install
INSTALL_PROGRAM = $(INSTALL)
INSTALL_OPTS = -pSv -m 644

.PHONY: all clean restart
.DEFAULT: all

all: build install restart

pull:
	git pull

build: 
	@./generate_conf.sh

install: build
	@$(INSTALL_PROGRAM) -d $(DESTDIR)
	$(INSTALL_PROGRAM) $(INSTALL_OPTS) chromaterm.yml $(DESTDIR)/chromaterm.yml

restart:
	ct -r

clean:
	rm -f chromaterm.yml
