// lib/widgets/cart_dialog.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../cart/cart_model.dart';
import '../utils/app_reponsiveness/responsive_utils.dart';
import '../utils/app_reponsiveness/app_spaces.dart';

class CartDialog extends StatelessWidget {
  final CartModel cartModel;

  const CartDialog({super.key, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final dialogWidth = isMobile ? double.infinity : 520.0; // slightly wider for nicer layout on desktop
    final borderRadius = BorderRadius.circular(18.0);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: dialogWidth,
          maxHeight: MediaQuery.of(context).size.height * 0.88,
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Material(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(AppSpaces.horizontal(context, 16)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with rounded background
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E8FF), // soft header tint
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(LucideIcons.shoppingCart, size: 20, color: Colors.black87),
                        const SizedBox(width: 10),
                        const Text('Shopping Cart', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(LucideIcons.x),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // subtitle
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select the products you want to purchase.',
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // List
                  Expanded(
                    child: AnimatedBuilder(
                      animation: cartModel,
                      builder: (context, _) {
                        final prods = cartModel.products;
                        if (prods.isEmpty) {
                          return const Center(child: Text('No products available'));
                        }

                        return ListView.separated(
                          padding: const EdgeInsets.only(bottom: 8, top: 4),
                          itemCount: prods.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final p = prods[index];
                            final checked = cartModel.isSelected(p.id);

                            return InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => cartModel.toggleProduct(p.id),
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: checked ? Colors.blue.shade300 : Colors.grey.shade300,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x08000000),
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Checkbox area
                                    Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: checked ? Colors.blue : Colors.white,
                                        border: Border.all(
                                          color: checked ? Colors.blue : Colors.grey.shade400,
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: checked
                                          ? const Icon(LucideIcons.check, size: 14, color: Colors.white)
                                          : null,
                                    ),

                                    const SizedBox(width: 14),

                                    // Text block
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(p.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                '${p.originalPrice} AED',
                                                style: TextStyle(
                                                  decoration: TextDecoration.lineThrough,
                                                  color: Colors.red.shade700,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                p.installationText,
                                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(p.promoText, style: const TextStyle(color: Colors.green, fontSize: 13)),
                                          const SizedBox(height: 8),
                                          RichText(
                                            text: TextSpan(
                                              text: 'Subscription: ',
                                              style: const TextStyle(color: Colors.black87, fontSize: 13),
                                              children: [
                                                TextSpan(
                                                  text: p.subscriptionText,
                                                  style: const TextStyle(fontWeight: FontWeight.w700),
                                                ),
                                                const TextSpan(text: '  '),
                                                TextSpan(
                                                  text: 'No Commitment',
                                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Checkout button: always visible but disabled when none selected
                  AnimatedBuilder(
                    animation: cartModel,
                    builder: (context, _) {
                      final anySelected = cartModel.selectedCount > 0;

                      // Disabled style (grey)
                      if (!anySelected) {
                        return SizedBox(
                          width: double.infinity,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: AppSpaces.vertical(context, 12)),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Checkout',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }

                      // Enabled style (blue gradient)
                      return SizedBox(
                        width: double.infinity,
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap: () {
                              // close cart and open checkout dialog
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (_) => CheckoutDialog(cartModel: cartModel),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: AppSpaces.vertical(context, 12)),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'Checkout',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CheckoutDialog extends StatefulWidget {
  final CartModel cartModel;

  const CheckoutDialog({super.key, required this.cartModel});

  @override
  State<CheckoutDialog> createState() => _CheckoutDialogState();
}

class _CheckoutDialogState extends State<CheckoutDialog> {
  final _formKey = GlobalKey<FormState>();
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _company = TextEditingController();
  final _website = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _tax = TextEditingController();

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _company.dispose();
    _website.dispose();
    _phone.dispose();
    _address.dispose();
    _tax.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final productNames = widget.cartModel.selectedProducts
        .map((e) => (e as dynamic)?.name ?? '')
        .where((s) => s.isNotEmpty)
        .toList();
    final productsJoined = productNames.isEmpty ? '—' : productNames.join(', ');

    Navigator.of(context).pop(); // close checkout
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Purchased: $productsJoined')));

    widget.cartModel.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final dialogWidth = isMobile ? double.infinity : 420.0;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: dialogWidth),
        child: Padding(
          padding: EdgeInsets.all(AppSpaces.horizontal(context, 16)),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(children: [
                    const Text('Checkout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(LucideIcons.x))
                  ]),
                  const SizedBox(height: 8),
                  const Text('Please provide your details to complete the purchase.', style: TextStyle(color: Colors.black54)),
                  const SizedBox(height: 12),

                  // form fields
                  TextFormField(controller: _first, decoration: const InputDecoration(labelText: 'First Name'), validator: (v) => v == null || v.isEmpty ? 'Required' : null),
                  const SizedBox(height: 8),
                  TextFormField(controller: _last, decoration: const InputDecoration(labelText: 'Last Name'), validator: (v) => v == null || v.isEmpty ? 'Required' : null),
                  const SizedBox(height: 8),
                  TextFormField(controller: _company, decoration: const InputDecoration(labelText: 'Company Name'), validator: (v) => v == null || v.isEmpty ? 'Required' : null),
                  const SizedBox(height: 8),
                  TextFormField(controller: _website, decoration: const InputDecoration(labelText: 'Website'), validator: (v) => v == null || v.isEmpty ? 'Required' : null),
                  const SizedBox(height: 8),
                  TextFormField(controller: _phone, decoration: const InputDecoration(labelText: 'Telephone'), validator: (v) => v == null || v.isEmpty ? 'Required' : null),
                  const SizedBox(height: 8),
                  TextFormField(controller: _address, decoration: const InputDecoration(labelText: 'Address'), validator: (v) => v == null || v.isEmpty ? 'Required' : null),
                  const SizedBox(height: 8),
                  TextFormField(controller: _tax, decoration: const InputDecoration(labelText: 'Tax Number (optional)')),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: _submit, child: const Text('Complete Purchase')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
