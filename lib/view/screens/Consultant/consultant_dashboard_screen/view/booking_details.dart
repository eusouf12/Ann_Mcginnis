import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingDetailsController extends GetxController {
  // Header Data
  final clientName = "Sarah Mitchell".obs;
  final bookingTime = "March 15, 2024 • 2:00 PM - 3:00 PM".obs;
  final bookingStatus = "Confirmed".obs;

  // Client Info Data
  final clientInfo = {
    "Full Name": "Sarah Mitchell",
    "Phone": "+1 (555) 123-4567",
    "Email": "sarah.m@email.com",
    "Nationality": "Canadian",
    "Immigration Interest": "Work Visa",
  }.obs;

  // Consultation Details Data
  final consultationDetails = {
    "Type": "General Consultation",
    "Duration": "1 hour",
    "Location": "Virtual",
  }.obs;

  // Booking History Timeline
  final bookingHistory = [
    {
      "title": "Consultation Confirmed",
      "date": "March 10, 2024 • 10:00 AM",
      "status": "confirmed"
    },
    {
      "title": "Booking Accepted",
      "date": "March 9, 2024 • 3:15 PM",
      "status": "accepted"
    },
    {
      "title": "Consultation Requested",
      "date": "March 8, 2024 • 2:45 PM",
      "status": "requested"
    },
  ].obs;

  // Documents List
  final clientDocuments = [
    {"name": "Resume.pdf", "date": "March 8, 2024", "type": "pdf"},
    {"name": "Passport_Copy.jpg", "date": "March 8, 2024", "type": "image"},
  ].obs;

  // Action Logs
  final actionLogs = [
    {"action": "Email confirmation sent", "status": "Success • 10:32 AM", "color": "green"},
    {"action": "Meeting link generated", "status": "Completed • 10:32 AM", "color": "blue"},
    {"action": "Calendar Invite sent", "status": "Pending • 10:35 AM", "color": "grey"},
  ].obs;

  // Methods
  void contactClient() => print("Contacting Client...");
  void rescheduleBooking() => print("Reschedule Clicked");
  void addNotes() => print("Add Notes Clicked");
  void joinMeeting() => print("Joining Meeting...");
}



class AppColors {
  static const Color primaryBlue = Color(0xFF0D3B66); // Dark Navy
  static const Color primaryYellow = Color(0xFFFFC107); // Amber/Yellow
  static const Color lightBlueBg = Color(0xFFE3F2FD);
  static const Color textBlack = Color(0xFF333333);
  static const Color textGrey = Color(0xFF757575);
  static const Color cardBg = Colors.white;
  static const Color scaffoldBg = Colors.white;
}

class BookingDetailsScreen extends StatelessWidget {
  BookingDetailsScreen({super.key});

  final BookingDetailsController controller = Get.put(BookingDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          "Booking Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text(
                  controller.clientName.value,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                )),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Obx(() => Text(
                    controller.bookingStatus.value,
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
                  )),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Obx(() => Text(
              controller.bookingTime.value,
              style: const TextStyle(fontSize: 12, color: AppColors.textGrey, fontWeight: FontWeight.w500),
            )),

            const SizedBox(height: 15),

            // --- CONTACT BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryYellow,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                onPressed: controller.contactClient,
                icon: const Icon(Icons.call, color: Colors.black, size: 20),
                label: const Text("Contact Client", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 20),

            // --- CLIENT INFORMATION CARD ---
            _buildSectionHeader("Client Information"),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardDecoration(),
              child: Obx(() => Column(
                children: controller.clientInfo.entries.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.key, style: const TextStyle(color: AppColors.textGrey, fontSize: 14)),
                        Text(e.value, style: const TextStyle(color: AppColors.textBlack, fontWeight: FontWeight.w600, fontSize: 14)),
                      ],
                    ),
                  );
                }).toList(),
              )),
            ),

            const SizedBox(height: 20),

            // --- CONSULTATION DETAILS CARD ---
            _buildSectionHeader("Consultation Details"),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardDecoration(),
              child: Column(
                children: [
                  ...controller.consultationDetails.entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.key, style: const TextStyle(color: AppColors.textGrey, fontSize: 14)),
                          Text(e.value, style: const TextStyle(color: AppColors.textBlack, fontWeight: FontWeight.w600, fontSize: 14)),
                        ],
                      ),
                    );
                  }).toList(),
                  // Link Row Specifically
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Meeting Link :", style: TextStyle(color: AppColors.textGrey, fontSize: 14)),
                      InkWell(
                        onTap: controller.joinMeeting,
                        child: Row(
                          children: const [
                            Icon(Icons.link, color: Colors.blue, size: 16),
                            SizedBox(width: 4),
                            Text("Join Meeting", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 15),

            // --- ACTION BUTTONS ROW ---
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryYellow,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: controller.rescheduleBooking,
                    icon: const Icon(Icons.calendar_today, size: 16),
                    label: const Text("Reschedule", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: controller.addNotes,
                    icon: const Icon(Icons.note_add, size: 16),
                    label: const Text("Add Notes", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // --- BOOKING HISTORY ---
            _buildSectionHeader("Booking History"),
            Obx(() => Column(
              children: controller.bookingHistory.map((item) {
                Color dotColor = item['status'] == 'confirmed' ? Colors.green
                    : item['status'] == 'accepted' ? Colors.blue
                    : Colors.grey;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Icon(Icons.circle, size: 12, color: dotColor),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Text(item['date']!, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            )),

            const SizedBox(height: 10),

            // --- NOTES ---
            _buildSectionHeader("Notes"),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Client is interested in work visa options for tech professionals. Has 5+ years experience in software development.\n\nAdded on March 10, 2024",
                style: TextStyle(fontSize: 13, color: AppColors.textBlack, height: 1.4),
              ),
            ),

            const SizedBox(height: 20),

            // --- CLIENT DOCUMENTS ---
            _buildSectionHeader("Client Documents"),
            Obx(() => Column(
              children: controller.clientDocuments.map((doc) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: _cardDecoration(bgColor: const Color(0xFFF8F9FA)),
                child: Row(
                  children: [
                    Icon(
                      doc['type'] == 'pdf' ? Icons.picture_as_pdf : Icons.image,
                      color: doc['type'] == 'pdf' ? Colors.red : Colors.blue,
                      size: 28,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doc['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Text("Uploaded: ${doc['date']}", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                    ),
                    const Icon(Icons.download, color: AppColors.primaryBlue, size: 22),
                  ],
                ),
              )).toList(),
            )),

            const SizedBox(height: 20),

            // --- ACTIONS LOG ---
            _buildSectionHeader("Actions Log"),
            Obx(() => Column(
              children: controller.actionLogs.map((log) {
                Color bgColor = log['color'] == 'green' ? const Color(0xFFE8F5E9)
                    : log['color'] == 'blue' ? const Color(0xFFE3F2FD)
                    : const Color(0xFFF5F5F5);
                Color textColor = log['color'] == 'green' ? Colors.green
                    : log['color'] == 'blue' ? Colors.blue
                    : Colors.grey;

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(log['action']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                      Text(log['status']!, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textColor)),
                    ],
                  ),
                );
              }).toList(),
            )),

            const SizedBox(height: 30),

            // --- BACK BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => Get.back(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.arrow_back, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text("Back to Bookings", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryBlue,
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration({Color bgColor = Colors.white}) {
    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.05),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}