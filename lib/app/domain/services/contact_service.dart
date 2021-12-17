//@dart=2.9
// ignore_for_file: prefer_final_fields

import 'package:tcc/app/domain/entities/contact.dart';
import 'package:tcc/app/domain/exception/domain_layer_exception.dart';
import 'package:tcc/app/domain/interfaces/contact_dao.dart';
import 'package:get_it/get_it.dart';

class ContactService {
  var _dao = GetIt.I.get<ContactDAO>();

  save(Contact contact) {
    validateIdentification(contact.identificacao);
    validateEmail(contact.email);
    validatePhone(contact.telefone);
    _dao.save(contact);
  }

  remove(dynamic id) {
    _dao.remove(id);
  }

  Future<List<Contact>> find() {
    return _dao.find();
  }

  validateIdentification(String identificacao) {
    if (identificacao == null) {
      throw DomainLayerException('A identificacao é obrigatória.');
    }
  }

  validateEmail(String email) {
    if (email == null) {
      throw DomainLayerException('O e-mail é obrigatório.');
    }
  }

  validatePhone(String phone) {
    if (phone == null) {
      throw DomainLayerException('O telefone é obrigatório.');
    }
  }
}
