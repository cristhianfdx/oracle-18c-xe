docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

sudo rm -rf ~/docker-services

unalias sqlplus
unalias oraclestart
unalias oraclestop
