import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todoist/model/task.dart';
import 'package:flutter_todoist/view_model/task_view_model.dart';


class ProjectItem extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;



  const ProjectItem(
      {Key key,
      @required this.onTap,
      @required this.project,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(
      builder: (context, taskViewModel,_) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0).copyWith(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.fiber_manual_record,
                    color:taskViewModel.projectColor[(project.displaycolor).toInt()],
                    ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    project.projecttitle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
      }
    );
  }
}
