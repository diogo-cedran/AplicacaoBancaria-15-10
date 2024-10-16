import 'package:flutter/material.dart';
import '../service/transacao.dart';

class Formulario extends StatefulWidget {
  final Map<String, dynamic>? transacao;

  Formulario({this.transacao});

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();
  final TransacaoService _transacaoService = TransacaoService();

  @override
  void initState() {
    super.initState();
    if (widget.transacao != null) {
      _nomeController.text = widget.transacao!['nome'];
      _valorController.text = widget.transacao!['valor'].toString();
    }
  }

  void _salvarTransacao() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        "nome": _nomeController.text,
        "valor": double.parse(_valorController.text)
      };
      if (widget.transacao == null) {
        await _transacaoService.create(data);
      } else {
        await _transacaoService.update(widget.transacao!['id'].toString(), data);
      }
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulário de Transação')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite um nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _valorController,
                decoration: InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite um valor';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarTransacao,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
