import 'package:flutter/material.dart';
import '../models/menu_model.dart';
import '../widgets/menu_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/order_cubit.dart';
import 'order_summary_page.dart';
import 'category_stack_page.dart';

class OrderHomePage extends StatelessWidget {
  OrderHomePage({Key? key}) : super(key: key);

  // contoh data menu
  final List<MenuModel> menus = [
    MenuModel(id: 'm1', name: 'Nasi Goreng', price: 25000, category: 'Makanan', discount: 0.1),
    MenuModel(id: 'm2', name: 'Mie Ayam', price: 20000, category: 'Makanan', discount: 0.0),
    MenuModel(id: 'm3', name: 'Es Teh', price: 8000, category: 'Minuman', discount: 0.2),
    MenuModel(id: 'm4', name: 'Kopi', price: 12000, category: 'Minuman', discount: 0.0),
    MenuModel(id: 'm5', name: 'Ayam Bakar', price: 35000, category: 'Makanan', discount: 0.15),
  ];

  @override
  Widget build(BuildContext context) {
    // kita akan memakai category_stack_page yang menerima daftar menu
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Kasir - Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BlocProvider.value(
                  value: context.read<OrderCubit>(),
                  child: OrderSummaryPage(),
                )),
              );
            },
          ),
        ],
      ),
      body: CategoryStackPage(allMenus: menus),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => BlocProvider.value(
              value: context.read<OrderCubit>(),
              child: OrderSummaryPage(),
            )),
          );
        },
        icon: const Icon(Icons.shopping_cart),
        label: const Text('Ringkasan'),
      ),
    );
  }
}
