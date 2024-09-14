import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/data/task_model.dart';
import 'package:taskmanager/presentation/home/bloc/detail/detail_home.bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DetailTaskModal extends StatefulWidget {
  const DetailTaskModal({super.key, required this.task});

  final TaskModel task;

  @override
  State<DetailTaskModal> createState() => _DetailTaskModalState();
}

class _DetailTaskModalState extends State<DetailTaskModal> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.task.status;
  }

  void _changeTaskStatus(newValue) {
    widget.task.editStatus(newValue);
    setState(() {
      isChecked = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailHomeBloc(),
      child: DraggableScrollableSheet(
        shouldCloseOnMinExtent: true,
        expand: false,
        maxChildSize: 0.95,
        minChildSize: 0.6,
        initialChildSize: 0.601,
        snap: true,
        snapSizes: const [0.601, 0.95],
        builder: (context, scrollController) => ListView(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: 6,
                  width: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(DateFormat("dd/MM/yyyy | HH:mm")
                    .format(widget.task.createTime)),
                Wrap(
                  children: [
                    IconButton.filled(
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(4),
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        color: Colors.deepPurple[100],
                      ),
                    ),
                    IconButton.filled(
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(4),
                      onPressed: () {
                        if (context.mounted) {
                          Navigator.pop(context);
                          context.read<DetailHomeBloc>().add(DetailHomeClose());
                        }
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Colors.deepPurple[100],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    value: isChecked,
                    onChanged: (bool? value) {
                      _changeTaskStatus(value!);
                    }),
                Expanded(
                    child: Text(widget.task.name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500))),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.access_time_filled, size: 24),
                const SizedBox(width: 8),
                Text(
                  DateFormat("dd/MM/yyyy | HH:mm").format(widget.task.deadTime),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextFormField(
              maxLines: null,
              minLines: 6,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
              ),
              initialValue: widget.task.description,
              readOnly: true,
            )
          ],
        ),
      ),
    );
  }
}
