PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
SHRDIR = $(PREFIX)/share
SUDO ?= sudo

.PHONY: all install uninstall

all:
	@echo "Usage: make [install|uninstall]"

install:
	@echo "Installing pacmark..."
	$(SUDO) install -Dm755 scripts/pacmark.sh $(DESTDIR)$(BINDIR)/pacmark
	$(SUDO) install -Dm644 scripts/utils.sh $(DESTDIR)$(SHRDIR)/pacmark/utils.sh
	$(SUDO) install -Dm644 scripts/clean.sh $(DESTDIR)$(SHRDIR)/pacmark/clean.sh
	$(SUDO) install -Dm644 scripts/generate.sh $(DESTDIR)$(SHRDIR)/pacmark/generate.sh
	$(SUDO) install -Dm644 scripts/status.sh $(DESTDIR)$(SHRDIR)/pacmark/status.sh
	$(SUDO) install -Dm644 scripts/mark.sh $(DESTDIR)$(SHRDIR)/pacmark/mark.sh
	@echo "Installation finished."
	@echo "Generating packages.list ..."
	bash $(DESTDIR)$(BINDIR)/pacmark generate
	@echo "Generating packages.list finished."
	@echo "Done."

uninstall:
	@echo "Uninstalling pacmark..."
	$(SUDO) rm -f $(DESTDIR)$(BINDIR)/pacmark
	$(SUDO) rm -rf $(DESTDIR)$(SHRDIR)/pacmark
	@echo "Done."
