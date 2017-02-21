//: Playground - noun: a place where people can play

import UIKit

/*
 闭包表达式语法
 { (parameters) -> returnType in
    statements
 }
 */

/*
 如果可以推断闭包的参数和返回值类型
 则闭包的类型 返回箭头->和参数周围的小括号都可以省略
 */
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
var reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )

/*
 单表达式闭包隐式返回
 单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果
 */
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )

/*
 参数名称缩写
 内联闭包中可以使用参数缩写，如$0 $1等。
 闭包表达式中使用参数名称缩写，则可以省略参数列表
 in 关键字也可以被省略，闭包表达式完全由函数体构成
 */
reversedNames = names.sorted(by: { $0 > $1 } )

/*
 运算符方法
 因为Swift 的 String 类型定义了关于大于号（>）的字符串实现，
 其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值
 Swift会推断你想使用大于号的字符串函数
 */
reversedNames = names.sorted(by: >)

/*
 尾随闭包
 闭包表达式作为最后一个参数传递给函数，
 可以使用尾随闭包来增强函数的可读性
 尾随闭包是一个书写在函数括号之后的闭包表达式
 在使用尾随闭包时，你不用写出它的参数标签
 如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，
 你甚至可以把 () 省略掉
 */

func someFunctionThatTakesAClosure(closure: () -> Void) {
    // 函数体部分
}

// 以下是不使用尾随闭包进行函数调用
someFunctionThatTakesAClosure(closure: {
    // 闭包主体部分
})

// 以下是使用尾随闭包进行函数调用
someFunctionThatTakesAClosure() {
    // 闭包主体部分
}
someFunctionThatTakesAClosure {
    //闭包主体部分
}

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [16, 58, 510]
let strings = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}

/*
 值捕获
 
 闭包可以在其被定义的上下文中捕获常量或变量。
 即使定义这些常量和变量的原作用域已经不存在，
 闭包仍然可以在闭包函数体内引用和修改这些值。
 */

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()

/*
 逃逸闭包
 
 当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，
 我们称该闭包从函数中逃逸
 可以在参数名之前标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的
 将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self
 */

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }//显示引用self
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()//闭包在函数返回之后才执行的
print(instance.x)