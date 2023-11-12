<?php
	$model_doc = new DOMDocument();
	$model_doc->load('ProST.uml');

	$uml2xml_xsl = new DOMDocument();
	$uml2xml_xsl->load('uml2xml.xsl');
	$uml2xml = new XsltProcessor();
	$uml2xml->importStylesheet($uml2xml_xsl);
	$xml_doc = $uml2xml->transformToDoc($model_doc);
	$xml_doc->preserveWhiteSpace = false;
	$xml_doc->formatOutput = true;
	$xml = $xml_doc->saveXML($xml_doc);
	file_put_contents('model.xml', $xml);
	//echo $xml;


	$xml2html_xsl = new DOMDocument();
	$xml2html_xsl->load('xml2html.xsl');
	$xml2html = new XsltProcessor();
	$xml2html->importStylesheet($xml2html_xsl);
	$html_doc = $xml2html->transformToDoc($xml_doc);
	$html_doc->preserveWhiteSpace = false;
	$html_doc->formatOutput = true;
	$html = $html_doc->saveHTML();
	file_put_contents('index.html', $html);
	echo $html;
?>