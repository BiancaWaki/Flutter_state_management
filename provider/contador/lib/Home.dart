import 'package:contador/ContadorProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contador"),
      ),
      body: Consumer<ContadorProvider>(
        builder: (context, contadorProvider, child) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 20),
                child: Text(contadorProvider.cont.toString()),
              ),
              IconButton(
                onPressed: () {
                  contadorProvider.soma_um();
                },
                icon: const Icon(
                    Icons.add,
                    color: Colors.green,
                ),
              ),
              IconButton(
                  onPressed: (){
                    contadorProvider.subtrai_um();
                  },
                  icon: const Icon(
                    Icons.delete_forever_sharp,
                    color: Colors.red,
                  ),
              ),
            ],
          );
        },
      ),
    );
  }
}
