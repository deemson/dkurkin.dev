+++
title = "Strong & Weak Type Systems"
description = "Short explanation of the differences between strong and weak type systems."
+++

I've discussed the differences between static and dynamic type systems
in the [previous post](/blog/static-dynamic/).
Type systems, however, have another property to them, and that is their *"looseness"*: they are categorized as either
**weak** or **strong** and these should not be confused with **dynamic** and **static**.

Let's discuss this aspect of type systems in this post.

# Weak Type System

Languages with a **weak**, or sometimes referred to as **loose**, type system engage in implicit type conversions during their operations. Take **JavaScript**, for instance:

```javascript
console.log(2 + "3") // 23
console.log(2 + "hello") // 2hello
console.log("3" * 2) // 6
console.log("hello" * 2) // NaN
```

In **JavaScript**, the `+` operator serves both for addition and string concatenation, leading to implicit type conversions.
Look at the first line of the example: even though you pass a string as a second argument, the result is a number. **JavaScript**
implicitly converts the string to a number.
Similarly, the `*` operator attempts to convert operands to numbers, yielding special values like NaN when unsuccessful.

# Strong Type System

Languages with a strong type system, like **Python**, won't do that:

```python
2 + "3" # TypeError: unsupported operand type(s) for +: 'int' and 'str'
2 + "hello" # TypeError: unsupported operand type(s) for +: 'int' and 'str'
{} + [] # TypeError: unsupported operand type(s) for +: 'dict' and 'list'
{} + {} # TypeError: unsupported operand type(s) for +: 'dict' and 'dict'
```

In **Python**, incompatible types lead to errors rather than implicit conversions.
This strictness ensures type integrity and helps catch potential bugs earlier.

# Navigating the Gray Areas

The distinction between weak and strong type systems isn't always clear-cut.
Some languages, like **C**, while usually classified as **strong** might still do some
implicit type conversions in certain situations:

```c
#include <stdio.h>

int main() {
   char charVar = 'a';
   int intVar = 2;
   printf("%d", charVar + intVar);
   return 0;
}
```

```bash
$ gcc example.c -o example
$ ./example
99
```

In this example **C** allows adding different types like char and
to perform this operation it implicitly converts them to compatible types just like a **weak** language would.

Similarly, although **Python** is considered strongly typed, it might still perform implicit conversions in certain scenarios:

```python
float_var = 2.2
print(type(float_var)) # <class 'float'>
int_var = 1
print(type(int_var)) # <class 'int'>
result = float_var + int_var
print(result) # 3.2
print(type(result)) # <class 'float'>
```

Here **Python** calculates a sum of two numbers that have different types: a `float` number and an `int` number. The
resulting type is `float`, which means that **Python** converted `int` variable to `float` before doing the calculation.
That means that **Python**, as well as **C**, exhibits characteristics of a weakly typed language in some trivial
situations.

In contrast, **Go**, another strongly typed language, strictly prohibits such operations, demonstrating a stricter type system.

```go
// example.go
package main

import "fmt"

func main() {
	var floatVar float64
	floatVar = 2.2
	var intVar int
	intVar = 1
	fmt.Println(floatVar + intVar)
}
```

```bash
$ go run example.go
./example.go:11:23: invalid operation: floatVar + intVar (mismatched types float64 and int)
```

This means that **Go** does not allow to add floats and ints, forcing a programmer to convert the types manually.

# Final thoughts

**Weak** (or **loose**) type system is a type system that might do type conversions in certain situations. Programming
languages inherently have a certain degree of *"looseness"* within them. There are, however, marginal examples of
extreme *"looseness"* and an example of that might be **JavaScript** -- it tries hard not to throw any errors even if the result of an operation does not make much sense:

```javascript
console.log([] + []) // "" (empty string)
console.log({} + []) // 0
```

This is the reason why **JavaScript**, in particular, receives a lot of flak as some people might consider this behavior
counter-intuitive.

There are many programming languages that do type conversions only in a handful of situations when it truly makes sense
-- examples include **Python** and **C**. There are also several languages that forbid type conversions altogether --
for example **Go**.