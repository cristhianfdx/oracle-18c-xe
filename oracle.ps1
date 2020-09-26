function Install-DB {
    if (Test-Path C:\docker-services -PathType Any) {
        Write-Output "Oracle Database is already install."
        return
    }

    New-Item -Path 'C:\docker-services\oracle\18c-xe' -ItemType Directory
    Invoke-WebRequest -Uri https://gitlab.com/cristhianfdx/resources/-/raw/master/oracle-database-xe-18c-1.0-1.x86_64.rpm -OutFile oracle-database-xe-18c-1.0-1.x86_64.rpm
    Copy-Item -Path "$pwd\oracle-database-xe-18c-1.0-1.x86_64.rpm" -Recurse -Destination "$pwd\18c\files"

    docker build -t cristhianfdx/oracle18c-xe $pwd\18c

    Remove-Item $pwd\18c\files\oracle-database-xe-18c-1.0-1.x86_64.rpm

    [System]::SetEnvironmentVariable("oracle", "C:\docker-services\oracle\oracle.ps1", [System.EnvironmentVariableTarget]::User)

    $OraclePwd = Read-Host -Prompt "Please, insert your database passwords [SYS, SYSTEM, PDB_ADMIN]:"
    New-Item $pwd\.env
    Set-Content $pwd\.env "ORACLE_PASSWORD=$OraclePwd"

    Copy-Item -Path "$pwd\*" -Recurse -Destination "C:\docker-services\oracle"

    docker-compose --env-file .env up -d --build
    docker-compose logs -f

}

function Uninstall {
    docker stop oracledb
    docker rm oracledb
    Remove-Item 'C:\docker-services' -Recurse
    Write-Output "Uninstalling..."
    Start-Sleep 2
}

function RunSqlplus {
    docker exec -it oracledb sh -c "/opt/oracle/product/18c/dbhomeXE/bin/sqlplus"
    break
}

while ($True) {
    Write-Output "----------------------------"
    Write-Output "| ORACLE DATABASE 18C XE   |"
    Write-Output "----------------------------"
    Write-Output "|        MENU              |"
    Write-Output "----------------------------"
    Write-Output "1. Install Database"
    Write-Output "2. Uninstall Database"
    Write-Output "3. SQLPLUS"
    Write-Output "4. Start Database"
    Write-Output "5. Stop Database"
    Write-Output "6. Exit"

    Write-Output ""
    $option = Read-Host -Prompt "Select option [1-4]:"
    Write-Output ""

    switch ($option) {
        "1" { Install-DB; break }
        "2" { Uninstall; break }
        "3" { RunSqlplus; break }
        "4" { docker start oracledb; Write-Output "Oracle service started..."; Start-Sleep 1; break }
        "5" { docker stop oracledb; Write-Output "Oracle service stopped..."; Start-Sleep 1; break }
        "6" { exit 0 }
        Default {Write-Output "Invalid option"; Write-Output "Try again.."}
    }
}