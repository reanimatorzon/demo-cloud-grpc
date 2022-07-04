{
  _baseHttpServicePortShift:: 8000,
  _baseGrpcServicePortShift:: 9000,

  // application list
  _springBootApps:: [
    { name: 'time-server', version: '0.0.4-SNAPSHOT', servicePortShift: 1 },
    { name: 'time-client', version: '0.0.4-SNAPSHOT', servicePortShift: 2 },
  ]
}