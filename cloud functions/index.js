const functions = require("firebase-functions");

const admin = require("firebase-admin");


admin.initializeApp(functions.config().firestore);
const db = admin.firestore();






var universityList = ["tilburguniversity.edu", "gmail.com", "tue.nl", "fonty.nl", "has.nl", "avansplus.nl", "tudelft.nl", "uu.nl", "uva.nl", "hr.nl", "leidenuniv.nl", "wur.nl", "rug.nl", "vu.nl",
    "maastrichtuniversity.nl", "communicatie.ru.nl", "utwente.nl", "org.hanze.nl", "han.nl", "tinbergen.nl", "hva.nl", "hu.nl", "hvhl.nl", "hz.nl", "artez.nl", "viaa.nl", "hsmarnix.nl",
    "hku.nl", "auc.nl", "uvh.nl", "ahk.nl", "tias.edu", "windesheim.nl", "driestar-educatief.nl", "tio.nl", "hsleiden.nl", "zuyd.nl", "hr.nl", "aeres.nl", "saxion.nl", "nhlstenden.com",
    "inholland.nl", "hhs.nl", "un-ihe.org", "hotelschool.nl", "designacademy.nl", "wittenborg.eu", "kabk.nl", "koncon.nl", "codarts.nl", "iselinge.nl", "vib.be", "webster.edu", "hva.nl", "ogrenci.ibu.edu.tr", "agu.edu.tr",
    "adiyaman.edu.tr", "stu.adu.edu.tr", "usr.aku.edu.tr", "ogr.agri.edu.tr", "ogr.akdeniz.edu.tr", "asu.edu.tr", "ogr.alanya.edu.tr", "ogrenci.amasya.edu.tr", "ankara.edu.tr", "student.asbu.edu.tr",
    "ogr.ardahan.edu.tr", "ogrenci.artvin.edu.tr", "ogr.atauni.edu.tr", "balikesir.edu.tr", "ogrenci.bartin.edu.tr", "ogrenci.bilecik.edu.tr", "ogrmail.bingol.edu.tr", "beu.edu.tr", "boun.edu.tr", "ogr.bozok.edu.tr",
    "ogrenci.btu.edu.tr", "ogr.cbu.edu.tr", "cumhuriyet.edu.tr", "ogr.comu.edu", "student.cu.edu.tr", "ogr.dicle.edu.tr", "ogr.deu.edu.tr", "ogr.dpu.edu.tr", "ogrenci.ege.edu.tr", "ogrenci.ogu.edu.tr", "firat.edu.tr",
    "gazi.edu.tr", "mail2.gantep.edu.tr", "gop.edu.tr", "ogr.gumushane.edu.tr", "hacettepe.edu.tr", "hakkari.edu.tr", "ogrenci.harran.edu.tr", "ogrenci.hitit.edu.tr", "hbv.edu.tr", "iste.edu.tr", "ismu.edu.tr", "ogr.iu.edu.tr",
    "ISTANBULUNİ", "bakircay.edu.tr", "ogr.ikc.edu.tr", "kafkas.edu.tr", "ogr.ksu.edu.tr", "ogrenci.karabuk.edu.tr", "ogr.ktu.edu.tr", "stu.kmu.edu.tr", "ogr.kastamonu.edu.tr", "ogr.klu.edu.tr", "ogrenci.kilis.edu.tr", "kocaeli.edu.tr",
    "ogr.konya.edu.tr", "ogrenci.artuklu.edu.tr", "marun.edu.tr", "ogr.mehmetakif.edu.tr", "mersin.edu.tr", "ogr.msgsu.edu.tr", "posta.mu.edu.tr", "ogr.mku.edu.tr", "alparslan.edu.tr", "nku.edu.tr", "mail.ohu.edu.tr", "stu.omu.edu.tr",
    "ogrenci.odu.edu.tr", "metu.edu.tr", "ogr.oku.edu.tr", "posta.pau.edu.tr", "erdogan.edu.tr", "ogr.sakarya.edu.tr", "ogr.selcuk.edu.tr", "ogr.sdu.edu.tr", "trakya.edu.tr", "stud.tau.edu.tr", "ogrenci.sbu.edu.tr", "ogr.uludag.edu.tr",
    "ogr.usak.edu.tr", "ogrenci.yalova.edu.tr", "std.yildiz.edu.tr", "ybu.edu.tr", "yyu.edu.tr", "student.atilim.edu.tr", "stu.bahcesehir.edu.tr", "mail.baskent.edu.tr", "student.beykent.edu.tr", "ogrenci.beykoz.edu.tr",
    "bavu.edu.tr", "st.biruni.edu.tr", "stu.fsm.edu.tr", "stu.fbu.edu.tr", "stu.gedik.edu.tr", "ogr.halic.edu.tr", "std.hku.edu.tr", "isik.edu.tr", "istanbularel.edu.tr", "stu.aydin.edu.tr", "stu.bilgi.edu.tr", "iesu.edu.tr",
    "ogr.gelisim.edu.tr", "ogr.altinbas.edu.tr", "stu.iku.edu.tr", "std.medipol.edu.tr", "stu.rumeli.edu.tr", "std.izu.edu.tr", "istanbulticaret.edu.tr", "stu.istinye.edu.tr", "std.izmirekonomi.edu.tr", "ku.edu.tr", "st.maltepe.edu.tr",
    "std.nisantasi.edu.tr", "ogrenci.nny.edu.tr", "stu.okan.edu.tr", "ozu.edu.tr", "pru.edu.tr", "sabanciuniv.edu", "toros.edu.tr", "st.uskudar.edu.tr", "stu.yasar.edu.tr", "std. yeditepe.edu.tr", "galata.edu.tr",];

var universityEnum = {
    tilburguniversity: "tilburguniversity.edu",
    gmail: "gmail.com",
    tue: "tue.nl",
    buas: "buas.nl",
    fonty: "fonty.nl",
    has: "has.nl",
    avansplus: "avansplus.nl",
    tudelft: "tudelft.nl",
    uu: "uu.nl",
    uva: "uva.nl",
    hr: "hr.nl",
    leidenuniv: "leidenuniv.nl",
    wur: "wur.nl",
    rug: "rug.nl",
    vu: "vu.nl",
    maastrichtuniversity: "maastrichtuniversity.nl",
    ru: "communicatie.ru.nl",
    utwente: "utwente.nl",
    hanze: "org.hanze.nl",
    han: "han.nl",
    tinbergen: "tinbergen.nl",
    hva: "hva.nl",
    hu: "hu.nl",
    hvhl: "hvhl.nl",
    hz: "hz.nl",
    artez: "artez.nl",
    viaa: "viaa.nl",
    hsmarnix: "hsmarnix.nl",
    hku: "hku.nl",
    auc: "auc.nl",
    uvh: "uvh.nl",
    ahk: "ahk.nl",
    tias: "tias.edu",
    windesheim: "windesheim.nl",
    driestar: "driestar-educatief.nl",
    tio: "tio.nl",
    hsleiden: "hsleiden.nl",
    zuyd: "zuyd.nl",
    hr: "hr.nl",
    aeres: "aeres.nl",
    saxion: "saxion.nl",
    nhlstenden: "nhlstenden.com",
    inholland: "inholland.nl",
    hhs: "hhs.nl",
    ihe: "un-ihe.org",
    hotelschool: "hotelschool.nl",
    designacademy: "designacademy.nl",
    wittenborg: "wittenborg.eu",
    kabk: "kabk.nl",
    koncon: "koncon.nl",
    codarts: "codarts.nl",
    iselinge: "iselinge.nl",
    vib: "vib.be",
    webster: "webster.edu",
    hva: "hva.nl",
    ibu: "ogrenci.ibu.edu.tr",
    agu: "agu.edu.tr",
    adiyaman: "adiyaman.edu.tr",
    adu: "stu.adu.edu.tr",
    aku: "usr.aku.edu.tr",
    agri: "ogr.agri.edu.tr",
    akdeniz: "ogr.akdeniz.edu.tr",
    asu: "asu.edu.tr",
    alanya: "ogr.alanya.edu.tr",
    amasya: "ogrenci.amasya.edu.tr",
    ankara: "ankara.edu.tr",
    asbu: "student.asbu.edu.tr",
    ardahan: "ogr.ardahan.edu.tr",
    artvin: "ogrenci.artvin.edu.tr",
    atauni: "ogr.atauni.edu.tr",
    balikesir: "balikesir.edu.tr",
    bartin: "ogrenci.bartin.edu.tr",
    bilecik: "ogrenci.bilecik.edu.tr",
    bingol: "ogrmail.bingol.edu.tr",
    beu: "beu.edu.tr",
    boun: "boun.edu.tr",
    bozok: "ogr.bozok.edu.tr",
    btu: "ogrenci.btu.edu.tr",
    cbu: "ogr.cbu.edu.tr",
    cumhuriyet: "cumhuriyet.edu.tr",
    comu: "ogr.comu.edu",
    cu: "student.cu.edu.tr",
    dicle: "ogr.dicle.edu.tr",
    deu: "ogr.deu.edu.tr",
    dpu: "ogr.dpu.edu.tr",
    ege: "ogrenci.ege.edu.tr",
    ogu: "ogrenci.ogu.edu.tr",
    firat: "firat.edu.tr",
    gazi: "gazi.edu.tr",
    gantep: "mail2.gantep.edu.tr",
    gop: "gop.edu.tr",
    gumushane: "ogr.gumushane.edu.tr",
    hacettepe: "hacettepe.edu.tr",
    hakkari: "hakkari.edu.tr",
    harran: "ogrenci.harran.edu.tr",
    hitit: "ogrenci.hitit.edu.tr",
    hbv: "hbv.edu.tr",
    iste: "iste.edu.tr",
    ismu: "ismu.edu.tr",
    iu: "ogr.iu.edu.tr",
    ISTANBULUNİ: "ISTANBULUNİ",
    bakircay: "bakircay.edu.tr",
    ikc: "ogr.ikc.edu.tr",
    kafkas: "kafkas.edu.tr",
    ksu: "ogr.ksu.edu.tr",
    karabuk: "ogrenci.karabuk.edu.tr",
    ktu: "ogr.ktu.edu.tr",
    kmu: "stu.kmu.edu.tr",
    kastamonu: "ogr.kastamonu.edu.tr",
    klu: "ogr.klu.edu.tr",
    kilis: "ogrenci.kilis.edu.tr",
    kocaeli: "kocaeli.edu.tr",
    konya: "ogr.konya.edu.tr",
    artuklu: "ogrenci.artuklu.edu.tr",
    marun: "marun.edu.tr",
    mehmetakif: "ogr.mehmetakif.edu.tr",
    mersin: "mersin.edu.tr",
    msgsu: "ogr.msgsu.edu.tr",
    posta: "posta.mu.edu.tr",
    mku: "ogr.mku.edu.tr",
    alparslan: "alparslan.edu.tr",
    nku: "nku.edu.tr",
    ohu: "mail.ohu.edu.tr",
    omu: "stu.omu.edu.tr",
    odu: "ogrenci.odu.edu.tr",
    metu: "metu.edu.tr",
    oku: "ogr.oku.edu.tr",
    pau: "posta.pau.edu.tr",
    erdogan: "erdogan.edu.tr",
    sakarya: "ogr.sakarya.edu.tr",
    selcuk: "ogr.selcuk.edu.tr",
    sdu: "ogr.sdu.edu.tr",
    trakya: "trakya.edu.tr",
    tau: "stud.tau.edu.tr",
    sbu: "ogrenci.sbu.edu.tr",
    uludag: "ogr.uludag.edu.tr",
    usak: "ogr.usak.edu.tr",
    yalova: "ogrenci.yalova.edu.tr",
    yildiz: "std.yildiz.edu.tr",
    ybu: "ybu.edu.tr",
    yyu: "yyu.edu.tr",
    atilim: "student.atilim.edu.tr",
    bahcesehir: "stu.bahcesehir.edu.tr",
    baskent: "mail.baskent.edu.tr",
    beykent: "student.beykent.edu.tr",
    beykoz: "ogrenci.beykoz.edu.tr",
    bavu: "bavu.edu.tr",
    biruni: "st.biruni.edu.tr",
    fsm: "stu.fsm.edu.tr",
    fbu: "stu.fbu.edu.tr",
    gedik: "stu.gedik.edu.tr",
    halic: "ogr.halic.edu.tr",
    hku: "std.hku.edu.tr",
    isik: "isik.edu.tr",
    istanbularel: "istanbularel.edu.tr",
    aydin: "stu.aydin.edu.tr",
    bilgi: "stu.bilgi.edu.tr",
    iesu: "iesu.edu.tr",
    gelisim: "ogr.gelisim.edu.tr",
    altinbas: "ogr.altinbas.edu.tr",
    iku: "stu.iku.edu.tr",
    medipol: "std.medipol.edu.tr",
    rumeli: "stu.rumeli.edu.tr",
    izu: "std.izu.edu.tr",
    istanbulticaret: "istanbulticaret.edu.tr",
    istinye: "stu.istinye.edu.tr",
    izmirekonomi: "std.izmirekonomi.edu.tr",
    ku: "ku.edu.tr",
    maltepe: "st.maltepe.edu.tr",
    nisantasi: "std.nisantasi.edu.tr",
    nny: "ogrenci.nny.edu.tr",
    okan: "stu.okan.edu.tr",
    ozu: "ozu.edu.tr",
    pru: "pru.edu.tr",
    sabanciuniv: "sabanciuniv.edu",
    toros: "toros.edu.tr",
    uskudar: "st.uskudar.edu.tr",
    yasar: "stu.yasar.edu.tr",
    yeditepe: "std. yeditepe.edu.tr",
    galata: "galata.edu.tr",












    properties: {
        "tilburguniversity.edu": { universityName: "Tilburg University", value: 1, activityNo: "33d3a91f-4f7a-4cc5-9bfe-9074b2a382d2", mailType: "tilburguniversity.edu", isActive: true, whichCountry: "Netherlands" },
        "gmail.com": { universityName: "Test University", value: 2, activityNo: "4c2833a0-b0c0-49f3-bae8-e54f22b02639", mailType: "gmail.com", isActive: false, whichCountry: "Test" },
        "tue.nl": { universityName: "Eindhoven University of Technology ", value: 3, activityNo: "838f0ed3-0837-4f2a-b641-0890f2314d40", mailType: "tue.nl", isActive: true, whichCountry: "Netherlands" },
        "buas.nl": { universityName: "NHTV Breda University of Applied Sciences", value: 4, activityNo: "663ac656-3678-4df5-a55c-09e73e3b4322", mailType: "buas.nl", isActive: true, whichCountry: "Netherlands" },
        "fonty.nl": { universityName: "Fontys University of Applied Sciences", value: 5, activityNo: "c4204864-224e-479a-859e-521c2671e7c8", mailType: "fonty.nl", isActive: true, whichCountry: "Netherlands" },
        "has.nl": { universityName: "HAS University of Applied Sciences", value: 6, activityNo: "2aeed779-a9a5-49d3-8cbb-2aa34003b41d", mailType: "has.nl", isActive: true, whichCountry: "Netherlands" },
        "avansplus.nl": { universityName: "AVANS University of Applied Sciences", value: 7, activityNo: "08687cb1-8d7d-4912-b126-9f5858910ac8", mailType: "avansplus.nl", isActive: true, whichCountry: "Netherlands" },
        "tudelft.nl": { universityName: "Delft University of Technology", value: 8, activityNo: "7b9f7da6-2bcb-4d4e-b172-4e0def57f80e", mailType: "tudelft.nl", isActive: true, whichCountry: "Netherlands" },
        "uu.nl": { universityName: "Utrecht University", value: 9, activityNo: "75e31dea-0eb8-40c3-aac6-3137952b6948", mailType: "uu.nl", isActive: true, whichCountry: "Netherlands" },
        "uva.nl": { universityName: "University of Amsterdam", value: 10, activityNo: "59f3d0aa-c50c-434b-8652-1a89ee436ef2", mailType: "uva.nl", isActive: true, whichCountry: "Netherlands" },
        "hr.nl": { universityName: "Erasmus University Rotterdam", value: 11, activityNo: "7e0b53d5-279d-41d3-be99-4f1070149db4", mailType: "hr.nl", isActive: true, whichCountry: "Netherlands" },
        "leidenuniv.nl": { universityName: "Leiden University", value: 12, activityNo: "28f9ebe0-ec9d-4168-abc0-9375ac2565d8", mailType: "leidenuniv.nl", isActive: true, whichCountry: "Netherlands" },
        "wur.nl": { universityName: "Wageningen University", value: 13, activityNo: "ae15158d-761d-4b48-a952-c1c555a39ca0", mailType: "wur.nl", isActive: true, whichCountry: "Netherlands" },
        "rug.nl": { universityName: "University of Groningen", value: 14, activityNo: "d8087106-000e-409b-b4f2-9691dba0c0ff", mailType: "rug.nl", isActive: true, whichCountry: "Netherlands" },
        "vu.nl": { universityName: "VU University Amsterdam", value: 15, activityNo: "f7e6d034-e5e0-4bae-b529-5c68820cb4fe", mailType: "vu.nl", isActive: true, whichCountry: "Netherlands" },
        "maastrichtuniversity.nl": { universityName: "Maastricht University", value: 16, activityNo: "08e21f87-da67-462e-9402-4e7e08a10e23", mailType: "maastrichtuniversity.nl", isActive: true, whichCountry: "Netherlands" },
        "communicatie.ru.nl": { universityName: "Radboud University", value: 17, activityNo: "4db27ec6-8669-4a9a-9fbf-1f825826ba72", mailType: "communicatie.ru.nl", isActive: true, whichCountry: "Netherlands" },
        "utwente.nl": { universityName: "University of Twente", value: 18, activityNo: "b02a715e-9bb3-4385-9b4d-7c4ac3c54f78", mailType: "utwente.nl", isActive: true, whichCountry: "Netherlands" },
        "org.hanze.nl": { universityName: "Hanze University of Applied Sciences", value: 19, activityNo: "ac6e20d2-4f7b-4de7-a169-2d4db54c1f6a", mailType: "org.hanze.nl", isActive: true, whichCountry: "Netherlands" },
        "han.nl": { universityName: "HAN University of Applied Sciences", value: 20, activityNo: "08954a8d-1177-42c0-b464-c25801af9a85", mailType: "han.nl", isActive: true, whichCountry: "Netherlands" },
        "tinbergen.nl": { universityName: "Tinbergen Institute", value: 21, activityNo: "d5d6d9fc-fa38-4e94-b63f-d897879b3716", mailType: "tinbergen.nl", isActive: true, whichCountry: "Netherlands" },
        "hva.nl": { universityName: "Hogeschool van Amsterdam, University of Professional Education", value: 22, activityNo: "a8fb1d0b-ac56-4f1c-b29b-b4047536e89f", mailType: "hva.nl", isActive: true, whichCountry: "Netherlands" },
        "hu.nl": { universityName: "HU University of Applied Sciences Utrecht", value: 23, activityNo: "ea82fef8-ff2f-4cc2-b1e9-b3e88842801d", mailType: "hu.nl", isActive: true, whichCountry: "Netherlands" },
        "hvhl.nl": { universityName: "Van Hall Larenstein University of Applied Sciences", value: 24, activityNo: "429f8b6c-984b-4736-9809-fab48655c71e", mailType: "hvhl.nl", isActive: true, whichCountry: "Netherlands" },
        "hz.nl": { universityName: "HZ University of Applied Sciences", value: 25, activityNo: "aefddaad-4d90-44d3-a5b3-a254935a79db", mailType: "hz.nl", isActive: true, whichCountry: "Netherlands" },
        "artez.nl": { universityName: "ArtEZ Institute for the Arts", value: 26, activityNo: "385bb7d2-b175-4ad0-969d-45b5b3a472d8", mailType: "artez.nl", isActive: true, whichCountry: "Netherlands" },
        "viaa.nl": { universityName: "Viaa University of Applied Sciences", value: 27, activityNo: "4c805eb3-2c74-4e78-ae6e-f840259fe007", mailType: "viaa.nl", isActive: true, whichCountry: "Netherlands" },
        "hsmarnix.nl": { universityName: "Manrix Academy", value: 28, activityNo: "524cbd52-b92d-4fe8-9559-583b2997aecb", mailType: "hsmarnix.nl", isActive: true, whichCountry: "Netherlands" },
        "hku.nl": { universityName: "Utrecht School of the Arts", value: 29, activityNo: "e7fd6fca-3acc-45a0-8393-37a9726e95d6", mailType: "hku.nl", isActive: true, whichCountry: "Netherlands" },
        "auc.nl": { universityName: "Amsterdam University College", value: 30, activityNo: "1ac1b415-1f45-411b-a541-7bcef442e29a", mailType: "auc.nl", isActive: true, whichCountry: "Netherlands" },
        "uvh.nl": { universityName: "University of Humanistic Studies", value: 31, activityNo: "7ab96ac7-35c5-48c7-9e7b-f60794d12312", mailType: "uvh.nl", isActive: true, whichCountry: "Netherlands" },
        "ahk.nl": { universityName: "Amsterdam School of the Arts", value: 32, activityNo: "4e21bc38-9b65-48b0-ae88-bb92c71efd24", mailType: "ahk.nl", isActive: true, whichCountry: "Netherlands" },
        "tias.edu": { universityName: "TIAS School for Business and Society", value: 33, activityNo: "7c331a54-4b31-42d0-b69d-54af67c964ad", mailType: "tias.edu", isActive: true, whichCountry: "Netherlands" },
        "windesheim.nl": { universityName: "Windesheim University of Applied Sciences", value: 34, activityNo: "a3b0428b-abe5-4185-8188-7c2183f466a0", mailType: "windesheim.nl", isActive: true, whichCountry: "Netherlands" },
        "driestar-educatief.nl": { universityName: "Driestar Christian University of Teacher Education", value: 35, activityNo: "bde0eff4-0009-4fc8-bed9-5b182889d339", mailType: "driestar-educatief.nl", isActive: true, whichCountry: "Netherlands" },
        "tio.nl": { universityName: "Tio University of Applied Sciences", value: 36, activityNo: "60ff25e7-46ad-405a-92f3-09583c5bc305", mailType: "tio.nl", isActive: true, whichCountry: "Netherlands" },
        "hsleiden.nl": { universityName: "Hogeschool Leiden, University of Professional Education", value: 37, activityNo: "b439a4e0-c58f-424f-ac2f-d7bcdd8ae4bf", mailType: "hsleiden.nl", isActive: true, whichCountry: "Netherlands" },
        "zuyd.nl": { universityName: "Zuyd University of Applied Sciences", value: 38, activityNo: "0d0edc64-e8ce-4de2-96aa-b50301452d90", mailType: "zuyd.nl", isActive: true, whichCountry: "Netherlands" },
        "hr.nl": { universityName: "Rotterdam University of Applied Sciences", value: 39, activityNo: "0783b7c9-c154-44aa-a38c-01a0fa84fd11", mailType: "hr.nl", isActive: true, whichCountry: "Netherlands" },
        "aeres.nl": { universityName: "Aeres University of Applied Sciences", value: 40, activityNo: "b0295f6d-7d77-423f-9476-0399910e1bbb", mailType: "aeres.nl", isActive: true, whichCountry: "Netherlands" },
        "saxion.nl": { universityName: "Saxion University", value: 41, activityNo: "14138124-cf7e-49ee-b15b-a5422d69ce9e", mailType: "saxion.nl", isActive: true },
        "nhlstenden.com": { universityName: "NHL Stenden University of Applied Sciences", value: 42, activityNo: "d5b3c35d-dd95-4a0b-b29c-6afedde011ff", mailType: "nhlstenden.com", isActive: true, whichCountry: "Netherlands" },
        "inholland.nl": { universityName: "Inholland University of Applied Sciences", value: 43, activityNo: "eff2ee4b-c095-4e84-babb-5bda50863ba5", mailType: "INHOLLAND.nl", isActive: true, whichCountry: "Netherlands" },
        "hhs.nl": { universityName: "The Hague University", value: 44, activityNo: "5b5d6ba9-f42a-4b68-a001-0a6d8240e841", mailType: "hhs.nl", isActive: true, whichCountry: "Netherlands" },
        "un-ihe.org": { universityName: "IHE Delft Institut for Water Education", value: 45, activityNo: "4b81621f-7a37-495f-b02c-0d15863583f7", mailType: "un-ihe.org", isActive: true, whichCountry: "Netherlands" },
        "hotelschool.nl": { universityName: "Hotelschool The Hague", value: 46, activityNo: "3e2d4db5-6848-40ec-8fc2-da2a210877a6", mailType: "hotelschool.nl", isActive: true, whichCountry: "Netherlands" },
        "designacademy.nl": { universityName: "Design Academy Eindhoven", value: 47, activityNo: "4786f1f9-a773-4439-9ec9-18bdb3f67127", mailType: "designacademy.nl", isActive: true, whichCountry: "Netherlands" },
        "wittenborg.eu": { universityName: "Wittenborg University of Applied Sciences", value: 48, activityNo: "b558b440-8f75-4a51-8185-c5196789dc19", mailType: "wittenborg.eu", isActive: true, whichCountry: "Netherlands" },
        "kabk.nl": { universityName: "Royal Academy of Art The Hague", value: 49, activityNo: "1f9bb92c-db14-4af7-810d-9106cd0e8ed9", mailType: "kabk.nl", isActive: true, whichCountry: "Netherlands" },
        "koncon.nl": { universityName: "Royal Conservatoire, The Hague", value: 50, activityNo: "5cc5690e-d005-4ab8-ac86-2a06286ba7a8", mailType: "koncon.nl", isActive: true, whichCountry: "Netherlands" },
        "codarts.nl": { universityName: "Codarts University of the Arts", value: 51, activityNo: "e79851ad-cfa9-4279-a07e-34532fac6610", mailType: "codarts.nl", isActive: true, whichCountry: "Netherlands" },
        "iselinge.nl": { universityName: "Iselinge University of Professional Teacher Education", value: 52, activityNo: "e989382e-e316-4ae1-8f33-ccef7cd4adf8", mailType: "iselinge.nl", isActive: true, whichCountry: "Netherlands" },
        "vib.be": { universityName: "VIB", value: 53, activityNo: "5d324b02-7562-4e5a-ba65-3b3a6e247b70", mailType: "vib.be", isActive: true, whichCountry: "Netherlands" },
        "webster.edu": { universityName: "Leiden, Webster University", value: 54, activityNo: "0026f9d8-3345-4cc0-bd96-d599a9210af5", mailType: "webster.edu", isActive: true, whichCountry: "Netherlands" },
        "hva.nl": { universityName: "Amsterdam Fashion Institute", value: 55, activityNo: "c68f1dee-cc21-40bf-8929-0a014d3a4d31", mailType: "hva.nl", isActive: true, whichCountry: "Netherlands" },
        "ogrenci.ibu.edu.tr": { universityName: "Abant İzzet Baysal University", value: 56, activityNo: "dcb81e69-c2b8-4a0e-ade1-3c3c5965f34c", mailType: "ogrenci.ibu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "agu.edu.tr": { universityName: "Abdullah Gül University", value: 57, activityNo: "7b543b92-b7a4-4e7c-88c4-ea591d4a9ba2", mailType: "agu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "adiyaman.edu.tr": { universityName: "Adıyaman University", value: 58, activityNo: "43bf2bde-5e45-424d-871a-d0cb70aa58c3", mailType: "adiyaman.edu.tr", isActive: true, whichCountry: "Turkey" },
        "stu.adu.edu.tr": { universityName: "Adnan Menderes University", value: 59, activityNo: "e48cf23f-6cc5-4b74-ab7d-6760b98b6c85", mailType: "stu.adu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "usr.aku.edu.tr": { universityName: "Afyon Kocatepe University", value: 60, activityNo: "1a886b13-d063-4fff-9b5b-e9275f8dbd41", mailType: "usr.aku.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.agri.edu.tr": { universityName: "Ağrı İbrahim Çeçen University", value: 61, activityNo: "8e205959-6af9-4c5c-a17c-71c84cd1190a", mailType: "ogr.agri.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.akdeniz.edu.tr": { universityName: "Akdeniz University", value: 62, activityNo: "eb0d09c6-36e7-4d79-92dd-b249bc85a449", mailType: "ogr.akdeniz.edu.tr", isActive: true, whichCountry: "Turkey" },
        "asu.edu.tr": { universityName: "Aksaray University", value: 63, activityNo: "3059ac52-81f6-4bc9-93fd-7b9f22a1fc88", mailType: "asu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.alanya.edu.tr": { universityName: "Alanya Alaaddin Keykubat University", value: 64, activityNo: "9fdcc20e-ad85-4c62-94bb-35e4e088a638", mailType: "ogr.alanya.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrenci.amasya.edu.tr": { universityName: "Amasya University", value: 65, activityNo: "d7edfe87-9abd-49a0-be9d-4afe7120fc7f", mailType: "ogrenci.amasya.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ankara.edu.tr": { universityName: "Ankara University", value: 66, activityNo: "4c98c012-da0a-4c91-9d05-56624e928bfb", mailType: "ankara.edu.tr", isActive: true, whichCountry: "Turkey" },
        "student.asbu.edu.tr": { universityName: "Ankara Sosyal Bilimler University", value: 67, activityNo: "59669702-2b46-4a7d-a131-bba8935ae31c", mailType: "student.asbu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.ardahan.edu.tr": { universityName: "", value: 68, activityNo: "312bd4ed-45b7-4bbb-bb51-fb1974742fb9", mailType: "ogr.ardahan.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrenci.artvin.edu.tr": { universityName: "Artvin Çoruh University", value: 69, activityNo: "a27b3027-f513-44fa-8058-9e3f6aa79677", mailType: "ogrenci.artvin.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.atauni.edu.tr": { universityName: "Atatürk University", value: 70, activityNo: "d4fe417b-3dc9-47aa-9a3d-3c8bb2741bfc", mailType: "ogr.atauni.edu.tr", isActive: true, whichCountry: "Turkey" },
        "balikesir.edu.tr": { universityName: "Balıkesir University", value: 71, activityNo: "8f3734d3-562f-4a73-ac71-faa860251bc8", mailType: "balikesir.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrenci.bartin.edu.tr": { universityName: "Bartın University", value: 72, activityNo: "5d95a18d-f4db-46c2-8183-7d13982b20f7", mailType: "ogrenci.bartin.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrenci.bilecik.edu.tr": { universityName: "Bilecik Şeyh Edebali University", value: 73, activityNo: "7fa304ac-be93-49e0-ac58-e1cbd767e1ab", mailType: "ogrenci.bilecik.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrmail.bingol.edu.tr": { universityName: "Bingöl University", value: 74, activityNo: "58ff0c44-8b45-4073-a48c-a97fe8f856d5", mailType: "ogrmail.bingol.edu.tr", isActive: true, whichCountry: "Turkey" },
        "beu.edu.tr": { universityName: "Bitlis Eren University", value: 75, activityNo: "abd8de15-dfa0-49f6-b023-65457c48ca16", mailType: "beu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "boun.edu.tr": { universityName: "Boğaziçi University", value: 76, activityNo: "dd5c2f39-fe17-4e4a-9fd5-75259068f384", mailType: "boun.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.bozok.edu.tr": { universityName: "Bozok University", value: 77, activityNo: "4a1e4c64-9fe1-4622-9f94-e61db0ad7945", mailType: "ogr.bozok.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrenci.btu.edu.tr": { universityName: "Bursa Teknik University", value: 78, activityNo: "19a082b9-40e1-4f86-8b3f-ec079db3395a", mailType: "ogrenci.btu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.cbu.edu.tr": { universityName: "Celal Bayar University", value: 79, activityNo: "0b4ee44b-ebcd-4dab-a92a-746d65a22e43", mailType: "ogr.cbu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "cumhuriyet.edu.tr": { universityName: "Cumhuriyet University", value: 80, activityNo: "94cd22a9-57ca-47c3-abb6-3502912d565c", mailType: "cumhuriyet.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.comu.edu": { universityName: "Çanakkale Onsekiz Mart University", value: 81, activityNo: "d56421ee-48b7-44a9-8688-26110e9c3afa", mailType: "ogr.comu.edu", isActive: true, whichCountry: "Turkey" },
        "student.cu.edu.tr": { universityName: "Çukurova University", value: 82, activityNo: "eb208cfe-dddb-4b93-b688-4ac9d0eed4f7", mailType: "student.cu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.dicle.edu.tr": { universityName: "Dicle University", value: 83, activityNo: "a7530431-9584-4254-ad90-69a9a78e8bde", mailType: "ogr.dicle.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.deu.edu.tr": { universityName: "Dokuz Eylül University", value: 84, activityNo: "ecfd2361-9ad9-4706-bd3a-335f09289f1e", mailType: "ogr.deu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.dpu.edu.tr": { universityName: "Dumlupınar University", value: 85, activityNo: "5f590a41-27b9-41af-a206-5edf41ebf7bd", mailType: "ogr.dpu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrenci.ege.edu.tr": { universityName: "Ege University", value: 86, activityNo: "9b00696d-3975-4914-bd13-84856b9fb45d", mailType: "ogrenci.ege.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrenci.ogu.edu.tr": { universityName: "Eskişehir Osmangazi University", value: 87, activityNo: "bcf217f9-f79e-4348-954a-021f694b4d9d", mailType: "ogrenci.ogu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "firat.edu.tr": { universityName: "Fırat University", value: 88, activityNo: "2e973bf9-62b9-4201-81f6-6c91d6743da4", mailType: "firat.edu.tr", isActive: true, whichCountry: "Turkey" },
        "gazi.edu.tr": { universityName: "Gazi University", value: 89, activityNo: "640c287c-21fe-4959-bb1d-cb2a53c82307", mailType: "gazi.edu.tr", isActive: true, whichCountry: "Turkey" },
        "mail2.gantep.edu.tr": { universityName: "Gaziantep University", value: 90, activityNo: "4d09f00f-0a27-4d0b-ba2b-da5202a44694", mailType: "mail2.gantep.edu.tr", isActive: true, whichCountry: "Turkey" },
        "gop.edu.tr": { universityName: "Gaziosmanpaşa University", value: 91, activityNo: "f79ce244-d672-4458-a80a-c49c693a61b8", mailType: "gop.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.gumushane.edu.tr": { universityName: "Gümüşhane University", value: 92, activityNo: "4a4147de-9538-4c13-b7db-7d6ed00fdc82", mailType: "ogr.gumushane.edu.tr", isActive: true, whichCountry: "Turkey" },
        "hacettepe.edu.tr": { universityName: "Hacettepe University", value: 93, activityNo: "4b7ef073-1fc5-47cc-9692-1c70bcd866ee", mailType: "hacettepe.edu.tr", isActive: true, whichCountry: "Turkey" },
        "hakkari.edu.tr": { universityName: "Hakkari University", value: 94, activityNo: "dcbb9e05-b51d-4e2f-897d-f75de9d476ce", mailType: "hakkari.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrenci.harran.edu.tr": { universityName: "Harran University", value: 95, activityNo: "e262e1c2-4dd3-480b-8873-bb3bf9730234", mailType: "ogrenci.harran.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrenci.hitit.edu.tr": { universityName: "Hitit University", value: 96, activityNo: "fca57340-3199-4d27-abe6-a6f21baa4035", mailType: "ogrenci.hitit.edu.tr", isActive: true, whichCountry: "Turkey" },
        "hbv.edu.tr": { universityName: "Hacı Bayram Veli University", value: 97, activityNo: "45c34725-3d74-4543-8894-b28872068e40", mailType: "hbv.edu.tr", isActive: true, whichCountry: "Turkey" },
        "iste.edu.tr": { universityName: "İskenderun Teknik University", value: 98, activityNo: "d3d1442e-6d76-4bea-9ba3-4c911ba282f4", mailType: "iste.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ismu.edu.tr": { universityName: "İstanbul Medeniyet University", value: 99, activityNo: "208c8f01-a124-4c50-982f-4076f7d922e0", mailType: "ismu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.iu.edu.tr": { universityName: "İstanbul University", value: 100, activityNo: "5c536def-7b2a-462c-9c2c-9175e7fa83a6", mailType: "ogr.iu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ISTANBULUNİ": { universityName: "İstanbul Teknik University", value: 101, activityNo: "47c6b6d7-442c-490f-94c3-6dd104e47245", mailType: "ISTANBULUNİ", isActive: true, whichCountry: "Turkey" },
        "bakircay.edu.tr": { universityName: "İzmir Bakırçay University", value: 102, activityNo: "1a96d84b-8206-4948-b735-7f747c0bb832", mailType: "bakircay.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.ikc.edu.tr": { universityName: "İzmir Kâtip Çelebi University", value: 103, activityNo: "9cb3346e-c84d-4e1b-b6ae-79612e25549b", mailType: "ogr.ikc.edu.tr", isActive: true, whichCountry: "Turkey" },
        "kafkas.edu.tr": { universityName: "Kafkas University", value: 104, activityNo: "440581f5-55b6-4851-909e-f6cd57e1a69e", mailType: "kafkas.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.ksu.edu.tr": { universityName: "Kahramanmaraş Sütçü İmam University", value: 105, activityNo: "7d043499-b678-40af-b788-5005ba442cbc", mailType: "ogr.ksu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrenci.karabuk.edu.tr": { universityName: "Karabük University", value: 106, activityNo: "64860539-7ee4-41b6-942c-22e45fc399b9", mailType: "ogrenci.karabuk.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.ktu.edu.tr": { universityName: "Karadeniz Teknik University", value: 107, activityNo: "709ac32e-3c20-4d06-b1b4-eaaa545f7e28", mailType: "ogr.ktu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "stu.kmu.edu.tr": { universityName: "Karamanoğlu Mehmetbey University", value: 108, activityNo: "e378ce9a-2d4f-4b11-9d96-9a704d681b50", mailType: "stu.kmu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.kastamonu.edu.tr": { universityName: "Kastamonu University", value: 109, activityNo: "47f633d8-1e9f-45de-a3be-3cd07e163a33", mailType: "ogr.kastamonu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.klu.edu.tr": { universityName: "Kırklareli University", value: 110, activityNo: "6e528f59-bd60-4cc4-bf85-82013812ac5b", mailType: "ogr.klu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrenci.kilis.edu.tr": { universityName: "Kilis 7 Aralık University", value: 111, activityNo: "b252281c-b595-47a2-b7a6-b1cdc33a0e37", mailType: "ogrenci.kilis.edu.tr", isActive: true, whichCountry: "Turkey" },
        "kocaeli.edu.tr": { universityName: "Kocaeli University", value: 112, activityNo: "8961de7a-3d9e-4132-b4d8-b1607950e3d1", mailType: "kocaeli.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.konya.edu.tr": { universityName: "Necmettin Erbakan University", value: 113, activityNo: "b524f561-eee6-40b3-9914-250745bc291d", mailType: "ogr.konya.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrenci.artuklu.edu.tr": { universityName: "Mardin Artuklu University", value: 114, activityNo: "09b2bd54-7a25-450f-8a48-b14f15e92ebc", mailType: "ogrenci.artuklu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "marun.edu.tr": { universityName: "Marmara University", value: 115, activityNo: "5e235e7c-7249-42f4-9330-cc0ed710e8a3", mailType: "marun.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.mehmetakif.edu.tr": { universityName: "Mehmet Akif Ersoy University", value: 116, activityNo: "3d294845-1056-4c0f-97a5-916587059e11", mailType: "ogr.mehmetakif.edu.tr", isActive: true, whichCountry: "Turkey" },
        "mersin.edu.tr": { universityName: "Mersin University", value: 117, activityNo: "239bdcd2-cfe6-4756-a8f9-bafd6c9d34ed", mailType: "mersin.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.msgsu.edu.tr": { universityName: "Mimar Sinan Güzel Sanatlar University", value: 118, activityNo: "75cf746e-0894-47be-9fe8-256f424226b0", mailType: "ogr.msgsu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "posta.mu.edu.tr": { universityName: "Muğla Sıtkı Koçman University", value: 119, activityNo: "809a3fa8-8093-4841-a1cd-0d6c03a42131", mailType: "posta.mu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.mku.edu.tr": { universityName: "Mustafa Kemal University", value: 120, activityNo: "8c3b7b83-7a5c-4545-8285-7a3fb94c3540", mailType: "ogr.mku.edu.tr", isActive: true, whichCountry: "Turkey" },
        "alparslan.edu.tr": { universityName: "Muş Alparslan University", value: 121, activityNo: "9112b98d-2c07-40d5-9381-a24a265fd16e", mailType: "alparslan.edu.tr", isActive: true, whichCountry: "Turkey" },
        "nku.edu.tr": { universityName: "Namık Kemal University", value: 122, activityNo: "f4a894ee-3022-4274-99e6-a786fb83912d", mailType: "nku.edu.tr", isActive: true, whichCountry: "Turkey" },
        "mail.ohu.edu.tr": { universityName: "Niğde University", value: 123, activityNo: "8865f08d-0dbb-4961-956b-4f38544ddb03", mailType: "mail.ohu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "stu.omu.edu.tr": { universityName: "Ondokuz Mayıs University", value: 124, activityNo: "01a315d6-0f04-48d0-9249-14cdd2c181d9", mailType: "stu.omu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrenci.odu.edu.tr": { universityName: "Ordu University", value: 125, activityNo: "514e1288-a2cc-4e1c-917c-8e95b9c6a267", mailType: "ogrenci.odu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "metu.edu.tr ": { universityName: "Orta Doğu Teknik University", value: 126, activityNo: "d9b039d1-b006-4cd1-9ad6-300fdb38c4c1", mailType: "metu.edu.tr ", isActive: true, whichCountry: "Turkey" },
        "ogr.oku.edu.tr": { universityName: "Osmaniye Korkut Ata University", value: 127, activityNo: "80318e43-bdd2-47f9-8285-2287776ac60d", mailType: "ogr.oku.edu.tr", isActive: true, whichCountry: "Turkey" },
        "posta.pau.edu.tr": { universityName: "Pamukkale University", value: 128, activityNo: "a75d8c37-9156-40b4-a0a9-9019a4a3bb67", mailType: "posta.pau.edu.tr", isActive: true, whichCountry: "Turkey" },
        "erdogan.edu.tr": { universityName: "Recep Tayyip Erdoğan University", value: 129, activityNo: "db44b730-acbe-4061-95a0-cc811052dda8", mailType: "erdogan.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.sakarya.edu.tr": { universityName: "Sakarya University", value: 130, activityNo: "2ff0df9a-edc8-41bd-8c89-4a1295d1992d", mailType: "ogr.sakarya.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.selcuk.edu.tr": { universityName: "Selçuk University", value: 131, activityNo: "633386b1-f830-4f46-a02c-ed23414472eb", mailType: "ogr.selcuk.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.sdu.edu.tr": { universityName: "Süleyman Demirel University", value: 132, activityNo: "e54e7214-70a0-46b4-8779-8265cdfd53fc", mailType: "ogr.sdu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "trakya.edu.tr": { universityName: "Trakya University", value: 133, activityNo: "e726e754-2abe-44ef-8449-469b557ff26c", mailType: "trakya.edu.tr", isActive: true, whichCountry: "Turkey" },
        "stud.tau.edu.tr": { universityName: "Türk-Alman University", value: 134, activityNo: "bede92e0-9053-46e1-829e-21129a35f5c6", mailType: "stud.tau.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrenci.sbu.edu.tr": { universityName: "Sağlık Bilimleri University", value: 135, activityNo: "98b32e33-2b6f-4908-80ae-2ee09cf8484b", mailType: "ogrenci.sbu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.uludag.edu.tr": { universityName: "Uludağ University", value: 136, activityNo: "2b7495f2-343d-4141-9557-519a478ce06f", mailType: "ogr.uludag.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.usak.edu.tr": { universityName: "Uşak University", value: 137, activityNo: "59339249-c799-425b-be12-d6693918d981", mailType: "ogr.usak.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrenci.yalova.edu.tr": { universityName: "Yalova University", value: 138, activityNo: "b1bbb0d1-fffe-4325-8801-e414301ff85e", mailType: "ogrenci.yalova.edu.tr", isActive: true, whichCountry: "Turkey" },
        "std.yildiz.edu.tr": { universityName: "Yıldız Teknik University", value: 139, activityNo: "9e706f3e-59af-43fe-9f5a-f269ddb64951", mailType: "std.yildiz.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ybu.edu.tr": { universityName: "Yıldırım Beyazıt University", value: 140, activityNo: "8015b554-b2bb-4ba7-ac9e-2938025532df", mailType: "ybu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "yyu.edu.tr": { universityName: "Yüzüncü Yıl University", value: 141, activityNo: "287fa012-e486-4423-b9dc-b7d46cd79447", mailType: "yyu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "student.atilim.edu.tr": { universityName: "Atılım University", value: 142, activityNo: "6a8d9539-75b9-4341-98b5-480104811d16", mailType: "student.atilim.edu.tr", isActive: true, whichCountry: "Turkey" },
        "stu.bahcesehir.edu.tr": { universityName: "Bahçeşehir University", value: 143, activityNo: "9227c2d5-0a5c-4a63-bb7e-d12d7513c4bd", mailType: "stu.bahcesehir.edu.tr", isActive: true, whichCountry: "Turkey" },
        "mail.baskent.edu.tr": { universityName: "Başkent University", value: 144, activityNo: "5f6a4ab3-4a5c-4af3-9e5e-aabb01f93eb2", mailType: "mail.baskent.edu.tr", isActive: true, whichCountry: "Turkey" },
        "student.beykent.edu.tr": { universityName: "Beykent University", value: 145, activityNo: "aa4c828c-5055-4141-a067-856c2ae2f2d6", mailType: "student.beykent.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrenci.beykoz.edu.tr": { universityName: "Beykoz University", value: 146, activityNo: "c67c1f63-9f11-4ce5-8919-93afb1458a13", mailType: "ogrenci.beykoz.edu.tr", isActive: true, whichCountry: "Turkey" },
        "bavu.edu.tr": { universityName: "Bezmiâlem University", value: 147, activityNo: "ab5bf2ff-6e5c-4788-82f8-d0f9d71fef0d", mailType: "bavu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "st.biruni.edu.tr": { universityName: "Biruni University", value: 148, activityNo: "21687383-19c7-4a9c-9189-3e8efc453c9a", mailType: "st.biruni.edu.tr", isActive: true, whichCountry: "Turkey" },
        "stu.fsm.edu.tr": { universityName: "Fatih Sultan Mehmet University", value: 149, activityNo: "d4734fc3-4860-4357-be0c-0fbfacea0289", mailType: "stu.fsm.edu.tr", isActive: true, whichCountry: "Turkey" },
        "stu.fbu.edu.tr": { universityName: "Fenerbahçe University", value: 150, activityNo: "6a4cc425-5238-4f6d-8fe9-745dba5e7a9f", mailType: "stu.fbu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "stu.gedik.edu.tr": { universityName: "Gedik University", value: 151, activityNo: "4784d6dc-f4bb-401d-95fb-127598b4b26e", mailType: "stu.gedik.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.halic.edu.tr": { universityName: "Haliç University", value: 152, activityNo: "3af355f0-063e-4a3f-9606-54938b0739ef", mailType: "ogr.halic.edu.tr", isActive: true, whichCountry: "Turkey" },
        "std.hku.edu.tr": { universityName: "Hasan Kalyoncu University", value: 153, activityNo: "7bafab44-d6fa-4a23-9e9e-a6b96ed1ebe8", mailType: "std.hku.edu.tr", isActive: true, whichCountry: "Turkey" },
        "isik.edu.tr": { universityName: "Işık University", value: 154, activityNo: "1d0e7400-c025-42b5-a439-dabd6c4392db", mailType: "isik.edu.tr", isActive: true, whichCountry: "Turkey" },
        "istanbularel.edu.tr": { universityName: "İstanbul Arel University", value: 155, activityNo: "01879e59-135a-44df-afd5-85da7f3a7cca", mailType: "istanbularel.edu.tr", isActive: true, whichCountry: "Turkey" },
        "stu.aydin.edu.tr": { universityName: "İstanbul Aydın University", value: 156, activityNo: "4da66330-3e54-48ad-9880-c87b4f6559c1", mailType: "stu.aydin.edu.tr", isActive: true, whichCountry: "Turkey" },
        "stu.bilgi.edu.tr": { universityName: "Istanbul Bilgi Universitesi", value: 157, activityNo: "a84e1a76-f394-43f9-b2fb-013d21a70bde", mailType: "stu.bilgi.edu.tr", isActive: true, whichCountry: "Turkey" },
        "iesu.edu.tr": { universityName: "İstanbul Esenyurt University", value: 158, activityNo: "24cda0ef-c0b9-45f2-831c-8770453a0ce7", mailType: "iesu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.gelisim.edu.tr": { universityName: "İstanbul Gelişim University", value: 159, activityNo: "fcfd028c-688b-4bf6-a59d-9ce6dd527cf8", mailType: "ogr.gelisim.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogr.altinbas.edu.tr": { universityName: "Altınbaş Universitesi", value: 160, activityNo: "8b47794a-99fe-4e9c-bbb2-513534bddcd5", mailType: "ogr.altinbas.edu.tr", isActive: true, whichCountry: "Turkey" },
        "stu.iku.edu.tr": { universityName: "İstanbul Kültür University", value: 161, activityNo: "eb4b700f-35ff-449b-a9a5-4caea7ee702d", mailType: "stu.iku.edu.tr", isActive: true, whichCountry: "Turkey" },
        "std.medipol.edu.tr": { universityName: "İstanbul Medipol University", value: 162, activityNo: "43ed0b5d-68a1-4a92-b7a6-6e6ead5aa5dc", mailType: "std.medipol.edu.tr", isActive: true, whichCountry: "Turkey" },
        "stu.rumeli.edu.tr": { universityName: "İstanbul Rumeli University", value: 163, activityNo: "b2ead16a-bcf1-41df-abf0-e167aa6e844f", mailType: "stu.rumeli.edu.tr", isActive: true, whichCountry: "Turkey" },
        "std.izu.edu.tr": { universityName: "İstanbul Sabahattin Zaim University", value: 164, activityNo: "189e3612-019b-4b04-89df-0a2bce88a8f3", mailType: "std.izu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "istanbulticaret.edu.tr": { universityName: "İstanbul Ticaret University", value: 165, activityNo: "9b60eaf0-9ff9-488f-986c-a59c4e986ba9", mailType: "istanbulticaret.edu.tr", isActive: true, whichCountry: "Turkey" },
        "stu.istinye.edu.tr": { universityName: "İstinye University", value: 166, activityNo: "69f4c66a-2136-4e74-991d-fd658243e7ff", mailType: "stu.istinye.edu.tr", isActive: true, whichCountry: "Turkey" },
        "std.izmirekonomi.edu.tr": { universityName: "İzmir Ekonomi University", value: 167, activityNo: "001afab7-3e9d-4c6b-8b1c-3e21a27232d9", mailType: "std.izmirekonomi.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ku.edu.tr": { universityName: "Koç University", value: 168, activityNo: "ed14f0ea-41fd-4c1b-85cf-27863a419ebb", mailType: "ku.edu.tr", isActive: true, whichCountry: "Turkey" },
        "st.maltepe.edu.tr": { universityName: "Maltepe University", value: 169, activityNo: "8d6b4d51-0182-4e6d-984c-f29c8ca9f851", mailType: "st.maltepe.edu.tr", isActive: true, whichCountry: "Turkey" },
        "std.nisantasi.edu.tr": { universityName: "Nişantaşı University", value: 170, activityNo: "64b88fbd-887a-4482-98f2-cd3f2209d7a0", mailType: "std.nisantasi.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ogrenci.nny.edu.tr": { universityName: "Nuh Naci Yazgan University", value: 171, activityNo: "7ace0a28-bd67-4383-83e8-2668ac7a8450", mailType: "ogrenci.nny.edu.tr", isActive: true, whichCountry: "Turkey" },
        "stu.okan.edu.tr": { universityName: "Okan University", value: 172, activityNo: "da6bea5b-c7ef-49f8-b6d2-4f8085c6b7bc", mailType: "stu.okan.edu.tr", isActive: true, whichCountry: "Turkey" },
        "ozu.edu.tr": { universityName: "Özyeğin University", value: 173, activityNo: "2edb4225-138b-4b6e-9b75-3531130ee34b", mailType: "ozu.edu.tr", isActive: true, whichCountry: "Turkey" },
        "pru.edu.tr": { universityName: "Piri Reis University", value: 174, activityNo: "59826e8c-2554-4dd8-bfdf-5613768066bf", mailType: "pru.edu.tr", isActive: true, whichCountry: "Turkey" },
        "sabanciuniv.edu": { universityName: "Sabancı University", value: 175, activityNo: "sabanciuniv.edu", mailType: "sabanciuniv.edu", isActive: true, whichCountry: "Turkey" },
        "toros.edu.tr": { universityName: "Toros University", value: 176, activityNo: "e93d3c81-9336-4dbf-99c9-bbbd70cb91aa", mailType: "toros.edu.tr", isActive: true, whichCountry: "Turkey" },
        "st.uskudar.edu.tr": { universityName: "Üsküdar University", value: 177, activityNo: "2d773876-4d89-46d0-b258-6b572302bae5", mailType: "st.uskudar.edu.tr", isActive: true, whichCountry: "Turkey" },
        "stu.yasar.edu.tr": { universityName: "Yaşar University", value: 178, activityNo: "8c9f907d-6f19-4739-bc95-d7469c7df1a9", mailType: "stu.yasar.edu.tr", isActive: true, whichCountry: "Turkey" },
        "std.yeditepe.edu.tr": { universityName: "Yeditepe University", value: 179, activityNo: "1caad9c2-14e4-4289-971b-a368551c243c", mailType: "std.yeditepe.edu.tr", isActive: true, whichCountry: "Turkey" },
        "galata.edu.tr": { universityName: "Istanbul Galata University", value: 180, activityNo: "d1c12948-c061-425f-9485-57c933e841a2", mailType: "galata.edu.tr", isActive: true, whichCountry: "Turkey" },



















    }
};





exports.sendMessageNotification = functions.firestore.document('groups_chat/{groupId}/chat_data/{messageId}').onCreate(async (snap, context) => {
    console.log('----------------start function--------------------');

    const messageData = snap.data();

    const groupNo = context.params.groupId;

    const member1 = messageData.member_message_target_1_uid;
    console.log(member1);
    const member2 = messageData.member_message_target_2_uid;
    console.log(member2);
    const messageText = messageData.member_message;
    console.log(messageText);
    const messageSender = messageData.member_name;
    console.log(messageSender);
    const messageSenderAvatar = messageData.member_avatar_url;
    console.log(messageSenderAvatar);
    const messageIsImage = messageData.member_message_isimage;
    const messageIsVideo = messageData.member_message_isvideo;
    const messageIsVoice = messageData.member_message_isvoice;
    const messageIsDoc = messageData.member_message_isdocument;


    var member1Coming = await db.collection('users_display').doc(member1).get();
    var member2Coming = await db.collection('users_display').doc(member2).get();


    var member1NotiChaos = await db.collection('users_notification_settings').doc(member1).get();
    var member2NotiChaos = await db.collection('users_notification_settings').doc(member2).get();



    var member1Datas = member1Coming.data();
    var member2Datas = member2Coming.data();

    var member1NotiData = member1NotiChaos.data();
    var member2NotiData = member2NotiChaos.data();

    const member1uDbToken = member1Datas.uDbToken;
    console.log(member1uDbToken);
    const member2uDbToken = member2Datas.uDbToken;
    console.log(member2uDbToken);



    var membersTokenList = [member1uDbToken, member2uDbToken];



    /*

    const member1Payload = {
        notification: {
            //     title: `You have a message from $messageSender`,
            title: messageSender,
            body: messageText,
            badge: '1',
            sound: 'default'
        }
    }
    const member2Payload = {
        notification: {
            // title: `You have a message from ${messageSender}`,
            title: messageSender,
            body: messageText,
            badge: '1',
            sound: 'default'
        }
    }
*/

    if (!member1uDbToken) {
        console.log('member1uDbToken return döndü');
        return;
    }
    /*
    else {
        console.log('member1uDbToken işlem yapıldı');

        await admin.messaging().sendToDevice(member1uDbToken, member1Payload);
    }
*/
    if (!member2uDbToken) {
        console.log('member2uDbToken return döndü');
        return;

    }
    /*
    else {
        console.log('member2uDbToken işlem yapıldı');
        await admin.messaging().sendToDevice(member2uDbToken, member2Payload);

    }*/
    console.log(groupNo);

    var textBody;


    if (messageIsImage == false && messageIsVideo == false && messageIsVoice == false && messageIsDoc == false) {
        textBody = messageSender + ': ' + messageText;
    }
    else {

        if (messageIsImage) {
            textBody = messageSender + ': Image';
        }
        else if (messageIsVoice) {
            textBody = messageSender + ': Voice';
        }
        else if (messageIsVideo) {
            textBody = messageSender + ': Video';
        }
        else if (messageIsDoc) {
            textBody = messageSender + ': Document';

        }

    }


    if (member1NotiData.group_messages && member2NotiData.group_messages) {
        await admin.messaging().sendMulticast({
            tokens: [member1uDbToken, member2uDbToken],
            topic: 'chat_items',
            type: 'chat',
            notification: {
                title: "New Message",
                body: textBody,


            },
            data: {
                notiGroupNo: groupNo,
                notiCategory: 'chat_message'

            }

        }).then((response) => {

            // Response is a message ID string.
            console.log('Successfully sent message:', response);
            return { success: true };
        }).catch((error) => {
            return { error: error.code };
        });


    }
    else {
        const payloadLike = {
            topic: 'chat_items',
            type: 'chat',
            notification: {
                title: "New Message",
                body: textBody


            },
            data: {
                notiGroupNo: groupNo,
                notiCategory: 'chat_message'

            }
        };

        if (member1NotiData.group_messages) {


            await admin.messaging().sendToDevice(member1uDbToken, payloadLike).then((response) => {

                // Response is a message ID string.
                console.log('Successfully sent message:', response);
                return { success: true };
            }).catch((error) => {
                return { error: error.code };
            });


        }

        if (member2NotiData.group_messages) {
            await admin.messaging().sendToDevice(member2uDbToken, payloadLike).then((response) => {

                // Response is a message ID string.
                console.log('Successfully sent message:', response);
                return { success: true };
            }).catch((error) => {
                return { error: error.code };
            });
        }

    }









});
exports.sendChaosMessageNotification = functions.firestore.document('chaos_groups_chat/{groupId}/chat_data/{messageId}').onCreate(async (snap, context) => {
    console.log('----------------start function--------------------');

    const messageData = snap.data();
    const groupNo = context.params.groupId;


    const member1 = messageData.member_message_target_1_uid;
    console.log(member1);
    const member2 = messageData.member_message_target_2_uid;
    console.log(member2);
    const member3 = messageData.member_message_target_3_uid;
    console.log(member3);
    const member4 = messageData.member_message_target_4_uid;
    console.log(member4);
    const member5 = messageData.member_message_target_5_uid;
    console.log(member5);


    const messageText = messageData.member_message;
    console.log(messageText);
    const messageSender = messageData.member_name;
    console.log(messageSender);
    const messageSenderAvatar = messageData.member_avatar_url;
    console.log(messageSenderAvatar);
    const messageIsImage = messageData.member_message_isimage;
    const messageIsVideo = messageData.member_message_isvideo;
    const messageIsVoice = messageData.member_message_isvoice;




    const targetMember1NotiChaosGet = await db.collection('users_notification_settings').doc(member1).get();
    const targetMember2NotiChaosGet = await db.collection('users_notification_settings').doc(member2).get();
    const targetMember3NotiChaosGet = await db.collection('users_notification_settings').doc(member3).get();
    const targetMember4NotiChaosGet = await db.collection('users_notification_settings').doc(member4).get();
    const targetMember5NotiChaosGet = await db.collection('users_notification_settings').doc(member5).get();

    const targetMember1NotiData = targetMember1NotiChaosGet.data();
    const targetMember2NotiData = targetMember2NotiChaosGet.data();
    const targetMember3NotiData = targetMember3NotiChaosGet.data();
    const targetMember4NotiData = targetMember4NotiChaosGet.data();
    const targetMember5NotiData = targetMember5NotiChaosGet.data();

    const targetMember1NotiChaosystemNotifications = targetMember1NotiData.chaos_messages;
    const targetMember2NotiChaosystemNotifications = targetMember2NotiData.chaos_messages;
    const targetMember3NotiChaosystemNotifications = targetMember3NotiData.chaos_messages;
    const targetMember4NotiChaosystemNotifications = targetMember4NotiData.chaos_messages;
    const targetMember5NotiChaosystemNotifications = targetMember5NotiData.chaos_messages;




    var exTokenList = [];

    if (targetMember1NotiChaosystemNotifications) {
        const targetMember1TokenGet = await db.collection('users_display').doc(member1).get();
        const targetMember1DisplayData = targetMember1TokenGet.data();
        const targetMember1Token = targetMember1DisplayData.uDbToken;


        exTokenList.push(targetMember1Token);

    }

    if (targetMember2NotiChaosystemNotifications) {
        const targetMember2TokenGet = await db.collection('users_display').doc(member2).get();
        const targetMember2DisplayData = targetMember2TokenGet.data();
        const targetMember2Token = targetMember2DisplayData.uDbToken;

        exTokenList.push(targetMember2Token);


    }

    if (targetMember3NotiChaosystemNotifications) {
        const targetMember3TokenGet = await db.collection('users_display').doc(member3).get();
        const targetMember3DisplayData = targetMember3TokenGet.data();
        const targetMember3Token = targetMember3DisplayData.uDbToken;

        exTokenList.push(targetMember3Token);

    }

    if (targetMember4NotiChaosystemNotifications) {
        const targetMember4TokenGet = await db.collection('users_display').doc(member4).get();
        const targetMember4DisplayData = targetMember4TokenGet.data();
        const targetMember4Token = targetMember4DisplayData.uDbToken;


        exTokenList.push(targetMember4Token);

    }

    if (targetMember5NotiChaosystemNotifications) {


        const targetMember5TokenGet = await db.collection('users_display').doc(member5).get();
        const targetMember5DisplayData = targetMember5TokenGet.data();
        const targetMember5Token = targetMember5DisplayData.uDbToken;

        exTokenList.push(targetMember5Token);
    }




    /*
        var member1Coming = await db.collection('users_display').doc(member1).get();
        var member2Coming = await db.collection('users_display').doc(member2).get();
        var member3Coming = await db.collection('users_display').doc(member3).get();
        var member4Coming = await db.collection('users_display').doc(member4).get();
        var member5Coming = await db.collection('users_display').doc(member5).get();
    
    
        var member1Datas = member1Coming.data();
        var member2Datas = member2Coming.data();
        var member3Datas = member3Coming.data();
        var member4Datas = member4Coming.data();
        var member5Datas = member5Coming.data();
    
    
    
        const member1uDbToken = member1Datas.uDbToken;
        console.log(member1uDbToken);
        const member2uDbToken = member2Datas.uDbToken;
        console.log(member2uDbToken);
        const member3uDbToken = member3Datas.uDbToken;
        console.log(member3uDbToken);
        const member4uDbToken = member4Datas.uDbToken;
        console.log(member4uDbToken);
        const member5uDbToken = member5Datas.uDbToken;
        console.log(member5uDbToken);
    */
    /*

    const member1Payload = {
        notification: {
            //     title: `You have a message from $messageSender`,
            title: messageSender,
            body: messageText,
            badge: '1',
            sound: 'default'
        }
    }
    const member2Payload = {
        notification: {
            // title: `You have a message from ${messageSender}`,
            title: messageSender,
            body: messageText,
            badge: '1',
            sound: 'default'
        }
    }
*/
    /*
       if (!member1uDbToken) {
           console.log('member1uDbToken return döndü');
           return;
       }
      
       else {
           console.log('member1uDbToken işlem yapıldı');
   
           await admin.messaging().sendToDevice(member1uDbToken, member1Payload);
       }
   
   
       if (!member2uDbToken) {
           console.log('member2uDbToken return döndü');
           return;
   
       }
       if (!member3uDbToken) {
           console.log('member3uDbToken return döndü');
           return;
   
       }
       if (!member4uDbToken) {
           console.log('member4uDbToken return döndü');
           return;
   
       }
       if (!member5uDbToken) {
           console.log('member5uDbToken return döndü');
           return;
   
       }
   
   */
    /*
    else {
        console.log('member2uDbToken işlem yapıldı');
        await admin.messaging().sendToDevice(member2uDbToken, member2Payload);

    }*/


    await admin.messaging().sendMulticast({
        tokens: exTokenList,
        type: 'chat',
        notification: {
            title: "New Chaos Message",
            body: messageSender + ': ' + messageText,

        },
        data: {
            notiGroupNo: groupNo,
            notiCategory: 'chat_message'

        }
    }).then((response) => {

        // Response is a message ID string.
        console.log('Successfully sent message:', response);
        return { success: true };
    }).catch((error) => {
        return { error: error.code };
    });






});
exports.checkGroupActive = functions.firestore.document('groups/{docNo}').onUpdate(async (change, context) => {




    const gActiveNewStatus = change.after.data().gActive;
    const gActivePreviousStatus = change.before.data().gActive;






    if (gActiveNewStatus && gActivePreviousStatus == false) {


        const gNo = change.after.id;
        const gList = change.after.data().gList;
        var firstUserDoc = await db.collection('users_meta').doc(gList[0]).get();
        var secondUserDoc = await db.collection('users_meta').doc(gList[1]).get();
        var thirdUserDoc = await db.collection('users_meta').doc(gList[2]).get();

        var firstUserDisplayDoc = await db.collection('users_display').doc(gList[0]).get();
        var secondUserDisplayDoc = await db.collection('users_display').doc(gList[1]).get();
        var thirdUserDisplayDoc = await db.collection('users_display').doc(gList[2]).get();


        var firstUserData = firstUserDoc.data();
        var secondUserData = secondUserDoc.data();
        var thirdUserData = thirdUserDoc.data();

        var firstUserDisplayData = firstUserDisplayDoc.data();
        var secondUserDisplayData = secondUserDisplayDoc.data();
        var thirdUserDisplayData = thirdUserDisplayDoc.data();

        var firstUserTokenDownerAmount = 1;
        var secondUserTokenDownerAmount = 1;
        var thirdUserTokenDownerAmount = 1;

        if (firstUserData.uGroupList.length < 3) {
            firstUserTokenDownerAmount = 0;


            if (firstUserData.uGroupList[0] == 'nothing') {

                firstUserData.uGroupList = [];


            }


        }


        if (secondUserData.uGroupList.length < 3) {
            secondUserTokenDownerAmount = 0;
            if (secondUserData.uGroupList[0] == 'nothing') {

                secondUserData.uGroupList = [];


            }


        }



        if (thirdUserData.uGroupList.length < 3) {
            thirdUserTokenDownerAmount = 0;

            if (thirdUserData.uGroupList[0] == 'nothing') {

                thirdUserData.uGroupList = [];


            }
        }




        const currentDate = new Date('December 10, 1815');
        const timestamp = currentDate.getTime();

        var firstUserGroupList = firstUserData.uGroupList;
        await firstUserGroupList.push(gNo);

        var secondUserGroupList = secondUserData.uGroupList;
        await secondUserGroupList.push(gNo);

        var thirdUserGroupList = thirdUserData.uGroupList;
        await thirdUserGroupList.push(gNo);

        1656775744945


        const currentDate2 = new Date();
        const timestamp2 = currentDate2.getTime();


        const currentDate3 = new Date();
        const timestamp3 = currentDate3.getTime();


        const currentDate4 = new Date();
        const timestamp4 = currentDate4.getTime();




        const targetMember1NotiChaosGet = await db.collection('users_notification_settings').doc(firstUserData.uUid).get();
        const targetMember2NotiChaosGet = await db.collection('users_notification_settings').doc(secondUserData.uUid).get();
        const targetMember3NotiChaosGet = await db.collection('users_notification_settings').doc(thirdUserData.uUid).get();


        const targetMember1NotiData = targetMember1NotiChaosGet.data();
        const targetMember2NotiData = targetMember2NotiChaosGet.data();
        const targetMember3NotiData = targetMember3NotiChaosGet.data();


        const targetMember1NotiNewMatchesNotifications = targetMember1NotiData.new_matches;
        const targetMember2NotiNewMatchesNotifications = targetMember2NotiData.new_matches;
        const targetMember3NotiNewMatchesNotifications = targetMember3NotiData.new_matches;



        var exTokenList = [];

        if (targetMember1NotiNewMatchesNotifications) {
            const targetMember1TokenGet = await db.collection('users_display').doc(firstUserData.uUid).get();
            const targetMember1DisplayData = targetMember1TokenGet.data();
            const targetMember1Token = targetMember1DisplayData.uDbToken;


            exTokenList.push(targetMember1Token);

        }

        if (targetMember2NotiNewMatchesNotifications) {
            const targetMember2TokenGet = await db.collection('users_display').doc(secondUserData.uUid).get();
            const targetMember2DisplayData = targetMember2TokenGet.data();
            const targetMember2Token = targetMember2DisplayData.uDbToken;

            exTokenList.push(targetMember2Token);


        }

        if (targetMember3NotiNewMatchesNotifications) {
            const targetMember3TokenGet = await db.collection('users_display').doc(thirdUserData.uUid).get();
            const targetMember3DisplayData = targetMember3TokenGet.data();
            const targetMember3Token = targetMember3DisplayData.uDbToken;

            exTokenList.push(targetMember3Token);

        }


        const batch = db.batch();

        const firstMemberRef = db.collection('users_meta').doc(gList[0]);
        batch.update(firstMemberRef, { uGroupList: firstUserGroupList, uSearching: false, uToken: firstUserData.uToken - firstUserTokenDownerAmount });

        const secondMemberRef = db.collection('users_meta').doc(gList[1]);
        batch.update(secondMemberRef, { uGroupList: secondUserGroupList, uSearching: false, uToken: secondUserData.uToken - secondUserTokenDownerAmount });

        const thirdMemberRef = db.collection('users_meta').doc(gList[2]);
        batch.update(thirdMemberRef, { uGroupList: thirdUserGroupList, uSearching: false, uToken: thirdUserData.uToken - thirdUserTokenDownerAmount });

        const groupChatRef = db.collection('groups_chat').doc(gNo).collection('chat_data').doc();
        const groupChatRef2 = db.collection('groups_chat').doc(gNo).collection('chat_data').doc();
        const groupChatRef3 = db.collection('groups_chat').doc(gNo).collection('chat_data').doc();
        const groupChatRef4 = db.collection('groups_chat').doc(gNo).collection('chat_data').doc();
        batch.set(groupChatRef, {
            'member_avatar_url': "https://firebasestorage.googleapis.com/v0/b/isola-b2dd8.appspot.com/o/default_files%2Fgroup_leave_icon.png?alt=media&token=11e9f80d-8604-494e-899c-f8f471469bd3",
            'member_message': "Welcome To Group",
            'member_message_attachment_url': "isola_system_message",
            'member_message_isattachment': false,
            'member_message_isdocument': false,
            'member_message_isimage': false,
            'member_message_isvideo': false,
            'member_message_isvoice': false,
            'member_message_target_1_uid': secondUserData.uUid,
            'member_message_target_2_uid': thirdUserData.uUid,
            'member_message_time': currentDate,
            'member_message_voice_url': "",
            'member_name': "System Message",
            'member_uid': firstUserData.uUid,
            'member_message_no': groupChatRef.id,
        });
        batch.set(groupChatRef2, {

            'member_avatar_url': firstUserDisplayData.uPic,
            'member_message': "Hello!",
            'member_message_attachment_url': "",
            'member_message_isattachment': false,
            'member_message_isdocument': false,
            'member_message_isimage': false,
            'member_message_isvideo': false,
            'member_message_isvoice': false,
            'member_message_target_1_uid': secondUserData.uUid,
            'member_message_target_2_uid': thirdUserData.uUid,
            'member_message_time': currentDate2,
            'member_message_voice_url': "",
            'member_name': firstUserDisplayData.uName,
            'member_uid': firstUserData.uUid,
            'member_message_no': groupChatRef2.id,

        });
        batch.set(groupChatRef3, {

            'member_avatar_url': secondUserDisplayData.uPic,
            'member_message': "Hello!",
            'member_message_attachment_url': "",
            'member_message_isattachment': false,
            'member_message_isdocument': false,
            'member_message_isimage': false,
            'member_message_isvideo': false,
            'member_message_isvoice': false,
            'member_message_target_1_uid': firstUserData.uUid,
            'member_message_target_2_uid': thirdUserData.uUid,
            'member_message_time': currentDate3,
            'member_message_voice_url': "",
            'member_name': secondUserDisplayData.uName,
            'member_uid': secondUserData.uUid,
            'member_message_no': groupChatRef3.id,

        });
        batch.set(groupChatRef4, {

            'member_avatar_url': thirdUserDisplayData.uPic,
            'member_message': "Hello!",
            'member_message_attachment_url': "",
            'member_message_isattachment': false,
            'member_message_isdocument': false,
            'member_message_isimage': false,
            'member_message_isvideo': false,
            'member_message_isvoice': false,
            'member_message_target_1_uid': firstUserData.uUid,
            'member_message_target_2_uid': secondUserData.uUid,
            'member_message_time': currentDate4,
            'member_message_voice_url': "",
            'member_name': thirdUserDisplayData.uName,
            'member_uid': thirdUserData.uUid,
            'member_message_no': groupChatRef4.id,

        });



        await batch.commit();




        await admin.messaging().sendMulticast({
            tokens: exTokenList,
            type: 'chat',
            notification: {
                title: "New Matching",
                body: 'Your new matching is ready now ! ',

            }
        }).then((response) => {

            // Response is a message ID string.
            console.log('Successfully sent message:', response);
            return { success: true };
        }).catch((error) => {
            return { error: error.code };
        });

    }




});
exports.groupFind = functions.firestore.document('matching_pool/{user_uid}').onCreate(async (snap, context) => {


    const newUser = snap.data();
    // const newUuid

    const groupsAddingRef = db.collection('groups').doc();
    const groupsRef = db.collection('groups');
    const matchingPoolRef = db.collection('matching_pool');

    const usersMetaRef = db.collection('users_meta');
    const snapshot = await groupsRef.where('gActive', '==', false)
        .where('gNeed', '==', true)
        // .where('gNonBinary', '==', newUser.uNonBinary)
        .where('gValid', '==', newUser.uValid).get();


    if (snapshot.empty) {
        //searching true

        await groupsAddingRef.set({
            'gActive': false,
            'gNonBinary': newUser.uNonBinary,
            'gList': [newUser.uUid],
            'gValue': 1,
            'gNeed': true,
            'gSex': newUser.uSex,
            'gValid': newUser.uValid,
            'gToken': 0,
            'gNo': groupsAddingRef.id,
            'gChaos': false,
            'gChaosNo': "nothing",
            'gChaosSearching': false,


        });
        console.log('grup yoktu o sebeple kuruldu');

        matchingPoolRef.doc(newUser.uUid).delete();

        console.log('Havuzdan ismim silindi');




        usersMetaRef.doc(newUser.uUid).update({
            'uSearching': true,
        });
        console.log('searching true ya çevrildi');


        return;
    }

    else {
        var isOkey = false;
        var loopValue = 0;
        const snapDatas = snapshot.docs;

        do {
            // code block to be executed

            const targetData = snapDatas[loopValue];




            try {

                db.runTransaction(async (t) => {

                    var targetGroup = await t.get(groupsRef.doc(targetData.data().gNo));
                    var targetGroupData = targetGroup.data();



                    console.log('group is non binary girildi');
                    if (targetGroupData.gValue > 1) {
                        console.log('gvalue 1 den büyük girdi');
                        //group_member_value == 2
                        var oldList2 = targetGroupData.gList;
                        await oldList2.push(newUser.uUid);


                        t.update(groupsRef.doc(targetGroupData.gNo), {
                            'gActive': true,
                            gList: oldList2,
                            'gValue': 3,
                            'gNeed': false,


                        });
                        console.log('grup değeri 2 bu sebeple içine eklenip active yapıldı ');

                    }
                    else {
                        console.log('gvalue 1 den küçük girdi');
                        //searching true
                        //burada takılıyor arrayUnion fonksyionunda sorun var


                        var oldList2 = targetGroup.data().gList;
                        await oldList2.push(newUser.uUid);
                        //Sayı yazdı




                        groupsRef.doc(targetGroupData.gNo).update({

                            gValue: 2,
                            gList: oldList2,


                        });

                        console.log('grup değeri 1 di ve 2 yapıldı');
                        usersMetaRef.doc(newUser.uUid).update({
                            'uSearching': true,
                        });

                        console.log('grup değeri 1 di ve search true');


                    }


                    matchingPoolRef.doc(newUser.uUid).delete();
                    console.log('grup değeri 1 ve uid havuzdan silindi');


                    isOkey = true;

                    /*
                    BURASI CİNSİYET AYRIMLI ÜSTTEKİNİ SİLİP BURAYI AÇABİLİRSİN
                                        if (targetGroupData.gNonBinary == true) {
                    
                    
                                            console.log('group is non binary girildi');
                                            if (targetGroupData.gValue > 1) {
                                                console.log('gvalue 1 den büyük girdi');
                                                //group_member_value == 2
                                                var oldList2 = targetGroupData.gList;
                                                await oldList2.push(newUser.uUid);
                    
                    
                                                t.update(groupsRef.doc(targetGroupData.gNo), {
                                                    'gActive': true,
                                                    gList: oldList2,
                                                    'gValue': 3,
                                                    'gNeed': false,
                    
                    
                                                });
                                                console.log('grup değeri 2 bu sebeple içine eklenip active yapıldı ');
                    
                                            }
                                            else {
                                                console.log('gvalue 1 den küçük girdi');
                                                //searching true
                                                //burada takılıyor arrayUnion fonksyionunda sorun var
                    
                    
                                                var oldList2 = targetGroup.data().gList;
                                                await oldList2.push(newUser.uUid);
                                                //Sayı yazdı
                    
                    
                    
                    
                                                groupsRef.doc(targetGroupData.gNo).update({
                    
                                                    gValue: 2,
                                                    gList: oldList2,
                    
                    
                                                });
                    
                                                console.log('grup değeri 1 di ve 2 yapıldı');
                                                usersMetaRef.doc(newUser.uUid).update({
                                                    'uSearching': true,
                                                });
                    
                                                console.log('grup değeri 1 di ve search true');
                    
                    
                                            }
                    
                    
                                            matchingPoolRef.doc(newUser.uUid).delete();
                                            console.log('grup değeri 1 ve uid havuzdan silindi');
                    
                    
                                            isOkey = true;
                    
                                        }
                                        else if (targetGroupData.gSex == newUser.uSex) {
                                            console.log('binary değildi o sebeple sex e girdi');
                                            if (targetGroupData.gValue > 1) {
                                                //group_member_value == 2
                                                var oldList2 = targetGroupData.gList;
                                                await oldList2.push(newUser.uUid);
                    
                                                t.update(groupsRef.doc(targetGroupData.gNo), {
                                                    'gActive': true,
                                                    'gList': oldList2,
                                                    'gValue': 3,
                                                    'gNeed': false,
                    
                                                });
                    
                                                console.log('sex içinde grup değeri 2 di 3 yapılıp aktif edildi');
                    
                                            }
                                            else {
                                                //searching true
                                                var oldList2 = targetGroupData.gList;
                                                await oldList2.push(newUser.uUid);
                    
                                                t.update(groupsRef.doc(targetGroupData.gNo), {
                    
                                                    'gList': oldList2,
                                                    'gValue': 2,
                    
                                                });
                    
                                                console.log('sexte grup değeri 1 di eklendi');
                    
                                                usersMetaRef.doc(newUser.uUid).update({
                                                    'uSearching': true,
                                                });
                                                console.log('grup değeri 1 di  sexte searching aktif');
                    
                    
                                            }
                                            matchingPoolRef.doc(newUser.uUid).delete();
                                            console.log('sex eşleşme havuzdan silindi');
                                            isOkey = true;
                    
                                        }
                    */
                });



            } catch (error) {


            }


            loopValue = loopValue + 1;

        }
        while (isOkey == false && loopValue < snapshot.length);
        /*
                for (let index = 0; index < snapshot.length; index++) {
                    const doc = snapshot[index];
         try {
        
                        db.runTransaction(async (t) => {
        
                            const targetGroup = await t.get(groupsRef.doc(doc.data().gNo));
                            const targetGroupData = targetGroup.data();
        
        
                            if (targetGroupData.gNonBinary == true) {
        
        
                                console.log('group is non binary girildi');
                                if (targetGroupData.gValue > 1) {
                                    //group_member_value == 2
                                    var oldList2 = targetGroupData.gList;
                                    oldList2.push(newUser.uUid);
        
        
                                    t.update(groupsRef.doc(targetGroupData.gNo), {
                                        'gActive': true,
                                        gList: oldList2,
                                        'gValue': 3,
                                        'gNeed': false,
        
        
                                    });
                                    console.log('grup değeri 2 bu sebeple içine eklenip active yapıldı ');
        
                                }
                                else {
                                    //searching true
                                    //burada takılıyor arrayUnion fonksyionunda sorun var
        
        
                                    var oldList2 = doc.data().gList;
                                    oldList2.push(newUser.uUid);
                                    //Sayı yazdı
        
        
        
        
                                    groupsRef.doc(doc.id).update({
        
                                        gValue: 2,
                                        gList: oldList2,
        
        
                                    });
        
                                    console.log('grup değeri 1 di ve 2 yapıldı');
                                    usersMetaRef.doc(newUser.uUid).update({
                                        'uSearching': true,
                                    });
        
                                    console.log('grup değeri 1 di ve search true');
        
        
                                }
                                matchingPoolRef.doc(newUser.uUid).delete();
                                console.log('grup değeri 1 ve uid havuzdan silindi');
        
        
        
                            }
                            else if (targetGroupData.gSex == newUser.uSex) {
                                console.log('binary değildi o sebeple sex e girdi');
                                if (targetGroupData.gValue > 1) {
                                    //group_member_value == 2
                                    var oldList2 = targetGroupData.gList;
                                    oldList2.push(newUser.uUid);
        
                                    t.update(groupsRef.doc(targetGroupData.gNo), {
                                        'gActive': true,
                                        'gList': oldList2,
                                        'gValue': 3,
                                        'gNeed': false,
        
                                    });
        
                                    console.log('sex içinde grup değeri 2 di 3 yapılıp aktif edildi');
        
                                }
                                else {
                                    //searching true
                                    var oldList2 = targetGroupData.gList;
                                    oldList2.push(newUser.uUid);
        
                                    t.update(groupsRef.doc(targetGroupData.gNo), {
        
                                        'gList': oldList2,
                                        'gValue': 2,
        
                                    });
        
                                    console.log('sexte grup değeri 1 di eklendi');
        
                                    usersMetaRef.doc(newUser.uUid).update({
                                        'uSearching': true,
                                    });
                                    console.log('grup değeri 1 di  sexte searching aktif');
        
        
                                }
                                matchingPoolRef.doc(newUser.uUid).delete();
                                console.log('sex eşleşme havuzdan silindi');
        
                            }
        
                        });
        
                        index = snapshot.length;
        
                    } catch (error) {
                        index = index + 1;
        
                    }
                   
        
        
        
        
                }*/

    }   /*
    else {
        snapshot.forEach(doc => {
            // console.log(doc.id, '=>', doc.data());



            try {

                db.runTransaction(async (t) => {

                    const targetGroup = await t.get(groupsRef.doc(doc.data().gNo));
                    const targetGroupData = targetGroup.data();


                    if (targetGroupData.gNonBinary == true) {


                        console.log('group is non binary girildi');
                        if (targetGroupData.gValue > 1) {
                            //group_member_value == 2
                            var oldList2 = targetGroupData.gList;
                            oldList2.push(newUser.uUid);


                            t.update(groupsRef.doc(targetGroupData.gNo), {
                                'gActive': true,
                                gList: oldList2,
                                'gValue': 3,
                                'gNeed': false,


                            });
                            console.log('grup değeri 2 bu sebeple içine eklenip active yapıldı ');

                        }
                        else {
                            //searching true
                            //burada takılıyor arrayUnion fonksyionunda sorun var


                            var oldList2 = doc.data().gList;
                            oldList2.push(newUser.uUid);
                            //Sayı yazdı




                            groupsRef.doc(doc.id).update({

                                gValue: 2,
                                gList: oldList2,


                            });

                            console.log('grup değeri 1 di ve 2 yapıldı');
                            usersMetaRef.doc(newUser.uUid).update({
                                'uSearching': true,
                            });

                            console.log('grup değeri 1 di ve search true');


                        }
                        matchingPoolRef.doc(newUser.uUid).delete();
                        console.log('grup değeri 1 ve uid havuzdan silindi');

                        break;

                    }
                    else if (targetGroupData.gSex == newUser.uSex) {
                        console.log('binary değildi o sebeple sex e girdi');
                        if (targetGroupData.gValue > 1) {
                            //group_member_value == 2
                            var oldList2 = targetGroupData.gList;
                            oldList2.push(newUser.uUid);

                            t.update(groupsRef.doc(targetGroupData.gNo), {
                                'gActive': true,
                                'gList': oldList2,
                                'gValue': 3,
                                'gNeed': false,

                            });

                            console.log('sex içinde grup değeri 2 di 3 yapılıp aktif edildi');

                        }
                        else {
                            //searching true
                            var oldList2 = targetGroupData.gList;
                            oldList2.push(newUser.uUid);

                            t.update(groupsRef.doc(targetGroupData.gNo), {

                                'gList': oldList2,
                                'gValue': 2,

                            });

                            console.log('sexte grup değeri 1 di eklendi');

                            usersMetaRef.doc(newUser.uUid).update({
                                'uSearching': true,
                            });
                            console.log('grup değeri 1 di  sexte searching aktif');


                        }
                        matchingPoolRef.doc(newUser.uUid).delete();
                        console.log('sex eşleşme havuzdan silindi');
                        break;
                    }

                });

            } catch (error) {

            }



        });
    
   
    } */
});
exports.createNewUserMeta = functions.auth.user().onCreate(async (user) => {
    const newUserUid = user.uid;
    const newUserMail = user.email;
    const newUserName = user.displayName;
    const newUserUniversity = newUserMail.substring(newUserMail.lastIndexOf('@') + 1);



    console.log(newUserUniversity);
    console.log(newUserMail);


    var uActivityNo;
    var uIsActive;
    var uUniversityName;

    if (universityList.includes(newUserUniversity)) {

        console.log('include calisti');
        uActivityNo = [universityEnum.properties[newUserUniversity].activityNo];
        uIsActive = universityEnum.properties[newUserUniversity].isActive;
        uUniversityName = universityEnum.properties[newUserUniversity].universityName;

    }
    else {
        console.log('inc calismadi');
        uActivityNo = ["null"];
        uIsActive = false;
        uUniversityName = newUserUniversity;

    }



    const currentDate = new Date();

    const metaRef = db.collection('users_meta').doc(newUserUid);
    const displayRef = db.collection('users_display').doc(newUserUid);
    const statisticsRef = db.collection('users_statistics').doc(newUserUid);
    const likeHistoryRef = db.collection('users_like_history').doc(newUserUid);
    const usersNotificationChaosRef = db.collection('users_notification_settings').doc(newUserUid);
    const universityStatisticsRef = db.collection('university_statistics').doc(newUserUniversity).collection('users').doc(newUserUid);
    const universityStatisticsValueRef = db.collection('university_statistics').doc(newUserUniversity);
    const batch = db.batch();


    batch.set(metaRef, {
        'uUid': newUserUid,
        'uBlocked': ["nothing"],
        'uFriends': ["nothing"],
        'uClubs': uActivityNo,
        'uValid': uIsActive,
        'uGroupList': ["nothing"],
        'uEmail': newUserMail,
        'uToken': 0,
        'uSearching': false,
        'uFriendOrders': ["nothing"],
    });
    batch.set(displayRef, {
        'uPic': "https://firebasestorage.googleapis.com/v0/b/isola-b2dd8.appspot.com/o/default_files%2Fdefault_profile_photo.png?alt=media&token=fd38c835-ce62-4e3b-8dec-3914f2c94586",
        'uBio': "My Biography",
        'uInterest': ["interest1", "interest2", "interest3", "interest4", "interest5"],
        'uNonBinary': true,
        'uOnline': true,
        'uName': newUserName,
        'uSex': true,
        'uUniversity': uUniversityName,
        'uAct': ["nothing"],
        'uLike': ["nothing"],
        'uDbToken': "token1",
    });

    batch.set(statisticsRef, {
        'rt101': 0,
        'rt102': 0,
        'rt103': 0,
        'rt104': 0,
        'rt105': 0
    });

    batch.set(likeHistoryRef, {

        'like_datas': ["nothing"]
    });

    batch.set(usersNotificationChaosRef, {

        'chaos_messages': true,
        'group_messages': true,
        'likes': true,
        'new_matches': true,
        'chaos_messages': true,
        'tokens': true
    })
    batch.set(universityStatisticsRef, {
        'user_mail': newUserMail,
        'user_name': newUserName,
        'user_uid': newUserUid,
        'created_time': currentDate

    })

    await batch.commit();


    try {

        await db.runTransaction(async (t) => {

            const uniValueGetting = await t.get(universityStatisticsValueRef);


            const uniValueData = uniValueGetting.data();
            try {
                var uniValue = uniValueData.university_users_value;
                t.update(universityStatisticsValueRef, {
                    'university_users_value': uniValue + 1,

                });
            } catch (error) {
                t.set(universityStatisticsValueRef, {
                    'university_users_value': 1,

                });

            }


            //feed like list operation end

        });



        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);

    }



    /*
    
        await db.collection('users_meta').doc(newUserUid).set({
            'uUid': newUserUid,
            'uBlocked': ["nothing"],
            'uFriends': ["nothing"],
            'uClubs': [universityEnum.properties[newUserUniversity].activityNo],
            'uValid': true,
            'uGroupList': ["nothing"],
            'uEmail': newUserMail,
            'uToken': 0,
            'uSearching': false,
            'uFriendOrders': ["nothing"],
    
        });
    
        await db.collection('users_display').doc(newUserUid).set({
            'uPic': "https://firebasestorage.googleapis.com/v0/b/isola-b2dd8.appspot.com/o/default_files%2Fdefault_profile_photo.png?alt=media&token=fd38c835-ce62-4e3b-8dec-3914f2c94586",
            'uBio': "My Biography",
            'uInterest': ["interest1", "interest2", "interest3", "interest4", "interest5"],
            'uNonBinary': true,
            'uOnline': true,
            'uName': newUserName,
            'uSex': true,
            'uUniversity': universityEnum.properties[newUserUniversity].universityName,
            'uAct': ["nothing"],
            'uLike': ["nothing"],
            'uDbToken': "token1",
        })*/
});
exports.groupLeave = functions.firestore.document('groups_leave_pool/{groupNo}').onCreate(async (snap, context) => {

    const leaverGroupData = snap.data();

    const leaverGroupNo = leaverGroupData.groupNo;
    const leaverUserUid = leaverGroupData.leaverUser;
    console.log('groupno alındı');
    //  const groupsDeleteMember1 = db.collection('groups').doc(leaverGroupNo).get();

    ///group dağıldı diye kişilere bildirim gönder ve bildirimi handle yap diğer cihazlarda 
    // eğer kişi o mesaj bölümünde ise homepage e gidecek


    //kaldığım yukarıda uid ini aldım ve ona atmıcaz tokenlarını alalmı




    const groupsData = await db.collection('groups').doc(leaverGroupNo).get();
    console.log('groupdata alındı');
    var groupsMemberList = groupsData.data().gList;
    console.log('groupmemberlist oluşturuldu');
    // console.log(groupsData.gList[0]);
    //console.log(groupsData.gList[1]);
    //console.log(groupsData.gList[2]);

    const firstMemberRef = db.collection('users_meta').doc(groupsMemberList[0]);
    console.log('firstmember ref alındı');
    const secondMemberRef = db.collection('users_meta').doc(groupsMemberList[1]);
    console.log('secondmember ref alındı');
    const thirdMemberRef = db.collection('users_meta').doc(groupsMemberList[2]);
    console.log('thirdmember ref alındı');


    const firstMemberDisplayRef = db.collection('users_display').doc(groupsMemberList[0]);
    console.log('firstmemberDisplay ref alındı');
    const secondMemberDisplayRef = db.collection('users_display').doc(groupsMemberList[1]);
    console.log('secondmemberDisplay ref alındı');
    const thirdMemberDisplayRef = db.collection('users_display').doc(groupsMemberList[2]);
    console.log('thirdmemberDisplay ref alındı');


    const firstMemberGroupList = await firstMemberRef.get();
    console.log('firstmembergrouplist get');
    const secondMemberGroupList = await secondMemberRef.get();
    console.log('secondmembergrouplist get');
    const thirdMemberGroupList = await thirdMemberRef.get();
    console.log('thirdmembergrouplsit get');



    const firstMemberDisplayGet = await firstMemberDisplayRef.get();
    console.log('firstmemberDisplay get');
    const secondMemberDisplayGet = await secondMemberDisplayRef.get();
    console.log('secondmemberDisplay get');
    const thirdMemberDisplayGet = await thirdMemberDisplayRef.get();
    console.log('thirdmemberDisplay get');




    var firstUserMetaData = firstMemberGroupList.data();
    console.log('fisrtmetadata alındı');
    var secondUserMetaData = secondMemberGroupList.data();
    console.log('secondmeta data alındı');
    var thirdUserMetaData = thirdMemberGroupList.data();
    console.log('third data alındı');


    var firstUserDbToken = firstMemberDisplayGet.data().uDbToken;
    console.log('fisrttoken');
    var secondUserDbToken = secondMemberDisplayGet.data().uDbToken;
    console.log('secontoken data ');
    var thirdUserDbToken = thirdMemberDisplayGet.data().uDbToken;
    console.log('third token');

    var firstUserGroupList = firstUserMetaData.uGroupList;
    const firstUserGroupIndex = await firstUserGroupList.indexOf(leaverGroupNo);
    const firstUserGroupCleanList = await firstUserGroupList.splice(firstUserGroupIndex, 1);
    console.log('slice ilk');




    var secondUserGroupList = secondUserMetaData.uGroupList;
    const secondUserGroupIndex = await secondUserGroupList.indexOf(leaverGroupNo);
    const secondUserGroupCleanList = await secondUserGroupList.splice(secondUserGroupIndex, 1);
    console.log('slice iki');


    var thirdUserGroupList = thirdUserMetaData.uGroupList;
    const thirdUserGroupIndex = await thirdUserGroupList.indexOf(leaverGroupNo);
    const thirdUserGroupCleanList = await thirdUserGroupList.splice(thirdUserGroupIndex, 1);
    console.log('slice üc');






    const batch = db.batch();
    console.log('batch tanımlama');

    firstUserGroupList.length == 0 ? batch.update(firstMemberRef, { uGroupList: ["nothing"] }) : batch.update(firstMemberRef, { uGroupList: firstUserGroupList });
    secondUserGroupList.length == 0 ? batch.update(secondMemberRef, { uGroupList: ["nothing"] }) : batch.update(secondMemberRef, { uGroupList: secondUserGroupList });
    thirdUserGroupList.length == 0 ? batch.update(thirdMemberRef, { uGroupList: ["nothing"] }) : batch.update(thirdMemberRef, { uGroupList: thirdUserGroupList });


    await batch.commit();
    console.log('batch commit tamam');


    await admin.messaging().sendMulticast({
        tokens: [firstUserDbToken, secondUserDbToken, thirdUserDbToken],
        type: 'chat',
        notification: {
            title: "Your group disassembled",
            body: 'The group member left the group ',

        }
    }).then((response) => {

        // Response is a message ID string.
        console.log('Successfully sent message:', response);
        return { success: true };
    }).catch((error) => {
        return { error: error.code };
    });

});
exports.addFriend = functions.firestore.document('add_friend_orders/{orderDocNo}').onCreate(async (snap, context) => {

    const friendOrderData = snap.data();

    const friendOrderNo = friendOrderData.orderNo;
    const orderTargetUid = friendOrderData.targetUser;
    const orderInviterUid = friendOrderData.inviterUser;


    const checkInviterData = await db.collection('users_meta').doc(orderInviterUid).get();
    const checkInviterDisplayData = await db.collection('users_display').doc(orderInviterUid).get();

    var inviterFriendOrdersList = checkInviterData.data().uFriendOrders;
    var inviterFriendsList = checkInviterData.data().uFriends;
    var inviterBlockedList = checkInviterData.data().uBlocked;

    const inviterToken = checkInviterDisplayData.data().uDbToken;

    const inviterUserRef = db.collection('users_meta').doc(orderInviterUid);
    const targetUserRef = db.collection('users_meta').doc(orderTargetUid);

    const targetUserDisplayRef = db.collection('users_display').doc(orderTargetUid);
    const orderRef = db.collection('add_friend_orders').doc(friendOrderNo);

    if (inviterFriendOrdersList.includes(orderTargetUid) || inviterFriendsList.includes(orderTargetUid) || inviterBlockedList.includes(orderTargetUid)) {

        //target already added these lists
        //delete doc
        await orderRef.delete();
    }
    else {
        //target available for operation

        // I am checking targetuser had a order or no
        const checkCrossOrder = await targetUserRef.get();

        var targetFriendOrdersList = checkCrossOrder.data().uFriendOrders;
        var targetFriendsList = checkCrossOrder.data().uFriends;
        var targetBlockedList = checkCrossOrder.data().uBlocked;

        if (targetFriendsList.includes(orderInviterUid)) {

            //inviter already friend with target
            //delete doc
            await orderRef.delete();
        }
        else if (targetBlockedList.includes(orderInviterUid)) {

            //inviter blocked by target
            //delete document

            await orderRef.delete();


            await admin.messaging().send({
                token: inviterToken,
                type: 'chat',

                notification: {


                    title: "Add Friend Fail",
                    body: 'The person you want to add as a friend has blocked you! ',

                }
            }).then((response) => {

                // Response is a message ID string.
                console.log('Successfully sent message:', response);
                return { success: true };
            }).catch((error) => {
                return { error: error.code };
            });

        }
        else if (targetFriendOrdersList.includes(orderInviterUid)) {



            //target added to inviter before that order
            //friend adding operation 
            //inviter friend list change
            //target friend list change
            //target orderlist delete inviter uid
            //delete document


            try {

                await db.runTransaction(async (t) => {

                    const targetUserMeta = await t.get(targetUserRef);

                    //console.log("burada1");

                    var targetFriendsList = await targetUserMeta.data().uFriends;


                    if (targetFriendsList[0] == "nothing") {
                        targetFriendsList = [];
                    }

                    await targetFriendsList.push(orderInviterUid);

                    //    console.log("burada2");
                    t.update(targetUserRef, {
                        'uFriends': targetFriendsList
                    });

                });
                console.log('Transaction success!');

            } catch (error) {
                console.log('Transaction failure:', error);

            }

            try {

                await db.runTransaction(async (t) => {

                    const inviterUserMeta = await t.get(inviterUserRef);

                    //console.log("burada1");

                    var inviterFriendsList = await inviterUserMeta.data().uFriends;


                    if (inviterFriendsList[0] == "nothing") {

                        inviterFriendsList = [];
                    }
                    await inviterFriendsList.push(orderTargetUid);
                    //    console.log("burada2");
                    t.update(inviterUserRef, {
                        'uFriends': inviterFriendsList
                    });

                });
                console.log('Transaction success!');

            } catch (error) {
                console.log('Transaction failure:', error);

            }




            try {

                await db.runTransaction(async (t) => {

                    const targetUserMeta = await t.get(targetUserRef);

                    //console.log("burada1");

                    var targetFriendOrdersList = await targetUserMeta.data().uFriendOrders;


                    const orderIndex = await targetFriendOrdersList.indexOf(orderInviterUid);
                    await targetFriendOrdersList.splice(orderIndex, 1);
                    //    console.log("burada2");
                    t.update(targetUserRef, {
                        'uFriendOrders': targetFriendOrdersList.length == 0 ? ["nothing"] : targetFriendOrdersList
                    });

                });
                console.log('Transaction success!');

            } catch (error) {
                console.log('Transaction failure:', error);

            }

            /*
            
                        if (inviterFriendsList[0] == "nothing") {
            
                            inviterFriendsList = [];
                        }
            
                        if (targetFriendsList[0] == "nothing") {
                            targetFriendsList = [];
                        }
            
                        const orderIndex = await targetFriendOrdersList.indexOf(orderInviterUid);
                        await targetFriendOrdersList.splice(orderIndex, 1);
                        await inviterFriendsList.push(orderTargetUid);
                        await targetFriendsList.push(orderInviterUid);
            
                        const batch = db.batch();
                        console.log('batch tanımlama');
            
                        targetFriendOrdersList.length == 0 ? batch.update(targetUserRef, { uFriendOrders: ["nothing"] }) : batch.update(targetUserRef, { uFriendOrders: targetFriendOrdersList });
                        batch.update(inviterUserRef, { uFriends: inviterFriendsList });
                        batch.update(targetUserRef, { uFriends: targetFriendsList });
            
                        await batch.commit();
                        console.log('batch commit tamam');*/

            await orderRef.delete();



            const targetDisplay = await targetUserDisplayRef.get();

            const targetToken = targetDisplay.data().uDbToken;


            //
            await admin.messaging().sendMulticast({
                tokens: [targetToken, inviterToken],
                type: 'new_friend',
                notification: {
                    title: "New Friend",
                    body: 'You have new friend now ! ',

                }
            }).then((response) => {

                // Response is a message ID string.
                console.log('Successfully sent message:', response);
                return { success: true };
            }).catch((error) => {
                return { error: error.code };
            });


        }
        else {
            //add this uid to inviter order list
            //and delete this orderno


            try {

                await db.runTransaction(async (t) => {

                    const inviterUserMeta = await t.get(inviterUserRef);

                    //console.log("burada1");

                    var inviterFriendOrdersList = await inviterUserMeta.data().uFriendOrders;


                    if (inviterFriendOrdersList[0] == "nothing") {

                        inviterFriendOrdersList = [];
                    }


                    await inviterFriendOrdersList.push(orderTargetUid);
                    //    console.log("burada2");
                    t.update(inviterUserRef, {
                        uFriendOrders: inviterFriendOrdersList
                    });

                });
                await orderRef.delete();
                console.log('Transaction success!');

            } catch (error) {
                console.log('Transaction failure:', error);

            }








            /* if (inviterFriendOrdersList[0] == "nothing") {
                 inviterFriendOrdersList[0] = orderTargetUid;
 
                 await inviterUserRef.update({
                     uFriendOrders: inviterFriendOrdersList
                 });
                 await orderRef.delete();
             }
             else {
                 await inviterFriendOrdersList.push(orderTargetUid);
 
                 await inviterUserRef.update({
                     uFriendOrders: inviterFriendOrdersList
                 });
                 await orderRef.delete();
 
             }*/
        }
    }
});
exports.reportPoolChecker = functions.firestore.document('reports_pool/{reportDocNo}').onCreate(async (snap, context) => {

    const reportData = snap.data();

    const dataReasonType = reportData.reasonType;
    const dataReportDate = reportData.reportDate;
    const dataReportGroup = reportData.reportGroup;
    const dataReporterUid = reportData.reporterUid;
    const dataTargetUid = reportData.targetUid;

    const reportSaveToAllReportsRef = db.collection('all_reports').doc(dataTargetUid).collection(dataReasonType).doc(dataReporterUid);




    await reportSaveToAllReportsRef.set({
        'reportDate': dataReportDate,
        'reportReasonType': dataReasonType,
        'reporterUid': dataReporterUid,
        'targetUid': dataTargetUid,
        'reportGroupNo': dataReportGroup
    });



    //blocklama ekle 
    const reporterMetaRef = db.collection('users_meta').doc(dataReporterUid);
    const targetMetaRef = db.collection('users_meta').doc(dataTargetUid);



    try {

        await db.runTransaction(async (t) => {

            const reporterData = await t.get(reporterMetaRef);

            //console.log("burada1");

            const newReporterData = reporterData.data();
            //    console.log("burada2");
            var reporterFriendList = newReporterData.uFriends;
            var reporterBlockedList = newReporterData.uBlocked;
            var reporterFriendOrdersList = newReporterData.uFriendOrders;


            if (reporterFriendOrdersList.includes(dataTargetUid)) {

                if (reporterFriendOrdersList.length == 1) {
                    reporterFriendOrdersList = ["nothing"];


                }
                else {
                    const targetIndexOfFriendOrdersList = await reporterFriendOrdersList.indexOf(dataTargetUid);
                    await reporterFriendOrdersList.splice(targetIndexOfFriendOrdersList, 1);

                }


            }



            if (reporterFriendList.length == 1) {



                if (reporterBlockedList[0] == "nothing") {
                    reporterBlockedList = [];
                }
                if (reporterBlockedList.includes(dataTargetUid) == false) {
                    await reporterBlockedList.push(dataTargetUid);

                }


                if (reporterFriendList.includes(dataTargetUid)) {

                    t.update(reporterMetaRef, {
                        'uFriends': ["nothing"],
                        'uBlocked': reporterBlockedList,
                        'uFriendOrders': reporterFriendOrdersList
                    });

                }
                else {
                    t.update(reporterMetaRef, {

                        'uBlocked': reporterBlockedList,
                        'uFriendOrders': reporterFriendOrdersList
                    });


                }



            }
            else {



                if (reporterBlockedList[0] == "nothing") {
                    reporterBlockedList = [];

                };

                if (reporterBlockedList.includes(dataTargetUid) == false) {
                    await reporterBlockedList.push(dataTargetUid);

                }



                if (reporterFriendList.includes(dataTargetUid)) {
                    const targetIndexOfFriendList = await reporterFriendList.indexOf(dataTargetUid);
                    await reporterFriendList.splice(targetIndexOfFriendList, 1);

                    t.update(reporterMetaRef, {
                        'uFriends': reporterFriendList,
                        'uBlocked': reporterBlockedList,
                        'uFriendOrders': reporterFriendOrdersList
                    });

                }
            }



        });
        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);

    }



    try {

        await db.runTransaction(async (t) => {

            const targetData = await t.get(targetMetaRef);

            //console.log("burada1");

            const newTargetData = targetData.data();
            //    console.log("burada2");
            var targetFriendList = newTargetData.uFriends;


            if (targetFriendList.length == 1) {



                if (targetFriendList.includes(dataReporterUid)) {


                    t.update(targetMetaRef, {
                        'uFriends': ["nothing"]
                    });

                }


            }
            else {

                if (targetFriendList.includes(dataReporterUid)) {
                    const reporterIndexOfFriendList = await targetFriendList.indexOf(dataReporterUid);
                    await targetFriendList.splice(reporterIndexOfFriendList, 1);

                    t.update(targetMetaRef, {
                        'uFriends': targetFriendList
                    });

                }
            }


        });
        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);

    }

});
exports.reportsType101Checker = functions.firestore.document('all_reports/{targetId}/rt101/{reporterId}').onCreate(async (snap, context) => {

    const reportData = snap.data();
    const reportTargetUid = reportData.targetUid;
    console.log(reportTargetUid);


    //  const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid).collection('report_datas').doc('report_types_data');
    const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid);

    try {

        await db.runTransaction(async (t) => {

            const userReportStatistics = await t.get(userStatisticsReportDataTypesRef);

            //console.log("burada1");

            const newRt101 = await userReportStatistics.data().rt101 + 1;
            //    console.log("burada2");
            t.update(userStatisticsReportDataTypesRef, {
                'rt101': newRt101
            });

        });
        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);

    }
});
exports.reportsType102Checker = functions.firestore.document('all_reports/{targetId}/rt102/{reporterId}').onCreate(async (snap, context) => {

    const reportData = snap.data();
    const reportTargetUid = reportData.targetUid;
    console.log(reportTargetUid);


    //  const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid).collection('report_datas').doc('report_types_data');
    const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid);

    try {

        await db.runTransaction(async (t) => {

            const userReportStatistics = await t.get(userStatisticsReportDataTypesRef);

            //console.log("burada1");

            const newRt102 = await userReportStatistics.data().rt102 + 1;
            //    console.log("burada2");
            t.update(userStatisticsReportDataTypesRef, {
                'rt102': newRt102
            });

        });
        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);

    }
});
exports.reportsType103Checker = functions.firestore.document('all_reports/{targetId}/rt103/{reporterId}').onCreate(async (snap, context) => {

    const reportData = snap.data();
    const reportTargetUid = reportData.targetUid;
    console.log(reportTargetUid);


    //  const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid).collection('report_datas').doc('report_types_data');
    const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid);

    try {

        await db.runTransaction(async (t) => {

            const userReportStatistics = await t.get(userStatisticsReportDataTypesRef);

            //console.log("burada1");

            const newRt103 = await userReportStatistics.data().rt103 + 1;
            //    console.log("burada2");
            t.update(userStatisticsReportDataTypesRef, {
                'rt103': newRt103
            });

        });
        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);

    }
});
exports.reportsType104Checker = functions.firestore.document('all_reports/{targetId}/rt104/{reporterId}').onCreate(async (snap, context) => {

    const reportData = snap.data();
    const reportTargetUid = reportData.targetUid;
    console.log(reportTargetUid);


    //  const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid).collection('report_datas').doc('report_types_data');
    const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid);

    try {

        await db.runTransaction(async (t) => {

            const userReportStatistics = await t.get(userStatisticsReportDataTypesRef);

            //console.log("burada1");

            const newRt104 = await userReportStatistics.data().rt104 + 1;
            //    console.log("burada2");
            t.update(userStatisticsReportDataTypesRef, {
                'rt104': newRt104
            });

        });
        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);

    }
});
exports.reportsType105Checker = functions.firestore.document('all_reports/{targetId}/rt105/{reporterId}').onCreate(async (snap, context) => {

    const reportData = snap.data();
    const reportTargetUid = reportData.targetUid;
    console.log(reportTargetUid);


    //  const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid).collection('report_datas').doc('report_types_data');
    const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid);

    try {

        await db.runTransaction(async (t) => {

            const userReportStatistics = await t.get(userStatisticsReportDataTypesRef);

            //console.log("burada1");

            const newRt105 = await userReportStatistics.data().rt105 + 1;
            //    console.log("burada2");
            t.update(userStatisticsReportDataTypesRef, {
                'rt105': newRt105
            });

        });
        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);

    }
});
exports.feedsPoolChecker = functions.firestore.document('text_feeds_pool/{feederId}').onCreate(async (snap, context) => {

    const feedData = snap.data();

    const feedDate = feedData.feed_date;
    const feedText = feedData.feed_text;
    const feedUserUid = feedData.user_uid;
    const feedUserAvatarUrl = feedData.user_avatar_url;
    const feedUserName = feedData.user_name;
    const feedOrderNo = context.params.feederId;

    const feedSaveToTextFeedsRef = db.collection('feeds').doc(feedUserUid).collection('text_feeds').doc();

    await feedSaveToTextFeedsRef.set({
        'feed_date': feedDate,
        'feed_no': feedSaveToTextFeedsRef.id,
        'feed_text': feedText,
        'like_list': ["nothing"],
        'like_value': 0,
        'user_uid': feedUserUid,
        'user_name': feedUserName,
        'user_avatar_url': feedUserAvatarUrl

    });

    const feedOrderCleanRef = db.collection('text_feeds_pool').doc(feedOrderNo);

    await feedOrderCleanRef.delete();

});
exports.likePoolChecker = functions.firestore.document('like_pool/{likeId}').onCreate(async (snap, context) => {

    const likeData = snap.data();


    const likeUserUid = likeData.user_uid; //liker 
    const targetUid = likeData.target_uid; //target feed owner

    const targetFeedNo = likeData.target_feed_no;
    const orderIsLikeOrUnlike = likeData.like_or_unlike;
    const likeOrderNo = context.params.likeId;
    const feedIsImage = likeData.feed_is_image;


    const textOrImage = feedIsImage == true ? 'image_feeds' : 'text_feeds';



    const targetNotiChaos = db.collection('users_notification_settings').doc(targetUid);
    const targetFeedRef = db.collection('feeds').doc(targetUid).collection(textOrImage).doc(targetFeedNo);
    const likeHistoryRef = db.collection('users_like_history').doc(likeUserUid);
    const targetFeedGetData = await targetFeedRef.get();

    const targetFeedData = targetFeedGetData.data();

    var feedLikeList = targetFeedData.like_list;
    var feedLikeValue = targetFeedData.like_value;


    if (orderIsLikeOrUnlike == true) {



        try {

            await db.runTransaction(async (t) => {

                const feedLikeGetting = await t.get(targetFeedRef);

                //console.log("burada1");

                const likeData = feedLikeGetting.data();
                //    console.log("burada2");
                var feedLikeList = likeData.like_list;


                // LİKE ==TRUE  feed like list start
                if (feedLikeList.includes(likeUserUid) == false) {

                    if (feedLikeList[0] == "nothing") {

                        feedLikeList[0] = likeUserUid;
                        feedLikeValue = 1;
                    }

                    else {
                        await feedLikeList.push(likeUserUid);
                        feedLikeValue = feedLikeValue + 1;
                    }

                    t.update(targetFeedRef, {
                        'like_list': feedLikeList,
                        'like_value': feedLikeValue,
                    });
                }
                //feed like list operation end

            });
            console.log('Transaction success!');

        } catch (error) {
            console.log('Transaction failure:', error);

        }


        //LİKE == TRUE like history add (transaction)
        try {

            await db.runTransaction(async (t) => {

                const likeHistoryGetting = await t.get(likeHistoryRef);

                //console.log("burada1");

                const likeData = likeHistoryGetting.data();
                //    console.log("burada2");
                var likeArray = likeData.like_datas;


                if (likeArray.includes(targetFeedNo) == false) {

                    if (likeArray.length == 1) {
                        likeArray = [targetFeedNo];
                    }
                    else {
                        await likeArray.push(targetFeedNo);



                    }
                    t.update(likeHistoryRef, {
                        'like_datas': likeArray,
                    });




                }



            });
            console.log('Transaction success!');



        } catch (error) {
            console.log('Transaction failure:', error);

        }
        const targetNotiGet = await targetNotiChaos.get();
        const targetNotiData = targetNotiGet.data();
        const targetNotiLike = targetNotiData.likes;

        if (targetNotiLike) {
            try {
                console.log('baslayalim baslayalim');
                const targetDisplayRef = db.collection('users_display').doc(targetUid);
                const likerDisplayRef = db.collection('users_display').doc(likeUserUid);


                const targetDisplayGet = await targetDisplayRef.get();
                const likerDisplayGet = await likerDisplayRef.get();




                const targetDisplayData = targetDisplayGet.data();
                const likerDisplayData = likerDisplayGet.data();


                const targetDbToken = targetDisplayData.uDbToken;
                const likerName = likerDisplayData.uName;





                console.log(targetDbToken);
                console.log(likerName);
                var msgBody = likerName + ' is liked your post';
                console.log(msgBody);


                const payloadLike = {
                    notification: {

                        title: "New Like !",
                        body: msgBody,

                    }
                };

                await admin.messaging().sendToDevice(targetDbToken, payloadLike).then((response) => {

                    // Response is a message ID string.
                    console.log('Successfully sent message:', response);
                    return { success: true };
                }).catch((error) => {
                    return { error: error.code };
                });

            } catch (error) {
                console.log('message alert ', error);
            }

        }


        console.log('bitti aga');
        // like history add (transaction) end

    }
    else {


        //LİKE ==FALSE feed like list remove start
        try {

            await db.runTransaction(async (t) => {

                const feedLikeGetting = await t.get(targetFeedRef);

                //console.log("burada1");

                const likeData = feedLikeGetting.data();
                //    console.log("burada2");
                var feedLikeList = likeData.like_list;


                // LİKE ==TRUE  feed like list start
                if (feedLikeList.includes(likeUserUid)) {

                    if (feedLikeList.length == 1) {




                        t.update(targetFeedRef, {
                            'like_list': ["nothing"],
                            'like_value': 0,
                        });
                    }

                    else {

                        const likeIndex = await feedLikeList.indexOf(likeUserUid);
                        await feedLikeList.splice(likeIndex, 1);

                        feedLikeValue = feedLikeValue - 1;



                        t.update(targetFeedRef, {
                            'like_list': feedLikeList,
                            'like_value': feedLikeValue,
                        });
                    }


                }
                //feed like list operation end

            });
            console.log('Transaction success!');

        } catch (error) {
            console.log('Transaction failure:', error);

        }

        //feed like list end

        //LİKE == TRUE like history remove (transaction)
        try {

            await db.runTransaction(async (t) => {

                const likeHistoryGetting = await t.get(likeHistoryRef);

                //console.log("burada1");

                const likeData = likeHistoryGetting.data();
                //    console.log("burada2");
                var likeArray = likeData.like_datas;


                if (likeArray.includes(targetFeedNo)) {

                    if (likeArray.length == 1) {
                        likeArray = ["nothing"];
                    }
                    else {
                        const feedIndex = await likeArray.indexOf(likeUserUid);
                        await likeArray.splice(feedIndex, 1);


                    }

                    t.update(likeHistoryRef, {
                        'like_datas': likeArray,
                    });


                }



            });
            console.log('Transaction success!');

        } catch (error) {
            console.log('Transaction failure:', error);

        }
        // like history remove (transaction) end


    }

    /*
        if (orderIsLikeOrUnlike == true) {
    
            // LİKE ==TRUE  feed like list start
            if (feedLikeList.includes(likeUserUid) == false) {
    
                if (feedLikeList[0] == "nothing") {
    
                    feedLikeList[0] = likeUserUid;
                    feedLikeValue = 1;
                }
    
                else {
                    await feedLikeList.push(likeUserUid);
                    feedLikeValue = feedLikeValue + 1;
                }
    
                await targetFeedRef.update({
                    'like_list': feedLikeList,
                    'like_value': feedLikeValue,
                });
            }
            //feed like list operation end
    
            //LİKE == TRUE like history add (transaction)
            try {
    
                await db.runTransaction(async (t) => {
    
                    const likeHistoryGetting = await t.get(likeHistoryRef);
    
                    //console.log("burada1");
    
                    const likeData = likeHistoryGetting.data();
                    //    console.log("burada2");
                    var likeArray = likeData.like_datas;
    
    
                    if (likeArray.includes(targetFeedNo) == false) {
    
                        if (likeArray.length == 1) {
                            likeArray = [targetFeedNo];
                        }
                        else {
                            await likeArray.push(targetFeedNo);
    
    
    
                        }
                        t.update(likeHistoryRef, {
                            'like_datas': likeArray,
                        });
    
    
                    }
    
    
    
                });
                console.log('Transaction success!');
    
            } catch (error) {
                console.log('Transaction failure:', error);
    
            }
            // like history add (transaction) end
    
        }
        else {
    
    
            //LİKE ==FALSE feed like list remove start
            if (feedLikeList.includes(likeUserUid)) {
    
                if (feedLikeList.length == 1) {
    
                    feedLikeList[0] = "nothing";
                    feedLikeValue = 0;
                }
    
                else {
    
                    const likerIndex = await feedLikeList.indexOf(likeUserUid);
                    await feedLikeList.splice(likerIndex, 1);
    
                    feedLikeValue = feedLikeValue - 1;
                }
    
                await targetFeedRef.update({
                    'like_list': feedLikeList,
                    'like_value': feedLikeValue,
                });
            }
            //feed like list end
    
            //LİKE == TRUE like history remove (transaction)
            try {
    
                await db.runTransaction(async (t) => {
    
                    const likeHistoryGetting = await t.get(likeHistoryRef);
    
                    //console.log("burada1");
    
                    const likeData = likeHistoryGetting.data();
                    //    console.log("burada2");
                    var likeArray = likeData.like_datas;
    
    
                    if (likeArray.includes(targetFeedNo)) {
    
                        if (likeArray.length == 1) {
                            likeArray = ["nothing"];
                        }
                        else {
                            const feedIndex = await likeArray.indexOf(likeUserUid);
                            await likeArray.splice(feedIndex, 1);
    
    
                        }
    
                        t.update(likeHistoryRef, {
                            'like_datas': likeArray,
                        });
    
    
                    }
    
    
    
                });
                console.log('Transaction success!');
    
            } catch (error) {
                console.log('Transaction failure:', error);
    
            }
            // like history remove (transaction) end
    
    
        }
    */

    const likeOrderCleanRef = db.collection('like_pool').doc(likeOrderNo);

    await likeOrderCleanRef.delete();


    //meta datalar oluşturulurken like history de oluşturulsun
    //mevcut userlerin like historsini manuel olarak ekle

    //like historye eklemeyi unutma !!!!!!!!!!

});
exports.imageFeedsPoolChecker = functions.firestore.document('image_feeds_pool/{imageFeedId}').onCreate(async (snap, context) => {


    const feedData = snap.data();

    const feedDate = feedData.feed_date;
    const feedImage = feedData.feed_image;
    const feedUserAvatarUrl = feedData.user_avatar_url;
    const feedUserName = feedData.user_name;
    const feedUserUid = feedData.user_uid;
    const feedOrderNo = context.params.imageFeedId;
    const feedUserUniversity = feedData.user_university;
    const feedIsActivity = feedData.feed_is_activity;

    const feedUserLocationRef = await db.collection('users_location').doc(feedUserUid).get();

    const locData = feedUserLocationRef.data();
    const geoLoc = locData.uLoc;



    const feedSaveToImageFeedsRef = db.collection('feeds').doc(feedUserUid).collection('image_feeds').doc();

    await feedSaveToImageFeedsRef.set({
        'feed_date': feedDate,
        'feed_no': feedSaveToImageFeedsRef.id,
        'feed_image': feedImage,
        'like_list': ["nothing"],
        'like_value': 0,
        'user_uid': feedUserUid,
        'user_name': feedUserName,
        'user_avatar_url': feedUserAvatarUrl,
        'user_loc': geoLoc,
        'feed_visibility': true,
        'feed_report_value': 0,
        'user_university': feedUserUniversity,
        'feed_token': 0,
        'feed_is_activity': feedIsActivity,
        'feed_token_list': ["nothing"],

    });

    const feedOrderCleanRef = db.collection('image_feeds_pool').doc(feedOrderNo);

    await feedOrderCleanRef.delete();




});
exports.textFeedDeletePoolChecker = functions.firestore.document('text_feed_delete_pool/{textFeedDeleteId}').onCreate(async (snap, context) => {

    const orderData = snap.data();

    const orderNo = orderData.orderNo;
    const targetFeed = orderData.targetFeed;
    const userUid = orderData.userUid;

    const targetFeedRef = db.collection('feeds').doc(userUid).collection('text_feeds').doc(targetFeed);
    const orderRef = db.collection('text_feed_delete_pool').doc(orderNo);

    try {

        await db.runTransaction(async (t) => {

            const feedGetting = await t.get(targetFeedRef);

            //console.log("burada1");

            const feedData = feedGetting.data();
            //    console.log("burada2");
            var feedOwner = feedData.user_uid;

            if (feedOwner == userUid) {
                t.delete(targetFeedRef);

            }

            orderRef.delete();

        });


        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);

    }


});
exports.imageFeedDeletePoolChecker = functions.firestore.document('image_feed_delete_pool/{imageFeedDeleteId}').onCreate(async (snap, context) => {

    const orderData = snap.data();

    const orderNo = orderData.orderNo;
    const targetFeed = orderData.targetFeed;
    const userUid = orderData.userUid;

    const targetFeedRef = db.collection('feeds').doc(userUid).collection('image_feeds').doc(targetFeed);
    const orderRef = db.collection('image_feed_delete_pool').doc(orderNo);

    try {

        await db.runTransaction(async (t) => {

            const feedGetting = await t.get(targetFeedRef);

            //console.log("burada1");

            const feedData = feedGetting.data();
            //    console.log("burada2");
            var feedOwner = feedData.user_uid;

            if (feedOwner == userUid) {
                t.delete(targetFeedRef);

            }

            orderRef.delete();

        });


        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);

    }


});
exports.feedReportPoolChecker = functions.firestore.document('feed_reports_pool/{reportDocNo}').onCreate(async (snap, context) => {
    const reportData = snap.data();

    const dataReasonType = reportData.reasonType;
    const dataReportDate = reportData.reportDate;
    const dataFeedNo = reportData.reportFeedNo;
    const dataReporterUid = reportData.reporterUid;
    const dataTargetUid = reportData.targetUid;
    const dataIsImage = reportData.reportIsImage;



    const reportSaveToAllFeedReportsRef = db.collection('feed_all_reports').doc(dataTargetUid).collection(dataReasonType).doc(dataReporterUid);


    await reportSaveToAllFeedReportsRef.set({
        'reportDate': dataReportDate,
        'reportReasonType': dataReasonType,
        'reporterUid': dataReporterUid,
        'targetUid': dataTargetUid,
        'reportFeedNo': dataFeedNo,
        'reportIsImage': dataIsImage
    });




});
exports.reportsFeedType101Checker = functions.firestore.document('feed_all_reports/{targetId}/rt101/{reporterId}').onCreate(async (snap, context) => {

    const reportData = snap.data();
    const reportTargetUid = reportData.targetUid;
    console.log(reportTargetUid);


    //  const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid).collection('report_datas').doc('report_types_data');
    const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid);

    try {

        await db.runTransaction(async (t) => {

            const userReportStatistics = await t.get(userStatisticsReportDataTypesRef);

            //console.log("burada1");

            const newRt101 = await userReportStatistics.data().rt101 + 1;
            //    console.log("burada2");
            t.update(userStatisticsReportDataTypesRef, {
                'rt101': newRt101
            });

        });
        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);

    }
});
exports.reportsFeedType102Checker = functions.firestore.document('feed_all_reports/{targetId}/rt102/{reporterId}').onCreate(async (snap, context) => {

    const reportData = snap.data();
    const reportTargetUid = reportData.targetUid;
    console.log(reportTargetUid);


    //  const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid).collection('report_datas').doc('report_types_data');
    const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid);

    try {

        await db.runTransaction(async (t) => {

            const userReportStatistics = await t.get(userStatisticsReportDataTypesRef);

            //console.log("burada1");

            const newRt102 = await userReportStatistics.data().rt102 + 1;
            //    console.log("burada2");
            t.update(userStatisticsReportDataTypesRef, {
                'rt102': newRt102
            });

        });
        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);

    }
});
exports.reportsFeedType103Checker = functions.firestore.document('feed_all_reports/{targetId}/rt103/{reporterId}').onCreate(async (snap, context) => {

    const reportData = snap.data();
    const reportTargetUid = reportData.targetUid;
    console.log(reportTargetUid);


    //  const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid).collection('report_datas').doc('report_types_data');
    const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid);

    try {

        await db.runTransaction(async (t) => {

            const userReportStatistics = await t.get(userStatisticsReportDataTypesRef);

            //console.log("burada1");

            const newRt103 = await userReportStatistics.data().rt103 + 1;
            //    console.log("burada2");
            t.update(userStatisticsReportDataTypesRef, {
                'rt103': newRt103
            });

        });
        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);

    }
});
exports.reportsFeedType104Checker = functions.firestore.document('feed_all_reports/{targetId}/rt104/{reporterId}').onCreate(async (snap, context) => {

    const reportData = snap.data();
    const reportTargetUid = reportData.targetUid;
    console.log(reportTargetUid);


    //  const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid).collection('report_datas').doc('report_types_data');
    const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid);

    try {

        await db.runTransaction(async (t) => {

            const userReportStatistics = await t.get(userStatisticsReportDataTypesRef);

            //console.log("burada1");

            const newRt104 = await userReportStatistics.data().rt104 + 1;
            //    console.log("burada2");
            t.update(userStatisticsReportDataTypesRef, {
                'rt104': newRt104
            });

        });
        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);

    }
});
exports.reportsFeedType105Checker = functions.firestore.document('feed_all_reports/{targetId}/rt105/{reporterId}').onCreate(async (snap, context) => {

    const reportData = snap.data();
    const reportTargetUid = reportData.targetUid;
    console.log(reportTargetUid);


    //  const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid).collection('report_datas').doc('report_types_data');
    const userStatisticsReportDataTypesRef = db.collection('users_statistics').doc(reportTargetUid);

    try {

        await db.runTransaction(async (t) => {

            const userReportStatistics = await t.get(userStatisticsReportDataTypesRef);

            //console.log("burada1");

            const newRt105 = await userReportStatistics.data().rt105 + 1;
            //    console.log("burada2");
            t.update(userStatisticsReportDataTypesRef, {
                'rt105': newRt105
            });

        });
        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);

    }
});
exports.tokenSendingPoolChecker = functions.firestore.document('token_sending_pool/{transferNo}').onCreate(async (snap, context) => {
    const transferData = snap.data();


    const tokenSenderUid = transferData.token_sender_uid;
    const tokenTargetUid = transferData.token_target_uid;
    const tokenTargetFeedNo = transferData.token_target_feed_no;
    const transferDate = transferData.transfer_date;
    const transferNo = transferData.transfer_no;


    const tokenSenderMetaRef = db.collection('users_meta').doc(tokenSenderUid);

    const transferOperationRef = db.collection('token_sending_pool').doc(transferNo);

    const transfersRef = db.collection('token_transfer_operations').doc(transferNo);
    const transferFailsRef = db.collection('token_transfer_fails').doc(transferNo);

    //const senderMeta=await tokenSenderMetaRef.get();


    try {

        await db.runTransaction(async (t) => {

            const senderMetaGetting = await t.get(tokenSenderMetaRef);

            //console.log("burada1");

            const senderData = senderMetaGetting.data();
            //    console.log("burada2");

            const oldTokenValue = senderData.uToken;
            var senderTokenValue = senderData.uToken;


            if (senderTokenValue > 0) {

                senderTokenValue = senderTokenValue - 1;

                //tokeni düsür 
                //karşı tarafın tokenını yükselt
                //karşı tarafın postunda token miktarını yükselt

                t.update(tokenSenderMetaRef, {
                    'uToken': senderTokenValue,

                });


                if (oldTokenValue > 0) {
                    try {
                        await transfersRef.set({
                            'transfer_no': transferNo,
                            'sender_uid': tokenSenderUid,
                            'target_uid': tokenTargetUid,
                            'target_feed': tokenTargetFeedNo,
                            'transfer_date': transferDate,
                            'transfer_value': 1,
                        });

                        await transferOperationRef.delete();


                    } catch (error) {

                        await transferFailsRef.set({

                            'transfer_no': transferNo,
                            'sender_uid': tokenSenderUid,
                            'target_uid': tokenTargetUid,
                            'target_feed': tokenTargetFeedNo,
                            'transfer_date': transferDate,
                            'transfer_value': 1,
                            'fail_reason': error,
                        });

                        console.log('Transaction failure:', error);

                    }
                }



            }

            else {


                await transferOperationRef.delete();

                //delete dosyayı
            }

            // LİKE ==TRUE  feed like list start

            //feed like list operation end

        });





        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);


    }






});
exports.tokenTransferToTargetWallet = functions.firestore.document('token_transfer_operations/{transferNo}').onCreate(async (snap, context) => {
    const transferData = snap.data();
    //const tokenSenderUid = transferData.sender_uid;
    const tokenTargetUid = transferData.target_uid;
    //const tokenTargetFeedNo = transferData.target_feed;
    //const transferDate = transferData.transfer_date;
    //const transferNo = transferData.transfer_no;
    const transferValue = transferData.transfer_value;




    const tokenTargetMetaRef = db.collection('users_meta').doc(tokenTargetUid);



    try {

        await db.runTransaction(async (t) => {


            const targetMetaGetting = await t.get(tokenTargetMetaRef);
            const targetDataToken = targetMetaGetting.data();

            var targetTokenValue = targetDataToken.uToken;
            targetTokenValue = targetTokenValue + transferValue;

            t.update(tokenTargetMetaRef, {
                'uToken': targetTokenValue,

            });

        });
        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);


    }




});
exports.tokenTransferToTargetFeed = functions.firestore.document('token_transfer_operations/{transferNo}').onCreate(async (snap, context) => {

    const transferData = snap.data();
    const tokenSenderUid = transferData.sender_uid;
    const tokenTargetUid = transferData.target_uid;
    const tokenTargetFeedNo = transferData.target_feed;
    //  const transferDate = transferData.transfer_date;
    //  const transferNo = transferData.transfer_no;
    const transferValue = transferData.transfer_value;

    const targetNotiChaos = db.collection('users_notification_settings').doc(tokenTargetUid);

    const tokenTargetFeedRef = db.collection('feeds').doc(tokenTargetUid).collection('image_feeds').doc(tokenTargetFeedNo);




    try {

        await db.runTransaction(async (t) => {

            const targetFeedGetting = await t.get(tokenTargetFeedRef);
            const targetData = targetFeedGetting.data();

            var targetFeedTokenValue = targetData.feed_token;
            var targetFeedTokenList = targetData.feed_token_list;
            targetFeedTokenValue = targetFeedTokenValue + transferValue;


            if (targetFeedTokenList[0] == "nothing") {

                targetFeedTokenList = [];
            }

            await targetFeedTokenList.push(tokenSenderUid);

            t.update(tokenTargetFeedRef, {
                'feed_token': targetFeedTokenValue,
                'feed_token_list': targetFeedTokenList,

            });

        });
        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);


    }

    const targetNotiGet = await targetNotiChaos.get();
    const targetNotiData = targetNotiGet.data();
    const targetNotiTokens = targetNotiData.tokens;
    if (targetNotiTokens) {
        try {
            console.log('baslayalim baslayalim');
            const targetDisplayRef = db.collection('users_display').doc(tokenTargetUid);
            const tokenSenderDisplayRef = db.collection('users_display').doc(tokenSenderUid);

            const targetDisplayGet = await targetDisplayRef.get();
            const tokenSenderDisplayGet = await tokenSenderDisplayRef.get();

            const targetDisplayData = targetDisplayGet.data();
            const tokenSenderDisplayData = tokenSenderDisplayGet.data();

            const targetDbToken = targetDisplayData.uDbToken;
            const tokenSenderName = tokenSenderDisplayData.uName;
            console.log(targetDbToken);
            console.log(tokenSenderName);
            var msgBody = tokenSenderName + ' gave token to your post';
            console.log(msgBody);


            const payloadLike = {
                notification: {

                    title: "New Token !",
                    body: msgBody,

                }
            };

            await admin.messaging().sendToDevice(targetDbToken, payloadLike).then((response) => {

                // Response is a message ID string.
                console.log('Successfully sent message:', response);
                return { success: true };
            }).catch((error) => {
                return { error: error.code };
            });

        } catch (error) {
            console.log('token send message alert ', error);
        }


    }
});
exports.newsAndPopularPoolChecker = functions.firestore.document('news_and_popular_pool/{feedNo}').onCreate(async (snap, context) => {

    const feedData = snap.data();

    const feedAvatarUrl = feedData.pAvatarUrl;
    const feedDate = feedData.pDate;
    const feedLink = feedData.pLink;
    const feedName = feedData.pName;
    const feedText = feedData.pText;
    const feedOrderNo = context.params.feedNo;

    const newsAndPopularRef = db.collection('news_and_popular').doc();


    await newsAndPopularRef.set({
        'pAvatarUrl': feedAvatarUrl,
        'pDate': feedDate,
        'pLink': feedLink,
        'pName': feedName,
        'pText': feedText,

    });

    const feedOrderCleaner = db.collection('news_and_popular_pool').doc(feedOrderNo);

    await feedOrderCleaner.delete();


});
exports.newsAndPopularCycle = functions.pubsub.schedule('every 60 minutes').onRun(async (ctx) => {
    console.log(ctx.timestamp);

    // let simdi=new Date();
    // const yirmiDakikaOnce=simdi.setDate(simdi.getDate()-20);

    //   const yirmiGunOnceStamp=admin.firestore.Timestamp.fromDate(yirmiDakikaOnce);

    const textFeedItems = await db.collectionGroup('text_feeds').orderBy('like_value', 'desc').limit(2).get();
    var sira = 0;
    textFeedItems.forEach(doc => {



        const targetFeed = doc.data();
        if (sira == 0) {
            const addToNewsAndPopularRef = db.collection('news_and_popular').doc('popular1');

            addToNewsAndPopularRef.set({

                'pAvatarUrl': targetFeed.user_avatar_url,
                'pDate': targetFeed.feed_date,
                'pLink': "nothing",
                'pName': targetFeed.user_name,
                'pText': targetFeed.feed_text,
                'pLikeValue': targetFeed.like_value,


            });
            sira = 1;
        }
        else {

            const addToNewsAndPopularRef = db.collection('news_and_popular').doc('popular2');

            addToNewsAndPopularRef.set({

                'pAvatarUrl': targetFeed.user_avatar_url,
                'pDate': targetFeed.feed_date,
                'pLink': "nothing",
                'pName': targetFeed.user_name,
                'pText': targetFeed.feed_text,
                'pLikeValue': targetFeed.like_value,


            });

        }





    });








});
exports.chaosApplyPoolChecker = functions.firestore.document('chaos_apply_pool/{memberUid}').onCreate(async (snap, context) => {
    const poolData = snap.data();

    const dataGroupNo = poolData.groupNo;
    const dataMemberUid = poolData.memberUid;
    const dataOperationTime = poolData.operationTime;

    const targetGroupRef = db.collection('groups').doc(dataGroupNo);
    const thisOrder = db.collection('chaos_apply_pool').doc(dataMemberUid);
    const thisOrder2 = db.collection('chaos_apply_pool_2').doc(dataGroupNo);
    const notificationPosterRef = db.collection('notification_poster_pool').doc();



    var groupData = await targetGroupRef.get();
    var groupMemberList = groupData.data().gList;
    var groupMemberListForNotification = groupData.data().gList;
    var groupSearchInfo = groupData.data().gChaosSearching;







    if (groupMemberList.includes(dataMemberUid) && groupSearchInfo == false) {

        //batch aç


        const whichLine = await groupMemberListForNotification.indexOf(dataMemberUid);
        const whoInviter = groupMemberListForNotification[whichLine];
        await groupMemberListForNotification.splice(whichLine, 1);

        const inviterDisplayDataRef = db.collection('users_display').doc(whoInviter);
        const firstGuestDisplayDataRef = db.collection('users_display').doc(groupMemberListForNotification[0]);
        const secondGuestDisplayDataRef = db.collection('users_display').doc(groupMemberListForNotification[1]);

        const inviterData = await inviterDisplayDataRef.get();
        const firstGuestData = await firstGuestDisplayDataRef.get();
        const secondGuestData = await secondGuestDisplayDataRef.get();

        const inviterDisplay = inviterData.data();
        const firstGuestDisplay = firstGuestData.data();
        const secondGuestDisplay = secondGuestData.data();
        var msgBody = 'You are invited from ' + inviterDisplay.uName;

        const batch = db.batch();

        batch.set(thisOrder2, {
            'groupMemberList': [dataMemberUid],
            'groupNo': dataGroupNo,
            'operationTime': dataOperationTime,
        })

        /*  await thisOrder2.set({
              'groupMemberList': [dataMemberUid],
              'groupNo': dataGroupNo,
              'operationTime': dataOperationTime,
  
          });*/
        batch.update(targetGroupRef, {
            'gChaosSearching': true,
        })

        /* await targetGroupRef.update({
             'gChaosSearching': true,
         });*/

        batch.delete(thisOrder);

        // await thisOrder.delete();
        batch.set(notificationPosterRef, {
            'isMulti': true,
            'notiCategory': 'chaos_starting',
            'notificationTitle': 'Chaos Invite',
            'notificationBody': msgBody,
            'tokenList': [firstGuestDisplay.uDbToken, secondGuestDisplay.uDbToken],
        })

        await batch.commit();






    }
    else {

        if (groupSearchInfo == true) {



            try {


                await db.runTransaction(async (t) => {
                    const pool2Data = await t.get(thisOrder2);
                    var newPool2Data = await pool2Data.data().groupMemberList;
                    await newPool2Data.push(dataMemberUid);

                    //    console.log("burada2");
                    t.update(thisOrder2, {
                        'groupMemberList': newPool2Data,
                        'groupNo': dataGroupNo,
                        'operationTime': dataOperationTime,
                    });




                });
                console.log('Transaction success!');
                await thisOrder.delete();

            } catch (error) {
                console.log('Transaction failure:', error);
                await thisOrder.delete();

            }




        }
        else {

            await thisOrder.delete();
        }






    }








});
exports.chaosApplyPool2Checker = functions.firestore.document('chaos_apply_pool_2/{groupNo}').onUpdate(async (change, context) => {


    const gList = change.after.data().groupMemberList;
    const gNo = change.after.data().groupNo;
    const gTime = change.after.data().operationTime;


    console.log('1');
    const member1Uid = gList[0];

    const member2Uid = gList[1];

    const member3Uid = gList[2];

    const member1Ref = db.collection('users_meta').doc(member1Uid);
    const member2Ref = db.collection('users_meta').doc(member2Uid);
    const member3Ref = db.collection('users_meta').doc(member3Uid);

    console.log('2');

    if (gList.length == 3) {
        console.log('3');
        var member1Status = false;
        var member2Status = false;
        var member3Status = false;
        //user 1 transiction
        try {
            console.log('4');
            await db.runTransaction(async (t) => {
                const member1Data = await t.get(member1Ref);

                var newMember1TokenValue = await member1Data.data().uToken;

                if (newMember1TokenValue > 0) {
                    //    console.log("burada2");
                    t.update(member1Ref, {
                        'uToken': newMember1TokenValue - 1,
                    });
                    member1Status = true;

                }

            });
            console.log('Transaction success!');


        } catch (error) {
            console.log('Transaction failure:', error);


        }

        //user 2 transiction
        try {
            console.log('5');
            await db.runTransaction(async (t) => {
                const member2Data = await t.get(member2Ref);

                var newMember2TokenValue = await member2Data.data().uToken;

                if (newMember2TokenValue > 0) {
                    //    console.log("burada2");
                    t.update(member2Ref, {
                        'uToken': newMember2TokenValue - 1,
                    });
                    member2Status = true;

                }

            });
            console.log('Transaction success!');


        } catch (error) {
            console.log('Transaction failure:', error);


        }

        //user3 transiction

        try {
            console.log('6');
            await db.runTransaction(async (t) => {
                const member3Data = await t.get(member3Ref);

                var newMember3TokenValue = await member3Data.data().uToken;

                if (newMember3TokenValue > 0) {
                    //    console.log("burada2");
                    t.update(member3Ref, {
                        'uToken': newMember3TokenValue - 1,
                    });
                    member3Status = true;

                }

            });
            console.log('Transaction success!');


        } catch (error) {
            console.log('Transaction failure:', error);


        }

        if (member1Status && member2Status && member3Status) {


            const targetGroupChatRef = db.collection('groups_chat').doc(gNo).collection('chat_data').doc();

            console.log('12');
            await targetGroupChatRef.set({

                'member_avatar_url': "https://firebasestorage.googleapis.com/v0/b/isola-b2dd8.appspot.com/o/default_files%2Fgroup_leave_icon.png?alt=media&token=11e9f80d-8604-494e-899c-f8f471469bd3",
                'member_message': "CHAOS MODE WILL START SOON",
                'member_message_attachment_url': "isola_system_message",
                'member_message_isattachment': false,
                'member_message_isdocument': false,
                'member_message_isimage': false,
                'member_message_isvideo': false,
                'member_message_isvoice': false,
                'member_message_target_1_uid': member1Uid,
                'member_message_target_2_uid': member2Uid,
                'member_message_time': gTime,
                'member_message_voice_url': "",
                'member_name': "System Message",
                'member_uid': member3Uid,
                'member_message_no': targetGroupChatRef.id,

            });
            const groupInfo = await db.collection('groups').doc(gNo).get();
            const chaosGroupsRef = db.collection('chaos_groups');
            const groupNonBinary = groupInfo.data().gNonBinary;
            const groupSex = groupInfo.data().gSex;
            const groupValid = groupInfo.data().gValid;

            const snapshot = await chaosGroupsRef.where('group_is_active', '==', false)
                .where('group_2_is_here', '==', false)
                .where('group_is_nonbinary', '==', groupNonBinary)
                .where('group_is_valid', '==', groupValid).get();

            if (snapshot.empty) {
                const chaosGroupsDocRef = db.collection('chaos_groups').doc();
                //create group


                await chaosGroupsDocRef.set({
                    'group_1_is_here': true,
                    'group_2_is_here': false,
                    'group_is_active': false,
                    'group_is_nonbinary': groupNonBinary,
                    'group_is_valid': groupValid,
                    'group_no': chaosGroupsDocRef.id,
                    'group_sex': groupSex,
                    'group_1_no': gNo,
                    'group_2_no': ''
                });
            }
            else {
                var isOkey = false;
                var loopValue = 0;
                const snapDatas = snapshot.docs;

                do {
                    const doc = snapDatas[loopValue];
                    try {
                        db.runTransaction(async (t) => {
                            const targetGroup = await t.get(chaosGroupsRef.doc(doc.data().group_no));
                            const targetGroupData = targetGroup.data();

                            if (targetGroupData.group_is_nonbinary == true) {


                                //group 2 is here true yap
                                //gChaosNo ekle
                                //gChaos = true yap
                                //gChaosSearching=false yap
                                //chaos group update check etcek ve ona göre grup chat aççak

                                t.update(chaosGroupsRef.doc(doc.data().group_no), {
                                    'group_2_is_here': true,
                                    'group_is_active': true,
                                    'group_2_no': gNo,
                                });
                                isOkey = true;

                            } else if (targetGroupData.group_sex == groupSex) {

                                t.update(chaosGroupsRef.doc(doc.data().group_no), {
                                    'group_2_is_here': true,
                                    'group_is_active': true,
                                    'group_2_no': gNo,
                                });
                                isOkey = true;
                            }

                        });



                    } catch (error) {

                    }
                    loopValue = loopValue + 1;

                } while (isOkey == false && loopValue < snapshot.length);









            }







            //işlem tamam tokenlar düşürüldü ekle diğer havuza
            console.log('complate');
        }
        else {
            console.log('7');


            if (member1Status == false || member2Status == false || member3Status == false) {
                //iptalll
                //gChaosSearhing false
                //dosyaları sil

                console.log('8');
                if (member1Status == true) {
                    //tokenları geri ver 

                    try {
                        console.log('9');
                        await db.runTransaction(async (t) => {
                            const member1Data = await t.get(member1Ref);

                            var newMember1TokenValue = await member1Data.data().uToken;

                            if (newMember1TokenValue > 0) {
                                //    console.log("burada2");
                                t.update(member1Ref, {
                                    'uToken': newMember1TokenValue - 1,
                                });
                                member1Status = true;

                            }

                        });
                        console.log('Transaction success!');


                    } catch (error) {
                        console.log('Transaction failure:', error);


                    }

                }
                if (member2Status == true) {
                    try {
                        console.log('10');
                        await db.runTransaction(async (t) => {
                            const member2Data = await t.get(member2Ref);

                            var newMember2TokenValue = await member2Data.data().uToken;

                            if (newMember2TokenValue > 0) {
                                //    console.log("burada2");
                                t.update(member2Ref, {
                                    'uToken': newMember2TokenValue - 1,
                                });
                                member2Status = true;

                            }

                        });
                        console.log('Transaction success!');


                    } catch (error) {
                        console.log('Transaction failure:', error);


                    }

                }
                if (member3Status == true) {
                    console.log('11');
                    try {

                        await db.runTransaction(async (t) => {
                            const member3Data = await t.get(member3Ref);

                            var newMember3TokenValue = await member3Data.data().uToken;

                            if (newMember3TokenValue > 0) {
                                //    console.log("burada2");
                                t.update(member3Ref, {
                                    'uToken': newMember3TokenValue - 1,
                                });
                                member3Status = true;

                            }

                        });
                        console.log('Transaction success!');


                    } catch (error) {
                        console.log('Transaction failure:', error);


                    }


                }

                console.log(gNo);
                const targetGroupChatRef = db.collection('groups_chat').doc(gNo).collection('chat_data').doc();


                const order2Ref = db.collection('chaos_apply_pool_2').doc(gNo);

                const groupRef = db.collection('groups').doc(gNo);

                console.log('12');
                await targetGroupChatRef.set({

                    'member_avatar_url': "https://firebasestorage.googleapis.com/v0/b/isola-b2dd8.appspot.com/o/default_files%2Fgroup_leave_icon.png?alt=media&token=11e9f80d-8604-494e-899c-f8f471469bd3",
                    'member_message': "CHAOS FAİL - NOT ENOUGH TOKEN",
                    'member_message_attachment_url': "isola_system_message",
                    'member_message_isattachment': false,
                    'member_message_isdocument': false,
                    'member_message_isimage': false,
                    'member_message_isvideo': false,
                    'member_message_isvoice': false,
                    'member_message_target_1_uid': member1Uid,
                    'member_message_target_2_uid': member2Uid,
                    'member_message_time': gTime,
                    'member_message_voice_url': "",
                    'member_name': "System Message",
                    'member_uid': member3Uid,
                    'member_message_no': targetGroupChatRef.id,

                });
                console.log('13');
                await groupRef.update({

                    'gChaosSearching': false,
                    'gChaos': false,
                });
                console.log('14');
                await order2Ref.delete();
                console.log('15');




            }


        }


    }



});
exports.chaosGroupActiveChecker = functions.firestore.document('chaos_groups/{groupNo}').onUpdate(async (change, context) => {
    const g1HereBef = change.before.data().group_1_is_here;
    const g2HereBef = change.before.data().group_2_is_here;
    const g1HereAft = change.after.data().group_1_is_here;
    const g2HereAft = change.after.data().group_2_is_here;

    if (g2HereAft == true && g2HereBef == false) {

        const gChaosNo = change.after.data().group_no;

        const g1No = change.after.data().group_1_no;
        const g2No = change.after.data().group_2_no;

        //groups ref
        const group1Ref = db.collection('groups').doc(g1No);
        const group2Ref = db.collection('groups').doc(g2No);

        //groups data
        const group1Data = await group1Ref.get();
        const group2Data = await group2Ref.get();
        //groups member list
        const group1List = group1Data.data().gList;
        const group2List = group2Data.data().gList;

        //group 1 members
        const group1Member1 = group1List[0];
        const group1Member2 = group1List[1];
        const group1Member3 = group1List[2];

        //group 2 members
        const group2Member1 = group2List[0];
        const group2Member2 = group2List[1];
        const group2Member3 = group2List[2];

        //group members display and meta ref
        const group1Member1DisplayRef = db.collection('users_display').doc(group1Member1);
        const group1Member1MetaRef = db.collection('users_meta').doc(group1Member1);

        const group1Member2DisplayRef = db.collection('users_display').doc(group1Member2);
        const group1Member2MetaRef = db.collection('users_meta').doc(group1Member2);

        const group1Member3DisplayRef = db.collection('users_display').doc(group1Member3);
        const group1Member3MetaRef = db.collection('users_meta').doc(group1Member3);


        const group2Member1DisplayRef = db.collection('users_display').doc(group2Member1);
        const group2Member1MetaRef = db.collection('users_meta').doc(group2Member1);

        const group2Member2DisplayRef = db.collection('users_display').doc(group2Member2);
        const group2Member2MetaRef = db.collection('users_meta').doc(group2Member2);

        const group2Member3DisplayRef = db.collection('users_display').doc(group2Member3);
        const group2Member3MetaRef = db.collection('users_meta').doc(group2Member3);


        //group members display and meta data
        const group1Member1DisplayData = await group1Member1DisplayRef.get();
        //const group1Member1MetaData= await group1Member1MetaRef.get();

        const group1Member2DisplayData = await group1Member2DisplayRef.get();
        //const group1Member2MetaData=await group1Member2MetaRef.get();

        const group1Member3DisplayData = await group1Member3DisplayRef.get();
        //const group1Member3MetaData=await group1Member3MetaRef.get();


        const group2Member1DisplayData = await group2Member1DisplayRef.get();
        //const group2Member1MetaData=await group2Member1MetaRef.get();

        const group2Member2DisplayData = await group2Member2DisplayRef.get();
        //const group2Member2MetaData=await group2Member2MetaRef.get();

        const group2Member3DisplayData = await group2Member3DisplayRef.get();
        //const group2Member3MetaData=await group2Member3MetaRef.get();


        const group1Member1Name = group1Member1DisplayData.data().uName;
        const group1Member1AvatarUrl = group1Member1DisplayData.data().uPic;

        const group1Member2Name = group1Member2DisplayData.data().uName;
        const group1Member2AvatarUrl = group1Member2DisplayData.data().uPic;

        const group1Member3Name = group1Member3DisplayData.data().uName;
        const group1Member3AvatarUrl = group1Member3DisplayData.data().uPic;



        const group2Member1Name = group2Member1DisplayData.data().uName;
        const group2Member1AvatarUrl = group2Member1DisplayData.data().uPic;

        const group2Member2Name = group2Member2DisplayData.data().uName;
        const group2Member2AvatarUrl = group2Member2DisplayData.data().uPic;

        const group2Member3Name = group2Member3DisplayData.data().uName;
        const group2Member3AvatarUrl = group2Member3DisplayData.data().uPic;











        const chaosChatDocRef = db.collection('chaos_groups_chat').doc(gChaosNo);





        const systemDate = new Date('December 10, 1815');
        const m1MessageDate = new Date();
        const m2MessageDate = new Date();
        const m3MessageDate = new Date();
        const m4MessageDate = new Date();
        const m5MessageDate = new Date();
        const m6MessageDate = new Date();
        const currentDateForGroup = new Date();
        const finishTime = new Date();
        finishTime.setTime(currentDateForGroup.getTime() + (20 * 60000));
        const finishWithBonusTime = new Date();
        finishWithBonusTime.setTime(currentDateForGroup.getTime() + (40 * 60000));

        await chaosChatDocRef.set({
            'created_time': currentDateForGroup,
            'finish_time': finishTime,
            'finish_with_bonus_time': finishWithBonusTime,
            'time_bonus': false,
            'chaos_is_complete': false

        });



        const chaosChatDataRef = db.collection('chaos_groups_chat').doc(gChaosNo).collection('chat_data').doc();
        const chaosChatDataRef1 = db.collection('chaos_groups_chat').doc(gChaosNo).collection('chat_data').doc();
        const chaosChatDataRef2 = db.collection('chaos_groups_chat').doc(gChaosNo).collection('chat_data').doc();
        const chaosChatDataRef3 = db.collection('chaos_groups_chat').doc(gChaosNo).collection('chat_data').doc();
        const chaosChatDataRef4 = db.collection('chaos_groups_chat').doc(gChaosNo).collection('chat_data').doc();
        const chaosChatDataRef5 = db.collection('chaos_groups_chat').doc(gChaosNo).collection('chat_data').doc();
        const chaosChatDataRef6 = db.collection('chaos_groups_chat').doc(gChaosNo).collection('chat_data').doc();

        const chaosGroup1Ref = db.collection('groups').doc(g1No);
        const chaosGroup2Ref = db.collection('groups').doc(g2No);

        const batch = db.batch();
        //süre detaylarını unutma




        batch.set(chaosChatDataRef, {

            'member_avatar_url': "https://firebasestorage.googleapis.com/v0/b/isola-b2dd8.appspot.com/o/default_files%2Fgroup_leave_icon.png?alt=media&token=11e9f80d-8604-494e-899c-f8f471469bd3",
            'member_message': "Welcome To Chaos Group",
            'member_message_attachment_url': "isola_system_message",
            'member_message_isattachment': false,
            'member_message_isdocument': false,
            'member_message_isimage': false,
            'member_message_isvideo': false,
            'member_message_isvoice': false,
            'member_message_target_1_uid': group1Member2,
            'member_message_target_2_uid': group1Member3,
            'member_message_target_3_uid': group2Member1,
            'member_message_target_4_uid': group2Member2,
            'member_message_target_5_uid': group2Member3,
            'member_message_time': systemDate,
            'member_message_voice_url': "",
            'member_name': "System Message",
            'member_uid': group1Member1,
            'member_message_no': chaosChatDataRef.id,

        });
        batch.set(chaosChatDataRef1, {

            'member_avatar_url': group1Member1AvatarUrl,
            'member_message': "Hello!",
            'member_message_attachment_url': "",
            'member_message_isattachment': false,
            'member_message_isdocument': false,
            'member_message_isimage': false,
            'member_message_isvideo': false,
            'member_message_isvoice': false,
            'member_message_target_1_uid': group1Member2,
            'member_message_target_2_uid': group1Member3,
            'member_message_target_3_uid': group2Member1,
            'member_message_target_4_uid': group2Member2,
            'member_message_target_5_uid': group2Member3,
            'member_message_time': m1MessageDate,
            'member_message_voice_url': "",
            'member_name': group1Member1Name,
            'member_uid': group1Member1,
            'member_message_no': chaosChatDataRef1.id,



        });
        batch.set(chaosChatDataRef2, {
            'member_avatar_url': group1Member2AvatarUrl,
            'member_message': "Hello!",
            'member_message_attachment_url': "",
            'member_message_isattachment': false,
            'member_message_isdocument': false,
            'member_message_isimage': false,
            'member_message_isvideo': false,
            'member_message_isvoice': false,
            'member_message_target_1_uid': group1Member1,
            'member_message_target_2_uid': group1Member3,
            'member_message_target_3_uid': group2Member1,
            'member_message_target_4_uid': group2Member2,
            'member_message_target_5_uid': group2Member3,
            'member_message_time': m2MessageDate,
            'member_message_voice_url': "",
            'member_name': group1Member2Name,
            'member_uid': group1Member2,
            'member_message_no': chaosChatDataRef2.id,


        });
        batch.set(chaosChatDataRef3, {

            'member_avatar_url': group1Member3AvatarUrl,
            'member_message': "Hello!",
            'member_message_attachment_url': "",
            'member_message_isattachment': false,
            'member_message_isdocument': false,
            'member_message_isimage': false,
            'member_message_isvideo': false,
            'member_message_isvoice': false,
            'member_message_target_1_uid': group1Member1,
            'member_message_target_2_uid': group1Member2,
            'member_message_target_3_uid': group2Member1,
            'member_message_target_4_uid': group2Member2,
            'member_message_target_5_uid': group2Member3,
            'member_message_time': m3MessageDate,
            'member_message_voice_url': "",
            'member_name': group1Member3Name,
            'member_uid': group1Member3,
            'member_message_no': chaosChatDataRef3.id,

        });
        batch.set(chaosChatDataRef4, {
            'member_avatar_url': group2Member1AvatarUrl,
            'member_message': "Hello!",
            'member_message_attachment_url': "",
            'member_message_isattachment': false,
            'member_message_isdocument': false,
            'member_message_isimage': false,
            'member_message_isvideo': false,
            'member_message_isvoice': false,
            'member_message_target_1_uid': group1Member1,
            'member_message_target_2_uid': group1Member2,
            'member_message_target_3_uid': group1Member3,
            'member_message_target_4_uid': group2Member2,
            'member_message_target_5_uid': group2Member3,
            'member_message_time': m4MessageDate,
            'member_message_voice_url': "",
            'member_name': group2Member1Name,
            'member_uid': group2Member1,
            'member_message_no': chaosChatDataRef4.id,


        });
        batch.set(chaosChatDataRef5, {
            'member_avatar_url': group2Member2AvatarUrl,
            'member_message': "Hello!",
            'member_message_attachment_url': "",
            'member_message_isattachment': false,
            'member_message_isdocument': false,
            'member_message_isimage': false,
            'member_message_isvideo': false,
            'member_message_isvoice': false,
            'member_message_target_1_uid': group1Member1,
            'member_message_target_2_uid': group1Member2,
            'member_message_target_3_uid': group1Member3,
            'member_message_target_4_uid': group2Member1,
            'member_message_target_5_uid': group2Member3,
            'member_message_time': m5MessageDate,
            'member_message_voice_url': "",
            'member_name': group2Member2Name,
            'member_uid': group2Member2,
            'member_message_no': chaosChatDataRef5.id,


        });
        batch.set(chaosChatDataRef6, {

            'member_avatar_url': group2Member3AvatarUrl,
            'member_message': "Hello!",
            'member_message_attachment_url': "",
            'member_message_isattachment': false,
            'member_message_isdocument': false,
            'member_message_isimage': false,
            'member_message_isvideo': false,
            'member_message_isvoice': false,
            'member_message_target_1_uid': group1Member1,
            'member_message_target_2_uid': group1Member2,
            'member_message_target_3_uid': group1Member3,
            'member_message_target_4_uid': group2Member1,
            'member_message_target_5_uid': group2Member2,
            'member_message_time': m6MessageDate,
            'member_message_voice_url': "",
            'member_name': group2Member3Name,
            'member_uid': group2Member3,
            'member_message_no': chaosChatDataRef6.id,

        });

        batch.update(chaosGroup1Ref, {
            'gChaos': true,
            'gChaosNo': gChaosNo,
            'gChaosSearching': false

        });
        batch.update(chaosGroup2Ref, {
            'gChaos': true,
            'gChaosNo': gChaosNo,
            'gChaosSearching': false
        });


        await batch.commit();





    }



});
exports.chaosExtensionPoolChecker = functions.firestore.document('chaos_extensions_pool/{extensionNo}').onCreate(async (snap, context) => {

    const poolData = snap.data();
    console.log('1');

    const dataChaosGroupNo = poolData.chaos_group_no;
    const dataBenefactorUid = poolData.benefactor_uid;
    const dataExtensionTime = poolData.extension_time;
    const dataExtensionNo = poolData.extension_no;
    const dataBenefactorName = poolData.benefactor_name;
    const dataBenefactorAvatarUrl = poolData.benefactor_avatar_url;

    const dataMember1Uid = poolData.chaos_member_1_uid;
    const dataMember2Uid = poolData.chaos_member_2_uid;
    const dataMember3Uid = poolData.chaos_member_3_uid;
    const dataMember4Uid = poolData.chaos_member_4_uid;
    const dataMember5Uid = poolData.chaos_member_5_uid;


    const targetMember1NotiChaosGet = await db.collection('users_notification_settings').doc(dataMember1Uid).get();
    const targetMember2NotiChaosGet = await db.collection('users_notification_settings').doc(dataMember2Uid).get();
    const targetMember3NotiChaosGet = await db.collection('users_notification_settings').doc(dataMember3Uid).get();
    const targetMember4NotiChaosGet = await db.collection('users_notification_settings').doc(dataMember4Uid).get();
    const targetMember5NotiChaosGet = await db.collection('users_notification_settings').doc(dataMember5Uid).get();

    const targetMember1NotiData = targetMember1NotiChaosGet.data();
    const targetMember2NotiData = targetMember2NotiChaosGet.data();
    const targetMember3NotiData = targetMember3NotiChaosGet.data();
    const targetMember4NotiData = targetMember4NotiChaosGet.data();
    const targetMember5NotiData = targetMember5NotiChaosGet.data();

    const targetMember1NotiChaosystemNotifications = targetMember1NotiData.chaos_messages;
    const targetMember2NotiChaosystemNotifications = targetMember2NotiData.chaos_messages;
    const targetMember3NotiChaosystemNotifications = targetMember3NotiData.chaos_messages;
    const targetMember4NotiChaosystemNotifications = targetMember4NotiData.chaos_messages;
    const targetMember5NotiChaosystemNotifications = targetMember5NotiData.chaos_messages;


    var exTokenList = [];

    if (targetMember1NotiChaosystemNotifications) {
        const targetMember1TokenGet = await db.collection('users_display').doc(dataMember1Uid).get();
        const targetMember1DisplayData = targetMember1TokenGet.data();
        const targetMember1Token = targetMember1DisplayData.uDbToken;


        exTokenList.push(targetMember1Token);

    }

    if (targetMember2NotiChaosystemNotifications) {
        const targetMember2TokenGet = await db.collection('users_display').doc(dataMember2Uid).get();
        const targetMember2DisplayData = targetMember2TokenGet.data();
        const targetMember2Token = targetMember2DisplayData.uDbToken;

        exTokenList.push(targetMember2Token);


    }

    if (targetMember3NotiChaosystemNotifications) {
        const targetMember3TokenGet = await db.collection('users_display').doc(dataMember3Uid).get();
        const targetMember3DisplayData = targetMember3TokenGet.data();
        const targetMember3Token = targetMember3DisplayData.uDbToken;

        exTokenList.push(targetMember3Token);

    }

    if (targetMember4NotiChaosystemNotifications) {
        const targetMember4TokenGet = await db.collection('users_display').doc(dataMember4Uid).get();
        const targetMember4DisplayData = targetMember4TokenGet.data();
        const targetMember4Token = targetMember4DisplayData.uDbToken;


        exTokenList.push(targetMember4Token);

    }

    if (targetMember5NotiChaosystemNotifications) {


        const targetMember5TokenGet = await db.collection('users_display').doc(dataMember5Uid).get();
        const targetMember5DisplayData = targetMember5TokenGet.data();
        const targetMember5Token = targetMember5DisplayData.uDbToken;

        exTokenList.push(targetMember5Token);
    }


    console.log('2');


    const benefactorUserRef = db.collection('users_meta').doc(dataBenefactorUid);
    console.log('3');

    const targetChaosGroupRef = db.collection('chaos_groups_chat').doc(dataChaosGroupNo);
    console.log('4');


    const benefactorMessageRef = db.collection('chaos_groups_chat').doc(dataChaosGroupNo).collection('chat_data').doc();
    console.log('5');

    const notiPosterPoolRef = db.collection('notification_poster_pool').doc();

    const extensionRef = db.collection('chaos_extensions_pool').doc(dataExtensionNo);
    //  const benefactorGetting=await benefactorUserRef.get();
    console.log('6');

    var continueSecond = false;

    var reGiveToken = false;

    try {
        console.log('7');


        await db.runTransaction(async (t) => {
            console.log('8');

            const benefactorGetting = await t.get(benefactorUserRef);
            var benefactorData = await benefactorGetting.data().uToken;
            console.log('9');

            if (benefactorData > 0) {
                console.log('10');

                benefactorData = benefactorData - 1;
                t.update(benefactorUserRef, {
                    'uToken': benefactorData,

                });
                console.log('11');

                continueSecond = true;
            }
            else {
                console.log('12');

                continueSecond = false;
            }

            console.log('13');



        });


        console.log('14');




    } catch (error) {
        console.log('15');

    }
    console.log('16');

    if (continueSecond == true) {
        console.log('17');


        try {
            console.log('18');


            await db.runTransaction(async (t) => {
                console.log('19');

                const targetChaosGetting = await t.get(targetChaosGroupRef);
                var targetChaosData = targetChaosGetting.data();
                var timeBonusData = targetChaosData.time_bonus;
                var chaosIsComplete = targetChaosData.chaos_is_complete;
                console.log('20');

                if (timeBonusData == false && chaosIsComplete == false) {
                    console.log('21');

                    t.update(targetChaosGroupRef, {
                        'time_bonus': true

                    });
                }
                else {
                    console.log('22');


                    reGiveToken = true;

                }
                console.log('23');


            });
            console.log('24');

        } catch (error) {
            console.log('25');

            //adamın tokenını geriver
        }

    }
    console.log('26');


    if (reGiveToken == true) {
        console.log('27');

        //tokenı geriver

        try {
            console.log('28');

            await db.runTransaction(async (t) => {
                console.log('29');

                const benefactorGetting = await t.get(benefactorUserRef);
                var benefactorData = await benefactorGetting.data().uToken;

                console.log('30');

                benefactorData = benefactorData + 1;
                t.update(benefactorUserRef, {
                    'uToken': benefactorData,

                });

                console.log('31');





            });


            console.log('32');




        } catch (error) {
            console.log('33');


        }


        console.log('34');


    }
    console.log('35');


    if (continueSecond == true && reGiveToken == false) {
        console.log('36');

        // süreyi uzattı mesajı yaz

        var messageText = dataBenefactorName + " extented the time";
        console.log('37');

        const batch = db.batch();

        batch.set(benefactorMessageRef, {
            'member_avatar_url': dataBenefactorAvatarUrl,
            'member_message': messageText,
            'member_message_attachment_url': "isola_system_message",
            'member_message_isattachment': false,
            'member_message_isdocument': false,
            'member_message_isimage': false,
            'member_message_isvideo': false,
            'member_message_isvoice': false,
            'member_message_target_1_uid': dataMember1Uid,
            'member_message_target_2_uid': dataMember2Uid,
            'member_message_target_3_uid': dataMember3Uid,
            'member_message_target_4_uid': dataMember4Uid,
            'member_message_target_5_uid': dataMember5Uid,
            'member_message_time': dataExtensionTime,
            'member_message_voice_url': "",
            'member_name': "System Message",
            'member_uid': dataBenefactorUid,
            'member_message_no': benefactorMessageRef.id,

        });

        batch.set(notiPosterPoolRef, {
            'isMulti': true,
            'tokenList': exTokenList,
            'notificationTitle': 'Lets continue the chat',
            'notificationBody': messageText,
            'notiCategory': 'chaos_extension'



        });


        await batch.commit();

        /*await benefactorMessageRef.set({
            'member_avatar_url': dataBenefactorAvatarUrl,
            'member_message': messageText,
            'member_message_attachment_url': "isola_system_message",
            'member_message_isattachment': false,
            'member_message_isdocument': false,
            'member_message_isimage': false,
            'member_message_isvideo': false,
            'member_message_isvoice': false,
            'member_message_target_1_uid': dataMember1Uid,
            'member_message_target_2_uid': dataMember2Uid,
            'member_message_target_3_uid': dataMember3Uid,
            'member_message_target_4_uid': dataMember4Uid,
            'member_message_target_5_uid': dataMember5Uid,
            'member_message_time': dataExtensionTime,
            'member_message_voice_url': "",
            'member_name': "System Message",
            'member_uid': dataBenefactorUid,
            'member_message_no': benefactorMessageRef.id,

        });*/
        console.log('38');


        await extensionRef.delete();
        console.log('39');


    }
    console.log('40');




});
exports.chaosCompletePoolChecker = functions.firestore.document('chaos_complete_pool/{groupNo}').onCreate(async (snap, context) => {


    const poolData = snap.data();
    console.log('1');

    const dataChaosGroupNo = poolData.complete_chaos_no;


    const chaosGroupRef = db.collection('chaos_groups').doc(dataChaosGroupNo);

    const chaosGroupData = await chaosGroupRef.get();

    const chaosTargetGroup1 = chaosGroupData.data().group_1_no;

    const chaosTargetGroup2 = chaosGroupData.data().group_2_no;


    const chaosTargetGroupRef1 = db.collection('groups').doc(chaosTargetGroup1);
    const chaosTargetGroupRef2 = db.collection('groups').doc(chaosTargetGroup2);

    const chaosGroupsChatRef = db.collection('chaos_groups_chat').doc(dataChaosGroupNo);

    //  const chaosTargetGroupData1=await chaosTargetGroupRef1.get();
    // const chaosTargetGroupData2=await chaosTargetGroupRef2.get();


    const batch = db.batch();


    batch.update(chaosTargetGroupRef1, {
        'gChaos': false,
        'gChaosNo': "nothing"

    });


    batch.update(chaosTargetGroupRef2, {
        'gChaos': false,
        'gChaosNo': "nothing"
    });


    batch.update(chaosGroupsChatRef, {
        'chaos_is_complete': true
    });

    await batch.commit();





});
exports.notificationPosterPoolChecker = functions.firestore.document('notification_poster_pool/{posterNo}').onCreate(async (snap, context) => {

    const posterData = snap.data();


    const posterIsMulti = posterData.isMulti;
    const posterNotificationBody = posterData.notificationBody;
    const posterNotificationTitle = posterData.notificationTitle;
    const posterTokenList = posterData.tokenList;
    const posterNotiCategory = posterData.notiCategory;



    if (posterIsMulti == false) {







        await admin.messaging().send({
            token: posterTokenList[0],


            notification: {


                title: posterNotificationTitle,
                body: posterNotificationBody,

            },
            data: {
                'notiCategory': posterNotiCategory

            }
        }).then((response) => {

            // Response is a message ID string.
            console.log('Successfully sent message:', response);
            return { success: true };
        }).catch((error) => {
            return { error: error.code };
        });







    }
    else {
        await admin.messaging().sendMulticast({
            tokens: posterTokenList,


            notification: {
                title: posterNotificationTitle,
                body: posterNotificationBody


            },
            data: {

                notiCategory: posterNotiCategory

            }

        }).then((response) => {

            // Response is a message ID string.
            console.log('Successfully sent message:', response);
            return { success: true };
        }).catch((error) => {
            return { error: error.code };
        });

    }





});
exports.chaosStopperPoolChecker = functions.firestore.document('chaos_stopper_pool/{orderNo}').onCreate(async (snap, context) => {

    const poolData = snap.data();
    console.log('1');

    const dataGroupNo = poolData.groupNo;
    const dataOrderNo = poolData.orderNo;


    const chaosApplyPool2Ref = db.collection('chaos_apply_pool_2').doc(dataGroupNo);
    const targetGroupRef = db.collection('groups').doc(dataGroupNo);
    const targetOrderNo = db.collection('chaos_stopper_pool').doc(dataOrderNo);


    const batch = db.batch();



    batch.delete(chaosApplyPool2Ref);


    batch.update(targetGroupRef, {
        'gChaosSearching': false,
    });

    batch.delete(targetOrderNo);

    await batch.commit();



});
exports.deleteFriendPoolChecker = functions.firestore.document('delete_friend_pool/{orderNo}').onCreate(async (snap, context) => {
    const deleteFriendOrderData = snap.data();

    const deleteOrderNo = deleteFriendOrderData.report_no;
    const orderTargetUid = deleteFriendOrderData.target_uid;
    const orderUserUid = deleteFriendOrderData.user_uid;


    const userRef = db.collection('users_meta').doc(orderUserUid);
    const targetUserRef = db.collection('users_meta').doc(orderTargetUid);
    const deleteOrderRef = db.collection('delete_friend_pool').doc(deleteOrderNo);

    try {
        await db.runTransaction(async (t) => {


            const targetMetaGetting = await t.get(targetUserRef);

            //console.log("burada1");

            const targetData = targetMetaGetting.data();
            //    console.log("burada2");

            const targetFriendsList = targetData.uFriends;

            if (targetFriendsList.includes(orderUserUid)) {

                const orderIndex = await targetFriendsList.indexOf(orderUserUid);
                await targetFriendsList.splice(orderIndex, 1);

                t.update(targetUserRef, {
                    'uFriends': targetFriendsList
                })
            }






        });

        await deleteOrderRef.delete();
        console.log('Transaction success!');
    } catch (error) {
        console.log('Transaction failure:', error);
    }


    try {
        await db.runTransaction(async (t) => {


            const userMetaGetting = await t.get(userRef);

            //console.log("burada1");

            const userData = userMetaGetting.data();
            //    console.log("burada2");

            const userFriendsList = userData.uFriends;

            if (userFriendsList.includes(orderTargetUid)) {

                const orderIndex = await userFriendsList.indexOf(orderTargetUid);
                await userFriendsList.splice(orderIndex, 1);

                t.update(userRef, {
                    'uFriends': userFriendsList
                })
            }






        });

        await deleteOrderRef.delete();

        console.log('Transaction success!');
    } catch (error) {
        console.log('Transaction failure:', error);
    }

});
exports.blockTargetPoolChecker = functions.firestore.document('block_target_pool/{orderNo}').onCreate(async (snap, context) => {
    const blockTargetOrderData = snap.data();

    const blockOrderNo = blockTargetOrderData.report_no;
    const orderTargetUid = blockTargetOrderData.target_uid;
    const orderUserUid = blockTargetOrderData.user_uid;


    const userRef = db.collection('users_meta').doc(orderUserUid);
    const targetUserRef = db.collection('users_meta').doc(orderTargetUid);
    const blockOrderRef = db.collection('block_target_pool').doc(blockOrderNo);

    try {
        await db.runTransaction(async (t) => {


            const targetMetaGetting = await t.get(targetUserRef);

            //console.log("burada1");

            const targetBlockedData = targetMetaGetting.data();
            //    console.log("burada2");

            var targetBlockedList = targetBlockedData.uBlocked;

            if (targetBlockedList.includes(orderUserUid) == false) {

                if (targetBlockedList[0] == 'nothing') {

                    targetBlockedList[0] = orderUserUid;

                    t.update(targetUserRef, {
                        'uBlocked': targetBlockedList
                    })


                }
                else {
                    await targetBlockedList.push(orderUserUid);
                    t.update(targetUserRef, {
                        'uBlocked': targetBlockedList
                    })
                }


            }






        });

        await blockOrderRef.delete();
        console.log('Transaction success!');
    } catch (error) {
        console.log('Transaction failure:', error);
    }


    try {
        await db.runTransaction(async (t) => {


            const userMetaGetting = await t.get(userRef);

            //console.log("burada1");

            const userData = userMetaGetting.data();
            //    console.log("burada2");

            const userBlockedList = userData.uBlocked;

            if (userBlockedList.includes(orderTargetUid) == false) {

                if (userBlockedList[0] == 'nothing') {

                    userBlockedList[0] = orderTargetUid;

                    t.update(userRef, {
                        'uBlocked': userBlockedList
                    })


                }
                else {
                    await userBlockedList.push(orderTargetUid);
                    t.update(userRef, {
                        'uBlocked': userBlockedList
                    })
                }
            }








        });

        await blockOrderRef.delete();

        console.log('Transaction success!');
    } catch (error) {
        console.log('Transaction failure:', error);
    }

});
exports.tokenEarnPoolChecker = functions.firestore.document('token_earn_pool/{orderNo}').onCreate(async (snap, context) => {
    const tokenEarnData = snap.data();

    const earnType = tokenEarnData.earn_type;
    const earnerUid = tokenEarnData.earner_uid;
    const operationTime = tokenEarnData.operation_time;
    const order_no = tokenEarnData.order_no;



    const userMetaRef = db.collection('users_meta').doc(earnerUid);
    const orderRef = db.collection('token_earn_pool').doc(order_no);
    const statisticsRef = db.collection('app_settings').doc('statistic_values');
    var sendingToken = 0;

    if (earnType == 'earn_ads_video') {
        sendingToken = 1;

    }
    if (earnType == 'earn_rate') {

        sendingToken = 5;
    }


    try {

        await db.runTransaction(async (t) => {

            const userMetaGetting = await t.get(userMetaRef);


            const userMetaData = userMetaGetting.data();

            var userTokenValue = userMetaData.uToken;


            t.update(userMetaRef, {
                'uToken': userTokenValue + sendingToken,

            });

            //feed like list operation end

        });

        if (earnType != 'earn_rate') {
            await orderRef.delete();




        }



        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);

    }

    try {


        await db.runTransaction(async (t) => {

            const statisticsGetting = await t.get(statisticsRef);


            const appStatistics = statisticsGetting.data();

            var appRaterValue = appStatistics.app_rater;
            var appWatcher = appStatistics.video_watcher;

            var topRater = appStatistics.top_rater;
            var topWatcher = appStatistics.top_watcher;

            if (earnType == 'earn_ads_video') {

                await topWatcher.push(earnerUid);
                appWatcher = appWatcher + 1;
            }
            if (earnType == 'earn_rate') {

                await topRater.push(earnerUid);
                appRaterValue = appRaterValue + 1;
            }


            t.update(statisticsRef, {
                'app_rater': appRaterValue,
                'video_watcher': appWatcher,
                'top_rater': topRater,
                'top_watcher': topWatcher

            });

            //feed like list operation end

        });



        console.log('Transaction success!');
    } catch (error) {
        console.log('Transaction failure:', error);
    }










});
exports.testPoolChecker = functions.firestore.document('test_pool_checker/{testNo}').onCreate(async (snap, context) => {

    const testData = snap.data();

    const newUserMail = testData.email;
    const newUserUniversity = newUserMail.substring(newUserMail.lastIndexOf('@') + 1);


    var uActivityNo;
    var uIsActive;
    var uUniversityName;
    var uCountry;


    const testRef = db.collection('test_pool_solution').doc();


    if (universityList.includes(newUserUniversity)) {
        uActivityNo = [universityEnum.properties[newUserUniversity].activityNo];
        uIsActive = universityEnum.properties[newUserUniversity].isActive;
        uUniversityName = universityEnum.properties[newUserUniversity].universityName;
        uCountry = universityEnum.properties[newUserUniversity].whichCountry;
        await testRef.set({
            "uActivityNo": uActivityNo,
            "uIsActive": uIsActive,
            "uUniversityName": uUniversityName,
            "uCountry": uCountry


        });
    }
    else {
        uActivityNo = ["null"];
        uIsActive = false;
        uUniversityName = newUserUniversity;
        await testRef.set({
            "uActivityNo": uActivityNo,
            "uIsActive": uIsActive,
            "uUniversityName": uUniversityName,
            "uCountry": "-"

        });
    }
});
exports.confirmationCreatedPool = functions.firestore.document('confirmations/student_confirmations/confirmation_created_pool/{userUid}').onCreate(async (snap, context) => {

    const confirmationCreatedData = snap.data();

    const studentEmail = confirmationCreatedData.studentEmail;
    const userUid = confirmationCreatedData.userUid;
    const userUniversity = confirmationCreatedData.userUniversity;
    const sentDate = confirmationCreatedData.sentDate;
    console.log('1');

    var securityNumber = Math.floor(Math.random() * 711222);
    securityNumber = securityNumber + 111111;
    console.log('2');
    const sendPoolRef = db.collection('confirmations').doc('student_confirmations').collection('confirmation_send_pool').doc(userUid);
    const createdRef = db.collection('confirmations').doc('student_confirmations').collection('confirmation_created_pool').doc(userUid);
    console.log('3');

    //have to delete
    const solutionPoolRef = db.collection('confirmations').doc('student_confirmations').collection('confirmation_solution_pool').doc(userUid);
    const userAnswerPoolRef = db.collection('confirmations').doc('student_confirmations').collection('confirmation_user_answer_pool').doc(userUid);
    const userDisplay = db.collection('users_display').doc(userUid);
    const mailListRef = db.collection('confirmations').doc('student_confirmations').collection('universities_mail_list').doc(userUniversity);

    console.log('4');



    await sendPoolRef.delete();
    console.log('5');
    await solutionPoolRef.delete();
    console.log('6');
    await userAnswerPoolRef.delete();
    console.log('7');
    const mailListGetting = await mailListRef.get();
    console.log('8');
    const mailListData = mailListGetting.data();
    console.log('9');

    if (mailListData != null) {

        if (mailListData.mailList.includes(studentEmail)) {
            //send notification
            console.log('10');

            const userDisplayGetting = await userDisplay.get();
            console.log('11');
            const userDisplayData = userDisplayGetting.data();
            console.log('12');
            await createdRef.delete();
            console.log('13');
            await admin.messaging().send({
                token: userDisplayData.uDbToken,


                notification: {


                    title: 'Verification Fail',
                    body: 'The Email already used',

                },

            }).then((response) => {

                // Response is a message ID string.
                console.log('Successfully sent message:', response);
                return { success: true };
            }).catch((error) => {
                return { error: error.code };
            });

        }
        else {

            console.log('14');

            await sendPoolRef.set({
                'securityCode': securityNumber,
                'sentDate': sentDate,
                'userUniversity': userUniversity,
                'studentEmail': studentEmail,
                'userUid': userUid
            });
            console.log('15');
            await createdRef.delete();

            console.log('16');


            db.collection('mail').add({
                to: studentEmail,
                message: {
                    subject: 'Hello from Isola!',
                    html: `<h1>Order Confirmation</h1>
                <p> <b>Security Code: </b>${securityNumber} </p>`
                },
            });
            console.log('17');

        }
    }
    else {


        console.log('14');

        await sendPoolRef.set({
            'securityCode': securityNumber,
            'sentDate': sentDate,
            'userUniversity': userUniversity,
            'studentEmail': studentEmail,
            'userUid': userUid
        });
        console.log('15');
        await createdRef.delete();

        console.log('16');


        db.collection('mail').add({
            to: studentEmail,
            message: {
                subject: 'Hello from Isola!',
                html: `<h1>Order Confirmation</h1>
            <p> <b>Security Code: </b>${securityNumber} </p>`
            },
        });
        console.log('17');



    }

    /*
        var transporter = nodemailer.createTransport({
            host: 'smtp.gmail.com',
            port: 465,
            secure: true,
            auth: {
                user: 'suy.register@gmail.com',
                pass: '134679Renes'
            }
        });
        const mailOptions = {
            from: `suy.register@gmail.com`,
            to: studentEmail,
            subject: 'contact form message',
            html: `<h1>Order Confirmation</h1>
             <p> <b>Security Code: </b>${securityNumber} </p>`
        };
    
        return transporter.sendMail(mailOptions, (error, data) => {
            if (error) {
                console.log(error)
                return
            }
            console.log("Sent!")
        });
    */


});
exports.confirmationUserAnswerPool = functions.firestore.document('confirmations/student_confirmations/confirmation_user_answer_pool/{userUid}').onCreate(async (snap, context) => {

    const confirmationUserAnswerData = snap.data();

    const studentEmail = confirmationUserAnswerData.studentEmail;
    const userUid = confirmationUserAnswerData.userUid;
    const securityCode = confirmationUserAnswerData.securityCode;
    const answerDate = confirmationUserAnswerData.answerDate;





    const sendPoolRef = db.collection('confirmations').doc('student_confirmations').collection('confirmation_send_pool').doc(userUid);
    const solutionRef = db.collection('confirmations').doc('student_confirmations').collection('confirmation_solution_pool').doc(userUid);
    const answerRef = db.collection('confirmations').doc('student_confirmations').collection('confirmation_user_answer_pool').doc(userUid);

    const currentDate = new Date();
    const solutionDate = currentDate.getTime();



    const sendPoolData = await sendPoolRef.get();

    const sendData = sendPoolData.data();

    if (sendData.securityCode == securityCode) {

        await solutionRef.set({

            'solution': true,
            'solutionDate': solutionDate,
            'userUid': userUid,
            'userUniversity': sendData.userUniversity,
            'studentEmail': studentEmail
        });

        await sendPoolRef.delete();
        await answerRef.delete();
    }
    else {
        await solutionRef.set({
            'solution': false,
            'solutionDate': solutionDate,
            'userUid': userUid,
            'userUniversity': sendData.userUniversity,
            'studentEmail': studentEmail
        });
        await sendPoolRef.delete();
        await answerRef.delete();
    }








});
exports.confirmationSolutionPool = functions.firestore.document('confirmations/student_confirmations/confirmation_solution_pool/{userUid}').onCreate(async (snap, context) => {

    const confirmationSolutionData = snap.data();

    const solution = confirmationSolutionData.solution;
    const userUid = confirmationSolutionData.userUid;
    //const solutionDate = confirmationSolutionData.solutionDate;
    const userUniversity = confirmationSolutionData.userUniversity;
    const studentEmail = confirmationSolutionData.studentEmail;
    const currentDate = new Date();
    const solutionDate = currentDate.getTime();





    const solutionRef = db.collection('confirmations').doc('student_confirmations').collection('confirmation_solution_pool').doc(userUid);
    const usersConfirmationDataRef = db.collection('confirmations').doc('student_confirmations').collection('users_confirmation_data').doc(userUniversity).collection('users').doc(userUid);

    if (solution == true) {



        await usersConfirmationDataRef.set({

            'confirmDate': solutionDate,
            'studentEmail': studentEmail,
            'userUid': userUid,
            'userUniversity': userUniversity

        });

        await solutionRef.delete();
    }
    else {
        await solutionRef.delete();
    }










});
exports.usersConfirmationDataChecker = functions.firestore.document('confirmations/student_confirmations/users_confirmation_data/{universityName}/users/{userUid}').onCreate(async (snap, context) => {

    const userConfirmationData = snap.data();


    const userUid = userConfirmationData.userUid;
    //const solutionDate = confirmationSolutionData.solutionDate;
    const userUniversity = userConfirmationData.userUniversity;
    const studentEmail = userConfirmationData.studentEmail;



    const userDisplayRef = db.collection('users_display').doc(userUid);
    const userMetaRef = db.collection('users_meta').doc(userUid);


    const mailListRef = db.collection('confirmations').doc('student_confirmations').collection('universities_mail_list').doc(userUniversity);




    const batch = db.batch();


    batch.update(userDisplayRef, {

        'uUniversity': userUniversity,

    });


    batch.update(userMetaRef, {

        'uValid': true,

    });




    await batch.commit();



    //try
    try {

        await db.runTransaction(async (t) => {

            const targetMailListGetting = await t.get(mailListRef);
            const targetMailListData = targetMailListGetting.data();

            var targetMailList;

            if (targetMailListData != null) {
                targetMailList = targetMailListData.mailList;

                await targetMailList.push(studentEmail);



                t.update(mailListRef, {
                    'mailList': targetMailList,


                });
            }
            else {


                t.set(mailListRef, {

                    'mailList': [studentEmail],
                })
            }








        });
        console.log('Transaction success!');

    } catch (error) {
        console.log('Transaction failure:', error);


    }
});
exports.universityAdder = functions.firestore.document('university_adder/{docNo}').onCreate(async (snap, context) => {

    const universityData = snap.data();


    const activityNo = universityData.activityNo;
    const fullName = universityData.fullName;
    const isActive = universityData.isActive;
    const isNewCountry = universityData.isNewCountry;
    const mailType = universityData.mailType;
    const whichCountry = universityData.whichCountry;

    const docNo = context.params.docNo;

    const adderRef = db.collection('university_adder').doc(docNo);




    if (isNewCountry == true) {

        const newCountryRef = db.collection('partners').doc(whichCountry);
        const newCountryRefDetail = db.collection('partners').doc(whichCountry).collection('universityDetail').doc(fullName);

        const batch = db.batch();



        batch.set(newCountryRef, {
            'universityAmount': 1,
            'universityList': [fullName]
        });


        batch.set(newCountryRefDetail, {
            'activityNo': activityNo,
            'fullName': fullName,
            'isActive': isActive,
            'mailType': mailType,
            'universityValue': 1,
            'whichCountry': whichCountry



        })



        batch.delete(adderRef);



        await batch.commit();

        const partnerSettingsRef = db.collection('partners').doc('settings');

        try {

            await db.runTransaction(async (t) => {

                const partnerSettingsListGetting = await t.get(partnerSettingsRef);


                var countryList = partnerSettingsListGetting.data().countryList;

                await countryList.push(whichCountry);


                t.update(partnerSettingsRef, {
                    'countryList': countryList,


                });










            });
            console.log('Transaction success!');

        } catch (error) {
            console.log('Transaction failure:', error);


        }







    }
    else {


        const countryRef = db.collection('partners').doc(whichCountry);
        const countryRefDetail = db.collection('partners').doc(whichCountry).collection('universityDetail').doc(fullName);

        const countryRefGetting = await countryRef.get();


        var countryUniversityAmount = countryRefGetting.data().universityAmount;
        var countryUniversityList = countryRefGetting.data().universityList;



        await countryUniversityList.push(fullName);


        const batch = db.batch();


        batch.set(countryRef, {
            'universityAmount': countryUniversityAmount + 1,
            'universityList': countryUniversityList
        });


        batch.set(countryRefDetail, {
            'activityNo': activityNo,
            'fullName': fullName,
            'isActive': isActive,
            'mailType': mailType,
            'universityValue': countryUniversityAmount + 1,
            'whichCountry': whichCountry



        })



        batch.delete(adderRef);



        await batch.commit();




    }





});
exports.universityAdderAlot = functions.firestore.document('university_adder_alot/{docNo}').onCreate(async (snap, context) => {
    const universityData = snap.data();

    const activityNoList = universityData.activityNoList;
    const fullNameList = universityData.fullNameList;
    const isActiveList = universityData.isActiveList;
    const isNewCountry = universityData.isNewCountry;
    const mailTypeList = universityData.mailTypeList;
    const whichCountry = universityData.whichCountry;

    const docNo = context.params.docNo;

    const adderRef = db.collection('university_adder_alot').doc(docNo);

    if (isNewCountry == true) {
        const newCountryRef = db.collection('partners').doc(whichCountry);

        await newCountryRef.set({
            'universityAmount': fullNameList.length,
            'universityList': fullNameList,

        });




        try {

            await db.runTransaction(async (t) => {

                const partnerSettingsListGetting = await t.get(partnerSettingsRef);


                var countryList = partnerSettingsListGetting.data().countryList;

                await countryList.push(whichCountry);


                t.update(partnerSettingsRef, {
                    'countryList': countryList,


                });










            });
            console.log('Transaction success!');

        } catch (error) {
            console.log('Transaction failure:', error);


        }
        for (let index = 0; index < fullNameList.length; index++) {
            var fullName = fullNameList[index];
            var activityNo = activityNoList[index];
            var isActive = isActiveList[index];
            var mailType = mailTypeList[index];
            var universityValue = index + 1;

            const newCountryRefDetail = db.collection('partners').doc(whichCountry).collection('universityDetail').doc(fullName);

            await newCountryRefDetail.set({
                'activityNo': activityNo,
                'fullName': fullName,
                'isActive': isActive,
                'mailType': mailType,
                'universityValue': universityValue,
                'whichCountry': whichCountry

            });

        }
        const partnerSettingsRef = db.collection('partners').doc('settings');

        try {

            await db.runTransaction(async (t) => {

                const partnerSettingsListGetting = await t.get(partnerSettingsRef);


                var countryList = partnerSettingsListGetting.data().countryList;

                await countryList.push(whichCountry);


                t.update(partnerSettingsRef, {
                    'countryList': countryList,


                });










            });
            console.log('Transaction success!');

        } catch (error) {
            console.log('Transaction failure:', error);


        }

        await adderRef.delete();




    }
    else {
        const countryRef = db.collection('partners').doc(whichCountry);
        try {



            await db.runTransaction(async (t) => {

                const newCountryGetting = await t.get(countryRef);


                var universityAmount = newCountryGetting.data().universityAmount;
                var universityList = newCountryGetting.data().universityList;

                var newAmount = universityAmount + (fullNameList.length);

                var newList = await universityList.concat(fullNameList);



                t.update(countryRef, {
                    'universityAmount': newAmount,
                    'universityList': newList,


                });










            });
            console.log('Transaction success!');

        } catch (error) {
            console.log('Transaction failure:', error);


        }
        const countryData = await countryRef.get();
        const oldAmount = countryData.data().universityAmount;



        for (let index = 0; index < fullNameList.length; index++) {
            var fullName = fullNameList[index];
            var activityNo = activityNoList[index];
            var isActive = isActiveList[index];
            var mailType = mailTypeList[index];
            var universityValue = oldAmount + index + 1;

            const newCountryRefDetail = db.collection('partners').doc(whichCountry).collection('universityDetail').doc(fullName);

            await newCountryRefDetail.set({
                'activityNo': activityNo,
                'fullName': fullName,
                'isActive': isActive,
                'mailType': mailType,
                'universityValue': universityValue,
                'whichCountry': whichCountry

            });

        }


        await adderRef.delete();
    }





});
exports.statsDaily = functions.pubsub.schedule('every 24 hours').onRun(async (ctx) => {
    console.log(ctx.timestamp);

    // const textFeedItems = await db.collectionGroup('text_feeds').orderBy('like_value', 'desc').limit(2).get();
    const currentDate = new Date();
    const toDate = currentDate.getTime();




    const statisticValueRef = db.collection('app_settings').doc('statistic_values');
    const groupsRef = db.collection('groups');
    const groupLeaveListRef = db.collection('groups_leave_pool').doc('groups_leave_list');
    const chaosGroupsRef = db.collection('chaos_groups');
    const usersDisplayRef = db.collection('users_display');
    const usersMetaRef = db.collection('users_meta');
    const textFeeds = db.collectionGroup('text_feeds');
    const imageFeeds = db.collectionGroup('image_feeds');
    const countryRef = db.collection('partners').doc('settings');
    const universityStatisticRef = db.collection('university_statistics');
    const panelRefDaily = db.collection('panel_statistics').doc('isola_stats').collection('daily_stats').doc(toDate.toString());

    const statisticValueGetting = await statisticValueRef.get();
    const groupsGetting = await groupsRef.get();
    const groupsLeaveGetting = await groupLeaveListRef.get();
    const chaosGroupsGetting = await chaosGroupsRef.get();
    const usersDisplayGetting = await usersDisplayRef.get();
    const usersMetaGetting = await usersMetaRef.get();
    const textFeedsGetting = await textFeeds.get();
    const imageFeedsGetting = await imageFeeds.get();
    const countryRefGetting = await countryRef.get();
    const universityStatisticGetting = await universityStatisticRef.orderBy('university_users_value', 'desc').limit(5).get();
    const universityStatisticAllGetting = await universityStatisticRef.get();





    const statisticValueData = statisticValueGetting.data();
    const groupsDocs = groupsGetting.docs;
    const groupLeaveList = groupsLeaveGetting.data().leave_list;
    const chaosGroupsDocs = chaosGroupsGetting.docs;
    const usersDisplayDocs = usersDisplayGetting.docs;
    const usersMetaDocs = usersMetaGetting.docs;
    const textFeedsDocs = textFeedsGetting.docs;
    const imageFeedsDocs = imageFeedsGetting.docs;
    const countryValue = countryRefGetting.data().countryList.length;
    const universityStatisticDocs = universityStatisticGetting.docs;
    const universityStatisticAllDocs = universityStatisticAllGetting.docs;







    var ads_watcher_total = statisticValueData.video_watcher;
    var chaos_online = 0;
    var chaos_searching = 0;
    var chaos_total = 0;
    var country_total = countryValue;
    var group_active = 0;
    var group_female = 0;
    var group_male = 0;
    var group_other = 0;
    var group_female_active = 0;
    var group_male_active = 0;
    var group_other_active = 0;
    var group_total = 0;
    var group_waiting = 0;
    var image_total = 0;
    var like_total = 0;
    var messages_total = 0;
    var rater_total = statisticValueData.app_rater;
    var report_101_value = 0;
    var report_102_value = 0;
    var report_103_value = 0;
    var report_104_value = 0;
    var report_105_value = 0;
    var stats_date = toDate;
    var text_total = 0;
    var token_total = 0;
    var university_top5 = [];
    var university_total = 179;
    var university_used = -3;
    var users_female = 0;
    var users_male = 0;
    var users_online = 0;
    var users_other = 0;
    var users_searching = 0;
    var users_total = 0;
    var users_unvalid = 0;
    var users_valid = 0;




    groupsDocs.forEach(element => {
        group_total = group_total + 1;


        //closed
        if (groupLeaveList.includes(element.data().gNo)) {




            if (element.data().gNonBinary) {

                group_other = group_other + 1;

            }
            else {
                if (element.data().gSex) {

                    group_male = group_male + 1;
                }
                else {

                    group_female = group_female + 1;
                }
            }








        }
        //still alive
        else {





            if (element.data().gActive) {
                group_active = group_active + 1;




                if (element.data().gNonBinary) {
                    group_other_active = group_other_active + 1;
                    group_other = group_other + 1;

                }
                else {
                    if (element.data().gSex) {
                        group_male_active = group_male_active + 1;
                        group_male = group_male + 1;
                    }
                    else {
                        group_female_active = group_female_active + 1;
                        group_female = group_female + 1;
                    }
                }


            }
            else {
                group_waiting = group_waiting + 1;
            }
            if (element.data().gChaos) {
                chaos_online = chaos_online + 1;

            }
            if (element.data().gChaosSearching) {
                chaos_searching = chaos_searching + 1;
            }





        }










    });
    chaosGroupsDocs.forEach(element => {

        if (element.data().group_is_active) {
            chaos_total = chaos_total + 1;
        }

    });
    usersDisplayDocs.forEach(element => {

        users_total = users_total + 1;

        if (element.data().uOnline) {
            users_online = users_online + 1;
        }


        if (element.data().uNonBinary) {
            users_other = users_other + 1;
        }
        else {

            if (element.data().uSex) {
                users_male = users_male + 1;
            }
            else {
                users_female = users_female + 1;
            }
        }
    });
    usersMetaDocs.forEach(element => {



        token_total = token_total + element.data().uToken;
        if (element.data().uValid) {

            users_valid = users_valid + 1;
        }
        else {

            users_unvalid = users_unvalid + 1;
        }
        if (element.data().uSearching) {

            users_searching = users_searching + 1;

        }



    });
    textFeedsDocs.forEach(element => {
        text_total = text_total + 1;

        like_total = like_total + element.data().like_value;
    });
    imageFeedsDocs.forEach(element => {
        image_total = image_total + 1;
        like_total = like_total + element.data().like_value;
    });
    universityStatisticDocs.forEach(element => {

        university_top5.push(element.id);

    });
    universityStatisticAllDocs.forEach(element => {


        university_used = university_used + 1;
    });





    await panelRefDaily.set({

        "ads_watcher_total": ads_watcher_total,
        "chaos_online": chaos_online,
        "chaos_searching": chaos_searching,
        "chaos_total": chaos_total,
        "country_total": country_total,
        "group_active": group_active,
        "group_female": group_female,
        "group_male": group_male,
        "group_other": group_other,
        "group_female_active": group_female_active,
        "group_male_active": group_male_active,
        "group_other_active": group_other_active,
        "group_total": group_total,
        "group_waiting": group_waiting,
        "image_total": image_total,
        "like_total": like_total,
        "messages_total": messages_total,
        "rater_total": rater_total,
        "report_101_value": report_101_value,
        "report_102_value": report_102_value,
        "report_103_value": report_103_value,
        "report_104_value": report_104_value,
        "report_105_value": report_105_value,
        "stats_date": stats_date,
        "text_total": text_total,
        "token_total": token_total,
        "university_top5": university_top5,
        "university_total": university_total,
        "university_used": university_used,
        "users_female": users_female,
        "users_male": users_male,
        "users_online": users_online,
        "users_other": users_other,
        "users_searching": users_searching,
        "users_total": users_total,
        "users_unvalid": users_unvalid,
        "users_valid": users_valid


    });
});

exports.reloadStats = functions.firestore.document('panel_statistics/isola_stats/reload_stats/{orderNo}').onCreate(async (snap, context) => {


    // const textFeedItems = await db.collectionGroup('text_feeds').orderBy('like_value', 'desc').limit(2).get();
    const currentDate = new Date();
    const toDate = currentDate.getTime();




    const statisticValueRef = db.collection('app_settings').doc('statistic_values');
    const groupsRef = db.collection('groups');
    const groupLeaveListRef = db.collection('groups_leave_pool').doc('groups_leave_list');
    const chaosGroupsRef = db.collection('chaos_groups');
    const usersDisplayRef = db.collection('users_display');
    const usersMetaRef = db.collection('users_meta');
    //  const textFeeds = db.collectionGroup('text_feeds');
    // const imageFeeds = db.collectionGroup('image_feeds');
    const countryRef = db.collection('partners').doc('settings');
    const universityStatisticRef = db.collection('university_statistics');
    const panelRefCurrent = db.collection('panel_statistics').doc('isola_stats').collection('current_stats').doc('stats_now');
    const panelRefHistory = db.collection('panel_statistics').doc('isola_stats').collection('history_stats').doc(toDate.toString());

    const statisticValueGetting = await statisticValueRef.get();
    const groupsGetting = await groupsRef.get();
    const groupsLeaveGetting = await groupLeaveListRef.get();
    const chaosGroupsGetting = await chaosGroupsRef.get();
    const usersDisplayGetting = await usersDisplayRef.get();
    const usersMetaGetting = await usersMetaRef.get();
    // const textFeedsGetting = await textFeeds.get();
    // const imageFeedsGetting = await imageFeeds.get();
    const countryRefGetting = await countryRef.get();
    const universityStatisticGetting = await universityStatisticRef.orderBy('university_users_value', 'desc').limit(5).get();
    const universityStatisticAllGetting = await universityStatisticRef.get();





    const statisticValueData = statisticValueGetting.data();
    const groupsDocs = groupsGetting.docs;
    const groupLeaveList = groupsLeaveGetting.data().leave_list;
    const chaosGroupsDocs = chaosGroupsGetting.docs;
    const usersDisplayDocs = usersDisplayGetting.docs;
    const usersMetaDocs = usersMetaGetting.docs;
    // const textFeedsDocs = textFeedsGetting.docs;
    // const imageFeedsDocs = imageFeedsGetting.docs;
    const countryValue = countryRefGetting.data().countryList.length;
    const universityStatisticDocs = universityStatisticGetting.docs;
    const universityStatisticAllDocs = universityStatisticAllGetting.docs;







    var ads_watcher_total = statisticValueData.video_watcher;
    var chaos_online = 0;
    var chaos_searching = 0;
    var chaos_total = 0;
    var country_total = countryValue;
    var group_active = 0;
    var group_female = 0;
    var group_male = 0;
    var group_other = 0;
    var group_female_active = 0;
    var group_male_active = 0;
    var group_other_active = 0;
    var group_total = 0;
    var group_waiting = 0;
    var image_total = 0;
    var like_total = 0;
    var messages_total = 0;
    var rater_total = statisticValueData.app_rater;
    var report_101_value = 0;
    var report_102_value = 0;
    var report_103_value = 0;
    var report_104_value = 0;
    var report_105_value = 0;
    var stats_date = toDate;
    var text_total = 0;
    var token_total = 0;
    var university_top5 = [];
    var university_total = 179;
    var university_used = -3;
    var users_female = 0;
    var users_male = 0;
    var users_online = 0;
    var users_other = 0;
    var users_searching = 0;
    var users_total = 0;
    var users_unvalid = 0;
    var users_valid = 0;


    groupsDocs.forEach(element => {
        group_total = group_total + 1;


        //closed
        if (groupLeaveList.includes(element.data().gNo)) {




            if (element.data().gNonBinary) {

                group_other = group_other + 1;

            }
            else {
                if (element.data().gSex) {

                    group_male = group_male + 1;
                }
                else {

                    group_female = group_female + 1;
                }
            }








        }
        //still alive
        else {





            if (element.data().gActive) {
                group_active = group_active + 1;




                if (element.data().gNonBinary) {
                    group_other_active = group_other_active + 1;
                    group_other = group_other + 1;

                }
                else {
                    if (element.data().gSex) {
                        group_male_active = group_male_active + 1;
                        group_male = group_male + 1;
                    }
                    else {
                        group_female_active = group_female_active + 1;
                        group_female = group_female + 1;
                    }
                }


            }
            else {
                group_waiting = group_waiting + 1;
            }
            if (element.data().gChaos) {
                chaos_online = chaos_online + 1;

            }
            if (element.data().gChaosSearching) {
                chaos_searching = chaos_searching + 1;
            }





        }










    });
    chaosGroupsDocs.forEach(element => {

        if (element.data().group_is_active) {
            chaos_total = chaos_total + 1;
        }

    });
    usersDisplayDocs.forEach(element => {

        users_total = users_total + 1;

        if (element.data().uOnline) {
            users_online = users_online + 1;
        }


        if (element.data().uNonBinary) {
            users_other = users_other + 1;
        }
        else {

            if (element.data().uSex) {
                users_male = users_male + 1;
            }
            else {
                users_female = users_female + 1;
            }
        }
    });
    usersMetaDocs.forEach(element => {



        token_total = token_total + element.data().uToken;
        if (element.data().uValid) {

            users_valid = users_valid + 1;
        }
        else {

            users_unvalid = users_unvalid + 1;
        }
        if (element.data().uSearching) {

            users_searching = users_searching + 1;

        }



    });
    /*
    textFeedsDocs.forEach(element => {
        text_total = text_total + 1;

        like_total = like_total + element.data().like_value;
    });
    imageFeedsDocs.forEach(element => {
        image_total = image_total + 1;
        like_total = like_total + element.data().like_value;
    });

    */
    universityStatisticDocs.forEach(element => {

        university_top5.push(element.id);

    });
    universityStatisticAllDocs.forEach(element => {


        university_used = university_used + 1;
    });





    await panelRefCurrent.set({

        "ads_watcher_total": ads_watcher_total,
        "chaos_online": chaos_online,
        "chaos_searching": chaos_searching,
        "chaos_total": chaos_total,
        "country_total": country_total,
        "group_active": group_active,
        "group_female": group_female,
        "group_male": group_male,
        "group_other": group_other,
        "group_female_active": group_female_active,
        "group_male_active": group_male_active,
        "group_other_active": group_other_active,
        "group_total": group_total,
        "group_waiting": group_waiting,
        "image_total": image_total,
        "like_total": like_total,
        "messages_total": messages_total,
        "rater_total": rater_total,
        "report_101_value": report_101_value,
        "report_102_value": report_102_value,
        "report_103_value": report_103_value,
        "report_104_value": report_104_value,
        "report_105_value": report_105_value,
        "stats_date": stats_date,
        "text_total": text_total,
        "token_total": token_total,
        "university_top5": university_top5,
        "university_total": university_total,
        "university_used": university_used,
        "users_female": users_female,
        "users_male": users_male,
        "users_online": users_online,
        "users_other": users_other,
        "users_searching": users_searching,
        "users_total": users_total,
        "users_unvalid": users_unvalid,
        "users_valid": users_valid


    });

    await panelRefHistory.set({
        "ads_watcher_total": ads_watcher_total,
        "chaos_online": chaos_online,
        "chaos_searching": chaos_searching,
        "chaos_total": chaos_total,
        "country_total": country_total,
        "group_active": group_active,
        "group_female": group_female,
        "group_male": group_male,
        "group_other": group_other,
        "group_female_active": group_female_active,
        "group_male_active": group_male_active,
        "group_other_active": group_other_active,
        "group_total": group_total,
        "group_waiting": group_waiting,
        "image_total": image_total,
        "like_total": like_total,
        "messages_total": messages_total,
        "rater_total": rater_total,
        "report_101_value": report_101_value,
        "report_102_value": report_102_value,
        "report_103_value": report_103_value,
        "report_104_value": report_104_value,
        "report_105_value": report_105_value,
        "stats_date": stats_date,
        "text_total": text_total,
        "token_total": token_total,
        "university_top5": university_top5,
        "university_total": university_total,
        "university_used": university_used,
        "users_female": users_female,
        "users_male": users_male,
        "users_online": users_online,
        "users_other": users_other,
        "users_searching": users_searching,
        "users_total": users_total,
        "users_unvalid": users_unvalid,
        "users_valid": users_valid
    });
});



/*
exports.createUserTest = functions.firestore.document('create_user_test/{orderNo}').onCreate(async (snap, context) => {
    const testData = snap.data();

    const userEmail = testData.user_mail;
    const newUserUniversity = userEmail.substring(userEmail.lastIndexOf('@') + 1);
    var isValid;

    if (newUserUniversity == 'tilburguniversity.edu') {
        isValid = true;

    }
    else {
        isValid = false;
    }


    const orderRefNo = context.params.orderNo;

    const orderRef = db.collection('create_user_test').doc(orderRefNo);

    await orderRef.update({

        'active': isValid,
        'university_type': newUserUniversity
    });


});


*/
/*


exports.addFriend = functions.firestore.document('add_friend_orders/{orderDocNo}').onCreate(async (snap, context) => {

    const friendOrderData = snap.data();

    const friendOrderNo = friendOrderData.orderNo;
    const orderTargetUid = friendOrderData.targetUser;
    const orderInviterUid = friendOrderData.inviterUser;


    const checkInviterData = await db.collection('users_meta').doc(orderInviterUid).get();
    var inviterFriendOrdersList = checkInviterData.data().uFriendOrders;
    var inviterFriendsList = checkInviterData.data().uFriends;
    var inviterBlockedList = checkInviterData.data().uBlocked;

    const inviterUserRef = db.collection('users_meta').doc(orderInviterUid);
    const targetUserRef = db.collection('users_meta').doc(orderTargetUid);
    const orderRef = db.collection('add_friend_orders').doc(friendOrderNo);

    if (inviterFriendOrdersList.includes(orderTargetUid) || inviterFriendsList.includes(orderTargetUid) || inviterBlockedList.includes(orderTargetUid)) {

        //target already added these lists
        //delete doc
        await orderRef.delete();
    }
    else {
        //target available for operation

        // I am checking targetuser had a order or no
        const checkCrossOrder = await targetUserRef.get();

        var targetFriendOrdersList = checkCrossOrder.data().uFriendOrders;
        var targetFriendsList = checkCrossOrder.data().uFriends;
        var targetBlockedList = checkCrossOrder.data().uBlocked;

        if (targetFriendsList.includes(orderInviterUid)) {

            //inviter already friend with target
            //delete doc
            await orderRef.delete();
        }
        else if (targetBlockedList.includes(orderInviterUid)) {

            //inviter blocked by target
            //delete document

            await orderRef.delete();

        }
        else if (targetFriendOrdersList.includes(orderInviterUid)) {



            //target added to inviter before that order
            //friend adding operation 
            //inviter friend list change
            //target friend list change
            //target orderlist delete inviter uid
            //delete document

            if (inviterFriendsList[0] == "nothing") {

                inviterFriendsList = [];
            }

            if (targetFriendsList[0] == "nothing") {
                targetFriendsList = [];
            }

            const orderIndex = await targetFriendOrdersList.indexOf(orderInviterUid);
            await targetFriendOrdersList.splice(orderIndex, 1);
            await inviterFriendsList.push(orderTargetUid);
            await targetFriendsList.push(orderInviterUid);

            const batch = db.batch();
            console.log('batch tanımlama');

            targetFriendOrdersList.length == 0 ? batch.update(targetUserRef, { uFriendOrders: ["nothing"] }) : batch.update(targetUserRef, { uFriendOrders: targetFriendOrdersList });
            batch.update(inviterUserRef, { uFriends: inviterFriendsList });
            batch.update(targetUserRef, { uFriends: targetFriendsList });

            await batch.commit();
            console.log('batch commit tamam');

            await orderRef.delete();


        }
        else {
            //add this uid to inviter order list
            //and delete this orderno

            if (inviterFriendOrdersList[0] == "nothing") {
                inviterFriendOrdersList[0] = orderTargetUid;

                await inviterUserRef.update({
                    uFriendOrders: inviterFriendOrdersList
                });
                await orderRef.delete();
            }
            else {
                await inviterFriendOrdersList.push(orderTargetUid);

                await inviterUserRef.update({
                    uFriendOrders: inviterFriendOrdersList
                });
                await orderRef.delete();

            }
        }
    }
});



*/




/*
exports.moderatorYap = functions.firestore
    .document('moderators/{moderator_status}')
    .onWrite(async (doc) => {
        const oncekiModeratorDurumu = doc.before.data().moderator_status;
        const sonrakiModeratorDurumu = doc.after.data().moderator_status;

        if (oncekiModeratorDurumu !== sonrakiModeratorDurumu) {
            const moderatorOnceki = await admin
                .auth()
                .getUserByEmail(doc.after.data().email);

            console.log(moderatorOnceki.customClaims);

            await admin.auth().setCustomUserClaims(moderatorOnceki.uid, {
                moderator: sonrakiModeratorDurumu,
            });
            const moderatorSonraki = await admin
                .auth()
                .getUserByEmail(doc.after.data().email);
            console.log(moderatorOnceki.customClaims);
        }
    });

exports.yeniUcretliKullanici = functions.firestore.document('users_display/{paid}').onWrite(async (doc) => {
    const ucretDurumu = doc.after.data().paid;
    const kullaniciId = doc.after.id;
    const lastMessage = doc.after.data().lastMessage;

    if (ucretDurumu && kullaniciId && !lastMessage)

        await db.collection('users').doc(kullaniciId).update({
            'lastMessage': "Yeni Ucretli Kullanici",
            'lastMessageTime': admin.firestore.FieldValue.serverTimestamp(),
        });
});

exports.ucretliKullaniciDurumTakibi=functions.pubsub.schedule('every 20 mins').onRun(async(ctx)=>{
    console.log(ctx.timestamp);

    let simdi=new Date();
    const yirmiDakikaOnce=simdi.setDate(simdi.getDate()-20);
    
    const yirmiGunOnceStamp=admin.firestore.Timestamp.fromDate(yirmiDakikaOnce);

    const suresiGecenKullanicilar=await db.collection('users').orderBy
});

*/



/*
exports.groupOnCreate = functions.firestore.document('groups/{docId}').onCreate(async (snap, context) => {


    const newGroup = snap.data();
    console.log(snap.id);
    const firstUserInGroup = newGroup.gList[0];
    const usersMetaRef = db.collection('users_meta');


    await usersMetaRef.doc(firstUserInGroup).update({
        'uSearching': true,
    });


});
*/
/*
exports.sendMessageNotifications = functions.firestore.document('groups_chat/{groupId/chat_data/{messageId}').onCreate(async (snapshot, context) => {


    const { message, senderId } = snapshot.data();
    const groupId = context.params.groupId;
    const messageId = context.params.messageId;

    const messageData = await db.collection('conversations').doc(groupId).collection('chat_data').doc(messageId).get();


    const member1 = messageData.get("member_message_target_1_uid");
    const member2 = messageData.get("member_message_target_2_uid");

    const members = [member1, member2];
    members.filter(member => member !== senderId).forEach(async (value, index) => {
        const profile = await db.collection("users_display").doc(value).get();
        const token = profile.get("uDbToken");

        if (!token) {
            return;
        }
        await admin.messaging().sendToDevice(token,{
            
            data: {hello: messageId }, notification: {
                title: "You have a message",
                body: message,
            }
        })
    });
    //  const profile1=await db.collection("users_meta").doc(member1).get();
    //const profile2=await db.collection("users_meta").doc(member2).get();

    // const token1=member1.get("token");
    //const token2=member2.get("token");

});
*/