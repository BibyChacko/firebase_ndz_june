import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_fb_june_ndz/src/cubit/tasks/tasks_cubit.dart';
import 'package:task_fb_june_ndz/src/models/task_model.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit(),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Create a task"),
          ),
          body: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        labelText: "Title"
                    ),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                        labelText: "Description"
                    ),
                  ),
                  TextFormField(
                    controller: _startDateController,
                    readOnly: true,
                    onTap: () async {
                      startDate = await showDatePicker(context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030)
                      );
                      if (startDate != null) {
                        _startDateController.text = startDate.toString();
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Start Date"
                    ),
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: _endDateController,
                    onTap: () async {
                      endDate = await showDatePicker(context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030)
                      );
                      if (endDate != null) {
                        _endDateController.text = endDate.toString();
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "End Date"
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: () {
                      TaskModel taskModel = TaskModel(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          startDate: startDate??DateTime.now(),
                          endDate: endDate??DateTime.now().add(Duration(days: 5)),
                          isCompleted: false
                      );
                      context.read<TasksCubit>().createTasks(taskModel);
                  }, child: Text("Create Task"))

                ],
              ))),
    );
  }
}
