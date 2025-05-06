
import SwiftUI


struct Uitgave: Identifiable {
    let id = UUID()
    let categorie: String
    let bedrag: Double
}

struct ContentView: View {
    // Voorbeelduitgaven
    @State private var uitgaven: [Uitgave] = [
        Uitgave(categorie: "Boodschappen", bedrag: 45.50),
        Uitgave(categorie: "Huur", bedrag: 750.00),
        Uitgave(categorie: "Internet", bedrag: 40.00)
    ]
    
    
    @State private var nieuweCategorie = ""
    @State private var nieuwBedrag = ""

    var totaal: Double {
        uitgaven.reduce(0) { $0 + $1.bedrag }
    }

    var body: some View {
        NavigationView {
            VStack {
                List(uitgaven) { uitgave in
                    HStack {
                        Text(uitgave.categorie)
                        Spacer()
                        Text("€\(uitgave.bedrag, specifier: "%.2f")")
                    }
                }

                HStack {
                    TextField("Categorie", text: $nieuweCategorie)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Bedrag", text: $nieuwBedrag)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    Button("Voeg toe")
                        {
                        if let bedrag = Double(nieuwBedrag), !nieuweCategorie.isEmpty {
                            let nieuweUitgave = Uitgave(categorie: nieuweCategorie, bedrag: bedrag)
                            uitgaven.append(nieuweUitgave)
                            nieuweCategorie = ""
                            nieuwBedrag = ""
                        }
                    }
                }
                .padding()

                Text("Totaal: €\(totaal, specifier: "%.2f")")
                    .font(.headline)
                    .padding()

                Spacer()
            }
            .navigationTitle("Uitgavenoverzicht")
        }
    }
}

#Preview {
    ContentView()
}
