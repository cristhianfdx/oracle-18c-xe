docker stop $(docker ps -a -q)
docker rm oracledb

sudo rm -rf ~/docker-services

unalias sqlplus
unalias oraclestart
unalias oraclestop
