import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:flutter_todoist/list.dart';
import 'package:flutter_todoist/screen/task_screen/task_list_each_project_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_todoist/screen/task_screen/task_screen.dart';
import 'package:flutter_todoist/screen/add_task_screen/add_task_screen.dart';
import 'package:flutter_todoist/screen/add_project_screen/add_project_screen.dart';
import 'package:flutter_todoist/view_model/task_view_model.dart';
import 'package:flutter_todoist/screen/open_page_screen/project_item.dart';

import '../task_screen/task_list_view.dart';


class OpenScreen extends StatelessWidget{
     OpenScreen({
    Key key,
  }) : super(key: key);

static String id = 'open_screen';
  bool visibilityProject = true;
  bool visibilityLabel = false;



  @override
  Widget build(BuildContext context){


    return Scaffold(
      appBar: AppBar(title: Text('Open Screen')),
      body:
         ListView(
          children: [
            Container(
              height: 70.0,
              child: ListTile(
                leading: Icon(Icons.inbox,
                color: Colors.blue,
                ),
                title: Text("インボックス",
                style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  final viewModel = Provider.of<TaskViewModel>(context, listen: false);
                   viewModel.listType = true;
                   viewModel.listTypeToday = false;
                   viewModel.distributer = null;
                   viewModel.distributenum = null;
                  Navigator.pushNamed(context, TaskScreen.id);
                },
              ),
            ),
            Divider(height: 1.0),
            Container(
              height: 70.0,
              child:ListTile(
                leading: Icon(Icons.today,
                color: Colors.green),
                title: Text("今日",
                style: TextStyle(fontWeight: FontWeight.bold),),
                onTap: () {
                  final viewModel = Provider.of<TaskViewModel>(context, listen: false);
                  viewModel.listType = false;
                  viewModel.listTypeToday = true;
                  Navigator.pushNamed(context, TaskScreen.id);
                },
              ),
            ),
            Divider(height: 1.0),
        //     Container(
        //       height:70.0,
        //       child:ListTile(
        //         leading: Icon(Icons.calendar_today,
        //         color: Colors.purple,),
        //         title: Text("近日予定",
        //         style: TextStyle(fontWeight: FontWeight.bold),),
        //         onTap: (){
        //           final viewModel = Provider.of<TaskViewModel>(context, listen: false);
        //           viewModel.listType = false;
        //           viewModel.listTypeToday = false;
        //           Navigator.pushNamed(context, TaskScreen.id);
        //         },
        //       ),
        //     ),
        // Divider(height: 1.0),
      Consumer<TaskViewModel>(builder: (context, taskViewModel, _) {
        return Container(
          color: taskViewModel.whichProject(context),
              height: 70.0,
              child:ListTile(
                //leading: Icon(Icons.calendar_today),
                title: Text("プロジェクト",
                style: TextStyle(fontWeight: FontWeight.bold),),
                onTap: () {
                  final viewModel = Provider.of<TaskViewModel>(context, listen: false);
                  viewModel.moveProject();
               //   viewModel.rotationObject();
                },
                trailing: Wrap(
    spacing: 12, // space between two icons
    children: <Widget>[
(taskViewModel.visibilityProject == true)
? SizedBox(
  height: 50,
  width: 50,
  child: 
RotationTransition(
  turns: new AlwaysStoppedAnimation(90 / 360),
  child: Icon(Icons.arrow_forward_ios),
),
)
: SizedBox(
  height: 50,
  width: 50,
  child: 
       RotationTransition(
  turns: new AlwaysStoppedAnimation(180 / 360),
  child: Icon(Icons.arrow_forward_ios),
),
),
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddProjectScreen.id);
        },
      ), // icon-2
    ],
  ),
              ),
            );
            }),
            Divider(height: 1.0),
   _projectList(context),
          ],
      ),
      
            floatingActionButton: FloatingActionButton(
        onPressed: (){
        Navigator.pushNamed(context, AddTaskScreen.id);
        },
        child: Icon(Icons.add, size: 40),
      ),
     );
  }

    Widget _projectList(BuildContext context) {
      final viewModel = Provider.of<TaskViewModel>(context, listen: true);
      return AnimatedContainer(
      height:viewModel.visibilityProject ? (viewModel.projects.length)*70.0 + 70.0 : 0.0,
      duration: Duration(milliseconds: 300.round()),
      child:
      Consumer<TaskViewModel>(builder: (context, taskViewModel, _) {
      if (taskViewModel.projects.isEmpty){ 
       return Container(
              height: 70.0,
              child:ListTile(
                leading: Text("➕"),
                title: Text("プロジェクトを追加",
                style: TextStyle(
                  color: Colors.black
                ),),
                onTap: () {
                    Navigator.pushNamed(context, AddProjectScreen.id);
                },
              ),
            );
      }
      else
      return Container(
        height: 70,
        child: ListView.separated(
          itemBuilder: (context, index) {
            var project = taskViewModel.projects[index];
            return Dismissible(
              key: UniqueKey(),
              child: ProjectItem(
                project: project,
                onTap: () {
                  // taskViewModel.listType = true;
                                     viewModel.listType = true;
                   viewModel.listTypeToday = false;
                   viewModel.distributer = null;
                   viewModel.distributenum = null;
                  taskViewModel.distributeProject(index);
                  Navigator.pushNamed(context, TaskScreen.id);
                },
              ),
            );
          },
          separatorBuilder: (_, __) => Divider(),
          itemCount: taskViewModel.projects.length
          ),
      );
      // ListView.builder(
      //   itemCount:0,
      //   //scrollDirection: Axis.vertical,
      //   itemBuilder: (BuildContext context, int index) {
      //     //   if (homePageKey.currentState.projectBox[index] == 'true') {
      //     return Column(
      //       children:<Widget>[
      //         Container(
      //           height: 70.0,
      //           padding: const EdgeInsets.all(20.0),
      //           alignment: Alignment.centerLeft,
      //           child:Text("hello!",
      //           ),
      //         ),
      //         Divider(height: 0.0),
      //       ],
      //     );
      //     //  } else {
      //     //   return Container();
      //     // }
      //   },
      // ),
    }),

    );
  }

}

class SomeOtherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
    );
  }
}