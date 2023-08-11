class Header {
  // SECURE HEADER
  static Map<String, dynamic> secureHeader = {
    "Authorization": "Bearer 'token'",
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
  // DEFAULT HEADER
  static Map<String, dynamic> defaultHeader = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  // DEFAULT MULTIPART-HEADER
  static Map<String, dynamic> defaultMultipartHeader = {
    'Accept': 'application/json',
    'Content-Type': 'multipart/form-data',
  };

  // SECURE MULTIPART HEADER
  static Map<String, dynamic> secureMultipartHeader = {
    "Authorization": "Bearer 'token'",
    'Accept': 'application/json',
    'Content-Type': 'multipart/form-data',
  };
}