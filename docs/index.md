# M346 - Dokumentation 
## Einleitung

Willkommen zur offiziellen Dokumentation des M346-Moduls! Diese Dokumentation bietet eine umfassende Anleitung zur Verwendung des M346-Moduls, das entwickelt wurde, um das Verkleinern von Bildgrößen zu erleichtern.

Wir haben ein Skript erstellt, das mithilfe von AWS CLI automatisch die Größe von Bildern reduziert. Dies wird durch die Integration von AWS S3 und Lambda-Funktionen ermöglicht, die eine nahtlose und effiziente Verarbeitung ermöglichen.

Unter [**Code**](./Skript.md) finden Sie unser Skript mit den einzelnen Erklärungen.

Unter [**Test**](./Tests.md) finden Sie die Tests zu unseren jeweiligen Codes.

## Installation 

### Systemanforderungen
- Stellen Sie sicher, dass Sie über eine stabile Internetverbindung verfügen.
- Stellen Sie sicher, dass die AWS CLI auf Ihrem System installiert ist und ordnungsgemäß konfiguriert ist.




## Verwendung
## Lizenzinformationen 




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