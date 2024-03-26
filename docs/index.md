# M346 - Dokumentation


## Einleitung

Willkommen zur offiziellen Dokumentation des M346-Moduls! Diese Dokumentation bietet eine umfassende Anleitung zur Verwendung des M346-Moduls, das entwickelt wurde, um das Verkleinern Bildgrössen zu erleichtern....

## Codeblocks

Some `code` goes here.

## Plain codeblock

A plain codeblock:

```
Some code here
def myfunction()
// some comment
```

## Code for a specific language

Some more code with the `py` at the start:

``` py
import tensorflow as tf
def whatever()
```

## With a title

``` py title="bubble_sort.py"
def bubble_sort(items):
    for i in range(len(items)):
        for j in range(len(items) - 1 - i):
            if items[j] > items[j + 1]:
                items[j], items[j + 1] = items[j + 1], items[j]
```

## With line numbers

``` py linenums="1"
def bubble_sort(items):
    for i in range(len(items)):
        for j in range(len(items) - 1 - i):
            if items[j] > items[j + 1]:
                items[j], items[j + 1] = items[j + 1], items[j]
```

## Highlighting lines

``` py hl_lines="2 3"
def bubble_sort(items):
    for i in range(len(items)):
        for j in range(len(items) - 1 - i):
            if items[j] > items[j + 1]:
                items[j], items[j + 1] = items[j + 1], items[j]
```

## Icons and Emojs

:smile: 

:fontawesome-regular-face-laugh-wink:

:fontawesome-brands-twitter:{ .twitter }

:octicons-heart-fill-24:{ .heart }