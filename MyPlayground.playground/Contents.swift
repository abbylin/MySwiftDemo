//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples"
let fruitSummary = "I have \(apples + oranges) pieces of fruit"
let optionalInt: Int? = 9
let actualInt: Int = optionalInt!
var myString = "7"
var possibleInt = Int(myString)
print(possibleInt)
myString = "banana"
possibleInt = Int(myString)
print(possibleInt)
let emptyArray = [String]()

var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName
{
    greeting = "Hello, \(name)"
}

var optionalHello: String? = "Hello"
optionalHello! = "你好"
if let hello = optionalHello where hello.hasPrefix("H"), let name = optionalName
{
    greeting = "\(hello), \(name)"
}

var firstForLoop = 0
for i in 0..<4
{
    firstForLoop += i
}
print(firstForLoop)

func greet(name: String, day: String) -> String
{
    return "Hello \(name), today is \(day)"
}

greet("Anna", day: "Tuesday")

var array = ["apple", "banana", "dragonfruit"]
array.insert("cherry", atIndex: 2)
array

class NamedShape
{
    var numberOfSides = 0
    var name: String
    init(name: String){
        self.name = name
    }
    
    func simpleDescription() -> String{
        return "\(name) with \(numberOfSides) sides."
    }
}


let namedShape = NamedShape(name: "my named shape")
namedShape.numberOfSides = 7
var shapeDescription = namedShape.simpleDescription()


class Square: NamedShape{
    var sideLength: Double
    
    init(sideLength: Double, name: String){
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double{
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}

let testSquare = Square(sideLength: 5.2, name: "my test square")
testSquare.area()
testSquare.simpleDescription()

class Circle: NamedShape{
    var radius: Double
    
    init?(radius: Double, name: String){
        self.radius = radius
        super.init(name: name)
        numberOfSides = 1
        if radius <= 0{
            return nil
        }
    }
    
    override func simpleDescription() -> String {
        return "A circle with radius of \(radius)."
    }
}

let successfulCircle = Circle(radius: 4.2, name: "successful circle")
let failedCircle = Circle(radius: -7, name: "failed circle")


class Triangle: NamedShape{
    init(sideLength: Double, name: String){
        super.init(name: name)
        numberOfSides = 3
    }
}

let shapesArray = [Triangle(sideLength: 1.5, name: "triangle1"), Triangle(sideLength: 4.2, name: "triangle2"), Square(sideLength: 3.2, name: "square1"), Square(sideLength: 2.7, name: "square1")]
var squares = 0
var triangles = 0
for shape in shapesArray{
    if let square = shape as? Square{
        squares++
    }else if let triangle = shape as? Triangle{
        triangles++
    }
}

print("\(squares) squares and \(triangles) triangles")

enum Rank: Int{
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String{
        switch self{
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

let ace = Rank.Ace
let aceRawValue = ace.rawValue

if let convertedRank = Rank(rawValue: 3){
    let threeDescription = convertedRank.simpleDescription()
}

enum Suit{
    case Spades, Hearts, Diamonds, Clubs
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
}
let hearts = Suit.Hearts
let heartsDescription = hearts.simpleDescription()










