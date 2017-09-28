# Displays current time in the Pacific Standard Time timezone.
if dependency date; then
	function pst {
		TZ="US/Pacific" date
	}
fi
