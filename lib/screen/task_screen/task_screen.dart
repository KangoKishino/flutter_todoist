import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todoist/list.dart';
import 'package:flutter_todoist/screen/add_task_screen/add_task_screen.dart';
import 'package:flutter_todoist/screen/task_screen/task_list_view.dart';
import 'package:flutter_todoist/screen/task_screen/task_list_each_project_view.dart';
import 'package:flutter_todoist/view_model/task_view_model.dart';
import 'package:flutter_todoist/screen/add_project_screen/add_project_screen.dart';

class TaskScreen extends StatelessWidget {


  static String id = 'task_screen';
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        actions:  <Widget>[
            // IconButton(
            //   icon: Icon(Icons.search),
            //   onPressed: () {
            //   },
            // ),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // _onButtonPressed();
                  final viewModel = Provider.of<TaskViewModel>(context, listen: false);
                showModalBottomSheet<void>(
                  context: context,
                  builder: (context) {
                    return Container(
                      color: Color(0xff737373),
                      height: 180,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            if(viewModel.distributenum != null)
                            ListTile(
                              leading: Icon(Icons.edit),
                              title:Text('プロジェクトを編集'),
                              onTap: (){
                                Navigator.of(context).push<dynamic>(
                                  MaterialPageRoute<dynamic>(builder: (context) {
                                    var project = viewModel.projects[viewModel.distributenum];
                                    viewModel.projectController.text = project.projecttitle;
                                    viewModel.numnum = project.displaycolor;
                                    viewModel.colornum = project.projectcolor;
                                    return AddProjectScreen(editProject: project);
                                }),
                              );
                            },
                          ),
                            ListTile(
                          leading: Icon(Icons.edit),
                          title:Text('プロジェクトを編集'),
                          onTap: (){},
                        ),
                            ListTile(
                          leading: Icon(Icons.edit),
                          title:Text('プロジェクトを編集'),
                        onTap: (){},
                      ),
                    ],
                  ),
                 decoration: BoxDecoration(
                   color: Theme.of(context).canvasColor,
                   borderRadius: BorderRadius.only(
                     topLeft: const Radius.circular(10),
                     topRight: const Radius.circular(10),
                   ),
                 ),
                    ),
                  );
                  }
                );
              },
            ),
          ],
      ),
      body: _choiceDisplay(context),
      floatingActionButton:FloatingActionButton(
        onPressed: (){
        Navigator.pushNamed(context, AddTaskScreen.id);
        },
        child: Icon(Icons.add, size: 40),
      ),
    );


  }
     Container _choiceDisplay(BuildContext context){
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    if(viewModel.listType == true && viewModel.listTypeToday == false){
      return Container(
        child: TaskListEachProjectView(),
      );
    }else{
    return Container(
     child: ListExample(),
    );
    }
  }
  
}