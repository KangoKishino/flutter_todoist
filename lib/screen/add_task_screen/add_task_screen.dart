import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_todoist/model/task.dart';
import 'package:flutter_todoist/view_model/task_view_model.dart';
import 'package:flutter_todoist/screen/open_page_screen/project_item.dart';

import '../../model/task.dart';

class AddTaskScreen extends StatefulWidget{
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
final Task editTask;
  AddTaskScreen({Key key, this.editTask}) : super(key: key);
  static String id = 'add_task_screen';
    
}

class _AddTaskScreenState extends State<AddTaskScreen> {
   final DateFormat _format = DateFormat("yyyy-MM-dd HH:mm");
  


      List<String> _idlist = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(
      builder: (context, viewModel, _) {
        return WillPopScope(
          onWillPop: () async {
            viewModel.clear();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(_isEdit() ? 'Save Task' : 'Add Task'),
            ),
            body: SingleChildScrollView(
              child: Column(
              children: <Widget>[
                _buildInputField(
                  context,
                  title: 'Name',
                  textEditingController: viewModel.nameController,
                  errorText:
                      viewModel.validateName ? viewModel.strValidateName : null,
                  didChanged: (_) {
                   viewModel.updateValidateName();
                  },
                ),
                _buildInputField(
                  context,
                  title: 'Memo',
                  textEditingController: viewModel.memoController,
                  errorText: null,
                ),
                _buildDueDateTimeField(),
                _buildproject(context),
                _buildpriority(context),
                _buildAddButton(context),
              ],
              ),
            ),
          ),
        );
      },
    );
  }


  bool _isEdit() {
    return widget.editTask != null;
  }

  void tapAddButton(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    viewModel.setValidateName(true);
    if (viewModel.validateTaskName()) {
      _isEdit() ? viewModel.updateTask(widget.editTask) : viewModel.addTask();
      Navigator.of(context).pop();
    }
  }

  Widget _buildpriority(BuildContext context) {
    final singleSelectCountry = Provider.of<TaskViewModel>(context, listen: false);
    // return Consumer<TaskViewModel>(
    //   builder: (
    //     context,
    //     final TaskViewModel singleSelectCountry,
    //     final Widget child,
    //   ) {
        return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
                    Text(
            "優先度",
            style: Theme.of(context).textTheme.subtitle,
          ),
          DropdownButton<String>(
          hint: const Text("優先度"),
          value: singleSelectCountry.visibleItem, // dropdownbuttonの表示部分
          onChanged: (final String newValue) {
            singleSelectCountry.choicingPriority = newValue; // dropdownbuttonの選択
            singleSelectCountry.simpleUpdate();
          },
          items: singleSelectCountry.items.map<DropdownMenuItem<String>>( // アイテムの種類をゲット
            (final String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
          
        ),
                ],
      ),
    );
    //   },
    // );
  }

    Widget _buildproject(BuildContext context) {
      return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
                    Text(
            "プロジェクト",
            style: Theme.of(context).textTheme.subtitle,
          ),
    //       Container(
    //     height: 200,
    //     child: Consumer<TaskViewModel>(builder: (context, taskViewModel, _) {
    //   if (taskViewModel.projects.isEmpty) {
    //     return _emptyView();
    //   }
    //   return ListView.separated(
    //       itemBuilder: (context, index) {
    //         var project = taskViewModel.projects[index];
    //         return Dismissible(
    //           key: UniqueKey(),
    //         //  background: _buildDismissibleBackgroundContainer(false),
    //         //  secondaryBackground: _buildDismissibleBackgroundContainer(true),
    //           child: ProjectItem(
    //             project: project,
    //             onTap: () {
    //               taskViewModel.selectedProject = project.projecttitle;
    //               taskViewModel.selectedProjectId = project.projectid;
    //             },
    //           ),
    //         );
    //       },
    //       separatorBuilder: (_, __) => Divider(),
    //       itemCount: taskViewModel.projects.length);
    // }),
    // ),
    Container(
        height: 50,
        child: 
    Consumer<TaskViewModel>(builder: (context, taskViewModel, _) {
      taskViewModel.addDropitems();
      _idlist = taskViewModel.iddropitems;
    return
    DropdownButton<String>(
          hint: Text("プロジェクト"),
          value: taskViewModel.popupItem, // dropdownbuttonの表示部分
          onChanged: (String newValue) {
           taskViewModel.setstateProject(newValue);
          // taskViewModel.choicingItem = newValue;
          // taskViewModel.selectedProject = taskViewModel.peggingProject(newValue);
          // taskViewModel.selectedProjectId = newValue;
          },
           items: _idlist.map<DropdownMenuItem<String>>( // アイテムの種類をゲット
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: 
                Row(children: <Widget>[
                Text(taskViewModel.peggingProject(value)),
                ],)
              );
            },
          ).toList(),
    );
          }),
          ),
    ],
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

  Widget _buildInputField(BuildContext context,
      {String title,
      TextEditingController textEditingController,
      String errorText,
      Function(String) didChanged}) {
        
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle,
          ),
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(errorText: errorText),
            onChanged: (value) {
              setState(() {
              didChanged(value);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDueDateTimeField(){
      return Consumer<TaskViewModel>(builder: (context, taskViewModel, _){
          return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
                    Text(
            "締切日",
            style: Theme.of(context).textTheme.subtitle,
          ),
          DateTimeField(
          format: _format,
          //decoration: InputDecoration(labelText: "締切日"),
          initialValue: taskViewModel.dueDate ?? DateTime.now(),
          onChanged: taskViewModel.setDueDate,
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime(2000),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100)
            );
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(
                currentValue ?? DateTime.now()
              ),
            );
          return DateTimeField.combine(date, time);
          }else {
            return currentValue;
          }
        }
        ),
        ],
      ),
    );
      }
    );
  }
   
  Widget _buildAddButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: RaisedButton(
        onPressed: () => tapAddButton(context),
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            _isEdit() ? 'Save' : 'Add',
            style:
                Theme.of(context).textTheme.title.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
