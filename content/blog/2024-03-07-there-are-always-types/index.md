+++
title = "There Are Always Types"
description = "Even if you use a dynamic language, the types are still there and you need to think about them. Here I try to explain why."
+++

Here's the thought: If you think you can completely avoid dealing with types by using a dynamic language
instead of a static language, you're mistaken.
You're only postponing the need to think about types, but it will inevitably catch up with you.
See [this short post](/blog/static-dynamic) to learn more about dynamic and static languages.

Let me explain.

Imagine you're about to write a function in a dynamic language that receives an input,
and you want to use the output of this function:

```javascript
function doSomethingAndGetOutput(input) {
    ...
}
let output = doSomethingAndGetOutput(input)
```

This *might* give an impression that the types of `input` and `output` don't matter.
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

The situation with the code we've arrived at could be described with explicit types in a static language:

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

What does this give us? Well, let's say you want to make changes to the code:

```typescript
// let's change this line:
let dataObtainedFromInput = input.inputMethod()
// to this line
let dataObtainedFromInput = input.someOtherInputMethod()
```

```bash
error: Property 'someOtherInputMethod' does not exist on type 'Input'.

input.someOtherInputMethod()
      ~~~~~~~~~~~~~~~~~~~~
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

Is this a good thing? It depends. If you want something to be done with less effort and can't be bothered with modifying extra code such as type definitions and interfaces, then it's probably not very beneficial. On the other hand, if safety is more important to you and you want to reduce the risk of potential regressions, then it's very beneficial. Imagine a situation where you're not the only one expected to modify the code or you might need to touch it after a while. The safety net of a static type system might be very beneficial in this case.