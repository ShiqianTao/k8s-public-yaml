## Note
A draft for testing.

## Enable
Please submit a request to Microsoft.

## AKSWindowsExtension

Create an AKS cluster with Windows agent pool. We can see `AKSWindowsExtension` in the Windows agent pool backend VMSS.

![image](https://github.com/ShiqianTao/k8s-public-yaml/assets/62196586/6b67f084-567f-42b8-9f77-867e35d61c5d)


## Windows Exporter

With `AKSWindowsExtension` all Windows nodes have installed `windows-exporter`.

- Apply a Windows PowerShell pod to a Windows node.

```
kubectl apply -f https://raw.githubusercontent.com/ShiqianTao/k8s-public-yaml/main/windows-exporter/windows-powershell-hpc-pod.yaml
```

- Exec the pod the access the node resource.

```
kubectl exec windows-powershell-hpc-pod -it -- powershell
```

- Read `windows-exporter` metrics. (Port is `19182`)

```
PS C:\> curl.exe http://localhost:19182/health 

{"status":"ok"}

PS C:\> curl.exe http://localhost:19182/version

{"version":"v0.25.1","revision":"f70fa009de541dc99ed210aa7e67c9550133ef02","branch":"HEAD","buildUser":"cloudtest@781d70d7c000002","buildDate":"20240223-08:06:57","goVersion":"go1.21.3"}

PS C:\> curl.exe http://localhost:19182/metrics

windows_service_status{name="windows-exporter", status="ok"} 1
windows_service_status{name="windows-exporter", status="pred fail"} 0
windows_service_status{name="windows-exporter", status="service"} 0
windows_service_status{name="windows-exporter", status="starting"} 0
```

- Use node IP or other http commands

```
$NodeIP = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias (Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}).InterfaceAlias).IPAddress

curl.exe http://${NodeIP}:19182/health

Invoke-WebRequest -UseBasicParsing -Uri http://${NodeIP}:19182/version

$response = Invoke-WebRequest -UseBasicParsing -Uri http://${NodeIP}:19182/metrics
$response.RawContentLength
```
