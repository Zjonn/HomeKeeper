class MemberPoints {
  final String userId;
  final List<int> points;
  late final int pointsSum;

  MemberPoints(this.userId, this.points) {
    pointsSum = points.fold(0, (v, e) => v + e);
  }
}
