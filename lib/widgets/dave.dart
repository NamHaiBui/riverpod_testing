import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_testing/riverpod_providers/dave_provider.dart';

class Dave extends ConsumerWidget {
  Dave({super.key});

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  Future<Person?> createOrUpdatePersonDialog(BuildContext context,
      [Person? existingPerson]) {
    String? name = existingPerson?.name;
    int? age = existingPerson?.age;

    nameController.text = name ?? '';
    ageController.text = age?.toString() ?? '';
    return showDialog<Person?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create a person'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Enter name here...',
                ),
                onChanged: (value) => name = value,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Enter age here...',
                ),
                onChanged: (value) => age = int.tryParse(value),
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  if (name != null && age != null) {
                    if (existingPerson != null) {
                      final newPerson = existingPerson.updated(
                        name,
                        age,
                      );

                      Navigator.of(context).pop(newPerson);
                    } else {
                      Navigator.of(context).pop(Person(
                        name: name!,
                        age: age!,
                      ));
                    }
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final dataModel = ref.watch(peopleProvider);
          return ListView.builder(
            itemBuilder: (context, index) {
              final person = dataModel.people[index];
              return ListTile(
                title: GestureDetector(
                    onTap: () async {
                      final updatedPerson = await createOrUpdatePersonDialog(
                        context,
                        person,
                      );
                      if (updatedPerson != null) {
                        dataModel.update(updatedPerson);
                      }
                    },
                    child: Text(person.displayName)),
              );
            },
            itemCount: dataModel.count,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        final person = await createOrUpdatePersonDialog(context);
        if (person != null) {
          final dataModel = ref.read(peopleProvider);
          dataModel.addPerson(person);
        }
      }),
    );
  }
}
