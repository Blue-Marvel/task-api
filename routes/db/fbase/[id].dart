import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firestore/firestore.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) {
  return switch (context.request.method) {
    HttpMethod.patch => _updateList(context, id),
    HttpMethod.delete => _deleteList(context, id),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

Future<Response> _updateList(RequestContext context, String id) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final name = body['name'] as String?;
  final list = <String, dynamic>{'name': name};
  await Firestore.instance.collection('tasklists').document(id).update(list);
  return Response(statusCode: HttpStatus.noContent);
}

Future<Response> _deleteList(RequestContext context, String id) async {
  await Firestore.instance
      .collection('tasklists')
      .document(id)
      .delete()
      .then((value) => Response(statusCode: HttpStatus.noContent))
      .onError(
        (error, stackTrace) => Response(statusCode: HttpStatus.badRequest),
      );
  return Response(statusCode: HttpStatus.accepted);
}
