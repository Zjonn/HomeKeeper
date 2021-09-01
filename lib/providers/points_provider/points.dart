import 'member_points.dart';

class Points {
  final Map<String, MemberPoints> membersPoints;
  final List<String> pointsDescription;
  late final int membersPointsSum;

  Points(this.membersPoints, this.pointsDescription) {
    membersPointsSum =
        membersPoints.values.map((e) => e.pointsSum).fold(0, (v, e) => v + e);
  }
}
