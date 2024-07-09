import 'package:ace_chat_app/shared/api.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class PushNotificationService {
  Future<String> getAccessToken() async {
    final serviceAccount = {

    };

    List<String> scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccount),
      scopes,
    );

    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccount),
      scopes,
      client,
    );

    client.close();

    return credentials.accessToken.data;
  }

  sendNotification({
    required String token,
    required String sender,
    required String msg,
    String? groupName,
  }) async {
    final String serverKey = await getAccessToken();
    String endpoint =
        'https://fcm.googleapis.com/v1/projects/ace-chatapp/messages:send';

    final Map<String, dynamic> message = {
      'message': {
        'token': token,
        'notification': {
          'title': groupName == null? sender: '$groupName: $sender',
          'body': msg,
        },
        'data': {},
      }
    };

    await Api().post(url: endpoint, token: serverKey, body: message);
  }
}
