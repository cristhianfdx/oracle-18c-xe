# !/bin/bash
# Program to install Oracle Database services with docker
# Author: Cristhian Forero

install () {
    if [ -d ~/docker-services ]; then
        echo "Oracle Database is already install."
        return
    fi
    mkdir -p ~/docker-services/oracle/18c
    sudo cp -r * ~/docker-services/oracle
    sudo apt install wget unzip -y
    wget https://github.com/cristhianfdx/resources/raw/master/oracle/sqlcl.zip -O sqlcl.zip
    unzip sqlcl.zip
    mv sqlcl ~/docker-services/oracle/
    rm -rf sqlcl.zip
    cat aliases >> ~/.bashrc
    cat aliases >> ~/.zshrc

    read -p "Please, insert your database passwords [SYS, SYSTEM, PDB_ADMIN]: " oraclepwd
    touch .env
    echo "ORACLE_PASSWORD=$oraclepwd" >> .env
    docker-compose --env-file .env up -d --build
    docker-compose logs -f
}

uninstall () {
    docker stop oracledb
    docker rm oracledb
    rm .env
    sudo rm -rf ~/docker-services
    unalias oracle
    echo "Uninstalling..."
    sleep 2
}

runSqlplus () {
    docker exec -it oracledb sh -c "/opt/oracle/product/18c/dbhomeXE/bin/sqlplus"
    break
}

while :
do
    clear

    echo "----------------------------"
    echo "| ORACLE DATABASE 18C XE   |"
    echo "----------------------------"
    echo "|        MENU              |"
    echo "----------------------------"
    echo "1. Install Database"
    echo "2. Uninstall Database"
    echo "3. SQLPLUS"
    echo "4. Start Database"
    echo "5. Stop Database"
    echo "6. Exit"

    echo "\nSelect option [1-4]: " && read option

    case $option in
        1)
            install
            sleep 3
            ;;
        2)
            uninstall
            ;;
        3)
            runSqlplus
            ;;
        4)
            docker start oracledb
            sleep 1
            echo "Oracle service started..."
            sleep 1
            ;;
        5)
            docker stop oracledb
            sleep 1
            echo "Oracle service stopped..."
            sleep 1
            ;;
        6)
            echo "\nExited..."
            sleep 1
            exit 0
            ;;
        *)
            echo "\nInvalid option"
            echo "\nTry again.."
            sleep 1
            ;;
    esac
done
