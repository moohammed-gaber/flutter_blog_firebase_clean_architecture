import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreDocumentModel {
  final String id;
  FirestoreDocumentModel(this.id);
  FirestoreDocumentModel.fromFirestoreDocument(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id;

  Map<String, dynamic> toMap();
}

class FirestoreCrudOperations<T extends FirestoreDocumentModel> {
  FirestoreCrudOperations(
    this.collectionName,
    this.fromFirestore,
  ) {
    collection = FirebaseFirestore.instance.collection(collectionName);
    collectionWithConverter = collection.withConverter<T>(
        fromFirestore: (_, __) => fromFirestore(_),
        toFirestore: (_, __) => _.toMap());
  }

  final T Function(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) fromFirestore;
  final String collectionName;
  late final CollectionReference<T> collectionWithConverter;
  late final CollectionReference<Map<String, dynamic>> collection;

  DocumentReference<Map<String, dynamic>> getDocumentReference(String id) {
    return collection.doc(id);
  }

  //delete collection

  Future deleteAll() async {
    final data = await collection.get();

    final batchArray = <WriteBatch>[];
    batchArray.add(FirebaseFirestore.instance.batch());
    var operationCounter = 0;
    var batchIndex = 0;
    for (var documentData in data.docs) {
      batchArray[batchIndex].delete(documentData.reference);
      operationCounter++;

      if (operationCounter == 499) {
        batchArray.add(FirebaseFirestore.instance.batch());
        batchIndex++;
        operationCounter = 0;
      }
    }
    return Future.wait(batchArray.map((e) => e.commit()).toList());

/*
    final batch = FirebaseFirestore.instance.batch();
    for (int i = 0; i < data.size; i++) {
      final element = data.docs[i];
      batch.delete(element.reference);
    }
    return batch.commit();
*/
  }

  Stream<List<T>> listen() {
    return collectionWithConverter
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  Future<List<T>> getAll() async {
    final result = await collectionWithConverter.get();
    return result.docs.map((e) => e.data()).toList();
  }

  Future<T> add(T data) async {
    final result = await collectionWithConverter.doc(data.id).set(data);
    return data;
  }

  Future<void> delete(String id) async {
    await collectionWithConverter.doc(id).delete();
  }

  Future<void> update(
    T data,
  ) async {
    await collectionWithConverter.doc(data.id).update(data.toMap());
  }

  Future<T?> getOne(
    String id,
  ) async {
    final get = await collectionWithConverter.doc(id).get();
    return get.data();
  }

  Future<DocumentSnapshot<T>> getDocument(
    String id,
  ) async {
    final get = await collectionWithConverter.doc(id).get();
    return get;
  }

  Future addAll(List<T> data) async {
    final batchArray = <WriteBatch>[];
    batchArray.add(FirebaseFirestore.instance.batch());
    var operationCounter = 0;
    var batchIndex = 0;
    for (var documentData in data) {
      batchArray[batchIndex]
          .set(collection.doc(documentData.id), documentData.toMap());
      operationCounter++;

      if (operationCounter == 499) {
        batchArray.add(FirebaseFirestore.instance.batch());
        batchIndex++;
        operationCounter = 0;
      }
    }
    return Future.wait(batchArray.map((e) => e.commit()).toList());

    for (int i = 0; i < batchArray.length; i++) {
      batchArray[i].commit();
    }

/*
    for (var o in batchArray) {
      o.commit();
    }
*/

    // return Future.wait(batchArray.map((e) => e.commit()).toList());
/*
    for (int i = 0; i < batchArray.length; i++) {
      futures.add(batchArray[i].commit());
    }
*/

    /// do this
    // final batch = FirebaseFirestore.instance.batch();
    // for (int i = 0; i < data.length; i++) {
    //   final element = data[i];
    //   batch.set(collection.doc(element.id), element.toMap());
    // }
    // return batch.commit();
    //
    // /// don't do this
    // final List<Future> bulkAdd = [];
    // for (int i = 0; i < data.length; i++) {
    //   final status = data[i];
    //   bulkAdd.add(collectionWithConverter.doc(status.id).set(status));
    // }
    //
    // return Future.wait(bulkAdd);
  }
}
