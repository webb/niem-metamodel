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

  <template match="//*[@structures:ref or @structures:id or @structures:uri]">
    <variable name="objects" select="f:collect-objects(.)"/>
    <!-- just do the first occurrence -->
    <if test="$objects[1] eq .">
      <message><value-of select="f:describe(.)"/>
        <for-each select="f:collect-parents($objects)">
          <text>&#10;  parent: </text>
          <value-of select="f:describe(.)"/>
        </for-each>
      </message>
    </if>
    <apply-templates/>
  </template>

</stylesheet>
