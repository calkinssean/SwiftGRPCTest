//
//  ContentView.swift
//  SwiftGPRCTest
//
//  Created by Sean Calkins on 1/29/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            TextField("Enter your message", text: $viewModel.greetingText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                viewModel.sendEchoRequest()
            }) {
                Text("Send message")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
            Button(action: {
                viewModel.getHardcodedResponse() 
            }) {
                Text("Get hardcoded message")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
            Text(viewModel.responseText)
                .padding()
                .font(.title2)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
