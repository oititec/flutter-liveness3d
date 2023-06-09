import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../store/actions.dart';

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          StoreConnector<int, String>(
              converter: (store) => store.state.toString(),
              builder: (context, viewModel) {
                return Text(viewModel, style: TextStyle(fontSize: 24));
              }),
          StoreConnector<int, VoidCallback>(converter: (store) {
            return () => store.dispatch(ActionsStore.increment);
          }, builder: (context, callback) {
            return TextButton(
                child: Text('Add 1', style: TextStyle(color: Colors.white)),
                onPressed: callback);
          })
        ]));
  }
}
