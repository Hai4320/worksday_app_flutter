import 'package:flutter/material.dart';
import 'package:worksday_app/themes/color.dart';

class AddForm extends StatefulWidget {
  const AddForm({ Key? key }) : super(key: key);

  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  int stepIndex = 0 ;
  List alltype = [
    {"name":"Personal", "icon": Icons.person}, 
    {"name":"Home", "icon": Icons.person}, 
    {"name":"Work", "icon": Icons.person}, 
    {"name":"Community", "icon": Icons.person},
    {"name":"Others", "icon": Icons.person}
  ];
  List allpriority = [
    {"name": "important", "color": AppColors.important},
    {"name": "moderate", "color": AppColors.moderate},
    {"name": "safe", "color": AppColors.safe},
    {"name": "unimportant", "color": AppColors.gray}
    ];
  TextEditingController task_name = TextEditingController();
  int task_type = 0;
  int task_priority = 0;
  List<Step> steps() => [
    Step(
      state: stepIndex>0? StepState.complete: stepIndex==0? StepState.editing: StepState.disabled,
      isActive: stepIndex>=0,
      title: const Text("Task"),
      content: Column(
        children: [
          TextFormField(
            controller: task_name,
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
                allpriority[task_priority]["name"], 
                style: TextStyle(
                  color: allpriority[task_priority]["color"]
                ),
              ),
              onTap: ()=> _showSelectionPriority()
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              title: const Text("Type"),
              trailing: Icon(alltype[task_type]["icon"]),
              subtitle: Text(alltype[task_type]["name"]),
              onTap: ()=> _showSelectionType(),
            ),
          )
        ]
      )
    ),
    Step(
      state:  stepIndex>1? StepState.complete: stepIndex==1? StepState.editing: StepState.disabled,
      isActive: stepIndex>=1,
      title: Text("Type"),
      content: Center(
        child: Text("Type"),
      ),
    ),
    Step(
      state:  stepIndex>2? StepState.complete: stepIndex==2? StepState.editing: StepState.disabled,
      isActive: stepIndex>=2,
      title: Text("Repeat"),
      content: Center(
        child: Text("Repeat"),
      ),
    ),
     Step(
      state:  stepIndex>3? StepState.complete: stepIndex==3? StepState.editing: StepState.disabled,
      isActive: stepIndex>=3,
      title: Text("Alert"),
      content: Center(
        child: Text("Alert"),
      ),
    ),
  ];
  void _selectPriority(int index){
    Navigator.pop(context);
    task_priority = index;
    setState(() {
    });
  }
  void _selectType(int index){
    Navigator.pop(context);
    task_type = index;
    setState(() {
    });
  }
  void _showSelectionPriority(){
    showModalBottomSheet(context: context, builder: (context) {
      return ListView.separated(
        itemCount: allpriority.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(allpriority[index]["name"]),
            onTap: ()=> _selectPriority(index)
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        }
      );
    });
  }
   void _showSelectionType(){
    showModalBottomSheet(context: context, builder: (context) {
      return ListView.separated(
        itemCount: alltype.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(alltype[index]["name"]),
            onTap: ()=> _selectType(index)
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        }
      );
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
            print(task_name.text);
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
}