m4_changequote([[[,]]])m4_dnl
m4_changecom(,)m4_dnl
m4_define([[[M_NS_CLAIM]]],[[[http://example.org/claim/1/]]])m4_dnl
m4_define([[[M_NS_MODEL]]],[[[http://reference.niem.gov/specification/metamodel/5.0alpha1]]])m4_dnl
m4_define([[[M_NS_STRUCTURES]]],[[[http://release.niem.gov/niem/structures/4.0/]]])m4_dnl
m4_define([[[M_NS_NC]]],[[[http://release.niem.gov/niem/niem-core/4.0/]]])m4_dnl
<?xml version="1.0" encoding="UTF-8"?>
<Model
  xml:base="http://example.org/local"
  xmlns:m="M_NS_MODEL"
  xmlns:s="M_NS_STRUCTURES"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns="M_NS_MODEL">
  <Namespace s:uri="M_NS_CLAIM">
    <NamespaceURI>M_NS_CLAIM</NamespaceURI>
    <NamespacePrefixName>claim</NamespacePrefixName>
    <DefinitionText>A data model for an insurance claim.</DefinitionText>
  </Namespace>
  <Property s:uri="M_NS_CLAIM#DamagedVehicle">
    <Name>DamagedVehicle</Name>
    <Namespace s:uri="M_NS_CLAIM"/>
    <DefinitionText>A vehicle that has sustained damage.</DefinitionText>
    <Class s:uri="M_NS_NC#VehicleType"/>
  </Property>
  <Property s:uri="M_NS_CLAIM#VehicleDamageAmount">
    <Name>VehicleDamageAmount</Name>
    <Namespace s:uri="M_NS_CLAIM"/>
    <DefinitionText>An amount of money evaluating the cost of repair of damage to a vehicle.</DefinitionText>
    <Class s:uri="M_NS_NC#AmountType"/>
  </Property>
  <Property s:uri="M_NS_CLAIM#Claim">
    <Name>Claim</Name>
    <DefinitionText>An insurance claim resulting from an auto crash.</DefinitionText>
    <Class s:uri="M_NS_CLAIM#ClaimType"/>
  </Property>
  <Class s:uri="M_NS_CLAIM#ClaimType">
    <Name>ClaimType</Name>
    <Namespace s:uri="M_NS_CLAIM"/>
    <DefinitionText>A data type for an insurance claim.</DefinitionText>
    <ExtensionOf s:uri="M_NS_STRUCTURES#ObjectType"/>
    <HasProperty m:sequenceID="1" m:minOccursQuantity="1"
                 m:maxOccursQuantity="1">
      <Property s:uri="M_NS_CLAIM#DamagedVehicle"/>
    </HasProperty>
    <HasProperty m:sequenceID="2" m:minOccursQuantity="1"
                 m:maxOccursQuantity="1">
      <Property s:uri="M_NS_CLAIM#VehicleDamageAmount"/>
    </HasProperty>
  </Class>
</Model>
