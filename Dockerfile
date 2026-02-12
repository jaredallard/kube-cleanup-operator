# syntax=docker/dockerfile:1
FROM gcr.io/distroless/static-debian13:nonroot
ENTRYPOINT ["/usr/local/bin/kube-cleanup-operator"]
COPY kube-cleanup-operator /usr/local/bin/
