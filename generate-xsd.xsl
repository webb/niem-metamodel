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
        <apply-templates select="//mm:Namespace[f:is-target(.)]" mode="generate-xml-catalog"/>
      </c:catalog>
    </result-document>
    <apply-templates select="//mm:Namespace[f:is-target(.)]" mode="generate-xsd"/>
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
    <result-document href="tmp/xsd/{mm:NamespacePrefix}.xsd" indent="yes">
      <xs:schema>
        <apply-templates select="//*[f:is-target(.)
                                     and (self::mm:ObjectProperty
                                          or self::mm:DataProperty
                                          or self::mm:Class
                                          or self::mm:Datatype)
                                     and f:has-namespace(., current())]" mode="generate-xsd">
          <sort select="mm:Name"/>
        </apply-templates>
      </xs:schema>
    </result-document>
  </template>

  <template match="mm:ObjectProperty" mode="generate-xsd">
    <xs:element name="{mm:Name}">
      <choose>
        <when test="exists(mm:Class)">
          <attribute name="type">
            <value-of select="f:resolve(mm:Namespace)get-uri(mm:Class)"/>
          </attribute>
        </when>
        <otherwise>
          <attribute name="abstract">true</attribute>
        </otherwise>
      </choose>
      <xs:annotation>
        <xs:documentation>
          <value-of select="mm:DefinitionText"/>
        </xs:documentation>
      </xs:annotation>
    </xs:element>
  </template>

  <template match="mm:Class" mode="generate-xsd">
    <xs:complexType name="{mm:Name}">
      <xs:annotation>
        <xs:documentation>
          <value-of select="mm:DefinitionText"/>
        </xs:documentation>
      </xs:annotation>
    </xs:complexType>
  </template>

  <template match="@*|node()" priority="-1" mode="generate-xsd">
    <message terminate="yes">Unexpected element (mode=generate-xsd): <value-of select="f:describe(.)"/></message>
  </template>

</stylesheet>
