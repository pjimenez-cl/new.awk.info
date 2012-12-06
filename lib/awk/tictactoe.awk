BEGIN {
    winning_sum = 15;
    max_play = 9;
    used[0] = 1;
    my_sum = your_sum = 0;
    if (start == 1) {
        answer = ftw(used, my_sum);
	used[answer] = 1;
	my_sum += answer;
	print answer;
    }
    halted=0;
}

! /^[1-9]$/ {
    print "Illegal play: " $0;
}

{
    if ($0 in used) {
        print "Illegal play: " $0;
    } else {
        used[$0] = 1;
        your_sum += $0;
        if (your_sum == winning_sum) {
            print "You win!";
	    halted=1
	    exit 0
        } else if (your_sum > winning_sum && my_sum > winning_sum) {
            print "Draw";
	    halted=1;
	    exit 2;
        } else {
	    answer = block = winning_sum - your_sum;
	    winning_move = ftw(used, my_sum);
            if (block > max_play \
		|| block <= 0 \
		|| block in used) {
                answer = winning_move;
	    }
	    while (answer <= 0 || answer > max_play || answer in used) {
		answer++;
	    }
            my_sum += answer;
            used[answer] = 1;
            print answer;
            if (my_sum == winning_sum) {
                print "I win!";
		halted=1;
		exit 1;
            }
        }
    }
}

END {
    if (halted == 1) {
	exit;
    }
    if (your_sum != winning_sum && my_sum != winning_sum) {
	print "I win by forfeit";
	exit 1;
    }
}

function ftw(used, sum) {
    strlst = "";
    for (v in used) {
        strlst = strlst "" v;
    }
    to_win = try(strlst, max_play "", sum);
    if (to_win == "") {
        return -1;
    }
    return substr(to_win, 1, 1);
}

function try(used, hunches, sum) {
    curr_sum = strsum(hunches) + sum;
    curr_hunch = substr(hunches, 1, 1);
    next_hunch = curr_hunch - 1;
    if (hunches == "") {
        return "";
    } else if (curr_hunch < 1) {
        return substr(hunches, 2);
    } else if (index(used, curr_hunch) || curr_sum > winning_sum) {
        return try(used, next_hunch "" substr(hunches, 2), sum);
    } else if (curr_sum == winning_sum) {
        return hunches;
    }
    return try(curr_hunch "" used, next_hunch "" hunches, sum);
}

function strsum(str) {
    s = 0;
    str_length = length(str);
    for (i = 1; i <= str_length; i++) {
        s += substr(str, i, 1);
    }
    return s;
}
