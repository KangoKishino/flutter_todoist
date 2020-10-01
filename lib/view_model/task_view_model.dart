import 'dart:collection';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_todoist/model/task.dart';

import '../model/task.dart';

class TaskViewModel extends ChangeNotifier { // UnmodifiableListViewで使用されるリスト
  
  final List<String> _items = <String>[
    "優先度1",
    "優先度2",
    "優先度3",
    "優先度4",
  ];

  List<String> dropitems = [];
  List<String> iddropitems = [];




    List<Color> projectColor = [
    Colors.pink,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.lime,
    Colors.lightGreen,
    Colors.green,
    Colors.cyan,
    Colors.teal,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pinkAccent,
    Colors.redAccent,
    Colors.amber,
    Colors.grey,
    Colors.blueGrey,
    Colors.brown,
    Colors.white,
  ];



  String get editingName => nameController.text;
  String get editingMemo => memoController.text;
  TextEditingController nameController = TextEditingController();
  TextEditingController memoController = TextEditingController();
  String _strValidateName = '';
  String get strValidateName => _strValidateName;
  bool _validateName = false;
  bool get validateName => _validateName;
  String get choicingPriority => priorityController; //dropdownbuttonで選択されたものがpriorityControllerに送られる
  String selectedItem = null; // 実際に選択された優先度
  String visibleItem = null; //　表示させる用の見せかけ優先度
  String selectedProject = "インボックス";
  String selectedProjectId = null;
  DateTime dueDate = DateTime.now();
  int projectoftaskColor;
  String popupItem = null;
  String get choicingItem => projectitemController; //dropdownbuttonで選択されたものがpriorityControllerに送られる


  String distributer = null;
  int distributenum = null;
  bool listType;// true->project
  bool listTypeToday;// true->today
  static DateTime _dateTimeNow = DateTime.now();
  final today = DateTime(_dateTimeNow.year,_dateTimeNow.month,_dateTimeNow.day);
  bool visibilityProject = true;
  double radians = pi/2;
 
  // project版
  String get editingProject => projectController.text;
  TextEditingController projectController = TextEditingController();
  String _strValidateProject = '';
  String get strValidateProject => _strValidateProject;
  bool _validateProject = false;
  bool get validateProject => _validateProject;
  // int _colornum = 17;
  int colornum = 17;
  int numnum = 17;


  final List<DateTime> times = <DateTime>[
  DateTime(_dateTimeNow.year,_dateTimeNow.month,_dateTimeNow.day),
];


  List<Task> _tasks = [];
  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  UnmodifiableListView<String> get items {
    return UnmodifiableListView(this._items); // dropdownbuttonのリストをitems:へ返す
  }

  List<Project> _projects = [];// project作成用
  UnmodifiableListView<Project> get projects {
    return UnmodifiableListView(_projects);
  }

  List<Task> _selects = [];
  UnmodifiableListView<Task> get selects {
    return UnmodifiableListView(_selects);
  }

    List<Task> _divisions = [];
  UnmodifiableListView<Task> get divisions {
    return UnmodifiableListView(_divisions);
  }

  

  // final List<String> _taspro = <String>[];// taskのproject項目用
  // UnmodifiableListView<String> get taspro {
  //   return UnmodifiableListView(this._taspro);
  // }

  // final List<int> _
  // UnmodifiableListView<int> get nums{// カラーナンバーをaddprojectに送る
  //   return UnmodifiableListView(_nums);
  // }

  String get priorityController  {
    return this.selectedItem; // 選択されたものをselectedItemに装着
  }

    String get projectitemController  {
    return this.popupItem;
  }

  String get projectoftaskController {
    return this.selectedItem;
  }

  set choicingPriority(final String item) { // 優先度が選択された際の登録
    this.visibleItem = item;
    this.selectedItem = item;
    this.notifyListeners();
  }

      set choicingItem(final String item) { // プロジェクトが選択された際の登録
    this.popupItem = item;
    this.notifyListeners();
  }

  bool validateTaskName() {
    if (editingName.isEmpty) {
      _strValidateName = 'Please input something.';
      notifyListeners();
      return false;
    } else {
      _strValidateName = '';
      _validateName = false;
      return true;
    }
  }
  
  bool validateProjectName() {// プロジェクト名が入力されているか
    if (editingProject.isEmpty) {// 入力されていなければ、エラーメッセージを返す
      _strValidateProject = 'Please input something.';
      notifyListeners();
      return false;
    } else {// 入力されている時は、プロジェクト名検証の信号をoffにして、プロジェクト名が入力されている合図を送る
      _strValidateProject = '';
      _validateProject = false;
      return true;
    }
  }

  void setValidateName(bool value) {
    _validateName = value;
  }

    void setValidateProject(bool value) {
    _validateProject = value;
  }

  void updateValidateName() {
    if (validateName) {
      validateTaskName();
      notifyListeners();
    }
  }

    void updateValidateProject() {
    if (validateProject) {
      validateProjectName();
      notifyListeners();
    }
  }

  void coloringProject(int value) {//addprojectcolorscreenで指定された色のナンバーが_colornumへセットされる
    colornum = value;
    numnum = value;
      notifyListeners();
  }

  void addTask() {
    final newTask = Task(
      id: Uuid().v4(),
      name: nameController.text,
      memo: memoController.text,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      duedate: dueDate,
      priority: selectedItem,
      displaypriority: visibleItem,
      projectoftaskid: selectedProjectId,
      projectoftask: selectedProject,
    );
    _tasks.add(newTask);
     clear();
    // selectTask(newTask);
  }

    void addProject() {
    final newProject = Project(
      projectid: Uuid().v4(),
      projecttitle: projectController.text,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      projectcolor: colornum,
      displaycolor: numnum,
    );
    _projects.add(newProject);
    projectclear();
  }

  void selectTask() {// リスト表示
    deleteSelect();
    for(int i=0;i<_tasks.length;i++){
    if(_tasks[i].projectoftaskid == distributer){
      final newSelect = Task(
        id: _tasks[i].id,
        name: _tasks[i].name,
        memo: _tasks[i].memo,
        isDone: _tasks[i].isDone,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        duedate: _tasks[i].duedate,
        priority: _tasks[i].priority,
        displaypriority: _tasks[i].displaypriority,
        projectoftaskid: _tasks[i].projectoftaskid,
        projectoftask: _tasks[i].projectoftask,
      );
    _selects.add(newSelect);
  }
    }
  clear();
}

  void selecttimeTask() {// リスト表示
    deleteSelect();
    _tasks.sort((a,b) => a.duedate.compareTo(b.duedate));
    for(int i=0;i<_tasks.length;i++){
      if(listTypeToday == false){
        final newSelect = Task(
        id: _tasks[i].id,
        name: _tasks[i].name,
        memo: _tasks[i].memo,
        isDone: _tasks[i].isDone,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        duedate: _tasks[i].duedate,
        priority: _tasks[i].priority,
        displaypriority: _tasks[i].displaypriority,
        projectoftaskid: _tasks[i].projectoftaskid,
        projectoftask: _tasks[i].projectoftask,
      );
    _selects.add(newSelect);
      }
      else if (today.difference(_tasks[i].duedate).inDays == 0 && today.day == _tasks[i].duedate.day) {
    // if(_tasks[i].duedate == distributer){
      final newSelect = Task(
        id: _tasks[i].id,
        name: _tasks[i].name,
        memo: _tasks[i].memo,
        isDone: _tasks[i].isDone,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        duedate: _tasks[i].duedate,
        priority: _tasks[i].priority,
        displaypriority: _tasks[i].displaypriority,
        projectoftaskid: _tasks[i].projectoftaskid,
        projectoftask: _tasks[i].projectoftask,
      );
    _selects.add(newSelect);
  }
    }
  clear();
}

void divisionTask(DateTime time){
    deleteDivision();
   // ide.projecttitle = "aa";
    for(int i=0;i<_selects.length;i++){
    if((time.year == _selects[i].duedate.year)
              && (time.month == _selects[i].duedate.month)
                && (time.day == _selects[i].duedate.day)){
      final newDivision = Task(
        id: _selects[i].id,
        name: _selects[i].name,
        memo: _selects[i].memo,
        isDone: _selects[i].isDone,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        duedate: _selects[i].duedate,
        priority: _selects[i].priority,
        displaypriority: _selects[i].displaypriority,
        projectoftaskid: _selects[i].projectoftaskid,
        projectoftask: _selects[i].projectoftask,
      );
    _divisions.add(newDivision);
  }
    }
  clear();
}

void distributeProject(int index) {// どのプロジェクトが選択されているかの振り分け
  distributer = _projects[index].projectid;
  distributenum = index;
}

  void updateTask(Task updateTask) {
    var updateIndex = _tasks.indexWhere((task) {
      return task.createdAt == updateTask.createdAt;
    });
    updateTask.id = updateTask.id;
    updateTask.name = nameController.text;
    // updateTask.memo = memoController.text;
    updateTask.updatedAt = DateTime.now();
    _tasks[updateIndex] = updateTask;
    updateTask.duedate = dueDate;
    updateTask.priority = selectedItem;
    updateTask.displaypriority = visibleItem;
    updateTask.projectoftaskid = selectedProjectId;
    updateTask.projectoftask = selectedProject;
     clear();
    // selectTask(updateTask);
  }

    void updateProject(Project updateProject) {
    var updateIndex = _projects.indexWhere((project) {
      return project.createdAt == updateProject.createdAt;
    });
    updateProject.projecttitle = projectController.text;
    updateProject.updatedAt = DateTime.now();
    _projects[updateIndex] = updateProject;
    updateProject.projectcolor = colornum;
    updateProject.displaycolor = numnum;
    projectclear();
  }

  void deleteTask(int index) {
    int match;
    var select = _selects[index];
    for(int i=0;i<_tasks.length;i++){
      if(select.id == _tasks[i].id){
      match = i;
      }
    }
    _tasks.removeAt(match);
    notifyListeners();
  }

    void deleteProject(int index) {
    _projects.removeAt(index);
    notifyListeners();
  }

    void deleteSelect() {// リストのリセット
    _selects.clear();
    notifyListeners();
  }

    void deleteDivision() {// リストのリセット
    _divisions.clear();
    notifyListeners();
  }

  int matting(int index){
    int match;
    var select = _selects[index];
    for(int i=0;i<_tasks.length;i++){
      if(select.id == _tasks[i].id){
      match = i;
      }
    }
    return match;
  }

  void toggleDone(int index, bool isDone) {
    // var task = _tasks[index];
    // task.isDone = isDone;
    // _tasks[index] = task;
    // notifyListeners();
    int match;
    var select = _selects[index];
    for(int i=0;i<_tasks.length;i++){
      if(select.id == _tasks[i].id){
      match = i;
      }
    }
    var task = _tasks[match];
    task.isDone = isDone;
    _tasks[match] = task;
    notifyListeners();
  }

  void clear() {
    nameController.clear();
    memoController.clear();
    _validateName = false;
    selectedItem = null;
    visibleItem = null;
    dueDate = DateTime.now();
    selectedProjectId = null;
    selectedProject = "インボックス";
    popupItem = null;

    notifyListeners();
  }

    void projectclear() {// プロジェクトを削除した時の値の初期化
    projectController.clear();
    _validateProject = false;
    colornum = 17;
    numnum = 17;
    notifyListeners();
  }

  void deleteInTask(int index) {// プロジェクトを削除時、プロジェクトないのタスクを削除する
    var project = _projects[index];
    for(int i;i<_tasks.length;i++){
      if(project.projectid == _tasks[i].id)
      _tasks.removeAt(i);
    }
  }


  void setDueDate(DateTime dt) {
    dueDate = dt;
  }

  int setColor(String x){// viewへプロジェクトの色をセット
    int match = null;
    for(int i=0; i<_projects.length;i++){
      if(x == _projects[i].projectid)
      match = _projects[i].projectcolor;
    }
    return match;
  }

  Color compareTime(DateTime x){
    var _dateTimeNow = DateTime.now();
    var _isBefore = _dateTimeNow.isBefore(x);
    if(_isBefore == true)
    return Colors.green;
    else
    return Colors.red;
  }

  bool compareDay(DateTime x){
  final xday = DateTime(x.year,x.month,x.day);
  if(xday == today)
  return true;
  else
  return false;
  }

  bool moveProject(){
    visibilityProject = !visibilityProject;
    (visibilityProject == true)
    ? radians = pi/2
    : radians = 0;
    notifyListeners();
    return visibilityProject;
  }

  Color whichProject(BuildContext context){
    if(visibilityProject == true)
    return Theme.of(context).hoverColor;
    else
    return Theme.of(context).backgroundColor;
  }

  void rotationObject(){
radians = pi/2;
notifyListeners();
  }

  void addDropitems(){
    dropitems = [];
    iddropitems = [];
    for(int i=0;i<_projects.length;i++){
      dropitems.add(_projects[i].projecttitle);
      iddropitems.add(_projects[i].projectid);
    }
  }

  String peggingProject(String value){// projectidからprojecttitleを選択する関数
    for(int i=0; i<_projects.length; i++){
      if (_projects[i].projectid == value)
      return _projects[i].projecttitle;
    }
  }

  void setstateProject(String newValue){
    choicingItem = newValue;
    selectedProject = peggingProject(newValue);
    selectedProjectId = newValue;
    notifyListeners();

  }

  void simpleUpdate(){
    notifyListeners();
  }



}