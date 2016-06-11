package Rainfall;

use v5.10;
use strict;
use utf8;
use List::Util qw/min max/;

sub amount {
    my @heights = @_;
    my $amount = 0;

    my $left_top = 0;
    my ($right_top, $remaining_right_tops) = top_values(@heights);

    while (@heights) {
        my $current = shift @heights;
        die 'Illegal height' unless $current >= 0;

        # Recalculate right top
        if ($current == $right_top) {
            if ($remaining_right_tops > 1) {
                $remaining_right_tops--;
            }
            else {
                ($right_top, $remaining_right_tops) = top_values(@heights);
            }
        }

        # Amount of water
        $amount += amount_for_column($left_top, $current, $right_top);

        # Recalculate left top
        $left_top = $current if ($current > $left_top)
    }

    $amount;
}

# Amount of water in a specific column given the highest columns at their
# right and left.
sub amount_for_column {
    my ($top_left, $column, $top_right) = @_;

    max(0, min($top_left, $top_right) - $column);
}

# Highest number in a list and the number of occurrences.
sub top_values {
    my @heights = @_;

    my $top = 0;
    my $occurrences = 0;

    for my $index (0..@heights-1) {
        my $diff = $heights[$index] - $top;

        # New occurrence of the same top
        if ($diff == 0) {
            $occurrences++;
        }
        # New top height
        elsif ($diff > 0) {
            $top = $heights[$index];
            $occurrences = 1;
        }
    }

    return ($top, $occurrences);
}

1;
