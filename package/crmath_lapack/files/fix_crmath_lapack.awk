# Awk program to modify LAPACK sources to use crlibm

# Add use statements after each function/subroutine statement

/^ {6}.*FUNCTION/ {
    state = "function"
    print
    next
}

/^ {6}SUBROUTINE/ {
    state = "subroutine"
    print
    next
}

!/^ {5}[$+]/ {
    if (state == "function" || state == "subroutine") {
	print "      use crmath" remap_list
	state = ""
    }
}

# Comment out intrinsic lines

/^ {6}INTRINSIC/ {
    state = "intrinsic"
    printf "*%s\n", $0
    next
}

/^ {5}[$+]/ {
    if (state == "intrinsic") {
	printf "*%s\n", $0
	next
    }
}

!/^ {5}\$/ {
    if (state == "intrinsic") {
	state = ""
    }
}

# Replace real selected exponentiations with exp/log equivalent

/EPS\*\*MEIGTH/ {
    gsub(/EPS\*\*MEIGTH/, "exp(MEIGHTH*log(EPS))")
    print
    next
}

/EPS\*\*MEIGHTH/ {
    gsub(/EPS\*\*MEIGHTH/, "exp(MEIGHTH*log(EPS))")
    print
    next
}

# Leave remaining lines as-is

1
