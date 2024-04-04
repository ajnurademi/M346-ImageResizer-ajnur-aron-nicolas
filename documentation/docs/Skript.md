---
runme:
  id: 01HTNN62EEWHEPK7PNRHF9WARF
  version: v3
---

# M346 - Script documentation

## Codeblocks

Some `code` goes here.

## Plain codeblock

A plain codeblock:

```ini {"id":"01HTNN62EEWHEPK7PNR8SHJGPN"}
Some code here
def myfunction()
// some comment

```

## Code for a specific language

Some more code with the `py` at the start:

```py {"id":"01HTNN62EEWHEPK7PNRA64GKN3"}
import tensorflow as tf
def whatever()

```

## With a title

```py {"id":"01HTNN62EEWHEPK7PNRCPZXRDT"}
def bubble_sort(items):
    for i in range(len(items)):
        for j in range(len(items) - 1 - i):
            if items[j] > items[j + 1]:
                items[j], items[j + 1] = items[j + 1], items[j]

```

## With line numbers

```py {"id":"01HTNN62EEWHEPK7PNRCV7T1ZY"}
def bubble_sort(items):
    for i in range(len(items)):
        for j in range(len(items) - 1 - i):
            if items[j] > items[j + 1]:
                items[j], items[j + 1] = items[j + 1], items[j]

```

## Highlighting lines

```py {"id":"01HTNN62EEWHEPK7PNRFFF1J14"}
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