import 'package:flutter/material.dart';
import '../models/menu_model.dart';
import '../widgets/menu_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/order_cubit.dart';

class CategoryStackPage extends StatefulWidget {
  final List<MenuModel> allMenus;
  const CategoryStackPage({Key? key, required this.allMenus}) : super(key: key);

  @override
  State<CategoryStackPage> createState() => _CategoryStackPageState();
}

class _CategoryStackPageState extends State<CategoryStackPage> {
  // kategori yang ada (diambil dari data)
  late final List<String> categories;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    final set = <String>{};
    for (var m in widget.allMenus) set.add(m.category);
    categories = set.toList();
    if (categories.isEmpty) categories.add('All');
  }

  @override
  Widget build(BuildContext context) {
    // untuk gaya rapi, kita tampilkan kategori di atas, kemudian Stack menampilkan halaman kategori.
    return Column(
      children: [
        const SizedBox(height: 12),
        SizedBox(
          height: 48,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final cat = categories[index];
              final isActive = index == activeIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    activeIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isActive ? Theme.of(context).primaryColor : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Text(
                      cat,
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.black87,
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Stack(
            children: [
              for (int i = 0; i < categories.length; i++)
                Offstage(
                  offstage: i != activeIndex,
                  child: buildCategoryList(categories[i]),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCategoryList(String category) {
    final items = widget.allMenus.where((m) => m.category == category).toList();
    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.only(bottom: 80),
      itemBuilder: (context, index) {
        return MenuCard(menu: items[index]);
      },
    );
  }
}
