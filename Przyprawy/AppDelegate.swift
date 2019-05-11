//
//  AppDelegate.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 20.07.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit

enum DbTableNames : String {
    case products        = "ProductTable"
    case basket          = "BasketProductTable"
    case shopingProduct  = "ShopingProductTable"
    case toShop          = "ToShopProductTable"
    case categories      = "CategoryTable"
    case users           = "Users"
}
enum SearchField : String {
    case Producent = "producent"
    case Product   = "productName"
    case Tag       = "searchTag"
    case EAN       = "eanCode"
}

 typealias CategoryType = (name: String, nameEN: String, pictureName: String, selectedCategory : Bool)



let coreData = CoreDataStack()
let database = Database(context: coreData.persistentContainer.viewContext)
let server   = Server()
let  categoriesData : [CategoryType]  =
    [(name: "Przyprawy", nameEN: "Spices", pictureName: "🌶🧂", selectedCategory : false),
     (name: "Warzywa", nameEN: "Vegetables", pictureName: "🥬🥕🥒", selectedCategory : false),
     (name: "Owoce", nameEN: "Fructs", pictureName: "🍏🍒🍐", selectedCategory : true),
     (name: "Mięso", nameEN: "Miel", pictureName: "🍗🥩🍖", selectedCategory : false),
     (name: "Pieczywo", nameEN: "Broat", pictureName: "🥐🍞🥖", selectedCategory : false),
     (name: "Nabiał", nameEN: "Milk", pictureName: "🥛🧀🥚", selectedCategory : false),
     (name: "Napoje", nameEN: "Drinks", pictureName: "☕️🍺🍹", selectedCategory : false),
     (name: "Inne", nameEN: "Others", pictureName: "🥜🥟🥮", selectedCategory : false)
        //✖️✔️☛☞☛✔︎✘✓✕❤︎☎︎☏✆✍︎✍︎✍︎💲✖️✔️
]

let fructsProd    : [String] = ["owoce_01_b","owoce_02_b","owoce_03_b","owoce_04_b","owoce_05_b","owoce_06_b","owoce_07_b","owoce_08_b","owoce_09_b","owoce_10_b",
                                "owoce_11_b","owoce_12_b","owoce_13_b","owoce_14_b","owoce_15_b","owoce_16_b","owoce_17_b","owoce_18_b","owoce_19_b","owoce_20_b"]

let vegetableProd : [String] = ["warzywa_01_b","warzywa_02_b","warzywa_03_b","warzywa_04_b","warzywa_05_b","warzywa_06_b","warzywa_07_b","warzywa_08_b",
                                "warzywa_09_b","warzywa_10_b","warzywa_11_b","warzywa_12_b","warzywa_13_b","warzywa_14_b","warzywa_15_b","warzywa_16_b",
                                "warzywa_17_b","warzywa_18_b"]

let othersProd    : [String] = ["pozostale_01_b","pozostale_02_b","pozostale_03_b","pozostale_04_b","pozostale_05_b","pozostale_06_b","pozostale_07_b",
                               "pozostale_08_b","pozostale_09_b","pozostale_10_b","pozostale_11_b","pozostale_12_b","pozostale_13_b","pozostale_14_b",
                                "pozostale_15_b","pozostale_16_b","pozostale_17_b","pozostale_18_b","pozostale_19_b","pozostale_20_b", "pozostale_21_b",
                                "pozostale_22_b"]

//otherProduct(pictureName: "owoce_01_b", productName: "owoce_01_b", categoryNumber: 2, productId: k+1)
//otherProduct(pictureName: "warzywa_01_b", productName: "warzywa_01_b", categoryNumber: 2, productId: k+2)
//otherProduct(pictureName: "pozostale_01_b", productName: "pozostale_01_b", categoryNumber: 2, productId: k+3)



   // / [("Przyprawy", "Spices","picture1",true),("Warzywa", "Vegetables","picture1",false),("Owoce", "Fructs","picture1",false)]

let picturesArray: [String] =
    ["CYKORIA_ARROD_PAPRYKA_OSTRA_MIELONA_10G_59954826_0_173_200",
     "CYKORIA_ARROD_PIEPRZ_CZARNY_ZIARNISTY_11G_60057064_0_173_200",
     "CYKORIA_ARROD_PRZYPRAWA_DO_KURCZAKA_20G_60194487_0_173_200",
     "CYKORIA_BAZYLIA_CYKORIA_10_g_60066362_0_173_200",
     "CYKORIA_CHILI_20G_CYKORIA_60002862_0_173_200",
     "CYKORIA_CURRY_25G_CYKORIA_60114196_0_173_200",
     "CYKORIA_CYNAMON_MIELONY_20G_CYKORIA_63402101_0_173_200",
     "CYKORIA_CZOSNEK_SUSZONY_GRANULOWANY_20G_CYKORIA_60103033_0_173_200",
     "CYKORIA_ESTRAGON_10G_CYKORIA_60920808_0_173_200",
     "CYKORIA_GALKA_MUSZKATOLOWA_MIELONA_15G_61107553_0_173_200",
     "CYKORIA_GORCZYCA_CYKORIA_25_g_60223088_0_173_200",
     "CYKORIA_IMBIR_MIELONY_20G_CYKORIA_60955721_0_173_200",
     "CYKORIA_Jalowiec_15g_53445060_0_173_200",
     "CYKORIA_KMINEK_20G_CYKORIA_59584029_0_173_200",
     "CYKORIA_KOLENDRA_MIELONA_20G_CYKORIA_60947785_0_173_200",
     "Dr_Oetker_Dr_Oetker_Przyprawa_korzenna_40g_76415553_0_173_200",
     "Kamis_Aromatyczny_Pstrag_Z_Koperkiem_18g_35965474_0_173_200",
     "Kamis_FAMILY_MAJERANEK_18G_87417754_0_173_200",
     "Kamis_FAMILY_PAPRYKA_SLODKA_50G_87681805_0_173_200",
     "Kamis_FAMILY_PIEPRZ_ZIOLOWY_50G_87295275_0_173_200",
     "Kamis_FAMILY_PRZYPRAWA_DO_GYROSA_70G_87450078_0_173_200",
     "Kamis_FAMILY_PRZYPRAWA_DO_KURCZAKA_75G_87502506_0_173_200",
     "Kamis_FAMILY_ZIOLA_PROWANSALSKIE_25G_87347761_0_173_200",
     "Kamis_GRILL_CHRUPIACE_WARZYWA_39225271_0_173_200",
     "Kamis_GRILL_KASZANKA_Z_CEBULKA_39501788_0_173_200",
     "Kamis_Grill_Srodziemnomorski_20g_37625365_0_173_200",
     "Kamis_GRILL_ZIEMNIAKI_PIECZONE_39513239_0_173_200",
     "Kamis_KAM_KOPEREK_6G_62938774_0_173_200",
     "Kamis_KAM_OREGANO_10G_61704995_0_173_200",
     "Kamis_KAM_PRZYP_DO_DAN_MEKSYK_25G_62277777_0_173_200",
     "Kamis_KAM_PRZYP_DO_KURC_PO_WEGIE_25G_61778536_0_173_200",
     "Kamis_KAM_PRZYPRAWA_DO_GYROSA_30G_62391727_0_173_200",
     "Kamis_KAMIS_BAZYLIA_10G_61254454_0_173_200",
     "Kamis_KAMIS_Chili_15g_41218157_0_173_200",
     "Kamis_KAMIS_CHINSKA_PRZYPRAWA_5_SMAKOW_20G_27053834_0_173_200",
     "Kamis_KAMIS_CURRY_20G_61318507_0_173_200",
     "Kamis_KAMIS_CYNAMON_MIELONY_15G_63367635_0_173_200",
     "Kamis_KAMIS_CZOSNEK_GRANULOWANY_20G_61302998_0_173_200",
     "Kamis_KAMIS_FAMILY_SUSZONE_POMIDORY_50G_87609194_0_173_200",
     "Kamis_KAMIS_Galka_muszkatolowa_mielona_9g_20253696_0_173_200",
    "Kamis_KAMIS_GORCZYCA_BIALA_30G_62108238_0_173_200",
    "Kamis_KAMIS_Gozdziki_9G_62492475_0_173_200",
    "Kamis_KAMIS_GRILL_GRZANKI_ZLOCISTE_15G_61861878_0_173_200",
    "Kamis_KAMIS_GRILL_KLASYCZNY_25G_62040522_0_173_200",
    "Kamis_KAMIS_GRILL_KLASYCZNY_25G_62040522_0_173_200",
    "Kamis_KAMIS_GRILL_OGNISTE_SKRZYDELKA_25G_61821831_0_173_200",
    "Kamis_KAMIS_GRILL_PIKANTNY_25G_61877718_0_173_200",
    "Kamis_KAMIS_Grill_Pikantny_80g_XXL_39423264_0_173_200",
    "Kamis_KAMIS_GRILL_PRZYPR_DOKARKOWKI_20G_61814125_0_173_200",
    "Kamis_KAMIS_IMBIR_MIELONY_15G_62929229_0_173_200",
    "Kamis_KAMIS_KMINEK_CALY_15G_61129532_0_173_200",
    "Kamis_KAMIS_Kolendra_15g_44193159_0_173_200",
    "Kamis_KAMIS_Kurkuma_20g_41294562_0_173_200",
    "Kamis_KAMIS_LISCIE_LAUROWE_6G_63011225_0_173_200",
    "Kamis_KAMIS_MAJERANEK_8G_61691036_0_173_200",
    "Kamis_KAMIS_MARYNATA_STAROP_MIESDROB_20G_62125687_0_173_200",
    "Kamis_KAMIS_PAPRYKA_OSTRA_20G_61137527_0_173_200",
    "Kamis_KAMIS_PIEPRZ_BIALY_MIELONY_20G_61179057_0_173_200",
    "Kamis_KAMIS_PIEPRZ_CYTRYNOWY_20G_61188744_0_173_200",
    "Kamis_KAMIS_PIEPRZ_CZARNY_MIELONY_20G_61235099_0_173_200",
    "Kamis_KAMIS_PIEPRZ_ZIOLOWY_15G_61155388_0_173_200",
    "Kamis_KAMIS_PRZYPRAWA_DO_KURCZAKA_30G_61794616_0_173_200",
    "Kamis_KAMIS_PRZYPRAWA_DO_KURCZAKA_PO_STAROP_25G_61787867_0_173_200",
    "Kamis_KAMIS_PRZYPRAWA_DO_MIESA_MIELONEGO_20G_62429915_0_173_200",
    "Kamis_KAMIS_PRZYPRAWA_DO_OGORKOW_KONSERWOWYCH_35_G_41614942_0_173_200",
    "Kamis_KAMIS_PRZYPRAWA_DO_PAPRYKI_KONSERWOWEJ_30_G_41703471_0_173_200",
    "Kamis_KAMIS_ROZMARYN_15G_62921507_0_173_200",
    "Kamis_KAMIS_ZIELE_ANGIELSKIE_15G_63053698_0_173_200",
    "KNORR_KNORR_CURRY_20g_35905207_0_173_200",
    "KNORR_KNORR_CYNAMON_15g_35810316_0_173_200",
    "KNORR_KNORR_fix_carbonara_45g_45_g_23550577_0_173_200",
    "KNORR_KNORR_fix_danie_orientalne_z_kurczakiem_48_g_23629918_0_173_200", //--- error
    "KNORR_KNORR_fix_do_gulaszu_45g_45_g_23804354_0_173_200",
    "KNORR_KNORR_fix_do_kotl_miel_70g_70_g_23832264_0_173_200",
    "KNORR_KNORR_fix_do_potr_chinskich36g_36_g_23822257_0_173_200",
    "KNORR_KNORR_FIX_DO_SPAGHETTI_BOLOGNESE_44G_23814478_0_173_200",
    "KNORR_KNORR_FIX_DO_SPAGHETTI_NAPOLI_47G_23735418_0_173_200",
    "KNORR_KNORR_fix_golabki_bez_zaw_65g_65_g_23612070_0_173_200",
    "KNORR_KNORR_FIX_LASAGNE_56G_26281071_0_173_200",
    "KNORR_KNORR_FIX_LECZO_35g_52824927_0_173_200",
    "KNORR_KNORR_fix_rurkikurs_piecz_16_16_g_23688369_0_173_200",
    "KNORR_KNORR_FIX_SCHAB_ALA_STROGONOFF_56G_47241849_0_173_200",
    "KNORR_KNORR_GALKA_MUSZKATOLOWA_10g_49426265_0_173_200",
    "KNORR_KNORR_KMINEK_15g_34983031_0_173_200",
    "KNORR_KNORR_LISC_LAUROWY_5g_35518125_0_173_200",
    "KNORR_KNORR_MAJERANEK_8g_35009349_0_173_200",
    "KNORR_KNORR_NATURALNIE_SMACZNE_GULASZ_63G_59929927_0_173_200",
    "KNORR_KNORR_NATURALNIE_SMACZNE_KURCZAK_SMIETANOWO_-_ZIOLOWY_47g_43745009_0_173_200",
    "KNORR_KNORR_NATURALNIE_SMACZNE_SOS_SALATKOWY_KOPERKOWO-ZIOLOWY_9g_72503477_0_173_200",
    "KNORR_KNORR_NATURALNIE_SMACZNE_SOS_SALATKOWY_PAPRYKOWY_9g_94197225_0_173_200",
    "KNORR_KNORR_NATURALNIE_SMACZNE_SOS_SALATKOWY_TRUSKAWKA_Z_CHILI_9g_94217379_0_173_200",
    "KNORR_KNORR_NATURALNIE_SMACZNE_SOS_SALATKOWY_WLOSKI_9g_72511355_0_173_200",
    "KNORR_KNORR_NATURALNIE_SMACZNE_SOS_SALATKOWY_ZIOLA_OGRODOWE_9g_94205887_0_173_200",
    "KNORR_KNORR_NATURALNIE_SMACZNE_SPAGHETTI_BOLOGNESE_43G_59981431_0_173_200",
    "KNORR_KNORR_NATURALNIE_SMACZNE_ZAPIEKANKA_MAKARONOWA_Z_SZYNKA_44G_59955633_0_173_200",
    "KNORR_KNORR_NATURALNIE_SMACZNY_ZAPIEKANKA_ZIEMNIACZANA_52G_55761811_0_173_200",
    "KNORR_KNORR_OREGANO_10g_34923763_0_173_200",
    "KNORR_KNORR_PAPRYKA_OSTRA_20g_49451354_0_173_200",
    "KNORR_KNORR_PAPRYKA_SLODKA_20g_49443310_0_173_200",
    "KNORR_KNORR_PIEPRZ_CZARNY_MIELONY_16g_35486265_0_173_200",
    "KNORR_KNORR_PIEPRZ_CZARNY_ZIARNISTY_16g_34851998_0_173_200",
    "KNORR_KNORR_PRZYPAWA_DO_MIES_75g_100_NATURALNA_59069435_0_173_200",
    "KNORR_KNORR_przypr_do_mies_200g_200_g_24619215_0_173_200",
    "KNORR_KNORR_PRZYPRAWA_DO_GULASZU_23g_58781030_0_173_200",
    "KNORR_KNORR_PRZYPRAWA_DO_GYROSA_23g_58812272_0_173_200",
    "KNORR_KNORR_PRZYPRAWA_DO_KARKOWKI_23g_18331736_0_173_200",
    "KNORR_KNORR_PRZYPRAWA_DO_KURCZAK_23g_18398438_0_173_200",
    "KNORR_KNORR_PRZYPRAWA_DO_KURCZAKA_PO_PROWANSALSKU_23g_58943358_0_173_200",
    "KNORR_KNORR_przyprawa_do_mies_75g_24551285_0_173_200",
    "KNORR_KNORR_PRZYPRAWA_DO_MIESA_MIELONEGO_23g_62283494_0_173_200",
    "KNORR_KNORR_PRZYPRAWA_DO_PIKANTNEGO_KURCZAKA_23g_58978685_0_173_200",
    "KNORR_KNORR_PRZYPRAWA_DO_WIEPRZOWINY_23g_35953637_0_173_200",
    "KNORR_KNORR_PRZYPRAWA_DO_ZEBEREK_23g_35913284_0_173_200",
    "KNORR_KNORR_PRZYPRAWA_DO_ZLOTEGO_KURCZAKA_23g_63650634_0_173_200",
    "KNORR_KNORR_sos_do_piecz_jasny_25g_25_g_23517477_0_173_200",
    "KNORR_KNORR_sos_grzybowy_24g_24_g_23507619_0_173_200",
    "KNORR_KNORR_SOS_KOPERKOWO-ZIOLOWY_9G_23910730_0_173_200",
    "KNORR_KNORR_sos_pomidorowy_st_30g_30_g_23533177_0_173_200",
    "KNORR_KNORR_SOS_SALATKOWY_FRANCUSKI_8G_23920556_0_173_200",
    "KNORR_KNORR_SOS_SALATKOWY_GRECKI_9G_23880651_0_173_200",
    "KNORR_KNORR_st_sos_piecz_ciemny_30g_30_g_23525439_0_173_200",
    "KNORR_KNORR_ZIELE_ANGIELSKIE_15g_34812206_0_173_200",
    "KNORR_KNORR_ZIOLA_PROWANSALSKIE_10g_35862143_0_173_200",
    "KOTANYI_CZARNUSZKA_CALA_20G_KOTANYI_49464936_0_173_200",
    "KOTANYI_CZOSNEK_NIEDZWIEDZI_10G_KOTANYI_6_g_74749326_0_173_200",
    "KOTANYI_Kmin_rzymski_caly_-_Kumin_18g_26477521_0_173_200",
    "KOTANYI_KOT_GORCZYCA_ZOLTA_CALA_40G_KOTANYI_57911901_0_173_200",
    "KOTANYI_KOTA_GRILL_DO_KARKOWKI_22G_KOTANYI_12422721_0_173_200",
    "KOTANYI_KOTA_GRILL_DO_KURCZAKA_30G_KOTANYI_57839441_0_173_200",
    "KOTANYI_KOTA_PIEPRZ_CAYENNE_KOTANYI_20_G_57751471_0_173_200",
    "KOTANYI_Kotanyi_Czosnek_platki_15g_51659084_0_173_200",
    "KOTANYI_Kotanyi_mieszanka_przypraw_Pesto_z_grzybami_20g_52827052_0_173_200",
    "KOTANYI_Kotanyi_Pesto_z_pomidorami_i_bazylia_20g_52835048_0_173_200",
    "KOTANYI_Kotanyi_Pieprz_kolorowy_ziarnisty_16g_26505578_0_173_200",
    "KOTANYI_Kotanyi_Sekrety_kuchni_wloskiej_Aglio_e_olio_20g_52852993_0_173_200",
    "Kotanyi_Polonia_Sp_Z_O_O_ANYZ_CALY_24G_KOTANYI_POLONIA_SP_Z_O_O_45058708_0_173_200",
    "Kotanyi_Polonia_Sp_Z_O_O_CYNAMON_MIELONY_KOTANYI_POLONIA_SP_Z_O_O_18_g_63323398_0_173_200",
    "Kotanyi_Polonia_Sp_Z_O_O_CYNAMON_MIELONY_KOTANYI_POLONIA_SP_Z_O_O_18_g_64420912_0_173_200",
    "Kotanyi_Polonia_Sp_Z_O_O_GOZDZIKI_CALE_KOTANYI_POLONIA_SP_Z_O_O_12_g_59516948_0_173_200",
    "Kotanyi_Polonia_Sp_Z_O_O_Grill_DO_SZASZLYKOW_KOTANYI_POLONIA_SP_Z_O_O_30_g_58848003_0_173_200",
    "Kotanyi_Polonia_Sp_Z_O_O_KARDAMON_MIELONY_KOTANYI_POLONIA_SP_Z_O_O_10_g_81698375_0_173_200",
    "Kotanyi_Polonia_Sp_Z_O_O_KOT_GALKA_MUSZKATOLOWA_CALA_9G_KOTANYI_POLONIA_SP_Z_O_O_15_x_9_g_35830546_0_173_200",
    "Kotanyi_Polonia_Sp_Z_O_O_Kotanyi_Szafran_Oryginalny_0_12g_50878446_0_173_200",
    "KOTANYI_Zatar_mieszanka_przypraw_14g_47701214_0_173_200",
    "Prymat_ANYZ_NASIONA_20G_PRYMAT_36184794_0_173_200",
    "Prymat_BAZYLIA_10G_PRYMAT_54514138_0_173_200",
    "Prymat_CUKIER_Z_PRAWDZIWA_WANILIA_10G_PRYMAT_27956127_0_173_200",
    "Prymat_CYNAMON_MIELONY_PRYMAT_15G_64310915_0_173_200",
    "Prymat_CZABER_PRYMAT_10G_53161287_0_173_200",
    "Prymat_CZOSNEK_SUSZONY_20_G_PRYMAT_54522180_0_173_200",
    "Prymat_GALKA_MUSZKATOLOWA_MIELONA_10G_PRYMAT_39384185_0_173_200",
    "Prymat_GORCZYCA_BIALA_30G_PRYMAT_42547646_0_173_200",
    "Prymat_GRILL_KLASYCZNY_20G_PRYMAT_42445841_0_173_200",
    "Prymat_GRILL_PIKANTNY_20G_PRYMAT_42432567_0_173_200",
    "Prymat_GRILL_ZIOLOWY_20G_PRYMAT_23979180_0_173_200",
    "Prymat_KARDAMON_MIELONY_10G_PRYMAT_56742935_0_173_200",
    "Prymat_KEBAB-GYROS_70G_PRYMAT_70_g_42667899_0_173_200",
    "Prymat_KOLENDRA_CALA_15_G_PRYMAT_52418639_0_173_200",
    "Prymat_KOPEREK_SUSZONY_6G_PRYMAT_40180291_0_173_200",
    "Prymat_MARYNATA_KLASYCZNA_20G_PRYMAT_42773267_0_173_200",
    "Prymat_MARYNATA_PIKANTNA_20G_PRYMAT_42763441_0_173_200",
    "Prymat_PRZYPRAWA_DO_KURCZAKA_30_G_PRYMAT_55036198_0_173_200",
    "Prymat_PRZYPRAWA_DO_KURCZAKA_PIKANTNA_25_G_54605233_0_173_200",
    "Prymat_PRZYPRAWA_DO_RYB_20G_PRYMAT_44586055_0_173_200",
    "Prymat_PRZYPRAWA_DO_SALATEK_20G_PRYMAT_24045023_0_173_200",
    "Prymat_PRZYPRAWA_DO_STEKU_20G_PRYMAT_24151193_0_173_200",
    "Prymat_PRZYPRAWA_DO_ZIEMNIAKOW_I_FRYTEK_25G_PRYMAT_42655373_0_173_200",
    "Prymat_PRZYPRAWA_KEBAB-GYROS_30G_PRYMAT_44598399_0_173_200"]

let polishLanguage = true
// Mark: Detect 3D touch
let is3Dtouch = UIApplication.shared.keyWindow?.traitCollection.forceTouchCapability == UIForceTouchCapability.available
let bundleID = "pl.wroclaw.pwr.Przyprawy"
var segmentValues : [String] = ["product","producent"]


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("database.categoryArray.count przed : \(database.category.categoryArray.count)")
        database.loadData(tableNameType: .categories)
        print("database.categoryArray.count po : \(database.category.categoryArray.count)")
        
        print("database.basketProduct.basketProductArray.count przed : \(database.basketProduct.basketProductArray.count)")
        database.loadData(tableNameType: .basket)
        print("database.basketProduct.basketProductArray.count po : \(database.basketProduct.basketProductArray.count)")
        if database.category.categoryArray.count == 0 {
            var i=1
            for rec in categoriesData {
                database.addCategory(newCategoryValue: rec, idNumber: i)
                i+=1
            }
        }
        else {
            for cat in database.category.categoryArray {
                if cat.selectedCategory {
                    database.selectedCategory=cat
                }
            }
        }

        // Override point for customization after application launch.
        aboutSwiftVersion()
        return true
    }
    func aboutSwiftVersion() {
        #if swift(>=5.0)
        print("Version: Swift 5.0")
        
        #elseif swift(>=4.2)
        print("Version: Swift 4.2")
        
        #elseif swift(>=4.1)
        print("Version: Swift 4.1")
        
        #elseif swift(>=4.0)
        print("Version: Swift 4.0")
        
        #elseif swift(>=3.2)
        print("Version: Swift 3.2")
        
        #elseif swift(>=3.0)
        print("Version: Swift 3.0")
        
        #elseif swift(>=2.2)
        print("Version: Swift 2.2")
        
        #elseif swift(>=2.1)
        print("Version: Swift 2.1")
        
        #elseif swift(>=2.0)
        print("Version: Swift 2.0")
        
        #elseif swift(>=2.0)
        print("Version: Swift 2.0")
        
        #elseif swift(>=1.2)
        print("Version: Swift 1.2")
        
        #elseif swift(>=1.1)
        print("Version: Swift 1.1")
        
        #elseif swift(>=1.0)
        print("Version: Swift 1.0")
        
        #endif
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        coreData.saveContext()
    }
    
    
///   tu był corebData stack
    // Mark : 3D touch method
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if shortcutItem.type=="pl.wroclaw.pwr.Przyprawy.showPictures"{
            print("pl.wroclaw.pwr.Przyprawy.showPictures")
            let storyBoard:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
            let initViewController = storyBoard.instantiateViewController(withIdentifier: "3dtouch")
            self.window?.rootViewController=initViewController
            self.window?.makeKeyAndVisible()
        }
    }
 
}

