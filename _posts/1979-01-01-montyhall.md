---
layout: default
title: 'The Monty Hall Problem'
tags: [ fun, tutorial, working_example, posix ]
---

## {{ page.title }}

#### Description

Donald 'Paddy' McCarthy has a nice Awk
solution to the [Monty Hall Problem](http://en.wikipedia.org/wiki/Monty_Hall_problem),
which he describes as follow:

- The contestant in in front of three  doors that he cannot see behind..
- The three doors conceal one prize and the rest being booby prizes,
  arranged randomly.
- The Host asks the contestant to choose a door.
- The host then goes behind the doors where only he can see what is concealed,
  then always opens one door, out of the other s not chosen by the contestant,
  that must reveal a booby prize to the contestant.
- The host then asks the contestant if he would like either to stick with his
  previous choice, or switch and choose the other remaining closed door.

It turns out that if the contestant follows a strategy of always switching
when asked, then he will maximise his chances of winning.

Donald's simulator shows that:
- A strategy of never switching wins 1/3rd of the time.
- A strategy of randomly switching wins 1/2 of the time.
- A strategy of always switching wins 2/3rds of the time.

#### Example

    gawk -f montyHall.awk
    
    Monty Hall problem simulation:
    3 doors, 10000 iterations.
    
      Algorithm    keep: prize count = 3411, =  34.11%
      Algorithm  switch: prize count = 6655, =  66.55%
      Algorithm  random: prize count = 4991, =  49.91%

#### Code

{% highlight awk %}
{% insert_example lib/awk/montyhall.awk %}
{% endhighlight %}

#### Download

[montyhall.awk]({{site.baseurl}}/lib/awk/montyhall.awk)

#### Author

Donald 'Paddy' McCarthy ( paddy3118@googlemail.com )
