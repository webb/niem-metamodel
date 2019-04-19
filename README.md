A metamodel for NIEM.

# Terminology:

Primarily uses terms from RDFS and OWL.

- Model
    - an entire data model, profile, EIEM, or release.
- ObjectProperty
- Class - maps to XSD complex types
    - from RDFS
- Datatype
    - from rdfs:Datatype
    - maps to XSD simple types
- DataProperty
- SubClassOf
- SubPropertyOf

# Order

Consistently use this order:

1. Namespace
2. ObjectProperty
3. Class
4. DataProperty
5. Datatype

# Class content style

Each class needs to identify its content style as one of the following:

- HasValue
- HasObjectProperty

This is self-evident, given:

1. a reference to a base type which identifies its content style, and
2. extension content (has-value has-object-property)

# Versioning

- Later: 
    - include a "Release" object, that identifies a set of namespaces.
    - include versioning info, identifying relationships between versions of components
        - a namespace as a new version of another namespace
        - a class as a new version of a class
            - a class as *merging* two independent classes
    - include some kind of object that represents the concept of a namespace across multiple versions (e.g., the Justice domain *in general*).
    
    
# Relevant Specifications

- Constraning facets: <https://www.w3.org/TR/xmlschema-2/#rf-facets>
- List & Union: <https://www.w3.org/TR/xmlschema-2/#atomic-vs-list>

# TODO #

- Wantlist requirements:
    - How to cover profiling?
        - profile of a class:
            - don't need a base class
            - it doesn't have the "extensionof" semantic
            - it doesn't need to indicate the "hasvalue", as that's required
            - it needs has*property elements for "element in a type"
                    - there's not a simple way to wantlist "an element in a type" or "an attribute in a type".
                        - at this point, a reference to a type is just a pointer to the type
                        - I could have a "profile" element containing Has*Property elements
                    - Write something that generates a regular wantlist from the metamodel.
- Augmentations
    - We don't represent augmentations in the metamodel
    - It'd be nice for a model to be able to use its own augmentation points
    - We'll need to identify specific augmentation types and let domains build augmentation elements.

