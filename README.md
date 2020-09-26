# Docker build for Oracle Database 18c Express Edition (XE)

## Prerequisites

- Install [Docker](https://docs.docker.com/engine/install/) (Windows - Install Docker Desktop and activate Linux containers)
- Install [Docker compose](https://docs.docker.com/compose/install/) (Only Linux)
- For Windows:  
  - Use **Windows Powershell**
  - Run as administrator `Set-ExecutionPolicy -ExecutionPolicy AllSigned`

## Install container

- Clone repository: `git clone https://github.com/cristhianfdx/oracle-18c-xe.git`
- `cd oracle-18c-xe`
- Execute:
  - Linux: `./oracle.sh`
  - Windows `./oracle.ps1` (**Use Windows Powershell**) then restart system

### Available commands

- Run program: `oracle`
