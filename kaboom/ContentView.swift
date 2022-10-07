//
//  ContentView.swift
//  kaboom
//
//  Created by Nurzhan Ababakirov on 4/4/22.
//

import SwiftUI

enum BombState{
    case exploded, deffused, beingDeffused
}
struct ContentView: View {
    @State var btn1Presses: Int = Int.random(in: 0...5)
    @State var btn1Pressed: Int = 0
    @State var btn2Presses: Int = Int.random(in: 0...5)
    @State var btn2Pressed: Int = 0
    @State var btn3Presses: Int = Int.random(in: 0...5)
    @State var btn3Pressed: Int = 0
    
    @State var codeWords = ""
    @State var redWireConnected = true
    @State var greenWireConnected = true
    @State var blueWireConnected = true
    @State var password = ""
    @State var bombState = BombState.beingDeffused
    
    func restart(){
        btn1Presses = Int.random(in: 0...5)
        btn1Pressed = 0
        btn2Presses = Int.random(in: 0...5)
        btn2Pressed = 0
        btn3Presses = Int.random(in: 0...5)
        btn3Pressed = 0
        
        bombState = .beingDeffused
    }
    func generateInstructions() -> String {
        var instructions: [String] = []
        

        if (btn1Presses > 0) {
            instructions.append("Press 'Button 1' \(btn1Presses) \(btn1Presses == 1 ? "time" : "times")")
        }

        if (btn2Presses > 0) {
            instructions.append("Press 'Button 2' \(btn2Presses) \(btn2Presses == 1 ? "time" : "times")")
        }

        if (btn3Presses > 0) {
            instructions.append("Press 'Button 3' \(btn3Presses) \(btn3Presses == 1 ? "time" : "times")")
        }
        instructions.append("Enter code word: 'Code is simple'")
        instructions.append("Disconnect green wire")
        instructions.append("Password is: 'Qwerty123'")
        
        return instructions.joined(separator: ". ")

    }
    
    func deffuse(){
        if btn1Pressed == btn1Presses &&
            btn2Pressed == btn2Presses &&
            btn3Pressed == btn3Presses &&
            codeWords == "Code is simple" &&
            password == "Qwerty123" &&
            greenWireConnected == false
        {
            bombState = .deffused
        } else {
            bombState = .exploded
        }
        
        
    }
    
    var body: some View {
        VStack {
            Text("Kaboom").padding().font(.title)
        

        Form {
            switch bombState {
            case .exploded:
                Image("Explosion").resizable().aspectRatio(contentMode: .fit)
            case .deffused:
                Image(systemName: "peacesign").resizable().aspectRatio(contentMode: .fit).foregroundColor(.green)
                Text("Press 'Restart' to try again")
            case .beingDeffused:
            Text("Disarm the bomb by following instructions").padding()
                Text(generateInstructions())
            HStack{
                Spacer()
                Button("1"){
                        btn1Pressed += 1
                    }.buttonStyle(.borderedProminent)
                Button("2"){
                        btn2Pressed += 1
                    }.buttonStyle(.borderedProminent)
                Button("3"){
                        btn3Pressed += 1
                    }.buttonStyle(.borderedProminent)
                Spacer()
                }
                TextField("Code Words", text: $codeWords)
                Toggle(isOn: $redWireConnected) {
                    if redWireConnected == true{
                        Text("Red wire is connected").foregroundColor(.red)
                    } else{
                        Text("Red wire is disconnected").foregroundColor(.gray)
                    }

                }
                Toggle(isOn: $greenWireConnected) {
                    if greenWireConnected == true{
                        Text("Green wire is connected").foregroundColor(.green)
                    } else{
                        Text("Green wire is disconnected").foregroundColor(.gray)
                    }
                }
                Toggle(isOn: $blueWireConnected) {
                    if blueWireConnected == true{
                        Text("Blue wire is connected").foregroundColor(.blue)
                    } else{
                        Text("Blue wire is disconnected").foregroundColor(.gray)
                    }

                }
                SecureField("Password", text: $password)
            }
            HStack(spacing: 40) {
                Spacer()
                if (bombState == .beingDeffused){
                    Button("Deffuse", role: .destructive){
                        deffuse()
                    }.buttonStyle(.borderedProminent)
                }
                Button("Restart"){
                    restart()
                    
                }.buttonStyle(.borderedProminent)
                Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ContentView()
        }
    }
}
