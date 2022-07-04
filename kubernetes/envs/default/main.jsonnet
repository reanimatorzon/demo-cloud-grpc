(import 'kubernetes.libsonnet') +
(import 'global.libsonnet') +
{
  ns: $.k.namespace.new('time-app') + $.k.namespace.enableIstioInjection,

  strictPeerAuth: $.k.security.strictPeerAuth(self.ns),
  mtls: $.k.security.mtls(self.ns),

  deployments: [
    $.k.deployment.new(
      self.ns,
      'docker.io/library', app.name, app.version,
      {
        http: $._baseHttpServicePortShift + app.servicePortShift,
        grpc: $._baseGrpcServicePortShift + app.servicePortShift
      }
    ) for app in $._springBootApps
  ],

  services: [
    $.k.service.new(deployment) for deployment in self.deployments
  ],

  httpsGateway: $.k.gateway.https.new(self.ns, 'https-gateway', tlsCredentialName='localhost-crt'),

  virtualService: $.k.virtualService.new(self.ns, 'virtual-service', self.services, [self.httpsGateway]),
}
