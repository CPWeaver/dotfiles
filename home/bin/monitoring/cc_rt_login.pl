#!/usr/bin/perl

# script to monitor conference center for login page

## Configurables;
$search_string="Chairperson Login";
@cc_boxen=("dobra");
## End configurables

$element=0;

foreach $host(@cc_boxen)
	{
	chomp $host;
	@wget=`wget --output-document=- --no-check-certificate --output-file=/dev/null --keep-session-cookies --save-cookies=/tmp/cc_cookie 'https://dobra.ecovate.com/cc'`;
	check_cookie ();
	check_logon ();
	}

sub check_cookie
	{
	@cookies=`cat /tmp/cc_cookie | awk '{print $7}'`;
	@node_c=split(/\s+/,$cookies[6]);
	@host_cookie=split(/\./,$node_c[6]);
	$cookie_host=$host_cookie[1];
	chomp $host;
	chomp $cookie_host;
	if ($host eq $cookie_host)
		{
		$OK[$element]{cookie}="OK";
		}
	}

sub check_logon
	{
	foreach (@wget)
		{
		$OK[$element]{host}=$host;
		if ($_ =~ /$search_string/o)
			{
			$OK[$element]{status}="OK";
			}
		}
	$element++;
	}


# figure out our status

for ($count=0;$count<$element;$count++)
	{
	if ($OK[$count]{status} ne "OK")
		{
		print "CRITICAL: Houston $OK[$count]{host} has a problem!\n";
		exit (2);
		}
	if ($OK[$count]{cookie} ne "OK")
                {
                print "CRITICAL: Houston $OK[$count]{host} has a problem!\n";
                exit (2);
                }
	}

print "OK - Conference Center is Happy\n";
exit (0);
