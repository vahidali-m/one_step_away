import 'package:flutter/material.dart';

class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String type;
  final String logo;
  final String description;
  final List<String> skills;
  final String postedDate;
  final bool isFeatured;
  final String category;
  final int applicants;
  final Color? accentColor;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.type,
    required this.logo,
    required this.description,
    required this.skills,
    required this.postedDate,
    this.isFeatured = false,
    required this.category,
    this.applicants = 0,
    this.accentColor,
  });
}

class Course {
  final String id;
  final String title;
  final String instructor;
  final String category;
  final String thumbnail;
  final double rating;
  final int students;
  final String duration;
  final String level;
  final bool isPremium;
  final String price;
  final List<String> topics;
  final Color accentColor;

  Course({
    required this.id,
    required this.title,
    required this.instructor,
    required this.category,
    required this.thumbnail,
    required this.rating,
    required this.students,
    required this.duration,
    required this.level,
    required this.isPremium,
    required this.price,
    required this.topics,
    required this.accentColor,
  });
}

class HistoryItem {
  final String id;
  final String jobTitle;
  final String company;
  final String appliedDate;
  final String status; // Applied, Shortlisted, Interview, Rejected, Hired
  final String logo;

  HistoryItem({
    required this.id,
    required this.jobTitle,
    required this.company,
    required this.appliedDate,
    required this.status,
    required this.logo,
  });
}