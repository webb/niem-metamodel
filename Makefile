
png_target_files = ${patsubst %.dot,generated/%.png,${wildcard *.dot}}

targets = \
  docs/niem-metamodel.png \
  docs/NIEM-Metamodel.pptx \
  tmp/token/xml/metamodel.xml \
  tmp/token/valid-xsd/metamodel.xml \
  tmp/token/valid-sch/metamodel.xml \
  tmp/token/generated-xsd \
  tmp/token/valid-xsd-generated/metamodel.xml \
  ${png_target_files} \

.PHONY: default
default: ${targets}

.PHONY: png
png: ${png_target_files}

.PHONY: vxsd
vxsd: tmp/token/valid-xsd/metamodel.xml

.PHONY: v2
v2: xsd
	xs-validate -c xml-catalog-generated.xml metamodel.xml

.PHONY: sch
sch: tmp/token/valid-sch/metamodel.xml

tmp/augmented.xml: tmp/restacked.xml augment.xsl functions.xsl
	mkdir -p ${dir $@}
	saxon --in=$< --out=$@ --xsl=augment.xsl

tmp/restacked.xml: metamodel.xml restack.xsl functions.xsl
	mkdir -p ${dir $@}
	saxon --in=$< --out=$@ --xsl=restack.xsl

tmp/token/generated-xsd: metamodel.xml generate-xsd.xsl functions.xsl
	rm -rf generated/xsd
	mkdir -p generated/xsd
	saxon --in=metamodel.xml --xsl=generate-xsd.xsl
	mkdir -p ${dir $@}
	touch $@

tmp/token/valid-xsd-generated/%.xml: %.xml tmp/token/generated-xsd xml-catalog-generated.xml ${shell find niem -type f}
	xs-validate -c xml-catalog-generated.xml $<
	mkdir -p ${dir $@}
	touch $@

.PHONY: xsd
xsd:
	rm -rf generated/xsd tmp/token/generated-xsd 
	${MAKE} tmp/token/generated-xsd

generated/%.png: %.dot
	dot -Tpng -o$@ $<

tmp.metamodel.sch.xsl: metamodel.sch functions.xsl
	schematron-compile --output-file=$@ $<

tmp/token/valid-sch/%: % tmp.metamodel.sch.xsl functions.xsl
	schematron-execute --xslt-file=tmp.metamodel.sch.xsl $<
	mkdir -p ${dir $@}
	touch $@

tmp/token/valid-xsd/%: %
	xs-validate -c xml-catalog.xml $<
	mkdir -p ${dir $@}
	touch $@

.PHONY: clean
clean:
	${RM} -rf tmp generated
	${RM} ${wildcard tmp.*}

# conformance check
cc: tmp/token/generated-xsd
	schematron-execute --xslt-file=../ndr/artifacts/repo/ndr-rules-conformance-target-ref.sch.xsl generated/xsd/mm.xsd


# xml via xmllint check
tmp/token/xml/%: %
	xmllint --noout $<
	mkdir -p ${dir $@}
	touch $@

docs/niem-metamodel.png: metamodel-tb.dot
	dot -Tpng -o$@ $<

# output format: pptx
# input: markdown_strict
# doesn't work well:	  --reference-doc=reference.pptx
docs/NIEM-Metamodel.pptx: slides.md reference.pptx generated/metamodel-core.png
	pandoc \
	  --to=pptx --output=$@ \
	  --reference-doc=reference.pptx \
	  --from=markdown_strict+yaml_metadata_block $< \


