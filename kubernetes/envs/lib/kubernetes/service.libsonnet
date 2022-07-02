{
  k+:: {
    service: {
      new(deployment, port): {
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
          ports: [{
            port: port,
            targetPort: deployment.spec.template.spec.containers[0].ports[0].containerPort,
          }],
          type: 'LoadBalancer',
        },
      },
    }
  }
}