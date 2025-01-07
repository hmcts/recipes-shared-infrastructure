# recipes-shared-infrastructure

This repository contains the shared the common infra components per Environment (persistent) for all Recipes services:

- Frontend
- Backend
- Receiver
- Batch

Infrastructure created:

- Application Insights
- Azure Key Vault
- Postgres Flexible Server
- Redis Cache Storage
- Service Bus

The infrastructure is written in code using Terraform and will be deployed via the Jenkins Infra pipelines using this repository as documented [here](https://github.com/hmcts/cnp-jenkins-library/blob/master/README.md).
