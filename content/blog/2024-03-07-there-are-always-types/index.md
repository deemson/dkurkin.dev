+++
title = "There Are Always Types"
description = "Even if you use a dynamic language, the types are still there and you need to think about them. Here I try to explain why."
+++

Here's the thought: if you think you completely avoid dealing with types
when you use dynamic language instead of static language, then you are wrong.
You see, you only postponing the need to think about types but it will inevitably catch up to you.
See [this short post](/blog/static-dynamic) to learn more about dynamic and static languages.

Let me explain.

Imagine you are about to write a certain function in a dynamic language
that receives a certain input and you'd like to use
the output of the call to this function for something:

```javascript
function doSomethingAndGetOutput(input) {
    ...
}
let output = doSomethingAndGetOutput(input)
```

This *might* give an impression that it does not matter what the types of `input` and `output` are.
But let's look at what happens when you write the actual implementation:

```javascript
function doSomethingAndGetOutput(input) {
    let dataObtainedFromInput = input.inputMethod()
    let output = doSomethingWithTheData(dataObtainedFromInput)
    return output
}

let output = doSomethingAndGetOutput(input)
output.outputMethod()
```

Now the implementation requires `input` object to have a method `inputMethod` and the outer code
expects the returned `output` object to have a method `outputMethod`. This happens implicitly, it does not
require a programmer to think about it right away when you write in a dynamic language.
Yet something like this happens inevitably one way or another.
So the situation with the code we've arrived to could be described with explicit types in a static language:

```typescript
interface Input {
    inputMethod(): Data
}

interface Output {
    outputMethod()
}

function doSomethingAndGetOutput(input: Input): Output {
    let dataObtainedFromInput = input.inputMethod()
    let output = doSomethingWithTheData(dataObtainedFromInput)
    return output
}

let output = doSomethingAndGetOutput(input)
output.outputMethod()
```

What does this give us? Well, if you make changes to the code:

```typescript
// let's change this line:
let dataObtainedFromInput = input.inputMethod()
// to this line
let dataObtainedFromInput = input.someOtherInputMethod()
```

Then the compilation step is going to fail with an error that `Input` type does not have a method called `someOtherInputMethod`,
unless you modify the interface to include it:
```typescript
interface Input {
    inputMethod(): Data
    someOtherInputMethod(): Data
}
...
```

Is this a good thing? It depends. If you want something to be done with less effort and can't be bothered
with modifying extra code such as type definitions and interfaces, then it probably not very beneficial.
On the other hand, if the safety is more important to you and you'd like to reduce the risk of potential regression,
then it's very beneficial.
Imagine a situation where you are not the only one expected to modify the code or you might need to touch it
after quite a while. The safety net of a static type system might be very beneficial in this case.