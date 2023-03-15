import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {

  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final void Function(String,double) onSubmit;

  TransactionForm(this.onSubmit);

  _submitForm(){

  final title = this.titleController.text;
  final value = double.tryParse(this.valueController.text) ?? 0.0;

  if(title.isEmpty || value <= 0) return;

  onSubmit(title,value);

}

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
              onSubmitted: (_)=>_submitForm(),
              decoration: InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: this.valueController,
              keyboardType: TextInputType.numberWithOptions(decimal:true),
              onSubmitted: (_)=>_submitForm(),
              decoration: InputDecoration(labelText: "Valor"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: _submitForm,
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
