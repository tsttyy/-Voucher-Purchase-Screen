import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state_management/voucher_providers.dart';

/// Reusable Amount Input Widget
/// Handles amount input with validation and ₹ prefix
class AmountInputWidget extends ConsumerWidget {
  const AmountInputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validationError = ref.watch(validationErrorMessageProvider);
    final notifier = ref.read(voucherNotifierProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        TextField(
          key: const Key('amount_input_field'),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixText: '₹',
            prefixStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            hintText: 'Enter amount',
            errorText: validationError,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
          ),
          onChanged: (value) {
            final parsedAmount = double.tryParse(value) ?? 0.0;
            notifier.updateAmount(parsedAmount);
          },
        ),
      ],
    );
  }
}
