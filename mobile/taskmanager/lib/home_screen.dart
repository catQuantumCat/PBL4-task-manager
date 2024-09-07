import 'package:flutter/material.dart';
import 'detail_task_widget.dart';
import 'task_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dummydata = List<String>.generate(10, (i) => 'Item ${i + 1}');

    return Scaffold(
      appBar: AppBar(
          title: const Text('Task Manager'),
          backgroundColor: Colors.blueAccent),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext contex) => DetailTaskWidget(),
          );
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
          key: Key(dummydata[index]),
          child: TaskWidget(
            title: dummydata[index],
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
      ),
    );
  }
}
