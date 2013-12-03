#!/usr/bin/perl

# script to monitor the converence center API

$CC_HOST=$ARGV[0];


# Pull down html from CC
@wget=`wget --output-document=- --timeout=20 --no-check-certificate --output-file=/dev/null https://$CC_HOST/api/1.3/svc`;


## fetch the current bridge
foreach (@wget)
	{
	if ($_ =~ /Available SOAP services/o)
		{
		$soap_services="1";
		}
        if ($_ =~ /Available RESTful services/o)
                {
		$restful_services="1"
                }
	}

# 1 + 1 = 2, or it's critical

$total=($soap_services + $restful_services);

if ($total eq 2)
	{
	print "OK: API sheilds are at 100%\n";
	exit (0);
	}
else
	{
	print "CRITICAL: API failure!\n";
	exit (2);
	}
