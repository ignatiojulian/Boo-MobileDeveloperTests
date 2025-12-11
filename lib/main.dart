import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'matching/matching_cubit.dart';
import 'matching/matching_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Boo Matching',
      theme: ThemeData(colorSchemeSeed: Colors.pink, useMaterial3: true),
      home: BlocProvider(
        create: (_) => MatchingCubit(),
        child: const MatchingPage(),
      ),
    );
  }
}

