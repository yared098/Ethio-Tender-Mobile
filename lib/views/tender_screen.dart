import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ettmobile/core/viewmodel/tender_viewmodel.dart';
import 'package:ettmobile/core/viewmodel/auth_viewmodel.dart';

class TenderScreen extends StatefulWidget {
  @override
  _TenderScreenState createState() => _TenderScreenState();
}

class _TenderScreenState extends State<TenderScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> tenderData = {}; // Store the custom key-value pairs
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tenderViewModel = Provider.of<TenderViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Tenders')),
      body: ListView(
        children: [
          // Display the added key-value pairs
          ...tenderData.entries.map((entry) {
            return ListTile(
              title: Text(entry.key),
              subtitle: Text(entry.value.toString()),
            );
          }).toList(),

          // Display list of tenders if needed
          ListView.builder(
            shrinkWrap: true, // Prevent overflow by making it scrollable
            itemCount: tenderViewModel.tenders.length,
            itemBuilder: (context, index) {
              final tender = tenderViewModel.tenders[index];
              return ListTile(
                title: Text(tender.title),
                subtitle: Text(tender.description),
                trailing: Text('\$${tender.title}'),
              );
            },
          ),
        ],
      ),
      floatingActionButton: authViewModel.isAuthenticated
          ? FloatingActionButton(
              onPressed: _showAddTenderDialog,
              child: Icon(Icons.add),
            )
          : null,
    );
  }

  // Function to show dialog to add custom key-value pair
  void _showAddTenderDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Custom Tender Info'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _keyController,
                  decoration: InputDecoration(labelText: 'Key'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a key';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _valueController,
                  decoration: InputDecoration(labelText: 'Value'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  setState(() {
                    // Add the key-value pair to the tenderData map
                    tenderData[_keyController.text] = _valueController.text;
                  });
                  _keyController.clear();
                  _valueController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
