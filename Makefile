
targets = tmp/token/valid-sch/metamodel.xml

.PHONY: default
default: ${targets} metamodel.png xsd tmp/metamodel.png

tmp/metamodel.png: metamodel.dot
	dot -Tpng -o$@ $<

.PHONY: xsd
xsd:
	rm -rf tmp/xsd
	mkdir -p tmp/xsd
	saxon --in=metamodel.xml --xsl=generate-xsd.xsl

tmp.metamodel.sch.xsl: metamodel.sch functions.xsl
	schematron-compile --output-file=$@ $<

tmp/token/valid-sch/%: % tmp.metamodel.sch.xsl functions.xsl
	schematron-execute --xslt-file=tmp.metamodel.sch.xsl $<
	mkdir -p ${dir $@}
	touch $@

.PHONY: clean
clean:
	${RM} -rf tmp
	${RM} ${wildcard tmp.*}
