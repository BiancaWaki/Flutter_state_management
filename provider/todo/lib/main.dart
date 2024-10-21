import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_api.dart';
import 'package:todo/presenter/app_presenter.dart';
import 'package:todo/view/login.dart';

import 'theme.dart';

void main() {
  // Inicializa o TodoApi uma única vez para a aplicação
  final api = TodoApi();
  runApp(
    MultiProvider(
      // Fornece o TodoApi para todos os presenters
      providers: [
        ChangeNotifierProvider(create: (_) => AppPresenter(api: api)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const Login(),
    );
  }
}
