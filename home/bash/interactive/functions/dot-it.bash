# Wraps GraphViz's dot utility with my most common arguments.
#
# Accepts only one argument, but any valid argument to dot should work. This
# is related to how the arguments are passed into the nix-shell command.
function dot-it {
	nix-shell -p graphviz --run "dot -T png -O $@"
}
