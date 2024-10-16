// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todo/presenter/home_presenter.dart';

// class Todo extends StatefulWidget {
//   const Todo({super.key, required this.createTodo});

//   final Function(String, String, String) createTodo;

//   @override
//   State<Todo> createState() => _TodoState();
// }

// class _TodoState extends State<Todo> {
//   final titleController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final colorController = TextEditingController();
//   var color = "#ffe2e0";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Nova tarefa'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: const InputDecoration(labelText: 'Título'),
//             ),
//             TextField(
//               controller: descriptionController,
//               decoration: const InputDecoration(labelText: 'Descrição'),
//             ),
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.color_lens,
//                     size: 32,
//                     color: Colors.black,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.color_lens,
//                     size: 32,
//                     color: Colors.black,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     color = "#ffe2e0";
//                   },
//                   icon: const Icon(
//                     Icons.color_lens,
//                     size: 32,
//                     color: Colors.red,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.color_lens,
//                     size: 32,
//                     color: Colors.black,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.color_lens,
//                     size: 32,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(); // Cancela a adição
//                   },
//                   child: const Text('Cancelar'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     final title = titleController.text;
//                     final description = descriptionController.text;
//                     final color = "#ffe2e0";

//                     if (title.isNotEmpty &&
//                         description.isNotEmpty &&
//                         color.isNotEmpty) {
//                       widget.createTodo(title, description, color);
//                       Navigator.of(context).pop();
//                       // final presenter =
//                       //     Provider.of<HomePresenter>(context, listen: false);
//                       // presenter.api
//                       //     .createTodo(title, description, color)
//                       //     .then((_) {
//                       //   // Após a criação, você pode navegar de volta à tela anterior ou atualizar a tela de origem
//                       //   Navigator.of(context).pop(); // Fecha a tela atual
//                       // });
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                             content: Text('Preencha todos os campos!')),
//                       );
//                     }
//                   },
//                   child: const Text('Adicionar'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({super.key, required this.createTodo});

  final Function(String, String, String) createTodo;

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String selectedColor = "#ffe2e0"; // Cor padrão pastel

  final List<String> pastelColors = [
    "#ffe2e0", // Vermelho pastel
    "#fff1b3", // Amarelo pastel
    "#d4f4ff", // Azul pastel
    "#d3ffd4", // Verde pastel
    "#f6d1f7", // Rosa pastel
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
          padding: EdgeInsets.all(30),
          child: Column(
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
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  hintText: 'Escreva uma descrição para sua tarefa',
                  hintStyle: TextStyle(
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
                      color: Color(int.parse(color.replaceFirst('#', '0xff'))),
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
                      Navigator.of(context).pop();
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
                    onPressed: () {
                      final title = titleController.text;
                      final description = descriptionController.text;

                      if (title.isNotEmpty &&
                          description.isNotEmpty &&
                          selectedColor.isNotEmpty) {
                        widget.createTodo(title, description, selectedColor);
                        Navigator.of(context).pop();
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
          ),
        ),
      ),
    );
  }
}
