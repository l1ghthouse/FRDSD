import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [sortDescriptor], animation: .default) private var items: FetchedResults<Test>

    @State private var sortType: Int = 0
    @State private var sortDescriptor: NSSortDescriptor = NSSortDescriptor(keyPath: \Test.title, ascending: true)

    var body: some View {
        Picker(selection: $sortType, label: Text("Sort")) {
            Text("Title").tag(0)
            Text("Date").tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: sortType) { value in
            sortType = value

            if sortType == 0 {
                sortDescriptor = NSSortDescriptor(keyPath: \Test.title, ascending: true)
            } else {
                sortDescriptor = NSSortDescriptor(keyPath: \Test.date, ascending: true)
            }
        }

        List {
            ForEach(items) { item in
                let dateString = itemFormatter.string(from: item.date!)
                HStack {
                    Text(item.title!)
                    Spacer()
                    Text(dateString)
                }
            }
        }

        .onAppear(perform: {
            if items.isEmpty {
                let newEntry1 = Test(context: self.viewContext)
                newEntry1.title = "Apple"
                newEntry1.date = Date(timeIntervalSince1970: 197200800)

                let newEntry2 = Test(context: self.viewContext)
                newEntry2.title = "Microsoft"
                newEntry2.date = Date(timeIntervalSince1970: 168429600)

                let newEntry3 = Test(context: self.viewContext)
                newEntry3.title = "Google"
                newEntry3.date = Date(timeIntervalSince1970: 904903200)

                let newEntry4 = Test(context: self.viewContext)
                newEntry4.title = "Amazon"
                newEntry4.date = Date(timeIntervalSince1970: 773402400)

                if self.viewContext.hasChanges {
                    try? self.viewContext.save()
                }
            }
        })
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()
