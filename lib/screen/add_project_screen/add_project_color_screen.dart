import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todoist/model/task.dart';
import 'package:flutter_todoist/view_model/task_view_model.dart';

class AddProjectColorScreen extends StatelessWidget {
  static String id = 'add_project_color_screen';
  final Project editProject;
  AddProjectColorScreen({Key key, this.editProject}) : super(key: key);
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
              title: Text(_isEdit() ? 'Sava Project' : 'Add Project'),
            ),
            body: ListView(
              children: <Widget>[
                _buildColorField(context),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _isEdit() {
    return editProject != null;
  }

  void tapAddButton(BuildContext context) {
    // final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    // viewModel.setValidateProject(true);
    // if (viewModel.validateProjectName()) {
    //   _isEdit() ? viewModel.updateProject(editProject) : viewModel.addProject();

       Navigator.of(context).pop();
    // }
  }

  Widget _buildColorField(BuildContext context) {
     final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    return Column(
          children:<Widget>[
            SizedBox(height: 20),
            Container(
              height: 50.0,
              child:Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Colors.pink,
                      shape: CircleBorder(
                      ),
                      onPressed: () { 
                         viewModel.coloringProject(0);
                        tapAddButton(context);}
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.red,
                      shape: CircleBorder(
                      ),
                      onPressed: () { 
                        viewModel.coloringProject(1);
                        tapAddButton(context);},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.orange,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(2);
                        tapAddButton(context);},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.yellow,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(3);
                        tapAddButton(context);},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.lime,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(4);
                        tapAddButton(context);},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.lightGreen,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(5);
                        tapAddButton(context);},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.green,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(6);
                        tapAddButton(context);},
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50.0,
              child:Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Colors.cyan,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(7);
                        tapAddButton(context);},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.teal,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(8);
                        tapAddButton(context);},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.lightBlue,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(9);
                        tapAddButton(context);},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.lightBlueAccent,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(10);
                        tapAddButton(context);},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.blue,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(11);
                        tapAddButton(context);},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.indigo,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(12);
                        tapAddButton(context);},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.purple,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(13);
                        tapAddButton(context);},
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50.0,
              child:Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Colors.pinkAccent,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(14);
                        tapAddButton(context);},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.redAccent,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(15);
                        tapAddButton(context);},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.amber,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(16);
                        tapAddButton(context);},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.grey,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(17);
                        tapAddButton(context);},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.blueGrey,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(18);
                        tapAddButton(context);},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.brown,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(19);
                        tapAddButton(context);},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.white,
                      shape: CircleBorder(
                      ),
                      onPressed: () {
                        viewModel.coloringProject(20);
                        tapAddButton(context);},
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
  }
}
