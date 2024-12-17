all:
	@echo "Usage: make [install|uninstall]"

install:
	@echo "Installing pacmark..."
	sudo install -Dm755 src/pacmark.sh /usr/local/bin/pacmark
	mkdir -p ~/.local/lib/pacmark
	install -Dm644 src/utils.sh ~/.local/lib/pacmark/utils.sh
	install -Dm644 src/clean.sh ~/.local/lib/pacmark/clean.sh
	install -Dm644 src/generate.sh ~/.local/lib/pacmark/generate.sh
	install -Dm644 src/status.sh ~/.local/lib/pacmark/status.sh
	install -Dm644 src/mark.sh ~/.local/lib/pacmark/mark.sh
	@echo "Installation finished."
	@echo "Generating packages.list ..."
	bash src/pacmark.sh generate
	@echo "Generating packages.list finished."
	@echo "Done!"

uninstall:
	@echo "Uninstalling pacmark..."
	sudo rm -f /usr/local/bin/pacmark
	rm -rf ~/.local/lib/pacmark
	@echo "Done!"
