
# Issues

## Representation of simple values

Allow for native representation of simple value content. Don't require a totally different hierarchy of properties for simple vs complex representation.

In XML Schema, represent (natively) elements with types of datatype instead of object.

In JSON schema, represent (natively) properties with types that are simple values vs. properties that are objects with properties and a simple value.

## Be a suitable representation for wantlists

Wantlists are different than model representations, and so may have a different syntax when they appear in a model.

- How to cover profiling / wantlists??
    - profile of a class:
        - don't need a base class
        - it doesn't have the "extensionof" semantic
        - it doesn't need to indicate the "hasvalue", as that's required
        - it needs has*property elements for "element in a type"
                - there's not a simple way to wantlist "an element in a type" or "an attribute in a type".
                    - at this point, a reference to a type is just a pointer to the type
                    - I could have a "profile" element containing Has*Property elements
                - Write something that generates a regular wantlist from the metamodel.

## Find a good way to handle augmentations

- We don't represent augmentations in the metamodel
- It'd be nice for a model to be able to use its own augmentation points
- We'll need to identify specific augmentation types and let domains build augmentation elements.

## Find a good way to handle roles

- How do you distinguish a "role" property from another type of property?

## Determine what level of detail the model should hold

- We could / should treat the representation of a component name as a CamelCasedName with a representation term as conforming to an implementation-specific convention.
- Our NDR specifies that component names are structured:
    - Each name has up to 3 terms; specifically a subject, property, and representation term.
    - Each term may have multiple words, and some of those words may be modifiers of the main words
- We could have the model carry the component names as structured names, rather than as CamelCaseNames. 
- We could leave out the representation terms from the structured names, carrying that as data associated with a property or type.

For example, the current model holds:

```xml
<Name>PersonGivenName</Name>
```

It could instead hold

```xml
<Name>person given name</Name>
```

With this representation, both the <q>Person</q> element and the <q>PersonType</q> complex type could have the same name, <q>person</q>, with the <q>Type</q> suffix automatically applied in translation from the model to XSD.

Or, you could break down names into parts:

```xml
<Name>
  <SubjectTerm>person</SubjectTerm>
  <PropertyTerm>given name</PropertyTerm>
  <RepresentationTerm>name</RepresentationTerm>
</Name>
```

One reason that we've never put a representation of term breakdown into the
model is that it any representation for it is exceedingly klunky and verbose.

There's not a good way to construct this breakdown from the XSD names
automatically, so translations to map between XSD and models would be lossy.

## Migrate NDR Rules to apply to models

Some NDR rules would be better fit to models than XML Schemas. Then those rules
could be applied to all implementations of models (e.g., JSON Schema, UML).

How would you write a rule that applied to a model and not a schema? If you did
Schematron, you'd still be pegged to XML representations of a model. You could
do Schematron with a language binding to Javascript, but that would be processed
with new code.

## Other options

- Handle attribute use (required, prohibited, etc).
- Add min / max occurs restrictiosn
    - 0-1 for attributes
    - min <= max
    
