<?xml version="1.0" encoding="UTF-8"?>
<stylesheet 
  exclude-result-prefixes="c f mm structures xsl"
  version="2.0"
  xmlns:c="urn:oasis:names:tc:entity:xmlns:xml:catalog"
  xmlns:ct="http://release.niem.gov/niem/conformanceTargets/3.0/"
  xmlns:f="http://example.org/functions"
  xmlns:mm="http://reference.niem.gov/specification/metamodel/5.0alpha1"
  xmlns:structures="http://release.niem.gov/niem/structures/4.0/"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/XSL/Transform">

  <import href="functions.xsl"/>

  <template match="mm:Model">
    <result-document href="generated/xsd/xml-catalog.xml" indent="yes">
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
    <result-document href="generated/xsd/{mm:NamespacePrefix}.xsd" indent="yes">
      <xs:schema targetNamespace="{mm:NamespaceURI}">
        <variable name="referenced-namespaces"
                  select="f:component-get-namespace(
                          f:component-get-referenced-components(
                          f:collect-components-in-namespace($this)))"/>
        <for-each select="$referenced-namespaces">
          <namespace name="{mm:NamespacePrefix}" select="mm:NamespaceURI"/>
        </for-each>
        <attribute name="ct:conformanceTargets">http://reference.niem.gov/niem/specification/naming-and-design-rules/4.0/#ReferenceSchemaDocument</attribute>
        <attribute name="version">1</attribute>

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
          <sort select="lower-case(mm:Name)"/>
          <sort select="lower-case(mm:Name)" case-order="upper-first"/>
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
      <for-each select="mm:SubPropertyOf">
        <attribute name="substitutionGroup" select="f:component-get-qname(mm:ObjectProperty)"/>
      </for-each>
      <attribute name="nillable">true</attribute>
      <xs:annotation>
        <xs:documentation>
          <value-of select="mm:DefinitionText"/>
        </xs:documentation>
      </xs:annotation>
    </xs:element>
  </template>

  <template match="mm:Class[f:is-target(.) and mm:DefinitionText and mm:ExtensionOf]" mode="generate-xsd">
    <variable name="this" select="."/>
    <variable name="content-style" select="f:class-get-content-style(.)"/>
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
      <for-each select="mm:ExtensionOf">
        <choose>
          <when test="$content-style = 'HasObjectProperty'">
            <xs:complexContent>
              <xs:extension base="{f:component-get-qname(mm:Class)}">
                <xs:sequence>
                  <apply-templates select="mm:HasObjectProperty" mode="#current">
                    <sort select="@mm:sequenceID"/>
                    <sort select="f:resolve(mm:ObjectProperty)/mm:Name"/>
                  </apply-templates>
                  <xs:element ref="{f:class-get-augmentation-point-qname($this)}" minOccurs="0" maxOccurs="unbounded"/>
                </xs:sequence>
                <apply-templates select="mm:HasDataProperty" mode="#current">
                  <sort select="f:resolve(mm:DataPropert)/mm:Name"/>
                </apply-templates>
              </xs:extension>
            </xs:complexContent>
          </when>
          <when test="$content-style = 'HasValue'">
            <xs:simpleContent>
              <xs:extension>
                <choose>
                  <when test="mm:HasValue">
                    <attribute name="base" select="f:component-get-qname(mm:HasValue/mm:Datatype)"/>
                    <xs:attributeGroup ref="structures:SimpleObjectAttributeGroup"/>
                  </when>
                </choose>
                <apply-templates select="mm:HasDataProperty" mode="#current">
                  <sort select="f:resolve(mm:DataPropert)/mm:Name"/>
                </apply-templates>
              </xs:extension>
            </xs:simpleContent>
          </when>
        </choose>
      </for-each>
    </xs:complexType>
    <if test="$content-style = 'HasObjectProperty'">
      <xs:element name="{local-name-from-QName(f:class-get-augmentation-point-qname($this))}" abstract="true">
        <xs:annotation>
          <xs:documentation>An augmentation point for <value-of select="f:component-get-qname($this)"/>.</xs:documentation>
        </xs:annotation>
      </xs:element>
    </if>
  </template>

  <template match="mm:HasObjectProperty" mode="generate-xsd">
    <xs:element ref="{f:component-get-qname(mm:ObjectProperty)}" minOccurs="{@mm:minOccurs}" maxOccurs="{@mm:maxOccurs}"></xs:element>
  </template>

  <template match="mm:HasDataProperty" mode="generate-xsd">
    <xs:attribute ref="{f:component-get-qname(mm:DataProperty)}">
      <!--
      minOccurs="{@mm:minOccurs}" maxOccurs="{@mm:maxOccurs}"></xs:element>
      -->
    </xs:attribute>
  </template>

  <template match="mm:DataProperty[f:is-target(.)]" mode="generate-xsd">
    <xs:attribute name="{mm:Name}">
      <for-each select="mm:Datatype">
        <attribute name="type" select="f:component-get-qname(.)"/>
      </for-each>
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
      <for-each select="mm:RestrictionOf">
        <xs:restriction base="{f:component-get-qname(mm:Datatype)}">
          <apply-templates select="*[position() ge 2]" mode="generate-xsd">
            <sort select="local-name()"/>
            <sort select="*[1]"/>
          </apply-templates>
        </xs:restriction>
      </for-each>
      <for-each select="mm:UnionOf">
        <variable name="member-types" as="xs:string*">
          <for-each select="mm:Datatype">
            <value-of select="f:component-get-qname(.)"/>
          </for-each>
        </variable>
        <xs:union memberTypes="{string-join($member-types, ' ')}"/>
      </for-each>
      <for-each select="mm:ListOf">
        <xs:list itemType="{f:component-get-qname(mm:Datatype)}"/>
      </for-each>
    </xs:simpleType>
  </template>

  <template match="mm:Enumeration" mode="generate-xsd">
    <xs:enumeration value="{*[1]}">
      <xs:annotation>
        <xs:documentation>
          <value-of select="mm:DefinitionText"/>
        </xs:documentation>
      </xs:annotation>
    </xs:enumeration>
  </template>

  <template match="@*|node()" priority="-1" mode="generate-xsd">
    <message terminate="yes">Unexpected element (mode=generate-xsd): <value-of select="f:describe(.)"/></message>
  </template>

</stylesheet>
