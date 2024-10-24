import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/presenter/todo_presenter.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String selectedColor = "#FFF2CC"; // Cor padrão pastel

  final List<String> pastelColors = [
    "#FFF2CC", // Amarelo pastel
    "#FFD9F0", // Rosa pastel
    "#E8C5FF", // Roxo pastel
    "#CAFBFF", // Azul pastel
    "#E3FFE6", // Verde pastel
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Nova tarefa',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Consumer<TodoPresenter>(
            builder: (context, presenter, child) {
              if (presenter.loadingTodo) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Título',
                    ),
                  ),
                  TextFormField(
                    maxLines: 8,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(
                          int.parse(selectedColor.replaceFirst('#', '0xff'))),
                      contentPadding: const EdgeInsets.all(20.0),
                      hintText: 'Escreva uma descrição para sua tarefa',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: pastelColors.map((color) {
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            selectedColor = color; // Define a cor selecionada
                          });
                        },
                        icon: Icon(
                          Icons.circle,
                          color:
                              Color(int.parse(color.replaceFirst('#', '0xff'))),
                          size: 50,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        tooltip: 'Adicionar TODO',
                        iconSize: 100,
                      ),
                      const SizedBox(width: 60),
                      IconButton(
                        icon: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 80,
                        ),
                        onPressed: () async {
                          final title = titleController.text;
                          final description = descriptionController.text;

                          if (title.isNotEmpty &&
                              description.isNotEmpty &&
                              selectedColor.isNotEmpty) {
                            await context.read<TodoPresenter>().createTodo(
                                  title: title,
                                  description: description,
                                  color: selectedColor,
                                );

                            Navigator.pop(context, true);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Preencha todos os campos!')),
                            );
                          }
                        },
                        tooltip: 'Adicionar TODO',
                        iconSize: 100,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
