<?xml version="1.0" encoding="UTF-8"?>
<stylesheet 
  version="2.0"
  xmlns:f="http://example.org/functions"
  xmlns:structures="http://release.niem.gov/niem/structures/4.0/"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/XSL/Transform">

  <function name="f:resolve" as="element()">
    <param name="element" as="element()"/>
    <choose>
      <when test="exists($element/@structures:ref)">
        <variable name="id" select="$element/@structures:ref" as="xs:string"/>
        <sequence select="root($element)//*[@structures:id]"/>
      </when>
      <otherwise>
        <sequence select="$element"/>
      </otherwise>
    </choose>
  </function>

</stylesheet>
