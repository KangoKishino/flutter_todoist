import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_todoist/view_model/task_view_model.dart';


class AppScaffold extends StatelessWidget {
  
  const AppScaffold({
    Key key,
     this.slivers,
    this.reverse = false,
  }) : super(key: key);

  final List<Widget> slivers;
  final bool reverse;
  

  @override
  Widget build(BuildContext context) {
    return DefaultStickyHeaderController(
      child: Scaffold(
        body: CustomScrollView(
          slivers: slivers,
          reverse: reverse,
        ),
      ),
    );
  }
}



class Header extends StatelessWidget {
  const Header({
    Key key,
    this.index,
    this.title,
    this.color = Colors.white,
  }) : super(key: key);

  final String title;
  final DateTime index;
  final Color color;


  @override
  Widget build(BuildContext context) {
    var _dateTimeNow = DateTime.now();
    final _today = DateTime(_dateTimeNow.year,_dateTimeNow.month,_dateTimeNow.day);
    var _indextoday = DateTime(index.year,index.month,index.day);
    var _indextomorrow = DateTime(index.year,index.month,index.day);
    var _same = _today.compareTo(_indextoday);
    var _next = _today.compareTo(_indextomorrow);


    var _weekName =  ['','月', '火', '水', '木', '金', '土', '日'];
  
    return Container(
      height: 40,
      color: color,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          if(checkDate() == "TODAY") 
          Text(
         '今日',
        style: const TextStyle(color: Colors.black),
          ),
          if(checkDate() == "TOMORROW") 
          Text(
         '明日',
        style: const TextStyle(color: Colors.black),
          ),
          (checkDate() == "PAST") 
         ? Text(
         '期限切れ',
        style: const TextStyle(color: Colors.black),
          )
         : Text(
         '${index.month}月${index.day}日(${_weekName[index.weekday]})',
        style: const TextStyle(color: Colors.black),
      ),
        ]
      )
      
    );
  }

  String checkDate(){
   //  example, dateString = "2020-01-26";
   DateTime checkedTime= index;
   DateTime currentTime= DateTime.now();
   var _1daysBefore  = index.add(new Duration(days: 1));
   var _1daysAfter  = currentTime.add(new Duration(days: 1));
   var _today  = index.add(new Duration(days: 0));

var _isBefore     = currentTime.isBefore(_1daysBefore);
var _isTomorrow     = currentTime.isAfter(_today);


if(_isBefore == false){
                return "PAST";
              }
   if((currentTime.year == checkedTime.year)
          && (currentTime.month == checkedTime.month)
              && (currentTime.day == checkedTime.day))
     {
        return "TODAY";
     }
   else if((index.year == _1daysAfter.year)
              && (index.month == _1daysAfter.month)
                && (index.day == _1daysAfter.day))
     {
            return "TOMORROW";
         
     }
           
 }
}