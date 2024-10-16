import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class AbstractApi {
  final _urlLocalHost = "http://localhost:3000";
  String _recurso;

  AbstractApi(this._recurso);

  Future<String> getAll() async {
    var response = await http.get(Uri.parse('$_urlLocalHost/$_recurso'));
    return response.body;
  }

  Future<String> getById(String id) async {
    var response = await http.get(Uri.parse('$_urlLocalHost/$_recurso/$id'));
    return response.body;
  }

  Future<String> create(Map<String, dynamic> data) async {
    var response = await http.post(
      Uri.parse('$_urlLocalHost/$_recurso'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    return response.body;
  }

  Future<String> update(String id, Map<String, dynamic> data) async {
    var response = await http.put(
      Uri.parse('$_urlLocalHost/$_recurso/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    return response.body;
  }

  Future<String> delete(String id) async {
    var response = await http.delete(Uri.parse('$_urlLocalHost/$_recurso/$id'));
    return response.body;
  }
}
