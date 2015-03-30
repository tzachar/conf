#!/usr/bin/perl

use strict;
sub generate_last_digit{
	my $digit = 0;
	my $sum = 0;
	for (my $i=0; $i< $#_+1; $i++){
		my $tmp = $i%2 +1;
		$tmp = $tmp*$_[$i];
		#a two digit number becomes one:
		while ($tmp >= 10){
			$tmp = int($tmp/10) + ($tmp%10);
		}
		$sum += $tmp;
	}
	$sum = $sum %10;
	return (10 - $sum)%10;
}

my @id = (0);
my $ID_LENGTH = 9;

for (my $i=1; $i<$ID_LENGTH-1; $i++){
	my $digit = int(rand(10)); # get a new random digit
	$id[$i] = $digit;
}

$id[$ID_LENGTH-1] = generate_last_digit @id;

for (my $i=0; $i< scalar @id; $i++){
	print "$id[$i]";
}
print "\n";

