# AI Village's CTFd Deployment

This combines the [LLM Verification](https://github.com/aivillage/llm_verification) plugin, the [router component](https://github.com/aivillage/llm_router) and the [theme](https://github.com/aivillage/aiv_ctfd_theme) and deploys them in (currently) a single docker compose on a single machine. We don't expect you to use this exact deployment, this repo is provided as a starting point to hack your own deployment together. 

## Intended Architecture

![A digram that shows the various components and their seperation](grt_digram.png?raw=true "GRT Architecture Diagram")

We've seperated out the various LLM API calls to each vendor into it's own component the `llm_router`. The front-end plugin, `llm_verification` will call the available models through this component. This pairing is designed to provide an idempotent connection and an additional auth & security layer in the deployment for the model API keys. This is important for conferences where you don't trust the network's reliability and security. The idempotency lets you resume conversations in the case of a temporary network failure, and all traffic is encrypted and goes to the same place so someone sniffing the conference network can't tell which model is being called at any one time as all traffic is encrypted and going to the same place. The idempotency is the most important feature for us.

# To use:

1. Run `make setup` to clone the repos you need for this and create the config directory
2. Add your keys into `config/llm_router/.env_keys`
2. Then run `make up` to create a service with the correct theme and plugin with the monolith deployment. 

This is a dev instance, you should customize the environment variables in the newly created `config` to your needs.

## Monolith Deployment

This deploys everything on a single server that does everything. This is appropriate for smaller GRTs, you can run a few dozen people easily off of a small NUC or AWS node. 

# Todo:

We need a split deployment that deploys the `llm_router` component remotely, and creates a pair of proxies. These need to establish a TLS connection between them with authentication and allow for a deployment of all but the `llm_router` locally. 