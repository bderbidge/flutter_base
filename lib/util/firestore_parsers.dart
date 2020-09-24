import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreParser<T> {
  List<T> parse(QuerySnapshot querySnapshot, Function fromJson) {
    return querySnapshot.docs.map((documentSnapshot) {
      T data = fromJson(documentSnapshot.data(), documentSnapshot.id);
      return data;
    }).toList();
  }

  T parseIndividual(DocumentSnapshot document, Function fromJson) {
    T user = fromJson(document.data(), document.id);
    return user;
  }
}
