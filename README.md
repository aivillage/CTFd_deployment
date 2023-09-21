# CTFd_deployment

1. Run `make setup` to clone the repos you need for this and create the config directory
2. Add your keys into `config/llm_router/.env_keys`
2. Then run `make up` to create a service with the correct theme and plugin with the monolith deployment. 

This is a dev instance, you should customize the environment variables in the newly created `config` to your needs.

# Monolith Deployment

This deploys everything on a single server that does everything. This is appropriate for smaller GRTs, you can run a few dozen people easily off of a small NUC. 

# Todo:

We need a split deployment that deploys the `llm_router` component remotely, and creates a pair of proxies. These need to establish a TLS connection between them with authentication and allow for a deployment of all but the `llm_router` locally. 