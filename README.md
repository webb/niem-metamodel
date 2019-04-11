A metamodel for NIEM.

Primarily uses terms from RDFS and OWL.

- Model
    - an entire data model, profile, EIEM, or release.
- Datatype
    - from rdfs:Datatype
    - maps to XSD simple types
- DatatypeProperty
    - from 
- ObjectProperty
- Class - maps to XSD complex types
    - from RDFS
- SubClassOf
- SubPropertyOf

Constraning facets: <https://www.w3.org/TR/xmlschema-2/#rf-facets>

List & Union: <https://www.w3.org/TR/xmlschema-2/#atomic-vs-list>


Christina's perspectives
- "accessors" to return different "slices" of the data
- 
- release
    - need to handle releases
        - a release is a collection of namespaces
        - "multiple versions of a namespace"
    - namespace as a new version of another namespace
    - component being a new version of another compoennt
    - can we look at a separate layer of release
    - "a model" versus "each iepd as its own model"
        - each could have their own releases
    - each namespace has a version attribute
- "namespace version"
- certain things optional vs required
    - schema generator
    - adapter
    - augmentation
    - metadata

