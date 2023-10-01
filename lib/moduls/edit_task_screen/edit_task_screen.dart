import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/style/theme_style.dart';
import 'package:todo/core/network/firebase/firebase_functions.dart';
import 'package:todo/moduls/model/task_model.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel task;

  const EditTaskScreen({super.key, required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description;
    selectedDate = DateTime.fromMillisecondsSinceEpoch(widget.task.date);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   // var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      backgroundColor: Theme.of(context).canvasColor,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: Theme.of(context).textTheme.bodySmall,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          BorderSide(color: MyTheme.lightTheme.primaryColor)),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: Theme.of(context).textTheme.bodySmall,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          BorderSide(color: MyTheme.lightTheme.primaryColor)),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text(
                    'Date: ${DateFormat.yMd().format(selectedDate)}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 15
                    )
                  ),
                  const SizedBox(width: 23),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: const Text('Change Date'),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Update the taskModel object with new data
                      widget.task.title = titleController.text;
                      widget.task.description = descriptionController.text;
                      widget.task.date = selectedDate.millisecondsSinceEpoch;

                      // Call the updateTask function with the updated task
                      FirebaseFunctions.updateTask(widget.task.id, widget.task);

                      // Navigate back to the previous screen
                      Navigator.of(context).pop();
                    },
                    child: const Text('Save Changes'),
                    style: ElevatedButton.styleFrom(

                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
