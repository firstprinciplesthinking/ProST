<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:uml="http://www.eclipse.org/uml2/5.0.0/UML"
                xmlns:sysml="http://www.eclipse.org/papyrus/1.6.0/SysML"
                xmlns:xmi="http://www.omg.org/spec/XMI/20131001"
                exclude-result-prefixes="uml sysml xmi">

    <xsl:output method="html" indent="yes"/>

    <!-- Template for the XMI root element -->
    <xsl:template match="/xmi:XMI">
        <html>
            <head>
                <title>SysML Model</title>
            </head>
            <body>
                <h1>SysML Model Elements</h1>
                <!-- Apply templates to all contained elements -->
                <xsl:apply-templates select="//uml:Model"/>
            </body>
        </html>
    </xsl:template>

    <!-- Template for UML Model -->
    <xsl:template match="uml:Model">
        <h2>Model: <xsl:value-of select="@name"/></h2>
        <!-- Apply templates to child elements like Blocks, etc. -->
        <xsl:apply-templates select=".//uml:Class"/>
    </xsl:template>

    <!-- Template for SysML Blocks -->
    <xsl:template match="uml:Class[sysml:Block]">
        <h3>Block: <xsl:value-of select="@name"/></h3>
        <p>
            <strong>Block Description:</strong>
            <xsl:value-of select="uml:ownedComment/body"/>
        </p>
        <!-- You can add more detail about parts, properties, etc. -->
    </xsl:template>

    <!-- You would continue to add templates for other SysML and UML elements here -->

</xsl:stylesheet>