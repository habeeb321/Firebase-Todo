import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoListPage extends StatelessWidget {
  ToDoListPage({super.key});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        centerTitle: true,
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: 'Type here'),
                ),
              ),
              TextButton(
                  onPressed: () {
                    addTask();
                  },
                  child: const Text('Add Task')),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("todos").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Expanded(
                  child: ListView(
                    children: snapshot.data!.docs.map((document) {
                      return Dismissible(
                        key: Key(document.id),
                        onDismissed: (direction) => onDelete(document.id),
                        background: Container(
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            )),
                        child: ListTile(
                          title: Text(document["title"]),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void addTask() {
    FirebaseFirestore.instance.collection("todos").add({
      "title": controller.text,
    });
  }

  void onDelete(String id) {
    FirebaseFirestore.instance.collection("todos").doc(id).delete();
  }
}
