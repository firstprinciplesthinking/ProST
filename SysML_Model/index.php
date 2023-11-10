<?php
	$xml = new DOMDocument();
	$xml->load('ProST.uml');

	$xsl = new DOMDocument();
	$xsl->load('ProST.xsl');

	$xslt = new XsltProcessor();
	$xslt->importStylesheet($xsl);

	$result = $xslt->transformToDoc($xml);
	$html = $result->saveHTML();
	echo $html;
	file_put_contents('index.html', $html);
?>