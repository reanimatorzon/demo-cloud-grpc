{
  k+:: {
    deployment: {
      new(ns, registryUrl, name, version, servicePorts={}, replicas=1): {
        apiVersion: 'apps/v1',
        kind: 'Deployment',
        metadata: {
          name: name,
          namespace: ns.metadata.name,
          labels: {
            app: name,
          },
          annotations: {
            httpServicePort: '%s' % servicePorts.http,
            grpcServicePort: '%s' % servicePorts.grpc
          },
        },
        spec: {
          replicas: replicas,
          selector: {
            matchLabels: {
              app: name,
            },
          },
          template: {
            metadata: {
              labels: {
                app: name,
              },
            },
            spec: {
              containers: [{
                name: name,
                image: '%s/%s:%s' % [registryUrl, name, version],
                ports: [{
                  containerPort: 8080,
                }, {
                  containerPort: 6565,
                }],
              }],
            },
          },
        },
      },
    },
  },
}