import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/data/task_model.dart';

class NewTaskWidget extends StatefulWidget {
  const NewTaskWidget({super.key});

  @override
  State<NewTaskWidget> createState() => _NewTaskWidgetState();
}

class _NewTaskWidgetState extends State<NewTaskWidget> {
  DateTime? selectedDate;

  Future _showDatePicker() async {
    selectedDate = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2026));
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      shouldCloseOnMinExtent: true,
      expand: false,
      maxChildSize: 0.95,
      minChildSize: 0.6,
      initialChildSize: 0.95,
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: TextField()),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.access_time_filled, size: 24),
              SizedBox(width: 8),
              IconButton(
                  onPressed: _showDatePicker,
                  icon: const Icon(Icons.access_time_filled, size: 24))
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
          )
        ],
      ),
    );
  }
}
