function Install-DB {
    if (Test-Path C:\docker-services -PathType Any) {
        Write-Output "Oracle Database is already install."
        return
    }

    New-Item -Path 'C:\docker-services\oracle\18c-xe' -ItemType Directory
    Invoke-WebRequest -Uri https://github.com/cristhianfdx/resources/raw/master/oracle/sqlcl.zip -OutFile sqlcl.zip
    Expand-Archive -LiteralPath $pwd\sqlcl.zip -DestinationPath C:\docker-services\oracle\sqlcl
    Remove-Item sqlcl.zip
    Copy-Item * -Path $pwd -Recurse -Destination 'C:\docker-services\oracle'

    [System.Environment]::SetEnvironmentVariable('oracle', 'C:\docker-services\oracle\install_windows.ps1', [System.EnvironmentVariableTarget]::User)

    $oracle_pwd = Read-Host -Prompt "Please, insert your database passwords [SYS, SYSTEM, PDB_ADMIN]:"
    touch .env

    docker-compose --env-file .env up -d --build
    docker-compose logs -f

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

    $option = Read-Host -Prompt "Select option [1-4]:"

    switch ($option) {
        "1" { Install-DB; break }
        "2" {  }
        "3" {  }
        "4" {  }
        "5" {  }
        "6" {  }
         *  {  }
        Default {}
    }
}



# $InstallerFile = 'oracle-database-xe-18c-1.0-1.x86_64.rpm'

# if (-not (Test-Path C:\docker-services -PathType Any)) {
#     New-Item -Path 'C:\docker-services\oracle\18c-xe' -ItemType Directory
#     Invoke-WebRequest -Uri https://github.com/cristhianfdx/resources/raw/master/oracle/sqlcl.zip -OutFile sqlcl.zip
#     Expand-Archive -LiteralPath $pwd\sqlcl.zip -DestinationPath C:\docker-services\oracle\sqlcl
#     Remove-Item sqlcl.zip

#     [System.Environment]::SetEnvironmentVariable('sqlplus', 'C:\docker-services\oracle\sqlcl\sqlcl\bin\sql.exe', [System.EnvironmentVariableTarget]::User)

# }

# if (-not (Test-Path $pwd\18c-xe\files\$InstallerFile)) {
#     Move-Item $HOME\Downloads\$InstallerFile $pwd\18c-xe\files\
# }

# docker-compose up -d --build

# docker-compose logs -f


