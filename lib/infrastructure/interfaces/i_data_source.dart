import "dart:async";

enum WhereQueryType {
  IsEqualTo,
  IsLessThan,
  IsLessThanOrEqualTo,
  IsGreaterThan,
  IsGreaterThanOrEqualTo,
  ArrayContains,
  ArrayContainsAny,
  WhereIn,
  IsNull
}

abstract class IDataSource {
  delete(String path, String id);

  update(String path, String id, Map<String, dynamic> data);

  Future<String> create({String id, String path, Map<String, dynamic> data});

  Future<T> getSingle<T>(String path, String id, Function fromJson);

  Future<List<T>> getCollection<T>(String path, Function fromJson);

  Future<List<T>> getCollectionwithParams<T>(String path, Function fromJson,
      {Map<String, dynamic> wheremap,
      Map<String, WhereQueryType> compare,
      Map<String, bool> orderby,
      int limit,
      String startAfterID});

  Stream<List<T>> getCollectionStreamWithParams<T>(
      String path, Function fromJson,
      {Map<String, dynamic> wheremap,
      Map<String, WhereQueryType> compare,
      Map<String, bool> orderby,
      int limit});

  onError(e);
}
