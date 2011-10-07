use strict;
use warnings;
use ExtUtils::MakeMaker;
use Config;

my %args = (
	pkg_name => 'jirc-bridge',
	name     => 'jirc',
	DESTDIR  => undef,
);
my @pass_args;
while (my $arg = shift @ARGV) {
    my ($key, $value) = split /=/, $arg;
        if (exists $args{$key}) {
        $args{$key} = $value;
    } else {
        push @pass_args, $arg;
    }
}
@ARGV = @pass_args;


my %opts=(
    'INSTALLDIRS'   => 'site',
    'NAME'          => $args{'name'},
    'AUTHOR'        => 'Kees Cook <kees@outflux.net>',
    'VERSION_FROM'  => 'scripts/jirc', # finds $VERSION
    'ABSTRACT_FROM' => 'scripts/jirc',
    'EXE_FILES'     => [ qw(
    				scripts/jirc
			) ],
    'PREREQ_PM'     => {
		'Config::Simple' => 0,
    		'POE' => 0,
		'POE::Component::IRC' => 0,
		'POE::Component::Jabber' => 0,
		'POE::Filter::XML' => 0,
		'XML::Stream::Parser' => 0,
		'Net::Jabber' => 0,
	},
);

#if ($ExtUtils::MakeMaker::VERSION > 5.45) {
#        $opts{'PREREQ_FATAL'} = 1,
#}

# This puts us in the site_perl directory, not dependant on any version
# of perl.
if (defined($Config{'sitelib_stem'}) && $Config{'sitelib_stem'} ne "") {
        #print "stem is: $Config{'sitelib_stem'}\n";
        $opts{'INSTALLSITELIB'} = "";
        $opts{'INSTALLSITELIB'} = $args{'DESTDIR'}
                if (($] >= 5.008 && $] < 5.008005) ||
                    $ExtUtils::MakeMaker::VERSION =~ /5\.9[1-6]|6\.0[0-5]/);
        $opts{'INSTALLSITELIB'} .= $Config{'sitelib_stem'};
}

WriteMakefile(%opts);

# /* vi:set ai ts=4 sw=4 expandtab: */
