# Awk program to modify LAPACK sources to use crlibm

# Add use statements after each function/subroutine statement

/^ *END FUNCTION/ {
    print
    next
}

/^ *[^!]*FUNCTION.*& *$/ {
    state = "function"
    print
    next
}

/^ *[^!]*FUNCTION/ {
    print
    print "use crmath"
    next
}

/^ *END SUBROUTINE/ {
    print
    next
}

/^ *SUBROUTINE.*& *$/ {
    state = "subroutine"
    print
    next
}

/^ *SUBROUTINE/ {
    print
    print "use crmath"
    next
}

!/& *$/ {
    if (state == "function" || state == "subroutine") {
	print 
	print "use crmath"
	state = ""
	next
    }
}

# Comment out intrinsic lines

/^ *INTRINSIC/ {
    printf "!%s\n", $0
    next
}

# Leave remaining lines as-is

1
