import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_project/firebase_functions/task.dart';

class FirebaseUtils{

 static CollectionReference<Task>createCollection(){

 return FirebaseFirestore.instance.collection('Tasks').withConverter<Task>(
        fromFirestore:(snapshot,options) =>Task.fromJson(snapshot.data()!),
        toFirestore: (task1,options)=>task1.toJson(task1));


 }

 static Future<void>  addToFirestore (Task task){
   DocumentReference<Task>docRef=createCollection().doc();
   task.id=docRef.id;
   return docRef.set(task);

          }

 static Future<void> deleteTasks(Task task){
  return createCollection().doc(task.id).delete();
 }
}






