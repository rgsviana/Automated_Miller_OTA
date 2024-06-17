use strict;
use warnings; 

# Put the file name in a string variable
# so we can use it both to open the file
# and to refer to in an error message
# if needed.

my @a = (1..10);

for(@a){

	my $min_length = 130;
	my $length = $_*$min_length;

	my $file = "pmos". $_ . ".cir";

	# Use the open() function to create the file.
	unless(open FILE, '>'.$file) {
    	# Die with error message 
    	# if we can't open it.
    	die "\nUnable to create $file\n";
	}

	# Write some text to the file. 

	print FILE "*** LUT Generation for Analog Design ***\n";
	print FILE ".include param" . $length . ".inc\n\n";
	print FILE ".include pmos130nm.pm\n\n";
	print FILE "*** Voltage Sources ***\n";
	print FILE "vdrain	drain 	0	dc 0\n";	
	print FILE "Vsource	source  0	dc 0\n";
	print FILE "Vgate	gate	0	dc 0\n";
	print FILE "Vbulk   bulk	0	dc 0\n\n";

	print FILE "*** Circuit ***\n";
	print FILE "m1	drain gate source bulk pmos w=width l=length ps=p_source pd=p_drain as=a_source ad=a_drain\n\n";

	print FILE "*** Analysis ***\n";
	print FILE ".save \@m1[l]\n";
	print FILE ".save \@m1[vgs]\n";
	print FILE ".save \@m1[vds]\n";
	print FILE ".save \@m1[igd]\n";
	print FILE ".save \@m1[igs]\n";
	print FILE ".save \@m1[id]\n";
	print FILE ".save \@m1[gm]\n";
	print FILE ".save \@m1[gmbs]\n";
	print FILE ".save \@m1[gds]\n";
	print FILE ".save \@m1[cgg]\n";
	print FILE ".save \@m1[cgs]\n";
	print FILE ".save \@m1[cgd]\n";
	print FILE ".save \@m1[cdg]\n";
	print FILE ".save \@m1[cgb]\n";
	print FILE ".save \@m1[cdd]\n";
	print FILE ".save \@m1[csg]\n\n";

	print FILE ".control\n";
	print FILE "dc vdrain 0 -1.3 -0.01 vgate 0 -1.3 -0.01\n\n";
	print FILE "print \@m1[vgs] \@m1[vds] \@m1[igd] \@m1[igs] \@m1[id] \@m1[gm] \@m1[gmbs] \@m1[gds] \@m1[cgg] \@m1[cgs] \@m1[cgd] \@m1[cdg] \@m1[cgb] \@m1[cdd] \@m1[csg]\n\n"; 
	print FILE ".endc\n\n";
	print FILE ".end\n";



	# close the file.

	close FILE;
}

