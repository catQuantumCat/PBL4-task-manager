import 'package:flutter/material.dart';
import 'package:taskmanager/data/dummy_data.dart';
import 'task_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  get builder => null;

  @override
  Widget build(BuildContext context) {
    final dummydata = dummyData;

    return Scaffold(
      appBar: AppBar(
          title: const Text('Task Manager'),
          backgroundColor: Colors.blueAccent),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO
          print("pressed");
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        addAutomaticKeepAlives: false,
        itemCount: 10,
        itemBuilder: (_, index) => Dismissible(
          direction: DismissDirection.endToStart,
          background: Container(
            padding: const EdgeInsets.only(right: 20),
            color: Colors.redAccent,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          onDismissed: (_) {
            dummydata.removeAt(index);
          },
          key: Key(dummydata[index].name),
          child: TaskWidget(
            task: dummydata[index],
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
      ),
    );
  }
}
