#!/usr/bin/perl

# script to monitor for happy active MQ

# ARGV
# ./MQ_mon.pl <FQDN> <PORT> <SMQ WARN> <SMQ CRIT> <LMQ WARN> <LMQ CRIT>
# ./MQ_mon.pl $smq_warn $smq_crit $lmq_warn $lmq_crit

($fqdn, $port, $smq_warn,$smq_crit,$lmq_warn,$lmq_crit) =@ARGV;

## Configurables;
$search_small="SMALL_EVENT_QUEUE";
$search_large="LARGE_EVENT_QUEUE";
$search_failed="FAILED_EVENT_QUEUE";
$search_dead="ActiveMQ.DLQ";
@cc_boxen=("dobra.ecovate.com");
## End configurables

$element=0;

@wget=`wget --output-document=- --no-check-certificate --output-file=/dev/null 'http://$fqdn\:$port/admin/queues.jsp'`;
#print "Ran: wget --output-document=- --no-check-certificate --output-file=/dev/null 'http://$fqdn\:$port/admin/queues.jsp'\n"; #DEBUG
check_jsp ();

sub check_jsp
	{
	#print "Checking JSP\n"; #DEBUG
	$SMQ_line=0;
	$LMQ_line=0;
	$OK[$element]{count}=1;
	foreach (@wget)
		{
		$OK[$element]{host}=$host;
		if ($_ =~ /$search_small/o)
			{
			#print "Found search string $search_small\n"; #DEBUG
			#$OK[$element]{status}="OK";
			find_small_queue ();
			}
		if ($_ =~ /$search_large/o)
			{
			find_large_queue ();
			}
		if ($_ =~ /$search_failed/o)
			{
			#print "Found Failed Queue\n";
			find_failed_queue ();
			}
		if ($_ =~ /$search_dead/o)
			{
			#print "Found Dead Queue\n";
			find_dead_queue ();
			}

		if ($OK[$element]{count} == $SMQ_line)
			{
			chomp $_;
			# find_small_queue let us know where to find our queue length
			# now we just need to extract it from the html. I will use 
			# split, since I know and love it. 
			($smq_f1, $smq_f2)=split(/\>/, $_);
			($smqueue_size, $foo) = split (/\</, $smq_f2);
			$OK[$element]{small_queue} = $smqueue_size;
			#print "Small Queue Size:  $smqueue_size\n"; ## DEBUG
			}
		if ($OK[$element]{count} == $LMQ_line)
			{
			chomp $_;
			# find_large_queue let us know where to find our queue length
			# same exact plan as with the small queue....
			($lmq_f1, $lmq_f2)=split(/\>/, $_);
			($lmqueue_size, $foo) = split (/\</, $lmq_f2);
			$OK[$element]{large_queue} = $lmqueue_size;
			#print "Large Queue Size:  $lmqueue_size\n"; ## DEBUG
			}
		if ($OK[$element]{count} == $FMQ_line)
			{
			chomp $_;
			# find_large_queue let us know where to find our queue length
			# same exact plan as with the small queue....
			($fmq_f1, $fmq_f2)=split(/\>/, $_);
			($fmqueue_size, $foo) = split (/\</, $fmq_f2);
			$OK[$element]{failed_queue} = $fmqueue_size;
			#print "Failed Queue Size:  $fmqueue_size\n"; ## DEBUG
			}
		if ($OK[$element]{count} == $DMQ_line)
			{
			chomp $_;
			# find_large_queue let us know where to find our queue length
			# same exact plan as with the small queue....
			($dmq_f1, $dmq_f2)=split(/\>/, $_);
			($dmqueue_size, $foo) = split (/\</, $dmq_f2);
			$OK[$element]{dead_queue} = $dmqueue_size;
			#print "Dead Queue Size:  $dmqueue_size\n"; ## DEBUG
			}
		$OK[$element]{count}++;
		}
	$element++;
	}

sub find_small_queue 
	{
	if ($small_flag ne "True")
		{
		# Queue was found on the current line, which is 1 more then $OK[$element]{count}
		# hence, we are going to check whats in-between our <td></td> on the next line
		# thats 2+$OK[$element]{count} ;)
		$SMQ_line=($OK[$element]{count} + 1);
		$small_flag="True";
		$OK[$element]{small_queue_present}="True";
		}
	}
sub find_large_queue
	{
	if ($large_flag ne "True")
		{
		# Queue was found on the current line, which is 1 more then $OK[$element]{count}
		# hence, we are going to check whats in-between our <td></td> on the next line
		# thats 1+$OK[$element]{count} ;)
		$LMQ_line=($OK[$element]{count} + 1);
		$large_flag="True";
		$OK[$element]{large_queue_present}="True";
		}
	}
sub find_failed_queue
	{
	if ($failed_flag ne "True")
		{
		# Queue was found on the current line, which is 1 more then $OK[$element]{count}
		# hence, we are going to check whats in-between our <td></td> on the next line
		# thats 1+$OK[$element]{count} ;)
		$FMQ_line=($OK[$element]{count} + 1);
		#print "$FMQ_line\n";
		$failed_flag="True";
		$OK[$element]{failed_queue_present}="True";
		}
	}
sub find_dead_queue
	{
	if ($dead_flag ne "True")
		{
		# Queue was found on the current line, which is 1 more then $OK[$element]{count}
		# hence, we are going to check whats in-between our <td></td> on the next line
		# thats 1+$OK[$element]{count} ;)
		$DMQ_line=($OK[$element]{count} + 1);
		#print "$DMQ_line\n";
		$dead_flag="True";
		$OK[$element]{dead_queue_present}="True";
		}
	}

# figure out our status

# We need to look at 3 things on each box.. 
# 1) Is the queue there?? Applies for Small and Large
# 2) Is the queue big enough to Warn? Applies for Small and Large
# 3) Is the queue big enough to go CRIT? Applies for Small and Large

for ($count=0;$count<$element;$count++)
	{
	if ($OK[$count]{small_queue_present} ne "True")
		{
		print "CRITICAL: No small queue found!\n";
		exit (2);
		}
	if ($OK[$count]{large_queue_present} ne "True")
                {
                print "CRITICAL: No large queue found!\n";
                exit (2);
                }
	if ($OK[$count]{small_queue} > $smq_crit)
		{
		print "CRITICAL: Small MQ is: $OK[$count]{small_queue}\n";
		exit (2);
		}
	if ($OK[$count]{large_queue} > $lmq_crit)
		{
		print "CRITICAL: Large MQ is: $OK[$count]{large_queue}\n";
		exit (2);
		}


	if ($OK[$count]{failed_queue} > 0 )
		{
		print "CRITICAL: Failed MQ is: $OK[$count]{failed_queue}\n";
		exit (2);
		}
	if ($OK[$count]{dead_queue} > 0 )
		{
		print "CRITICAL: Dead MQ is: $OK[$count]{dead_queue}\n";
		exit (2);
		}

	if ($OK[$count]{small_queue} > $smq_warn)
		{
		print "WARN: Small MQ is: $OK[$count]{small_queue}\n";
		exit (1);
		}
	if ($OK[$count]{large_queue} > $lmq_warn)
		{
		print "WARN: Large MQ is: $OK[$count]{large_queue}\n";
		exit (1);
		}
	}

print "OK - MQ is Happy\n";
exit (0);
