import 'package:flutter/material.dart';
import 'package:task_application/models/tareas/task_modelGet.dart';
import 'package:task_application/models/tareas/task_modelPost.dart';
import 'package:task_application/providers/tasks_providers.dart';

class TaskPage extends StatefulWidget {
  // TaskPage({Key key, @required this.animalCard}) : super(key: key);

  final TaskModelGet taskModelGet;
  TaskPage({
    this.taskModelGet,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {


  final formKey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final tasksProvider = new TasksProvider();

  
  TaskModelPost taskModelPost = new TaskModelPost();
  TaskModelGet taskModelGet = new TaskModelGet();

  bool _guardando = false;

  TextStyle colores = TextStyle(color: Color.fromRGBO(238, 238, 238, 1)) ;

  @override
  Widget build(BuildContext context) {

    final TaskModelGet taskDataGet = ModalRoute.of(context).settings.arguments;

    // bool tipo = ModalRoute.of(context).settings.arguments;

      taskModelGet = taskDataGet;


    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 173, 181, 1),
        title: taskDataGet == null ?Text('Crear Tarea',style: colores): Text('Actualizar Tarea'),
        actions: [
        ],
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(50.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _crearName(),
                Divider(),
                _crearDescripcion(),
                SizedBox(height: 20,),
                _crearDisponible(context),
                SizedBox(height: 20,),
                _botonAgregar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearName(){
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      initialValue: taskModelGet == null ? taskModelGet :taskModelGet.name ,
      decoration: InputDecoration(
        labelText: 'Nombre de la tarea',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(57, 62, 70, 1)),
        ),
        icon: Icon(Icons.task_outlined ,color: Color.fromRGBO(57, 62, 70, 1),),
        hintText: 'Ir a la universidad',
        labelStyle: TextStyle(
          color: Color.fromRGBO(57, 62, 70, 1)
        ),
      ),
      onSaved: (value) => taskModelGet.name == null ? taskModelPost.name=value: taskModelGet.name=value,
      validator: (value){
        if (value.length<1) {
          if (value.length > 45) {
            return 'La tarea no puede contener mas de 45 caracteres';
          }
          return 'Ingrese el nombre de la tarea';
        }else{
          return null;
        }
      },
    );
  }

  Widget _crearDescripcion(){
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      initialValue: taskModelGet == null ? '' :taskModelGet.description ,
      decoration: InputDecoration(
        labelText: 'Descripcion',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(57, 62, 70, 1)),
        ),
        icon: Icon(Icons.description_outlined,color: Color.fromRGBO(57, 62, 70, 1),),
        hintText: 'ir a el bloque i',
        labelStyle: TextStyle(
          color: Color.fromRGBO(57, 62, 70, 1)
        ),
      ),
      onSaved: (value) => taskModelGet.description == null ? taskModelPost.description=value: taskModelGet.description=value,
      validator: (value){
        if (value.length>255) {
            return 'La descripcion no puede contener mas de 255 caracteres';
        }else{
          return null;
        }
      },
    );
  }

  Widget _botonAgregar(){
    return(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)
        ),
        width: 120,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(0, 173, 181, 1)
          ),
          child: Row(
            children: [
              Icon(Icons.save,color: Color.fromRGBO(238, 238, 238, 1)),
              SizedBox(width: 10,),
              Text('Guardar',style: colores,)
            ],
          ),
          // onPressed: (_guardando) ? null : _submit,
          onPressed: _submit,

        ),
      )
    );
  }

    Widget _crearDisponible(BuildContext context){
      // print(tipo.toString());
      if (taskModelGet==null) {
        return Container();
      }else{
        return SwitchListTile(
          value: taskModelGet.status,
          title: Text('Status'),
          activeColor:  Color.fromRGBO(57, 62, 70, 1),
          onChanged: (value) => setState((){  
            taskModelGet.status = value;
          })
        );

      }
  }

  void _submit(){
    if(!formKey.currentState.validate()) return;
    formKey.currentState.save();
    
    setState(() {_guardando = true;});

    if (taskModelGet != null) {

      // print(taskModelGetToJson(taskModelGet));
      tasksProvider.editartask(taskModelGet);

    }else{
      //Registrar
      tasksProvider.crearTask(taskModelPost);         
    }
    
    Navigator.pop(context);

  }


  void mostrarSnacbar(String mensaje) {
    final snackbar = SnackBar(
      backgroundColor: Colors.green,
      content: Text(mensaje,style: TextStyle(fontWeight: FontWeight.bold),),
      duration: Duration(milliseconds: 3000),
    );
    // ignore: deprecated_member_use
    scaffoldkey.currentState.showSnackBar(snackbar);
  }


}
