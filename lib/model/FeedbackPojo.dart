// To parse this JSON data, do
//
//     final feedbackPojo = feedbackPojoFromJson(jsonString);

import 'dart:convert';

FeedbackPojo feedbackPojoFromJson(String str) => FeedbackPojo.fromJson(json.decode(str));

String feedbackPojoToJson(FeedbackPojo data) => json.encode(data.toJson());

class FeedbackPojo {
  FeedbackPojo({
    this.status,
    this.message,
    this.totalRating,
    this.ratingDetail,
  });

  int? status;
  String? message;
  int? totalRating;
  List<RatingDetail>? ratingDetail;

  factory FeedbackPojo.fromJson(Map<String, dynamic> json) => FeedbackPojo(
    status: json["status"],
    message: json["message"],
    totalRating: json["total_rating"],
    ratingDetail: List<RatingDetail>.from(json["Rating Detail"].map((x) => RatingDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "total_rating": totalRating,
    "Rating Detail": List<dynamic>.from(ratingDetail!.map((x) => x.toJson())),
  };
}

class RatingDetail {
  RatingDetail({
    this.id,
    this.rating,
    this.comment,
    this.user_name,
    this.date,
  });


  int? id;
  int? rating;
  String? comment;
  String?user_name;
  String?date;

  factory RatingDetail.fromJson(Map<String, dynamic> json) => RatingDetail(
    id: json["id"],
    rating: json["rating"],
    comment: json["comment"],
    user_name: json["user_name"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "comment": comment,
    "user_name": user_name,
    "date": date,
  };
}
