# How to Design Programs, Second Edition

# Preface

> By “good programming,” we mean an approach to the creation of software that relies on systematic thought, planning, and understanding from the very beginning, at every stage, and for every step.  To emphasize the point, we speak of systematic program design and systematically designed programs.  Critically, the latter articulates the rationale of the desired functionality.  Good programming also satisfies an aesthetic sense of accomplishment; the elegance of a good program is comparable to time-tested poems or the black-and-white photographs of a bygone era. In short, programming differs from good programming like crayon sketches in a diner from oil paintings in a museum.

## Systematic Program Design

A program interacts with people, dubbed *users*, and other programs, in which case we speak of *server* and *client* components.

In this context, “systematic program design” refers to a mix of two concepts: **design recipes** and **iterative refinement**. The design recipes are a creation of the authors, and here they enable the use of the latter.

#### The Design Recipe

Here's the first and most fundamental **design recipe**:

1. **From Problem Analysis to Data Definitions**
  Identify the information that must be represented and how it is represented in the chosen programming language. Formulate data definitions and illustrate them with examples.
2. **Signature, Purpose Statement, Header**
  State what kind of data the desired function consumes and produces.  Formulate a concise answer to the question what the function computes. Define a stub that lives up to the signature.
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

> *Define one function per task.*

### 2.4 Global Constants

Again, we state an imperative slogan:

> *For every constant mentioned in a problem statement, introduce one constant definition.*

### 2.5 Programs

Usually the first piece of software to be installed on a computer is an *operating system*. It has the task of managing the computer for you, including connected devices such as the monitor, the keyboard, the mouse, the speakers, and so on. The way it works is that when a user presses a key on the keyboard, the operating system runs a function that processes keystrokes. **We say that the keystroke is a *key event*, and the function is an *event handler*. In the same vein, the operating system runs an event handler for clock ticks, for mouse actions, and so on.** 

Designing an interactive program requires a way to designate some function as the one that takes care of keyboard events, another function for dealing with clock ticks, a third one for presenting some data as an image, and so forth. It is the task of an interactive program’s main function to communicate these designations to the operating system, that is, the software platform on which the program is launched.

### 3.1 Designing functions

The purpose of a program is to describe a computational process that consumes some information and produces new information. All this information comes from a part of the real world—often called the program’s *domain*—and the results of a program’s computation represent more information in this domain.

*Information* plays a central role in our description. Think of information as facts about the program’s domain. For a program that deals with a furniture catalog, a “table with five legs” or a “square table of two by two meters” are pieces of information. A game program deals with a different kind of domain, where “five” might refer to the number of pixels per clock tick that some object travels on its way from one part of the canvas to another. Or, a payroll program is likely to deal with “five deductions.”

For a program to process information, it must turn it into some form of *data* in the programming language; then it processes the data; and once it is finished, it turns the resulting data into information again. An interactive program may even intermingle these steps, acquiring more information from the world as needed and delivering information in between.

> We use BSL and DrRacket so that you do **not** have to worry about the translation of information into data. In DrRacket’s BSL you can apply a function directly to data and observe what it produces. As a result, we avoid the serious chicken-and-egg problem of writing functions that convert information into data and vice versa.

![Figure 15: From information to data, and back](https://htdp.org/2023-3-6/Book/pict_42.png)

We, the programmers, must decide how to use our chosen programming language to *represent* the relevant pieces of information as data and how we should *interpret* data as information.

There could be the number `42`. Depending on the domain, it could have different meanings, such as:

- the number of pixels from the top margin in the domain of images;
- the number of pixels per clock tick that a simulation or game object moves;
- a temperature, on the Fahrenheit, Celsius, or Kelvin scale for the domain of physics;
- may specify the size of some table if the domain of the program is a furniture catalog; or
- just count the number of characters in a string.

The key is to know how to go from numbers as information to numbers as data and vice versa.

Since this knowledge is so important for everyone who reads the program, we often write it down in the form of comments, which we call *data definitions*. A data definition serves two purposes. First, it names a collection of data—a *class*—using a meaningful word. Second, it informs readers how to create elements of this class and how to decide whether some arbitrary piece of data belongs to the collection. This is very apparent when the data definition is a group of data tied together (a structure), defined by the programmer instead of being a built-in class.

Here is a data definition for one of the above examples:

> ; A *Temperature* is a `Number`
>
> ; **interpretation** represents Celsius degrees

#### The Design Process

1. Express how you wish to represent information as data. A one-line comment suffices:

   > ; We use numbers to represent centimeters.

   Formulate data definitions for the classes of data that you consider necessary for the success of your program.

2. Write down a *signature, a statement of purpose, and a function header*.

   1. A *function signature* is a comment that tells the readers how many inputs the function consumes, from which classes they are drawn, and what kind of data it produces.

   2. A *purpose statement* summarizes the purpose of the function in a single line. If you are ever in doubt about a purpose statement, write down the shortest possible answer to the question *what does the function compute?*. 

      Every reader of your program should understand what your functions compute **without** having to read the function itself.

   3. Finally, a *header* is a simplistic function definition, also called a *stub*. Pick one variable name for each class of input in the signature; the body of the function can be any piece of data from the output class.

3. Illustrate the signature and the purpose statement with some functional examples. To construct a *functional example*, pick one piece of data from each input class from the signature and determine what you expect back. In example:

   ```scheme
   ; Number -> Number
   ; computes the area of a square with side len
   ; given: 2, expect: 4
   ; given: 7, expect 49
   (define (area-of-square len) 0)
   ```

   Should be noted that this can also be expressed as tests from step 6.

4. The next step is to take *inventory*, to understand what are the givens and what we need to compute. While parameters are placeholders for values that we don’t know yet, we do know that it is from this unknown data that the function must compute its result. To remind ourselves of this fact, we replace the function’s body with a *template*.

5. It is now time to *code*. So, replacing the template with expressions that attempt to compute, from the pieces of the template, what the purpose statement produces.

6. The last step of a proper design is to test the function on the functional examples from step three. If the result doesn’t match the expected output, consider the following three possibilities:

   1. You miscalculated and determined the wrong expected output for some of the examples.
   2. Alternatively, the function definition computes the wrong result. When this is the case, you have a *logical error* in your program, also known as a *bug*.
   3. Both the examples and the function definition are wrong.

### 3.3 Domain Knowledge

It is natural to wonder *what knowledge it takes to code up the body of a function*. A little bit of reflection tells you that this step demands an appropriate grasp of the domain of the program. Indeed, there are two forms of such *domain knowledge*:

1. **Knowledge from external domains**, such as mathematics, music, biology, civil engineering, art, and so on. Because programmers cannot know all of the application domains of computing, they must be prepared to understand the language of a variety of application areas so that they can discuss problems with domain experts.
2. **Knowledge about the libraries in the chosen programming language.** This prevents you from reinventing the wheel.

### 3.4 From Functions to Programs

Not all programs consist of a single function definition. Some require several functions; many also use constant definitions. No matter what, it is always important to design every function systematically, though global constants as well as auxiliary functions change the design process a bit.

**For these reasons, we recommend keeping around a list of needed functions or a *wish list*.** Each entry on a wish list should consist of three things: a meaningful name for the function, a signature, and a purpose statement. **If you discover during the design that you need another function, put it on the list. When the list is empty, you are done.**

### 3.6 World Programs

#### Design Recipe for World Programs

The design recipe for world programs, like the one for functions, is a tool for systematically moving from a problem statement to a working program. It consists of three big steps and one small one:

1. For all those properties of the world that remain the same over time and are needed to render it as an `Image` **introduce constants**.
   1. “Physical” constants describe general attributes of objects in the world, such as the speed or velocity of an object, its color, its height, its width, its radius, and so forth. It's a good practice to compute constants from others
   2. Graphical constants are images of objects in the world. They are generated with the appropriate rendering functions, which will very likely employ the "physical" constants.
2. Those properties that change over time—in reaction to clock ticks, keystrokes, or mouse actions—give rise to the current state of the world. So, it's necessary to develop a data definition (*WorldState* or similar) *that **encompasses all the possible states** of the world, **each state represented by its respective data representation**.* 
3. Once that is defined, it is necessary to design a number of functions that a `big-bang` expression needs in order to perform correctly. That means:
   1. **A (rendering) function** that maps any given state in an image so that `big-bang` can render the sequence of states as images
   2. **Event handling functions**, to decide which kind of events (clock ticks, keyboard events, mouse click events...) should change which aspects of the world state.
   3. Optionally, if the problem statement suggests that the program should stop if the world has certain properties, **an `end?`ing function** that checks if those conditions are met needs to be designed.
4. Finally, you need a **`main` function from where to launch the world program**. At this moment in the learning path, it's simply `define`ing a `main` function that contains the `big-bang` expression.

### 4 Intervals, Enumerations, and Itemizations

#### 4.1 Programming with Conditionals

In many problem contexts, a function must distinguish several different situations. With a `cond` expression, you can use one line per possibility and thus remind the reader of the code for the different situations from the problem statement.

Contrast `cond` expressions with `if` expressions. The latter distinguish one situation from all the others. As such, `if` expressions are much less suited for multi-situation contexts; they are best used when all we wish to say is “one or the other.” We therefore **always** use `cond` for situations when we wish to remind the reader of our code that some distinct situations come directly from data definitions. For other pieces of code, we use whatever construct is most convenient.

```scheme
(cond [question-expression answer-exrpession]
      ...
      [else answer-expression])
```

Chooses a clause based on some condition. `cond` finds the first *question-expression* that evaluates to #true, then evaluates the corresponding *answer-expression*.

If none of the *question-expressions* evaluates to #true, `conds`’s value is the *answer-expression* of the `else` clause. If there is no `else`, `cond` reports an error. If the result of a *question-expression* is neither #true nor #false,  also reports an error.

#### 4.3 Enumerations

*Enumerations* are a fixed, finite amount of elements from a class, in which every possibility is listed:

```scheme
; A MouseEvt is one of these Strings:
; – "button-down"
; – "button-up"
; – "drag"
; – "move"
; – "enter"
; – "leave"
```

#### 4.4 Intervals

*Intervals* are collections of elements that satisfy a specific property, contained within boundaries. The simplest interval has two boundaries: left and right. If the left boundary is to be included in the interval, we say it is *closed* on the left. Similarly, a right-closed interval includes its right boundary. Finally, if an interval does not include a boundary, it is said to be *open* at that boundary.

- [3*,*5] is a closed interval:

  ![image](https://htdp.org/2023-3-6/Book/pict_53.png)

- (3*,*5] is a left-open interval:

  ![image](https://htdp.org/2023-3-6/Book/pict_54.png)

- [3*,*5) is a right-open interval:

  ![image](https://htdp.org/2023-3-6/Book/pict_55.png)

- and (3*,*5) is an open interval:

  ![image](https://htdp.org/2023-3-6/Book/pict_56.png)

In general, intervals deserve special attention when you make up examples, that is, they deserve at least three kinds of examples: one from each end and another one from inside. Also, it is necessary to take into account if the boundaries are open or not, and what to do in each case(s). Certain special values (minimums, maximums, 0...) may need to be accounted for, too.

#### 4.5 Itemizations

An interval distinguishes different sub-classes of numbers, which, in principle, is an infinitely large class.  An enumeration spells out item for item the useful elements of an existing class of data. Some data definitions need to include elements from both. They use *itemizations*, which generalize intervals and enumerations.

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

1. It will be required that the the data definitions use distinct *clauses* for each sub-class of data. That is, each element within an itemization must be distinct from one another.
2. The signature, purpose statement and function header step remain unchanged.
3. When formulating examples, it is mandatory that at least you formulate one example per clause/sub-class/item in the itemization.
   1. If a sub-class is also a finite interval, it's necessary to pick examples that account for the boundaries and its interior.
4. **The template mirrors the organization of sub-classes with a `cond`**. This means:
   1. The function’s body must be a conditional expression with as many clauses as there are distinct sub-classes in the data definition.
   2. You must formulate one condition expression per `cond` line. Each expression involves the function parameter and identifies one of the sub-classes of data in the data definition.
5. Now that is time to code, go for each `cond` line, assume the input parameter meets the condition and therefore exploit its corresponding test cases. To formulate the corresponding result expression, you write down the computation for this example as an expression that involves the function parameter in some way.
6. Your attitude and behavior regarding tests keeps being the same.

### 4.7 Finite State Worlds





Apartado 6.1: Revisión de la Designt Recipe -> Hay más por extraer

To complete the definition, we figure out for each cond line how to combine the values we have in order to compute the expected result. Beyond the pieces of the input, we may also use globally defined constants, for example, BACKGROUND, which is obviously of help here; primitive or built-in operations; and, if all else fails, wish-list functions, that is, we describe functions we wish we had.



