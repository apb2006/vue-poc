Problem: When XSLT is run in BaseX on an XML file that contains a DTD DOCTYPE pointing to a non-working system URI the transofrmation fails. The XSLT uses unparsed-entity-uri() to access an entityref in the XML file.

Root cause: xslt:transform function is not using the XML Catalog to resolve the DTD location when parsing XML.

Mailing list discussion thread: https://www.mail-archive.com/basex-talk@mailman.uni-konstanz.de/msg12859.html

This small self contained example shows the problem.

Set up this test as follows:

1. Download BaseX version 9.3.3 zip distribution
2. Extract the BaseX zip so that the 'lib' folder is relative to this project folder at ./basex/lib
3. Download Saxon HE version 9.9 and place Saxon jar in ./basex/lib/custom

Run this query which shows that BaseX doc() function uses the XML Catalog to parse the XML resolving the location of the DTD correctly, however the same is not working with the xslt:transform() function.

    .\basex\bin\basex transform.xq

Run this Linux shell script which shows that:

1.  The transformation works in Saxon and uses the catalog file to locate the DTD when parsing the XML input1.xml.
2.  The BaseX xslt:transform should work the same as #1, but fails because the DTD cannot be read.
3.  Adding Saxon configuration for Entity Resolver Class and URI Resolve Class did not help.
4.  Simply parsing the XML using doc() in BaseX with the same configuration shows that the XML catalog is configured correctly within BaseX.

In this test, the XSLT run in Saxon (1) and in BaseX (2) should produce identical XML. It works in Saxon (1), but BaseX (2) is producing an error because the DTD is not being found.

Running this test with strace shows that when the XSLT is run in BaseX (2) it is trying to download the DTD from the non-working URI.

    strace -f ./run-test >& hugelog.txt

The log file hugelog.txt contains "GET /dtd/TAFXML/TFJA.dtd HTTP/1." around line 334992 showing the attempt to download the DTD from the non-working URI.

Testing with XSpec produces a passing report also confirming that the XSLT and XML Catalog are working with Saxon.

    xspec -catalog schemas/catalog.xml transform.xspec
