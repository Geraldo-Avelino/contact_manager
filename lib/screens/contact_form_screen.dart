// lib/screens/contact_form_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contact_controller.dart';
import '../models/contact.dart';
import '../widgets/custom_text_field.dart';

class ContactFormScreen extends StatefulWidget {
  final Contact? contact;

  ContactFormScreen({this.contact});

  @override
  _ContactFormScreenState createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final ContactController controller = Get.find();

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      _nameController.text = widget.contact!.name;
      _phoneController.text = widget.contact!.phone;
      _emailController.text = widget.contact!.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text(widget.contact == null ? 'Criar Usuário' : 'Editar Contato'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: _nameController,
                label: widget.contact == null ? 'Nome de Usuário' : 'Nome',
                placeholder: 'Digite seu nome de usuário',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite o nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: _phoneController,
                label: 'Telefone',
                placeholder: 'Digite seu telefone',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite o telefone';
                  }
                  if (!RegExp(r'^\d{10,11}$').hasMatch(value)) {
                    return 'Telefone inválido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                label: 'Email',
                placeholder: 'Digite seu email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite o email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                child: Text(widget.contact == null ? 'Criar Usuário' : 'Salvar'),
                onPressed: _submitForm,
              ),
              SizedBox(height: 12),
              TextButton(
                child: Text('Cancelar'),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final contact = Contact(
        id: widget.contact?.id,
        name: _nameController.text,
        phone: _phoneController.text,
        email: _emailController.text,
      );

      if (widget.contact == null) {
        controller.addContact(contact);
      } else {
        controller.updateContact(contact);
      }

      Get.back();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}