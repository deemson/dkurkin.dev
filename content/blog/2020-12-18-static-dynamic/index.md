+++
title = "Static & Dynamic Type Systems"
description = "Short description of differences between static and dynamic type systems in programming lanuages."
+++

# Dynamic Languages

In dynamic languages, programmers don't need to explicitly declare variable types and think about the types in advance.
This means you can use variables of any type in functions and expressions without strict type checking and rely on
what's called [duck typing](https://en.wikipedia.org/wiki/Duck_typing).
Programs written in dynamic languages are usually [interpreted](https://en.wikipedia.org/wiki/Interpreter_(computing)).

For example, consider the `sum_of_two` function in **Python**.
It can effortlessly handle various types of inputs, whether they're integers, floats, strings or even lists:

```python
def sum_of_two(number1, number2):
    return number1 + number2
```

```python
>>> sum_of_two(3, 4)
7
```

```python
>>> sum_of_two(3.3, 4.4)
7.7
>>> sum_of_two(2, 3.3)
5.3
```

```python
>>> sum_of_two("3", "4")
'34'
```

```python
>>> sum_of_two([1, 2, 3], [5, 6, 7])
[1, 2, 3, 5, 6, 7]
```

While this flexibility allows for creative solutions,
it also places the responsibility on the programmer to ensure that types are used correctly.

Other famous dynamic languages: *JavaScript*, *PHP*, *Ruby*, *Lua*.

# Static Languages

On the other hand, in static languages
you must explicitly declare variable types,
and the compiler enforces strict type checking.
This means you can't pass a variable of the wrong type to a function or expression without encountering an error.
Programs written in static languages are usually [compiled](https://en.wikipedia.org/wiki/Compiler)
(or [transpiled](https://en.wikipedia.org/wiki/Source-to-source_compiler)).

Take the `sumTwo` function in **Go** as an example:

```go
func sumTwo(number1 int, number2 int) int {
	return number1 + number2
}
```

```go
// sum_two.go
func main() {
	fmt.Println(sumTwo(3, 4))
}
```

```bash
$ go run sum_two.go
7
```

```go
// sum_two.go
func main() {
	fmt.Println(sumTwo(3.4, 4.3))
}
```

```bash
$ go run sum_two.go
./sum_two.go:10:28: constant 3.4 truncated to integer
./sum_two.go:10:33: constant 4.3 truncated to integer
```

```go
// sum_two.go
func main() {
	fmt.Println(sumTwo("3", "4"))
}
```

```bash
$ go run sum_two.go
./sum_two.go:10:28: cannot use "3" (type untyped string) as type int in argument to sumTwo
./sum_two.go:10:33: cannot use "4" (type untyped string) as type int in argument to sumTwo
```

It only accepts integers, and attempting to pass it a float or a string will result in a compile-time error.
While this approach may seem more restrictive, it offers greater assurance that your code is type-safe
and free from certain classes of errors.

Other famous static languages: *Java*, *TypeScript*, *Swift*, *Rust*.