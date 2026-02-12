# Kubernetes cleanup operator

> [!WARNING]
> This repository is a permanent fork of kube-cleanup-operator, however
> it is still being setup.

Kubernetes Controller to automatically delete completed Jobs and Pods.
Controller listens for changes in Pods and Jobs and acts accordingly
with config arguments.

Some common use-case scenarios:

- Delete Jobs and their pods after their completion
- Delete Pods stuck in a Pending state
- Delete Pods in Evicted state
- Delete orphaned Pods (Pods without an owner in non-running state)

| flag name                  | pod                                                   | job                           |
| -------------------------- | ----------------------------------------------------- | ----------------------------- |
| delete-successful-after    | delete after specified period if owned by the job     | delete after specified period |
| delete-failed-after        | delete after specified period if owned by the job     | delete after specified period |
| delete-orphaned-pods-after | delete after specified period (any completion status) | N/A                           |
| delete-evicted-pods-after  | delete on discovery                                   | N/A                           |
| delete-pending-pods-after  | delete after specified period                         | N/A                           |

## Helm chart

Chart is available to install via oci:

```bash
helm install --create-namespace --namespace kube-cleanup-operator \
  kube-cleanup-operator oci://ghcr.io/jaredallard/helm-charts/kube-cleanup-operator
```

## Docker images

`docker pull ghcr.io/jaredallard/kube-cleanup-operator`

## Development

```bash
mise run build
./bin/kube-cleanup-operator -run-outside-cluster -dry-run=true
```

## Usage

```bash
Usage of ./bin/kube-cleanup-operator:
  -delete-evicted-pods-after duration
        Delete pods in evicted state (golang duration format, e.g 5m), 0 - never delete (default 15m0s)
  -delete-failed-after duration
        Delete jobs and pods in failed state after X duration (golang duration format, e.g 5m), 0 - never delete
  -delete-orphaned-pods-after duration
        Delete orphaned pods. Pods without an owner in non-running state (golang duration format, e.g 5m), 0 - never delete (default 1h0m0s)
  -delete-pending-pods-after duration
        Delete pods in pending state after X duration (golang duration format, e.g 5m), 0 - never delete
  -delete-successful-after duration
        Delete jobs and pods in successful state after X duration (golang duration format, e.g 5m), 0 - never delete (default 15m0s)
  -dry-run
        Print only, do not delete anything.
  -ignore-owned-by-cronjobs
        [EXPERIMENTAL] Do not cleanup pods and jobs created by cronjobs
  -keep-failures int
        Number of hours to keep failed jobs, -1 - forever (default) 0 - never, >0 number of hours (default -1)
  -keep-pending int
        Number of hours to keep pending jobs, -1 - forever (default) >0 number of hours (default -1)
  -keep-successful int
        Number of hours to keep successful jobs, -1 - forever, 0 - never (default), >0 number of hours
  -legacy-mode true
        Legacy mode: true - use old `keep-*` flags, `false` - enable new `delete-*-after` flags (default true)
  -listen-addr string
        Address to expose metrics. (default "0.0.0.0:7000")
  -namespace string
        Limit scope to a single namespace
  -run-outside-cluster
        Set this flag when running outside of the cluster.
  -label-selector
        Delete only jobs and pods that meet label selector requirements. #See https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
```

### Optional parameters

DISCLAIMER: These parameters are not supported on this project since
they are implemented by the underlying libraries. Any malfunction
regarding the use them is not covered by this GitHub repository. They
are included in this documentation since the debugging process is
simplified.

```bash
-alsologtostderr
  log to standard error as well as files
-log_backtrace_at value
  when logging hits line file:N, emit a stack trace
-log_dir string
  If non-empty, write log files in this directory
-logtostderr
  log to standard error instead of files
-vmodule value
  comma-separated list of pattern=N settings for file-filtered logging
```

## License

All code modified on and before 538f00d447db507f528fd6f94fa2c3d81b9302f3
is MIT licensed. All code modified after
538f00d447db507f528fd6f94fa2c3d81b9302f3 is AGPL-3.0 licensed.
