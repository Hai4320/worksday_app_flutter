import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:worksday_app/themes/color.dart';
import 'package:intl/intl.dart';

class AddForm extends StatefulWidget {
  const AddForm({ Key? key }) : super(key: key);

  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  int stepIndex = 0 ;
  String task_name="";
  int task_type = 0;
  int task_priority = 3;
  DateTime task_time = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateFormat timeformat = DateFormat.jm();
  int task_repeat = 0;
  int task_notification = 0;
  List allRepeats = ["None","Daily","Weekly","Monthly"];
  List allDayOfWeek = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];
  List allDayOfWeekValue = [true, false, false, false, false, false, false];
  List allNotification = ["None","In time","5'","10'","15'","30'","1h"];
  List allDayOfMonth = List<String>.generate(31, (index) => (index+1).toString());
  List allDayOfMonthValue = List<bool>.generate(31, (index) => false);
  List allType = [
    {"name":"Personal", "icon": Icons.person}, 
    {"name":"Home", "icon": Icons.person}, 
    {"name":"Work", "icon": Icons.person}, 
    {"name":"Community", "icon": Icons.person},
    {"name":"Others", "icon": Icons.person}
  ];
  List allPriority = [
    {"name": "important", "color": AppColors.important},
    {"name": "moderate", "color": AppColors.moderate},
    {"name": "safe", "color": AppColors.safe},
    {"name": "unimportant", "color": AppColors.gray}
    ];
  TextEditingController nameEditor = TextEditingController();
  void _showSelectionPriority(){
    showModalBottomSheet(context: context, builder: (context) {
      return SizedBox(
        height: 300,
        child: ListView.separated(
          itemCount: allPriority.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(allPriority[index]["name"]),
              onTap: (){
                Navigator.pop(context);
                task_priority = index;
                setState(() {});
              }
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          }
        ),
      );
    });
  }

 
  void _showSelectionType(){
    showModalBottomSheet(context: context, builder: (context) {
      return SizedBox(
        height: 400,
        child: ListView.separated(
          itemCount: allType.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(allType[index]["name"]),
              onTap: (){
                Navigator.pop(context);
                task_type = index;
                setState(() {});   
              }
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          }
        ),
      );
    });
  }
  void _showPickDateTime(bool type){
    DateTime init_time = task_time;
    showModalBottomSheet(context: context, builder: (context){
      return Column(
        children: [
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              initialDateTime: init_time,
              mode: type? CupertinoDatePickerMode.time: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime value) {  
                init_time = value;
              },
            )
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
              onPressed: () { 
                task_time = init_time;
                Navigator.pop(context); 
                setState(() {});
              },
              child: Container(
                width: 50,
                alignment: Alignment.center,
                child: const Text("Done")
                ),
              ),
              const SizedBox(width: 50),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.white,
                onPrimary: AppColors.gray
              ),
              onPressed: () { 
                Navigator.pop(context); 
                setState(() {});
              },
              child: Container(
                width: 50,
                alignment: Alignment.center,
                child: const Text("Cancel")
                ),
              )
            ],
            
          )
        ],
      );
    });
  }
  void _onChangeRadioSelection(int index, int changeIndex) {
    switch (changeIndex) {
      case 0: task_repeat = index; break;
      case 1: task_notification = index; break;
    }
    Navigator.pop(context);
    setState(() {});
  }
  void _showSelectionByRadio(List data, int groupValue, int changeIndex){
    
    showModalBottomSheet(context: context, builder: (context) {
      return SizedBox(
        height: data.length<5? data.length*80: 400,
        child: ListView.separated(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) => RadioListTile(
            title: Text(data[index]), 
            value: index,
            groupValue: groupValue, 
            onChanged: (value) => _onChangeRadioSelection(index,changeIndex)
           
          ), 
          separatorBuilder: (BuildContext context, int index) => const Divider(), 
          
          )
      );
    });
  }

  String _getTextDateSelector(){
    switch(task_repeat) {
      case 0: return DateFormat.yMd().format(task_time);
      case 1: return "Daily";
      case 2:{
        String result ="";
        for( int i = 0; i < allDayOfWeekValue.length; i++)
        {
          if (allDayOfWeekValue[i]==true) {
            result += "${allDayOfWeek[i]}, ";
          }
        }
        if (result!=""){
          result = result.substring(0,result.length - 2);
          return result;
        }
        else{
          return "Select";
        }
      }
      case 3: {
        String result ="";
        for( int i = 0; i < allDayOfMonthValue.length; i++)
        {
          if (allDayOfMonthValue[i]==true) {
            result += "${allDayOfMonth[i]}, ";
          }
        }
        if (result!=""){
          result = result.substring(0,result.length - 2);
          return result;
        }
        else{
          return "Select";
        }
      }
      default: return DateFormat.yMd().format(task_time);
    }
  }
  void _getDayPickerAction(){
    switch (task_repeat) {
      case 0: return _showPickDateTime(false);
      case 1: return;
      case 2: return  _showSelectionRepeatDays(allDayOfWeek, allDayOfWeekValue);
      case 3: return  _showSelectionRepeatDays(allDayOfMonth, allDayOfMonthValue);
      default: return;
    }
  }
  void _showSelectionRepeatDays(List allDayOfWeekx, List dayOfWeekValuex){
    showModalBottomSheet(context: context, builder: (context){
      return StatefulBuilder(builder: (context, setState2) {
        return Column(
          children: [
          SizedBox(
            height: 350,
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              itemCount: allDayOfWeekx.length,
              itemBuilder: (BuildContext context, int index) => CheckboxListTile(
                title: Text(allDayOfWeekx[index]),
                value: dayOfWeekValuex[index],
                onChanged: (value) {                
                  setState2(() {
                    dayOfWeekValuex[index] = value;
                  });
                  setState(() {});
                }
      
              ), separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                
              ),
              child: Container(
                width: 200,
                alignment: Alignment.center,
                child: const Text("OK")
                ),
              onPressed: (){
                Navigator.pop(context);
              },
              ),
          )

          ]
        );
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stepper(
        currentStep: stepIndex,
        type: StepperType.horizontal,
        steps: steps(),
        onStepContinue: (){
          if (stepIndex<steps().length-1) {
            stepIndex++;
          }
          setState(() {});
        },
        onStepCancel: (){
          if (stepIndex>0) {
            stepIndex--;
          }
          setState(() {});
        },
        onStepTapped: (value) {
          stepIndex = value;
          setState(() {});
        },
      ),

    );
  }
   List<Step> steps() => [
    Step(
      state: stepIndex>0? StepState.complete: stepIndex==0? StepState.editing: StepState.disabled,
      isActive: stepIndex>=0,
      title: const Text("Task"),
      content: Column(
        children: [
          TextFormField(
            controller: nameEditor,
            onChanged: (value) => task_name = value,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Task name"
            ),
            validator: (value){
              if (value=="") {
                return "Task name is required";              }
            },
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              title: const Text("Priority"),
              trailing: const Icon(Icons.navigate_next),
              subtitle: Text(
                allPriority[task_priority]["name"], 
                style: TextStyle(
                  color: allPriority[task_priority]["color"]
                ),
              ),
              onTap: ()=> _showSelectionPriority()
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              title: const Text("Type"),
              trailing: Icon(allType[task_type]["icon"]),
              subtitle: Text(allType[task_type]["name"]),
              onTap: ()=> _showSelectionType(),
            ),
          )
        ]
      )
    ),

    Step(
      state:  stepIndex>1? StepState.complete: stepIndex==1? StepState.editing: StepState.disabled,
      isActive: stepIndex>=1,
      title: Text("Time"),
      content: Column(
        children: [
          Card(
            child: ListTile(
              onTap: ()=> _showPickDateTime(true),
              iconColor: AppColors.primary,
              leading: const Icon(Icons.alarm),
              trailing: const Icon(Icons.navigate_next),
              title: Text(timeformat.format(task_time)),
            ),
          ),
          Card(
            child: ListTile(
              iconColor: AppColors.primary,
              leading: const Icon(Icons.repeat),
              trailing: const Icon(Icons.navigate_next),
              title: const Text("Repeat"),
              subtitle: Text(allRepeats[task_repeat]),
              onTap: ()=> _showSelectionByRadio(allRepeats, task_repeat, 0)
            ),
          ),
          Card(
            child: ListTile(
              iconColor: AppColors.primary,
              leading: const Icon(Icons.date_range),
              trailing: const Icon(Icons.navigate_next),
              title: Text(_getTextDateSelector()),
              onTap: ()=> _getDayPickerAction(),
            ),
          )
        ],)
    ),
    Step(
      state:  stepIndex>2? StepState.complete: stepIndex==2? StepState.editing: StepState.disabled,
      isActive: stepIndex>=2,
      title: Text("Notify"),
      content: Column(
        children: [
          Card(
            child: ListTile(
              iconColor: AppColors.primary,
              leading: const Icon(Icons.notifications),
              trailing: const Icon(Icons.navigate_next),
              title: const Text("Notification"),
              subtitle: Text(allNotification[task_notification]),
              onTap: ()=> _showSelectionByRadio(allNotification,task_notification,1),
            ),
          ),
           Card(
            child: ListTile(
              iconColor: AppColors.primary,
              leading: const Icon(Icons.music_note),
              trailing: const Icon(Icons.navigate_next),
              title: const Text("Ringtone"),
              subtitle: const Text("Default"),
              onTap: (){},
            ),
          )
        ],
      )
    ),
     Step(
      state:  stepIndex>3? StepState.complete: stepIndex==3? StepState.editing: StepState.disabled,
      isActive: stepIndex>=3,
      title: const Text("Confirm"),
      content: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ["Name:",task_name],
              ["Priority:",allPriority[task_priority]["name"]],
              ["Type:", allType[task_type]["name"]],
              ["Time:",timeformat.format(task_time)],
              ["Day:", _getTextDateSelector()],
              ["Notification:", allNotification[task_notification]]

              ].map(
              (cf) => Container(
                margin: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 110,
                      child: Text(
                        cf[0], 
                        style: TextStyle(color: AppColors.black, fontSize: 17, fontWeight: FontWeight.bold)
                        ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width-200,
                      child: Text(
                        cf[1],
                        style: TextStyle(color: AppColors.black, fontSize: 17),
                        ),
                    )
                  ]
                ),
              ),
            ).toList() 
              
          ),
        )
      )
    ),
  ];
}