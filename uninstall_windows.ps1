docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

[System.Environment]::SetEnvironmentVariable('sqlplus', $null, [System.EnvironmentVariableTarget]::User)