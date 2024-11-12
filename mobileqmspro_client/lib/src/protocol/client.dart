/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:mobileqmspro_client/src/protocol/log_login.dart' as _i3;
import 'package:mobileqmspro_client/src/protocol/profile_user.dart' as _i4;
import 'package:mobileqmspro_client/src/protocol/queue_service.dart' as _i5;
import 'package:mobileqmspro_client/src/protocol/queue_window.dart' as _i6;
import 'package:mobileqmspro_client/src/protocol/token_issued.dart' as _i7;
import 'protocol.dart' as _i8;

/// {@category Endpoint}
class EndpointLogLogin extends _i1.EndpointRef {
  EndpointLogLogin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'logLogin';

  _i2.Future<List<_i3.LogLogin>> getAll(
    int? limit,
    int? offset,
    bool desc,
  ) =>
      caller.callServerEndpoint<List<_i3.LogLogin>>(
        'logLogin',
        'getAll',
        {
          'limit': limit,
          'offset': offset,
          'desc': desc,
        },
      );

  _i2.Future<_i3.LogLogin> update(_i3.LogLogin logLogin) =>
      caller.callServerEndpoint<_i3.LogLogin>(
        'logLogin',
        'update',
        {'logLogin': logLogin},
      );

  _i2.Future<_i3.LogLogin> create(_i3.LogLogin logLogin) =>
      caller.callServerEndpoint<_i3.LogLogin>(
        'logLogin',
        'create',
        {'logLogin': logLogin},
      );

  _i2.Future<void> delete(_i3.LogLogin logLogin) =>
      caller.callServerEndpoint<void>(
        'logLogin',
        'delete',
        {'logLogin': logLogin},
      );
}

/// {@category Endpoint}
class EndpointProfileUser extends _i1.EndpointRef {
  EndpointProfileUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'profileUser';

  _i2.Future<_i4.ProfileUser?> findByEmail(String email) =>
      caller.callServerEndpoint<_i4.ProfileUser?>(
        'profileUser',
        'findByEmail',
        {'email': email},
      );

  _i2.Future<_i4.ProfileUser> update(_i4.ProfileUser profileUser) =>
      caller.callServerEndpoint<_i4.ProfileUser>(
        'profileUser',
        'update',
        {'profileUser': profileUser},
      );

  _i2.Future<_i4.ProfileUser> create(_i4.ProfileUser profileUser) =>
      caller.callServerEndpoint<_i4.ProfileUser>(
        'profileUser',
        'create',
        {'profileUser': profileUser},
      );

  _i2.Future<void> delete(_i4.ProfileUser profileUser) =>
      caller.callServerEndpoint<void>(
        'profileUser',
        'delete',
        {'profileUser': profileUser},
      );
}

/// {@category Endpoint}
class EndpointQueueService extends _i1.EndpointRef {
  EndpointQueueService(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'queueService';

  _i2.Future<List<_i5.QueueService>> getAllByWindowId(
    int queueWindowId,
    int? limit,
    int? offset,
    bool desc,
  ) =>
      caller.callServerEndpoint<List<_i5.QueueService>>(
        'queueService',
        'getAllByWindowId',
        {
          'queueWindowId': queueWindowId,
          'limit': limit,
          'offset': offset,
          'desc': desc,
        },
      );

  _i2.Future<List<_i5.QueueService>> getAllByWindowIdAndEnable(
    int queueWindowId,
    bool desc,
  ) =>
      caller.callServerEndpoint<List<_i5.QueueService>>(
        'queueService',
        'getAllByWindowIdAndEnable',
        {
          'queueWindowId': queueWindowId,
          'desc': desc,
        },
      );

  _i2.Future<_i5.QueueService?> findById(int id) =>
      caller.callServerEndpoint<_i5.QueueService?>(
        'queueService',
        'findById',
        {'id': id},
      );

  _i2.Future<_i5.QueueService> update(_i5.QueueService queueService) =>
      caller.callServerEndpoint<_i5.QueueService>(
        'queueService',
        'update',
        {'queueService': queueService},
      );

  _i2.Future<List<_i5.QueueService>> createAll(
          List<_i5.QueueService> queueServiceList) =>
      caller.callServerEndpoint<List<_i5.QueueService>>(
        'queueService',
        'createAll',
        {'queueServiceList': queueServiceList},
      );

  _i2.Future<_i5.QueueService> create(_i5.QueueService queueService) =>
      caller.callServerEndpoint<_i5.QueueService>(
        'queueService',
        'create',
        {'queueService': queueService},
      );

  _i2.Future<void> delete(_i5.QueueService queueService) =>
      caller.callServerEndpoint<void>(
        'queueService',
        'delete',
        {'queueService': queueService},
      );

  _i2.Future<int> countByWindow(int windowId) => caller.callServerEndpoint<int>(
        'queueService',
        'countByWindow',
        {'windowId': windowId},
      );
}

/// {@category Endpoint}
class EndpointQueueWindow extends _i1.EndpointRef {
  EndpointQueueWindow(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'queueWindow';

  _i2.Future<List<_i6.QueueWindow>> getAllByEmail(
    String email,
    int? limit,
    int? offset,
    bool desc,
  ) =>
      caller.callServerEndpoint<List<_i6.QueueWindow>>(
        'queueWindow',
        'getAllByEmail',
        {
          'email': email,
          'limit': limit,
          'offset': offset,
          'desc': desc,
        },
      );

  _i2.Future<_i6.QueueWindow?> getSelectedByEmail(String email) =>
      caller.callServerEndpoint<_i6.QueueWindow?>(
        'queueWindow',
        'getSelectedByEmail',
        {'email': email},
      );

  _i2.Future<_i6.QueueWindow?> findById(int id) =>
      caller.callServerEndpoint<_i6.QueueWindow?>(
        'queueWindow',
        'findById',
        {'id': id},
      );

  _i2.Future<void> updateSelected(
    _i6.QueueWindow queueWindow,
    String email,
  ) =>
      caller.callServerEndpoint<void>(
        'queueWindow',
        'updateSelected',
        {
          'queueWindow': queueWindow,
          'email': email,
        },
      );

  _i2.Future<_i6.QueueWindow> update(_i6.QueueWindow queueWindow) =>
      caller.callServerEndpoint<_i6.QueueWindow>(
        'queueWindow',
        'update',
        {'queueWindow': queueWindow},
      );

  _i2.Future<_i6.QueueWindow> create(_i6.QueueWindow queueWindow) =>
      caller.callServerEndpoint<_i6.QueueWindow>(
        'queueWindow',
        'create',
        {'queueWindow': queueWindow},
      );

  _i2.Future<void> delete(_i6.QueueWindow queueWindow) =>
      caller.callServerEndpoint<void>(
        'queueWindow',
        'delete',
        {'queueWindow': queueWindow},
      );

  _i2.Future<int> countByEmail(String email) => caller.callServerEndpoint<int>(
        'queueWindow',
        'countByEmail',
        {'email': email},
      );
}

/// {@category Endpoint}
class EndpointTokenIssued extends _i1.EndpointRef {
  EndpointTokenIssued(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'tokenIssued';

  _i2.Future<List<_i7.TokenIssued>> getAllByWindowId(
    int windowId,
    int? limit,
    int? offset,
    bool desc,
  ) =>
      caller.callServerEndpoint<List<_i7.TokenIssued>>(
        'tokenIssued',
        'getAllByWindowId',
        {
          'windowId': windowId,
          'limit': limit,
          'offset': offset,
          'desc': desc,
        },
      );

  _i2.Future<List<_i7.TokenIssued>> getAllByWindowAndStatus(
    int windowId,
    int statusCode,
    int? limit,
    int? offset,
    bool desc,
  ) =>
      caller.callServerEndpoint<List<_i7.TokenIssued>>(
        'tokenIssued',
        'getAllByWindowAndStatus',
        {
          'windowId': windowId,
          'statusCode': statusCode,
          'limit': limit,
          'offset': offset,
          'desc': desc,
        },
      );

  _i2.Future<List<_i7.TokenIssued>> getAllByWindowAndOnQueue(
    int windowId,
    int? limit,
    int? offset,
    bool desc,
  ) =>
      caller.callServerEndpoint<List<_i7.TokenIssued>>(
        'tokenIssued',
        'getAllByWindowAndOnQueue',
        {
          'windowId': windowId,
          'limit': limit,
          'offset': offset,
          'desc': desc,
        },
      );

  _i2.Future<List<_i7.TokenIssued>> getAllByServiceId(
    int serviceId,
    int? limit,
    int? offset,
    bool desc,
  ) =>
      caller.callServerEndpoint<List<_i7.TokenIssued>>(
        'tokenIssued',
        'getAllByServiceId',
        {
          'serviceId': serviceId,
          'limit': limit,
          'offset': offset,
          'desc': desc,
        },
      );

  _i2.Future<_i7.TokenIssued?> findByToken(
    String letter,
    int start,
  ) =>
      caller.callServerEndpoint<_i7.TokenIssued?>(
        'tokenIssued',
        'findByToken',
        {
          'letter': letter,
          'start': start,
        },
      );

  _i2.Future<_i7.TokenIssued?> findById(int id) =>
      caller.callServerEndpoint<_i7.TokenIssued?>(
        'tokenIssued',
        'findById',
        {'id': id},
      );

  _i2.Future<_i7.TokenIssued?> findLatestTokenIssuedByWindowAndService(
    int windowId,
    int serviceId,
  ) =>
      caller.callServerEndpoint<_i7.TokenIssued?>(
        'tokenIssued',
        'findLatestTokenIssuedByWindowAndService',
        {
          'windowId': windowId,
          'serviceId': serviceId,
        },
      );

  _i2.Future<_i7.TokenIssued> update(_i7.TokenIssued tokenIssued) =>
      caller.callServerEndpoint<_i7.TokenIssued>(
        'tokenIssued',
        'update',
        {'tokenIssued': tokenIssued},
      );

  _i2.Future<List<_i7.TokenIssued>> updateAll(
          List<_i7.TokenIssued> tokenIssuedList) =>
      caller.callServerEndpoint<List<_i7.TokenIssued>>(
        'tokenIssued',
        'updateAll',
        {'tokenIssuedList': tokenIssuedList},
      );

  _i2.Future<List<_i7.TokenIssued>> resetAll(int windowId) =>
      caller.callServerEndpoint<List<_i7.TokenIssued>>(
        'tokenIssued',
        'resetAll',
        {'windowId': windowId},
      );

  _i2.Future<_i7.TokenIssued?> create(_i7.TokenIssued tokenIssued) =>
      caller.callServerEndpoint<_i7.TokenIssued?>(
        'tokenIssued',
        'create',
        {'tokenIssued': tokenIssued},
      );

  _i2.Future<void> delete(_i7.TokenIssued tokenIssued) =>
      caller.callServerEndpoint<void>(
        'tokenIssued',
        'delete',
        {'tokenIssued': tokenIssued},
      );

  _i2.Future<int> countIsQueueStatus(int windowId) =>
      caller.callServerEndpoint<int>(
        'tokenIssued',
        'countIsQueueStatus',
        {'windowId': windowId},
      );

  _i2.Future<int> countStatus(
    int statusCode,
    int windowId,
  ) =>
      caller.callServerEndpoint<int>(
        'tokenIssued',
        'countStatus',
        {
          'statusCode': statusCode,
          'windowId': windowId,
        },
      );

  _i2.Stream<dynamic> echoStatusStream(
    int statusCode,
    int windowId,
  ) =>
      caller.callStreamingServerEndpoint<_i2.Stream<dynamic>, dynamic>(
        'tokenIssued',
        'echoStatusStream',
        {
          'statusCode': statusCode,
          'windowId': windowId,
        },
        {},
      );

  _i2.Stream<dynamic> echoTokensStream(int windowId) =>
      caller.callStreamingServerEndpoint<_i2.Stream<dynamic>, dynamic>(
        'tokenIssued',
        'echoTokensStream',
        {'windowId': windowId},
        {},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i8.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    logLogin = EndpointLogLogin(this);
    profileUser = EndpointProfileUser(this);
    queueService = EndpointQueueService(this);
    queueWindow = EndpointQueueWindow(this);
    tokenIssued = EndpointTokenIssued(this);
  }

  late final EndpointLogLogin logLogin;

  late final EndpointProfileUser profileUser;

  late final EndpointQueueService queueService;

  late final EndpointQueueWindow queueWindow;

  late final EndpointTokenIssued tokenIssued;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'logLogin': logLogin,
        'profileUser': profileUser,
        'queueService': queueService,
        'queueWindow': queueWindow,
        'tokenIssued': tokenIssued,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
