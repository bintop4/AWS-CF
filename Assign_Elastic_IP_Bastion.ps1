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
 
 
#setup
$AWSRegion = (New-Object System.Net.WebClient).DownloadString("http://169.254.169.254/latest/meta-data/placement/availability-zone")
$AWSRegion = $AWSRegion.Substring(0,$AWSRegion.Length-1) 
Set-DefaultAWSRegion $AWSRegion
 
#no need to change
$instanceid = (New-Object System.Net.WebClient).DownloadString("http://169.254.169.254/latest/meta-data/instance-id")
$pubip = '52.70.173.251'
 
Register-Ec2Address -instanceId $instanceid -PublicIp $pubip