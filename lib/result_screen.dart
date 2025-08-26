// lib/result_screen.dart
import 'package:flutter/material.dart';
import 'components/vyoora_scaffold.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> result;
  const ResultScreen({Key? key, required this.result}) : super(key: key);

  // normalize safety label
  String _classText(String s) {
    switch (s.toLowerCase()) {
      case 'safe':
        return 'Safe';
      case 'irritant':
        return 'Irritant';
      case 'comedogenic':
        return 'Comedogenic';
      case 'limited data':
      case 'not enough data':
        return 'Limited Data';
      default:
        return 'Limited Data';
    }
  }

  Color _classColor(String s) {
    switch (s.toLowerCase()) {
      case 'safe':
        return Colors.green;
      case 'irritant':
        return Colors.orange;
      case 'comedogenic':
        return Colors.redAccent;
      case 'limited data':
      case 'not enough data':
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List itemsRaw = (result['ingredients'] ?? []) as List;

    // map backend → UI schema (supports both key styles)
    final items = itemsRaw.map<Map<String, String>>((raw) {
      final m = (raw as Map).map((k, v) => MapEntry(k.toString(), v));
      final name = (m['name'] ?? m['ingredient'] ?? '').toString();
      final safetyRaw = (m['safety'] ?? m['classification'] ?? 'Limited Data').toString();
      final reason = (m['reason'] ?? '').toString();
      return {
        'name': name,
        'safety': _classText(safetyRaw),
        'reason': reason.isNotEmpty ? reason : 'No detailed rationale available yet.',
      };
    }).toList();

    final body = ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final ing = items[i];
        final name = ing['name'] ?? '';
        final safety = ing['safety'] ?? 'Limited Data';
        final reason = ing['reason'] ?? '';

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            title: Text(
              name.isEmpty ? 'Unnamed ingredient' : name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _classColor(safety).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: _classColor(safety).withOpacity(0.4)),
                  ),
                  child: Text(
                    safety,
                    style: TextStyle(
                      color: _classColor(safety),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
            children: [
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Why', style: Theme.of(context).textTheme.titleSmall),
              ),
              const SizedBox(height: 4),
              Text(reason),
            ],
          ),
        );
      },
    );

    // Use VyooraScaffold so the Chat FAB is present on this page
    return VyooraScaffold(
      title: 'Analysis Results',
      body: body,
      // showChatFab: true (default) -> FAB navigates to /chat
    );
  }
}
