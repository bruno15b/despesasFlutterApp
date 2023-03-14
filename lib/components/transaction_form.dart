import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {

  final titleController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: this.titleController,
              decoration: InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: this.valueController,
              decoration: InputDecoration(labelText: "Valor"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () {
                    print(this.titleController.text);
                    print(this.valueController.text);
                  },
                  child: Text(
                    "Nova Transação",
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
