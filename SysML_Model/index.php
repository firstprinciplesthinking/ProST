<?php
	$model = new DOMDocument();
	$model->load('ProST.uml');

	$model2xml_xsl = new DOMDocument();
	$model2xml_xsl->load('model2xml.xsl');
	
	$model2xml = new XsltProcessor();
	$model2xml->importStylesheet($model2xml_xsl);
	$xml_doc = $model2xml->transformToDoc($model);
	$xml_doc->preserveWhiteSpace = false;
	$xml_doc->formatOutput = true;
	$xml = $xml_doc->saveXML($xml_doc);
	file_put_contents('model.xml', $xml);
	echo $xml;

	//$xml2html = new XsltProcessor();
	//$xml2html->importStylesheet(new DOMDocument()->load('xml2html.xsl'));
	//$html = $xml2html->transformToDoc($xml)->saveHTML();
	//file_put_contents('index.html', $html);
	//echo $html;
?>