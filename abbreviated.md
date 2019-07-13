
# an abbreviated JSON-LD syntax for models

This could be called a normalized form for models. 

Basic philosophy: omit anything from the syntax of the model that could be interpreted from the content of the JSON-LD expanded content.

For example, IDs of components are significant:

- m:namespace/m:namespaceURI = value of m:namespace/@id
- You can't substitute m:namespace/m:prefix with something from the context, since the context would go away in the expanded JSON-LD content.
- m:property/m:class:
    - m:definition is derived
    - m:name is derived
    - m:abstract indicator is default false 
- m:hasProperty:
    - m:sequenceID is derived from location within its sequence
    - m:minimumOccurrence defaults to 1
    - m:maximumOccurrence defaults to 1
    
- How do we construct the URI for a component from its name pieces? Are we supposed to stick with NIEM / XSD naming conventions? Even if we're targeting JSON?
