import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobsController extends GetxController {
  var isLoading = true.obs;
  var jobs = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId');
      if (userId != null) {
        final response =
            await http.get(Uri.parse('http://127.0.0.1:8000/jobs/details/$userId'));
        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          jobs.value = jsonData;
        } else {
          throw Exception('Failed to fetch jobs');
        }
      } else {
        throw Exception('User ID not found in local storage');
      }
    } catch (e) {
      print('Error fetching jobs: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteJob(int jobId) async {
    try {
      final response =
          await http.delete(Uri.parse('http://127.0.0.1:8000/jobs/delete/$jobId'));
      if (response.statusCode == 200) {
        jobs.removeWhere((job) => job['id'] == jobId);
        Get.snackbar('Success', 'Job deleted successfully',
            duration: Duration(seconds: 2));
      } else {
        throw Exception('Failed to delete job');
      }
    } catch (e) {
      print('Error deleting job: $e');
    }
  }
}
