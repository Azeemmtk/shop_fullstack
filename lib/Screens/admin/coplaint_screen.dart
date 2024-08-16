import 'package:flutter/material.dart';

import '../../utils/contants.dart';

class Complaint extends StatefulWidget {
  const Complaint({super.key});

  @override
  State<Complaint> createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  // Sample complaints data
  final List<Map<String, String>> complaints = [
    {
      "title": "Slow Service",
      "description": "The service was very slow and unsatisfactory.",
      "date": "2024-08-10"
    },
    {
      "title": "Product Defect",
      "description": "The product I received had a defect in it.",
      "date": "2024-08-11"
    },
    {
      "title": "Late Delivery",
      "description": "The delivery was delayed by three days.",
      "date": "2024-08-12"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [maincolor, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Row(
          children: [
            Text(
              'Complaints',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          final complaint = complaints[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                complaint["title"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    complaint["description"]!,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Date: ${complaint["date"]}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle complaint item tap
              },
            ),
          );
        },
      ),
    );
  }
}
