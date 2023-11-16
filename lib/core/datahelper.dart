import 'package:average_app/model/lesson_model.dart';
import 'package:flutter/material.dart';

class DataHelper {

  static List<String> allNote = ['AA', 'BA', 'BB', 'CB', 'CC', 'DC', 'DD', 'FD', 'FF']; // Listede Gösterilecek Not Listesinin Oluşturulması
  static List<double> allNoteDouble = List.generate(allNote.length, (index) => (index + 1) / 2 - 0.5).reversed.toList(); // Not Listesinin Sayısal Veriye Dönüşütürülmesi
  static List<int> allCredit = List.generate(10, (index) => index + 1); // Listede Gösterilecek Kredi Listesinin Oluşturulması
  static List<Lesson> allLessons = []; // Boş Dersler Sınıfının Oluşturulması
  static double average = 0;  // Ortalama Değişkeni
  static int totalCredit = 0; // Toplam Kredi Değişkeni
  static double totalNote = 0;  // Toplam Not Değişkeni
  


  static List<DropdownMenuItem<int>> allCreditItems() { // DropDownMenu için item oluşturuluyor
    return List.generate(allCredit.length, (index) => 
    DropdownMenuItem(
      value: allCredit[index],
      child: Text(allCredit[index].toString()),
    ));
  }

  static List<DropdownMenuItem<double>> allNoteItems() { // DropDownMenu için item oluşturuluyor
    return List.generate(allNoteDouble.length, (index) => 
    DropdownMenuItem(
      value: allNoteDouble[index],
      child: Text(allNote[index].toString()),
    ));
  }  

  static addLesson(Lesson lessonData) { // Dersler Listesine Nesne Ekleniyor
    allLessons.add(lessonData);
    
    averageCalculator(allLessons);
  }

  static averageCalculator(List<Lesson> lessonData) { // Ortalama Hesaplanıyor
    
    for (var element in allLessons) {
      totalNote += element.lessonCredit * element.lessonNote;
      totalCredit += element.lessonCredit;
      average = totalNote / totalCredit;
    }
  }
}