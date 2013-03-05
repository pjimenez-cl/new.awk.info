---
layout: default
title: "Shorten Your Pipes"
tags: [tip, pipes, external_links]
---

# {{ page.title }}

*[m0j0][1] writes in [his blog][2]...*

I was lurking around on twitter during my lunch hour (yes, even
freelancers need a lunch hour), and @bitprophet tweeted thusly:

> *Get syslog-owned log names from syslog.conf:*
> `grep -v "^#" syslog.conf | 
> awk "{print $2}" | egrep -v "^(\*|\|)" | 
> sed "/^$/ d" | sed "s/^-//"`

Followed by this:

> *(Interested to see if anyone can shorten my previous tweet's command
> line, outside of using `cut` instead of the awk bit.)*

I happen to love puzzles like this, and my lunch was almost immediately
followed by a long, boring conference call.

 @bitprophet's pipeline above is translated by my brain into the English:

> Find non-commented lines, grab the second space-delimited field, then
> filter out the ones that start with "\*" or "\|", then delete any blank
> lines, and strip any leading "\-" from the result.

My brain usually attempts to think of the English version of the solution
*first*, and then try to emulate that in the code/command I write. So,
the issue here is we want to find file paths (and apparently sockets are
ok, too, as "@" is a valid leading character in the initial definition
of the problem). If it's a file path, we want to see it in a form that
would be suitable for passing it to something like "ls -l", which means
leading symbols like "-" and "|" should be omitted.

In a syslog.conf file, the main meat is the area where you specify the
warning levels, and the file you want messages at that warning level sent
to (this is a simplistic explanation, but good enough to understand the
solution I came up with). The file is also littered with comments. Here's
the file on my Mac:

	*.err;kern.*;auth.notice;authpriv,remoteauth,install.none;mail.crit        /dev/console
	*.notice;authpriv,remoteauth,ftp,install.none;kern.debug;mail.crit    /var/log/system.log

	# Send messages normally sent to the console also to the serial port.
	# To stop messages from being sent out the serial port, comment out this line.
	#*.err;kern.*;auth.notice;authpriv,remoteauth.none;mail.crit        /dev/tty.serial

	# The authpriv log file should be restricted access; these
	# messages shouldn't go to terminals or publically-readable
	# files.
	auth.info;authpriv.*;remoteauth.crit            /var/log/secure.log

	lpr.info                        /var/log/lpr.log
	mail.*                            /var/log/mail.log
	ftp.*                            /var/log/ftp.log

	install.*                        /var/log/install.log
	install.*                        @127.0.0.1:32376
	local0.*                        /var/log/appfirewall.log
	local1.*                        /var/log/ipfw.log
	stuff.*                            -/boo
	things.*                        |/var/log
	*.emerg                            *

So, in English, my brain parses the problem like this:

> Skip blank lines, commented lines, and lines where the file name is
> "\*", and give me everything else, but strip off characters "\-" and "\|"
> before sending it to the screen.

And here's my awk one-liner for doing that:

{% highlight awk %}
awk '$0 !~ /^$|^#/ && $2 !~ /^\*/ {sub(/^-|^\|/,"",$2);print $2}' syslog.conf
{% endhighlight %}

Knowing a few key things about awk will help parse the above:

Awk automatically breaks up each line of input into fields. If you don't
tell it what to use as a delimiter, it'll just use any number of spaces
as the delimiter. If you have a CSV file, you'd likely use `awk -F,` to
tell awk to use a comma. For /etc/passwd, use `awk -F:`. From there, you
can reference the first field as $1, the second as $2, etc. $0 represents
the whole line. There are more, but that's enough for this example.

Though I think most sysadmins can get a lot done with simple usage
like `awk -F: '{print $2}'`, sometimes more power is needed, and awk
delivers. It uses the basic regex engine, and enables you to check a field
(or the whole line: $0, like I do above) against a regex as a precondition
for performing some action with the line or a field on that line. So,
in the above awk command, I check to see if the line is either empty,
or a comment. I then use a logical AND to check if field 2 starts with
"\*". If the current line is a match for any of these rules it is skipped.

Another nice thing about awk is that it actually is a Turing-complete
programming language. After I check the lines of input against the rules
mentioned above, I immediately know that I definitely want at least some
portion of $2 in the remaining lines. What I *don't* want are preceding
characters like "-" or "|". I need to strip them from the file name. I
use awk's built in `sub()` function to handle that, and with that out
of the way I call `print` to send the result to the screen.

[1]: http://www.protocolostomy.com/author/m0j0/
[2]: http://www.protocolostomy.com/2009/07/27/awk-idioms-shorten-your-pipelines-consolidate-your-tool-set/
