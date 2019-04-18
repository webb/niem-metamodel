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

  <template match="mm:Model">
    <result-document href="tmp/xsd/xml-catalog.xml" indent="yes">
      <c:catalog prefer="public">
        <apply-templates select="//mm:Namespace[f:is-target(.) and mm:DefinitionText]" mode="generate-xml-catalog"/>
      </c:catalog>
    </result-document>
    <apply-templates select="//mm:Namespace[f:is-target(.) and mm:DefinitionText]" mode="generate-xsd"/>
  </template>

  <template match="@*|node()" priority="-1">
    <message terminate="yes">Unexpected element (default mode)</message>
  </template>

  <!-- ==================================================================== -->

  <template match="mm:Namespace[f:is-target(.)]" mode="generate-xml-catalog">
    <c:uri name="{mm:NamespaceURI}"
           uri="{mm:NamespacePrefix}.xsd"/>
  </template>

  <template match="@*|node()" priority="-1" mode="generate-xml-catalog">
    <message terminate="yes">Unexpected element (mode=generate-xml-catalog)</message>
  </template>

  <!-- ==================================================================== -->

  <template match="mm:Namespace[f:is-target(.)]" mode="generate-xsd">
    <variable name="this" as="element(mm:Namespace)" select="."/>
    <result-document href="tmp/xsd/{mm:NamespacePrefix}.xsd" indent="yes">
      <xs:schema targetNamespace="{mm:NamespaceURI}">
        <variable name="referenced-namespaces"
                  select="f:component-get-namespace(
                          f:component-get-referenced-components(
                          f:collect-components-in-namespace($this)))"/>
        <for-each select="$referenced-namespaces">
          <namespace name="{mm:NamespacePrefix}" select="mm:NamespaceURI"/>
        </for-each>

        <xs:annotation>
          <xs:documentation>
            <value-of select="mm:DefinitionText"/>
          </xs:documentation>
        </xs:annotation>

        <for-each select="//*[(. ne $this)
                              and (self::mm:Namespace or self::mm:Namespace)
                              and . = $referenced-namespaces]">
          <xs:import namespace="{mm:NamespaceURI}"/>
        </for-each>
        <apply-templates select="//*[f:is-target(.) and f:is-component(.)
                                     and f:component-get-namespace(.) eq $this]"
                         mode="generate-xsd">
          <sort select="mm:Name"/>
        </apply-templates>
      </xs:schema>
    </result-document>
  </template>

  <template match="mm:ObjectProperty[f:is-target(.)]" mode="generate-xsd">
    <xs:element name="{mm:Name}">
      <for-each select="mm:Class">
        <attribute name="type">
          <value-of select="f:component-get-qname(.)"/>
        </attribute>
      </for-each>
      <for-each select="mm:Abstract">
        <if test="xs:boolean(.) = true()">
          <attribute name="abstract">true</attribute>
        </if>
      </for-each>
      <xs:annotation>
        <xs:documentation>
          <value-of select="mm:DefinitionText"/>
        </xs:documentation>
      </xs:annotation>
    </xs:element>
  </template>

  <template match="mm:Class[f:is-target(.) and mm:DefinitionText and mm:ExtensionOf]" mode="generate-xsd">
    <xs:complexType name="{mm:Name}">
      <for-each select="mm:Abstract">
        <if test="xs:boolean(.) = true()">
          <attribute name="abstract">true</attribute>
        </if>
      </for-each>
      <xs:annotation>
        <xs:documentation>
          <value-of select="mm:DefinitionText"/>
        </xs:documentation>
      </xs:annotation>
      <variable name="content-style" select="f:class-get-content-style(.)"/>
      <choose>
        <when test="$content-style = 'HasObjectProperty'">
          <xs:complexContent>
            <xs:extension base="{f:component-get-qname(mm:ExtensionOf/mm:Class)}">
              <xs:sequence>
                <for-each select="mm:ExtensionOf/mm:HasObjectProperty">
                  <sort select="@mm:sequenceID"/>
                  <xs:element ref="{f:component-get-qname(mm:ObjectProperty)}" minOccurs="{@mm:minOccurs}" maxOccurs="{@mm:maxOccurs}"></xs:element>
                </for-each>
              </xs:sequence>
            </xs:extension>
          </xs:complexContent>
        </when>
      </choose>
    </xs:complexType>
  </template>

  <template match="mm:DataProperty[f:is-target(.)]" mode="generate-xsd">
    <xs:attribute name="{mm:Name}">
      <xs:annotation>
        <xs:documentation>
          <value-of select="mm:DefinitionText"/>
        </xs:documentation>
      </xs:annotation>
    </xs:attribute>
  </template>

  <template match="mm:Datatype[f:is-target(.)]" mode="generate-xsd">
    <xs:simpleType name="{mm:Name}">
      <xs:annotation>
        <xs:documentation>
          <value-of select="mm:DefinitionText"/>
        </xs:documentation>
      </xs:annotation>
    </xs:simpleType>
  </template>

  <template match="@*|node()" priority="-1" mode="generate-xsd">
    <message terminate="yes">Unexpected element (mode=generate-xsd): <value-of select="f:describe(.)"/></message>
  </template>

</stylesheet>
