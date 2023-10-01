import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/core/network/firebase/firebase_functions.dart';
import 'package:todo/core/style/theme_style.dart';
import 'package:todo/moduls/model/task_model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var formKey = GlobalKey<FormState>();
  DateTime selectDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 35,
          ),
          Text(
            "Add New Task",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: titleController,
            validator: (value) {
              if (value!.toString().length < 4) {
                return " Please enter title at least 4 char";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "enter your title",
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
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: "enter your description",
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
          Text(
            "select Time",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Text(
                  DateFormat.Md().format(selectDate).toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                )),
          ),
          const SizedBox(
            height: 12,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  TaskModel task = TaskModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      date: DateUtils.dateOnly(selectDate)
                          .millisecondsSinceEpoch);
                  FirebaseFunctions.addTask(task);
                  Navigator.pop(context);
                }
              },
              child: const Text("add Task"),
            ),
          )
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    var data = DateTime.now();

    var selected = await showDatePicker(
        context: context,
        initialDate: selectDate,
        firstDate: DateTime.now(),
        lastDate: data.add(const Duration(days: 365)));
    if (selected == null) {
      selectDate = DateTime.now();
    } else {
      selectDate = selected;
      selectDate = selectDate;
    }

    setState(() {});
  }
}
