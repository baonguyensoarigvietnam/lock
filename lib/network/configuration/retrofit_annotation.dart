import 'package:retrofit/retrofit.dart';
import 'package:applock/network/utility/constant/network_constant.dart';

// ignore: constant_identifier_names
const SkipEnvelope = Extra(<String, Object>{
  NetworkConstant.skipEnvelope: true,
});

// ignore: constant_identifier_names
const SkipAuthApiKey = Extra(<String, Object>{
  NetworkConstant.skipAuthApi: true,
});

/// Annotation to inject 'app_id' and 'platform' into query parameters.
// ignore: constant_identifier_names
const InjectHubQuery = Extra(<String, Object>{
  NetworkConstant.injectHubQuery: true,
});

/// Annotation to inject 'host_app_id' and 'platform' into body.
// ignore: constant_identifier_names
const InjectHubBodyHostAppId = Extra(<String, Object>{
  NetworkConstant.injectHubBodyHostAppId: true,
});

/// Annotation to inject 'app_id' and 'platform' into body.
// ignore: constant_identifier_names
const InjectHubBodyAppId = Extra(<String, Object>{
  NetworkConstant.injectHubBodyAppId: true,
});

/// Annotation to inject 'uuid' into query parameters.
// ignore: constant_identifier_names
const InjectDeviceUuidQuery = Extra(<String, Object>{
  NetworkConstant.injectDeviceUuidQuery: true,
});

/// Annotation to inject 'uuid' into body.
// ignore: constant_identifier_names
const InjectDeviceUuidBody = Extra(<String, Object>{
  NetworkConstant.injectDeviceUuidBody: true,
});
