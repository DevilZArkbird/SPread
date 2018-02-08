

$port = 445;

$net = Get-WmiObject win32_networkadapterconfiguration | ForEach-Object { echo $_.IPAddress };
[String]$network=$net[0];
#$network;
$range = 1..254;

    # Extract an IP address from a string and return it.  Return $Null if no valid address found.
    # (If the string contains more than one valid address only the first one will be returned)
    Function ExtractValidIPAddress($String){
        $IPregex=‘(?<Address>((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){2}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))’
        If ($String -Match $IPregex) {$Matches.Address}
    }
    
$test=ExtractValidIPAddress($network);
$test;
foreach ($r in $range)
{
   $ip = “{0}.{1}” -F $test,$r
    if(Test-Connection -BufferSize 32 -Count 1 -Quiet -ComputerName $ip)
    {
 	  
       $socket = new-object System.Net.Sockets.TcpClient($ip, $port)
 	   if($socket.Connected)
            {
    	   #insert rule ethernalblue
    	     $socket.Close()
            }
    }
  
 }
 