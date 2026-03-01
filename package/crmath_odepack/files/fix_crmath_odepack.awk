# Awk program to modify ODEPACK sources to use crlibm

# Add use statement after each function/subroutine statement

/^ {6}FUNCTION/ {
    state = "function"
    print
    next
}

/^ {6}SUBROUTINE/ {
    state = "subroutine"
    print
    next
}

!/^ {5}[0-9]/ {
    if (state == "function" || state == "subroutine") {
	print "      use crmath"
	state = ""
    }
}

# Leave remaining lines as-is

1
