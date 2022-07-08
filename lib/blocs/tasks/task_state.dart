abstract class TaskStates {}

class TaskInitialState extends TaskStates {}

class TaskDatabaseInitialized extends TaskStates {}

class TaskDatabaseTableCreated extends TaskStates {}

class TaskDatabaseOpened extends TaskStates {}

class TaskDatabaseUserCreated extends TaskStates {}

class TaskDatabaseLoading extends TaskStates {}

class TaskDatabaseUsers extends TaskStates {}

class TaskSelectUser extends TaskStates {}

class TimeSelected extends TaskStates {}

class TaskChecked extends TaskStates {}

class GetCheckedData extends TaskStates{}

class DeleteGroupDatabase extends TaskStates{}

class LogoSelectedIndex extends TaskStates{}