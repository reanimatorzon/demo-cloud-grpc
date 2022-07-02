{
  k+:: {
    security: {
      strictPeerAuth(ns): {
        apiVersion: 'security.istio.io/v1beta1',
        kind: 'PeerAuthentication',
        metadata: {
          name: 'default',
          namespace: ns.metadata.name,
        },
        spec: {
          mtls: {
            mode: 'STRICT',
          },
        },
      },
      mtls(ns): {
        apiVersion: 'networking.istio.io/v1alpha3',
        kind: 'DestinationRule',
        metadata: {
          name: 'default',
          namespace: ns.metadata.name,
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
  }
}