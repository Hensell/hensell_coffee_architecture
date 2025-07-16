import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/datasources/coffee_database.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/datasources/coffee_local_data_source.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/datasources/coffee_remote_data_source.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/repositories/coffee_repository_impl.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/repositories/coffee_repository.dart';

class InjectionContainer extends StatelessWidget {
  const InjectionContainer({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CoffeeRepository>(
          create: (_) => CoffeeRepositoryImpl(
            localDataSource: CoffeeLocalDataSource(CoffeeDatabase()),
            remoteDataSource: CoffeeRemoteDataSource(),
          ),
        ),
      ],
      child: child,
    );
  }
}
