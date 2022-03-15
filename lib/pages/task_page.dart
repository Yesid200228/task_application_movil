import 'package:flutter/material.dart';
import 'package:task_application/models/tareas/task_modelPost.dart';
import 'package:task_application/providers/tasks_providers.dart';

class TaskPage extends StatefulWidget {
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final tasksProvider = new TasksProvider();

  TaskModelPost taskModelPost = new TaskModelPost();
  bool _guardando = false;


  @override
  Widget build(BuildContext context) {
    final TaskModelPost taskData = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 173, 181, 1),
        title: Text('Crear tareas',style: TextStyle(color: Color.fromRGBO(238, 238, 238, 1)),),
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
      onSaved: (value) => taskModelPost.name = value,
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
      onSaved: (value) => taskModelPost.description = value,
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
              Text('Guardar',style: TextStyle(color: Color.fromRGBO(238, 238, 238, 1)),)
            ],
          ),
          onPressed: _submit,
        ),
      )
    );
    
  }

  void _submit(){
    setState(() {_guardando = true;});

    if(!formKey.currentState.validate()) return;
    formKey.currentState.save();


      tasksProvider.crearTask(taskModelPost);
    // if (task.id == null) {
    // }else{
    //   // para mandarlo a edtiar
    // }
    
    mostrarSnacbar('Tarea guardada');
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
