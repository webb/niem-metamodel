

default: ../tmp/valid/example-xsd/claim.xml

.PHONY: valid-before
valid-before:
	${MAKE} -C .. tmp/token/valid-xsd-generated/example/extension.xml
	${MAKE} -C .. tmp/token/valid-sch/example/extension.xml

../tmp/valid/example-xsd/%.xml: %.xml generated/xsd/xml-catalog.xml ${shell find niem -type f}
	xs-validate -c xml-catalog.xml $<
	mkdir -p ${dir $@}
	touch $@

generated/xsd/xml-catalog.xml: extension.xml
	rm -rf generated/xsd
	saxon -x ../generate-xsd.xsl -i $<

.PHONY: clean
clean:
	rm -rf generated/xsd
	rm -rf ../tmp/valid/example-xsd
	rm -rf ../tmp/valid-xsd-generated/example
	rm -rf ../tmp/valid-sch/example

