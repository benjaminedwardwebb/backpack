# Displays current time in the Universal Coordinated Time timezone.
if dependency date; then
	function utc {
		TZ="UTC" date
	}
fi
