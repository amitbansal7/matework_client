// @dart=2.9

import 'package:Matework/database.dart';
import 'package:Matework/network/chats_rest_client.dart';
import 'package:Matework/network/invites_rest_client.dart';
import 'package:Matework/repositories/chats_repository.dart';
import 'package:Matework/repositories/invites_repository.dart';
import 'package:Matework/screens/chats_screen.dart';
import 'package:Matework/screens/invites_screen.dart';
import 'package:Matework/viewmodels/chats_viewmodel.dart';
import 'package:Matework/viewmodels/invites_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = "home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Explore',
      style: optionStyle,
    ),
    InvitesScreen(),
    ChatsScreen(),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // final client = Provider.of<AuthRestClient>(context, listen: false);
    return MultiProvider(
      providers: [
        ProxyProvider<Dio, InvitesRestClient>(
          update: (_, dio, __) {
            return InvitesRestClient(dio);
          },
        ),
        ProxyProvider<AppDatabase, InviteRepository>(
          update: (_, db, __) {
            return db.inviteRepository;
          },
        ),
        ChangeNotifierProxyProvider2<InviteRepository, InvitesRestClient,
            InvitesViewModel>(
          create: (_) => InvitesViewModel(),
          update: (_, inviteRepository, invitesRestClient, viewModel) {
            viewModel.setInviteRepository = inviteRepository;
            viewModel.setInvitesRestClient = invitesRestClient;
            return viewModel;
          },
        ),
        ChangeNotifierProxyProvider2<ChatsRepository, ChatsRestClient,
            ChatsViewModel>(
          create: (_) => ChatsViewModel(),
          update: (_, chatsRepository, chatsRestClient, viewModel) {
            viewModel.setChatsRepository = chatsRepository;
            viewModel.setChatsRestClient = chatsRestClient;
            return viewModel;
          },
        ),
      ],
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: const Radius.circular(15),
                topLeft: const Radius.circular(15)),
            boxShadow: [
              const BoxShadow(
                  color: Colors.black26, spreadRadius: 0, blurRadius: 0.1),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0),
            ),
            child: BottomNavigationBar(
              elevation: 10,
              iconSize: 30,
              selectedFontSize: 12,
              selectedIconTheme: IconThemeData(color: Colors.black),
              unselectedIconTheme: IconThemeData(color: Colors.grey),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const Icon(Icons.account_tree_sharp),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.connect_without_contact_sharp),
                  label: 'Invites',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.chat),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: _selectedIndex == 3
                      ? const Icon(Icons.person_rounded)
                      : const Icon(Icons.person_outline_outlined),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.black87,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
