(import 'kubernetes.libsonnet') +
{
  ns: $.k.namespace.new('time-app') + $.k.namespace.enableIstioInjection,

  strictPeerAuth: $.k.security.strictPeerAuth(self.ns),
  mtls: $.k.security.mtls(self.ns),

  timeServer: $.k.deployment.new(self.ns, 'docker.io/library', 'time-server', '0.0.2-SNAPSHOT'),
  timeClient: $.k.deployment.new(self.ns, 'docker.io/library', 'time-client', '0.0.3-SNAPSHOT'),

  timeServerService: $.k.service.new(self.timeServer, 9001),
  timeClientService: $.k.service.new(self.timeClient, 9002),

  httpsGateway: $.k.gateway.https.new(self.ns, 'https-gateway', tlsCredentialName='localhost-cer'),

  virtualService: $.k.virtualService.new(
    self.ns,
    'istio-virtual-service',
    [self.timeServerService, self.timeClientService],
    [self.httpsGateway]
  ),

}