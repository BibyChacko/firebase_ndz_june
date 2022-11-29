import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_fb_june_ndz/src/cubit/tasks/tasks_cubit.dart';
import 'package:task_fb_june_ndz/src/models/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit()..getAllTasks(),
      child: Scaffold(
        appBar: AppBar(title: Text("Home page"),),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
        ),
        body: BlocBuilder<TasksCubit,TasksState>(
          builder: (context,state){
            if(state is TasksLoading || state is TaskDeleting){
              return CircularProgressIndicator();
            }
            else if(state is TasksLoaded){
              return _buildTaskListView(context,state.tasks);
            }else if(state is TasksLoadError){
              return Text("Failed to load data");
            }
            else{
              return Container();
            }
          },
        )
      ),
    );
  }

  Widget _buildTaskListView(BuildContext context, List<TaskModel> tasks) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context,pos){
        TaskModel taskModel = tasks[pos];
        return ListTile(
          title: Text(taskModel.title),
          subtitle: Column(
            children: [
              Text(taskModel.description),
              Text("Start Date : ${taskModel.startDate.toString()}"),
              Text("End Date : ${taskModel.endDate.toString()}")
            ],
          ),
          trailing: Row(
            children: [
              Text(taskModel.isCompleted?"Done":"Pending"),
              SizedBox(width: 4,),
              IconButton(onPressed: (){
                context.read<TasksCubit>().deleteTask(taskModel);
              }, icon: Icon(Icons.delete))
            ],
          ),
        );
      },
    );
  }
}
