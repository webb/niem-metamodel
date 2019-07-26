
SHELL = /bin/bash -o nounset -o errexit -o pipefail

default: ../tmp/valid/example-xsd/claim.xml

.SECONDARY:

.PHONY: restack
restack: tmp/extension-expand-compact.json

.PHONY: restack-json
restack-json: ${patsubst json/%,tmp/json-restacked/%,${shell find -type f -name '*.json'}}

tmp/json-restacked/%.json: tmp/json-expanded 
	jsonld 

tmp/json-restacked/%.json: json/%.json json/context.json
	jsonld 

tmp/json-restacked/%.json: json/%.json json/context.json
	jsonld 

tmp/extension.xml: extension.xml.m4
	mkdir -p ${dir $@}
	m4 -P $< > $@
	xmllint --noout $@

tmp/extension.json: tmp/extension.xml
	mkdir -p ${dir $@}
	saxon --xsl=${HOME}/r/niem/xslt/niem-xml-to-json/niem-xml-to-json.xsl --in=$< --out=$@

#tmp/extension-expand.json: tmp/extension.json context.json
#	mkdir -p ${dir $@}
#	jsonld expand $< > $@

tmp/extension-expand.json: tmp/extension.json
	cd tmp && jsonld expand extension.json > extension-expand.json

tmp/%-expand.json: tmp/%.json tmp/context.json
	cd tmp && jsonld expand $*.json > $*-expand.json

tmp/%-compact.json: tmp/%.json tmp/context.json
	cd tmp && jsonld compact -c context.json $*.json > $*-compact.json

tmp/context.json: target-context.json
	jq . $< > /dev/null || ( printf "ERROR: Not a valid JSON file: %s\n" $< && exit 1 )
	mkdir -p ${dir $@}
	cp $< $@

tmp/%.json: %.json
	jq . $< > /dev/null || ( printf "ERROR: Not a valid JSON file: %s\n" $< && exit 1 )
	mkdir -p ${dir $@}
	cp $< $@

.PHONY: valid-before
valid-before:
	${MAKE} -C .. tmp/token/valid-xsd-generated/example/extension.xml
	${MAKE} -C .. tmp/token/valid-sch/example/extension.xml

../tmp/valid/example-xsd/%.xml: %.xml generated/xsd/xml-catalog.xml ${shell find niem -type f}
	xs-validate -c xml-catalog.xml $<
	mkdir -p ${dir $@}
	touch $@

generated/xsd/xml-catalog.xml: tmp/extension.xml
	rm -rf generated/xsd
	saxon -x ../generate-xsd.xsl -i $<

.PHONY: clean
clean:
	rm -rf generated/xsd
	rm -rf ../tmp/valid/example-xsd
	rm -rf ../tmp/valid-xsd-generated/example
	rm -rf ../tmp/valid-sch/example
	rm -rf tmp

cc:
	schematron-execute --xslt-file=../../ndr/artifacts/repo/ndr-rules-conformance-target-ref.sch.xsl generated/xsd/claim.xsd
	schematron-execute --param=+xml-catalog=xml-catalog.xml --xslt-file=../../ndr/artifacts/repo/ndr-rules-conformance-target-set.sch.xsl generated/xsd/claim.xsd
