import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firedart.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _getLists(context),
    HttpMethod.post => _createList(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

Future<Response> _getLists(RequestContext context) async {
  final list = <Map<String, dynamic>>[];

  await Firestore.instance.collection('tasklists').get().then((event) {
    for (var doc in event) {
      list.add(doc.map);
    }
  });
  return Response.json(body: list.toString());
}

Future<Response> _createList(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;

  final name = body['name'] as String?;

  final list = <String, dynamic>{'name': name};

  final id = await Firestore.instance
      .collection('tasklists')
      .add(list)
      .then((doc) => doc.id);
  return Response.json(body: {'id': id});
}
