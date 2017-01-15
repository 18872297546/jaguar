part of jaguar.src.http.response;

class JaguarHttpHeaders {
  final Map<String, List<String>> headers = {};

  operator [](String name) => headers[name];

  operator []=(String name, value) => set(name, value);

  String value(String name) {
    name = name.toLowerCase();
    List<String> values = headers[name];
    if (values == null) return null;
    return values[0];
  }

  void add(String name, Object value) {
    if (value is List) {
      for (int i = 0; i < value.length; i++) {
        _addValue(name, value[i]);
      }
    } else {
      _addValue(name, value);
    }
  }

  void set(String name, String value) {
    name = name.toLowerCase();
    List<String> values = new List<String>();
    headers[name] = values;
    values.add(value);
  }

  void remove(String name, Object value) {
    headers[name]?.remove(value);
  }

  void removeAll(String name) {
    headers.clear();
  }

  void forEach(void f(String name, List<String> values)) {
    headers.forEach(f);
  }

  void clear() {
    headers.clear();
  }

  void _addValue(String name, Object value) {
    List<String> values = headers[name];
    if (values == null) {
      values = new List<String>();
      headers[name] = values;
    }
    if (value is DateTime) {
      values.add(HttpDate.format(value));
    } else {
      values.add(value.toString());
    }
  }

  void setContentType(ContentType contentType) {
    set(HttpHeaders.CONTENT_TYPE, contentType.toString());
  }
}
