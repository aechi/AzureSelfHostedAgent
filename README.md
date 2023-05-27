`docker build --tag="<image_name>"`
`docker run --interactive --env-file .env <image_name>`

# Add this to azure-piplines.yml
pool:
  name: Default
  demands:
    - agent.name -equals AGENTDOCKER