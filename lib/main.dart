import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todoist/screen/add_project_screen/add_project_screen.dart';
import 'package:flutter_todoist/screen/add_project_screen/add_project_color_screen.dart';
import 'package:flutter_todoist/screen/add_task_screen/add_task_screen.dart';
import 'package:flutter_todoist/screen/open_page_screen/open_screen.dart';
import 'package:flutter_todoist/screen/task_screen/task_list_each_project_view.dart';
import 'package:flutter_todoist/screen/task_screen/task_screen.dart';
import 'package:flutter_todoist/view_model/task_view_model.dart';

void main() {
  print('Welcome Yamatatsu Todo App !!!');
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        backgroundColor :Color(0xFFFAFAFA),
        hoverColor: Colors.grey[200],
      ),
      initialRoute: OpenScreen.id,
      routes: {
        OpenScreen.id: (context) => OpenScreen(),
        TaskScreen.id: (context) => TaskScreen(),
        AddTaskScreen.id: (context) => AddTaskScreen(),
        AddProjectScreen.id: (context) => AddProjectScreen(),
        AddProjectColorScreen.id: (context) => AddProjectColorScreen(),
      },
    );
  }
}
