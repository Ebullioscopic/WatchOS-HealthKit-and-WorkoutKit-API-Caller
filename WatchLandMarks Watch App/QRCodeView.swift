////
////  QRCodeView.swift
////  WatchLandMarks Watch App
////
////  Created by hariharan on 25/08/24.
////
//
//import SwiftUI
//
//struct QRCodeView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    QRCodeView()
//}
// QRCodeView.swift
// WatchLandMarks Watch App
//
// Created by hariharan on 18/08/24.
//

import SwiftUI

struct QRCodeView: View {
    let qrCodeImage: UIImage
    
    var body: some View {
        Image(uiImage: qrCodeImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
    }
}
