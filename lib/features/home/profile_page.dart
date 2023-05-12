import 'package:flutter/material.dart';
import 'package:minha_estante/services/secure_storage.dart';

import '../../commom/constants/routes.dart';

class ProfilePage extends StatelessWidget {
  final _secureStorage = const SecureStorage();
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Profile Page"),
            ElevatedButton(
              onPressed: () {
                _secureStorage.deleteOne(key: "CURRENT_USER").then(
                      (_) => Navigator.popAndPushNamed(
                        context,
                        NamedRoute.initial,
                      ),
                    );
              },
              child: const Text("Logout")
            ),
          ],
        ),
      ),
    );
  }
}