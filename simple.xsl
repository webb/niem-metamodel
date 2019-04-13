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

  <template match="//*[exists(@structures:ref or @structures:id or @structures:uri)]">
    <message>
      <text>object id </text>
      <value-of select="generate-id(.)"/>
      <text> uri </text>
      <value-of select="f:get-uri(.)"/>
      <text> matches objects:&#10;</text>
      <for-each select="f:collect-objects(.)">
        <text>  id </text>
        <value-of select="generate-id(.)"/>
        <text> uri </text>
        <value-of select="f:get-uri(.)"/>
        <text>&#10;</text>
      </for-each>
      <text>properties:&#10;</text>
      <for-each select="f:collect-properties-test(.)">
        <choose>
          <when test="self::element()">
            <text>  element </text>
            <value-of select="node-name(.)"/>
            <text>&#10;</text>
          </when>
          <when test="self::attribute()">
            <text>  attribute </text>
            <value-of select="node-name(.)"/>
            <text>&#10;</text>
          </when>
        </choose>
      </for-each>
    </message>
    <apply-templates/>
  </template>

</stylesheet>
