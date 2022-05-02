import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/extensions/locale_keys.dart';
import 'package:isola_app/src/model/app_settings/partners_model.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../widget/liquid_progress_indicator.dart';

class EmailConfirmationPage extends StatefulWidget {
  EmailConfirmationPage(
      {Key? key, required this.countryListInfo, required this.countryTextList})
      : super(key: key);

  var countryListInfo;
  List<Text> countryTextList;
  @override
  State<EmailConfirmationPage> createState() => _EmailConfirmationPageState();
}

class _EmailConfirmationPageState extends State<EmailConfirmationPage> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  String countryText = "default";
  String universityName = "default";
  String mailType = "default";
  int initValueCountry = 0;
  int initValueUniversity = 0;
  String studentEmail = "";

  bool isConfirmationSent = false;
/*
  List<PartnersModel> partnerList = [
    PartnersModel(
        "Tilburg University",
        1,
        "33d3a91f-4f7a-4cc5-9bfe-9074b2a382d2",
        "tilburguniversity.edu",
        true,
        "Netherlands"),
    PartnersModel("Eindhoven University of Technology ", 3,
        "838f0ed3-0837-4f2a-b641-0890f2314d40", "tue.nl", true, "Netherlands"),
    PartnersModel("NHTV Breda University of Applied Sciences", 4,
        "663ac656-3678-4df5-a55c-09e73e3b4322", "buas.nl", true, "Netherlands"),
    PartnersModel(
        "Fontys University of Applied Sciences",
        5,
        "c4204864-224e-479a-859e-521c2671e7c8",
        "fonty.nl",
        true,
        "Netherlands"),
    PartnersModel("HAS University of Applied Sciences", 6,
        "2aeed779-a9a5-49d3-8cbb-2aa34003b41d", "has.nl", true, "Netherlands"),
    PartnersModel(
        "AVANS University of Applied Sciences",
        7,
        "08687cb1-8d7d-4912-b126-9f5858910ac8",
        "avansplus.nl",
        true,
        "Netherlands"),
    PartnersModel(
        "Delft University of Technology",
        8,
        "7b9f7da6-2bcb-4d4e-b172-4e0def57f80e",
        "tudelft.nl",
        true,
        "Netherlands"),
    PartnersModel("Utrecht University", 9,
        "75e31dea-0eb8-40c3-aac6-3137952b6948", "uu.nl", true, "Netherlands"),
    PartnersModel("University of Amsterdam", 10,
        "59f3d0aa-c50c-434b-8652-1a89ee436ef2", "uva.nl", true, "Netherlands"),
    PartnersModel("Erasmus University Rotterdam", 11,
        "7e0b53d5-279d-41d3-be99-4f1070149db4", "hr.nl", true, "Netherlands"),
    PartnersModel(
        "Leiden University",
        12,
        "28f9ebe0-ec9d-4168-abc0-9375ac2565d8",
        "leidenuniv.nl",
        true,
        "Netherlands"),
    PartnersModel("Wageningen University", 13,
        "ae15158d-761d-4b48-a952-c1c555a39ca0", "wur.nl", true, "Netherlands"),
    PartnersModel("University of Groningen", 14,
        "d8087106-000e-409b-b4f2-9691dba0c0ff", "rug.nl", true, "Netherlands"),
    PartnersModel("VU University Amsterdam", 15,
        "f7e6d034-e5e0-4bae-b529-5c68820cb4fe", "vu.nl", true, "Netherlands"),
    PartnersModel(
        "Maastricht University",
        16,
        "08e21f87-da67-462e-9402-4e7e08a10e23",
        "maastrichtuniversity.nl",
        true,
        "Netherlands"),
    PartnersModel(
        "Radboud University",
        17,
        "4db27ec6-8669-4a9a-9fbf-1f825826ba72",
        "communicatie.ru.nl",
        true,
        "Netherlands"),
    PartnersModel(
        "University of Twente",
        18,
        "b02a715e-9bb3-4385-9b4d-7c4ac3c54f78",
        "utwente.nl",
        true,
        "Netherlands"),
    PartnersModel(
        "Hanze University of Applied Sciences",
        19,
        "ac6e20d2-4f7b-4de7-a169-2d4db54c1f6a",
        "org.hanze.nl",
        true,
        "Netherlands"),
    PartnersModel("HAN University of Applied Sciences", 20,
        "08954a8d-1177-42c0-b464-c25801af9a85", "han.nl", true, "Netherlands"),
    PartnersModel(
        "Tinbergen Institute",
        21,
        "d5d6d9fc-fa38-4e94-b63f-d897879b3716",
        "tinbergen.nl",
        true,
        "Netherlands"),
    PartnersModel(
        "Hogeschool van Amsterdam, University of Professional Education",
        22,
        "a8fb1d0b-ac56-4f1c-b29b-b4047536e89f",
        "hva.nl",
        true,
        "Netherlands"),
    PartnersModel("HU University of Applied Sciences Utrecht", 23,
        "ea82fef8-ff2f-4cc2-b1e9-b3e88842801d", "hu.nl", true, "Netherlands"),
    PartnersModel("Van Hall Larenstein University of Applied Sciences", 24,
        "429f8b6c-984b-4736-9809-fab48655c71e", "hvhl.nl", true, "Netherlands"),
    PartnersModel("HZ University of Applied Sciences", 25,
        "aefddaad-4d90-44d3-a5b3-a254935a79db", "hz.nl", true, "Netherlands"),
    PartnersModel(
        "ArtEZ Institute for the Arts",
        26,
        "385bb7d2-b175-4ad0-969d-45b5b3a472d8",
        "artez.nl",
        true,
        "Netherlands"),
    PartnersModel("Viaa University of Applied Sciences", 27,
        "4c805eb3-2c74-4e78-ae6e-f840259fe007", "viaa.nl", true, "Netherlands"),
    PartnersModel("Manrix Academy", 28, "524cbd52-b92d-4fe8-9559-583b2997aecb",
        "hsmarnix.nl", true, "Netherlands"),
    PartnersModel("Utrecht School of the Arts", 29,
        "e7fd6fca-3acc-45a0-8393-37a9726e95d6", "hku.nl", true, "Netherlands"),
    PartnersModel("Amsterdam University College", 30,
        "1ac1b415-1f45-411b-a541-7bcef442e29a", "auc.nl", true, "Netherlands"),
    PartnersModel("University of Humanistic Studies", 31,
        "7ab96ac7-35c5-48c7-9e7b-f60794d12312", "uvh.nl", true, "Netherlands"),
    PartnersModel("Amsterdam School of the Arts", 32,
        "4e21bc38-9b65-48b0-ae88-bb92c71efd24", "ahk.nl", true, "Netherlands"),
    PartnersModel(
        "TIAS School for Business and Society",
        33,
        "7c331a54-4b31-42d0-b69d-54af67c964ad",
        "tias.edu",
        true,
        "Netherlands"),
    PartnersModel(
        "Windesheim University of Applied Sciences",
        34,
        "a3b0428b-abe5-4185-8188-7c2183f466a0",
        "windesheim.nl",
        true,
        "Netherlands"),
    PartnersModel(
        "Driestar Christian University of Teacher Education",
        35,
        "bde0eff4-0009-4fc8-bed9-5b182889d339",
        "driestar-educatief.nl",
        true,
        "Netherlands"),
    PartnersModel("Tio University of Applied Sciences", 36,
        "60ff25e7-46ad-405a-92f3-09583c5bc305", "tio.nl", true, "Netherlands"),
    PartnersModel(
        "Hogeschool Leiden, University of Professional Education",
        37,
        "b439a4e0-c58f-424f-ac2f-d7bcdd8ae4bf",
        "hsleiden.nl",
        true,
        "Netherlands"),
    PartnersModel("Zuyd University of Applied Sciences", 38,
        "0d0edc64-e8ce-4de2-96aa-b50301452d90", "zuyd.nl", true, "Netherlands"),
    PartnersModel("Rotterdam University of Applied Sciences", 39,
        "0783b7c9-c154-44aa-a38c-01a0fa84fd11", "hr.nl", true, "Netherlands"),
    PartnersModel(
        "Aeres University of Applied Sciences",
        40,
        "b0295f6d-7d77-423f-9476-0399910e1bbb",
        "aeres.nl",
        true,
        "Netherlands"),
    PartnersModel(
        "Saxion University",
        41,
        "14138124-cf7e-49ee-b15b-a5422d69ce9e",
        "saxion.nl",
        true,
        "Netherlands"),
    PartnersModel(
        "NHL Stenden University of Applied Sciences",
        42,
        "d5b3c35d-dd95-4a0b-b29c-6afedde011ff",
        "nhlstenden.com",
        true,
        "Netherlands"),
    PartnersModel(
        "Inholland University of Applied Sciences",
        43,
        "eff2ee4b-c095-4e84-babb-5bda50863ba5",
        "INHOLLAND.nl",
        true,
        "Netherlands"),
    PartnersModel("The Hague University", 44,
        "5b5d6ba9-f42a-4b68-a001-0a6d8240e841", "hhs.nl", true, "Netherlands"),
    PartnersModel(
        "IHE Delft Institut for Water Education",
        45,
        "4b81621f-7a37-495f-b02c-0d15863583f7",
        "un-ihe.org",
        true,
        "Netherlands"),
    PartnersModel(
        "Hotelschool The Hague",
        46,
        "3e2d4db5-6848-40ec-8fc2-da2a210877a6",
        "hotelschool.nl",
        true,
        "Netherlands"),
    PartnersModel(
        "Design Academy Eindhoven",
        47,
        "4786f1f9-a773-4439-9ec9-18bdb3f67127",
        "designacademy.nl",
        true,
        "Netherlands"),
    PartnersModel(
        "Wittenborg University of Applied Sciences",
        48,
        "b558b440-8f75-4a51-8185-c5196789dc19",
        "wittenborg.eu",
        true,
        "Netherlands"),
    PartnersModel("Royal Academy of Art The Hague", 49,
        "1f9bb92c-db14-4af7-810d-9106cd0e8ed9", "kabk.nl", true, "Netherlands"),
    PartnersModel(
        "Royal Conservatoire, The Hague",
        50,
        "5cc5690e-d005-4ab8-ac86-2a06286ba7a8",
        "koncon.nl",
        true,
        "Netherlands"),
    PartnersModel(
        "Codarts University of the Arts",
        51,
        "e79851ad-cfa9-4279-a07e-34532fac6610",
        "codarts.nl",
        true,
        "Netherlands"),
    PartnersModel(
        "Iselinge University of Professional Teacher Education",
        52,
        "e989382e-e316-4ae1-8f33-ccef7cd4adf8",
        "iselinge.nl",
        true,
        "Netherlands"),
    PartnersModel("VIB", 53, "5d324b02-7562-4e5a-ba65-3b3a6e247b70", "vib.be",
        true, "Netherlands"),
    PartnersModel(
        "Leiden, Webster University",
        54,
        "0026f9d8-3345-4cc0-bd96-d599a9210af5",
        "webster.edu",
        true,
        "Netherlands"),
    PartnersModel("Amsterdam Fashion Institute", 55,
        "c68f1dee-cc21-40bf-8929-0a014d3a4d31", "hva.nl", true, "Netherlands"),
    PartnersModel(
        "Abant İzzet Baysal University",
        56,
        "dcb81e69-c2b8-4a0e-ade1-3c3c5965f34c",
        "ogrenci.ibu.edu.tr",
        true,
        "Turkey"),
    PartnersModel("Abdullah Gül University", 57,
        "7b543b92-b7a4-4e7c-88c4-ea591d4a9ba2", "agu.edu.tr", true, "Turkey"),
    PartnersModel(
        "Adıyaman University",
        58,
        "43bf2bde-5e45-424d-871a-d0cb70aa58c3",
        "adiyaman.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Adnan Menderes University",
        59,
        "e48cf23f-6cc5-4b74-ab7d-6760b98b6c85",
        "stu.adu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Afyon Kocatepe University",
        60,
        "1a886b13-d063-4fff-9b5b-e9275f8dbd41",
        "usr.aku.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Ağrı İbrahim Çeçen University",
        61,
        "8e205959-6af9-4c5c-a17c-71c84cd1190a",
        "ogr.agri.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Akdeniz University",
        62,
        "eb0d09c6-36e7-4d79-92dd-b249bc85a449",
        "ogr.akdeniz.edu.tr",
        true,
        "Turkey"),
    PartnersModel("Aksaray University", 63,
        "3059ac52-81f6-4bc9-93fd-7b9f22a1fc88", "asu.edu.tr", true, "Turkey"),
    PartnersModel(
        "Alanya Alaaddin Keykubat University",
        64,
        "9fdcc20e-ad85-4c62-94bb-35e4e088a638",
        "ogr.alanya.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Amasya University",
        65,
        "d7edfe87-9abd-49a0-be9d-4afe7120fc7f",
        "ogrenci.amasya.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Ankara University",
        66,
        "4c98c012-da0a-4c91-9d05-56624e928bfb",
        "ankara.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Ankara Sosyal Bilimler University",
        67,
        "59669702-2b46-4a7d-a131-bba8935ae31c",
        "student.asbu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Ardağan University",
        68,
        "312bd4ed-45b7-4bbb-bb51-fb1974742fb9",
        "ogr.ardahan.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Artvin Çoruh University",
        69,
        "a27b3027-f513-44fa-8058-9e3f6aa79677",
        "ogrenci.artvin.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Atatürk University",
        70,
        "d4fe417b-3dc9-47aa-9a3d-3c8bb2741bfc",
        "ogr.atauni.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Balıkesir University",
        71,
        "8f3734d3-562f-4a73-ac71-faa860251bc8",
        "balikesir.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Bartın University",
        72,
        "5d95a18d-f4db-46c2-8183-7d13982b20f7",
        "ogrenci.bartin.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Bilecik Şeyh Edebali University",
        73,
        "7fa304ac-be93-49e0-ac58-e1cbd767e1ab",
        "ogrenci.bilecik.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Bingöl University",
        74,
        "58ff0c44-8b45-4073-a48c-a97fe8f856d5",
        "ogrmail.bingol.edu.tr",
        true,
        "Turkey"),
    PartnersModel("Bitlis Eren University", 75,
        "abd8de15-dfa0-49f6-b023-65457c48ca16", "beu.edu.tr", true, "Turkey"),
    PartnersModel("Boğaziçi University", 76,
        "dd5c2f39-fe17-4e4a-9fd5-75259068f384", "boun.edu.tr", true, "Turkey"),
    PartnersModel(
        "Bozok University",
        77,
        "4a1e4c64-9fe1-4622-9f94-e61db0ad7945",
        "ogr.bozok.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Bursa Teknik University",
        78,
        "19a082b9-40e1-4f86-8b3f-ec079db3395a",
        "ogrenci.btu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Celal Bayar University",
        79,
        "0b4ee44b-ebcd-4dab-a92a-746d65a22e43",
        "ogr.cbu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Cumhuriyet University",
        80,
        "94cd22a9-57ca-47c3-abb6-3502912d565c",
        "cumhuriyet.edu.tr",
        true,
        "Turkey"),
    PartnersModel("Çanakkale Onsekiz Mart University", 81,
        "d56421ee-48b7-44a9-8688-26110e9c3afa", "ogr.comu.edu", true, "Turkey"),
    PartnersModel(
        "Çukurova University",
        82,
        "eb208cfe-dddb-4b93-b688-4ac9d0eed4f7",
        "student.cu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Dicle University",
        83,
        "a7530431-9584-4254-ad90-69a9a78e8bde",
        "ogr.dicle.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Dokuz Eylül University",
        84,
        "ecfd2361-9ad9-4706-bd3a-335f09289f1e",
        "ogr.deu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Dumlupınar University",
        85,
        "5f590a41-27b9-41af-a206-5edf41ebf7bd",
        "ogr.dpu.edu.tr",
        true,
        "Turkey"),
    PartnersModel("Ege University", 86, "9b00696d-3975-4914-bd13-84856b9fb45d",
        "ogrenci.ege.edu.tr", true, "Turkey"),
    PartnersModel(
        "Eskişehir Osmangazi University",
        87,
        "bcf217f9-f79e-4348-954a-021f694b4d9d",
        "ogrenci.ogu.edu.tr",
        true,
        "Turkey"),
    PartnersModel("Fırat University", 88,
        "2e973bf9-62b9-4201-81f6-6c91d6743da4", "firat.edu.tr", true, "Turkey"),
    PartnersModel("Gazi University", 89, "640c287c-21fe-4959-bb1d-cb2a53c82307",
        "gazi.edu.tr", true, "Turkey"),
    PartnersModel(
        "Gaziantep University",
        90,
        "4d09f00f-0a27-4d0b-ba2b-da5202a44694",
        "mail2.gantep.edu.tr",
        true,
        "Turkey"),
    PartnersModel("Gaziosmanpaşa University", 91,
        "f79ce244-d672-4458-a80a-c49c693a61b8", "gop.edu.tr", true, "Turkey"),
    PartnersModel(
        "Gümüşhane University",
        92,
        "4a4147de-9538-4c13-b7db-7d6ed00fdc82",
        "ogr.gumushane.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Hacettepe University",
        93,
        "4b7ef073-1fc5-47cc-9692-1c70bcd866ee",
        "hacettepe.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Hakkari University",
        94,
        "dcbb9e05-b51d-4e2f-897d-f75de9d476ce",
        "hakkari.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Harran University",
        95,
        "e262e1c2-4dd3-480b-8873-bb3bf9730234",
        "ogrenci.harran.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Hitit University",
        96,
        "fca57340-3199-4d27-abe6-a6f21baa4035",
        "ogrenci.hitit.edu.tr",
        true,
        "Turkey"),
    PartnersModel("Hacı Bayram Veli University", 97,
        "45c34725-3d74-4543-8894-b28872068e40", "hbv.edu.tr", true, "Turkey"),
    PartnersModel("İskenderun Teknik University", 98,
        "d3d1442e-6d76-4bea-9ba3-4c911ba282f4", "iste.edu.tr", true, "Turkey"),
    PartnersModel("İstanbul Medeniyet University", 99,
        "208c8f01-a124-4c50-982f-4076f7d922e0", "ismu.edu.tr", true, "Turkey"),
    PartnersModel(
        "İstanbul University",
        100,
        "5c536def-7b2a-462c-9c2c-9175e7fa83a6",
        "ogr.iu.edu.tr",
        true,
        "Turkey"),
    PartnersModel("İstanbul Teknik University", 101,
        "47c6b6d7-442c-490f-94c3-6dd104e47245", "ISTANBULUNİ", true, "Turkey"),
    PartnersModel(
        "İzmir Bakırçay University",
        102,
        "1a96d84b-8206-4948-b735-7f747c0bb832",
        "bakircay.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "İzmir Kâtip Çelebi University",
        103,
        "9cb3346e-c84d-4e1b-b6ae-79612e25549b",
        "ogr.ikc.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Kafkas University",
        104,
        "440581f5-55b6-4851-909e-f6cd57e1a69e",
        "kafkas.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Kahramanmaraş Sütçü İmam University",
        105,
        "7d043499-b678-40af-b788-5005ba442cbc",
        "ogr.ksu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Karabük University",
        106,
        "64860539-7ee4-41b6-942c-22e45fc399b9",
        "ogrenci.karabuk.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Karadeniz Teknik University",
        107,
        "709ac32e-3c20-4d06-b1b4-eaaa545f7e28",
        "ogr.ktu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Karamanoğlu Mehmetbey University",
        108,
        "e378ce9a-2d4f-4b11-9d96-9a704d681b50",
        "stu.kmu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Kastamonu University",
        109,
        "47f633d8-1e9f-45de-a3be-3cd07e163a33",
        "ogr.kastamonu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Kırklareli University",
        110,
        "6e528f59-bd60-4cc4-bf85-82013812ac5b",
        "ogr.klu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Kilis 7 Aralık University",
        111,
        "b252281c-b595-47a2-b7a6-b1cdc33a0e37",
        "ogrenci.kilis.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Kocaeli University",
        112,
        "8961de7a-3d9e-4132-b4d8-b1607950e3d1",
        "kocaeli.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Necmettin Erbakan University",
        113,
        "b524f561-eee6-40b3-9914-250745bc291d",
        "ogr.konya.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Mardin Artuklu University",
        114,
        "09b2bd54-7a25-450f-8a48-b14f15e92ebc",
        "ogrenci.artuklu.edu.tr",
        true,
        "Turkey"),
    PartnersModel("Marmara University", 115,
        "5e235e7c-7249-42f4-9330-cc0ed710e8a3", "marun.edu.tr", true, "Turkey"),
    PartnersModel(
        "Mehmet Akif Ersoy University",
        116,
        "3d294845-1056-4c0f-97a5-916587059e11",
        "ogr.mehmetakif.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Mersin University",
        117,
        "239bdcd2-cfe6-4756-a8f9-bafd6c9d34ed",
        "mersin.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Mimar Sinan Güzel Sanatlar University",
        118,
        "75cf746e-0894-47be-9fe8-256f424226b0",
        "ogr.msgsu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Muğla Sıtkı Koçman University",
        119,
        "809a3fa8-8093-4841-a1cd-0d6c03a42131",
        "posta.mu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Mustafa Kemal University",
        120,
        "8c3b7b83-7a5c-4545-8285-7a3fb94c3540",
        "ogr.mku.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Muş Alparslan University",
        121,
        "9112b98d-2c07-40d5-9381-a24a265fd16e",
        "alparslan.edu.tr",
        true,
        "Turkey"),
    PartnersModel("Namık Kemal University", 122,
        "f4a894ee-3022-4274-99e6-a786fb83912d", "nku.edu.tr", true, "Turkey"),
    PartnersModel(
        "Niğde University",
        123,
        "8865f08d-0dbb-4961-956b-4f38544ddb03",
        "mail.ohu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Ondokuz Mayıs University",
        124,
        "01a315d6-0f04-48d0-9249-14cdd2c181d9",
        "stu.omu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Ordu University",
        125,
        "514e1288-a2cc-4e1c-917c-8e95b9c6a267",
        "ogrenci.odu.edu.tr",
        true,
        "Turkey"),
    PartnersModel("Orta Doğu Teknik University", 126,
        "d9b039d1-b006-4cd1-9ad6-300fdb38c4c1", "metu.edu.tr ", true, "Turkey"),
    PartnersModel(
        "Osmaniye Korkut Ata University",
        127,
        "80318e43-bdd2-47f9-8285-2287776ac60d",
        "ogr.oku.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Pamukkale University",
        128,
        "a75d8c37-9156-40b4-a0a9-9019a4a3bb67",
        "posta.pau.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Recep Tayyip Erdoğan University",
        129,
        "db44b730-acbe-4061-95a0-cc811052dda8",
        "erdogan.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Sakarya University",
        130,
        "2ff0df9a-edc8-41bd-8c89-4a1295d1992d",
        "ogr.sakarya.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Selçuk University",
        131,
        "633386b1-f830-4f46-a02c-ed23414472eb",
        "ogr.selcuk.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Süleyman Demirel University",
        132,
        "e54e7214-70a0-46b4-8779-8265cdfd53fc",
        "ogr.sdu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Trakya University",
        133,
        "e726e754-2abe-44ef-8449-469b557ff26c",
        "trakya.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Türk-Alman University",
        134,
        "bede92e0-9053-46e1-829e-21129a35f5c6",
        "stud.tau.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Sağlık Bilimleri University",
        135,
        "98b32e33-2b6f-4908-80ae-2ee09cf8484b",
        "ogrenci.sbu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Uludağ University",
        136,
        "2b7495f2-343d-4141-9557-519a478ce06f",
        "ogr.uludag.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Uşak University",
        137,
        "59339249-c799-425b-be12-d6693918d981",
        "ogr.usak.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Yalova University",
        138,
        "b1bbb0d1-fffe-4325-8801-e414301ff85e",
        "ogrenci.yalova.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Yıldız Teknik University",
        139,
        "9e706f3e-59af-43fe-9f5a-f269ddb64951",
        "std.yildiz.edu.tr",
        true,
        "Turkey"),
    PartnersModel("Yıldırım Beyazıt University", 140,
        "8015b554-b2bb-4ba7-ac9e-2938025532df", "ybu.edu.tr", true, "Turkey"),
    PartnersModel("Yüzüncü Yıl University", 141,
        "287fa012-e486-4423-b9dc-b7d46cd79447", "yyu.edu.tr", true, "Turkey"),
    PartnersModel(
        "Atılım University",
        142,
        "6a8d9539-75b9-4341-98b5-480104811d16",
        "student.atilim.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Bahçeşehir University",
        143,
        "9227c2d5-0a5c-4a63-bb7e-d12d7513c4bd",
        "stu.bahcesehir.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Başkent University",
        144,
        "5f6a4ab3-4a5c-4af3-9e5e-aabb01f93eb2",
        "mail.baskent.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Beykent University",
        145,
        "aa4c828c-5055-4141-a067-856c2ae2f2d6",
        "student.beykent.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Beykoz University",
        146,
        "c67c1f63-9f11-4ce5-8919-93afb1458a13",
        "ogrenci.beykoz.edu.tr",
        true,
        "Turkey"),
    PartnersModel("Bezmiâlem University", 147,
        "ab5bf2ff-6e5c-4788-82f8-d0f9d71fef0d", "bavu.edu.tr", true, "Turkey"),
    PartnersModel(
        "Biruni University",
        148,
        "21687383-19c7-4a9c-9189-3e8efc453c9a",
        "st.biruni.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Fatih Sultan Mehmet University",
        149,
        "d4734fc3-4860-4357-be0c-0fbfacea0289",
        "stu.fsm.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Fenerbahçe University",
        150,
        "6a4cc425-5238-4f6d-8fe9-745dba5e7a9f",
        "stu.fbu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Gedik University",
        151,
        "4784d6dc-f4bb-401d-95fb-127598b4b26e",
        "stu.gedik.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Haliç University",
        152,
        "3af355f0-063e-4a3f-9606-54938b0739ef",
        "ogr.halic.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Hasan Kalyoncu University",
        153,
        "7bafab44-d6fa-4a23-9e9e-a6b96ed1ebe8",
        "std.hku.edu.tr",
        true,
        "Turkey"),
    PartnersModel("Işık University", 154,
        "1d0e7400-c025-42b5-a439-dabd6c4392db", "isik.edu.tr", true, "Turkey"),
    PartnersModel(
        "İstanbul Arel University",
        155,
        "01879e59-135a-44df-afd5-85da7f3a7cca",
        "istanbularel.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "İstanbul Aydın University",
        156,
        "4da66330-3e54-48ad-9880-c87b4f6559c1",
        "stu.aydin.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Istanbul Bilgi Universitesi",
        157,
        "a84e1a76-f394-43f9-b2fb-013d21a70bde",
        "stu.bilgi.edu.tr",
        true,
        "Turkey"),
    PartnersModel("İstanbul Esenyurt University", 158,
        "24cda0ef-c0b9-45f2-831c-8770453a0ce7", "iesu.edu.tr", true, "Turkey"),
    PartnersModel(
        "İstanbul Gelişim University",
        159,
        "fcfd028c-688b-4bf6-a59d-9ce6dd527cf8",
        "ogr.gelisim.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Altınbaş Universitesi",
        160,
        "8b47794a-99fe-4e9c-bbb2-513534bddcd5",
        "ogr.altinbas.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "İstanbul Kültür University",
        161,
        "eb4b700f-35ff-449b-a9a5-4caea7ee702d",
        "stu.iku.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "İstanbul Medipol University",
        162,
        "43ed0b5d-68a1-4a92-b7a6-6e6ead5aa5dc",
        "std.medipol.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "İstanbul Rumeli University",
        163,
        "b2ead16a-bcf1-41df-abf0-e167aa6e844f",
        "stu.rumeli.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "İstanbul Sabahattin Zaim University",
        164,
        "189e3612-019b-4b04-89df-0a2bce88a8f3",
        "std.izu.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "İstanbul Ticaret University",
        165,
        "9b60eaf0-9ff9-488f-986c-a59c4e986ba9",
        "istanbulticaret.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "İstinye University",
        166,
        "69f4c66a-2136-4e74-991d-fd658243e7ff",
        "stu.istinye.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "İzmir Ekonomi University",
        167,
        "001afab7-3e9d-4c6b-8b1c-3e21a27232d9",
        "std.izmirekonomi.edu.tr",
        true,
        "Turkey"),
    PartnersModel("Koç University", 168, "ed14f0ea-41fd-4c1b-85cf-27863a419ebb",
        "ku.edu.tr", true, "Turkey"),
    PartnersModel(
        "Maltepe University",
        169,
        "8d6b4d51-0182-4e6d-984c-f29c8ca9f851",
        "st.maltepe.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Nişantaşı University",
        170,
        "64b88fbd-887a-4482-98f2-cd3f2209d7a0",
        "std.nisantasi.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Nuh Naci Yazgan University",
        171,
        "7ace0a28-bd67-4383-83e8-2668ac7a8450",
        "ogrenci.nny.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Okan University",
        172,
        "da6bea5b-c7ef-49f8-b6d2-4f8085c6b7bc",
        "stu.okan.edu.tr",
        true,
        "Turkey"),
    PartnersModel("Özyeğin University", 173,
        "2edb4225-138b-4b6e-9b75-3531130ee34b", "ozu.edu.tr", true, "Turkey"),
    PartnersModel("Piri Reis University", 174,
        "59826e8c-2554-4dd8-bfdf-5613768066bf", "pru.edu.tr", true, "Turkey"),
    PartnersModel("Sabancı University", 175, "sabanciuniv.edu",
        "sabanciuniv.edu", true, "Turkey"),
    PartnersModel("Toros University", 176,
        "e93d3c81-9336-4dbf-99c9-bbbd70cb91aa", "toros.edu.tr", true, "Turkey"),
    PartnersModel(
        "Üsküdar University",
        177,
        "2d773876-4d89-46d0-b258-6b572302bae5",
        "st.uskudar.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Yaşar University",
        178,
        "8c9f907d-6f19-4739-bc95-d7469c7df1a9",
        "stu.yasar.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Yeditepe University",
        179,
        "1caad9c2-14e4-4289-971b-a368551c243c",
        "std.yeditepe.edu.tr",
        true,
        "Turkey"),
    PartnersModel(
        "Istanbul Galata University",
        180,
        "d1c12948-c061-425f-9485-57c933e841a2",
        "galata.edu.tr",
        true,
        "Turkey"),
  ];
*/
  var countryListInfo;
  var countryTextList = <Text>[];

  var universityList;
  var universityTextList = <Text>[];

  var partnerModel = PartnersModel("", 0, "", "", false, "");
/*
  var outsideListNether = <String>[];
  int outsideAmountNether = 0;

  var outsideListTurkey = <String>[];
  int outsideAmountTurkey = 0;
*/
  void _showPicker(BuildContext ctx, List<dynamic> countryList,
      List<Text> targetTextList, String realTarget, int initValue) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => SizedBox(
              width: 100.w,
              height: 250,
              child: CupertinoPicker(
                looping: false,
                backgroundColor: CupertinoColors.white,
                itemExtent: 30,
                selectionOverlay:
                    const CupertinoPickerDefaultSelectionOverlay(),
                scrollController:
                    FixedExtentScrollController(initialItem: initValue),
                // ignore: prefer_const_literals_to_create_immutables
                children: targetTextList,
                onSelectedItemChanged: (value) {
                  initValue = value;
                  if (realTarget == "country") {
                    var uniList;
                    universityName = "default";
                    universityTextList.clear();
                    partnerModel = PartnersModel("", 0, "", "", false, "");

                    universityList = [];
                    FirebaseFirestore.instance
                        .collection('partners')
                        .doc(countryList[value])
                        .get()
                        .then((value) => uniList = value["universityList"])
                        .whenComplete(() {
                      print(uniList);

                      setState(() {
                        countryText = countryList[value];
                        universityList = uniList;
                        initValueCountry = value;
                        initValueUniversity = 0;
                      });
                    });
                  } else if (realTarget == "university") {
                    var partnerNew;
                    print(countryText);
                    print(universityList[value]);
                    FirebaseFirestore.instance
                        .collection('partners')
                        .doc(countryText)
                        .collection("universityDetail")
                        .doc(universityList[value])
                        .get()
                        .then((value) => partnerNew = PartnersModel(
                            value["fullName"],
                            value["universityValue"],
                            value["activityNo"],
                            value["mailType"],
                            value["isActive"],
                            value["whichCountry"]))
                        .whenComplete(() {
                      setState(() {
                        universityName = universityList[value];
                        initValueUniversity = value;
                        partnerModel = partnerNew as PartnersModel;
                      });
                    });
                  }
                },
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
    countryListInfo = widget.countryListInfo;

    countryTextList.addAll(widget.countryTextList);
/*
    for (var item in partnerList) {
      if (item.whichCountry == "Netherlands") {
        outsideListNether.add(item.fullName);
        outsideAmountNether = outsideAmountNether + 1;
      } else if (item.whichCountry == "Turkey") {
        outsideListTurkey.add(item.fullName);
        outsideAmountTurkey = outsideAmountTurkey + 1;
      }
    }*/
  }

  @override
  Widget build(BuildContext context) {
    if (countryText != "default" && universityTextList.isEmpty) {
      for (var item in universityList) {
        universityTextList.add(Text(
          item,
          style: TextStyle(fontSize: 10.sp),
        ));
      }
    }
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(automaticallyImplyLeading: true),
        child: Container(
            decoration:
                BoxDecoration(gradient: ColorConstant.startingPageGradient),
            height: 100.h,
            width: 100.w,
            child: isConfirmationSent == false
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        /*    CupertinoButton(
                            child: Text('sstest'),
                            onPressed: () async {
                              FirebaseAuth auth = FirebaseAuth.instance;
                              String fullUserUid = auth.currentUser!.uid;
                              Stream metaStream = FirebaseFirestore.instance
                                  .collection('users_meta')
                                  .doc(fullUserUid)
                                  .snapshots();

                              metaStream.listen((event) {
                                print(event['uValid']);
                                if (event['uValid'] == true) {
                                  print('done done dıne');
                                  Navigator.pushReplacementNamed(
                                      context, splashPage);
                                } else {
                                  showCupertinoDialog(
                                    barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          const CupertinoActivityIndicator(animating: true,));
                                }
                              });
/*
                              showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const AnimatedLiquidCircularProgressIndicator());*/
                            }),*/

                        /*  CupertinoButton(
                      child: Container(
                        height: 5.h,
                        width: 70.w,
                        child: Text("11111111111"),
                      ),
                      onPressed: () {
                        for (var partner in partnerList) {
                          var refPartner = FirebaseFirestore.instance
                              .collection("partners")
                              .doc(partner.whichCountry)
                              .collection("universityDetail")
                              .doc(partner.fullName);

                          refPartner.set({
                            "fullName": partner.fullName,
                            "universityValue": partner.universityValue,
                            "activityNo": partner.activityNo,
                            "mailType": partner.mailType,
                            "isActive": partner.isActive,
                            "whichCountry": partner.whichCountry,
                          });
                        }
                      }),*/

                        /*
                  CupertinoButton(
                      child: Container(
                        height: 5.h,
                        width: 70.w,
                        child: Text("22222222222"),
                      ),
                      onPressed: () {

              

outsideListNether
        .sort((a, b) => a.compareTo(b));

outsideListTurkey
        .sort((a, b) => a.compareTo(b));
                        var refOutsideNL = FirebaseFirestore.instance
                            .collection("partners")
                            .doc("Netherlands");
                        var refOutsideTR = FirebaseFirestore.instance
                            .collection("partners")
                            .doc("Turkey");

                        refOutsideNL.set({
                          "universityList": outsideListNether,
                          "universityAmount": outsideAmountNether
                        });
                        refOutsideTR.set({
                          "universityList": outsideListTurkey,
                          "universityAmount": outsideAmountTurkey
                        });
                      }),*/

                        buttonGetterEmailConfirm(
                          Text(
                            LocaleKeys.main_country.tr(),
                            style: TextStyle(
                              color: ColorConstant.softBlack,
                            ),
                          ),
                          () => _showPicker(context, countryListInfo,
                              countryTextList, "country", initValueCountry),
                          Text(
                            countryText,
                            style: TextStyle(
                              color: ColorConstant.softBlack,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: universityTextList.isNotEmpty,
                          child: buttonGetterEmailConfirm(
                              Text(
                                LocaleKeys.main_university.tr(),
                                style: TextStyle(
                                  color: ColorConstant.softBlack,
                                ),
                              ),
                              () => _showPicker(
                                  context,
                                  universityList,
                                  universityTextList,
                                  "university",
                                  initValueUniversity),
                              Text(
                                universityName,
                                style: TextStyle(
                                    color: ColorConstant.softBlack,
                                    fontSize:
                                        (8 + (50 / universityName.length)).sp),
                              )),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Visibility(
                          visible: universityName != "default",
                          child: SizedBox(
                              width: 70.w,
                              height: 4.h,
                              child: CupertinoTextField(
                                maxLength: 15,
                                onChanged: (t) {
                                  setState(() {});
                                },
                                decoration: BoxDecoration(
                                    color: ColorConstant.milkColor,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 1.sp,
                                          spreadRadius: 0.2.sp,
                                          offset: const Offset(0.0, 0.0),
                                          color: ColorConstant.softBlack
                                              .withOpacity(0.2))
                                    ],
                                    border: Border.all(
                                        width: 0.01,
                                        color: ColorConstant.softBlack)),
                                controller: t1,
                                suffix: Text(
                                  "@" + partnerModel.mailType,
                                  style: TextStyle(
                                      color: ColorConstant.softBlack,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                suffixMode: OverlayVisibilityMode.always,
                              )),
                        ),
                        CupertinoButton(
                            child: Text(
                              LocaleKeys.main_sendmail.tr(),
                              style: TextStyle(
                                color: ColorConstant.softBlack,
                              ),
                            ),
                            onPressed: () {
                              if (t1.text.length > 1) {
                                FirebaseAuth auth = FirebaseAuth.instance;

                                if (auth.currentUser?.uid != null) {
                                  studentEmail =
                                      t1.text + "@" + partnerModel.mailType;
                                  String fullEmail =
                                      t1.text + "@" + partnerModel.mailType;

                                  String fullUserUid = auth.currentUser!.uid;

                                  print(t1.text + "@" + partnerModel.mailType);
                                  print(universityName);
                                  var confirmCreateRef = FirebaseFirestore
                                      .instance
                                      .collection("confirmations")
                                      .doc("student_confirmations")
                                      .collection("confirmation_created_pool")
                                      .doc(auth.currentUser!.uid);

                                  confirmCreateRef.set({
                                    "studentEmail": fullEmail,
                                    "userUid": fullUserUid,
                                    "userUniversity": universityName,
                                    "sentDate": DateTime.now().toUtc(),
                                  }).whenComplete(() {
                                    setState(() {
                                      isConfirmationSent = true;
                                      universityName = universityName;
                                    });
                                  });
                                }
                              }
                            })
                      ])
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                          width: 80.w,
                          child: Text(
                              '${LocaleKeys.main_senttextfirst.tr()}$studentEmail${LocaleKeys.main_senttextsecond.tr()}'),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                          width: 50.w,
                          height: 10.h,
                          child: CupertinoTextField(
                            maxLength: 15,
                            onChanged: (t) {
                              setState(() {});
                            },
                            decoration: BoxDecoration(
                                color: ColorConstant.milkColor,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 1.sp,
                                      spreadRadius: 0.2.sp,
                                      offset: const Offset(0.0, 0.0),
                                      color: ColorConstant.softBlack
                                          .withOpacity(0.2))
                                ],
                                border: Border.all(
                                    width: 0.01,
                                    color: ColorConstant.softBlack)),
                            controller: t2,
                            placeholder: LocaleKeys.main_securitycode.tr(),
                            placeholderStyle: TextStyle(
                              textBaseline: TextBaseline.alphabetic,
                            ),
                          )),
                      CupertinoButton(
                          child: Text(
                            LocaleKeys.main_confirm.tr(),
                            style: TextStyle(
                              color: ColorConstant.softBlack,
                            ),
                          ),
                          onPressed: () {
                            if (t2.text.length > 1) {
                              FirebaseAuth auth = FirebaseAuth.instance;

                              if (auth.currentUser?.uid != null) {
                                String secureCode = t2.text;
                                String fullEmail =
                                    t2.text + "@" + partnerModel.mailType;

                                String fullUserUid = auth.currentUser!.uid;

                                print(t2.text + "@" + partnerModel.mailType);
                                print(universityName);
                                var confirmUserAnswerRef = FirebaseFirestore
                                    .instance
                                    .collection("confirmations")
                                    .doc("student_confirmations")
                                    .collection("confirmation_user_answer_pool")
                                    .doc(auth.currentUser!.uid);

                                confirmUserAnswerRef.set({
                                  "answerDate": DateTime.now().toUtc(),
                                  "userUid": fullUserUid,
                                  "securityCode": secureCode,
                                  "studentEmail": studentEmail
                                }).whenComplete(() async {
                                  FirebaseAuth auth = FirebaseAuth.instance;
                                  String fullUserUid = auth.currentUser!.uid;
                                  Stream metaStream = FirebaseFirestore.instance
                                      .collection('users_meta')
                                      .doc(fullUserUid)
                                      .snapshots();

                                  metaStream.listen((event) {
                                    print(event['uValid']);
                                    if (event['uValid'] == true) {
                                      print('done done dıne');
                                      Navigator.pushReplacementNamed(
                                          context, splashPage);
                                    } else {
                                      showCupertinoDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) =>
                                              const CupertinoActivityIndicator(
                                                animating: true,
                                              ));
                                    }
                                  });
                                });
                              }
                            }
                          }),
                    ],
                  )));
  }
}

Widget buttonGetterEmailConfirm(
    Text settingsItemText, Function() settingsItemFunc, Text nameText) {
  return Container(
    decoration: BoxDecoration(
        color: ColorConstant.milkColor,
        boxShadow: [
          BoxShadow(
              blurRadius: 1.sp,
              spreadRadius: 0.2.sp,
              offset: const Offset(0.0, 0.0),
              color: ColorConstant.softBlack.withOpacity(0.2))
        ],
        border: Border.all(width: 0.01, color: ColorConstant.softBlack)),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: CupertinoButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                settingsItemText,
              ],
            ),
            nameText
          ],
        ),
        onPressed: settingsItemFunc,
      ),
    ),
  );
}
