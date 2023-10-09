import 'package:http/http.dart' as http;
import 'package:travel_planning_app/exceptions/exception_handler.dart';

class ApiService {
  static const Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<http.Response> _sendRequest(String method, String url) async {
    try {
      final response = await _executeRequest(method, url);
      return response;
    } catch (error) {
      throw ExceptionHandlers().getExceptionString(error);
    }
  }

  Future<http.Response> _executeRequest(String method, String url) async {
    const headers = _defaultHeaders;

    final request = http.Request(_getMethodString(method), Uri.parse(url));
    request.headers.addAll(headers);

    final response = await http.Client().send(request);
    return http.Response.fromStream(response);
  }

  String _getMethodString(String method) {
    switch (method) {
      case 'get':
        return 'GET';
      case 'post':
        return 'POST';
      case 'put':
        return 'PUT';
      case 'patch':
        return 'PATCH';
      case 'delete':
        return 'DELETE';
      default:
        throw Exception('Unsupported HTTP method');
    }
  }

  Future<http.Response> get(String url) async {
    return await _sendRequest('get', url);
  }

  Future<http.Response> post(
    String url,
  ) async {
    return await _sendRequest(
      'post',
      url,
    );
  }

  Future<http.Response> put(
    String url,
  ) async {
    return await _sendRequest(
      'put',
      url,
    );
  }

  Future<http.Response> patch(
    String url,
  ) async {
    return await _sendRequest(
      'patch',
      url,
    );
  }

  Future<http.Response> delete(String url) async {
    return await _sendRequest('delete', url);
  }
}
