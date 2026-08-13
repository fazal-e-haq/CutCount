import 'package:cut_count/core/constants/app_sizes.dart';
import 'package:cut_count/core/widgets/app_ui/app_ui.dart';
import 'package:cut_count/core/widgets/auto_size_text/reusable_auto_size_text.dart';
import 'package:cut_count/core/widgets/buttons/reusable_button.dart';
import 'package:cut_count/core/widgets/text_fields/reusable_text_field.dart';
import 'package:cut_count/features/services/providers/services_provider.dart';
import 'package:cut_count/data/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../settings/providers/settings_provider.dart';

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

  void _addService([ServiceModel? existingService]) {
    final name = _nameController.text.trim();
    final price = _priceController.text.trim();
    if (name.isEmpty || price.isEmpty) return;

    if (existingService != null) {
      existingService
        ..name = name
        ..price = double.tryParse(price) ?? 0.0
        ..iconCodePoint = _selectedIcon.codePoint
        ..note = _noteController.text.trim();
      context.read<ServicesProvider>().updateService(existingService);
    } else {
      context.read<ServicesProvider>().addService(
            ServiceModel()
              ..name = name
              ..price = double.tryParse(price) ?? 0.0
              ..iconCodePoint = _selectedIcon.codePoint
              ..note = _noteController.text.trim(),
          );
    }

    _nameController.clear();
    _priceController.clear();
    _noteController.clear();
    FocusScope.of(context).unfocus();
  }

  void _openAddSheet([ServiceModel? existingService]) {
    if (existingService != null) {
      _nameController.text = existingService.name;
      _priceController.text = existingService.price.toInt().toString();
      _noteController.text = existingService.note;
      // Find matching icon from our list if possible
      _selectedIcon = _icons.firstWhere(
        (i) => i.codePoint == existingService.iconCodePoint,
        orElse: () => Icons.content_cut,
      );
    } else {
      _nameController.clear();
      _priceController.clear();
      _noteController.clear();
      _selectedIcon = Icons.content_cut;
    }
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
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
                      existingService != null ? 'Edit service' : 'Add service',
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
                          padding: const EdgeInsets.all(AppSizes.sm),
                          label: Icon(
                            icon,
                            size: 28,
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
                        _addService(existingService);
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

  void _showDeleteDialog(BuildContext context, ServiceModel service) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Service'),
        content: Text('Are you sure you want to delete ${service.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<ServicesProvider>().deleteService(service.id);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${service.name} deleted'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text('Delete', style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppUi(
      appBarTitle: const Text('Services'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddSheet(),
        child: const Icon(Icons.add),
      ),
      slivers: [
        Consumer2<ServicesProvider, SettingsProvider>(
          builder: (context, provider, settings, child) {
            return SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
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
                      if (provider.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppSizes.md),
                          child: Text(
                            provider.errorMessage!,
                            style: TextStyle(color: Theme.of(context).colorScheme.error),
                          ),
                        ),
                      if (provider.isLoading && provider.services.isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.only(bottom: AppSizes.md),
                          child: LinearProgressIndicator(),
                        ),
                    ],
                  ),
                ),
                if (provider.isLoading && provider.services.isEmpty)
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  SliverList.builder(
                    itemCount: provider.services.length,
                    itemBuilder: (context, index) {
                      final service = provider.services[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: AppSizes.md),
                        elevation: 0,
                        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(AppSizes.md),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
                                radius: 28,
                                child: Icon(
                                  // ignore: non_const_argument_for_const_parameter
                                  IconData(service.iconCodePoint, fontFamily: 'MaterialIcons'),
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(width: AppSizes.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReusableAutoSizeText(
                                      service.name,
                                      maxLines: 1,
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      service.note.isEmpty ? 'No additional note' : service.note,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${settings.currencySymbol} ${service.price.toInt()}',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: AppSizes.sm),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    tooltip: 'Edit service',
                                    onPressed: () => _openAddSheet(service),
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    tooltip: 'Delete service',
                                    onPressed: () => _showDeleteDialog(context, service),
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
