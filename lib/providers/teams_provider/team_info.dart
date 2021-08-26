import 'package:home_keeper/graphql/graphql_api.dart';
import 'package:home_keeper/providers/teams_provider/team_member.dart';

class TeamInfo {
  final String id;
  final String name;
  final List<TeamMember> teamMembers;

  TeamInfo(this.id, this.name, this.teamMembers);

  TeamInfo.fromResp(ListUserTeamsInfo$Query$TeamType response)
      : this(response.id, response.name,
            response.members.map((e) => TeamMember.fromResp(e)).toList());
}
