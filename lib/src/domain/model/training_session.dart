import 'package:training_log_app/src/domain/model/exercise.dart';

class TrainingSession {
  final String id;
  final String userId;
  final String title;
  final DateTime date;
  final String timeOfDay;
  final List<Exercise> exercises;
  final String notes;
  final int difficultyRating;
  final List<String> photoUrls;

  TrainingSession({
    required this.id,
    required this.userId,
    required this.title,
    required this.date,
    required this.timeOfDay,
    required this.exercises,
    required this.notes,
    required this.difficultyRating,
    required this.photoUrls,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'date': date.toIso8601String(),
      'timeOfDay': timeOfDay,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'notes': notes,
      'difficultyRating': difficultyRating,
      'photoUrls': photoUrls,
    };
  }

  factory TrainingSession.fromJson(Map<String, dynamic> json) {
    return TrainingSession(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      timeOfDay: json['timeOfDay'] as String,
      exercises: (json['exercises'] as List)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String,
      difficultyRating: json['difficultyRating'] as int,
      photoUrls: (json['photoUrls'] as List).cast<String>(),
    );
  }

  TrainingSession copyWith({
    String? id,
    String? userId,
    String? title,
    DateTime? date,
    String? timeOfDay,
    List<Exercise>? exercises,
    String? notes,
    int? difficultyRating,
    List<String>? photoUrls,
  }) {
    return TrainingSession(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      date: date ?? this.date,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      exercises: exercises ?? this.exercises,
      notes: notes ?? this.notes,
      difficultyRating: difficultyRating ?? this.difficultyRating,
      photoUrls: photoUrls ?? this.photoUrls,
    );
  }
}
