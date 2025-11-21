import 'package:bloc/bloc.dart';
import '../models/menu_model.dart';

class OrderState {
  final Map<String, OrderEntry> entries;

  OrderState({required this.entries});

  OrderState copyWith({
    Map<String, OrderEntry>? entries,
  }) {
    return OrderState(
      entries: entries ?? this.entries,
    );
  }
}

class OrderEntry {
  final MenuModel menu;
  final int qty;

  OrderEntry({
    required this.menu,
    required this.qty,
  });

  OrderEntry copyWith({MenuModel? menu, int? qty}) {
    return OrderEntry(
      menu: menu ?? this.menu,
      qty: qty ?? this.qty,
    );
  }
}

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderState(entries: {}));

  // ===========================================================
  // 1. Tambah ke order
  // ===========================================================
  void addToOrder(MenuModel menu) {
    final newEntries = Map<String, OrderEntry>.from(state.entries);

    if (newEntries.containsKey(menu.id)) {
      final current = newEntries[menu.id]!;
      newEntries[menu.id] =
          current.copyWith(qty: current.qty + 1);
    } else {
      newEntries[menu.id] = OrderEntry(menu: menu, qty: 1);
    }

    emit(state.copyWith(entries: newEntries));
  }

  // ===========================================================
  // 2. Hapus 1 item dari order
  // ===========================================================
  void removeFromOrder(MenuModel menu) {
    final newEntries = Map<String, OrderEntry>.from(state.entries);

    if (!newEntries.containsKey(menu.id)) return;

    final current = newEntries[menu.id]!;
    if (current.qty > 1) {
      newEntries[menu.id] =
          current.copyWith(qty: current.qty - 1);
    } else {
      newEntries.remove(menu.id);
    }

    emit(state.copyWith(entries: newEntries));
  }

  // ===========================================================
  // 3. Update qty secara langsung
  // ===========================================================
  void updateQuantity(MenuModel menu, int qty) {
    final newEntries = Map<String, OrderEntry>.from(state.entries);

    if (qty <= 0) {
      newEntries.remove(menu.id);
    } else {
      newEntries[menu.id] =
          OrderEntry(menu: menu, qty: qty);
    }

    emit(state.copyWith(entries: newEntries));
  }

  // ===========================================================
  // 4. Hitung subtotal (tanpa diskon)
  // ===========================================================
  int getSubtotal() {
    int sum = 0;
    for (var item in state.entries.values) {
      sum += item.menu.getDiscountedPrice() * item.qty;
    }
    return sum;
  }

  // ===========================================================
  // 5. Dapatkan total diskon (10% jika > 100.000)
  // ===========================================================
  int getTotalDiscountAmount() {
    final subtotal = getSubtotal();

    if (subtotal > 100000) {
      return (subtotal * 0.10).toInt();
    }

    return 0;
  }

  // ===========================================================
  // 6. Total akhir setelah diskon
  // ===========================================================
  int getTotalPrice() {
    final subtotal = getSubtotal();
    final discount = getTotalDiscountAmount();
    return subtotal - discount;
  }

  // ===========================================================
  // 7. Hapus seluruh pesanan
  // ===========================================================
  void clearOrder() {
    emit(OrderState(entries: {}));
  }
}
