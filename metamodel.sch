<?xml version="1.0" encoding="US-ASCII" standalone="yes"?>
<schema
   queryBinding="xslt2"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://purl.oclc.org/dsdl/schematron">

  <xsl:include href="functions.xsl"/>
  
  <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
  <ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>
  <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
  <ns prefix="mm" uri="http://reference.niem.gov/specification/metamodel/5.0alpha1"/>
  
  <pattern>
    <rule context="mm:DefinitionText">
      <assert test="string-length(normalize-space(.)) gt 0"
              >mm:DefinitionText must not be empty.</assert>
    </rule>
  </pattern>
</schema>
