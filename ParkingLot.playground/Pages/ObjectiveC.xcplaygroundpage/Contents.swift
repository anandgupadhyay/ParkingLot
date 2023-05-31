//: [Previous](@previous)

import Foundation

struct MyStruct {
    var myVar = "myVar"
    let myLet = "myLet"
    
    mutating func change(some: MyStruct){
        self = some
    }
    
    mutating func changeMyVar(newV : String)
    {
        self.myVar = newV
    }
}

func testMutateString() {
    //given
    var myStruct = MyStruct()
    print("0: \(myStruct.myVar)")
    myStruct.myVar = "Something"
    print("1: \(myStruct.myVar)")
    
    //Change var
    //when
    var myStructCopy = myStruct
    myStructCopy.myVar = "Nothing"
    print("2: \(myStructCopy.myVar)")
    print("3: \(myStruct.myVar)")
    //then
    
    var some = MyStruct()
    some.myVar = "Anand"
//    some.myLet = "Upadhyay"
    myStruct.change(some: some)
    print("4: \(myStruct.myVar)")
    
    myStruct.changeMyVar(newV: "Upadhyay")
    print("5: \(myStruct.myVar)")
    //XCTAssert(myStructCopy.myVar == "myVar changed 1")
    
    //Change let
    //when
//    withUnsafeMutableBytes(of: &myStructCopy) { bytes in
//        let offset = MemoryLayout.offset(of: \MyStruct.myLet)!
//        let rawPointerToValue = bytes.baseAddress! + offset
//        let pointerToValue = rawPointerToValue.assumingMemoryBound(to: String.self)
//        pointerToValue.pointee = "myLet changed"
//    }
    
    //then
//    XCTAssert(myStructCopy.myLet == "myLet changed")
}

testMutateString()

/*
What is Objective-C and how does it differ from C and C++?

Objective-C is a programming language that adds object-oriented capabilities to the C programming language. It differs from C and C++ by adding object-oriented features like classes, objects, messaging syntax, and dynamic runtime.
What is the difference between a class method and an instance method?

A class method is associated with the class itself, while an instance method is associated with an instance of the class. Class methods are called on the class itself using the class name, while instance methods are called on instances of the class.
What is a protocol in Objective-C?

A protocol is a list of method declarations that can be adopted by a class. It defines a set of methods that an object can implement to fulfill a certain behavior or contract. Protocols allow for code reusability and enable objects of different classes to communicate with each other.
How do you define properties in Objective-C?

Properties in Objective-C are defined using the @property keyword in the interface or implementation file. They are used to declare the accessors (getters and setters) for instance variables and provide a convenient way to encapsulate data within an object.
What are the memory management rules in Objective-C?

Objective-C follows manual memory management using reference counting. The rules include retaining an object when it is needed, releasing it when no longer needed, and balancing retains and releases to avoid memory leaks.
Explain the difference between retain, strong, weak, and copy in property attributes.

retain and strong both indicate ownership of an object and increase its retain count. weak creates a non-owning reference that automatically becomes nil when the object it points to is deallocated. copy creates a new copy of the object when assigning the property, ensuring immutability.
How does ARC (Automatic Reference Counting) work in Objective-C?

ARC is a memory management mechanism that automatically inserts retain, release, and autorelease messages at compile time based on the inferred ownership of objects. It helps manage the memory of Objective-C objects, reducing the need for manual memory management.
What are the different types of data encapsulation in Objective-C?

Objective-C supports data encapsulation through the use of properties, which allow you to control the access to instance variables by defining custom getter and setter methods.
What are delegates and how are they used in Objective-C?

Delegates are a design pattern used in Objective-C to allow one object to communicate with and control another object. They are typically implemented using protocols, where the delegate object conforms to the protocol and implements the required methods to receive callbacks and handle events from the delegating object.
What is the difference between categories and extensions in Objective-C?

Categories allow you to add methods to an existing class, even if you don't have access to the original class implementation. Extensions, on the other hand, are used to add private properties and methods to a class within its own implementation file.
Explain the concept of method swizzling in Objective-C.

Method swizzling is a technique in Objective-C that allows you to change the implementation of a method dynamically at runtime. It involves swapping the implementations of two methods, usually for the purpose of extending or modifying the behavior of existing classes or frameworks.
How do you handle exceptions in Objective-C?

Objective-C provides exception handling using the @try, @catch, and @finally keywords. Exceptions can be thrown using the NSException class or custom exception classes.
What is KVC (Key-Value Coding) and KVO (Key-Value Observing) in Objective-C?

Key-Value Coding (KVC) allows you to access and manipulate an object's properties indirectly by using string-based keys. Key-Value Observing (KVO) allows you to observe changes to an object's properties and receive notifications when those properties change.
What are blocks in Objective-C? How are they used?

Blocks are a language-level feature introduced in Objective-C that allows you to create and use anonymous functions. They encapsulate a unit of code that can be passed around and executed later. Blocks are commonly used for asynchronous and callback-based programming.
What is the purpose of the @synthesize directive in Objective-C?

The @synthesize directive is used to automatically generate the getter and setter methods for a property declared in a class. In modern Objective-C, the @synthesize directive is no longer required, as the compiler automatically synthesizes the accessor methods.
How do you create a singleton class in Objective-C?

To create a singleton class in Objective-C, you can use a shared instance method that returns a static instance of the class. This ensures that only one instance of the class exists throughout the application.
What are the benefits of using Objective-C over Swift?

Objective-C has a larger codebase and a longer history, making it easier to find resources and third-party libraries. It also has broader support for older iOS and macOS versions. Additionally, if you're working on a project with existing Objective-C code, using Objective-C allows for seamless interoperability.
How do you work with multithreading in Objective-C?

Objective-C provides various APIs for multithreading, such as NSThread, NSOperation, and GCD (Grand Central Dispatch). These APIs allow you to perform tasks concurrently, synchronize access to shared resources, and handle thread synchronization and communication.
Explain the difference between shallow copy and deep copy.

Shallow copy creates a new object that points to the same memory location as the original object. Deep copy creates a new object with its own memory, recursively copying all the objects it contains. Modifying the original object after a shallow copy can affect the copied object, while a deep copy remains independent.
How do you handle memory leaks in Objective-C?

Memory leaks can be avoided by adhering to proper memory management practices, such as releasing objects when no longer needed and avoiding retain cycles. Additionally, using Automatic Reference Counting (ARC) helps in managing memory automatically.
What is the purpose of the @autoreleasepool block in Objective-C?

The @autoreleasepool block is used to create a local autorelease pool. It helps manage the memory footprint by automatically releasing objects that are no longer needed within the block.
How do you handle data persistence in Objective-C?

Objective-C provides several options for data persistence, including NSUserDefaults for storing preferences, NSKeyedArchiver and NSKeyedUnarchiver for archiving and unarchiving objects, and Core Data for managing complex object graphs and relational data.
Explain the concept of method overriding in Objective-C.

Method overriding is the ability to provide a different implementation of a method in a subclass that is already defined in its superclass. This allows the subclass to customize the behavior of inherited methods to suit its specific requirements.
How do you handle notifications in Objective-C?

Objective-C provides the NSNotificationCenter class for handling notifications. You can register observers to listen for specific notifications and perform actions when those notifications are posted.
What are the best practices for naming conventions in Objective-C?

Objective-C follows a naming convention called "camel case with prefixes" where class names start with an uppercase letter and use a prefix (e.g., NSString, NSArray). Method names and variables start with a lowercase letter and use camel case (e.g., doSomething, myVariable). It is also common to use descriptive and meaningful names for clarity.

*/
