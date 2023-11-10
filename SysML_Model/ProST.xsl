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
                <title>SysML HTML5 Viewer</title>
				<link rel="stylesheet" type="text/css" href="ProST.css" />
            </head>
            <body>
                <h1>SysML HTML5 Viewer</h1>
                <!-- Apply templates to all contained elements -->
                <xsl:apply-templates select="//uml:Model"/>
            </body>
        </html>
    </xsl:template>

    <!-- Template for UML Model -->
    <xsl:template match="uml:Model">
        <h2>Model: <xsl:value-of select="@name"/></h2>
		
        <!-- Apply templates to all first children of the model element -->
		<ul class="tree">
			<xsl:apply-templates select="nestedClassifier|packagedElement"/>
		</ul>
    </xsl:template>

    <!-- Template for building a element including it sub elements -->
    <xsl:template match="nestedClassifier|packagedElement">
		<xsl:variable name="id" select="@xmi:id" />
		<li class="tree">
			<details>
				<summary><xsl:value-of select="@name"/></summary>
				<table>
					<tr>
						<td>Type</td>
						<td><xsl:value-of select="@xmi:type"/></td>
					</tr>
					<tr>
						<td>ID</td>
						<td><xsl:value-of select="@xmi:id"/></td>
					</tr>
					<tr>
						<td>Name</td>
						<td><xsl:value-of select="@name"/></td>
					</tr>
					<xsl:for-each select="//*[@base_NamedElement=$id]">
						<xsl:if test="name(.) = 'Requirements:Requirement'">
						<tr>
							<td>Requirement</td>
							<td><xsl:value-of select="@text"/></td>
						</tr>
						</xsl:if>
						
						<xsl:if test="name(.) = 'ProST:StakeholderNeed'">
						<tr>
							<td>Stakeholder Need</td>
							<td><xsl:value-of select="@text"/></td>
						</tr>
						</xsl:if>
					</xsl:for-each>
				</table>
			<xsl:if test="*">
				<ul class="tree">
					<xsl:apply-templates select="nestedClassifier|packagedElement"/>
				</ul>
			</xsl:if>
			</details>
		</li>
    </xsl:template>
</xsl:stylesheet>