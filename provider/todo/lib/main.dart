import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_api.dart';
import 'package:todo/presenter/home_presenter.dart';
import 'package:todo/presenter/login_presenter.dart';
import 'package:todo/presenter/register_presenter.dart';
import 'package:todo/presenter/splash_presenter.dart';
import 'package:todo/presenter/todo_presenter.dart';
import 'package:todo/view/home.dart';
import 'package:todo/view/login.dart';
import 'package:todo/view/register.dart';
import 'package:todo/view/todo.dart';
import 'package:todo/view/splash.dart';
import 'theme.dart';

//navegacao com rotas OK
//token no dispositivo
//cada tela tem que ter um presenter OK

void main() {
  // Inicializa o TodoApi uma única vez para a aplicação
  final api = TodoApi();
  runApp(
    MultiProvider(
      // Fornece o TodoApi para todos os presenters
      providers: [
        ChangeNotifierProvider(create: (_) => LoginPresenter(api: api)),
        ChangeNotifierProvider(create: (_) => RegisterPresenter(api: api)),
        ChangeNotifierProvider(create: (_) => HomePresenter(api: api)),
        ChangeNotifierProvider(create: (_) => TodoPresenter(api: api)),
        ChangeNotifierProvider(create: (_) => SplashPresenter(api: api)),
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
      initialRoute: '/',
      routes: {
        '/': (_) => Splash(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/home': (context) => const Home(),
        '/todo': (context) => const Todo(),
      },
    );
  }
}
