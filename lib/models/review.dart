class Review {
  final String placeId;
  final String userId;
  final String timeAdded;
  final String comment;
  final int overallRating;
  final int locationRating;
  final int custServRating;
  final int amenitiesRating;

  Review({
    this.placeId = "",
    this.userId = "",
    this.timeAdded = "",
    this.comment = "",
    this.overallRating = 0,
    this.locationRating = 0,
    this.custServRating = 0,
    this.amenitiesRating = 0,
  });
}
