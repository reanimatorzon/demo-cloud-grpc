// Certs created like that - https://gist.github.com/cecilemuller/9492b848eb8fe46d462abeb26656c4f8
// Then - https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/
// $ kubectl create -n istio-system secret tls localhost-crt --key=localhost.key --cert=localhost.crt
// The secret named `localhost-cer`
{
  httpsGateway: {
    apiVersion: 'networking.istio.io/v1alpha3',
    kind: 'Gateway',
    metadata: {
      name: 'https-gateway',
      namespace: $._global.namespace,
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
            credentialName: 'localhost-cer',
          },
          hosts: [
            '*',
          ],
        },
      ],
    },
  },

  virtualService: {
    apiVersion: 'networking.istio.io/v1alpha3',
    kind: 'VirtualService',
    metadata: {
      name: 'my-virtual-service',
      namespace: $._global.namespace,
    },
    spec: {
      hosts: [
        '*',
      ],
      gateways: [
        'https-gateway',
      ],
      http: [
        {
          match: [
            {
              uri: {
                prefix: '/time-server/',
              },
            },
            {
              uri: {
                prefix: '/time-server',
              },
            },
          ],
          rewrite: {
            uri: '/',
          },
          route: [
            {
              destination: {
                host: 'time-server',
                port: {
                  number: 9001,
                },
              },
            },
          ],
        },
        {
          match: [
            {
              uri: {
                prefix: '/time-client/',
              },
            },
            {
              uri: {
                prefix: '/time-client',
              },
            },
          ],
          rewrite: {
            uri: '/',
          },
          route: [
            {
              destination: {
                host: 'time-client',
                port: {
                  number: 9002,
                },
              },
            },
          ],
        },
      ],
    },
  },

  strictPeerAuthenification: {
    apiVersion: 'security.istio.io/v1beta1',
    kind: 'PeerAuthentication',
    metadata: {
      name: 'default',
      namespace: $._global.namespace,
    },
    spec: {
      mtls: {
        mode: 'STRICT',
      },
    },
  },

  defaultDestinationRule: {
    apiVersion: 'networking.istio.io/v1alpha3',
    kind: 'DestinationRule',
    metadata: {
      name: 'default',
      namespace: $._global.namespace,
    },
    spec: {
      host: '*',
      trafficPolicy: {
        tls: {
          mode: 'ISTIO_MUTUAL',
        },
      },
    },
  },

}