import 'package:Matework/database.dart';
import 'package:Matework/services/user_data_channel_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = "/preferences";

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late UserProfile myProfile;

  @override
  void initState() {
    final myId =
        Provider.of<UserDataChannelManager>(context, listen: false).myId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
