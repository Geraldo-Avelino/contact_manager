// lib/screens/contact_list_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contact_controller.dart';
import '../models/contact.dart';
import 'contact_form_screen.dart';
import '../widgets/contact_list_item.dart';

class ContactListScreen extends StatelessWidget {
  final ContactController controller = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.person_outline),
            SizedBox(width: 8),
            Text('Lista de Contatos'),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.contacts.isEmpty) {
          return Center(child: Text('Nenhum contato encontrado'));
        }
        return ListView.builder(
          itemCount: controller.contacts.length,
          itemBuilder: (context, index) {
            return ContactListItem(
              contact: controller.contacts[index],
              onEdit: () => _editContact(context, controller.contacts[index]),
              onDelete: () => _deleteContact(controller.contacts[index]),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addContact(context),
      ),
    );
  }

  void _addContact(BuildContext context) {
    Get.to(() => ContactFormScreen());
  }

  void _editContact(BuildContext context, Contact contact) {
    Get.to(() => ContactFormScreen(contact: contact));
  }

  void _deleteContact(Contact contact) {
    Get.defaultDialog(
      title: 'Confirmar Exclusão',
      content: Column(
        children: [
          Text('Tem certeza que deseja excluir este contato?'),
          SizedBox(height: 8),
          Text(
            contact.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      textConfirm: 'Excluir',
      textCancel: 'Cancelar',
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.deleteContact(contact.id!);
        Get.back();
      },
    );
  }
}