import 'package:arsim/components/progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetComentarios extends StatelessWidget {
  final String documentId;

  GetComentarios({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference coments =
        FirebaseFirestore.instance.collection('comentarios');

    return FutureBuilder<DocumentSnapshot>(
      future: coments.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text('Reseña: ${data['resena']}');
        }
        return Text('Cargando.....');
      }),
    );
  }
}
