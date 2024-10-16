import 'package:flutter/material.dart';
import '../service/transacao.dart';
import 'formulario.dart';
import 'dart:convert';

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  final TransacaoService _transacaoService = TransacaoService();
  List<dynamic> _transacoes = [];

  @override
  void initState() {
    super.initState();
    _carregarTransacoes();
  }

  void _carregarTransacoes() async {
    String response = await _transacaoService.getAll();
    setState(() {
      _transacoes = json.decode(response) as List<dynamic>;
    });
  }

  void _editarTransacao(Map<String, dynamic> transacao) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Formulario(transacao: transacao),
      ),
    );
    if (result != null && result) {
      _carregarTransacoes();
    }
  }

  void _excluirTransacao(String id) async {
    await _transacaoService.delete(id);
    _carregarTransacoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Transações')),
      body: ListView.builder(
        itemCount: _transacoes.length,
        itemBuilder: (context, index) {
          final transacao = _transacoes[index];
          return ListTile(
            title: Text(transacao['nome']),
            subtitle: Text('Valor: ${transacao['valor']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editarTransacao(transacao),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _excluirTransacao(transacao['id'].toString()),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Formulario()),
        ).then((result) {
          if (result != null && result) {
            _carregarTransacoes();
          }
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}
