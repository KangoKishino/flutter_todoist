import 'package:uuid/uuid.dart';


class Task {
  String id;
  String name;
  String memo;
  bool isDone;
  final DateTime createdAt;
  DateTime updatedAt;
  DateTime duedate;
  String priority;
  String displaypriority;
  String projectoftaskid;
  String projectoftask;

  Task(
      {this.id,
      this.name,
      this.memo,
      this.isDone = false,
      this.createdAt,
      this.updatedAt,
      this.duedate,
      this.priority,
      this.displaypriority,
      this.projectoftaskid,
      this.projectoftask,});
}




class Project {
  String projectid;
  String projecttitle;
  int projectcolor;
  int displaycolor;
  final DateTime createdAt;
  DateTime updatedAt;

  Project(
    {this.projectid,
    this.projecttitle,
    this.projectcolor,
    this.displaycolor,
    this.createdAt,
    this.updatedAt,});
  // Project.newProject() {
  //   projecttitle = "";
  // }

  // Project clone() {
  //   Project newProject = Project(projecttitle);
  //   newProject.projectid = projectid;
  //   return newProject;
  // }


}