import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @AppStorage("firstLaunch") var firstLaunch: Bool = true
    @State var sortDescriptor: NSSortDescriptor = NSSortDescriptor(keyPath: \Test.title, ascending: true)
    @State private var sortType: Int = 0

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

        ListView(sortDescripter: sortDescriptor)

        .onAppear(perform: {
            if firstLaunch == true {
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

                firstLaunch = false
            }
        })
    }
}

struct ListView: View {
    @FetchRequest var items: FetchedResults<Test>
    @Environment(\.managedObjectContext) var viewContext

    init(sortDescripter: NSSortDescriptor) {
        let request: NSFetchRequest<Test> = Test.fetchRequest()
        request.sortDescriptors = [sortDescripter]
        _items = FetchRequest<Test>(fetchRequest: request)
    }

    var body: some View {
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
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()
