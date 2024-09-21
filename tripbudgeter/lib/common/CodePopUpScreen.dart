import 'package:flutter/material.dart';

class CodeInputPopup extends StatefulWidget {
  @override
  _CodeInputPopupState createState() => _CodeInputPopupState();
}

class _CodeInputPopupState extends State<CodeInputPopup> {
  final TextEditingController _codeController = TextEditingController();
  String _errorCode = '';

  void _onSubmit() {
    setState(() {
      _errorCode =
          _codeController.text.length < 6 ? 'Code must be 6 digits' : '';
    });

    if (_errorCode.isEmpty) {
      print('Entered code: ${_codeController.text}');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Container(
        width: 400, // Đặt chiều rộng cho popup
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 15,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  '6 Digits Code',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  hintText: 'Enter code',
                  filled: true,
                  fillColor: Colors.purple.withOpacity(0.1),
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  errorText: _errorCode.isNotEmpty ? _errorCode : null,
                  prefixIcon: Icon(Icons.lock, color: Colors.purple),
                ),
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onSubmit,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.purple,
                  elevation: 5,
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Please check your email for the code.',
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
