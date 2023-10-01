import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/network/firebase/firebase_functions.dart';
import 'package:todo/core/style/theme_style.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/moduls/edit_task_screen/edit_task_screen.dart';
import 'package:todo/moduls/model/task_model.dart';
import 'package:todo/moduls/settings/settings_provider/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TaskItem extends StatelessWidget {
  TaskModel taskModel;
  DateTime selectedDate = DateTime.now();

  TaskItem({required this.taskModel, super.key});

  @override
  Widget build(BuildContext context) {
    DateTime taskDateTime = DateTime.fromMillisecondsSinceEpoch(taskModel.date);
    var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context);

    // Format the DateTime as a string
    String formattedDateTime = DateFormat.yMd().format(taskDateTime);
    return Container(

      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
      child: Slidable(
        startActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseFunctions.deleteTask(taskModel.id);
            },
            borderRadius: BorderRadius.circular(15),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: AppLocalizations.of(context)!.delete,
          ),
          SlidableAction(
            onPressed: (context) {
              // Navigate to a screen where the user can edit the task
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditTaskScreen(task: taskModel),
                ),
              );
            },
            borderRadius: BorderRadius.circular(15),
            backgroundColor: MyTheme.lightTheme.primaryColor,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: AppLocalizations.of(context)!.edit,
          ),
        ]),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor ,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 5.0,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: MyTheme.lightTheme.primaryColor,
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel.title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: MyTheme.lightTheme.primaryColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    taskModel.description,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: MyTheme.lightTheme.primaryColor),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 25,
                        color: !provider.isDark()
                            ? Colors.black
                            : Colors.white,
                      ),

                      const SizedBox(
                        height: 4,
                        width: 4.0,
                      ),
                      Text(
                        formattedDateTime,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  taskModel.isDone = !taskModel.isDone;
                  FirebaseFunctions.updateTask(taskModel.id, taskModel);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: taskModel.isDone
                          ? Colors.green
                          : MyTheme.lightTheme.primaryColor,
                      borderRadius: BorderRadius.circular(12.0)),
                  child: const Icon(
                    Icons.check,
                    size: 40,
                    color: Colors.white,
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
