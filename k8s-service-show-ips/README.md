A k8s service that will show the IP of 
- Pod who handles this request
- Previous-hop

Client uses the below code to request
```
for($i=1; $i -lt 100; $i = $i+1){curl.exe --silent --no-keepalive http://<service-ip>/; echo \"\"}
```

It will get the result like "`<Pod who handles this request>-IP`:`<Previous-hop>-IP`\\\\"

![image](https://github.com/ShiqianTao/k8s-public-yaml/assets/62196586/bcb150ff-726f-490d-bc51-74494be4b425)
