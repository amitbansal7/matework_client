import 'package:Matework/network/response/invite_response.dart';

import '../database.dart';

Invite inviteFromInvitesResponse(InviteResponse e, bool seen) {
  return Invite(
    id: e.id!,
    message: e.message,
    createdAt: e.createdAt!,
    seen: seen,
    userAvatar: e.user?.avatar,
    userFirstName: e.user?.firstName,
    userLastName: e.user?.lastName,
    userShortBio: e.user?.shortBio,
    userId: e.user?.id,
  );
}
