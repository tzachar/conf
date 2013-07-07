#!/usr/bin/perl

my %translations = (

	'zweb.h'	=> 'include\zweb.h',
	'trade_info_channel.h'	=> 'include\trade_info_channel.h',
	'AuditMsg.h'	=> 'include\AuditMsg.h',
	'Sanity.h'	=> 'include\Sanity.h',
	'prices.h'	=> 'include\prices.h',
	'zeus.h'	=> 'include\zeus.h',
	'RiskRule.h'	=> 'include\RiskRule.h',
	'zmodule.h'	=> 'include\zmodule.h',
	'RiskRule.cpp'	=> 'src\RiskRule.cpp',
	'trade_info_channel.cpp'	=> 'src\trade_info_channel.cpp',
	'zweb.cpp'	=> 'src\zweb.cpp',
	'main.cpp'	=> 'src\main.cpp',
	'zeus.cpp'	=> 'src\zeus.cpp',
	'Sanity.cpp'	=> 'src\Sanity.cpp',
	'prices.cpp'	=> 'src\prices.cpp',

);

while (<>)
{
	chomp($_);
	my $line = $_;
	foreach my $match (keys %translations) {
		# this line is for vcprojs.
		$line =~ s/"$match"/"$translations{$match}"/g;
		$line =~ s#".*/$match"#"$translations{$match}"#g;
		$line =~ s#".*\\$match"#"$translations{$match}"#g;
	}
	print $line . "\n";
}
