part of 'tasks_cubit.dart';

abstract class TasksState extends Equatable {
  const TasksState();
}

class TasksInitial extends TasksState {
  @override
  List<Object> get props => [];
}

class TasksLoading extends TasksState {
  @override
  List<Object> get props => [];
}

class TasksLoaded extends TasksState {
  final List<TaskModel> tasks;

  const TasksLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}
class TasksLoadError extends TasksState {
  @override
  List<Object> get props => [];
}

class TaskUpdating extends TasksState {
  @override
  List<Object> get props => [];
}

class TaskUpdated extends TasksState {
  @override
  List<Object> get props => [];
}

class TaskUpdateError extends TasksState {
  @override
  List<Object> get props => [];
}

class TaskCreating extends TasksState {
  @override
  List<Object> get props => [];
}

class TaskCreated extends TasksState {
  @override
  List<Object> get props => [];
}

class TaskCreateError extends TasksState {
  @override
  List<Object> get props => [];
}

class TaskDeleting extends TasksState {
  @override
  List<Object> get props => [];
}

class TaskDeleted extends TasksState {
  @override
  List<Object> get props => [];
}

class TaskDeleteError extends TasksState {
  @override
  List<Object> get props => [];
}

