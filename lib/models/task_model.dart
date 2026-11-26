class TaskModel {
   String TaskName;
   String TaskDesc;
   bool pero;

   bool isChecked;

  TaskModel({
    required this.TaskName,
    required this.TaskDesc,
    required this.pero,
     this.isChecked=false,
  });

  factory TaskModel.fromjson(Map<String, dynamic> json) {
    return TaskModel(
      TaskName: json["TaskName"],
      TaskDesc: json["TaskDesc"],
      pero: json["pero"],
      isChecked: json["ischckes"] ?? false,
    );
  }

  Map<String, dynamic> convert_to_map() {
    return {"TaskName": TaskName, "TaskDesc": TaskDesc, "pero": pero,"ischckes":isChecked };
  }

  delete_task(){

  }
}
