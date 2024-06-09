import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllStrings{
    String vakanuvis = "Vakanüvis";
    String user_email = "Email";
    String user_password = "Parola";
    String user_password_retry = "Parola doğrula";
    String dont_match_password = "Parolalar uyuşmuyor";
    String enter = "Giriş yap";
    String register = "Kayıt ol";
    String or = "ya da";
    String admin = "Admin";
    String query = "Sorgula";
    String host = "Host";
    String save = "Kaydet";
    String host_save = "Host kaydedildi.";
    String host_not_empty = "Host boş olamaz.";
    String check_email = "Email boş olamaz";
    String check_password = "Parola boş olamaz";
    String enter_info = "Boş alanları doldurun";
    String online_user = "Kullanıcı: ";
    String write = "Kılıcın parlattığı, Kalemin aydınlattığı";
    String choose_option = "İşlem seç";
    String exit = "Çıkış yap";
    String cancel = "İptal";
    String home = "Ana Sayfa";
    String full_query = "Rapor Sorgu";
    String person_query = "Kişi Sorgu";
    String family_query = "Aile Sorgu";
    String address_query = "Adres Sorgu";
    String phone_query = "Telefon Sorgu";
    String school_query = "Okul Sorgu";
    String school_query_2 = "Okul Sorgu2";
    String iban_query = "İban Sorgu";
    String ip_query = "İp Sorgu";
    String long_query = "Sorgu uzun sürebilir.";
    String chech_id = "TC boş olamaz.";
    String chech_ip = "IP boş olamaz.";
    String enter_public_ip = "IP Public olmalı.";
    String check_iban = "İban boş olamaz.";
    String empty_value = "Sonuç bulunamadı :(";
    String not_use_zero = "Başında 0 olmasın.";
    String not_use_space = "İbandaki boşlukları silin.";
    String not_found_query = "Sorgu bulunamadı.";

    //Images path
    String logo = "assets/images/dragon_logo.png";


    //Snackbar
    void showSnackBar(BuildContext context, String message) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            duration: Duration(milliseconds: 2000),
        ));
    }
    //Progres Dialog
    void showProgressDialog(BuildContext context) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
                return Center(
                    child: CircularProgressIndicator(),
                );
            },
        );
    }
    void hideProgressDialog(BuildContext context) {
        Navigator.of(context, rootNavigator: true).pop();
    }
}