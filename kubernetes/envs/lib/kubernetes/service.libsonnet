{
  k+:: {
    service: {
      new(deployment): {
        apiVersion: 'v1',
        kind: 'Service',
        metadata: {
          name: deployment.metadata.name,
          namespace: deployment.metadata.namespace,
        },
        spec: {
          selector: {
            app: deployment.metadata.name,
          },
          ports: [{ // FIXME
            name: 'http',
            port: std.parseInt(deployment.metadata.annotations.httpServicePort),
            targetPort: 8080,
          }, { // FIXME
            name: 'grpc',
            port: std.parseInt(deployment.metadata.annotations.grpcServicePort),
            targetPort: 6565,
          }],
          type: 'LoadBalancer',
        },
      },
    }
  }
}