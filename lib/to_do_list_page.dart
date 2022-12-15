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
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: ((context, index) {
                return const Text('hello');
              }),
            ),
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
}
