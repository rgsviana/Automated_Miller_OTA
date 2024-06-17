use strict;
use warnings; 

# Put the file name in a string variable
# so we can use it both to open the file
# and to refer to in an error message
# if needed.

my @a = (1..10);

for(@a){

	my $min_length = 0.13;
	my $width = 10;
	my $length = $_*$min_length;
	my $perim = 2*$width+10*$min_length;
	my $area = (3*$min_length)*(2*$min_length+$width);


	my $file = "param". 1000*$length . ".inc";

	# Use the open() function to create the file.
	unless(open FILE, '>'.$file) {
    	# Die with error message 
    	# if we can't open it.
    	die "\nUnable to create $file\n";
	}

	# Write some text to the file. 

	print FILE ".param length=" . $length . "u\n";
	print FILE ".param width=" . $width . "u\n";
	print FILE ".param p_source=" . $perim . "u\n";
	print FILE ".param p_drain=" . $perim . "u\n";
	print FILE ".param a_source=" . $area . "p\n";
	print FILE ".param a_drain=" . $area . "p\n";

	# close the file.

	close FILE;
}

