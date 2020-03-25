Set-ExecutionPolicy Unrestricted -force
 
#Get AWS Tools
If(-not(Test-Path -path "C:\Program Files (x86)\AWS Tools\PowerShell\AWSPowerShell.psd1"))
  {
	$getUrl = "http://sdk-for-net.amazonwebservices.com/latest/AWSToolsAndSDKForNet.msi"
	$dest='c:\AWSTools.msi'
	$t=(New-Object System.Net.WebClient).DownloadFile($getUrl,$dest)
	Start-Process -FilePath "msiexec.exe" -ArgumentList '/i $dest /q' -Wait -NoNewWindow
	del $dest
  }
 
 
$localIP =  Invoke-RestMethod -Uri http://169.254.169.254/latest/meta-data/local-ipv4
$localIP
$instanceID =  Invoke-RestMethod -Uri http://169.254.169.254/latest/meta-data/instance-id
$Octet = $localIP -split ("\.")
If ($Octet[2] -eq '3')
	{Add-EC2NetworkInterface -NetworkInterfaceId eni-3bbadf96 -InstanceId $instanceID -DeviceIndex 1 -Force}
Else
	{Add-EC2NetworkInterface -NetworkInterfaceId eni-94231f15 -InstanceId $instanceID -DeviceIndex 1 -Force}