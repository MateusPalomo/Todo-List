
import 'package:flutter/material.dart';
import 'package:todo_list2/models/task3.dart';

class TaskDialog extends StatefulWidget {
  final Task3 task;

  TaskDialog({this.task});

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Task3 _currentTask = Task3();
  int selectedRadioTile;
  int selectedRadio;

  @override
  void initState() {
    super.initState();
     selectedRadio = 0;
     selectedRadioTile = 0;
    if (widget.task != null) {
      _currentTask = Task3.fromMap(widget.task.toMap());
    }

    _titleController.text = _currentTask.title;
    _descriptionController.text = _currentTask.description;
  }
  setSelectedRadioTile(int val) {
  setState(() {
    selectedRadioTile = val;
  });
  }
  
   Future _submit() async {
    if (_formKey.currentState.validate()) {
     _formKey.currentState.save();
     _currentTask.title = _titleController.value.text;
     _currentTask.description = _descriptionController.text;
     Navigator.of(context).pop(_currentTask);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task == null ? 'Nova tarefa' : 'Editar tarefas'),
      content: Form(
        key: _formKey,
        child:SingleChildScrollView(
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            validator: (val){
              if (val.isEmpty) {
                        return 'Por favor preencha corretamente o campo';
                      }
            },
            onSaved: (val) => _titleController.text = val,
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
              autofocus: true),
          TextFormField(
            maxLines: null,
            validator: (val){
              if (val.isEmpty) {
                        return 'Por favor preencha corretamente o campo';
                      }
            },
            onSaved: (val) => _descriptionController.text = val,
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descrição')),
              
            RadioListTile(
                value: 1,
               groupValue: selectedRadioTile,
                  title: Text("Baixa prioridade"),
                     onChanged: (val) {
                               print("Radio Tile pressed $val");
                               setSelectedRadioTile(val);
                           },
                              activeColor: Colors.blue,
                           selected: true,
                           
                ),
              
                RadioListTile(
                value: 2,
               groupValue: selectedRadioTile,
                  title: Text("Média prioridade"),
                     onChanged: (val) {
                               print("Radio Tile pressed $val");
                               setSelectedRadioTile(val);
                           },
                              activeColor: Colors.yellow[800],
                           selected: true,
                ),
                RadioListTile(
                value: 3,
               groupValue: selectedRadioTile,
                  title: Text("Alta prioridade"),
                     onChanged: (val) {
                               print("Radio Tile pressed $val");
                               setSelectedRadioTile(val);
                           },
                              activeColor: Colors.red,
                           selected: true,
                ),
              ],
            
        ),
      ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Salvar'),
          onPressed: _submit,
        ),
      ],
    );
  }
}
