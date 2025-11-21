import 'package:flutter/material.dart';
import '../models/menu_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/order_cubit.dart';

class MenuCard extends StatelessWidget {
  final MenuModel menu;
  const MenuCard({Key? key, required this.menu}) : super(key: key);

  String formatRupiah(int value) {
    // sederhana: format dengan titik ribuan
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
    final discountedPrice = menu.getDiscountedPrice();
    final hasDiscount = menu.discount > 0.0;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // placeholder image box
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text(menu.name[0].toUpperCase(), style: TextStyle(fontSize: 24))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(menu.name, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      if (hasDiscount)
                        Text(
                          'Rp ${formatRupiah(menu.price)}',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                          ),
                        ),
                      if (hasDiscount) const SizedBox(width: 8),
                      Text(
                        'Rp ${formatRupiah(discountedPrice)}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: hasDiscount ? Colors.green.shade700 : Colors.black87,
                        ),
                      ),
                      if (hasDiscount) const SizedBox(width: 8),
                      if (hasDiscount)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '-${(menu.discount * 100).toInt()}%',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // tombol tambah
            ElevatedButton(
              onPressed: () {
                context.read<OrderCubit>().addToOrder(menu);
                final snack = SnackBar(content: Text('${menu.name} ditambahkan ke pesanan'));
                ScaffoldMessenger.of(context).showSnackBar(snack);
              },
              child: const Text('Tambah'),
            ),
          ],
        ),
      ),
    );
  }
}
