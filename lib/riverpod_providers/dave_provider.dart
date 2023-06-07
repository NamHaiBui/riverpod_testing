import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Person {
  final String name;
  final int age;
  final String id;

  Person({required this.name, required this.age, String? id})
      : id = id ?? uuid.v4();
  Person updated([String? name, int? age]) =>
      Person(name: name ?? this.name, age: age ?? this.age, id: id);
  String get displayName => '$name ($age years old)';

  @override
  bool operator ==(covariant Person other) => id == other.id;

  @override
  int get hashCode => Object.hash(name, age, id);
}

class DataModel extends ChangeNotifier {
  final List<Person> _people = [];
  int get count => _people.length;

  UnmodifiableListView<Person> get people => UnmodifiableListView(_people);
  void addPerson(Person person) {
    _people.add(person);
    notifyListeners();
  }

  void remove(Person person) {
    _people.remove(person);
    notifyListeners();
  }

  void update(Person updatedPerson) {
    final index = _people.indexOf(updatedPerson);
    final oldPerson = _people[index];
    if (oldPerson.age != updatedPerson.age ||
        oldPerson.name != updatedPerson.name) {
      _people[index] = oldPerson.updated(
        updatedPerson.name,
        updatedPerson.age,
      );
      notifyListeners();
    }
  }
}

final peopleProvider = ChangeNotifierProvider((ref) => DataModel());
