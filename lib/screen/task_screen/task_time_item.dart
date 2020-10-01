import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todoist/model/task.dart';
import 'package:flutter_todoist/view_model/task_view_model.dart';


class TaskTimeItem extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final Function(bool) toggleDone;
  

  const TaskTimeItem(
      {Key key,
      @required this.onTap,
      @required this.task,
      @required this.toggleDone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
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
              child: Checkbox(
                  value: task.isDone,
                  onChanged: (value) {
                    print(value);
                    toggleDone(value);
                  },
                activeColor: Colors.lightGreen,
                ),
                        ),
           // Flexible(
              //child: 
                          Expanded(
              flex: 8,
              child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    task.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline,
                  ),
                  Row(
                    children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    color: viewModel.compareTime(task.duedate),
                    size: 14.0,
                  ),
                  (viewModel.compareDay(task.duedate))
                  ? Container()
                  : Text(
                    '${task.duedate.month.toString()}月${task.duedate.day.toString()}日 ',
                    style: TextStyle(
                              color: viewModel.compareTime(task.duedate),
                              fontSize: 10.0,
                              )
                  ),
                        Text(
                          '${task.duedate.hour.toString()}:${task.duedate.minute.toString()} ',
                              // task.duedate.toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                              color: viewModel.compareTime(task.duedate),
                              fontSize: 10.0,
                              )
                  ),
                    ],
                    ),
                ],
              ),
                          ),        
           // ),
            Expanded(
              flex: 4,
              child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 23.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    (task?.projectoftask?.isEmpty ?? true)
                ? Container()
                : Column(
                    children: <Widget>[
                      SizedBox(height: 4),
                      Text(
                        task.projectoftask,
                        maxLines: 3,
                        
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                    (viewModel.setColor(task.projectoftaskid) == null)
                ? Icon(
                    Icons.inbox,
                    color: Colors.blue,
                    size: 10.0,
                  )
                : Icon(
                    Icons.fiber_manual_record,
                    color:viewModel.projectColor[(viewModel.setColor(task.projectoftaskid))],
                    size: 10.0,
                    ),
                  ],
              )
                
          ],
        ),
            ),   
          ],
        ),
      ),
    );
  }
}
