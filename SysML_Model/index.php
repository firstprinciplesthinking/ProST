<?php
 $xml = new DOMDocument();
 $xml->load('ProST.uml');
  
 $xsl = new DOMDocument();
 $xsl->load('ProST.xsl');
  
 $xslt = new XsltProcessor();
 $xslt->importStylesheet($xsl);
  
 $result = $xslt->transformToDoc($xml);
 echo $result->saveXML();
?>