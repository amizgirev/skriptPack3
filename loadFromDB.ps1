<##########################################################
# Autor: AMI
# Datum: 15.01.2021
#
# BESCHREIBUNG
#
# INFO
#
##########################################################>

Param(
    ## SHARE DRIVE ##
    #[Parameter(Mandatory)]
    [String] $SqlServer = "dagu.database.windows.net",
    [string] $SqlServerPort = "1433",
    [string] $Database = "itwosc_dev",
    [string] $SqlUsername = "dagu",
    [string] $SqlPass = "Da!3nGut@2O12"
)

$modulePath = $PSScriptRoot
Import-Module -Name "$modulePath\functions.psm1"

$sqlQuery = "SELECT Service_Name as Dienstname, File_Name as Dateiname, File_Type, Node, Attribute, Value `
            FROM [itwosc_dsweb].[SERVICES_CONFIGS] `
            WHERE File_Type = 'tomcat'"
$conn = ConnectToDB -SqlServer $SqlServer `
                    -SqlServerPort $SqlServerPort `
                    -Database $Database `
                    -SqlUsername $SqlUsername `
                    -SqlPass $SqlPass

$conn.ConnectionString
# Invoke-Sqlcmd -ConnectionString $conn.ConnectionString -Query $sqlQuery

$res = performDB -sqlConnection $conn -sqlQuery $sqlQuery
# $res.Select().File_Name
$res



# $conn.Close()

Get-Module "$modulePath\functions.psm1" -ListAvailable | Remove-Module