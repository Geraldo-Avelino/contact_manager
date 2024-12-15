import 'package:get/get.dart';
import '../models/contact.dart';
import '../services/database_service.dart';

class ContactController extends GetxController {
  final DatabaseService _db = DatabaseService();
  final RxList<Contact> contacts = <Contact>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadContacts();
  }

  Future<void> loadContacts() async {
    isLoading.value = true;
    contacts.value = await _db.getAllContacts();
    isLoading.value = false;
  }

  Future<void> addContact(Contact contact) async {
    await _db.createContact(contact);
    await loadContacts();
  }

  Future<void> updateContact(Contact contact) async {
    await _db.updateContact(contact);
    await loadContacts();
  }

  Future<void> deleteContact(int id) async {
    await _db.deleteContact(id);
    await loadContacts();
  }
}