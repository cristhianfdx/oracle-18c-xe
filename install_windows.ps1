Write-Output '-------------------------------'
Write-Output 'Oracle 18c-XE DATABASE INSTALL'
Write-Output '-------------------------------'

$InstallerFile = 'oracle-database-xe-18c-1.0-1.x86_64.rpm'

if (-not (Test-Path C:\docker-services -PathType Any)) {
    New-Item -Path 'C:\docker-services\oracle\18c-xe' -ItemType Directory
    Invoke-WebRequest -Uri https://github.com/cristhianfdx/resources/raw/master/oracle/sqlcl.zip -OutFile sqlcl.zip
    Expand-Archive -LiteralPath $pwd\sqlcl.zip -DestinationPath C:\docker-services\oracle\sqlcl
    Remove-Item sqlcl.zip

    [System.Environment]::SetEnvironmentVariable('sqlplus', 'C:\docker-services\oracle\sqlcl\sqlcl\bin\sql.exe', [System.EnvironmentVariableTarget]::User)
    
}

if (-not (Test-Path $pwd\18c-xe\files\$InstallerFile)) {
    Move-Item $HOME\Downloads\$InstallerFile $pwd\18c-xe\files\
}

docker-compose up -d --build

docker-compose logs -f


