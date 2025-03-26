import 'package:flutter/material.dart';

class AddTenderForm extends StatefulWidget {
  @override
  _AddTenderFormState createState() => _AddTenderFormState();
}

class _AddTenderFormState extends State<AddTenderForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _tenderFields = {};
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Tender'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section in Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tender Title',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Enter Tender Title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Key-Value Pair Section with Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tender Description (Key-Value Pairs)',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          // Key input field
                          Expanded(
                            child: TextFormField(
                              controller: _keyController,
                              decoration: InputDecoration(
                                labelText: 'Key',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          // Value input field
                          Expanded(
                            child: TextFormField(
                              controller: _valueController,
                              decoration: InputDecoration(
                                labelText: 'Value',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          // Add Key-Value Pair Button (Icon)
                          IconButton(
                            icon: Icon(Icons.add, color: Colors.deepPurple),
                            onPressed: _addKeyValuePair,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Display added key-value pairs as a complete description
              Text(
                'Tender Description (Complete):',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _tenderFields.isEmpty
                  ? Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('No description added yet.'),
                      ),
                    )
                  : Column(
                      children: _tenderFields.entries
                          .map((entry) => _buildKeyValueDisplay(entry.key, entry.value))
                          .toList(),
                    ),
              SizedBox(height: 16),

              // Submit Button
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit Tender'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to add the new key-value pair to the description
  void _addKeyValuePair() {
    if (_keyController.text.isNotEmpty && _valueController.text.isNotEmpty) {
      setState(() {
        _tenderFields[_keyController.text] = _valueController.text;

        // Clear the key-value input fields after adding
        _keyController.clear();
        _valueController.clear();
      });
    }
  }

  // Function to display the key-value pairs in a nice format
  Widget _buildKeyValueDisplay(String key, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$key: ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Concatenate the key-value pairs into a single description
  String _getTenderDescription() {
    List<String> descriptionList = [];
    _tenderFields.forEach((key, value) {
      descriptionList.add('$key: $value');
    });
    return descriptionList.join('\n');
  }

  // Submit the form and send data to backend
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // You can send the _tenderFields and title to your backend here
      print('Tender Title: ${_titleController.text}');
      print('Tender Description: ${_getTenderDescription()}');
      // Example: tenderViewModel.addTender(_titleController.text, _getTenderDescription());
    }
  }
}
