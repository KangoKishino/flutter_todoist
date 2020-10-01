import 'package:flutter/material.dart';
import 'package:flutter_todoist/model/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final Function(bool) toggleDone;

  const TaskItem(
      {Key key,
      @required this.onTap,
      @required this.task,
      @required this.toggleDone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0).copyWith(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
                        Expanded(
              flex: 2,
              child: 
            Checkbox(
                  value: task.isDone,
                  onChanged: (value) {
                    print(value);
                    toggleDone(value);
                  },
                activeColor: Colors.lightGreen,
                ),
                        ),
            Expanded(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    task.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  (task?.projectoftask?.isEmpty ?? true)
                      ? Container()
                      : Text(
                              task.duedate.toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.body1,
                  ),
                        //(taskViewModel.listType == true)

                ],
              ),
            ),
          ],
          
          
        )
      ),
    );
  }
}
