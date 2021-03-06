use strict;
use warnings;

package Dist::Zilla::Plugin::Test::Fixme;

# ABSTRACT: Check code for FIXMEs.
use Moose;
use Data::Section -setup;
with 'Dist::Zilla::Role::FileGatherer', 'Dist::Zilla::Role::TextTemplate';

sub gather_files {
    my ( $self, ) = @_;

    require Dist::Zilla::File::InMemory;

    for my $filename (qw( xt/release/fixme.t )) {
        my $content = $self->fill_in_string(
            ${ $self->section_data($filename) },
            { skiptests => '' },
        );
        $self->add_file(
            Dist::Zilla::File::InMemory->new(
                {
                    'name'    => $filename,
                    'content' => $content,
                }
            ),
        );
    }
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

=begin :prelude

=for test_synopsis
1;
__END__

=end :prelude

=head1 SYNOPSIS

In C<dist.ini>:

    [Test::Fixme]

=head1 DESCRIPTION

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>, providing the
following file:

  xt/release/fixme.t - a standard Test::Fixme test

=head1 TODO

- Allow user to pass options to Test::Fixme

=head1 ACKNOWLEDGMENTS

Thanks to Edmund von der Burg and Graham Ollis for writing L<Test::Fixme>.

Code for this plugin based on L<Dist::Zilla::Plugin::Test::Kwalitee> by Alan Young.

=begin Pod::Coverage

  mvp_multivalue_args
  gather_files

=end Pod::Coverage

=cut

__DATA__
___[ xt/release/fixme.t ]___
#!perl

# This test is generated by Dist::Zilla::Plugin::Test::Fixme
use strict;
use warnings;

use Test::Fixme;
run_tests();
