import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/network/firebase/firebase_functions.dart';
import 'package:todo/core/style/theme_style.dart';
import 'package:todo/task_item_widget/task_item.dart';
import 'package:provider/provider.dart';
import 'package:todo/moduls/settings/settings_provider/settings_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var theme = Theme.of(context);

    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(const Duration(days: 30)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) {
            selectedDate = date;
            setState(() {});
          },
          leftMargin: 20,
          monthColor: !provider.isDark() ? Colors.black : Colors.white,
          dayColor: !provider.isDark() ? Colors.black : Colors.white,
          activeDayColor: MyTheme.lightTheme.primaryColor,
          activeBackgroundDayColor: Colors.white,
          dotsColor: MyTheme.lightTheme.primaryColor,
          selectableDayPredicate: (date) =>
              date.isAfter(DateTime.now().subtract(const Duration(days: 30))) &&
              date.isBefore(DateTime.now().add(const Duration(days: 365))),
          locale: 'en_ISO',
        ),
        StreamBuilder(
          stream: FirebaseFunctions.getTasks(selectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            var tasks = snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
            if (tasks.isEmpty) {
              return const Center(
                  child: Text("you do not have tasks",
                      style: TextStyle(fontSize: 24)));
            }
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => TaskItem(
                  taskModel: tasks[index],
                ),
                itemCount: tasks.length,
              ),
            );
          },
        )
      ],
    );
  }
}
