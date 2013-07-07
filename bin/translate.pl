#!/usr/bin/perl

my %translations = (
	'webgui.h'	=> 'WebGui/webgui.h',
	'platform.h'	=> 'WebGui/platform.h',
	'mongoose.h'	=> 'WebGui/mongoose.h',
	'sorttable.h'	=> 'WebGui/sorttable.h',
);

while (<>)
{
	chomp($_);
	my $line = $_;
	foreach my $match (keys %translations) {
		$line =~ s/\#include.*<$match>/\#include <$translations{$match}>/g;
		$line =~ s/\#include.*<.*\/$match>/\#include <$translations{$match}>/g;
		$line =~ s/\#include.*<.*\\$match>/\#include <$translations{$match}>/g;

		$line =~ s/\#include.*"$match"/\#include "$translations{$match}"/g;
		$line =~ s/\#include.*".*\/$match"/\#include "$translations{$match}"/g;
		$line =~ s/\#include.*".*\\$match"/\#include "$translations{$match}"/g;
	}
	print $line . "\n";
}
