//
//  ProgressBar.swift
//  Cat or dog?
//
//  Created by Adityaa Mehra on 13/07/21.
//

import SwiftUI

struct ProgressBar: View {
    var value:Double
    var meterColor:Color{
        if value > 0.35{
            return .green
        }else if value > 0.2{
            return Color(UIColor.systemTeal)
        } else if value > 0.05{
            return .orange
        }else{
            return .red
        }
    }
    var body: some View {
        GeometryReader{geo in
            ZStack(alignment: .leading){
                Rectangle().frame(width: geo.size.width  ,height: geo.size.height).opacity(0.3).foregroundColor(.gray)
                
                Rectangle().frame(width: CGFloat(self.value) * geo.size.width, height: geo.size.height).foregroundColor(meterColor)
            }.cornerRadius(45)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: 0.7).previewLayout(.fixed(width: 300, height: 10))
    }
}
