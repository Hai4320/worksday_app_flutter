class Task {
  int id;
  String time;
  String detail;
  String type;
  String level;
  String image=""; 
  String audio="";
  int noticetime = -1;
  bool isDone = false;
  bool isShown = true;

  Task(this.id, this.time, this.detail, this.type, this.level);

  
}