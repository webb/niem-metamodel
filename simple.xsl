<?xml version="1.0" encoding="UTF-8"?>
<stylesheet 
  exclude-result-prefixes="xsl c f mm structures xsl"
  version="2.0"
  xmlns:c="urn:oasis:names:tc:entity:xmlns:xml:catalog"
  xmlns:f="http://example.org/functions"
  xmlns:mm="http://reference.niem.gov/specification/metamodel/5.0alpha1"
  xmlns:structures="http://release.niem.gov/niem/structures/4.0/"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/XSL/Transform">

  <import href="functions.xsl"/>

  <template match="//*[exists(@structures:ref)]">
    <message>@structures:ref=<value-of select="@structures:ref"/>&#10; resolves to <value-of select="f:get-uri(.)"/></message>
    <apply-templates/>
  </template>

  <template match="//*[exists(@structures:id)]">
    <message>@structures:id=<value-of select="@structures:id"/>&#10; resolves to <value-of select="f:get-uri(.)"/></message>
    <apply-templates/>
  </template>

  <template match="//*[exists(@structures:uri)]">
    <message>@structures:uri=<value-of select="@structures:uri"/>&#10; resolves to <value-of select="f:get-uri(.)"/></message>
    <apply-templates/>
  </template>

</stylesheet>
