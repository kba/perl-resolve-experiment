#!/usr/bin/perl
use strict;
use warnings;
use YAML::XS qw(LoadFile);
use Data::Dumper;
my $config = LoadFile('conf.yml');

my $action = shift @ARGV;

if ($action eq 'resolve-url') {
  for my $url (@ARGV) {
    for my $url_pattern (@{ $config->{url_pattern} }) {
      my $url_re = qr/$url_pattern/smx;
      if ($url =~ $url_re) {
        my $parsed = {
          ids => \%+
        };
        while (my ($pathType, $path) = each %{ $config->{filepath} }) {
          $parsed->{filepath}->{$pathType} = $path;
          while (my ($key, $value) = each %{ $parsed->{ids} }) {
            $parsed->{filepath}->{$pathType} =~ s/<$key>/$value/g;
          }
        }
        warn Dumper $parsed;
      }
    }
  }
} elsif ($action eq 'find') {
  # my $fn = shift @ARGV;
  # my %params;
  # my $params_str = shift @ARGV;
  # my @params_pairs = @ARGV


}
