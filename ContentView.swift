//
//  ContentView.swift
//  UnitConversionAppSwiftUI
//
//  Created by Vladlens Kukjans on 03/04/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputNumber = 0.0
    @State private var selectedUnit = 0
    @State private var inputUnit: Dimension = UnitLength.kilometers
    @State private var outputUnit: Dimension = UnitLength.meters
    @FocusState private var inputIsFocused: Bool
    
    
    //var units: [UnitLength] = [.meters, .miles, .kilometers, .feet, .yards]
    let forrmater: MeasurementFormatter
    
    let conversion = ["Distance", "Mass", "Temperature", "Time"]
    
    let unitType = [
        [UnitLength.feet, UnitLength.meters, UnitLength.kilometers, UnitLength.millimeters, UnitLength.yards ],
        [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]
    ]
    
    var result: String {
        let inputMeasurments = Measurement(value: inputNumber, unit: inputUnit)
        let outputMeasurments = inputMeasurments.converted(to: outputUnit)
        return forrmater.string(from: outputMeasurments)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter number", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Amount to convert")
                }
                
                Section {
                    Picker("Conversion", selection: $selectedUnit) {
                        ForEach(0..<conversion.count) {
                            Text(conversion[$0])
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                   Text("Select your measurments")
                }
                
                Section {
                    Picker("Convert From", selection: $inputUnit) {
                        ForEach(unitType[selectedUnit], id: \.self) {
                            Text(forrmater.string(from: $0).capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert From")
                }
                Section {
                    Picker("Convert To", selection: $outputUnit) {
                        ForEach(unitType[selectedUnit], id: \.self) {
                            Text(forrmater.string(from: $0).capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert To")
                }
                
                Section {
                    Text(result)
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
            .onChange(of: selectedUnit) { newSelection in
                let units = unitType[newSelection]
                inputUnit = units[0]
                outputUnit = units[1]
            }
        }
        
    }
    init() {
        forrmater = MeasurementFormatter()
        forrmater.unitOptions = .providedUnit
        forrmater.unitStyle = .long
    }
    
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


