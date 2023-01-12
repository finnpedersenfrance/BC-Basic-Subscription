# AL-Go Template
## Per Tenant Extension Project
This template repository can be used for managing Per Tenant Extensions for Business Central.

Please consult https://github.com/microsoft/AL-Go/#readme for scenarios on usage



# Learning

https://github.com/dockersamples/101-tutorial

## Getting Started with Windows Containers
https://github.com/docker/labs/blob/master/windows/windows-containers/README.md


```
> docker version  
Client:
 Cloud integration: v1.0.29
 Version:           20.10.21
 API version:       1.41
 Go version:        go1.18.7
 Git commit:        baeda1f
 Built:             Tue Oct 25 18:08:16 2022
 OS/Arch:           windows/amd64
 Context:           default
 Experimental:      true

Server: Docker Desktop 4.15.0 (93002)
 Engine:
  Version:          20.10.21
  API version:      1.41 (minimum version 1.24)
  Go version:       go1.18.7
  Git commit:       3056208
  Built:            Tue Oct 25 18:03:04 2022
  OS/Arch:          windows/amd64
  Experimental:     true
```

# Install on Windows

https://docs.docker.com/desktop/install/windows-install/


# Azure VM with Windows Server 2019
http://aka.ms/getbc will create an Azure VM with Windows Server 2019 – and it just always works. This is an up-to-date Windows Server with Docker and no extra software or policies enforced, only Windows Defender.

# BcContainerHelper

Getting the latest BcContainerHelper

```
> Install-Module BcContainerHelper -force
```

https://github.com/microsoft/navcontainerhelper

# Troubleshooting

## Troubleshooting Business Central on Docker
https://freddysblog.com/2020/10/12/troubleshooting-business-central-on-docker/


```
> docker --version
Docker version 20.10.21, build baeda1f
```

## Is linux installed

```
>wsl -l -v
  NAME                   STATE           VERSION
* Ubuntu                 Running         2
  docker-desktop         Running         2
  docker-desktop-data    Running         2
```

## Is widows installed 
??

## Try a container

docker run -d -p 80:80 docker/getting-started

https://bobcares.com/blog/docker-engine-failed-to-start-windows-10-wsl2/


## Set Experimental to True

https://stackoverflow.com/questions/48066994/docker-no-matching-manifest-for-windows-amd64-in-the-manifest-list-entries

## If everything else fails

https://bala.one/docker-engine-failed-to-start-fix/



## WTF 

Better Docker Diagnostics messages

```
Cannot process diagnostics. Reason: Error invoking remote method 'desktop-go-backend': Error: {"message":"[2022-12-31T12:22:13.383745900Z][com.docker.diagnose.exe][I] set path configuration to OnHost\nGathering diagnostics for ID DEEE9B08-7873-483C-813D-F00459DA551A/20221231122213 into C:\\Users\\finnp\\AppData\\Local\\Temp\\DEEE9B08-7873-483C-813D-F00459DA551A\\20221231122213.zip.\nThis may take up to 15 minutes.\ntime=\"2022-12-31T13:22:13+01:00\" level=info msg=\"Triggering Linux sysrq and log flushes via a unix socket: \\\\\\\\.\\\\pipe\\\\dockerDiagnosticd\" type=unixsock\ntime=\"2022-12-31T13:22:13+01:00\" level=warning msg=\"/flush failed: Post \\\"http://unix/flush\\\": open \\\\\\\\.\\\\pipe\\\\dockerDiagnosticd: The system cannot find the file specified.\" type=unixsock\nunable to trigger dns-forwarder diagnostics: Post \"http://ipc/diagnostics\": open \\\\.\\pipe\\dockerDnsForwarder: The system cannot find the file specified.\ntime=\"2022-12-31T13:22:20+01:00\" level=info msg=\"Start gathering list of 132 elements (timeout=15m0s)\" type=list\ntime=\"2022-12-31T13:22:20+01:00\" level=info msg=\"Gathering DiagKit\" type=list\ntime=\"2022-12-31T13:22:20+01:00\" level=info msg=\"Gathering BackendGatherer\" type=list\ntime=\"2022-12-31T13:22:20+01:00\" level=info msg=\"Gathering ProxyAPIGatherer\" type=list\ntime=\"2022-12-31T13:22:20+01:00\" level=info msg=\"Gathering LifecycleServerGatherer\" type=list\ntime=\"2022-12-31T13:22:20+01:00\" level=info msg=\"Gathering DiagKit took 279.6µs\" type=list\ntime=\"2022-12-31T13:22:20+01:00\" level=info msg=\"Gathering system\" type=list\ntime=\"2022-12-31T13:22:20+01:00\" level=info msg=\"Executing: [powershell -NoProfile -Command &{ $(Get-WmiObject Win32_OperatingSystem) | ConvertTo-json -Depth 1 }]\"\ntime=\"2022-12-31T13:22:20+01:00\" level=info msg=\"Gathering ProxyAPIGatherer took 72.7037ms\" type=list\ntime=\"2022-12-31T13:22:20+01:00\" level=info msg=\"Gathering ProcessGatherer\" type=list\ntime=\"2022-12-31T13:22:20+01:00\" level=info msg=\"Gathering ProcessGatherer took 9.3304ms\" type=list\ntime=\"2022-12-31T13:22:20+01:00\" level=info msg=\"Gathering typeperf \\\\Process(*)\\\\% Processor Time (timeout 0s)-sc (timeout 0s)5 (timeout 0s)-y\" type=list\ntime=\"2022-12-31T13:22:20+01:00\" level=info msg=\"Executing: [typeperf \\\\Process(*)\\\\% Processor Time -sc 5 -y]\"\ntime=\"2022-12-31T13:22:20+01:00\" level=info msg=\"Gathering BackendGatherer took 177.0203ms\" type=list\ntime=\"2022-12-31T13:22:20+01:00\" level=info msg=\"Gathering tasklist /V\" type=list\ntime=\"2022-12-31T13:22:20+01:00\" level=info msg=\"Executing: [tasklist /V]\"\ntime=\"2022-12-31T13:22:21+01:00\" level=info msg=\"Executing: [powershell -NoProfile -Command &{ $(Get-WmiObject Win32_ComputerSystem) | ConvertTo-json -Depth 1 }]\"\ntime=\"2022-12-31T13:22:22+01:00\" level=info msg=\"Executing: [powershell -NoProfile -Command &{ $(Get-WmiObject Win32_Processor) | ConvertTo-json -Depth 1 }]\"\ntime=\"2022-12-31T13:22:23+01:00\" level=info msg=\"Gathering tasklist /V took 2.5400879s\" type=list\ntime=\"2022-12-31T13:22:23+01:00\" level=info msg=\"Gathering Get-Process | Select-Object Handles,Name,NPM,PM,SI,VM,WS | ConvertTo-Json -Depth 1 (timeout 1m30s)\" type=list\ntime=\"2022-12-31T13:22:23+01:00\" level=info msg=\"Executing: [powershell -NoProfile -Command &{ Get-Process | Select-Object Handles,Name,NPM,PM,SI,VM,WS | ConvertTo-Json -Depth 1 }]\"\n2022/12/31 13:22:23 exit status 0xffffffff\n: exit status 1"}
```

# Deployment strategies

https://freddysblog.com/2022/05/06/deployment-strategies-and-al-go-for-github/

