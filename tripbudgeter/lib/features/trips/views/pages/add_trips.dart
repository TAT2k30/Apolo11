import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TripStepper extends StatefulWidget {
  @override
  _TripStepperState createState() => _TripStepperState();
}

class _TripStepperState extends State<TripStepper> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  String name = '';
  DateTime? startDate;
  DateTime? endDate;
  int totalBudget = 0;
  String status = 'Pending';
  String description = '';
  String destinationId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo chuyến đi'),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.withOpacity(0.9),
              Colors.blue.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Stepper(
            currentStep: _currentStep,
            onStepContinue: () {
              if (_formKey.currentState!.validate()) {
                if (_currentStep < 3) {
                  setState(() {
                    _currentStep++;
                  });
                } else {
                  // Xử lý dữ liệu chuyến đi ở đây
                  print('Tên chuyến đi: $name');
                  print('Ngân sách: $totalBudget');
                  print('Ngày bắt đầu: $startDate');
                  print('Ngày kết thúc: $endDate');
                  print('Trạng thái: $status');
                  print('Mô tả: $description');
                  print('ID địa điểm: $destinationId');
                }
              }
            },
            onStepCancel: () {
              if (_currentStep > 0) {
                setState(() {
                  _currentStep--;
                });
              }
            },
            steps: [
              _buildStep(
                title: 'Thông tin chuyến đi',
                content: _buildInfoForm(),
              ),
              _buildStep(
                title: 'Ngày',
                content: _buildDateSelection(),
              ),
              _buildStep(
                title: 'Trạng thái và mô tả',
                content: _buildStatusAndDescription(),
              ),
              _buildStep(
                title: 'Địa điểm',
                content: _buildDestinationInput(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Step _buildStep({required String title, required Widget content}) {
    return Step(
      title: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      content: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white.withOpacity(0.9),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: content,
        ),
      ),
    );
  }

  Widget _buildInfoForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Tên chuyến đi'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập tên chuyến đi';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Ngân sách (VND)'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập ngân sách';
              }
              return null;
            },
            onChanged: (value) {
              totalBudget = int.tryParse(value) ?? 0;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelection() {
    return Column(
      children: [
        TextButton(
          onPressed: () => _selectDate(context, true),
          style: TextButton.styleFrom(
            backgroundColor: Colors.purpleAccent,
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(
            startDate == null
                ? 'Chọn ngày bắt đầu'
                : 'Ngày bắt đầu: ${DateFormat('dd/MM/yyyy').format(startDate!)}',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 10),
        TextButton(
          onPressed: () => _selectDate(context, false),
          style: TextButton.styleFrom(
            backgroundColor: Colors.purpleAccent,
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(
            endDate == null
                ? 'Chọn ngày kết thúc'
                : 'Ngày kết thúc: ${DateFormat('dd/MM/yyyy').format(endDate!)}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusAndDescription() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: status,
          decoration: const InputDecoration(labelText: 'Trạng thái'),
          items: ['Pending', 'In Progress', 'Completed']
              .map((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              status = value!;
            });
          },
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Mô tả'),
          maxLines: 3,
          onChanged: (value) {
            setState(() {
              description = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDestinationInput() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'ID địa điểm'),
      onChanged: (value) {
        setState(() {
          destinationId = value;
        });
      },
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (startDate ?? DateTime.now())
          : (endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }
}
