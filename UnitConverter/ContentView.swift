//
//  ContentView.swift
//  UnitConverter
//
//  Created by Brent Yazel on 11/21/26.
//
//  From 100 Days of SwiftUI by Paul Hudson
//  Day 18 Challenge
//  Version 1.0
//  https://www.hackingwithswift.com/100/swiftui

import SwiftUI

struct ContentView: View {
    @State private var tempUnit: UnitTemperature = .fahrenheit
    @State private var temp: Double? = nil
    private var convertedTemp: Double? {
        if let temp = temp {
            switch tempUnit {
            case .fahrenheit:
                switch convertedUnit {
                case .fahrenheit:
                    return temp
                case .celsius:
                    return (temp - 32) * 5 / 9
                case .kelvin:
                    return (temp - 32) * 5 / 9 + 273.15
                default:
                    return nil
                }
            case .celsius:
                switch convertedUnit {
                case .fahrenheit:
                    return (temp * 9/5) + 32
                case .celsius:
                    return temp
                case .kelvin:
                    return temp + 273.15
                default:
                    return nil
                }
            case .kelvin:
                switch convertedUnit {
                case .fahrenheit:
                    return (temp - 273.15) * 9 / 5 + 32
                case .celsius:
                    return temp - 273.1
                case .kelvin:
                    return temp
                default:
                    return nil
                }
            default:
                return nil
            }
        } else {
            return nil
        }
    }
    @State private var convertedUnit: UnitTemperature = .fahrenheit
    @FocusState private var tempFocus: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section ("Input Temperature") {
                    VStack {
                        TextField("Degrees \(tempUnit.symbol)", value: $temp, format: .number.precision(.fractionLength(0...2)))
                            .keyboardType(.decimalPad)
                            .focused($tempFocus)
                        
                        Picker("", selection: $tempUnit){
                            Text("Fahrenheit").tag(UnitTemperature.fahrenheit)
                            Text("Celsius").tag(UnitTemperature.celsius)
                            Text("Kelvin").tag(UnitTemperature.kelvin)
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                Section ("Converted Temperature") {
                    VStack {
                        Text(convertedTemp?.formatted(.number.precision(.fractionLength(2))) ?? "Degrees \(convertedUnit.symbol)")
                            .foregroundStyle(convertedTemp == nil ? .tertiary : .primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Picker("", selection: $convertedUnit){
                            Text("Fahrenheit").tag(UnitTemperature.fahrenheit)
                            Text("Celsius").tag(UnitTemperature.celsius)
                            Text("Kelvin").tag(UnitTemperature.kelvin)
                        }
                        .pickerStyle(.segmented)
                    }
                }
            }
            .navigationTitle("UnitConverter")
            .toolbar {
                if tempFocus {
                    Button("Done") {
                        tempFocus = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
