import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/routes.dart';
import 'package:minha_estante/services/secure_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _secureStorage = const SecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Home Page"),
            ElevatedButton(
              onPressed: () {
                _secureStorage.deleteOne(key: "CURRENT_USER").then(
                      (_) => Navigator.popAndPushNamed(
                        context,
                        NamedRoute.initial,
                      ),
                    );
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
