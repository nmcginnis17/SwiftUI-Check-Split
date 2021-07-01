//
//  ContentView.swift
//  SwiftUIPractice
//
//  Created by Nicholas McGinnis on 6/30/21.
//

import SwiftUI

struct ContentView: View {
	
	@State private var checkAmount = ""
	@State private var numberOfPeople = 0
	@State private var tipPercent = 1
	
	let tipPercentages = [15, 18, 20, 22, 0]
	
	var totalPerPerson: Double {
		let peopleCount = Double(numberOfPeople + 2)
		let tipSelection = Double(tipPercentages[tipPercent])
		let orderAmount = Double(checkAmount) ?? 0
		
		let tipValue = orderAmount / 100 * tipSelection
		let grandTotal = orderAmount + tipValue
		let amountPerPerson = grandTotal / peopleCount
		
		return amountPerPerson
	}
	
    var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Check Amount", text: $checkAmount)
						.keyboardType(.decimalPad)
											
					Picker("Number of People", selection: $numberOfPeople) {
						ForEach(2..<101) {
							Text("\($0) people")
						}
					}
				}
				
				Section(header: Text("Tip Percentage")) {
					Picker("Tip Percentage", selection: $tipPercent) {
						ForEach(0..<tipPercentages.count) {
							Text("\(self.tipPercentages[$0])%")
						}
					}
					.pickerStyle(SegmentedPickerStyle())
				}
				
				Section {
					Text("$\(totalPerPerson, specifier: "%.2f")")
					Button("Done") {
							UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
					}
				}
			}
			.navigationTitle("Split Check")
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
			
    }
}
