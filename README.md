Solutions to the homework for M6: Templating Tools & Package Management

<!-- <br/>
<div style="margin: 50px">
<img style="margin: auto" src="https://github.com/dmitkov28/kubernetes/blob/basic-cluster/setup.webp?raw=true">
</div>
<br/> -->

## Task 1
**parametrized.yml** parametrizes the nodeport and replicas count of the original manifest using the following scheme:  
```
%valueName%
```
<br/>
These can then be configured like so:

```
sed 's/%replicas%/3/ ; s/%nodeport%/30002/' parametrized.yaml > v2.yml
```
<br/>
And applied with:

```
kubectl apply -f v2.yml
```
  
<br/>
<br/>

To spin it up, run:

```
vagrant up
```
<br/>

## Task 2
Install Kustomize with:

```
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash

sudo mv kustomize /usr/local/bin/
```

The solution should look like this:

```
├── base
│   ├── homework.yaml
│   └── kustomization.yaml
├── homework.yaml
└── overlays
	├── production
	│   ├── kustomization.yaml
	│   ├── replicas.yaml
	│   └── service_port.yaml
	└── test
    	├── kustomization.yaml
    	├── replicas.yaml
    	└── service_port.yaml
```

Apply with:

```
kubectl apply -k task2/overlays/production
kubectl apply -k task2/overlays/test
```

<br/>

## Task 3

Install Helm with:

```
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```
<br/>
To install the chart with default values:

1. Delete **values.yaml** or uncomment everything inside of it.
2. Run:

    ```
    helm install hw-chart-defaults nginx-chart
    ```

To install the chart with custom values:

1. Add the corresponding values in **values.yaml**
2. Run:
    ```
    helm install hw-chart-custom-values nginx-chart
    ```
