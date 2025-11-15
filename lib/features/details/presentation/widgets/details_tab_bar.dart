import 'package:ecommerce/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DetailsTabBar extends StatelessWidget {
  final String selectedTab;
  final ValueChanged<String> onTabSelected;

  const DetailsTabBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTabButton('description', 'Description'),
        const SizedBox(width: 8),
        _buildTabButton('specification', 'Specification'),
      ],
    );
  }

  Widget _buildTabButton(String key, String label) {
    final isSelected = selectedTab == key;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(key),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.accentColor : Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
