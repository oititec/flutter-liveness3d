import 'package:oiti_liveness3d/store/actions.dart';

int reducer(int previousState, dynamic action) {
  if (action == ActionsStore.increment) {
    return previousState + 1;
  }

  return previousState;
}
