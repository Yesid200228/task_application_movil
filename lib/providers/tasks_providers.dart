import 'package:dio/dio.dart';
import 'package:task_application/models/tareas/task_modelGet.dart';
import 'package:task_application/models/tareas/task_modelPost.dart';

class TasksProvider{

  final String _url = 'http://192.168.1.97:3500';
  Dio dio = Dio();

  TaskModelPost  task = new TaskModelPost ();


  Future<bool>crearTask(TaskModelPost task) async{

  final url = '$_url/tasks';


  final resp = await dio.post(url,data: taskModelToJson(task));


    print(resp.data);
    return true;
  }


  Future<List<TaskModelGet>> cargarTasks() async{
    final url = '$_url/tasks';

    final resp = await dio.get(url); 

    print(resp.data);

    final List<TaskModelGet> tasks = [];
     
    final result =  resp.data.map((item){
          print(item);
          final prodTemp = TaskModelGet.fromJson(item);


          tasks.add(prodTemp);
    });

    print(tasks);

    print(result);

    return tasks;

  }
  
}