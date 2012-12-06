---
layout: default
title: 'Tic-Tac-Toe'
tags: [ 'fun', 'working_example' ]
---

## Tic-Tac-Toe

#### Synopsis

To let the computer play first, run: `awk -f 15.awk -v start=1`

To play first, run: `awk -f 15.awk -v start=2`


#### Description

Each move is one square (in the range 1..9).

#### Example

    $ gawk -f 15.awk -v start=1
    6
    9
    1
    3
    8
    I win!

#### Download

[tictactoe.awk]({{site.baseurl}}/lib/awk/tictactoe.awk)

#### Code

{% highlight awk %}
{% insert_example lib/awk/tictactoe.awk %}
{% endhighlight %}

#### Author

Aaron S. Hawley
