<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:uml="http://www.eclipse.org/uml2/5.0.0/UML"
                xmlns:sysml="http://www.eclipse.org/papyrus/1.6.0/SysML"
                xmlns:xmi="http://www.omg.org/spec/XMI/20131001"
                exclude-result-prefixes="uml sysml xmi">

    <xsl:output method="html" indent="yes"/>

    <!-- Template for the XMI root element -->
    <xsl:template match="/">
        <html>
            <head>
                <title>SysML HTML5 Viewer</title>
				<link rel="stylesheet" type="text/css" href="simple.css" />
            </head>
            <body>
                <h1>SysML HTML5 Viewer</h1>
                <!-- Apply templates to all contained elements -->
                <xsl:apply-templates select="model"/>
            </body>
        </html>
    </xsl:template>

    <!-- Template for UML Model -->
    <xsl:template match="model">
        <h2>Model: <xsl:value-of select="@name"/></h2>
		
        <!-- Apply templates to all first children of the model element -->
		<ul class="tree">
			<xsl:apply-templates select="element"/>
		</ul>
    </xsl:template>

    <!-- Template for building a element including it sub elements -->
    <xsl:template match="element">
		<xsl:variable name="id" select="id" />
		<li class="tree">
			<details id="{$id}">
				<summary>
					<xsl:value-of select="name"/>
					<xsl:for-each select="stereotype">
						<span> [<xsl:value-of select="type"/>]</span>
					</xsl:for-each>
				</summary>
					<xsl:for-each select="stereotype">
					<table>
						<tr>
							<td><xsl:value-of select="profile"/></td>
							<td><xsl:value-of select="type"/></td>
							<xsl:if test="profile = 'uml'">
								<td><xsl:value-of select="name"/></td>
								<xsl:if test="type = 'Comment'">
								<td><xsl:value-of select="text"/></td>
								</xsl:if>
							</xsl:if>
							<xsl:if test="type = 'Requirement'">
								<td><xsl:value-of select="text"/></td>
							</xsl:if>
						</tr>
					</table>
				</xsl:for-each>
				<xsl:if test="*">
					<ul class="tree">
						<xsl:apply-templates select="element"/>
					</ul>
				</xsl:if>
			</details>
		</li>
    </xsl:template>
</xsl:stylesheet>