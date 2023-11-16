import 'package:average_app/core/datahelper.dart';
import 'package:average_app/model/lesson_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>(); // TextFi
  TextEditingController tfController = TextEditingController();

  int selectCredit = 1;
  double selectNote = 4.0;
  String selectLessonName = '';
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Not Hesaplama',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: formWidget(),
                    ),
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: averageWidget(),
                        ))
                  ],
                ),
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'Eklenen Dersler',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Expanded(
              child: Container(
                  child: DataHelper.allLessons.isNotEmpty
                      ? lessonListWidget()
                      : const Center(
                          child: Text('Ders Girilmedi'),
                        )),
            )
          ],
        ),
      ),
    );
  }

  Widget lessonListWidget() {
    return ListView.builder(
      itemCount: DataHelper.allLessons.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            setState(() {
              DataHelper.allLessons.removeAt(index); // Elemanı listeden kaldır
              DataHelper.allLessons.isNotEmpty
                  ? DataHelper.averageCalculator(DataHelper.allLessons)
                  : DataHelper.average = 0;
            });
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              title: Text(
                DataHelper.allLessons[index].lessonName,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              trailing: Text((DataHelper.allLessons[index].lessonCredit *
                      DataHelper.allLessons[index].lessonNote)
                  .toString()),
              subtitle: Text(
                  'Ders Kredisi: ${DataHelper.allLessons[index].lessonCredit} Ders Notu: ${DataHelper.allLessons[index].lessonNote}'),
            ),
          ),
        );
      },
    );
  }

  Widget dropDownMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: DropdownButton(
                  items: DataHelper.allCreditItems(),
                  value: selectCredit,
                  onChanged: (value) {
                    setState(() {
                      selectCredit = value!;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: DropdownButton(
                  items: DataHelper.allNoteItems(),
                  value: selectNote,
                  onChanged: (value) {
                    setState(() {
                      selectNote = value!;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_right_outlined,
              size: 36,
            ),
            onPressed: () {
              clicked = true;
              if (tfController.text != '') {
                setState(() {
                  formKey.currentState!.save();
                  Lesson lessonData = Lesson(
                      lessonName: selectLessonName,
                      lessonCredit: selectCredit,
                      lessonNote: selectNote);
                  DataHelper.addLesson(lessonData);
                  tfController.text = '';
                  clicked = false;
                }
                );
              }else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Boş Bırakmayınız')));
              }
            },
          ),
        )
      ],
    );
  }

  Widget formWidget() {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              controller: tfController,
              onSaved: (newValue) {
                selectLessonName = newValue!;
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z]+$'))
              ],
              
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: 'Ders adı girin',
                  labelStyle:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: dropDownMenu(),
          )
        ],
      ),
    );
  }

  Widget averageWidget() {
    return Column(
      children: [
        Text(
          '${DataHelper.allLessons.length} Ders Girildi',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          DataHelper.average.toStringAsFixed(2),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        const Text(
          'Ortalama',
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
