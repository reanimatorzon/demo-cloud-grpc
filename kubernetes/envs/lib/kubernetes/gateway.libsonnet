{
  k+:: {
    gateway: {
      https: {
        new(ns, name, tlsCredentialName, hosts=['*']): {
          apiVersion: 'networking.istio.io/v1alpha3',
          kind: 'Gateway',
          metadata: {
            name: name,
            namespace: ns.metadata.name,
          },
          spec: {
            selector: {
              istio: 'ingressgateway',
            },
            servers: [
              {
                port: {
                  number: 443,
                  name: 'https',
                  protocol: 'HTTPS',
                },
                tls: {
                  mode: 'SIMPLE',
                  credentialName: tlsCredentialName,
                },
                hosts: hosts
              },
            ],
          },
        },
      },
    }
  }
}