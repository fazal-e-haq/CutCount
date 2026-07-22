import 'package:cut_count/core/constants/app_sizes.dart';
import 'package:cut_count/core/widgets/app_ui/app_ui.dart';
import 'package:cut_count/core/widgets/auto_size_text/reusable_auto_size_text.dart';
import 'package:cut_count/core/widgets/buttons/reusable_button.dart';
import 'package:cut_count/core/widgets/custom_list_tile.dart';
import 'package:cut_count/core/widgets/text_fields/reusable_text_field.dart';
import 'package:cut_count/features/services/providers/services_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final List<IconData> _icons = const [
    Icons.content_cut,
    Icons.face_retouching_natural,
    Icons.water_drop_rounded,
    Icons.brush_rounded,
    Icons.spa_outlined,
    Icons.content_cut_outlined,
    Icons.clean_hands_outlined,
    Icons.local_fire_department_outlined,
    Icons.auto_fix_high_outlined,
    Icons.badge_outlined,
    Icons.back_hand_outlined,
    Icons.calendar_month_outlined,
  ];
  IconData _selectedIcon = Icons.content_cut;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _addService() {
    final name = _nameController.text.trim();
    final price = _priceController.text.trim();
    if (name.isEmpty || price.isEmpty) return;

    context.read<ServicesProvider>().addService(
          ServiceItem(
            name: name,
            price: 'Rs. $price',
            icon: _selectedIcon,
            note: _noteController.text.trim(),
          ),
        );

    _nameController.clear();
    _priceController.clear();
    _noteController.clear();
    FocusScope.of(context).unfocus();
  }

  void _openAddSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: AppSizes.lg,
            right: AppSizes.lg,
            top: AppSizes.sm,
            bottom: MediaQuery.viewInsetsOf(sheetContext).bottom + AppSizes.lg,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ReusableAutoSizeText(
                      'Add service',
                      style: Theme.of(context).textTheme.headlineMedium,
                      maxLines: 1,
                    ),
                    const SizedBox(height: AppSizes.md),
                    ReusableTextField(
                      controller: _nameController,
                      labelText: 'Service name',
                      hintText: 'Fade Cut, Shave, Styling',
                      prefixIcon: const Icon(Icons.badge_outlined),
                    ),
                    const SizedBox(height: AppSizes.md),
                    ReusableTextField(
                      controller: _priceController,
                      labelText: 'Price',
                      hintText: '800',
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.payments_outlined),
                    ),
                    const SizedBox(height: AppSizes.md),
                    ReusableTextField(
                      controller: _noteController,
                      labelText: 'Note',
                      hintText: 'Optional service note',
                      maxLines: 3,
                      prefixIcon: const Icon(Icons.notes_outlined),
                    ),
                    const SizedBox(height: AppSizes.md),
                    ReusableAutoSizeText(
                      'Choose an icon',
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                    ),
                    const SizedBox(height: AppSizes.sm),
                    Wrap(
                      spacing: AppSizes.sm,
                      runSpacing: AppSizes.sm,
                      children: _icons.map((icon) {
                        final selected = _selectedIcon == icon;
                        return ChoiceChip(
                          selected: selected,
                          label: Icon(
                            icon,
                            size: 18,
                            color: selected
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                          onSelected: (_) {
                            setModalState(() => _selectedIcon = icon);
                            setState(() => _selectedIcon = icon);
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppSizes.lg),
                    ReusableButton(
                      text: 'Save service',
                      onPressed: () {
                        _addService();
                        Navigator.of(sheetContext).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppUi(
      appBarTitle: const Text('Services'),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddSheet,
        child: const Icon(Icons.add),
      ),
      body: Consumer<ServicesProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableAutoSizeText(
                'Add your services',
                style: Theme.of(context).textTheme.headlineMedium,
                maxLines: 1,
              ),
              const SizedBox(height: AppSizes.md),
              ReusableAutoSizeText(
                'Tap the + button to add a new service',
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
              ),
              const SizedBox(height: AppSizes.xl),
              ReusableAutoSizeText(
                'Your services',
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: 1,
              ),
              const SizedBox(height: AppSizes.md),
              ...provider.services.map(
                (service) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.sm),
                  child: CustomListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.12),
                      child: Icon(
                        service.icon,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    title: ReusableAutoSizeText(
                      service.name,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      service.note.isEmpty ? 'Tap to add a note' : service.note,
                    ),
                    trailing: Text(service.price),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
