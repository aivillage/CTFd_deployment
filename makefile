SHELL := /bin/bash

config:
	cp -r config_template config
	openssl rand -base64 32 > config/ctfd/.ctfd_secret_key

setup_plugin:
	cd gits && git clone https://github.com/aivillage/llm_verification.git

setup_theme:
	cd gits && git clone https://github.com/aivillage/aiv_ctfd_theme.git

update:
	cd gits/aiv_ctfd_theme
	git pull origin main

	cd gits/llm_verification
	git pull origin main


setup: setup_plugin setup_theme config

up:
	docker compose -f docker-compose.monolith.yml up --build

build_ctfd:
	# For development delete old ctfd container and build a new one
	# Preserve other containrs to speed things up and so we don't need to
	# reinitialize users and challenges each time
	# This is proably better for hot reloading just CTFd
	# https://stackoverflow.com/questions/42529211/how-to-rebuild-and-update-a-container-without-downtime-with-docker-compose
	# docker stop ctfd_llmv_complete
	docker rm ctfd_llmv_complete
	docker compose -f docker-compose.monolith.yml build ctfd_llmv

clear_logs:
	sudo rm -rf .data/CTFd/logs/llmv_verification.log

clean:
	rm -rf config gits/*
	git checkout gits/README.md

.PHONY: clean