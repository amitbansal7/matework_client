import 'package:Matework/database.dart';
import 'package:Matework/network/chats_rest_client.dart';
import 'package:Matework/network/invites_rest_client.dart';
import 'package:Matework/network/user_profiles_rest_client.dart';
import 'package:Matework/repositories/chats_repository.dart';
import 'package:Matework/repositories/invites_repository.dart';
import 'package:Matework/screens/chats_screen.dart';
import 'package:Matework/screens/invites_screen.dart';
import 'package:Matework/services/user_data_channel_manager.dart';
import 'package:Matework/viewmodels/chats_viewmodel.dart';
import 'package:Matework/viewmodels/invites_viewmodel.dart';
import 'package:Matework/viewmodels/user_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  static TextStyle optionStyle =
      TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold);

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
    // For establishing a socket connection
    Provider.of<UserDataChannelManager>(context, listen: false);

    return MultiProvider(
      providers: [
        ProxyProvider<Dio, InvitesRestClient>(
          update: (_, dio, __) {
            return InvitesRestClient(dio);
          },
        ),
        ChangeNotifierProxyProvider2<AppDatabase, InvitesRestClient,
            InvitesViewModel>(
          create: (_) => InvitesViewModel(),
          update: (_, appDatabase, invitesRestClient, viewModel) {
            // viewModel.setInviteRepository = inviteRepository;
            viewModel?.setAppDatabase = appDatabase;
            viewModel?.setInvitesRestClient = invitesRestClient;
            return viewModel!;
          },
        ),
        ChangeNotifierProxyProvider2<AppDatabase, ChatsRestClient,
            ChatsViewModel>(
          create: (_) => ChatsViewModel(),
          update: (_, db, chatsRestClient, viewModel) {
            viewModel!.chatsRestClient = chatsRestClient;
            viewModel.setAppDatabase = db;
            return viewModel;
          },
        ),
        ChangeNotifierProxyProvider2<AppDatabase, UserProfilesRestClient,
            UserProfileViewModel>(
          create: (_) => UserProfileViewModel(),
          update: (_, db, userProfilesRestClient, viewModel) {
            viewModel!.userProfilesRestClient = userProfilesRestClient;
            viewModel.setAppDatabase = db;
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
                topRight: Radius.circular(15.r),
                topLeft: Radius.circular(15.r)),
            boxShadow: [
              const BoxShadow(
                  color: Colors.black26, spreadRadius: 0, blurRadius: 0.1),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
            ),
            child: BottomNavigationBar(
              elevation: 8.sp,
              iconSize: 23.sp,
              selectedFontSize: 10.sp,
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
