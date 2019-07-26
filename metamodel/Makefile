
default: tmp/metamodel.json

.SECONDARY:

tmp/metamodel-unformatted.json: tmp/metamodel.xml
	@ mkdir -p ${dir $@}
	saxon --xsl=${HOME}/r/niem/xslt/niem-xml-to-json/niem-xml-to-json.xsl --in=$< --out=$@

tmp/context.json: target-context.json
	mkdir -p ${dir $@}
	jq . $< > $@

tmp/%.json: tmp/%-unformatted-expand-compact.json
	jq . $< > $@

%-expand.json: %.json
	jsonld expand $< > $@

tmp/%-compact.json: tmp/%.json tmp/context.json
	cd tmp && jsonld compact -c context.json $*.json > $*-compact.json

tmp/%: tmp/%.m4
	m4 -P $< > $@

tmp/%.json: %.json
	mkdir -p ${dir $@}
	jq . $< > $@

tmp/%: %
	mkdir -p ${dir $@}
	cp $< $@

.PHONY: clean
clean:
	${RM} -r tmp
