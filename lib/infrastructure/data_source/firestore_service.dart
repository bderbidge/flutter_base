import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base/infrastructure/interfaces/i_data_source.dart';
import "dart:async";

import 'package:flutter_base/util/firestore_parsers.dart';

// Cloud Firestore
class FirestoreService implements IDataSource {
  FirestoreService({@required FirebaseFirestore db}) : _db = db;
  final FirebaseFirestore _db;

  Future<T> getSingle<T>(String path, String id, Function fromJson) async {
    var ref = firestoreRef(path, id);
    var parser = FirestoreParser<T>();
    var document = await ref.get();
    return parser.parseIndividual(document, fromJson);
  }

  Future<List<T>> getCollection<T>(String path, Function fromJson) async {
    var collectionReference = _db.collection(path);
    var snapshots = collectionReference
        .get()
        .then((snapshot) => FirestoreParser<T>().parse(snapshot, fromJson));
    return snapshots;
  }

//where map and compare have the same keys
  Future<List<T>> getCollectionwithParams<T>(String path, Function fromJson,
      {Map<String, dynamic> wheremap,
      Map<String, WhereQueryType> compare,
      Map<String, bool> orderby,
      int limit,
      String startAfterID}) async {
    DocumentSnapshot startAfter;
    if (startAfterID != null) {
      startAfter = await firestoreRef(path, startAfterID).get();
    }
    var collectionReference = queryConstruction(path, fromJson,
        wheremap: wheremap,
        compare: compare,
        orderby: orderby,
        limit: limit,
        startAfter: startAfter);
    var doc = await collectionReference.get().catchError(onError);
    return FirestoreParser<T>().parse(doc, fromJson);
  }

  Stream<List<T>> getCollectionStreamWithParams<T>(
      String path, Function fromJson,
      {Map<String, dynamic> wheremap,
      Map<String, WhereQueryType> compare,
      Map<String, bool> orderby,
      int limit}) {
    var collectionReference = queryConstruction(
      path,
      fromJson,
      wheremap: wheremap,
      compare: compare,
      orderby: orderby,
      limit: limit,
    );
    Stream<QuerySnapshot> snapshots =
        collectionReference.snapshots().handleError(onError);
    return snapshots
        .map((snapshot) => FirestoreParser<T>().parse(snapshot, fromJson));
  }

  Query queryConstruction(String path, Function fromJson,
      {Map<String, dynamic> wheremap,
      Map<String, WhereQueryType> compare,
      Map<String, bool> orderby,
      int limit,
      DocumentSnapshot startAfter}) {
    Query query = _db.collection(path);
    wheremap.forEach((key, value) {
      var op = compare[key];
      switch (op) {
        case WhereQueryType.IsEqualTo:
          query = query.where(key, isEqualTo: value);
          break;
        case WhereQueryType.IsLessThan:
          query = query.where(key, isLessThan: value);
          break;
        case WhereQueryType.IsLessThanOrEqualTo:
          query = query.where(key, isLessThanOrEqualTo: value);
          break;
        case WhereQueryType.IsGreaterThan:
          query = query.where(key, isGreaterThan: value);
          break;
        case WhereQueryType.IsGreaterThanOrEqualTo:
          query = query.where(key, isGreaterThanOrEqualTo: value);
          break;
        case WhereQueryType.ArrayContains:
          query = query.where(key, arrayContains: value);
          break;
        case WhereQueryType.ArrayContainsAny:
          query = query.where(key, arrayContainsAny: value);
          break;
        case WhereQueryType.WhereIn:
          query = query.where(key, whereIn: value);
          break;
        case WhereQueryType.IsNull:
          query = query.where(key, isNull: value);
          break;
        default:
          break;
      }
    });

    if (orderby != null) {
      orderby.forEach((key, value) {
        query = query.orderBy(key, descending: value);
      });
    }

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    return query;
  }

  //Post functions

  Future<String> create(
      {String id, String path, Map<String, dynamic> data}) async {
    if (id != null) {
      await firestoreRef(path, id).set(data);
      return null;
    } else {
      var ref = await _db.collection(path).add(data);
      return ref.id;
    }
  }

  //Put functions

  update(String path, String id, Map<String, dynamic> data) async {
    await firestoreRef(path, id).update(data);
  }

  //Delete functions

  delete(String path, String id) async {
    await firestoreRef(path, id).delete();
  }

  onError(e) {
    print(e);
  }

  DocumentReference firestoreRef(String path, String id) {
    if (id.isNotEmpty) {
      return _db.collection(path).doc(id);
    }
    return null;
  }
}
