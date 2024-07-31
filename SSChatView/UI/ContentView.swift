//
//  ContentView.swift
//  SSChatView
//
//  Created by Palak Doshi on 13/07/23.
//

import SwiftUI

struct ContentView: View {

    // MARK: - Variables
    @State var isBlurred = false

    // MARK: - Body
    var body: some View {
        VStack {
            ChatScreenView(isBlurred: $isBlurred)
        }
        .background(SystemColors.primaryBackground.ignoresSafeArea(.all, edges: .all))
        .ignoresSafeArea(.all, edges: .top)
        .onTapGesture {
            isBlurred = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
