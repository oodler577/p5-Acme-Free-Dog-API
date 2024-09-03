package Acme::Free::Dog::API;

use v5.10;
use strict;
use warnings;

our $VERSION = '1.0.0';

use HTTP::Tiny;
use JSON            qw/decode_json/;
use Util::H2O::More qw/baptise ddd HTTPTiny2h2o/;

use constant {
    BASEURL => "https://dog.ceo/api/breeds",
};

sub new {
    my $pkg  = shift;
    my $self = baptise { ua => HTTP::Tiny->new }, $pkg;
    return $self;
}

sub random {
    my $self  = shift;
    my $URL   = sprintf "%s/%s", BASEURL, "image/random";
    my $resp  = HTTPTiny2h2o $self->ua->get($URL);
    die sprintf( "fatal: API did not a useful response (status: %d)\n", $resp->status ) if ( $resp->status != 200 );
    return $resp->content->message;
}

1;

__END__

=head1 NAME

Acme::Free::Dog::API - Perl API client for the Dog API service, L<https://dog.ceo/dog-api>.

This module provides the client, "woof", that is available via C<PATH> after install.

=head1 SYNOPSIS

  #!/usr/bin/env perl
    
  use strict;
  use warnings;
  
  use Acme::Free::Dog::API qw//;
  
  my $woof = Acme::Free::Dog::API->new;

  printf "%s\n", $woof->random;

=head2 C<woof> Commandline Client

After installing this module, simply run the command C<woof> without any arguments,
and you will get a random quote.

  shell> woof
  https://images.dog.ceo/breeds/basenji/n02110806_2249.jpg
  shell>

=head1 DESCRIPTION

This fun module is to demonstrate how to use L<Util::H2O::More> and
L<Dispatch::Fu> to make creating easily make API SaaS modules and
clients in a clean and idiomatic way. These kind of APIs tracked at
L<https://www.freepublicapis.com/> are really nice for fun and practice
because they don't require dealing with API keys in the vast majority of cases.

This module is the first one written using L<Util::H2O::More>'s C<HTTPTiny2h2o>
method that looks for C<JSON> in the C<content> key returned via L<HTTP::Tiny>'s
response C<HASH>.

=head1 METHODS

=over 4

=item C<new>

Instantiates object reference. No parameters are accepted.

=item C<categories>

Makes the SaaS API call to get the list of categories. It accepts no arguments.

=item C<< random >>

Returns a random dog image URL. 

=back

=head1 C<woof> OPTIONS

=over 4

=item C<random>

Prints the random dog image URL to C<STDOUT>.

=back

=head2 Internal Methods

There are no internal methods to speak of.

=head1 ENVIRONMENT

Nothing special required.

=head1 AUTHOR

Brett Estrade L<< <oodler@cpan.org> >>

=head1 BUGS

Please report.

=head1 LICENSE AND COPYRIGHT

Same as Perl/perl.
