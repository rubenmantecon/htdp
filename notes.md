# How to Design Programs, Second Edition

# Preface

> By “good programming,” we mean an approach to the creation of software that relies on systematic thought, planning, and understanding from the very beginning, at every stage, and for every step. To emphasize the point, we speak of systematic program design and systematically designed programs. Critically, the latter articulates the rationale of the desired functionality. Good programming also satisfies an aesthetic sense of accomplishment; the elegance of a good program is comparable to time-tested poems or the black-and-white photographs of a bygone era. In short, programming differs from good programming like crayon sketches in a diner from oil paintings in a museum.

## Systematic Program Design

A program interacts with people, dubbed _users_, and other programs, in which case we speak of _server_ and _client_ components.

In this context, “systematic program design” refers to a mix of two concepts: **design recipes** and **iterative refinement**. The design recipes are a creation of the authors, and here they enable the use of the latter.

#### The Design Recipe

Here's the first and most fundamental **design recipe**:

1. **From Problem Analysis to Data Definitions**
   Identify the information that must be represented and how it is represented in the chosen programming language. Formulate data definitions and illustrate them with examples.
2. **Signature, Purpose Statement, Header**
   State what kind of data the desired function consumes and produces. Formulate a concise answer to the question what the function computes. Define a stub that lives up to the signature.
3. **Functional Examples**
   Work through examples that illustrate the function’s purpose.
4. **Function Template**
   Translate the data definitions into an outline of the function.
5. **Function Definition**
   Fill in the gaps in the function template. Exploit the purpose statement and the examples.
6. **Testing**
   Articulate the examples as tests and ensure that the function passes all. Doing so discovers mistakes. Tests also supplement examples in that they help others read and understand the definition when the need arises—and it will arise for any serious program.

**Iterative refinement** recommends stripping away all inessential details at first and finding a solution for the remaining core problem. A refinement step adds in one of these omitted details and re-solves the expanded problem, using the existing solution as much as possible. A repetition, also called an iteration, of these refinement steps eventually leads to a complete solution.

# I Fixed-Size Data

### 2.3 Composing Functions

In general, when a problem refers to distinct tasks of computation, a program should consist of one function per task and a main function that puts it all together. We formulate this idea as a simple slogan:

> _Define one function per task._

### 2.4 Global Constants

Again, we state an imperative slogan:

> _For every constant mentioned in a problem statement, introduce one constant definition._

### 2.5 Programs

Usually the first piece of software to be installed on a computer is an _operating system_. It has the task of managing the computer for you, including connected devices such as the monitor, the keyboard, the mouse, the speakers, and so on. The way it works is that when a user presses a key on the keyboard, the operating system runs a function that processes keystrokes. **We say that the keystroke is a _key event_, and the function is an _event handler_. In the same vein, the operating system runs an event handler for clock ticks, for mouse actions, and so on.**

Designing an interactive program requires a way to designate some function as the one that takes care of keyboard events, another function for dealing with clock ticks, a third one for presenting some data as an image, and so forth. It is the task of an interactive program’s main function to communicate these designations to the operating system, that is, the software platform on which the program is launched.

### 3.1 Designing functions

The purpose of a program is to describe a computational process that consumes some information and produces new information. All this information comes from a part of the real world—often called the program’s _domain_—and the results of a program’s computation represent more information in this domain.

_Information_ plays a central role in our description. Think of information as facts about the program’s domain. For a program that deals with a furniture catalog, a “table with five legs” or a “square table of two by two meters” are pieces of information. A game program deals with a different kind of domain, where “five” might refer to the number of pixels per clock tick that some object travels on its way from one part of the canvas to another. Or, a payroll program is likely to deal with “five deductions.”

For a program to process information, it must turn it into some form of _data_ in the programming language; then it processes the data; and once it is finished, it turns the resulting data into information again. An interactive program may even intermingle these steps, acquiring more information from the world as needed and delivering information in between.

> We use BSL and DrRacket so that you do **not** have to worry about the translation of information into data. In DrRacket’s BSL you can apply a function directly to data and observe what it produces. As a result, we avoid the serious chicken-and-egg problem of writing functions that convert information into data and vice versa.

![Figure 15: From information to data, and back](https://htdp.org/2023-3-6/Book/pict_42.png)

We, the programmers, must decide how to use our chosen programming language to _represent_ the relevant pieces of information as data and how we should _interpret_ data as information.

There could be the number `42`. Depending on the domain, it could have different meanings, such as:

- the number of pixels from the top margin in the domain of images;
- the number of pixels per clock tick that a simulation or game object moves;
- a temperature, on the Fahrenheit, Celsius, or Kelvin scale for the domain of physics;
- may specify the size of some table if the domain of the program is a furniture catalog; or
- just count the number of characters in a string.

The key is to know how to go from numbers as information to numbers as data and vice versa.

Since this knowledge is so important for everyone who reads the program, we often write it down in the form of comments, which we call _data definitions_. A data definition serves two purposes. First, it names a collection of data—a _class_—using a meaningful word. Second, it informs readers how to create elements of this class and how to decide whether some arbitrary piece of data belongs to the collection. This is very apparent when the data definition is a group of data tied together (a structure), defined by the programmer instead of being a built-in class.

Here is a data definition for one of the above examples:

```scheme
; A Temperature is a Number
; interpretation represents Celsius degrees
```

#### The Design Process

1. Express how you wish to represent information as data. A one-line comment suffices:

   ```scheme
   ; We use numbers to represent centimeters.
   ```

   Formulate data definitions for the classes of data that you consider necessary for the success of your program.

2. Write down a _signature, a statement of purpose, and a function header_.

   1. A _function signature_ is a comment that tells the readers how many inputs the function consumes, from which classes they are drawn, and what kind of data it produces.

   2. A _purpose statement_ summarizes the purpose of the function in a single line. If you are ever in doubt about a purpose statement, write down the shortest possible answer to the question _what does the function compute?_.

      Every reader of your program should understand what your functions compute **without** having to read the function itself.

   3. Finally, a _header_ is a simplistic function definition, also called a _stub_. Pick one variable name for each class of input in the signature; the body of the function can be any piece of data from the output class.

3. Illustrate the signature and the purpose statement with some functional examples. To construct a _functional example_, pick one piece of data from each input class from the signature and determine what you expect back. In example:

   ```scheme
   ; Number -> Number
   ; computes the area of a square with side len
   ; given: 2, expect: 4
   ; given: 7, expect 49
   (define (area-of-square len) 0)
   ```

   Should be noted that this can also be expressed as tests from step 6.

4. The next step is to take _inventory_, to understand what are the givens and what we need to compute. While parameters are placeholders for values that we don’t know yet, we do know that it is from this unknown data that the function must compute its result. To remind ourselves of this fact, we replace the function’s body with a _template_.

5. It is now time to _code_. So, replacing the template with expressions that attempt to compute, from the pieces of the template, what the purpose statement produces.

6. The last step of a proper design is to test the function on the functional examples from step three. If the result doesn’t match the expected output, consider the following three possibilities:

   1. You miscalculated and determined the wrong expected output for some of the examples.
   2. Alternatively, the function definition computes the wrong result. When this is the case, you have a _logical error_ in your program, also known as a _bug_.
   3. Both the examples and the function definition are wrong.

### 3.3 Domain Knowledge

It is natural to wonder _what knowledge it takes to code up the body of a function_. A little bit of reflection tells you that this step demands an appropriate grasp of the domain of the program. Indeed, there are two forms of such _domain knowledge_:

1. **Knowledge from external domains**, such as mathematics, music, biology, civil engineering, art, and so on. Because programmers cannot know all of the application domains of computing, they must be prepared to understand the language of a variety of application areas so that they can discuss problems with domain experts.
2. **Knowledge about the libraries in the chosen programming language.** This prevents you from reinventing the wheel.

### 3.4 From Functions to Programs

Not all programs consist of a single function definition. Some require several functions; many also use constant definitions. No matter what, it is always important to design every function systematically, though global constants as well as auxiliary functions change the design process a bit.

**For these reasons, we recommend keeping around a list of needed functions or a _wish list_.** Each entry on a wish list should consist of three things: a meaningful name for the function, a signature, and a purpose statement. **If you discover during the design that you need another function, put it on the list. When the list is empty, you are done.**

### 3.6 World Programs

#### Design Recipe for World Programs

The design recipe for world programs, like the one for functions, is a tool for systematically moving from a problem statement to a working program. It consists of three big steps and one small one:

1. For all those properties of the world that remain the same over time and are needed to render it as an `Image` **introduce constants**.
   1. “Physical” constants describe general attributes of objects in the world, such as the speed or velocity of an object, its color, its height, its width, its radius, and so forth. It's a good practice to compute constants from others.
   2. Graphical constants are images of objects in the world. They are generated with the appropriate rendering functions, which will very likely employ the "physical" constants.
2. Those properties that change over time—in reaction to clock ticks, keystrokes, or mouse actions—give rise to the current state of the world. So, it's necessary to develop a data definition (_WorldState_ or similar) _that **encompasses all the possible states** of the world, **each state represented by its respective data representation**._
3. Once that is defined, it is necessary to design a number of functions that a `big-bang` expression needs in order to perform correctly. That means:
   1. **A (rendering) function** that maps any given state in an image so that `big-bang` can render the sequence of states as images
   2. **Event handling functions**, to decide which kind of events (clock ticks, keyboard events, mouse click events...) should change which aspects of the world state.
   3. Optionally, if the problem statement suggests that the program should stop if the world has certain properties, **an `end?`ing function** that checks if those conditions are met needs to be designed.
4. Finally, you need a **`main` function from where to launch the world program**. At this moment in the learning path, it's simply `define`ing a `main` function that contains the `big-bang` expression.

### 4 Intervals, Enumerations, and Itemizations

### 4.1 Programming with Conditionals

In many problem contexts, a function must distinguish several different situations. With a `cond` expression, you can use one line per possibility and thus remind the reader of the code for the different situations from the problem statement.

Contrast `cond` expressions with `if` expressions. The latter distinguish one situation from all the others. As such, `if` expressions are much less suited for multi-situation contexts; they are best used when all we wish to say is “one or the other.” We therefore **always** use `cond` for situations when we wish to remind the reader of our code that some distinct situations come directly from data definitions. For other pieces of code, we use whatever construct is most convenient.

```scheme
(cond [question-expression answer-exrpession]
      ...
      [else answer-expression])
```

Chooses a clause based on some condition. `cond` finds the first _question-expression_ that evaluates to #true, then evaluates the corresponding _answer-expression_.

If none of the _question-expressions_ evaluates to #true, `conds`’s value is the _answer-expression_ of the `else` clause. If there is no `else`, `cond` reports an error. If the result of a _question-expression_ is neither #true nor #false, also reports an error.

### 4.3 Enumerations

_Enumerations_ are a fixed, finite amount of elements from a class, in which every possibility is listed:

```scheme
; A MouseEvt is one of these Strings:
; – "button-down"
; – "button-up"
; – "drag"
; – "move"
; – "enter"
; – "leave"
```

### 4.4 Intervals

_Intervals_ are collections of elements that satisfy a specific property, contained within boundaries. The simplest interval has two boundaries: left and right. If the left boundary is to be included in the interval, we say it is _closed_ on the left. Similarly, a right-closed interval includes its right boundary. Finally, if an interval does not include a boundary, it is said to be _open_ at that boundary.

- [3*,*5] is a closed interval:

  ![image](https://htdp.org/2023-3-6/Book/pict_53.png)

- (3*,*5] is a left-open interval:

  ![image](https://htdp.org/2023-3-6/Book/pict_54.png)

- [3*,*5) is a right-open interval:

  ![image](https://htdp.org/2023-3-6/Book/pict_55.png)

- and (3*,*5) is an open interval:

  ![image](https://htdp.org/2023-3-6/Book/pict_56.png)

In general, intervals deserve special attention when you make up examples, that is, they deserve at least three kinds of examples: one from each end and another one from inside. Also, it is necessary to take into account if the boundaries are open or not, and what to do in each case(s). Certain special values (minimums, maximums, 0...) may need to be accounted for, too.

### 4.5 Itemizations

An interval distinguishes different sub-classes of numbers, which, in principle, is an infinitely large class. An enumeration spells out item for item the useful elements of an existing class of data. Some data definitions need to include elements from both. They use _itemizations_, which generalize intervals and enumerations.

```scheme
; A KeyEvent is one of:
; – 1String
; – "left"
; – "right"
; – "up"
; – ...
```

Where `1String` refers to what is normally understood as `char` in other languages.

### 4.6 Designing with Itemizations

#### Design Recipe Update: Itemizations

1. It will be required that the the data definitions use distinct _clauses_ for each sub-class of data. That is, each element within an itemization must be distinct from one another.
2. The signature, purpose statement and function header step remain unchanged.
3. When formulating examples, it is mandatory that at least you formulate one example per clause/sub-class/item in the itemization.
   1. If a sub-class is also a finite interval, it's necessary to pick examples that account for the boundaries and its interior.
4. **The template mirrors the organization of sub-classes with a `cond`**. This means:
   1. The function’s body must be a conditional expression with as many clauses as there are distinct sub-classes in the data definition.
   2. You must formulate one condition expression per `cond` line. Each expression involves the function parameter and one of the sub-classes of data in the data definition.
5. Now that is time to code, go for each `cond` line, assume the input parameter meets the condition and therefore exploit its corresponding test cases. To formulate the corresponding result expression, you write down the computation for this example as an expression that involves the function parameter in some way.
6. Your attitude and behavior regarding tests keeps being the same.

### 4.7 Finite State Worlds

![image](https://htdp.org/2023-3-6/Book/pict_60.png)

The left-hand side of [Figure 26](https://htdp.org/2023-3-6/Book/part_one.html#(counter._(figure._fig~3atraffic-light)) summarizes this description as a _state transition diagram_. Such a diagram consists of _states_ and arrows that connect these states. Each state depicts a traffic light in one particular configuration: red, yellow, or green. Each arrow shows how the world can change, from which state it can _transition_ to another state. Our sample diagram contains three arrows, because there are three possible ways in which the traffic light can change. Labels on the arrows indicate the reason for changes; a traffic light transitions from one state to another as time passes.

Computer scientists call such diagrams _finite state machines_ (FSM), also known as _finite state automata_ (FSA). Despite their simplicity, FSMs/FSAs play an important role in computer science.

### 5 Adding Structure

Your cell phone is mostly a few million lines of code wrapped in plastic. Among other things, it administrates your contacts. Each contact comes with a name, a phone number, an email address, and perhaps some other information. When you have lots of contacts, each single contact is best represented as a single piece of data; otherwise the various pieces could get mixed up by accident.

Because of such programming problems, every programming language provides some mechanism to combine several pieces of data into a single piece of _compound data_ and ways to retrieve the constituent values when needed.

### 5.4 Defining Structures

A _structure type definition_ is another form of definition, distinct from constant and function definitions. A structure type definition actually defines functions. But, unlike an ordinary function definition, **a structure type definition defines many functions** simultaneously. Specifically, it defines three kinds of functions:

- one _constructor_, a function that creates _structure instances_. It takes as many values as there are fields; as mentioned, _structure_ is short for structure instance. The phrase _structure type_ is a generic name for the collection of all possible instances;
- one _selector_ per field, which extracts the value of the field from a structure instance; and
- one _structure predicate_, which, like ordinary predicates, distinguishes instances from all other kinds of values.

A program can use these as if they were functions or built-in primitives.

Every structure type definition introduces a new kind of structure, distinct from all others. Programmers want this kind of expressive power because they wish to convey an **intention** with the structure name. Wherever a structure is created, selected, or tested, the text of the program explicitly reminds the reader of this intention.

Since structures are values, just like numbers or Booleans or strings, it makes sense that one instance of a structure occurs inside another instance.

### 5.5 Computing with Structures

Let us first look at a diagrammatic way to think about structure instances as lockboxes with as many compartments as there are fields. Here is a representation of (previously defined structure called _entry_)

```scheme
(define pl (make-entry "Al Abe" "666-7771" "lee@x.me"))
```

as such diagram:

![image](https://htdp.org/2023-3-6/Book/pict_70.png)

Not surprisingly, nested structure instances have a diagram of boxes nested in boxes.

![image](https://htdp.org/2023-3-6/Book/pict_72.png)

### 5.6 Programming with Structures

Remember that a data definition provides a way of representing information into data and interpreting that data as information. For structure types, this calls for a description of what kind of data goes into which field. For some structure type definitions, formulating such descriptions is easy and obvious:

```scheme
(define-struct posn [x y])
; A Posn is a structure:
;   (make-posn Number Number)
; interpretation a point x pixels from left, y from top
```

> _If a function deals with nested structures, develop one function per level of nesting._

### 5.7 The Universe of Data

Every language comes with a universe of data. This data represents information from and about the external world; it is what programs manipulate. This universe of data is a collection that not only contains all built-in data but also any piece of data that any program may ever create.

Neither programs nor individual functions in programs deal with the entire universe of data. It is the purpose of a data definition to describe parts of this universe and to name these parts so that we can refer to them concisely. Put differently, a named data definition is a description of a collection of data, and that name is usable in other data definitions and in function signatures. In a function signature, the name specifies what data a function will deal with and, implicitly, which part of the universe of data it won’t deal with.

Since data definitions play such a central and important role in the design process, it is often best to illustrate data definitions with examples just like we illustrate the behavior of functions with examples. And indeed, creating data examples from a data definition is straightforward:

- for a built-in collection of data (number, string, Boolean, images), choose **your favorite examples**;
- for an enumeration, use **several of the items** of the enumeration;
- for intervals, use the **end points** (if they are included) and **at least one interior point**;
- for itemizations, **deal with each part separately**; and
- for data definitions for structures, follow the natural language description; that is, **use the constructor and pick an example from the data collection named for each field**.

### 5.8 Designing with Structures

#### Design Recipe Update: Structures

This section adds a design recipe, illustrating it with the following:

> **Sample Problem** Design a function that computes the distance of objects in a 3-dimensional space to the origin.

1. When a problem calls for the representation of pieces of information that belong together or describe a natural whole, you need a structure type definition.

   To ensure that we can create instances, our data definitions should come with **data examples**.

   ```scheme
   (define-struct r3 [x y z])
   ; An R3 is a structure:
   ;   (make-r3 Number Number Number)

   (define ex1 (make-r3 1 2 13))
   (define ex2 (make-r3 -1 0 3))
   ```

2. The second step remains unchanged.

3. The third step remains unchanged.

4. A function that consumes structures usually—though not always—extracts the values from the various fields in the structure. To remind yourself of this possibility, add a selector for each field to the templates for such functions.

   ```scheme
   ; R3 -> Number
   ; determines the distance of p to the origin
   (define (r3-distance-to-0 p)
     (... (r3-x p) ... (r3-y p) ... (r3-z p) ...))
   ```

5. The fifth step remains unchanged.

6. The sixth step remains unchanged.

### 5.9 Structure in the World

When a world program must track two independent pieces of information, we must use a collection of structures to represent the world state data. One field keeps track of one piece of information and the other field the second piece of information. Naturally, if the domain world contains more than two independent pieces of information, the structure type definition must specify as many fields as there are distinct pieces of information.

### 6.1 Designing with Itemizations, Again

#### Design Recipe Update: Itemizations and Structures

1. An itemization of different forms of data—including collections of structures—is required when your problem statement distinguishes different kinds of information and when at least some of these pieces of information consist of several different pieces.

2. The second step remains unchanged.

3. The third step remains unchanged.

4. The development of the template now exploits two different dimensions: the itemization itself and the use of structures in its clauses.

   By the first, the body of the template consists of a `cond` expression that has as many `cond` clauses as the itemizations has items. Furthermore, you must add a condition to each `cond` clause that identifies the sub-class of data in the corresponding item. Recall this similar advice from Design Recipe Update with Itemizations from section 4.6.

   By the second, if an item deals with a structure, the template contains the selector expressions—in the `cond` clause that deals with the sub-class of data described in the item. Recall this similar advice from Design Recipe Update with Structures from section 5.8.

   If said structure contains custom data definitions, you do **not** add selector expressions. Instead, you create a template for the separate data definition to the task at hand and refer to that template with a function call.

   **Before going through the work of developing a template**, briefly reflect on the nature of the function. If the problem statement suggests that there are several tasks to be performed, it is likely that a composition of several, separately designed functions is needed instead of a template.

5. If you are stuck, fill the easy cases first and use default values for the others. While this makes some of the test cases fail, you are making progress and you can visualize this progress.

   If you are stuck on some cases of the itemization, analyze the examples that correspond to those cases. Determine what the pieces of the template compute from the given inputs. Then consider how to combine these pieces (plus some constants) to compute the desired output.

   Also, if your template “calls” another template because the data definitions refer to each other, assume that the other function delivers what its purpose statement and its examples promise.

6. The sixth step remains unchanged.

### 6.3 Input Errors

One central point of this chapter concerns the role of predicates. They are critical when you must design functions that process mixes of data. Such mixes come up naturally when your problem statement mentions many different kinds of information, but they also come up when you hand your functions and programs to others. This section therefore presents one way of protecting programs from inappropriate inputs.

#### Checked functions

When designing a checked function, is that for all those values in the class of values for which the original function is defined, the checked version must produce the same results; for all others, it must signal an error. So we only need to write the behavior for the data definitions of the original version (which will be the same, managed by a `cond` clause), and use an `else` for the rest:

```scheme
; Any -> Number
; computes the area of a disk with radius v,
; if v is a number
(define (checked-area-of-disk v)
  (cond
    [(number? v) (area-of-disk v)]
    [else (error "area-of-disk: number expected")]))
```

> This book focuses on the design process for proper program design, and, to do this without distraction, we agree that we always adhere to data definitions and signatures. At least, we almost always do so, and on rare occasions we may ask you to design checked versions of a function or a program.

#### Predicates

As with checked functions, a predicate doesn’t need all possible `cond` lines. Only those that might produce #true are required:

```scheme
; A MissileOrNot is one of:
; – #false
; – Posn
; interpretation #false means the missile is in the tank;
; Posn says the missile is at that location

(define (missile-or-not? v)
  (cond
    [(false? v) #true]
    [(posn? v) #true]
    [else #false]))
```

### Checking the World

In a world program, many things can go wrong. Although we just agreed to trust that our functions are always applied to the proper kind of data, in a world program we may juggle too many things at once to place that much trust in ourselves. When we design a world program that takes care of clock ticks, mouse clicks, keystrokes, and rendering, it is just too easy to get one of those interplays wrong.

To help with this kind of problem, `big-bang` comes with an optional `check-with` clause that accepts a predicate for world states. Those predicates can be built-in or custom made.

### 6.5 Equality predicates

An _equality predicate_ is a function that compares two elements of the same collection of data. Custom ones can be made:

```scheme
; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three
; possible states that a traffic light may assume

; Any -> Boolean
; is the given value an element of TrafficLight
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))

; Any Any -> Boolean
; are the two values elements of TrafficLight and,
; if so, are they equal
(define (light=? a-value another-value)
  (if (and (light? a-value) (light? another-value))
      (string=? a-value another-value)
      (error MESSAGE)))
```

### 7 Summary

The most relevant things for myself:

- Programming languages, including BSL, come with a rich set of libraries so that programmers don’t have to reinvent the wheel all the time. A programmer should become comfortable with the functions that a library provides, especially their signatures and purpose statements. Doing so simplifies life.
- Make sure you understand the following terms: **structure type** definition, **function** definition, **constant** definition, **structure instance**, **data definition**, `big-bang`, and **event-handling function**.

# Section II Arbitrarily Large Data

### 10.3 Lists in Lists, Files

This idea of composing a built-in function with a newly designed function is common. Naturally, people don’t design functions randomly and expect to find something in the chosen programming language to complement their design. **Instead, program designers plan ahead and design the function to the output that available functions deliver**. More generally still and as mentioned above, it is common to think about a solution as a composition of two computations and to develop an appropriate data collection with which to communicate the result of one computation to the second one, where each computation is implemented with a function.

### 11.2 Composing functions

> Design one function per task. Formulate auxiliary function definitions for every dependency between quantities in the problem.
>
> Design one template per data definition. Formulate auxiliary function definitions when one data definition points to a second data definition.

These are not exclusive. This can mean -as in the second quote- that one function per task may be composed of a collection of subfunctions that deal with data definions that are part of the structure dealt with in the 'function per task' specified above.

> Turning a template into a complete function definition means combining the values of the template’s sub-expressions into the final answer. As you do so, you might encounter several situations that suggest the need for auxiliary functions:
>
> 1. If the composition of values requires knowledge of a particular domain of application—for example, composing two (computer) images, accounting, music, or science—design an auxiliary function.
>
>    R: that is, if it needs to be plugged data resulting from a computation. Applies to recursion too (see 3).
>
> 2. If the composition of values requires a case analysis of the available values—for example, depends on a number being positive, zero, or negative— use a [cond](<http://docs.racket-lang.org/htdp-langs/beginner.html#(form._((lib._lang%2Fhtdp-beginner..rkt)._cond))>) expression. If the [cond](<http://docs.racket-lang.org/htdp-langs/beginner.html#(form._((lib._lang%2Fhtdp-beginner..rkt)._cond))>) looks complex, design an auxiliary function whose arguments are the template’s expressions and whose body is the [cond](<http://docs.racket-lang.org/htdp-langs/beginner.html#(form._((lib._lang%2Fhtdp-beginner..rkt)._cond))>) expression.
> 3. If the composition of values must process an element from a self-referential data definition—a list, a natural number, or something like those—design an auxiliary function.
> 4. If everything fails, you may need to design a **more general** function and define the main function as a specific use of the general function. This suggestion sounds counterintuitive, but it is called for in a remarkably large number of cases.

> Before we continue, though, remember that the key to managing the design of programs is to maintain the often-mentioned
>
> > **Wish List**
>
> > Maintain a list of function headers that must be designed to complete a program. Writing down complete function headers ensures that you can test those portions of the programs that you have finished, which is useful even though many tests will fail. Of course, when the wish list is empty, all tests should pass and all functions should be covered by tests.

### 11.4 Auxiliary Functions that Generalize

On occasion an auxiliary function is not just a small helper function but a solution to a more general problem. Such auxiliaries are needed when a problem statement is too narrow.

Revising the data definition during an initial exploration is normal; indeed, on occasion such revisions become necessary during the rest of the design process. As long as you stick to a systematic approach, though, **changes to the data definition can naturally be propagated through the rest of the design.**

### 13 Summary

The main takeaway: complex problems call for a **decomposition** into separate problems. When you decompose a problem, you need two pieces: functions that solve the separate problems and data definitions that compose these separate solutions into a single one. To ensure that the composition works after you have spent time on the separate programs, you need to formulate your “wishes” together with the required data definitions.

# Section III Abstraction

## 14.3 Similarities in Data Definitions

Roughly speaking, a parametric data definition abstracts from a reference to a particular collection of data in the same manner as a function abstracts from a particular value.

R: one little detail I thought of for the design recipe. Of the operations that can be done upon the data structures chosen to represent information, which ones naturally align with the perceived nature of the information? Are they native to the language? Do they need to be constructed (say, operate upon struct fields in a particular way, instead of simply adding two numbers)?
