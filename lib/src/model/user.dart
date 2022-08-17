class User {
  String name;
  String displayName;
  String emailAddress;
  String jsessionid;
  String key;
  String accessToken;
  String refreshToken;
  String role;

  User(this.name, this.displayName, this.emailAddress, this.jsessionid,
      this.key, this.accessToken, this.refreshToken, this.role);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        displayName = json['displayName'],
        emailAddress = json['emailAddress'],
        jsessionid = json['JSESSIONID'],
        key = json['key'],
        accessToken = json['accessToken'],
        refreshToken = json['refreshToken'],
        role = json['role'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'displayName': displayName,
      'emailAddress': emailAddress,
      'JSESSIONID': jsessionid,
      'key': key,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'role': role
    };
  }

  @override
  String toString() {
    return 'User{name: $name,'
        '\n displayName: $displayName,'
        '\n emailAddress: $emailAddress,'
        '\n jsessionid: $jsessionid,'
        '\n key: $key,'
        '\n accessToken: $accessToken,'
        '\n refreshToken: $refreshToken,'
        '\n role: $role}';
  }

  void userReducer(User user, String action) {
    switch (action) {
      case 'login':
        {
          //todo login
          break;
        }
      case 'refreshToken':
        {
          //todo refreshToken
          break;
        }
      case 'logout':
        {
          //todo logout
          break;
        }
      default:
        {
          throw Error();
        }
    }
  }
}
