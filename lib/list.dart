import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todoist/view_model/task_view_model.dart';
import 'package:flutter_todoist/screen/task_screen/task_item.dart';
import 'package:flutter_todoist/screen/task_screen/task_time_item.dart';
import 'package:flutter_todoist/screen/add_task_screen/add_task_screen.dart';

import 'common.dart';

class ListExample extends StatelessWidget {
  static String id = 'list_example';
  const ListExample({
    Key key,
    // this.number,
  }) : super(key: key);
//  final int number;
 

  @override
  Widget build(BuildContext context) {
        
    DateTime listDay(int i){
      var _dateTimeNow = DateTime.now();
      var displayDay  = _dateTimeNow.add(new Duration(days: i));
      return displayDay;
    }
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    if(viewModel.listType == false && viewModel.listTypeToday == false){
    return AppScaffold(
      slivers: <Widget>[
        for(int ii=0; ii<31; ii++)
        _StickyHeaderList(index: listDay(ii))
      ],
    );
    }else {
      return AppScaffold(
      slivers: <Widget>[
        _StickyHeaderList(index: listDay(0))
      ],
    );
    }
    }
}

class _StickyHeaderList extends StatelessWidget {
  const _StickyHeaderList({
    Key key,
    this.index,
  }) : super(key: key);
  final DateTime index;


  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(builder: (context, taskViewModel, _) {
      taskViewModel.listType ? taskViewModel.selectTask() : taskViewModel.selecttimeTask();
      taskViewModel.divisionTask(index);
    return SliverStickyHeader(
      header: Header(index: index),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  taskViewModel.deleteTask(i);
                } else {
                  taskViewModel.toggleDone(i, true);
                }
              },
              background: _buildDismissibleBackgroundContainer(false),
              secondaryBackground: _buildDismissibleBackgroundContainer(true),
              child: 
              taskViewModel.listType == true
              ? TaskItem(
                task: taskViewModel.divisions[i],
                onTap: () {
                  Navigator.of(context).push<dynamic>(
                    MaterialPageRoute<dynamic>(builder: (context) {
                      // taskViewModel.matting(index);
                      var task = taskViewModel.tasks[taskViewModel.matting(i)];
                      taskViewModel.nameController.text = task.name;
                      taskViewModel.selectedItem = task.priority;
                      taskViewModel.dueDate = task.duedate;
                      taskViewModel.selectedProjectId = task.projectoftaskid;
                      taskViewModel.selectedProject = task.projectoftask;
                      taskViewModel.popupItem = task.projectoftaskid;
                      taskViewModel.simpleUpdate();
                      return AddTaskScreen(editTask: task);
                    }),
                  );
                },
                toggleDone: (value) {
                  taskViewModel.toggleDone(i, value);
                },
              )
              : TaskTimeItem(
                task: taskViewModel.divisions[i],
                onTap: () {
                  Navigator.of(context).push<dynamic>(
                    MaterialPageRoute<dynamic>(builder: (context) {
                      // taskViewModel.matting(index);
                      var task = taskViewModel.tasks[taskViewModel.matting(i)];
                      taskViewModel.nameController.text = task.name;
                      taskViewModel.selectedItem = task.priority;
                      taskViewModel.dueDate = task.duedate;
                      taskViewModel.selectedProjectId = task.projectoftaskid;
                      taskViewModel.selectedProject = task.projectoftask;
                      taskViewModel.popupItem = task.projectoftaskid;
                      taskViewModel.simpleUpdate();
                      return AddTaskScreen(editTask: task);
                    }),
                  );
                },
                toggleDone: (value) {
                  taskViewModel.toggleDone(i, value);
                },
              ),
              ),
              childCount: taskViewModel.divisions.length,
        ),
      ),
    );
    }
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
}