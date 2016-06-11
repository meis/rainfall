#!/usr/bin/env perl

use v5.10;
use strict;
use utf8;
use Test::More;
use Rainfall;

subtest 'Top values in array' => sub {
    my ($top, $occurrences);

    ($top, $occurrences) = Rainfall::top_values();
    is($top, 0);
    is($occurrences, 0);

    ($top, $occurrences) = Rainfall::top_values(0);
    is($top, 0);
    is($occurrences, 1);

    ($top, $occurrences) = Rainfall::top_values(0,1,1);
    is($top, 1);
    is($occurrences, 2);

    ($top, $occurrences) = Rainfall::top_values(0,0,0,1);
    is($top, 1);
    is($occurrences, 1);
};

subtest 'Amount for column' => sub {
    is(Rainfall::amount_for_column(0,0,0), 0);
    is(Rainfall::amount_for_column(1,0,0), 0);
    is(Rainfall::amount_for_column(0,1,0), 0);
    is(Rainfall::amount_for_column(0,1,1), 0);
    is(Rainfall::amount_for_column(0,8,1), 0);
    is(Rainfall::amount_for_column(1,0,1), 1);
    is(Rainfall::amount_for_column(4,0,1), 1);
    is(Rainfall::amount_for_column(1,0,4), 1);
    is(Rainfall::amount_for_column(8,1,4), 3);
};

subtest 'Total amount of water' => sub {
    my @walls;

    @walls = ();
    is(Rainfall::amount(@walls), 0);

    @walls = (1);
    is(Rainfall::amount(@walls), 0);

    @walls = (1,1);
    is(Rainfall::amount(@walls), 0);

    @walls = (1,2,1);
    is(Rainfall::amount(@walls), 0);

    @walls = (1,0,1);
    is(Rainfall::amount(@walls), 1);

    @walls = (5,4,3,2,1,0);
    is(Rainfall::amount(@walls), 0);

    @walls = (5,4,3,2,1,0,3);
    is(Rainfall::amount(@walls), 6);

    @walls = (2,5,1,2,3,4,7,7,6);
    is(Rainfall::amount(@walls), 10);

    @walls = (2,5,1,3,1,2,1,7,7,6);
    is(Rainfall::amount(@walls), 17);
};

done_testing();
