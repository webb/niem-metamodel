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
      <for-each select="$item">
        <choose>
          <when test="self::element()">
            <text>element </text>
            <value-of select="node-name(.)"/>
            <for-each select="mm:Name">
              <value-of> name <value-of select="."/></value-of>
            </for-each>
            <variable name="uri" as="xs:anyURI?" select="f:get-uri($item)"/>
            <if test="exists($uri)"> uri <value-of select="$uri"/></if>
          </when>
        </choose>
        <if test="not(f:is-target(.))">
          <text>&#10;  resolves to: </text>
          <value-of select="f:describe(f:resolve(.))"/>
        </if>
      </for-each>
    </value-of>
  </function>

  <!-- yield either 'HasValue, or 'HasObjectProperty', or 'none', or a message for a fail.  -->
  <function name="f:class-get-content-style" as="xs:string?">
    <param name="context" as="element(mm:Class)"/>
    <for-each select="f:resolve($context)">
      <choose>
        <when test="f:component-get-qname(.) = xs:QName('structures:ObjectType')">
          <value-of>none</value-of>
        </when>
        <when test="empty(mm:DefinitionText) and mm:ContentStyle">
          <value-of select="mm:ContentStyle"/>
        </when>
        <when test="mm:ExtensionOf">
          <variable name="base-style"
                    select="f:class-get-content-style(mm:ExtensionOf/mm:Class)"/>
          <choose>
            <when test="$base-style = 'none' and mm:ExtensionOf/mm:HasValue">HasValue</when>
            <when test="$base-style = 'none'">HasObjectProperty</when>
            <otherwise>
              <value-of select="$base-style"/>
            </otherwise>
          </choose>
        </when>
        <otherwise>
          <text>weird case</text>
        </otherwise>
      </choose>
    </for-each>
  </function>

  <function name="f:is-component" as="xs:boolean">
    <param name="element" as="element()"/>
    <for-each select="$element">
      <sequence select="self::mm:ObjectProperty
                        or self::mm:Class
                        or self::mm:DataProperty
                        or self::mm:Datatype"/>
    </for-each>
  </function>

  <function name="f:component-get-qname" as="xs:QName*">
    <param name="components" as="element()*"/>
    <for-each select="$components">
      <if test="not(f:is-component(.))">
        <message terminate="yes">f:component-get-qname() called on non-component (<value-of select="f:describe(.)"/>).</message>
      </if>
      <for-each select="f:resolve(.)">
        <variable name="namespace" select="f:resolve(mm:Namespace)"/>
        <sequence select="QName($namespace/mm:NamespaceURI, concat($namespace/mm:NamespacePrefix, ':', mm:Name))"/>
      </for-each>
    </for-each>
  </function>

  <function name="f:component-get-namespace" as="element(mm:Namespace)*">
    <param name="components" as="element()*"/>
    <for-each select="$components">
      <for-each select="f:resolve(.)">
        <if test="not(f:is-component(.))">
          <message terminate="yes"
                   >in f:component-get-namespace, member of $components is not a component (was <value-of select="f:qname-get-clark-name(node-name(.))"/>).</message>
        </if>
        <sequence select="f:resolve(mm:Namespace)"/>
      </for-each>
    </for-each>
  </function>

  <function name="f:collect-components-in-namespace" as="element()*">
    <param name="namespace" as="element()"/>
    <for-each select="f:resolve($namespace)">
      <sequence select="root(.)//*[f:is-target(.) and f:is-component(.) 
                        and f:component-get-namespace(.) eq current()]"/>
    </for-each>
  </function>

  <function name="f:component-get-referenced-components" as="element()*">
    <param name="components" as="element()*"/>
    <for-each select="$components">
      <for-each select="f:resolve(.)">
        <choose>
          <when test="self::mm:ObjectProperty">
            <for-each select="f:resolve(mm:SubPropertyOf)">
              <sequence select="f:resolve(mm:ObjectProperty)"/>
            </for-each>
            <sequence select="f:resolve(mm:Class)"/>
          </when>
          <when test="self::mm:Class">
            <for-each select="mm:ExtensionOf">
              <sequence select="f:resolve(mm:Class)"/>
            </for-each>
            <for-each select="mm:HasValue">
              <sequence select="f:resolve(mm:Datatype)"/>
            </for-each>
            <for-each select="mm:HasDataProperty">
              <sequence select="f:resolve(mm:DataProperty)"/>
            </for-each>
            <for-each select="mm:HasObjectProperty">
              <sequence select="f:resolve(mm:ObjectProperty)"/>
            </for-each>
          </when>
          <when test="self::mm:DataProperty">
            <sequence select="f:resolve(mm:Datatype)"/>
          </when>
          <when test="self::mm:Datatype">
            <for-each select="mm:RestrictionOf">
              <sequence select="f:resolve(mm:DataType)"/>
            </for-each>
            <for-each select="mm:ListOf">
              <sequence select="f:resolve(mm:DataType)"/>
            </for-each>
            <for-each select="mm:UnionOf">
              <for-each select="mm:DataType">
                <sequence select="f:resolve(.)"/>
              </for-each>
            </for-each>
          </when>
        </choose>
      </for-each>
    </for-each>
  </function>

  <function name="f:resolve" as="element()?">
    <param name="context" as="element()?"/>
    <choose>
      <when test="empty($context)"/>
      <when test="$context/@structures:ref">
        <sequence select="root($context)//*[@structures:id = $context/@structures:ref]"/>
      </when>
      <otherwise>
        <sequence select="$context"/>
      </otherwise>
    </choose>
  </function>

  <function name="f:is-target" as="xs:boolean">
    <param name="context" as="element()"/>
    <sequence select="empty($context/@structures:ref)"/>
  </function>

  <function name="f:qname-get-clark-name" as="xs:string">
    <param name="qname" as="xs:QName"/>
    <value-of>{<value-of select="namespace-uri-from-QName($qname)"/>}<value-of select="local-name-from-QName($qname)"/></value-of>
  </function>

</stylesheet>
