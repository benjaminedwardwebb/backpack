function keys {
	YELLOW="\e[00;33m"
	MAGENTA="\e[00;35m"
	BLUE="\e[00;34m"
	BODY="\e[00;93m"

	ONE=",---,---,---,---,---,---,---,---,---,---,---,---,---,-----,\n"
	TWO="| \` | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | - | = | del |\n"
	THR="|---'-$MAGENTA,-'-,-'-,-'-,-'-,$BLUE-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,---|\n"
	FOU="| tab $MAGENTA| q | w | e | r |$BLUE t | y | u | i | o | p | [ | ] | \\ |\n"
	FIV="|-----$MAGENTA',--',--',--',--'$BLUE,--'$MAGENTA,--',--',--',--',$BLUE--',--',--'---|\n"
	SIX="| caps $MAGENTA| a |$BLUE s | d | f | g $MAGENTA| h | j | k | l |$BLUE ; | ' |  ret |\n"
	SEV="|------$MAGENTA'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'$BLUE-,-'-,-'------|\n"
	EIG="| S      $MAGENTA| z | x | c | v | b | n |$BLUE m | , | . | / |      S |\n"
	NIN="|---$MAGENTA,---,'--,'---|---'---'---'---'$BLUE---|---',--',--',---,---|\n"
	TEN="| F $MAGENTA| C |$BLUE M | X  |                   |  X | M | < | ^ | > |\n"
	ELE="'---$MAGENTA'---'$BLUE---'----'-------------------'----'-------'---'---'\n"

	printf "$BLUE"
	printf "$ONE"
	printf "$TWO"
	printf "$THR"
	printf "$FOU"
	printf "$FIV"
	printf "$SIX"
	printf "$SEV"
	printf "$EIG"
	printf "$NIN"
	printf "$TEN"
	printf "$ELE"
	printf "$BODY"

	return 0
}
