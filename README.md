## Task 1
<ol type="a">
 <li>ConfigMap</li>
 <br/>

 ```
 kubectl create configmap hwcm \
--from-literal=k8sver="$(kubectl version --output=yaml | awk '/^  gitVersion:/ {print $2; exit}')" \
 --from-literal=k8sos="$(awk -F= '/PRETTY_NAME/ {print $2}' /etc/os-release | tr -d '"')" \
 --from-file=main.conf \
 --from-file=port.conf \
 --dry-run=client -o yaml > configmap.yaml
 ```

 <li>Secret</li>
<br/>
Create the files with:
<br/>

```
openssl genrsa -out main.key 4096

openssl req -new -x509 -key main.key -out main.crt -days 365 -subj /CN=www.hw.lab
```
<br/>

Create the secret.yml file:
<br/>

```
 kubectl create secret generic hwsec \
--from-file=main.key=main.key \
--from-file=main.crt=main.crt \
--from-file=port=port.conf \
--dry-run=client -o yaml > secret.yml
```

Apply:
<br/>
```
kubectl apply -f secret.yml
```

 <li>Pod with mounted volumes & env variables <i>(see <b>pod.yml</b>)</i></li>
 <br/>
 As this setup is using HostPath to mount the data, the following files & directories need to be present on each of the nodes:
 
 ```
 .
├── config
│   └── main.conf
└── secret
	├── main.crt
	└── main.key
 ```

 <br/>

 ```
 kubectl apply -f pod.yml
 ```
</ol>

## Task 2
<br/>

![Image Alt Text](/task_2/diagram.png)

<br/>

**An nfs server is used for the volumes (See Vagrantfile)*

<br/>

To spin up the cluster & nfs server, run:
<br/>


```
vagrant up
```
<br/>

To apply the manifests, run: 
<br/>
```
kubectl apply -f /vagrant/manifests
```

Done ✅




