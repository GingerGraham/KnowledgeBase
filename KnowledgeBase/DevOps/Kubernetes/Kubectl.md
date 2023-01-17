# Kubectl

`kubectl` is a command line tool for controlling Kubernetes clusters.

When configured correctly, `kubectl` can be used to perform all of the same operations as the Kubernetes dashboard across local and remote clusters, including those hosted on cloud services such as AWS EKS and Azure AKS.

For more information on `kubectl` see the [official documentation](https://kubernetes.io/docs/reference/kubectl/overview/).

## Detailed Output

Many commands support the `-o wide` option to provide additional information in the output.  For example, the following command will list all pods in the current namespace with additional information:

```bash
kubectl get pods -o wide
```

## Get Commands

The `get` command is used to retrieve information about resources in the cluster.

### Get Pods

The following command will list all pods in the current namespace:

```bash
kubectl get pods
```

For more on namespaces see the [Namespaces](#working-with-namespaces) section below.

### Get Services

The following command will list all services in the current namespace:

```bash
kubectl get services
```

The same basic format can be used all for entities in the cluster/namespace such as ingress controllers, deployments, and so on.

### Get All

The following command will list all entities in the current namespace:

```bash
kubectl get all
```

## Describe Commands

The `describe` command is used to retrieve detailed information about a specific resource in the cluster.

### Describe Pods

The following command will provide detailed information about a specific pod:

```bash
kubectl describe pod <pod-name>
```

Where `<pod-name>` is the name of the pod to retrieve information about.

### Describe Services

The following command will provide detailed information about a specific service:

```bash
kubectl describe service <service-name>
```

Where `<service-name>` is the name of the service to retrieve information about.

As with the `get` command, the same basic format can be used all for entities in the cluster/namespace such as ingress controllers, deployments, and so on.

## Deployments

Deployments are used to manage the lifecycle of pods.  They are used to create, update, and delete pods.  Deployments are defined in a YAML file and can be created using the `kubectl` command line tool.

Deployments are a subject in their own right and will be covered in more detail in a separate section.

### Rolling Restarts

When a deployment is updated, the pods are updated one at a time.  This is known as a rolling restart.  The following command can be used to view the status of a rolling restart:

```bash
kubectl rollout status deployment <deployment-name>
```

Where `<deployment-name>` is the name of the deployment to check.

#### Triggering a Rolling Restart

To trigger a rolling restart, the deployment can be updated.  The following command can be used to update a deployment:

```bash
kubectl rollout restart deployment <deployment-name>
```

Where `<deployment-name>` is the name of the deployment to update.

This can also be used to restart a deployment that has failed without rolling back to a previous version or updating the deployment definition.

### Rolling Back

If a deployment fails, it can be rolled back to a previous version.  The following command can be used to roll back a deployment:

```bash
kubectl rollout undo deployment <deployment-name>
```

Where `<deployment-name>` is the name of the deployment to roll back.

### Scaling Deployments

Deployments can be scaled up or down using the following command:

```bash
kubectl scale deployment <deployment-name> --replicas=<number-of-replicas>
```

Where `<deployment-name>` is the name of the deployment to scale and `<number-of-replicas>` is the number of replicas to scale to.

## Restarting Pods

There are many ways to restart a pod if it is not responding.  A individual pod can be deleted using the following command:

```bash
kubectl delete pod <pod-name>
```

Where `<pod-name>` is the name of the pod to delete.

Or a deployment can be restarted using [rolling restarts](#triggering-a-rolling-restart).

Or a deployment could be [scaled](#scaling-deployments) down to zero and then back up to the desired number of replicas.

Pods that are part of a stateful set can also be restarted in a similar way targeting the stateful set rather than the deployment.

## Force Deleting Pods

On occasion a pod may become stuck or otherwise non-responsive and will not respond to a normal delete command.  In this case the pod can be force deleted using the following command:

```bash
kubectl delete pod <pod-name> --grace-period=0 --force
```

Where `<pod-name>` is the name of the pod to delete.

## Working with Clusters and Contexts

A context is a defined set of parameters that `kubectl` uses to connect to a Kubernetes cluster.  Contexts are defined in a `~/.kube/config` file.  This file is created automatically when a cluster is created and can be edited manually to add additional contexts.  Typically a context will contain the following parameters:

- `cluster` - the name of the cluster
- `user` - the name of the user including connection credentials such as a username and password, certificate, or token
- `namespace` - the default namespace to use when connecting to the cluster
- `server` - the URL of the Kubernetes API server

While many choose to install [Docker Desktop](https://www.docker.com/products/docker-desktop/) and use the integrated Kubernetes environment to change context using a UI it is possible, and for some easier, to use the command line.  A range of simple commands can be used to view the current context, change context, and list available contexts.

For more information on contexts see the [official documentation](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/).

### Viewing the Current Context

To view the current context use the following command:

```bash
kubectl config current-context
```

#### Example

```bash
kubectl config current-context
docker-desktop
```

### Changing Context

To change context use the following command:

```bash
kubectl config use-context <context-name>
```

Where `<context-name>` is the name of the context to change to.

#### Example

```bash
kubectl config use-context docker-desktop
docker-desktop  # output from kubectl command showing that the current context has changed
```

### Listing Contexts

To list all available contexts use the following command:

```bash
kubectl config get-contexts
```

#### Example

```bash
kubectl config get-contexts
CURRENT   NAME             CLUSTER          AUTHINFO         NAMESPACE
*         docker-desktop   docker-desktop   docker-desktop
```

**Note:** The `*` indicates the currently active context.

## Renaming Contexts

When working with multiple contexts it can be useful to rename them to make it easier to identify them.  Particularly when working with AWS EKS the default context name is the name of the cluster which can be difficult to identify when working with multiple clusters as it constitutes the entity ARN value assigned by AWS.

Contexts can be renamed using the `kubectl config rename-context` command or by editing the `~/.kube/config` file directly.

### Renaming Contexts Using the Command Line

To rename a context use the following command:

```bash
kubectl config rename-context <old-context-name> <new-context-name>
```

Where `<old-context-name>` is the name of the context to rename and `<new-context-name>` is the new name to give the context.

#### Example

```bash
kubectl config rename-context docker-desktop docker
Context "docker-desktop" renamed to "docker".
```

### Renaming Contexts by Editing the Config File

To rename a context edit the `~/.kube/config` file and change the `name` property of the context to the new name.

**Note:** Depending on the configuration the `name` value may appear multiple times, for example it the context is the currently selected context and when a `user` is defined and associated with the context.

1. Open the `~/.kube/config` file in a text editor.
2. You will see a section similar to the following:

```yaml
apiVersion: v1
clusters:
- cluster:
 certificate-authority-data: <data>
 server: <server_address>
 name: excessively-long-and-silly-name # name you want to replace
contexts:
- context:
 cluster: excessively-long-and-silly-name
 user: excessively-long-and-silly-name
 name: excessively-long-and-silly-name
current-context: vocera-nonprod-k8s
kind: Config
preferences: {}
users:
- name: excessively-long-and-silly-name
 user:
 exec: <some_data> # may be multiline
 command: aws
 env:
 - name: AWS_PROFILE
 value: aws-prod # which AWS profile is needed if using multiple, named AWS CLI profiles
 interactiveMode: IfAvailable
 provideClusterInfo: false
```

3. Change the `name` value to the new name you want to use.
   1. In the above example the `name` value is `excessively-long-and-silly-name` and could be changed to something more useful such as `production` or `non-prod`.
   2. **Recommendation:** use a tool such as find and replace to find all instances of the old name and replace them with the new name.
4. Now when you run `kubectl config get-contexts` you will see the new name.

## Working with Namespaces

Namespaces are used to group resources into logical groups.  For example, a namespace could be used to group resources for a specific application or environment.  Namespaces are used to isolate resources from each other and to control access to resources.  For example, a namespace could be used to restrict access to a specific application or environment.  Namespaces can also be used with resource quotas to limit the amount of resources that can be used by a namespace.

For more information see the [Kubernetes Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) documentation.

### Viewing the Current Namespace

To view the current namespace use the following command:

```bash
kubectl config view --minify --output 'jsonpath={..namespace}'
```

#### Example

```bash
kubectl config view --minify --output 'jsonpath={..namespace}'
default
```

### Listing Namespaces

To list all available namespaces use the following command:

```bash
kubectl get namespaces
```

### Changing Namespace

To change namespace use the following command:

```bash
kubectl config set-context --current --namespace=<namespace>
```

Where `<namespace>` is the name of the namespace to change to.

#### Example

```bash
kubectl config set-context --current --namespace=production
Context "docker-desktop" modified.  # output from kubectl command showing that the current namespace has changed
```

### Definining a Namespace in Another `kubectl` Command

To define a namespace in another `kubectl` command use the `-n` or `--namespace` option.

#### Example

```bash
kubectl get pods -n production
```

### Creating a Namespace

To create a namespace use the following command:

```bash
kubectl create namespace <namespace>
```

Where `<namespace>` is the name of the namespace to create.

#### Example

```bash
kubectl create namespace production
namespace/production created
```

### Deleting a Namespace

To delete a namespace use the following command:

```bash
kubectl delete namespace <namespace>
```

Where `<namespace>` is the name of the namespace to delete.

#### Example

```bash
kubectl delete namespace production
namespace "production" deleted
```

## Working with Nodes

Nodes are the machines that run the Kubernetes cluster.  Nodes can be physical or virtual machines.  Nodes are managed by the Kubernetes master and are used to run the containers that make up the applications.

For more information see the [Kubernetes Nodes](https://kubernetes.io/docs/concepts/architecture/nodes/) documentation.

### Listing Nodes

To list all available nodes use the following command:

```bash
kubectl get nodes
```

#### Example

```bash
kubectl get nodes
NAME             STATUS   ROLES           AGE    VERSION
docker-desktop   Ready    control-plane   113d   v1.25.0
```

### Viewing Node Details

To view details about a node use the following command:

```bash
kubectl describe node <node>
```

Where `<node>` is the name of the node to view.

#### Example

```bash
kubectl describe node docker-desktop
```

The result of the command is a detailed overview of the node configuration and status.

### Listing all Pods on a Node

When working with larger deployments it can be useful to understand all the pods on a specific node.  To list all pods on a node use the following command:

```bash
kubectl get pods --all-namespaces --field-selector spec.nodeName=<node>
```

Where `<node>` is the name of the node to list pods for.

The `--all-namespaces` option is used to list pods from all namespaces.  This allows you to see all pods on a node regardless of the namespace they are in.

Optionally the `-o wide` option can be used to include additional information such as the node the pod is running on.

## Logging

### Viewing Logs

To view the logs for a pod use the following command:

```bash
kubectl logs <pod> -n <namespace>
```

Where `<pod>` is the name of the pod to view logs for and `<namespace>` is the namespace the pod is in.

#### Example

```bash
kubectl logs my-pod -n my-namespace
```

### Viewing Logs for a Specific Container

To view the logs for a specific container in a pod use the following command:

```bash
kubectl logs <pod> -c <container> -n <namespace>
```

Where `<pod>` is the name of the pod to view logs for, `<container>` is the name of the container to view logs for and `<namespace>` is the namespace the pod is in.

#### Example

```bash
kubectl logs my-pod -c my-container -n my-namespace
```

### Viewing Logs for a Previous Instance of a Pod

To view the logs for a previous instance of a pod use the following command:

```bash
kubectl logs <pod> -p -n <namespace>
```

Where `<pod>` is the name of the pod to view logs for and `<namespace>` is the namespace the pod is in.

### Following Logs

Logs can be followed, or tailed in a simialr way to the `tail -f` command.  To follow logs use the following command:

```bash
kubectl logs <pod> -f -n <namespace>
```

Where `<pod>` is the name of the pod to view logs for and `<namespace>` is the namespace the pod is in.

Alternatively the `--follow` option can be used instead of the `-f` option.
