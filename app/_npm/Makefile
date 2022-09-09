# makefile
SHELL := /bin/bash

bold := $(shell tput bold)
sgr0 := $(shell tput sgr0)

update:
	npm install -g npm-check-updates
	ncu --upgrade

	@printf '\n\n$(bold)Instalando Node Modules$(sgr0)\n'
	npm install
	
	rm -rf ../staticfiles/vendor
	rm -rf ../staticfiles/images/bootstrap-icons

	@printf '\n$(bold)Actualizando Bootstrap$(sgr0)\n'
	mkdir -p ../staticfiles/vendor/bootstrap
	cp -r node_modules/bootstrap/dist/* ../staticfiles/vendor/bootstrap
	npm run sass-prod

	@printf '\n$(bold)Actualizando Bootstrap Icons$(sgr0)\n'
	mkdir -p ../staticfiles/vendor/bootstrap-icons
	cp -r node_modules/bootstrap-icons/font/* ../staticfiles/vendor/bootstrap-icons
	rm ../staticfiles/vendor/bootstrap-icons/index.html

	mkdir -p ../staticfiles/images/bootstrap-icons
	cp -r node_modules/bootstrap-icons/icons/* ../staticfiles/images/bootstrap-icons

	@printf '\n$(bold)Actualizando Bootstrap Plugin: Table$(sgr0)\n'
	mkdir -p ../staticfiles/vendor/bootstrap-table
	cp -r node_modules/bootstrap-table/dist/* ../staticfiles/vendor/bootstrap-table

	@printf '\n$(bold)Actualizando HTMX$(sgr0)\n'
	mkdir -p ../staticfiles/vendor/htmx
	cp -r node_modules/htmx.org/dist/* ../staticfiles/vendor/htmx

	@printf '\n$(bold)Actualizando ChartJS Plugin: ColorSchemes$(sgr0)\n'
	mkdir -p ../staticfiles/vendor/chartjs
	cp -r node_modules/chartjs-plugin-colorschemes/dist/* ../staticfiles/vendor/chartjs

	@printf '\n$(bold)Actualizando jQuery$(sgr0)\n'
	mkdir -p ../staticfiles/vendor/jquery
	cp -r node_modules/jquery/dist/* ../staticfiles/vendor/jquery

dev:
	npm run sass-dev