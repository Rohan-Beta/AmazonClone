import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final String query;

  const ResultScreen({super.key, required this.query});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
