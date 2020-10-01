import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_todoist/screen/add_task_screen/add_task_screen.dart';
import 'package:flutter_todoist/screen/task_screen/task_item.dart';
import 'package:flutter_todoist/screen/task_screen/task_time_item.dart';
import 'package:flutter_todoist/view_model/task_view_model.dart';
import 'package:flutter_todoist/main.dart';

class TaskListSearch extends StatelessWidget {
  static String id = 'task_list_each_project_view';
  const TaskListSearch({
    Key key,
    this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(builder: (context, taskViewModel, _) {
      taskViewModel.listType ? taskViewModel.selectTask() : taskViewModel.selecttimeTask();

      if (taskViewModel.selects.isEmpty){
        return _emptyView();
      }

      return ListView.builder(
          itemBuilder: (context, index) {
            var select = taskViewModel.selects[index];
            return 
            //StickyHeader(
        //       header: Container(
        //   height: 40.0,
        //   color: Theme.of(context).backgroundColor,
        //   // padding: EdgeInsets.symmetric(horizontal: 16.0),
        //   alignment: Alignment.centerLeft,
        //   child: Text('Header #$index',
        //     style: const TextStyle(color: Colors.black),
        //   ),
        // ),
             // content: 
              
            Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  taskViewModel.deleteTask(index);
                } else {
                  taskViewModel.toggleDone(index, true);
                }
              },
              background: _buildDismissibleBackgroundContainer(false),
              secondaryBackground: _buildDismissibleBackgroundContainer(true),
              child: 
              taskViewModel.listType == true
              ? TaskItem(
                task: select,
                onTap: () {
                  Navigator.of(context).push<dynamic>(
                    MaterialPageRoute<dynamic>(builder: (context) {
                      // taskViewModel.matting(index);
                      var task = taskViewModel.tasks[taskViewModel.matting(index)];
                      taskViewModel.nameController.text = task.name;
                      taskViewModel.selectedItem = task.priority;
                      taskViewModel.dueDate = task.duedate;
                      taskViewModel.selectedProjectId = task.projectoftaskid;
                      taskViewModel.selectedProject = task.projectoftask;
                      return AddTaskScreen(editTask: task);
                    }),
                  );
                },
                toggleDone: (value) {
                  taskViewModel.toggleDone(index, value);
                },
              )
              : TaskTimeItem(
                task: select,
                onTap: () {
                  Navigator.of(context).push<dynamic>(
                    MaterialPageRoute<dynamic>(builder: (context) {
                      // taskViewModel.matting(index);
                      var task = taskViewModel.tasks[taskViewModel.matting(index)];
                      taskViewModel.nameController.text = task.name;
                      taskViewModel.selectedItem = task.priority;
                      taskViewModel.dueDate = task.duedate;
                      taskViewModel.selectedProjectId = task.projectoftaskid;
                      taskViewModel.selectedProject = task.projectoftask;
                      return AddTaskScreen(editTask: task);
                    }),
                  );
                },
                toggleDone: (value) {
                  taskViewModel.toggleDone(index, value);
                },
              )
            );
           // );
          },
          itemCount: taskViewModel.selects.length
          );

        }   
        );
                FloatingActionButton(
        onPressed: (){
        //  Navigator.pushNamed(context, AddTaskScreen.id);
        Navigator.pushNamed(context, AddTaskScreen.id);
        },
        child: Icon(Icons.add, size: 40),
      );
    
  }

  Container _buildDismissibleBackgroundContainer(bool isSecond) {
    return Container(
      color: isSecond ? Colors.red : Colors.green,
      alignment: isSecond ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          isSecond ? 'Delete' : 'Done',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

    Container header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      color: Colors.blueGrey[700],
      child: Text(
        'Header',
        style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _emptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("You don't have a task!!!"),
          SizedBox(height: 16),
          Text(
            'Complete!!!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }
}
