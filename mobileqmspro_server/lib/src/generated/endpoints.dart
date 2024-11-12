/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/log_login_endpoint.dart' as _i2;
import '../endpoints/profile_user_endpoint.dart' as _i3;
import '../endpoints/queue_service_endpoint.dart' as _i4;
import '../endpoints/queue_window_endpoint.dart' as _i5;
import '../endpoints/token_issued_endpoint.dart' as _i6;
import 'package:mobileqmspro_server/src/generated/log_login.dart' as _i7;
import 'package:mobileqmspro_server/src/generated/profile_user.dart' as _i8;
import 'package:mobileqmspro_server/src/generated/queue_service.dart' as _i9;
import 'package:mobileqmspro_server/src/generated/queue_window.dart' as _i10;
import 'package:mobileqmspro_server/src/generated/token_issued.dart' as _i11;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'logLogin': _i2.LogLoginEndpoint()
        ..initialize(
          server,
          'logLogin',
          null,
        ),
      'profileUser': _i3.ProfileUserEndpoint()
        ..initialize(
          server,
          'profileUser',
          null,
        ),
      'queueService': _i4.QueueServiceEndpoint()
        ..initialize(
          server,
          'queueService',
          null,
        ),
      'queueWindow': _i5.QueueWindowEndpoint()
        ..initialize(
          server,
          'queueWindow',
          null,
        ),
      'tokenIssued': _i6.TokenIssuedEndpoint()
        ..initialize(
          server,
          'tokenIssued',
          null,
        ),
    };
    connectors['logLogin'] = _i1.EndpointConnector(
      name: 'logLogin',
      endpoint: endpoints['logLogin']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'desc': _i1.ParameterDescription(
              name: 'desc',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['logLogin'] as _i2.LogLoginEndpoint).getAll(
            session,
            params['limit'],
            params['offset'],
            params['desc'],
          ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'logLogin': _i1.ParameterDescription(
              name: 'logLogin',
              type: _i1.getType<_i7.LogLogin>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['logLogin'] as _i2.LogLoginEndpoint).update(
            session,
            params['logLogin'],
          ),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'logLogin': _i1.ParameterDescription(
              name: 'logLogin',
              type: _i1.getType<_i7.LogLogin>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['logLogin'] as _i2.LogLoginEndpoint).create(
            session,
            params['logLogin'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'logLogin': _i1.ParameterDescription(
              name: 'logLogin',
              type: _i1.getType<_i7.LogLogin>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['logLogin'] as _i2.LogLoginEndpoint).delete(
            session,
            params['logLogin'],
          ),
        ),
      },
    );
    connectors['profileUser'] = _i1.EndpointConnector(
      name: 'profileUser',
      endpoint: endpoints['profileUser']!,
      methodConnectors: {
        'findByEmail': _i1.MethodConnector(
          name: 'findByEmail',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['profileUser'] as _i3.ProfileUserEndpoint).findByEmail(
            session,
            params['email'],
          ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'profileUser': _i1.ParameterDescription(
              name: 'profileUser',
              type: _i1.getType<_i8.ProfileUser>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['profileUser'] as _i3.ProfileUserEndpoint).update(
            session,
            params['profileUser'],
          ),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'profileUser': _i1.ParameterDescription(
              name: 'profileUser',
              type: _i1.getType<_i8.ProfileUser>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['profileUser'] as _i3.ProfileUserEndpoint).create(
            session,
            params['profileUser'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'profileUser': _i1.ParameterDescription(
              name: 'profileUser',
              type: _i1.getType<_i8.ProfileUser>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['profileUser'] as _i3.ProfileUserEndpoint).delete(
            session,
            params['profileUser'],
          ),
        ),
      },
    );
    connectors['queueService'] = _i1.EndpointConnector(
      name: 'queueService',
      endpoint: endpoints['queueService']!,
      methodConnectors: {
        'getAllByWindowId': _i1.MethodConnector(
          name: 'getAllByWindowId',
          params: {
            'queueWindowId': _i1.ParameterDescription(
              name: 'queueWindowId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'desc': _i1.ParameterDescription(
              name: 'desc',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['queueService'] as _i4.QueueServiceEndpoint)
                  .getAllByWindowId(
            session,
            params['queueWindowId'],
            params['limit'],
            params['offset'],
            params['desc'],
          ),
        ),
        'getAllByWindowIdAndEnable': _i1.MethodConnector(
          name: 'getAllByWindowIdAndEnable',
          params: {
            'queueWindowId': _i1.ParameterDescription(
              name: 'queueWindowId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'desc': _i1.ParameterDescription(
              name: 'desc',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['queueService'] as _i4.QueueServiceEndpoint)
                  .getAllByWindowIdAndEnable(
            session,
            params['queueWindowId'],
            params['desc'],
          ),
        ),
        'findById': _i1.MethodConnector(
          name: 'findById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['queueService'] as _i4.QueueServiceEndpoint).findById(
            session,
            params['id'],
          ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'queueService': _i1.ParameterDescription(
              name: 'queueService',
              type: _i1.getType<_i9.QueueService>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['queueService'] as _i4.QueueServiceEndpoint).update(
            session,
            params['queueService'],
          ),
        ),
        'createAll': _i1.MethodConnector(
          name: 'createAll',
          params: {
            'queueServiceList': _i1.ParameterDescription(
              name: 'queueServiceList',
              type: _i1.getType<List<_i9.QueueService>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['queueService'] as _i4.QueueServiceEndpoint).createAll(
            session,
            params['queueServiceList'],
          ),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'queueService': _i1.ParameterDescription(
              name: 'queueService',
              type: _i1.getType<_i9.QueueService>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['queueService'] as _i4.QueueServiceEndpoint).create(
            session,
            params['queueService'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'queueService': _i1.ParameterDescription(
              name: 'queueService',
              type: _i1.getType<_i9.QueueService>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['queueService'] as _i4.QueueServiceEndpoint).delete(
            session,
            params['queueService'],
          ),
        ),
        'countByWindow': _i1.MethodConnector(
          name: 'countByWindow',
          params: {
            'windowId': _i1.ParameterDescription(
              name: 'windowId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['queueService'] as _i4.QueueServiceEndpoint)
                  .countByWindow(
            session,
            params['windowId'],
          ),
        ),
      },
    );
    connectors['queueWindow'] = _i1.EndpointConnector(
      name: 'queueWindow',
      endpoint: endpoints['queueWindow']!,
      methodConnectors: {
        'getAllByEmail': _i1.MethodConnector(
          name: 'getAllByEmail',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'desc': _i1.ParameterDescription(
              name: 'desc',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['queueWindow'] as _i5.QueueWindowEndpoint)
                  .getAllByEmail(
            session,
            params['email'],
            params['limit'],
            params['offset'],
            params['desc'],
          ),
        ),
        'getSelectedByEmail': _i1.MethodConnector(
          name: 'getSelectedByEmail',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['queueWindow'] as _i5.QueueWindowEndpoint)
                  .getSelectedByEmail(
            session,
            params['email'],
          ),
        ),
        'findById': _i1.MethodConnector(
          name: 'findById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['queueWindow'] as _i5.QueueWindowEndpoint).findById(
            session,
            params['id'],
          ),
        ),
        'updateSelected': _i1.MethodConnector(
          name: 'updateSelected',
          params: {
            'queueWindow': _i1.ParameterDescription(
              name: 'queueWindow',
              type: _i1.getType<_i10.QueueWindow>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['queueWindow'] as _i5.QueueWindowEndpoint)
                  .updateSelected(
            session,
            params['queueWindow'],
            params['email'],
          ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'queueWindow': _i1.ParameterDescription(
              name: 'queueWindow',
              type: _i1.getType<_i10.QueueWindow>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['queueWindow'] as _i5.QueueWindowEndpoint).update(
            session,
            params['queueWindow'],
          ),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'queueWindow': _i1.ParameterDescription(
              name: 'queueWindow',
              type: _i1.getType<_i10.QueueWindow>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['queueWindow'] as _i5.QueueWindowEndpoint).create(
            session,
            params['queueWindow'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'queueWindow': _i1.ParameterDescription(
              name: 'queueWindow',
              type: _i1.getType<_i10.QueueWindow>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['queueWindow'] as _i5.QueueWindowEndpoint).delete(
            session,
            params['queueWindow'],
          ),
        ),
        'countByEmail': _i1.MethodConnector(
          name: 'countByEmail',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['queueWindow'] as _i5.QueueWindowEndpoint)
                  .countByEmail(
            session,
            params['email'],
          ),
        ),
      },
    );
    connectors['tokenIssued'] = _i1.EndpointConnector(
      name: 'tokenIssued',
      endpoint: endpoints['tokenIssued']!,
      methodConnectors: {
        'getAllByWindowId': _i1.MethodConnector(
          name: 'getAllByWindowId',
          params: {
            'windowId': _i1.ParameterDescription(
              name: 'windowId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'desc': _i1.ParameterDescription(
              name: 'desc',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tokenIssued'] as _i6.TokenIssuedEndpoint)
                  .getAllByWindowId(
            session,
            params['windowId'],
            params['limit'],
            params['offset'],
            params['desc'],
          ),
        ),
        'getAllByWindowAndStatus': _i1.MethodConnector(
          name: 'getAllByWindowAndStatus',
          params: {
            'windowId': _i1.ParameterDescription(
              name: 'windowId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'statusCode': _i1.ParameterDescription(
              name: 'statusCode',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'desc': _i1.ParameterDescription(
              name: 'desc',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tokenIssued'] as _i6.TokenIssuedEndpoint)
                  .getAllByWindowAndStatus(
            session,
            params['windowId'],
            params['statusCode'],
            params['limit'],
            params['offset'],
            params['desc'],
          ),
        ),
        'getAllByWindowAndOnQueue': _i1.MethodConnector(
          name: 'getAllByWindowAndOnQueue',
          params: {
            'windowId': _i1.ParameterDescription(
              name: 'windowId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'desc': _i1.ParameterDescription(
              name: 'desc',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tokenIssued'] as _i6.TokenIssuedEndpoint)
                  .getAllByWindowAndOnQueue(
            session,
            params['windowId'],
            params['limit'],
            params['offset'],
            params['desc'],
          ),
        ),
        'getAllByServiceId': _i1.MethodConnector(
          name: 'getAllByServiceId',
          params: {
            'serviceId': _i1.ParameterDescription(
              name: 'serviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'desc': _i1.ParameterDescription(
              name: 'desc',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tokenIssued'] as _i6.TokenIssuedEndpoint)
                  .getAllByServiceId(
            session,
            params['serviceId'],
            params['limit'],
            params['offset'],
            params['desc'],
          ),
        ),
        'findByToken': _i1.MethodConnector(
          name: 'findByToken',
          params: {
            'letter': _i1.ParameterDescription(
              name: 'letter',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'start': _i1.ParameterDescription(
              name: 'start',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tokenIssued'] as _i6.TokenIssuedEndpoint).findByToken(
            session,
            params['letter'],
            params['start'],
          ),
        ),
        'findById': _i1.MethodConnector(
          name: 'findById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tokenIssued'] as _i6.TokenIssuedEndpoint).findById(
            session,
            params['id'],
          ),
        ),
        'findLatestTokenIssuedByWindowAndService': _i1.MethodConnector(
          name: 'findLatestTokenIssuedByWindowAndService',
          params: {
            'windowId': _i1.ParameterDescription(
              name: 'windowId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'serviceId': _i1.ParameterDescription(
              name: 'serviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tokenIssued'] as _i6.TokenIssuedEndpoint)
                  .findLatestTokenIssuedByWindowAndService(
            session,
            params['windowId'],
            params['serviceId'],
          ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'tokenIssued': _i1.ParameterDescription(
              name: 'tokenIssued',
              type: _i1.getType<_i11.TokenIssued>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tokenIssued'] as _i6.TokenIssuedEndpoint).update(
            session,
            params['tokenIssued'],
          ),
        ),
        'updateAll': _i1.MethodConnector(
          name: 'updateAll',
          params: {
            'tokenIssuedList': _i1.ParameterDescription(
              name: 'tokenIssuedList',
              type: _i1.getType<List<_i11.TokenIssued>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tokenIssued'] as _i6.TokenIssuedEndpoint).updateAll(
            session,
            params['tokenIssuedList'],
          ),
        ),
        'resetAll': _i1.MethodConnector(
          name: 'resetAll',
          params: {
            'windowId': _i1.ParameterDescription(
              name: 'windowId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tokenIssued'] as _i6.TokenIssuedEndpoint).resetAll(
            session,
            params['windowId'],
          ),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'tokenIssued': _i1.ParameterDescription(
              name: 'tokenIssued',
              type: _i1.getType<_i11.TokenIssued>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tokenIssued'] as _i6.TokenIssuedEndpoint).create(
            session,
            params['tokenIssued'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'tokenIssued': _i1.ParameterDescription(
              name: 'tokenIssued',
              type: _i1.getType<_i11.TokenIssued>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tokenIssued'] as _i6.TokenIssuedEndpoint).delete(
            session,
            params['tokenIssued'],
          ),
        ),
        'countIsQueueStatus': _i1.MethodConnector(
          name: 'countIsQueueStatus',
          params: {
            'windowId': _i1.ParameterDescription(
              name: 'windowId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tokenIssued'] as _i6.TokenIssuedEndpoint)
                  .countIsQueueStatus(
            session,
            params['windowId'],
          ),
        ),
        'countStatus': _i1.MethodConnector(
          name: 'countStatus',
          params: {
            'statusCode': _i1.ParameterDescription(
              name: 'statusCode',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'windowId': _i1.ParameterDescription(
              name: 'windowId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tokenIssued'] as _i6.TokenIssuedEndpoint).countStatus(
            session,
            params['statusCode'],
            params['windowId'],
          ),
        ),
        'echoStatusStream': _i1.MethodStreamConnector(
          name: 'echoStatusStream',
          params: {
            'statusCode': _i1.ParameterDescription(
              name: 'statusCode',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'windowId': _i1.ParameterDescription(
              name: 'windowId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['tokenIssued'] as _i6.TokenIssuedEndpoint)
                  .echoStatusStream(
            session,
            params['statusCode'],
            params['windowId'],
          ),
        ),
        'echoTokensStream': _i1.MethodStreamConnector(
          name: 'echoTokensStream',
          params: {
            'windowId': _i1.ParameterDescription(
              name: 'windowId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['tokenIssued'] as _i6.TokenIssuedEndpoint)
                  .echoTokensStream(
            session,
            params['windowId'],
          ),
        ),
      },
    );
  }
}
