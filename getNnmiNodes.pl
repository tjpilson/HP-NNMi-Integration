#!/usr/bin/perl -w

use strict;
use SOAP::Lite;
use Term::ReadKey;

my $maxObjects = 20000; ## max number of items returned in query (default = 1,000)
my $nnmiServer = ""; ## enter NNMi server name

## Get Credentials for Authentication
## ----------------------------------
print "Enter Username: ";
chomp(my $username = <STDIN>);

print "Enter Password: ";
ReadMode('noecho'); ## turn off echo for grabbing password
chomp(my $password = <STDIN>);
ReadMode(0);
print "\n";

sub SOAP::Transport::HTTP::Client::get_basic_credentials {
   return "$username" => "$password"; 
}

my $soap = SOAP::Lite                                             
  -> uri("https://$nnmiServer/NodeBeanService/NodeBean?wsdl")                                             
  -> proxy("https://$nnmiServer/NodeBeanService/NodeBean?wsdl");

$soap->proxy->ssl_opts( SSL_verify_mode => 0 );  ## Turn off SSL certficate verification
$soap->proxy->ssl_opts( verify_hostname => 0 );  ## Turn off SSL hostname verification

## Call the "getNodes" function
my $method = SOAP::Data->name('ns1:getNodes')
    ->attr({'xmlns:ns1' => 'http://node.sdk.nms.ov.hp.com/'});

## Build a filter to override default maxObjects = 1,000
my @params = SOAP::Data->name(arg0 => 
               \SOAP::Data->value(
                                  SOAP::Data->name('operator' => 'AND' ),
                                  SOAP::Data->name('subFilters' =>
                 \SOAP::Data->value(
                                    SOAP::Data->name('name' => 'maxObjects'),
                                    SOAP::Data->name('value' => "$maxObjects")
                                   )
                                                  )->attr({'xsi:type' => 'ns3:constraint'})
                                 )
             )->attr({'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance','xmlns:ns3' => 'http://filter.sdk.nms.ov.hp.com/','xsi:type' => 'ns3:expression'});

my $data = $soap->call($method => @params)->result;

my $count;  ## establish counter
foreach my $item (@{$data->{item}}) {  ## iterate through "items"
  print "$item->{name}\n";
  print "  $item->{longName}\n";
  print "  $item->{systemContact}\n";
  print "  $item->{status}\n";
  print "  $item->{uuid}\n";
  print "  $item->{deviceModel}\n";
  print "  $item->{deviceFamily}\n";
  print "  $item->{id}\n";
  print "  $item->{IPv4Router}\n";
  print "  $item->{deviceCategory}\n";
  print "  $item->{snmpSupported}\n";
  print "  $item->{deviceDescription}\n";
  print "  $item->{systemName}\n";
  print "  $item->{systemLocation}\n";
  print "  $item->{systemDescription}\n";
  print "  $item->{managementMode}\n";
  print "  $item->{modified}\n";
  print "  $item->{deviceVendor}\n";
  print "  $item->{created}\n";
  print "  $item->{snmpVersion}\n";
  print "  $item->{discoveryState}\n";
  print "  $item->{endNode}\n";
  print "  $item->{lanSwitch}\n";
  print "  $item->{systemObjectId}\n";
  print "  $item->{notes}\n\n";
  $count++;
}
print "Total = $count\n";
