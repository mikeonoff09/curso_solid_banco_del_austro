import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('User Name: John Doe'),
        ElevatedButton(
          onPressed: () {
            // Lógica de negocio para actualizar el perfil
            updateUserProfile();
          },
          child: const Text('Update Profile'),
        ),
      ],
    );
  }

  void updateUserProfile() {
    // Código para actualizar el perfil del usuario
  }
}
