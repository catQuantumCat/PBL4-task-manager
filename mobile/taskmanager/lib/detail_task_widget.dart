import 'package:flutter/material.dart';
import 'package:taskmanager/data/task_model.dart';

class DetailTaskWidget extends StatefulWidget {
  const DetailTaskWidget({super.key, required this.task});

  final TaskModel task;

  @override
  State<DetailTaskWidget> createState() => _DetailTaskWidgetState();
}

class _DetailTaskWidgetState extends State<DetailTaskWidget> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.task.status;
  }

  void _closeDetailTask(context) {
    Navigator.pop(context);
  }

  void _changeTaskStatus(newValue) {
    widget.task.editStatus(newValue);
    setState(() {
      isChecked = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      shouldCloseOnMinExtent: true,
      expand: false,
      maxChildSize: 0.95,
      minChildSize: 0.6,
      initialChildSize: 0.6,
      snap: true,
      snapSizes: const [0.6, 0.95],
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
            children: [
              Text(widget.task.deadTime.toString()),
              Wrap(
                spacing: 12,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(100)),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.more_horiz_outlined,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(100)),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
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
                widget.task.deadTime.toString(),
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
    );
  }
}
