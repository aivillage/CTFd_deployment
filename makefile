setup_plugin:
	cd gits && git clone https://github.com/aivillage/llm_verification.git

setup_theme:
	cd gits && git clone https://github.com/aivillage/aiv_ctfd_theme.git

setup: setup_plugin setup_theme
	

up:
	docker compose -f docker-compose.dev.yml up --build
