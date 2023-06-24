import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_crud/components/user_tile.dart';
import 'package:users_crud/data/dummy_users.dart';
import 'package:users_crud/providers/users.dart';

import '../models/user.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final UsersProvider users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              users.put(User(
                name: 'Teste',
                email: 'teste@gmail.com',
                avatarUrl: '',
              ));
            },
          )
        ],
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: users.count,
          itemBuilder: (context, index) => UserTile(users.byIndex(index))),
    );
  }
}
