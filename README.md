# Docker build for Oracle Database 18c Express Edition (XE)

## Prerequisites

- [Download](https://drive.google.com/file/d/1P4tGL1IJq_NPtlZs8KvX_nxCbWeYkkvI/view?usp=sharing) the RPM from Oracle Technology Network and     save to folder. We will assume it is in `~/Downloads/oracle-database-xe-18c-1.0-1.x86_64.rpm`.
- Install [Docker](https://docs.docker.com/engine/install/) and [Docker compose](https://docs.docker.com/compose/install/)

## Container settings

- To change the password, modify the `ORACLE_PASSWORD` environment variable in the `docker-compose.yaml` file.

## Install container

- Execute `./install.sh`

### Available commands

- Run container: `oraclestart`
- Stop container: `oraclestop`
- Run sqlplus: `sqlplus`
- List the tablespaces created in the `/home/oracle` path of the container: `oracletablespaces`

### SQL

-- Connect to CDB
`sqlplus sys/7tXvhyoRXEtZnDGF@localhost:1521/XE as sysdba`


-- Connect to default PDB
`sqlplus sys/7tXvhyoRXEtZnDGF@localhost:1521/XEPDB1 as sysdba`

### APEX Install

An example to install APEX into the default container is available [here](docs/apex-install.md).

### SSH into Container

In some cases you may need to login to the server to modify or test something on the file system.

```bash
docker exec -it oracledb bash -c "source /home/oracle/.bashrc; bash"

# Once connected to run sqlplus:
$ORACLE_HOME/bin/sqlplus sys/7tXvhyoRXEtZnDGF@localhost/XE as sysdba
$ORACLE_HOME/bin/sqlplus sys/7tXvhyoRXEtZnDGF@localhost/XEPDB1 as sysdba


# Listener start/stop
$ORACLE_HOME/bin/lsnrctl stop
$ORACLE_HOME/bin/lsnrctl start
```

### Oracle Enterprise Manager

_Note: Flash is required_</br>

https://localhost:35518/em


