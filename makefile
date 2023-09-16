config:
	cp -r config_template config \
	openssl rand -base64 32 > config/ctfd/.ctfd_secret_key

setup_plugin:
	cd gits && git clone https://github.com/aivillage/llm_verification.git

setup_theme:
	cd gits && git clone https://github.com/aivillage/aiv_ctfd_theme.git

setup: setup_plugin setup_theme config

up:
	docker compose -f docker-compose.monolith.yml up --build
