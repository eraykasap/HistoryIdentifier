
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:history_identifier/model/model.dart';
import 'package:history_identifier/providers/providers.dart';


class AiApiContent {
  
  static String aiPrompt ({required String languageCode}) {

    return """ [GEREKLİ DİL = $languageCode]
  Sen, gönderilen görseldeki **TARİHİ ESERİ VEYA YAPIYI** analiz eden, bu alanda uzman, dikkatli bir **MÜZE KATALOGLAYICISI ve REHBERİSİN**.
  Görevin, **KESİNLİKLE** görselin yalnızca **FİZİKSEL BETİMLEMESİNİ YAPMAK DEĞİL**, doğrudan görseldeki **TARİHİ/KÜLTÜREL ÖNEME** sahip eseri tanımlamak ve onunla ilgili bilgileri yapılandırmaktır.
  **İSTENEN YANIT:** Görseldeki eseri veya yapıyı tanımla ve bir rehberin anlatacağı gibi önemli bilgileri (tarih, mimari, önem, işlev vb.) anlat.


 **YAPILANDIRILMIŞ JSON FORMATI:**
 - Yanıt **BAŞKA HİÇBİR METİN İÇERMEMELİ**, yalnızca JSON kodu olmalıdır.
 - JSON anahtarları (key) İngilizce olmalıdır ("Titel", "Explanation").
 - JSON değerleri (value) yukarıda belirtilen GEREKLİ DİLDE ($languageCode) olmalıdır.
 - Ana nesne bir JSON dizisi olmalı ve içinde esere ait birden fazla bilgi bloğu olmalıdır.
 - **"Titel"** key'ine karşılık gelen değerin sonuna **KESİNLİKLE** "Identification" veya benzeri bir kelime **EKLEME**.
 - Title ve Explanation da sınır yok gerektiği kadar yapabilirsin

  

  **JSON Yapısı Örneği:**

  [

     {

         "Titel" : "eserin ya da yapının adı buraya yazılacak",

         "Explanation" : "eser ya da yapı ile ilgili açıklama buraya yazılacak"

     },

     {

         "Titel" : "diğer konu başlığı buraya yazılacak",

         "Explanation" : "konu başlığı ile ilgili yazı"

     }

  ]

  **Şimdi görseldeki tarihi eseri analiz et ve talimatlara tam uyarak, sadece tarihi ve kültürel bilgiye odaklanarak, JSON çıktısını üret.**

  """;
  }

  

}




class ApiOperations {
  
  Future<List<ContentModel>> sendImageAndGetJson (File imageFile) async {

    final model = GenerativeModel(model: "gemini-2.5-flash", apiKey: "");
    List<ContentModel> icerikListesi = [];

    final jsonSchema = Schema(
      SchemaType.array,
      //description: 'A comprehensive analysis of the historical artifact in the image, presented as an array of topic objects.',
      items: Schema(
        SchemaType.object,
        //description: 'A single topic entry about the artifact.',
        properties: {
          "Title" : Schema(
            SchemaType.string,
            //description: "title about the historical artifact or structure in the photograph"
          ),
          "Explanation" : Schema(
            SchemaType.string,
            //description: "article about the described photograph"
          )
        },
        requiredProperties: ["Title" , "Explanation"]
      )
    );

    final String languageCode = await getDeviceLanguageCode();

    final bytes = await imageFile.readAsBytes();
    final contenst = [
      Content.multi(
        [
          DataPart("image/jpeg", Uint8List.fromList(bytes)),
          TextPart(AiApiContent.aiPrompt(languageCode: languageCode))
        ]
      )
    ];

    final config = GenerationConfig(
      responseMimeType: 'application/json',
      responseSchema: jsonSchema,
    );

    final response = await model.generateContent(
      contenst,
      generationConfig: config
    );

    final jsonString = response.text ?? "[]";
    final jsonObject = jsonDecode(jsonString);
    if (jsonObject is List) {
      icerikListesi = (jsonObject as List).map((e) => ContentModel.fromMap(e as Map<String, dynamic>)).toList();
    }

    return icerikListesi;

  }

  Future<String> getDeviceLanguageCode () async {

    final Locale deviceLocale = await PlatformDispatcher.instance.locales.first;

    return deviceLocale.languageCode;
  }


}