import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/order_cubit.dart';
import '../models/menu_model.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({super.key});

  String formatRupiah(int value) {
    final s = value.toString();
    final buffer = StringBuffer();
    int cnt = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      buffer.write(s[i]);
      cnt++;
      if (cnt == 3 && i != 0) {
        buffer.write('.');
        cnt = 0;
      }
    }
    return buffer.toString().split('').reversed.join('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          final entries = state.entries.values.toList();

          if (entries.isEmpty) {
            return const Center(
              child: Text("Belum ada pesanan"),
            );
          }

          final cubit = context.read<OrderCubit>();
          final subtotal = cubit.getSubtotal();
          final discount = cubit.getTotalDiscountAmount();
          final totalAfterDiscount = cubit.getTotalPrice();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Detail Pesanan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // LIST PESANAN
                Expanded(
                  child: ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final item = entries[index];
                      final menu = item.menu;
                      final itemTotal = menu.getDiscountedPrice() * item.qty;

                      return ListTile(
                        title: Text(menu.name),
                        subtitle: Text(
                          "Qty: ${item.qty} • Rp ${formatRupiah(itemTotal)}",
                        ),
                      );
                    },
                  ),
                ),

                const Divider(height: 32),

                // SUBTOTAL
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Subtotal:"),
                    Text("Rp ${formatRupiah(subtotal)}"),
                  ],
                ),
                const SizedBox(height: 6),

                // DISKON (opsional)
                if (discount > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Diskon (10%):"),
                      Text(
                        "-Rp ${formatRupiah(discount)}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                const SizedBox(height: 10),

                // TOTAL AKHIR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Akhir:",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rp ${formatRupiah(totalAfterDiscount)}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // TOMBOL CHECKOUT
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // aksi checkout
                    },
                    child: const Text("Checkout"),
                  ),
                ),

                const SizedBox(height: 10),

                // TOMBOL CLEAR ORDER
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    onPressed: () {
                      cubit.clearOrder();
                    },
                    child: const Text("Clear Order"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
