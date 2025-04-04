
import 'package:cached_network_image/cached_network_image.dart';
import 'package:david_weijian_test/presentation/controllers/bug_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BugReportScreen extends StatelessWidget {
  final BugReportController controller = Get.find<BugReportController>();

  BugReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bug Reports'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshReports,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        return _buildReportList();
      }),
    );
  }

  Widget _buildReportList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: controller.bugReports.length,
      itemBuilder: (context, index) {
        final report = controller.bugReports[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ExpansionTile(
            title: Text(report.project, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(report.screenName),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(report.message),
                    const SizedBox(height: 16),
                    _buildImagePreview(report.image),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Created: ${report.formattedCreatedAt}'),
                        Text('Updated: ${report.formattedUpdatedAt}'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImagePreview(String imageUrl) {
    return GestureDetector(
      onTap: () => _showFullScreenImage(imageUrl),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200,
          placeholder: (context, url) => Container(
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[200],
            child: const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  void _showFullScreenImage(String imageUrl) {
    Get.dialog(
      Dialog(
        child: Stack(
          children: [
            InteractiveViewer(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}