<?xml version="1.0" encoding="UTF-8"?>
<stylesheet 
  exclude-result-prefixes="xsl c f mm xsl"
  version="2.0"
  xmlns:c="urn:oasis:names:tc:entity:xmlns:xml:catalog"
  xmlns:f="http://example.org/functions"
  xmlns:mm="http://reference.niem.gov/specification/metamodel/5.0alpha1"
  xmlns:structures="http://release.niem.gov/niem/structures/4.0/"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/XSL/Transform">

  <import href="functions.xsl"/>

  <output method="xml" indent="yes"/>

  <template match="*">
    <copy>
      <if test=". eq root()">
        <namespace name="structures">http://release.niem.gov/niem/structures/4.0/</namespace>
      </if>
      <variable name="uri" as="xs:anyURI?" select="f:get-uri(.)"/>
      <if test="exists($uri)">
        <attribute name="structures:uri" select="$uri"/>
      </if>
      <variable name="objects" select="f:collect-objects(.)"/>
      <if test=". eq $objects[1]">
        <variable name="properties" select="f:collect-properties($objects)"/>
        <for-each select="$properties[
                          self::attribute()[not(node-name(.) = (xs:QName('structures:uri'), xs:QName('structures:id'), xs:QName('structures:ref')))]
                          or self::text()]">
          <copy-of select="."/>
        </for-each>
        <for-each select="$properties[self::element()]">
          <apply-templates select="."/>
        </for-each>
      </if>
    </copy>
  </template>

  <template match="text()"/>

</stylesheet>
