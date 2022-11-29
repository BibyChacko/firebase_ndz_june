import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_fb_june_ndz/src/cubit/tasks/tasks_repository.dart';
import 'package:task_fb_june_ndz/src/models/task_model.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {

  TasksRepository _repository = TasksRepository();
  TasksCubit() : super(TasksInitial());

  createTasks(TaskModel taskModel) async{
    emit(TaskCreating());
    try{
      await _repository.createTasks(taskModel);
      emit(TaskCreated());
    }catch(ex){
      emit(TaskCreateError());
    }
  }

  updateTask(TaskModel taskModel) async{
    emit(TaskUpdating());
    try{
      await _repository.updateTask(taskModel);
      emit(TaskUpdated());
    }catch(ex){
      emit(TaskUpdateError());
    }

  }

  deleteTask(TaskModel taskModel) async{
    emit(TaskDeleting());
    try{
      await _repository.deleteTask(taskModel);
      emit(TaskDeleted());
    }catch(ex){
      emit(TaskDeleteError());
    }
  }

  getAllTasks(TaskModel taskModel) async{
    emit(TasksLoading());
    try{
     QuerySnapshot snapshot = await _repository.getTasks();
     try {
     } catch (e, s) {
       print(s);
     }
     List<TaskModel> taskList = snapshot.docs.map((e){
       Map<String,dynamic>  dx = e.data() as Map<String,dynamic>;
       String id = e.id;
       TaskModel taskModel = TaskModel.fromJson(dx);
       taskModel.id = id;
       return taskModel;
     }).toList();
    emit(TasksLoaded(taskList));
    }catch(ex){
      emit(TasksLoadError());
    }
  }
}
