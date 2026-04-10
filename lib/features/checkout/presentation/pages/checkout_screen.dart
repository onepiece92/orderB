import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../features/address/data/models/address.dart';
import '../../../../features/cart/presentation/providers/cart_provider.dart';
import '../../../../features/address/presentation/providers/address_provider.dart';
import 'package:intl/intl.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/app_back_button.dart';
import '../../../../features/cart/presentation/widgets/empty_cart_view.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'package:go_router/go_router.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _step = 1; // 1 = delivery, 2 = payment & confirm
  int _selectedPayment = 0; // Default to Cash on Delivery

  static const _paymentMethods = [
    (icon: '💵', label: 'Cash on Delivery', sub: 'Pay when your order arrives'),
    (icon: '💳', label: '•••• 4289', sub: 'Visa ending in 4289'),
    (icon: '🍎', label: 'Apple Pay', sub: 'Express checkout'),
  ];

  String _stepLabel(Address addr) =>
      addr.type == 'Pickup' ? 'Pickup' : 'Delivery';

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final addr = context.watch<AddressProvider>().selected;
    final step1Label = _stepLabel(addr);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Checkout'),
      ),
      body: SafeArea(
        child: cart.items.isEmpty
            ? const EmptyCartView()
            : Stack(
                children: [
                  Column(
                    children: [
                      // Step indicator
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                        child: Row(
                          children: [
                            _StepIndicator(
                                label: step1Label, step: 1, current: _step),
                            const SizedBox(width: 6),
                            _StepIndicator(
                                label: 'Payment & Confirm',
                                step: 2,
                                current: _step),
                          ],
                        ),
                      ),

                      // Step content
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 140),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: _step == 1
                                ? _Step1(addr: addr, key: const ValueKey(1))
                                : _Step2(
                                    cart: cart,
                                    addr: addr,
                                    methods: _paymentMethods,
                                    selected: _selectedPayment,
                                    onSelect: (i) =>
                                        setState(() => _selectedPayment = i),
                                    key: const ValueKey(2),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // CTA Button
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: PrimaryButton(
                      label: _step < 2
                          ? 'Continue'
                          : 'Place Order — Rs ${cart.total.toStringAsFixed(0)}',
                      onTap: () {
                        if (_step < 2) {
                          setState(() => _step++);
                        } else {
                          context.go('/cart/checkout/success');
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final String label;
  final int step;
  final int current;

  const _StepIndicator(
      {required this.label, required this.step, required this.current});

  @override
  Widget build(BuildContext context) {
    final active = step <= current;
    final isCurrent = step == current;
    return Expanded(
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: 3,
            decoration: BoxDecoration(
              color: active
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: active
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}

class _Step1 extends StatelessWidget {
  final dynamic addr;

  const _Step1({required this.addr, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${addr.type == 'Pickup' ? 'Pickup' : 'Delivery'} Details',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        _InfoTile(
          label: addr.type == 'Pickup' ? 'PICKUP LOCATION' : 'DELIVERY ADDRESS',
          icon: addr.icon,
          title: addr.label,
          subtitle: addr.address,
        ),
        const SizedBox(height: 12),
        _InfoTile(
          label: '${addr.type == 'Pickup' ? 'PICKUP' : 'DELIVERY'} TIME',
          icon: '🕐',
          title:
              'Today, ${DateFormat('h:mm a').format(DateTime.now().add(const Duration(minutes: 25)))}',
          subtitle: null,
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SPECIAL INSTRUCTIONS',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontSize: 11, letterSpacing: 0.5)),
                const SizedBox(height: 8),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Any special requests for your order...',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withValues(alpha: 0.5),
                        ),
                    border: InputBorder.none,
                    isDense: false,
                    contentPadding: const EdgeInsets.only(top: 8),
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String icon;
  final String title;
  final String? subtitle;

  const _InfoTile({
    required this.label,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(fontSize: 11, letterSpacing: 0.5)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(icon, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                      if (subtitle != null)
                        Text(subtitle!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Step2 extends StatelessWidget {
  final CartProvider cart;
  final dynamic addr;
  final List<({String icon, String label, String sub})> methods;
  final int selected;
  final ValueChanged<int> onSelect;

  const _Step2(
      {required this.cart,
      required this.addr,
      required this.methods,
      required this.selected,
      required this.onSelect,
      super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final receiptStyle = AppTextStyles.receipt;
    final headerStyle = receiptStyle.copyWith(
        color: theme.textTheme.bodySmall?.color);
    final subtotal = cart.subtotal;
    final total = cart.total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── Receipt Card ──────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Column(
            children: [
              // Store name
              Text(
                'La Petite Boulangerie',
                style: receiptStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colors.primary,
                ),
              ),
              const SizedBox(height: 12),
              // Dashed separator
              _dashedLine(context),
              const SizedBox(height: 12),
              // Table header
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Text('Item', style: headerStyle),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text('Qty', style: headerStyle,
                        textAlign: TextAlign.center),
                  ),
                  SizedBox(
                    width: 56,
                    child: Text('Rate', style: headerStyle,
                        textAlign: TextAlign.right),
                  ),
                  SizedBox(
                    width: 56,
                    child: Text('Amt', style: headerStyle,
                        textAlign: TextAlign.right),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Item rows
              ...cart.items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        item.product.name,
                        style: receiptStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: Text(
                        '${item.quantity}',
                        style: receiptStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 56,
                      child: Text(
                        item.product.price.toStringAsFixed(0),
                        style: receiptStyle,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      width: 56,
                      child: Text(
                        (item.product.price * item.quantity).toStringAsFixed(0),
                        style: receiptStyle,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 8),
              _dashedLine(context),
              const SizedBox(height: 12),
              // Subtotal
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal', style: headerStyle),
                  Text('Rs ${subtotal.toStringAsFixed(0)}', style: receiptStyle),
                ],
              ),
              const SizedBox(height: 4),
              // Delivery
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delivery', style: headerStyle),
                  Text('Free', style: receiptStyle),
                ],
              ),
              const SizedBox(height: 16),
              // Grand Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Grand Total',
                    style: theme.textTheme.headlineMedium,
                  ),
                  Text(
                    'Rs ${total.toStringAsFixed(0)}',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: colors.error,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // ─── Deliver To ────────────────────────────────────────
        Text('Deliver to',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                )),
        const SizedBox(height: 12),
        _SelectableCard(
          icon: Icons.location_on_rounded,
          iconColor: colors.error,
          title: addr.label,
          badge: addr.type,
          subtitle: addr.address,
        ),
        const SizedBox(height: 28),

        // ─── Payment Method ────────────────────────────────────
        Text('Payment Method',
            style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                )),
        const SizedBox(height: 12),
        _SelectableCard(
          icon: Icons.account_balance_wallet_rounded,
          iconColor: colors.error,
          title: methods[selected].label,
          subtitle: methods[selected].sub,
          onTap: () {
            // Cycle through payment methods
            onSelect((selected + 1) % methods.length);
          },
        ),
      ],
    );
  }

  Widget _dashedLine(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 5.0;
        const dashSpace = 3.0;
        final count =
            (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(count, (_) {
            return SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Theme.of(context).dividerColor),
              ),
            );
          }),
        );
      },
    );
  }
}

class _SelectableCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? badge;
  final String subtitle;
  final VoidCallback? onTap;

  const _SelectableCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.badge,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.error, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: colors.error.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            badge!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.error,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Icon(Icons.keyboard_arrow_down_rounded,
                color: theme.textTheme.bodySmall?.color, size: 24),
          ],
        ),
      ),
    );
  }
}
