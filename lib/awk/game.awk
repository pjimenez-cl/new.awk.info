function intro() {
	print
	print "You are a brave adventurer. You have entered a hidden"
	print "cave just outside town, that is rumored to hold gold!"
	print "To win this adventure, you need to get the gold."
}

function invent() {
	if (coin || axe || sword)
	print "You are carrying: "
	if (coin) print "coin"
	if (axe) print "big, rusty battle axe"
	if (sword) print "small sword"
}
function input( x ) {
	printf( "\nCOMMAND> ")
	getline x
	return x
}
function cave() {
	print
	print "You are standing in a cave. Sunlight gleams behind you"
	print "from the entrance. In front of you, is a wooden door."
	print "You see an opening to the left, and one to the right."
	print
	invent()
	print
	print "What do you want to do? "
	print
	print "(o)pen wooden door"
	print "go (l)eft"
	print "go (r)ight"
	print "leave thru the (e)ntrance"
	if (sword) print "break door with your (s)word"
	if (axe) print "break door with your (a)xe"
	print "(y)ell Open Sesame"
	print "e(x)amine area"
	print "read (i)ntroduction"
	x = input()
	if (x=="o") {print "The wooden door is shut tight."; cave()}
	if (x=="l") {deadend()}
	if (x=="r") {cave2()}
	if (x=="e") {print "You decide to quit. Goodbye!";exit}
	if (sword&&x=="s") {print "your sword breaks!";sword=0;cave()}
	if (axe&&x=="a") {
		print "You chop down the door and find the gold!!"
		print "Great job, bold adventurer!"
		print "This is the end of this adventure, but"
		print "you have a promising career ahead of you!"
		exit;
	}
	if (x=="y") {
		print "A band of evil goblins passing by the entrance"
		print "hear you, enter the cave, and kill you"
		exit;
	}
	if (x=="x") {print "You find nothing";cave()}
	if (x=="i") {intro();cave()}
	print "What do you want to do?";cave()
}

function deadend() {
	print
	print "You are in a dead end"
	print
	invent()
	print
	print "What do you want to do? "
	print
	print "go (b)ack"
	print "e(x)amine area"
	print "read (i)ntroduction"
	x= input();
	if (x=="b") {cave()}
	if (x=="x") {print "You find a sword!";sword=1;deadend()}
	if (x=="i") {intro();deadend()}
	print "What do you want to do?";deadend()
}

function cave2() {
	print
	print "You are in another cave."
	print "You can go back, or explore a niche to the left."
	print
	invent()
	print
	print "What do you want to do? "
	print
	print "go (b)ack"
	print "enter (n)iche"
	if (rubble) print "(s)earch rubble"
	print "e(x)amine area"
	print "read (i)ntroduction"
	x = input()
	if (x=="b") {cave()}
	if (x=="n") {niche()}
	if (rubble&&x=="s"&&!coin) {print "you found a coin!";coin=1;cave2()}
	if (rubble&&x=="s"&&coin) {print "you found a nothing!";cave2()}
	if (x=="x") {print "You see a pile of rubble";rubble=1;cave2()}
	if (x=="i") {intro();cave2()}
	print "What do you want to do?";cave2()
}

function niche() {
	print
	print "You are in a niche."
	print "There is a dwarf here!"
	print
	invent()
	print
	print "What do you want to do? "
	print
	print "go (b)ack"
	print "(t)alk to dwarf"
	if (!sword&&!axe) print "(f)ight dwarf"
	if (sword) print "fight dwarf with (s)word"
	if (axe) print "fight dwarf with (a)xe"
	if (coin) print "(o)ffer coin to dwarf"
	print "e(x)amine area"
	print "read (i)ntroduction"
	x = input()
	if (x=="b") {cave2()}
	if (x=="t") {print "The dwarf grunts";niche()}
	if (x=="f") {print "The dwarf kills you";exit}
	if (x=="s") {print "The dwarf kills you";exit}
	if (x=="a") {print "The dwarf kills you";exit}
	if (coin&&x=="o") {print "The dwarf takes the coin and gives you a n axe!";coin=0;axe=1;niche()}
	if (x=="x") {print "You find nothing";niche()}
	if (x=="i") {intro();niche()}
	print "What do you want to do?";niche()
}

BEGIN { intro(); cave() }

## awk.info:
## AWK Example: game.awk
##
## This AWK example was downloaded from the 'http://awk.info' website.
##
## Author:
##  Praveen Puri has been a programmer and full-time trader. He is the authorof [Stock](http://www.amazon.com/Stock-Trading-Riches-Powerful-Transforms/dp/1434809870)which teaches his stocktrading system.
##
