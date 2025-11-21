import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/order_cubit.dart';
import 'pages/order_home_page.dart';

void main() {
  runApp(const KasirApp());
}

class KasirApp extends StatelessWidget {
  const KasirApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aplikasi Kasir',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: OrderHomePage(),
      ),
    );
  }
}
