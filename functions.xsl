<?xml version="1.0" encoding="UTF-8"?>
<stylesheet 
  version="2.0"
  xmlns:f="http://example.org/functions"
  xmlns:mm="http://reference.niem.gov/specification/metamodel/5.0alpha1"
  xmlns:structures="http://release.niem.gov/niem/structures/4.0/"
  xmlns:xml="http://www.w3.org/XML/1998/namespace"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/XSL/Transform">

<!--
  <function name="f:uri-to-qname" as="xs:QName">
    <param name="uri" as="xs:anyURI"/>
    <substring-before></substring-before>
  </function>
-->

  <function name="f:get-base-uri" as="xs:anyURI">
    <param name="context" as="element()"/>
    <variable name="base-attribute" as="attribute(xml:base)?"
              select="$context/ancestor-or-self::*[@xml:base][1]/@xml:base"/>
    <variable name="base-uri">
      <choose>
        <when test="exists($base-attribute)">
          <value-of select="xs:anyURI($base-attribute)"/>
        </when>
        <otherwise>
          <value-of select="base-uri($context)"/>
        </otherwise>
      </choose>
    </variable>
    <choose>
      <when test="ends-with($base-uri, '#')">
        <sequence select="xs:anyURI(substring($base-uri,1,string-length($base-uri) - 1))"/>
      </when>
      <otherwise>
        <sequence select="$base-uri"/>
      </otherwise>
    </choose>
  </function>

  <function name="f:get-uri" as="xs:anyURI?">
    <param name="context" as="element()"/>
    <choose>
      <when test="exists($context/@structures:id)">
        <value-of select="resolve-uri(concat('#', $context/@structures:id), f:get-base-uri($context))"/>
      </when>
      <when test="exists($context/@structures:ref)">
        <value-of select="resolve-uri(concat('#', $context/@structures:ref), f:get-base-uri($context))"/>
      </when>
      <when test="exists($context/@structures:uri)">
        <value-of select="resolve-uri($context/@structures:uri, f:get-base-uri($context))"/>
      </when>
    </choose>
  </function>

  <function name="f:collect-objects" as="element()*">
    <param name="context" as="element()"/>
    <variable name="context-uri" as="xs:anyURI?" select="f:get-uri($context)"/>
    <choose>
      <when test="exists($context-uri)">
        <sequence select="root($context)//*[f:get-uri(.) = $context-uri]"/>
      </when>
      <otherwise>
        <sequence select="$context"/>
      </otherwise>
    </choose>
  </function>

  <function name="f:is-first" as="xs:boolean">
    <param name="context" as="element()"/>
    <sequence select="$context eq f:collect-objects($context)[1]"/>
  </function>

  <function name="f:collect-properties" as="node()*">
    <param name="object" as="element()"/>
    <for-each select="f:collect-objects($object)">
      <sequence select="@*|*|text()[string-length(normalize-space(.)) gt 0]"/>
    </for-each>
  </function>

  <function name="f:collect-parents" as="node()*">
    <param name="objects" as="element()*"/>
    <for-each select="$objects">
      <sequence select="./parent::element()"/>
    </for-each>
  </function>

  <function name="f:describe" as="xs:string">
    <param name="item" as="item()"/>
    <value-of>
      <choose>
        <when test="$item/self::element()">
          <text>element </text>
          <value-of select="node-name($item)"/>
          <if test="exists($item/@mm:name)">
            <value-of> name <value-of select="$item/@mm:name"/></value-of>
          </if>
          <variable name="uri" as="xs:anyURI?" select="f:get-uri($item)"/>
          <if test="exists($uri)"> uri <value-of select="$uri"/></if>
        </when>
      </choose>
    </value-of>
  </function>

  <function name="f:has-namespace" as="xs:boolean">
    <param name="context" as="element()"/>
    <param name="namespace" as="element(mm:Namespace)"/>
    <sequence select="exists($context/mm:Namespace) 
                      and (f:resolve($context/mm:Namespace) eq $namespace)"/>
  </function>

  <function name="f:resolve" as="element()?">
    <param name="context" as="element()"/>
    <choose>
      <when test="$context/@structures:ref">
        <sequence select="root($context)//*[@structures:id = $context/@structures:ref]"/>
      </when>
      <when test="$context/@structures:id">
        <sequence select="$context"/>
      </when>
      <when test="$context/@structures:uri">
        <sequence select="()"/>
      </when>
      <otherwise>
        <sequence select="$context"/>
      </otherwise>
    </choose>
  </function>

  <function name="f:is-target" as="xs:boolean">
    <param name="context" as="element()"/>
    <variable name="resolved" select="f:resolve($context)"/>
    <sequence select="exists($resolved) and ($context eq $resolved)"/>
  </function>

</stylesheet>
