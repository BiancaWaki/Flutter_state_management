import 'package:flutter/material.dart';
import 'package:todo/model/todo_api.dart';

class HomePresenter extends ChangeNotifier {
  final TodoApi api;

  HomePresenter({required this.api});
}
