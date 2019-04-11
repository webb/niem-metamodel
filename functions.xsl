<?xml version="1.0" encoding="UTF-8"?>
<stylesheet 
  version="2.0"
  xmlns:f="http://example.org/functions"
  xmlns:structures="http://release.niem.gov/niem/structures/4.0/"
  xmlns:xml="http://www.w3.org/XML/1998/namespace"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/XSL/Transform">

  <function name="f:get-base-uri" as="xs:string">
    <param name="context" as="element()"/>
    <variable name="base-attributes" as="attribute(xml:base)?"
              select="$context/ancestor-or-self::*[@xml:base][1]/@xml:base"/>
    <choose>
      <when test="exists($base-attributes)">
        <value-of select="string($base-attributes)"/>
      </when>
      <otherwise>
        <value-of select="base-uri($context)"/>
      </otherwise>
    </choose>
  </function>

  <function name="f:get-uri" as="xs:string">
    <param name="context" as="element()"/>
    <choose>
      <when test="exists($context/@structures:id)">
        <value-of select="resolve-uri(concat('#',$context/@structures:id), f:get-base-uri($context))"/>
      </when>
      <when test="exists($context/@structures:ref)">
        <value-of select="resolve-uri(concat('#',$context/@structures:ref), f:get-base-uri($context))"/>
      </when>
      <when test="exists($context/@structures:uri)">
        <value-of select="resolve-uri($context/@structures:uri, f:get-base-uri($context))"/>
      </when>
    </choose>
  </function>

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
