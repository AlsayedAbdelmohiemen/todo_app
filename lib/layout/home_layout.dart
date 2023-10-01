import 'package:flutter/material.dart';
import 'package:todo/moduls/AddTask/add_task.dart';
import 'package:todo/moduls/HomeScreen/home_screen.dart';
import 'package:todo/moduls/settings/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});
  static const String routeName = "home_layout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<Widget> Screens = [HomeScreen(), const SettingsView()];
  int index = 0;
  @override

  Widget build(BuildContext context) {
    List<String> title = ["ToDo", AppLocalizations.of(context)!.settings];
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: Text(title[index],style:Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 35
          )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showAddTask();
          },
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 12,
          color: Colors.blue,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            currentIndex: index,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: "")
            ],
          ),
        ),
        body: Screens[index]);
  }

  Future showAddTask() {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(18), topLeft: Radius.circular(18))),
        context: context,
        builder: (context) {
          return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddTask());
        });
  }
}
