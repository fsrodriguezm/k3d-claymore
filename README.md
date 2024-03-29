# k3d-claymore
```                                                                                                          
                         ,,               ,,                                                              
`7MM                   `7MM             `7MM                                                              
  MM                     MM               MM                                                              
  MM  ,MP'pd""b.    ,M""bMM       ,p6"bo  MM   ,6"Yb.`7M'   `MF'`7MMpMMMb.pMMMb.  ,pW"Wq.`7Mb,od8 .gP"Ya  
  MM ;Y  (O)  `8b ,AP    MM      6M'  OO  MM  8)   MM  VA   ,V    MM    MM    MM 6W'   `Wb MM' "',M'   Yb 
  MM;Mm       ,89 8MI    MM      8M       MM   ,pm9MM   VA ,V     MM    MM    MM 8M     M8 MM    8M"""""" 
  MM `Mb.   ""Yb. `Mb    MM      YM.    , MM  8M   MM    VVV      MM    MM    MM YA.   ,A9 MM    YM.    , 
.JMML. YA.     88  `Wbmd"MML.     YMbmd'.JMML.`Moo9^Yo.  ,V     .JMML  JMML  JMML.`Ybmd9'.JMML.   `Mbmmd' 
         (O)  .M'                                       ,V                                                
          bmmmd'                                     OOb"                                                 
```
This repo is for creating a local k3d cluster with two nodes bundled with an installation of rancher using Helm.

## Requirements
* docker desktop v4.21.0
* terraform v1.0.11
* k3d v5.6.0
* kubectl v1.28.2
* helm v3.14.0

## Get Started
1. Deploy a K3D cluster
```
make cluster-init
```
2. Deploy Rancher Helm Chart </br>
It takes about 3 minutes for the helm chart to deploy.
```
make rancher-init
```
You could also run make, which will initialize the cluster and rancher deployment with one command.
```
make
```
3. Access Rancher </br>
https://localhost:8901/dashboard/

4. Use the K3D cli to stop or start the cluster
```
k3d cluster start claymore
```
```
k3d cluster stop claymore
```
5. Destroy the cluster if needed
```
make destroy
```

## Reference

https://medium.com/47billion/playing-with-kubernetes-using-k3d-and-rancher-78126d341d23
https://docs.docker.com/desktop/release-notes/#4210
