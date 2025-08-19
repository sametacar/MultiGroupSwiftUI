//
//  Lesson1.swift
//  swiftui-odev
//
//  Created by vili on 19.08.2025.
//
import Foundation

enum Cinsiyet: String {
    case kadin = "Kadın"
    case erkek = "Erkek"
}

struct Kunye {
    var isim: String = "Samet"
    var ikinciIsim: String?
    var soyIsim: String = "Acar"
    var yas: Int = 40
    var cinsiyet: Cinsiyet = Cinsiyet.erkek
    var turkVatandasi: Bool = true
    var boy: Double = 1.87
}

let kisi = Kunye()

func runLesson1() {
    print("-- Lesson 1 --")
    print("İsim soyisim: \(kisi.isim + (" " + (kisi.ikinciIsim ?? "")) + " " + kisi.soyIsim)")
    print("boy: \(kisi.boy) yaş: \(kisi.yas)")
    
}
