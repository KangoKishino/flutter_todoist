import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todoist/model/task.dart';
import 'package:flutter_todoist/view_model/task_view_model.dart';
import 'package:flutter_todoist/screen/add_project_screen/add_project_color_screen.dart';
import 'package:flutter_todoist/screen/open_page_screen/open_screen.dart';

class AddProjectScreen extends StatelessWidget {
  static String id = 'add_project_screen';
  final Project editProject;
  AddProjectScreen({Key key, this.editProject}) : super(key: key);
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
          automaticallyImplyLeading: false,
              title: // Text(_isEdit() ? 'Save Project' : 'Add Project'),
              Row(
                children:[
                  FlatButton(
                    child: Text("キャンセル",
                      style: TextStyle(
                        color: Colors.white,
                      //  fontSize: 15,
                      ),
                    ),
                    onPressed: () {
                      viewModel.projectclear();
                      Navigator.of(context).pop();
                    },
                  ),

              Center(
                child:
                Text(_isEdit() ? '新しいプロジェクト':'プロジェクトを編集',
                style: TextStyle(
                 // fontSize: 15,
                ),
              ),
              ),
        ],
              ),
            ),
            body: ListView(
              children: <Widget>[
                _buildInputField(
                  context,
                  title: 'Name',
                  textEditingController: viewModel.projectController,
                  errorText:
                      viewModel.validateProject ? viewModel.strValidateProject : null,
                  didChanged: (_) {
                    viewModel.updateValidateProject();
                  },
                ),
                _buildColorField(context),
                _buildAddButton(context),
                if(_isEdit() == true)
                _buildDeleteButton(context),
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
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    viewModel.setValidateProject(true);
    if (viewModel.validateProjectName()) {
      _isEdit() ? viewModel.updateProject(editProject) : viewModel.addProject();
      Navigator.of(context).pop();
    }
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
              didChanged(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildColorField(BuildContext context) {
    return Consumer<TaskViewModel>(
      builder: (
        context,
        final TaskViewModel singleSelectCountry,
        final Widget child,
      ) {
    return Container(
              height: 70.0,
              child: ListTile(
                leading: Icon(Icons.color_lens),
                title: Text("色",
                  //style: TextStyle(fontSize: 24),
                ),
                onTap: () {
                //  _awaitReturnValueFromSecondScreen(context);
                },
                trailing:RaisedButton(
                    color: singleSelectCountry.projectColor[(singleSelectCountry.colornum).toInt()],
                    shape: CircleBorder(
                    ),
                    onPressed: () {
                  Navigator.pushNamed(context, AddProjectColorScreen.id);
                    },
                  ),
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

    Widget _buildDeleteButton(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: RaisedButton(
        onPressed: () {
                  viewModel.deleteInTask(viewModel.distributenum);
                  viewModel.projectclear();
                  viewModel.deleteProject(viewModel.distributenum);
                  Navigator.pushNamed(context, OpenScreen.id);
        },
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            "プロジェクトを削除",
            style:
                Theme.of(context).textTheme.title.copyWith(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
