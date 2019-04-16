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
  <ns prefix="f" uri="http://example.org/functions"/>
  <ns prefix="structures" uri="http://release.niem.gov/niem/structures/4.0/"/>
  

  <pattern>
    <rule context="/*">
      <assert test="self::mm:Model">Document element must be mm:Model.</assert>
    </rule>
  </pattern>

  <pattern>
    <rule context="*[@structures:uri]">
      <assert test="false()">@structures:uri is prohibited.</assert>
    </rule>
  </pattern>
  
  <pattern>
    <rule context="*">
      <assert test="count(@structures:id | @structures:ref) = (0,1)">
        An element must have at most one of @structures:id or @structures:ref.</assert>
    </rule>
  </pattern>

  <pattern>
    <rule context="*[@structures:ref]">
      <assert test="node-name(f:resolve(.)) = node-name(.)">@structures:ref must resolve to same element (<value-of select="node-name(.)"/> resolves to <value-of select="node-name(f:resolve(.))"/>.</assert>
    </rule>
  </pattern>

  <pattern>
    <rule context="*[@structures:ref]">
      <assert test="self::mm:Namespace
                    or self::mm:NamespaceReference
                    or self::mm:ObjectProperty
                    or self::mm:ObjectPropertyReferenc
                    or self::mm:Class
                    or self::mm:ClassReference
                    or self::mm:DataProperty
                    or self::mm:DataPropertyReference
                    or self::mm:Datatype
                    or self::mm:DatatypeReference"
              >This element is not allowed to have @structures:ref</assert>
    </rule>
  </pattern>

  <pattern>
    <rule context="mm:DefinitionText">
      <assert test="string-length(normalize-space(.)) gt 0"
              >mm:DefinitionText must not be empty.</assert>
    </rule>
  </pattern>

</schema>
