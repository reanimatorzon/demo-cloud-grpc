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
            port: std.parseInt(deployment.metadata.annotations.httpServicePort),
            targetPort: deployment.spec.template.spec.containers[0].ports[0].containerPort,
          }, { // FIXME
            port: std.parseInt(deployment.metadata.annotations.httpServicePort),
            targetPort: deployment.spec.template.spec.containers[0].ports[1].containerPort,
          }],
          type: 'LoadBalancer',
        },
      },
    }
  }
}