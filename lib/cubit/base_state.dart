abstract class BaseState {
  const BaseState();
}

class Initial extends BaseState {
  const Initial();
}

class Loading extends BaseState {
  const Loading();
}

class Failure extends BaseState {
  String error;

  Failure({required this.error});
}
