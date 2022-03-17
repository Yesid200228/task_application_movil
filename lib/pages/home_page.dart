import 'package:flutter/material.dart';
import 'package:pandabar/main.view.dart';
import 'package:pandabar/model.dart';
import 'package:task_application/models/tareas/task_modelGet.dart';
import 'package:task_application/providers/tasks_providers.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final tasksProvider = new TasksProvider();
   String page = 'task';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // floatingActionButton: _crearBoton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _crearListado(),
      floatingActionButton: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar(){
    return PandaBar(
        buttonData: [
          PandaBarButtonData(
            id: 'task',
            icon: Icons.task_outlined,
            title: 'Tareas'
          ),
          
          PandaBarButtonData(
            id: 'actividades',
            icon: Icons.local_activity_outlined,
            title: 'Actividades',
          ),
          PandaBarButtonData(
            id: 'favoritas',
            icon: Icons.star,
            title: 'Favoritas',
          ),
          
        ],
        onChange: (id) {
          setState(() {
            page = id;
          });
        },
        fabIcon: Icon(Icons.add),
        fabColors: [
          Color.fromRGBO(0, 173, 181, 1),
          Color.fromRGBO(57, 62, 70, 1),
        ],
        buttonSelectedColor: Color.fromRGBO(0, 173, 181, 1),
        backgroundColor: Color.fromRGBO(34, 40, 49, 1),
        onFabButtonPressed: () {
          Navigator.pushNamed(context, 'task').then((value) => initState());
        },
      );
  }



  // Widget _crearBoton(BuildContext context){
  //   return FloatingActionButton(
  //     onPressed: (){
  //       Navigator.pushNamed(context, 'task').then((value) => initState());
  //     },
  //     child: Center(child: Icon(Icons.add)),
  //     backgroundColor: Color.fromRGBO(57, 62, 70, 1),
  //   );
  // }


  Widget _crearListado(){
    return FutureBuilder(
      future: tasksProvider.cargarTasks(),
      builder: (BuildContext context, AsyncSnapshot<List<TaskModelGet>> snapshot){
        if (snapshot.hasData) {
          final tasks = snapshot.data;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context,i) => _crearItem(tasks[i],context)
          );

        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }

  Widget _crearItem( TaskModelGet task,BuildContext context){
    
    return Container(
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
          color:   Color.fromRGBO(0, 173, 181, 1),
        ),
        onDismissed: (direccion){
          tasksProvider.borrarProducto(task.id);
          // print(task.id);
        },
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                 Navigator.pushNamed(context, 'task',arguments: task);
              },
              child: Container(
                margin: EdgeInsets.all(15),
                width: double.infinity,
                height: 70,
                child: Card(
                  elevation: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Text('${task.name}',style: TextStyle(color: Color.fromRGBO(57, 62, 70, 1),fontWeight: FontWeight.bold)),
                    Text(task.description,style: TextStyle(color: Color.fromRGBO(0, 173, 181, 1)),),
                        ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initState() {
    setState(() {
    });
  }
}