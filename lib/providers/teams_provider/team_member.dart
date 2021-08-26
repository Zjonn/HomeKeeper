import 'dart:convert';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:home_keeper/graphql/graphql_api.dart';

class TeamMember {
  final String id;
  final String username;
  final Color color;

  TeamMember(this.id, this.username, this.color);

  TeamMember.fromResp(ListUserTeamsInfo$Query$TeamType$UserType resp)
      : this(resp.id, resp.username, generateColor(resp));

  static Color generateColor(final object) {
    final hash = md5.convert(utf8.encode(object.toString())).toString();
    final elemPerColor = hash.length ~/ 3;

    final r = hash.substring(0, elemPerColor).hashCode % 255;
    final g = hash.substring(elemPerColor, elemPerColor * 2).hashCode % 255;
    final b = hash.substring(elemPerColor * 2, hash.length).hashCode % 255;

    return Color.fromRGBO(r, g, b, 1);
  }
}
