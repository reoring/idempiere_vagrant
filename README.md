idempiere_vagrant
=================

Vagrant environment for the iDempiere with chef recipe

# Setup

1. copy aws_config.dist.yml aws_config.yml then replace placeholders with your own aws access token information.

2. place your keypair file to the idempiere.pem

# Usage

## start on local

```
vagrant up
```

## start on AWS

```
vagrant up --provider=aws
```
