import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:oiti_liveness3d/store/actions.dart';

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          StoreConnector<int, String>(
              converter: (store) => store.state.toString(),
              builder: (context, viewModel) {
                return Text(viewModel, style: const TextStyle(fontSize: 24));
              }),
          StoreConnector<int, VoidCallback>(converter: (store) {
            return () => store.dispatch(ActionsStore.increment);
          }, builder: (context, callback) {
            return TextButton(
              onPressed: () => callback,
              child: const Text('Add 1', style: TextStyle(color: Colors.white)),
            );
          })
        ]));
  }
}
