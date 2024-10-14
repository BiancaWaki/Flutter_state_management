import 'package:contador/ContadorProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Home.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
      create: (_) => ContadorProvider(),
      child: const MaterialApp(
          home: Home(),
      ),
    ),
  );
}