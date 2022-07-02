{
  k+:: {
    virtualService: {
      new(ns, name, services, gateways, hosts=['*']): {
        apiVersion: 'networking.istio.io/v1alpha3',
        kind: 'VirtualService',
        metadata: {
          name: name,
          namespace: ns.metadata.name,
        },
        spec: {
          hosts: hosts,
          gateways: [gateway.metadata.name for gateway in gateways],
          http: [
            {
              match: [
                {
                  uri: {
                    prefix: '/' + service.metadata.name + '/',
                  },
                },
                {
                  uri: {
                    prefix: '/' + service.metadata.name,
                  },
                },
              ],
              rewrite: {
                uri: '/',
              },
              route: [
                {
                  destination: {
                    host: service.metadata.name,
                    port: {
                      number: service.spec.ports[0].port,
                    },
                  },
                },
              ],
            } for service in services
          ],
        },
      },
    }
  }
}