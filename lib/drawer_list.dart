import 'package:carros_flutter/login/login_page.dart';
import 'package:carros_flutter/login/usuario.dart';
import 'package:carros_flutter/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  Future<Usuario> future = Usuario.get();

  UserAccountsDrawerHeader _header(Usuario user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.nome),
      accountEmail: Text(user.email),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user.urlFoto),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<Usuario>(
              builder: (context, snapshot) {
                Usuario user = snapshot.data;

                return user != null ? _header(user) : Container();
              },
              future: future,
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 1");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 1");
                Navigator.pop(context);
              },
            ),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Logout"),
                subtitle: Text("mais informações..."),
                trailing: Icon(Icons.arrow_forward),
                onTap: () => _onclickLogout(context)),
          ],
        ),
      ),
    );
  }

  _onclickLogout(BuildContext context) {
    Usuario.clear();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
