# FRDSD
FetchRequest Dynamic SortDescriptor


I have a list with items that contain a title and a date. User can set what to sort on (title or date).

However I can't figure out how to change the NSSortDescriptor dynamically.


When I change

`@FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Test.title, ascending: true)], animation: .default) private var items: FetchedResults<Test>`

to

`@FetchRequest(sortDescriptors: [sortDescriptor], animation: .default) private var items: FetchedResults<Test>`

the error "Cannot use instance member 'sortDescriptor' within property initializer; property initializers run before 'self' is available" appears.

I also tried to store the NSSortDescriptor in a UserDefault and create an init that creates it's own FetchRequest.. still no dynamic sorting...

Anyone a pointer where to look to solve this problem?



Asked:
- https://stackoverflow.com/questions/63687731/swiftui-and-dynamic-nssortdescriptors-in-fetchrequest
- https://developer.apple.com/forums/thread/659042
