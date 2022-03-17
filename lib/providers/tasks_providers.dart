import 'package:dio/dio.dart';
import 'package:task_application/models/tareas/task_modelGet.dart';
import 'package:task_application/models/tareas/task_modelPost.dart';

class TasksProvider {
  final String _url = 'http://192.168.1.97:3500';
  Dio dio = Dio();

  TaskModelPost task = new TaskModelPost();

  Future<bool> crearTask(TaskModelPost task) async {
    final url = '$_url/tasks';

    final resp = await dio.post(url, data: taskModelToJson(task));

    print(resp.data);
    return true;
  }

  Future<List<TaskModelGet>> cargarTasks() async {
    final url = '$_url/tasks';

    final resp = await dio.get(url);

    final List<TaskModelGet> tasks = [];

    var result = resp.data.map((item) {
      final prodTemp = TaskModelGet.fromJson(item);

      tasks.add(prodTemp);
    });

    print(result);

    return tasks;
  }

  Future<bool> editartask(TaskModelGet taskModelGet) async {
    final url = '$_url/tasks/${taskModelGet.id}';

    final resp = await dio.put(url, data: taskModelGetToJson(taskModelGet));

    return true;
  }

  Future<int> borrarProducto(String id) async {
    
    final url = '$_url/tasks/$id';

    final resp = await dio.delete(url);


    return 1;
  }
}
