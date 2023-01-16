# Kubernetes Taints And Tolerations

This section contains knowledge relating to Kubernetes taints and tolerations.

Taints and tolerations can be used to control the scheduling and placement of pods on nodes.  For example, a specific workload, such as Prometheus, may require increased resources such as RAM compared to other workloads.  You can use taints and tolerations to ensure that Prometheus pods are only scheduled on nodes that have sufficient resources; perhaps a node group dedicated to Prometheus with larger RAM allocations per host node.

Further details on taints and tolerations can be found in the [Kubernetes documentation](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/).

## Taints

Taints should be applied to host **nodes**.  Taints are applied to nodes using the `kubectl taint` command, or can be applied during node creation on the cloud provider; see [AWS EKS](../AWS/AWS-EKS.md#adding-eks-host-nodes) for more information.

### Taint Syntax

Taints are defined using the following syntax:

```bash
kubectl taint nodes <node-name> <key>=<value>:<effect>
```

Where:
`<node-name>` is the name of the node to apply the taint to.
`<key>` is the name of the taint.
`<value>` is the value of the taint.
`<effect>` is the effect of the taint.

#### Example

```bash
kubectl taint nodes node1 nodeRole=Prometheus:NoSchedule
```

### Taint Effects

Taints can have one of the following effects:

- `NoSchedule` - Pods that do not tolerate the taint will not be scheduled on the node.
- `PreferNoSchedule` - Kubernetes will try to avoid scheduling pods that do not tolerate the taint on the node.
- `NoExecute` - Pods that do not tolerate the taint will be evicted from the node.
- `NoExecuteIfNewPodScheduled` - Pods that do not tolerate the taint will be evicted from the node if a new pod is scheduled on the node.

## Tolerations

Tolerations should be applied to **pods**.  Tolerations are applied to pods using the `tolerations` property in the pod definition.

Tolerations allow pods to "tolerate" specified taints.  Thus a pod with a toleration for a taint **will be scheduled** on a node with that taint.

### Tolerations Syntax

Tolerations are defined using the following syntax:

```yaml
tolerations:
  - key: "key"
    operator: "Equal"
    value: "value"
    effect: "NoSchedule"
```

Where:
`key` is the name of the taint.
`operator` is the operator used to compare the key and value. Valid values are `Equal` and `Exists`.
`value` is the value of the taint.
`effect` is the effect of the taint.

#### Example

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: prometheus
  labels:
    app: prometheus
spec:
  containers:
  - name: prometheus
    image: prom/prometheus
    ports:
    - containerPort: 9090
  tolerations:
  - key: "nodeRole"
    operator: "Equal"
    value: "Prometheus"
    effect: "NoSchedule"
```
