<##########################################################
# Autor: AMI
# Datum: 15.01.2021
#
# BESCHREIBUNG
#
# INFO
#
##########################################################>

### ConnectToDB() Method **************************************
Function ConnectToDB {
    [CmdletBinding()]
    Param(
        [String]$SqlServer,              
        [String]$SqlServerPort,
        [String]$Database,
        [String]$SqlUsername,
        [String]$SqlPass
    )

    if ($null -eq $Database) {
        $Database = "master"
        Write-Progress -Activity "Connect to DB $Database at $SqlServer"
        $Connection = New-Object System.Data.SqlClient.SqlConnection("Server=tcp:$SqlServer,$SqlServerPort;User ID=$SqlUsername;Password=$SqlPass;Trusted_Connection=False;Encrypt=True;Connection Timeout=30;")
    }
    else {
        Write-Progress -Activity "Connect to DB $Database at $SqlServer"
        $Connection = New-Object System.Data.SqlClient.SqlConnection("Server=tcp:$SqlServer,$SqlServerPort;Database=$Database;User ID=$SqlUsername;Password=$SqlPass;Trusted_Connection=False;Encrypt=True;Connection Timeout=30;")
    }
    # Open the SQL connection
    $Maximum = 5
    $Delay = 1000
    $count = 0
    do {
        $count++
        try {
            $Connection.Open()
            break        
        }
        catch {
            Write-Error $_.Exception.InnerException.Message -ErrorAction Continue
            Start-Sleep -Milliseconds $Delay
        }
    } while ($count -lt $Maximum)
    
    $Connection
}
### ConnectToDB() Method ______________________________________

### performDB() Method ****************************************
function performDB {
    Param(
        [System.Data.Common.DbConnection] $sqlConnection,
        [string] $sqlQuery
    )
    
    $command = new-object system.data.sqlclient.sqlcommand($sqlQuery, $sqlconnection)
    $sqlDataAdapter = New-Object System.Data.sqlclient.sqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet
    $sqlDataAdapter.Fill($dataSet) | Out-Null
    $dataSet.Tables
}
### performDB() Method ________________________________________