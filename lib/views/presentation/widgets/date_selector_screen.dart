import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectorRow extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const DateSelectorRow({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (index) {
        DateTime date = DateTime.now().add(Duration(days: index));
        String day = DateFormat('d').format(date);
        String month = DateFormat('MMM').format(date);

        bool isSelected = _isSameDate(date, selectedDate);

        return GestureDetector(
          onTap: () => onDateSelected(date),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 0,
                child: Container(
                  height: 6,
                  width: 50,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0XFFDCDCDC)
                        : Colors.black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                height: 80,
                width: 60,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0XFF120698)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      day,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      month,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
