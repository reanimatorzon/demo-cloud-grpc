{
  _defaultContainerPorts:: {
    http: 8080,
    grpc: 9090,
  },
  _defaultVirtualServerPorts:: {
    https: 443,
    grpcs: 8443,
  },

  _baseHttpServicePortShift:: 8000,
  _baseGrpcServicePortShift:: 9000,

  // application list
  _springBootApps:: [
    { name: 'time-server', version: '0.0.2-SNAPSHOT', servicePortShift: 1 },
    { name: 'time-client', version: '0.0.3-SNAPSHOT', servicePortShift: 2 },
  ]
}