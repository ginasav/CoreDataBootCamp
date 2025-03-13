## CoreData Bootcamp

Resource: https://www.youtube.com/watch?v=BPQkpxtgalY

Here we're gonna explore how to use CoreData with an MVVM product.
We could use a @FetchRequest, but it would not be feasible when we have a very complex app, with Models and ViewModels.

1. - Create a CoreDataViewModel, which should respond to the `ObservableObject` protocol.
2. - Initialize a variable of the class `CoreDataViewModel()'` in the view we need to call the CoreDataVM.
3. - Create inside the `CoreDataViewModel class` the actual persistent container of the type `NSPersistentContainer`
4. - We are still inside the `CoreDataViewModel class`: we need to create the persistent container, which we'll use to call the function `.loadPersistentStore` and here we'll write some code to handle potential errors.

These 4 steps are all we need to load CoreData in our project.

Now, let's create our CoreData model:
- right-click on the navigator bar
- "New File from Template" and choose "Data Model"
- name the file (I suggest to name it like: "nameContainer", so you know when you call it, it's the container).
    BE CAREFUL: make sure the right group it's selected in this phase
- choose always the extension .xcdatamodeld

Inside this .xcdatamodeld file, create your `Entity`. Treat it as a struct: it is the "blueprint" of the future entities of that kind.
In this example, I'm working with "fruits", so:
- the .xcdatamodeld is called "FruitsContainer"
- my Entity will be called "FruitEntity

Now: **don't forget to link the xcdatamodeld to the container you created inside the CoreDataViewModel class**
**IT NEEDS TO HAVE THE SAME EXACT NAME YOU GAVE!!!!**

At this point of the process, try to build the project and see what the console tells you.
If it prints the "success" message you gave on the error handler, we're fine to go!

## Fetch what we have!

So now that CoreData is settled, let's actually fetch what we have inside the Container.

We can do that with a `@FetchRequest` inside the view where we need the data, or we can do what I'm gonna write down.

*Why? You might ask!*. Well, our projects will be almost always an MVVP, so very complex projects, and the @FetchRequest is just a lot of code inside the View files.

**when you do this operation, you might want to save, quit and re-open Xcode, sometimes it's buggy :)**

So, inside the `CoreDataViewModel class` create a `fetch` function, maybe after the `init()`, to be clean.
Here we are going to create the variable for the request and then the actual call.
The call needs to inserted in a `do - catch` flow, to spot errors. That's why you need to `try` the request. 
See *code line 29* of CoreDataViewModel.swift.

Here, we are just fetching, but where we save it? Let's create a `@Published` variable inside the class.

Now let's call the function `fetchFruits()` inside the `init()`.

But, we don't have any fruit so let's create them with a function and let's save them!
See *line 42 - 57*

Little detail: when we save the data, we need to update the @Published variable savedEntities. In the way we wrote the code, the quickest way to do it is to call `fetchFruits()` again, 'cause everytime we call it, it tries to fetch the data inside the container and save them inside the variable.

--------------------------------------------------------------------
## UI SETUP

Let's move in our ContentView. Here, just copy the code, it's not important to explain. I think you're navigated in this more then me :)

NOw, everything is set up! Try the app, try to kill the process and re-open.
The fruits you added should always be there!! YAYYY

For the sake of being complete, I added the delete and update function.
For the Constellation project, we don't need them, but if you want to experiment with the CoreData, here they are!

Happy coding everyone!

-G.
