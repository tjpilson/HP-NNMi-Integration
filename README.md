Nnmi
====

**HP NNMi Integration**

Perl is a tool that is commonly available to system admins.  HP's NNMi tool offers a web service which is useful for collecting node information. This script enables web service queries to the platform.

The web service will only return a maximum of 1,000 results by default.  The script will set a filter in the SOAP call to override the maxObjects with a user-specified number of records.

**Requirements (Perl Modules)**
- SOAP::Lite
- Term::ReadKey
  
**Configuration**

Edit variable to include your NNMi server
```
my $nnmiServer = "";
```

Edit to include your max record/node count
```
my $maxObjects = "";
```

**Running (getNnmiNodes.pl)**

The script is designed to be run manually and will prompt for a password.  The output can be modified to print
in any necessary format.
