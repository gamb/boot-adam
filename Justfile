build:
	nix build .#default

add:
	nix profile add .#default

update: build
	nix profile upgrade --all
