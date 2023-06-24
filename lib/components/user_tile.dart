
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_crud/models/user.dart';
import 'package:users_crud/providers/users.dart';

import '../routes/app_routes.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: user,
                );
              },
              icon: Icon(Icons.edit),
              color: Colors.orange,
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Excluir Usuário'),
                          content: Text('Tem Certeza?'),
                          actions: <Widget>[
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text('Não'),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text('Sim'),
                            ),
                          ],
                        )
                        ).then((confirmed) => {
                          if(confirmed) {
                            Provider.of<UsersProvider>(context, listen: false).remove(user)
                          }
                        });
              },
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
