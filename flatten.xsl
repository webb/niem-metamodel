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

  <template match="/mm:Model">
    <result-document href="xsd/xml-catalog.xml" indent="yes">
      <c:catalog prefer="public">
        <apply-templates select="//mm:Namespace[empty(@structures:ref)]" mode="generate-xml-catalog"/>
      </c:catalog>
    </result-document>
    <apply-templates select="//mm:Namespace[empty(@structures:ref)]" mode="generate-xsd"/>
  </template>

  <template match="mm:Namespace" mode="generate-xml-catalog">
    <c:uri name="{@namespaceURI}" uri="{@namespacePrefix}.xsd"/>
  </template>

  <template match="mm:Namespace" mode="generate-xsd">
    <variable name="this" as="element()" select="."/>
    <result-document href="xsd/{@namespacePrefix}.xsd" indent="yes">
      <xs:schema>
        <apply-templates select="//*[(self::mm:Type or self::mm:Property)
                                     and f:resolve(./mm:Namespace) is $this]"
                         mode="generate-xsd">
          <sort select="@name"/>
        </apply-templates>
      </xs:schema>
    </result-document>
  </template>

  <template match="mm:Type" mode="generate-xsd">
    <xs:complexType name="{@name}">
      <xs:annotation>
        <xs:documentation>
          <value-of select="mm:DefinitionText"/>
        </xs:documentation>
      </xs:annotation>
    </xs:complexType>
  </template>

  <template match="mm:Property" mode="generate-xsd">
    <xs:element name="{@name}">
      <if test="exists(mm:Type)">
      </if>
      <xs:annotation>
        <xs:documentation>
          <value-of select="mm:DefinitionText"/>
        </xs:documentation>
      </xs:annotation>
    </xs:element>
  </template>

</stylesheet>
