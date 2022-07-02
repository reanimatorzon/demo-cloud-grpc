{
  k+:: {
    namespace: {
      new(name): {
        apiVersion: 'v1',
        kind: 'Namespace',
        metadata: {
          labels: {
            'kubernetes.io/metadata.name': name,
          },
          name: name,
        },
      },
      enableIstioInjection: {
        metadata+: {
          labels+: {
            'istio-injection': 'enabled'
          }
        }
      }
    }
  }
}