abstract class HttpService {
  Future<String> get(String slugUrl);
  Future<String> put({required String slugUrl, required Map body});
  Future<String> post({required String slugUrl, required Map body});
  Future<String> delete(String slugUrl);
}
