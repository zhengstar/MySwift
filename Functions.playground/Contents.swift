//: Playground - noun: a place where people can play

import UIKit

/*函数参数标签和参数名称
 参数标签用于调用 参数名称用于函数内部使用
 默认情况下，函数参数使用参数名称来作为它们的参数标签
 多个参数拥有同样的参数标签是可能的,但不能拥有同样的参数名称
 如果不希望为某个参数添加一个标签，在该参数前添加_
 */

func someFunction(argumentLabel parameterName: Int, argumentLabel par2: Int) {
    // 在函数体内，parameterName 代表参数值
}

func fade(_ paramName: Int, _ paramName2: Int) {
    
}

/*可变参数
 通过在变量类型名后面加入（...）的方式来定义可变参数
 可变参数的传入值在函数体中变为此类型的一个数组
 一个函数最多只能拥有一个可变参数
 */
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)

/*输入输出参数
 函数参数默认是常量。如果函数内修改参数值会报错
 如果想要一个函数可以修改参数的值，且想要在这些修改在函数调用结束后仍然存在，
 那么就应该把这个参数定义为输入输出参数
 定义一个输入输出参数时，在参数类型前加 inout 关键字
 只能传递变量给输入输出参数
 当传入的参数作为输入输出参数时，需要在参数名前加 & 符
 输入输出参数不能有默认值，而且可变参数不能用 inout 标记
 */
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

