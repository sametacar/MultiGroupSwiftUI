//
//  Lesson2.swift
//  swiftui-odev
//
//  Created by vili on 19.08.2025.
//

import Foundation

enum Islem {
    case toplama, cikarma, carpma, bolme
}

func toplama(a: Double, b: Double) -> Double {
    return (a + b)
}

func cikarma(a: Double, b: Double) -> Double {
    return (a - b)
}

func carpma(a: Double, b: Double) -> Double {
    return (a * b)
}

func bolme(a: Double, b: Double) -> Double {
    return (a / b)
}

func hesap(a: Double, b: Double, islem: Islem) -> Double {
    switch islem {
    case .toplama:
        return toplama(a: a, b: b)
    case .cikarma:
        return cikarma(a: a, b: b)
    case .carpma:
        return carpma(a: a, b: b)
    case .bolme:
        return bolme(a: a, b: b)
    }
}

func runLesson2_HesapMakinesi() {
    print(hesap(a: 10, b: 5, islem: .toplama))
    print(hesap(a: 10, b: 5, islem: .cikarma))
    print(hesap(a: 10, b: 5, islem: .carpma))
    print(hesap(a: 10, b: 5, islem: .bolme))
}


//  2. Bölüm

let sayilar = [5, 7, 2, 9, 1, 6, 10, 3, 8, 4]

func runLesson2_FiltreleSirala() {
    // Çift sayıları filtrele
    let ciftSayilar = sayilar.filter { $0 % 2 == 0 }
    let sortedCiftSayilar = ciftSayilar.sorted { $0 < $1 }
    print("Sıralı çift sayılar:", sortedCiftSayilar)
}
