
class Task {
  int id;
  String time;
  String taskname;
  int priority;
  String type;
  String more="";
  int repeatID=0;
  String image=""; 
  String audio="";
  int noticetime;
  bool isDone = false;
  bool isShown = true;

  Task(this.id, this.time, this.taskname, this.type, this.priority, this.noticetime);

  
}