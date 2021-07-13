//
//  AnimalRow.swift
//  Cat or dog?
//
//  Created by Adityaa Mehra on 13/07/21.
//

import SwiftUI

struct AnimalRow: View {
    var ImageLabel:String
    var confidence:Double
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(.white).cornerRadius(10).shadow(color: .gray, radius: 5, x: 0, y: 5)
            VStack {
                HStack{
                    Text(ImageLabel).bold()
                    Spacer()
                    Text(String(format: "%.2f%%", confidence * 100)).bold()
                }
                ProgressBar(value: confidence).frame(height: 10)
            }.padding(10)
        }
    }
}

struct AnimalRow_Previews: PreviewProvider {
    static var previews: some View {
        AnimalRow(ImageLabel: "Husky", confidence: 0.23).previewLayout(.fixed(width: 300, height: 70))
    }
}
