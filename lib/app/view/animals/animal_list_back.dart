//@dart=2.9
// ignore_for_file: prefer_final_fields

import 'package:tcc/app/domain/entities/animal.dart';
import 'package:tcc/app/domain/services/animal_service.dart';
import 'package:tcc/app/my_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'animal_list_back.g.dart';

class AnimalListBack = _AnimalListBack with _$AnimalListBack;

abstract class _AnimalListBack with Store {
  var _service = GetIt.I.get<AnimalService>();

  //lista de contatos
  @observable
  Future<List<Animal>> list;

  //método para atualizar a lista de contatos
  @action
  refreshList([dynamic value]) {
    list = _service.find();
  }

  _AnimalListBack() {
    refreshList();
  }

  //método para chamar o form salvar/alterar
  goToForm(BuildContext context, [Animal animal]) {
    Navigator.of(context)
        .pushNamed(MyApp.ANIMAL_FORM, arguments: animal)
        .then(refreshList);
  }

  goToDetails(BuildContext context, Animal animal) {
    Navigator.of(context).pushNamed(MyApp.ANIMAL_DETAILS, arguments: animal);
  }

  //excluir
  remove(dynamic id) {
    _service.remove(id);
    refreshList();
  }
}
