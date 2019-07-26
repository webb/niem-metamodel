m4_changequote([[[,]]])m4_dnl
m4_changecom(,)m4_dnl
m4_define([[[M_STRUCTURES]]],[[[http://release.niem.gov/niem/structures/4.0/]]])m4_dnl
m4_define([[[M_MODEL]]],[[[http://reference.niem.gov/specification/metamodel/5.0alpha2]]])m4_dnl
m4_define([[[M_XS_PROXY]]],[[[http://release.niem.gov/niem/proxy/xsd/4.0/]]])m4_dnl
m4_define([[[M_XS]]],[[[http://www.w3.org/2001/XMLSchema]]])m4_dnl
<Model
  xml:base="http://example.org/local/"
  xmlns:mm="M_MODEL"
  xmlns:s="M_STRUCTURES"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns="M_MODEL">

  <Namespace s:uri="#model">
    <NamespaceURI>http://reference.niem.gov/specification/metamodel/5.0alpha2</NamespaceURI>
    <NamespacePrefixName>mm</NamespacePrefixName>
    <DefinitionText>A data model for a metamodel for NIEM.</DefinitionText>
  </Namespace>

  <Property>
    <Name>Model</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A data model.</DefinitionText>
    <Class>
      <Name>ModelType</Name>
      <Namespace s:uri="#model" xsi:nil="true"/>
      <DefinitionText>A data type for a data model.</DefinitionText>
      <ExtensionOf>
        <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
        <HasProperty mm:sequenceID="1" mm:minOccursQuantity="0" mm:maxOccursQuantity="unbounded">
          <Property s:uri="M_MODEL#ModelItemAbstract">
            <Name>ModelItemAbstract</Name>
            <Namespace s:uri="#model" xsi:nil="true"/>
            <DefinitionText>A data concept for an item in a data model.</DefinitionText>
            <AbstractIndicator>true</AbstractIndicator>
          </Property>
        </HasProperty>
      </ExtensionOf>
    </Class>
  </Property>

  <Property s:uri="M_MODEL#Namespace">
    <Name>Namespace</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A namespace of a data model component.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#ModelItemAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class>
      <Name>NamespaceType</Name>
      <Namespace s:uri="#model" xsi:nil="true"/>
      <DefinitionText>A data type for a namespace</DefinitionText>
      <ExtensionOf>
        <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
        <HasProperty mm:sequenceID="1" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
          <Property>
            <Name>NamespaceURI</Name>
            <Namespace s:uri="#model" xsi:nil="true"/>
            <DefinitionText>A namespace name URI for a namespace.</DefinitionText>
            <Class s:uri="M_XS_PROXY#anyURI" xsi:nil="true"/>
          </Property>
        </HasProperty>
        <HasProperty mm:sequenceID="2" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
          <Property>
            <Name>NamespacePrefixName</Name>
            <Namespace s:uri="#model" xsi:nil="true"/>
            <DefinitionText>A namespace name URI for a namespace.</DefinitionText>
            <Class s:uri="M_MODEL#NCName" xsi:nil="true"/>
          </Property>
        </HasProperty>
        <HasProperty mm:sequenceID="3" mm:minOccursQuantity="0" mm:maxOccursQuantity="1">
          <Property s:uri="M_MODEL#DefinitionText" xsi:nil="true"/>
        </HasProperty>
      </ExtensionOf>
    </Class>
  </Property>

  <Class s:uri="M_MODEL#ComponentType">
    <Name>ComponentType</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A data type for common properties of a data component in NIEM.</DefinitionText>
    <AbstractIndicator>true</AbstractIndicator>
    <ExtensionOf>
      <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
      <HasProperty mm:sequenceID="1" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
        <Property>
          <Name>Name</Name>
          <Namespace s:uri="#model" xsi:nil="true"/>
          <DefinitionText>A name of a data model component.</DefinitionText>
          <Class s:uri="M_MODEL#NCName" xsi:nil="true"/>
        </Property>
      </HasProperty>
      <HasProperty mm:sequenceID="2" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
        <Property s:uri="M_MODEL#Namespace" xsi:nil="true"/>
      </HasProperty>
      <HasProperty mm:sequenceID="3" mm:minOccursQuantity="0" mm:maxOccursQuantity="1">
        <Property s:uri="M_MODEL#DefinitionText" xsi:nil="true"/>
      </HasProperty>
    </ExtensionOf>
  </Class>
  
  <Property s:uri="M_MODEL#Property">
    <Name>Property</Name>
    <Namespace xsi:nil="true" s:uri="#model"/>
    <DefinitionText>An object property.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#ModelItemAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class>
      <Name>PropertyType</Name>
      <Namespace s:uri="#model" xsi:nil="true"/>
      <DefinitionText>A data type for an object property</DefinitionText>
      <ExtensionOf>
        <Class s:uri="M_MODEL#ComponentType" xsi:nil="true"/>
        <HasProperty mm:sequenceID="1" mm:minOccursQuantity="0" mm:maxOccursQuantity="1">
          <Property>
            <Name>SubPropertyOf</Name>
            <Namespace s:uri="#model" xsi:nil="true"/>
            <DefinitionText>An object property of which an object property is a subproperty.</DefinitionText>
            <Class>
              <Name>SubPropertyOfType</Name>
              <Namespace s:uri="#model" xsi:nil="true"/>
              <DefinitionText>A data type for a description of a subproperty.</DefinitionText>
              <ExtensionOf>
                <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
                <HasProperty mm:sequenceID="1" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
                  <Property s:uri="M_MODEL#Property" xsi:nil="true"/>
                </HasProperty>
              </ExtensionOf>
            </Class>
          </Property>
        </HasProperty>
        <HasProperty mm:sequenceID="2" mm:minOccursQuantity="0" mm:maxOccursQuantity="1">
          <Property s:uri="M_MODEL#Class" xsi:nil="true"/>
        </HasProperty>
        <HasProperty mm:sequenceID="3" mm:minOccursQuantity="0" mm:maxOccursQuantity="1">
          <Property s:uri="M_MODEL#AbstractIndicator" xsi:nil="true"/>
        </HasProperty>
      </ExtensionOf>
    </Class>
  </Property>
  <Property s:uri="M_MODEL#Class">
    <Name>Class</Name>
    <Namespace xsi:nil="true" s:uri="#model"/>
    <DefinitionText>A class.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#ModelItemAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class>
      <Name>ClassType</Name>
      <Namespace s:uri="#model" xsi:nil="true"/>
      <DefinitionText>A data type for a class.</DefinitionText>
      <ExtensionOf>
        <Class s:uri="M_MODEL#ComponentType" xsi:nil="true"/>
        <HasProperty mm:sequenceID="1" mm:minOccursQuantity="0" mm:maxOccursQuantity="1">
          <Property s:uri="M_MODEL#AbstractIndicator" xsi:nil="true"/>
        </HasProperty>
        <HasProperty mm:sequenceID="2" mm:minOccursQuantity="0" mm:maxOccursQuantity="1">
          <Property>
            <Name>ExtensionOf</Name>
            <Namespace s:uri="#model" xsi:nil="true"/>
            <DefinitionText>A extension of a class.</DefinitionText>
            <Class>
              <Name>ExtensionOfType</Name>
              <Namespace s:uri="#model" xsi:nil="true"/>
              <DefinitionText>A data type for an extension of a class.</DefinitionText>
              <ExtensionOf>
                <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
                <HasProperty mm:sequenceID="1" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
                  <Property s:uri="M_MODEL#Class" xsi:nil="true"/>
                </HasProperty>
                <HasProperty mm:sequenceID="2" mm:minOccursQuantity="0" mm:maxOccursQuantity="unbounded">
                  <Property>
                    <Name>HasValue</Name>
                    <Namespace s:uri="#model" xsi:nil="true"/>
                    <DefinitionText>An occurrence of a data value as content of a class.</DefinitionText>
                    <Class>
                      <Name>HasValueType</Name>
                      <Namespace s:uri="#model" xsi:nil="true"/>
                      <DefinitionText>A data type for an occurrence of a value as content of a class.</DefinitionText>
                      <ExtensionOf>
                        <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
                        <HasProperty mm:sequenceID="1" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
                          <Property s:uri="M_MODEL#Datatype" xsi:nil="true"/>
                        </HasProperty>
                      </ExtensionOf>
                    </Class>
                  </Property>
                </HasProperty>
                <HasProperty mm:sequenceID="3" mm:minOccursQuantity="0" mm:maxOccursQuantity="unbounded">
                  <Property>
                    <Name>HasDataProperty</Name>
                    <Namespace s:uri="#model" xsi:nil="true"/>
                    <DefinitionText>An occurrence of a data property within a class.</DefinitionText>
                    <Class>
                      <Name>HasDataPropertyType</Name>
                      <Namespace s:uri="#model" xsi:nil="true"/>
                      <DefinitionText>A data type for an occurrence of a data property within a class.</DefinitionText>
                      <ExtensionOf>
                        <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
                        <HasDataProperty mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
                          <DataProperty s:uri="M_MODEL#minOccursQuantity" xsi:nil="true"/>
                        </HasDataProperty>
                        <HasDataProperty mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
                          <DataProperty s:uri="M_MODEL#maxOccursQuantity" xsi:nil="true"/>
                        </HasDataProperty>
                        <HasProperty mm:sequenceID="1" mm:minOccursQuantity="0" mm:maxOccursQuantity="unbounded">
                          <Property s:uri="M_MODEL#DataProperty" xsi:nil="true"/>
                        </HasProperty>
                      </ExtensionOf>
                    </Class>
                  </Property>
                </HasProperty>
                <HasProperty mm:sequenceID="4" mm:minOccursQuantity="0" mm:maxOccursQuantity="unbounded">
                  <Property>
                    <Name>HasProperty</Name>
                    <Namespace s:uri="#model" xsi:nil="true"/>
                    <DefinitionText>An occurrence of an object property within a class.</DefinitionText>
                    <Class>
                      <Name>HasPropertyType</Name>
                      <Namespace s:uri="#model" xsi:nil="true"/>
                      <DefinitionText>A data type for an occurrence of an object property within a class.</DefinitionText>
                      <ExtensionOf>
                        <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
                        <HasDataProperty mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
                          <DataProperty>
                            <Name>sequenceID</Name>
                            <Namespace s:uri="#model" xsi:nil="true"/>
                            <DefinitionText>An identifier for the order of an object property within a class.</DefinitionText>
                            <Datatype s:uri="M_XS#positiveInteger" xsi:nil="true"/>
                          </DataProperty>
                        </HasDataProperty>
                        <HasDataProperty mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
                          <DataProperty s:uri="M_MODEL#minOccursQuantity" xsi:nil="true"/>
                        </HasDataProperty>
                        <HasDataProperty mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
                          <DataProperty s:uri="M_MODEL#maxOccursQuantity" xsi:nil="true"/>
                        </HasDataProperty>
                        <HasProperty mm:sequenceID="1" mm:minOccursQuantity="0" mm:maxOccursQuantity="unbounded">
                          <Property s:uri="M_MODEL#Property" xsi:nil="true"/>
                        </HasProperty>
                      </ExtensionOf>
                    </Class>
                  </Property>
                </HasProperty>
              </ExtensionOf>
            </Class>
          </Property>
        </HasProperty>
        <HasProperty mm:sequenceID="3" mm:minOccursQuantity="0" mm:maxOccursQuantity="1">
          <Property>
            <Name>ContentStyleCode</Name>
            <Namespace s:uri="#model" xsi:nil="true"/>
            <DefinitionText>An indication of whether a referenced class has simple content or complex content.</DefinitionText>
            <Class>
              <Name>ContentStyleCodeType</Name>
              <Namespace s:uri="#model" xsi:nil="true"/>
              <DefinitionText>A data type for an indication of whether a referenced class has simple content or complex content.</DefinitionText>
              <ExtensionOf>
                <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
                <HasValue>
                  <Datatype>
                    <Name>ContentStyleCodeSimpleType</Name>
                    <Namespace s:uri="#model" xsi:nil="true"/>
                    <DefinitionText>A data type for an indication of whether a referenced class has simple content or complex content.</DefinitionText>
                    <RestrictionOf>
                      <Datatype s:uri="M_XS#string" xsi:nil="true"/>
                      <Enumeration>
                        <StringValue>HasValue</StringValue>
                        <DefinitionText>A class contains a datatype value.</DefinitionText>
                      </Enumeration>
                      <Enumeration>
                        <StringValue>HasProperty</StringValue>
                        <DefinitionText>A class contains object properties.</DefinitionText>
                      </Enumeration>
                    </RestrictionOf>
                  </Datatype>
                </HasValue>
              </ExtensionOf>
            </Class>
          </Property>
        </HasProperty>        
      </ExtensionOf>
    </Class>
  </Property>

  <DataProperty s:uri="M_MODEL#minOccursQuantity">
    <Name>minOccursQuantity</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A minimum number of times a property may occur within a class.</DefinitionText>
    <Datatype s:uri="M_XS#nonNegativeInteger" xsi:nil="true"/>
  </DataProperty>
  <DataProperty s:uri="M_MODEL#maxOccursQuantity">
    <Name>maxOccursQuantity</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A maximum number of times a property may occur within a class.</DefinitionText>
    <Datatype>
      <Name>MaxOccursSimpleType</Name>
      <Namespace s:uri="#model" xsi:nil="true"/>
      <DefinitionText>A data type for the maximum number of times a property may occur within a class.</DefinitionText>
      <UnionOf>
        <Datatype s:uri="M_XS#nonNegativeInteger" xsi:nil="true"/>
        <Datatype>
          <Name>MaxOccursUnboundedCodeSimpleType</Name>
          <Namespace s:uri="#model" xsi:nil="true"/>
          <DefinitionText>A data type for identifying that there is no maximum number of times that a property may occur within a class.</DefinitionText>
          <RestrictionOf>
            <Datatype s:uri="M_XS#string" xsi:nil="true"/>
            <Enumeration>
              <StringValue>unbounded</StringValue>
              <DefinitionText>There is no maximum number of times that a property may occur.</DefinitionText>
            </Enumeration>
          </RestrictionOf>
        </Datatype>
      </UnionOf>
    </Datatype>
  </DataProperty>

  <Property s:uri="M_MODEL#DataProperty">
    <Name>DataProperty</Name>
    <Namespace xsi:nil="true" s:uri="#model"/>
    <DefinitionText>A data property.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#ModelItemAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class>
      <Name>DataPropertyType</Name>
      <Namespace s:uri="#model" xsi:nil="true"/>
      <DefinitionText>A data type for a data property.</DefinitionText>
      <ExtensionOf>
        <Class s:uri="M_MODEL#ComponentType" xsi:nil="true"/>
        <HasProperty mm:sequenceID="1" mm:minOccursQuantity="0" mm:maxOccursQuantity="1">
          <Property s:uri="M_MODEL#Datatype" xsi:nil="true"/>
        </HasProperty>
      </ExtensionOf>
    </Class>
  </Property>

  <Property s:uri="M_MODEL#Datatype">
    <Name>Datatype</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A datatype.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#ModelItemAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class>
      <Name>DatatypeType</Name>
      <Namespace s:uri="#model" xsi:nil="true"/>
      <DefinitionText>A data type for a data type.</DefinitionText>
      <ExtensionOf>
        <Class s:uri="M_MODEL#ComponentType" xsi:nil="true"/>
        <HasProperty mm:sequenceID="1" mm:minOccursQuantity="0" mm:maxOccursQuantity="1">
          <Property>
            <Name>RestrictionOf</Name>
            <Namespace s:uri="#model" xsi:nil="true"/>
            <DefinitionText>A restriction of a data type.</DefinitionText>
            <Class>
              <Name>RestrictionOfType</Name>
              <Namespace s:uri="#model" xsi:nil="true"/>
              <DefinitionText>A data type for a restriction of a data type.</DefinitionText>
              <ExtensionOf>
                <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
                <HasProperty mm:sequenceID="1" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
                  <Property s:uri="M_MODEL#Datatype" xsi:nil="true"/>
                </HasProperty>
                <HasProperty mm:sequenceID="2" mm:minOccursQuantity="0" mm:maxOccursQuantity="unbounded">
                  <Property s:uri="M_MODEL#FacetAbstract">
                    <Name>FacetAbstract</Name>
                    <Namespace s:uri="#model" xsi:nil="true"/>
                    <DefinitionText>A data concept for a facet that restricts an aspect of a data type.</DefinitionText>
                    <AbstractIndicator>true</AbstractIndicator>
                  </Property>
                </HasProperty>
              </ExtensionOf>
            </Class>
          </Property>
        </HasProperty>
        <HasProperty mm:sequenceID="2" mm:minOccursQuantity="0" mm:maxOccursQuantity="1">
          <Property>
            <Name>UnionOf</Name>
            <Namespace s:uri="#model" xsi:nil="true"/>
            <DefinitionText>A union of data types.</DefinitionText>
            <Class>
              <Name>UnionOfType</Name>
              <Namespace s:uri="#model" xsi:nil="true"/>
              <DefinitionText>A data type for a union of data types.</DefinitionText>
              <ExtensionOf>
                <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
                <HasProperty mm:sequenceID="1" mm:minOccursQuantity="1" mm:maxOccursQuantity="unbounded">
                  <Property s:uri="M_MODEL#Datatype" xsi:nil="true"/>
                </HasProperty>
              </ExtensionOf>
            </Class>
          </Property>
        </HasProperty>
      </ExtensionOf>
    </Class>
  </Property>

  <Property s:uri="M_MODEL#DefinitionText">
    <Name>DefinitionText</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A human-readable text definition of a data model component.</DefinitionText>
    <Class s:uri="M_XS_PROXY#string" xsi:nil="true"/>
  </Property>
  <Property s:uri="M_MODEL#AbstractIndicator">
    <Name>AbstractIndicator</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>True if a component is a base for extension, and must be specialized to be used directly; false if a component may be used directly.</DefinitionText>
    <Class s:uri="M_XS_PROXY#boolean" xsi:nil="true"/>
  </Property>

  <!-- facet stuff -->
  <Property>
    <Name>Length</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A restriction of the length of a data type. Unit of length varies depending on the type that is being derived from.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#FacetAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class s:uri="M_MODEL#NonNegativeValueFacetType">
      <Name>NonNegativeValueFacetType</Name>
      <Namespace s:uri="#model" xsi:nil="true"/>
      <DefinitionText>A data type for a restriction of the length of a data type.</DefinitionText>
      <ExtensionOf>
        <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
        <HasProperty mm:sequenceID="1" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
          <Property s:uri="M_MODEL#NonNegativeValue" xsi:nil="true"/>
        </HasProperty>
        <HasProperty mm:sequenceID="2" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
          <Property s:uri="M_MODEL#DefinitionText" xsi:nil="true"/>
        </HasProperty>
      </ExtensionOf>
    </Class>
  </Property>
  <Property>
    <Name>MinLength</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A minimum length of a data type. Unit of length varies depending on the type that is being derived from.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#FacetAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class s:uri="M_MODEL#NonNegativeValueFacetType" xsi:nil="true"/>
  </Property>
  <Property>
    <Name>MaxLength</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A maximum length of a data type. Unit of length varies depending on the type that is being derived from.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#FacetAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class s:uri="M_MODEL#NonNegativeValueFacetType" xsi:nil="true"/>
  </Property>
  <Property>
    <Name>Pattern</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A restriction of the content of a datatype to values that match a specific pattern, provided as a regular expression.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#FacetAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class>
      <Name>PatternFacetType</Name>
      <Namespace s:uri="#model" xsi:nil="true"/>
      <DefinitionText>A data type for restricting the content of a datatype to values that match a specific pattern, provided as a regular expression.</DefinitionText>
      <ExtensionOf>
        <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
        <HasProperty mm:sequenceID="1" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
          <Property s:uri="M_MODEL#StringValue" xsi:nil="true"/>
        </HasProperty>
        <HasProperty mm:sequenceID="2" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
          <Property s:uri="M_MODEL#DefinitionText" xsi:nil="true"/>
        </HasProperty>
      </ExtensionOf>
    </Class>
  </Property>
  <Property>
    <Name>Enumeration</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A restriction of the length of a data type.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#FacetAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class s:uri="M_MODEL#AnyValueFacetType">
      <Name>AnyValueFacetType</Name>
      <Namespace s:uri="#model" xsi:nil="true"/>
      <DefinitionText>A data type for a facet that can have any value type.</DefinitionText>
      <ExtensionOf>
        <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
        <HasProperty mm:sequenceID="1" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
          <Property s:uri="M_MODEL#AnyValueAbstract" xsi:nil="true"/>
        </HasProperty>
        <HasProperty mm:sequenceID="2" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
          <Property s:uri="M_MODEL#DefinitionText" xsi:nil="true"/>
        </HasProperty>
      </ExtensionOf>
    </Class>
  </Property>
  <Property>
    <Name>WhiteSpace</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A constraint on how white space within data values is handled.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#FacetAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class>
      <Name>WhiteSpaceFacetType</Name>
      <Namespace s:uri="#model" xsi:nil="true"/>
      <DefinitionText>A data type constraining how white space within data values is handled.</DefinitionText>
      <ExtensionOf>
        <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
        <HasProperty mm:sequenceID="1" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
          <Property>
            <Name>WhiteSpaceValueCode</Name>
            <Namespace s:uri="#model" xsi:nil="true"/>
            <DefinitionText>A value of a specification of white space for a data type.</DefinitionText>
            <Class>
              <Name>WhiteSpaceValueCodeType</Name>
              <Namespace s:uri="#model" xsi:nil="true"/>
              <DefinitionText>A data type for a specification of white space for a data type.</DefinitionText>
              <ExtensionOf>
                <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
                <HasValue>
                  <Datatype>
                    <Name>WhiteSpaceFacetCodeSimpleType</Name>
                    <Namespace s:uri="#model" xsi:nil="true"/>
                    <DefinitionText>A data type for a data type for a specification of white space for a data type.</DefinitionText>
                    <RestrictionOf>
                      <Datatype s:uri="M_XS#string" xsi:nil="true"/>
                      <Enumeration>
                        <StringValue>preserve</StringValue>
                        <DefinitionText>No normalization is done, the value is not changed (this is the behavior required by [XML 1.0 (Second Edition)] for element content)</DefinitionText>
                      </Enumeration>
                      <Enumeration>
                        <StringValue>replace</StringValue>
                        <DefinitionText>All occurrences of #x9 (tab), #xA (line feed) and #xD (carriage return) are replaced with #x20 (space)</DefinitionText>
                      </Enumeration>
                      <Enumeration>
                        <StringValue>collapse</StringValue>
                        <DefinitionText>After the processing implied by replace, contiguous sequences of #x20's are collapsed to a single #x20, and leading and trailing #x20's are removed.</DefinitionText>
                      </Enumeration>
                    </RestrictionOf>
                  </Datatype>
                </HasValue>
              </ExtensionOf>
            </Class>
          </Property>
        </HasProperty>
        <HasProperty mm:sequenceID="2" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
          <Property s:uri="M_MODEL#DefinitionText" xsi:nil="true"/>
        </HasProperty>
      </ExtensionOf>
    </Class>
  </Property>
  <Property>
    <Name>MaxInclusive</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>An inclusive upper bound of a data type.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#FacetAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class s:uri="M_MODEL#AnyValueFacetType" xsi:nil="true"/>
  </Property>
  <Property>
    <Name>MaxExclusive</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>An exclusive upper bound of a data type.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#FacetAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class s:uri="M_MODEL#AnyValueFacetType" xsi:nil="true"/>
  </Property>
  <Property>
    <Name>MinExclusive</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>An exclusive lower bound of a data type.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#FacetAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class s:uri="M_MODEL#AnyValueFacetType" xsi:nil="true"/>
  </Property>
  <Property>
    <Name>MinInclusive</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>An inclusive lower bound of a data type.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#FacetAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class s:uri="M_MODEL#AnyValueFacetType" xsi:nil="true"/>
  </Property>
  <Property>
    <Name>TotalDigits</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A restriction on the precision and of a decimal data type, via a restriction on the number of digits required to represent its value.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#FacetAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class s:uri="M_MODEL#PositiveValueFacetType">
      <Name>PositiveValueFacetType</Name>
      <Namespace s:uri="#model" xsi:nil="true"/>
      <DefinitionText>A data type for a facet that carries a value that is a positive integer.</DefinitionText>
      <ExtensionOf>
        <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
        <HasProperty mm:sequenceID="1" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
          <Property s:uri="M_MODEL#PositiveValue" xsi:nil="true"/>
        </HasProperty>
        <HasProperty mm:sequenceID="2" mm:minOccursQuantity="1" mm:maxOccursQuantity="1">
          <Property s:uri="M_MODEL#DefinitionText" xsi:nil="true"/>
        </HasProperty>
      </ExtensionOf>
    </Class>
  </Property>
  <Property>
    <Name>FractionDigits</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A restriction on the precision and of a decimal data type, via a restriction on the number of digits allowed to the right of the decimal point of its decimal representation.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#FacetAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class s:uri="M_MODEL#NonNegativeValueFacetType" xsi:nil="true"/>
  </Property>
  
  
  <Property s:uri="M_MODEL#AnyValueAbstract">
    <Name>AnyValueAbstract</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A data concept for a value of a facet.</DefinitionText>
    <AbstractIndicator>true</AbstractIndicator>
  </Property>
  <Property s:uri="M_MODEL#NonNegativeValue">
    <Name>NonNegativeValue</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A value of a facet, with an integer value zero or greater.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#AnyValueAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class s:uri="M_XS_PROXY#nonNegativeInteger" xsi:nil="true"/>
  </Property>
  <Property s:uri="M_MODEL#PositiveValue">
    <Name>PositiveValue</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A value of a facet, with an integer value greater than zero.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#AnyValueAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class s:uri="M_XS_PROXY#positiveInteger" xsi:nil="true"/>
  </Property>
  <Property s:uri="M_MODEL#StringValue">
    <Name>StringValue</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A value of a facet, with a string value.</DefinitionText>
    <SubPropertyOf>
      <Property s:uri="M_MODEL#AnyValueAbstract" xsi:nil="true"/>
    </SubPropertyOf>
    <Class s:uri="M_XS_PROXY#string" xsi:nil="true"/>
  </Property>

  <Class s:uri="M_MODEL#NCName">
    <Name>NCName</Name>
    <Namespace s:uri="#model" xsi:nil="true"/>
    <DefinitionText>A data type for XML names that exclude a colon character.</DefinitionText>
    <ExtensionOf>
      <Class s:uri="M_STRUCTURES#ObjectType" xsi:nil="true"/>
      <HasValue>
        <Datatype s:uri="M_XS#NCName" xsi:nil="true"/>
      </HasValue>
    </ExtensionOf>
  </Class>

  <Namespace s:uri="#structures">
    <NamespaceURI>http://release.niem.gov/niem/structures/4.0/</NamespaceURI>
    <NamespacePrefixName>structures</NamespacePrefixName>
  </Namespace>
  <Class s:uri="M_STRUCTURES#ObjectType">
    <Name>ObjectType</Name>
    <Namespace s:uri="#structures" xsi:nil="true"/>
  </Class>

  <Namespace s:uri="#xs-proxy">
    <NamespaceURI>http://release.niem.gov/niem/proxy/xsd/4.0/</NamespaceURI>
    <NamespacePrefixName>xs-proxy</NamespacePrefixName>
  </Namespace>
  <Class s:uri="M_XS_PROXY#string">
    <Name>string</Name>
    <Namespace s:uri="#xs-proxy" xsi:nil="true"/>
    <ContentStyleCode>HasValue</ContentStyleCode>
  </Class>
  <Class s:uri="M_XS_PROXY#anyURI">
    <Name>anyURI</Name>
    <Namespace s:uri="#xs-proxy" xsi:nil="true"/>
    <ContentStyleCode>HasValue</ContentStyleCode>
  </Class>
  <Class s:uri="M_XS_PROXY#nonNegativeInteger">
    <Name>nonNegativeInteger</Name>
    <Namespace s:uri="#xs-proxy" xsi:nil="true"/>
    <ContentStyleCode>HasValue</ContentStyleCode>
  </Class>
  <Class s:uri="M_XS_PROXY#positiveInteger">
    <Name>positiveInteger</Name>
    <Namespace s:uri="#xs-proxy" xsi:nil="true"/>
    <ContentStyleCode>HasValue</ContentStyleCode>
  </Class>
  <Class s:uri="M_XS_PROXY#boolean">
    <Name>boolean</Name>
    <Namespace s:uri="#xs-proxy" xsi:nil="true"/>
    <ContentStyleCode>HasValue</ContentStyleCode>
  </Class>

  <Namespace s:uri="#xs">
    <NamespaceURI>http://www.w3.org/2001/XMLSchema</NamespaceURI>
    <NamespacePrefixName>xs</NamespacePrefixName>
  </Namespace>
  <Datatype s:uri="M_XS#NCName">
    <Name>NCName</Name>
    <Namespace s:uri="#xs" xsi:nil="true"/>
  </Datatype>
  <Datatype s:uri="M_XS#nonNegativeInteger">
    <Name>nonNegativeInteger</Name>
    <Namespace s:uri="#xs" xsi:nil="true"/>
  </Datatype>
  <Datatype s:uri="M_XS#positiveInteger">
    <Name>positiveInteger</Name>
    <Namespace s:uri="#xs" xsi:nil="true"/>
  </Datatype>
  <Datatype s:uri="M_XS#string">
    <Name>string</Name>
    <Namespace s:uri="#xs" xsi:nil="true"/>
  </Datatype>

</Model>
