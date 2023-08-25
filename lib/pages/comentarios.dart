import 'package:arsim/read%20data/get_comentarios.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ComentPage extends StatefulWidget {
  const ComentPage({super.key});

  @override
  State<ComentPage> createState() => _ComentPageState();
}

class _ComentPageState extends State<ComentPage> {
  List<String> docs = [];
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('comentarios').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference.id);
            docs.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comentarios',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 139, 187, 231),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(
                                    255, 173, 214, 244), // Celeste claro
                                Color.fromARGB(
                                    255, 22, 109, 189), // Celeste medio
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: GetComentarios(documentId: docs[index]),
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
