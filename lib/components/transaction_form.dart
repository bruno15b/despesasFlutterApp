import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TransactionForm extends StatefulWidget {

  final void Function(String, double,DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {

  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = this._titleController.text;
    final value = double.tryParse(this._valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) return;

    widget.onSubmit(title, value,_selectedDate);
  }

  _showDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now()
    ).then((pickedDate) => setState(()=>this._selectedDate = pickedDate));
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
              controller: this._titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: this._valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(labelText: "Valor"),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(this._selectedDate == null
                        ? "Nenhuma data selecionada"
                        :"Data Selecionada: ${DateFormat("dd/MM/y").format(this._selectedDate)}"),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed:  _showDatePicker,
                    child: Text(
                      "Selecionar",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  onPressed: _submitForm,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text("Nova Transação"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
