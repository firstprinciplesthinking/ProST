<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:uml="http://www.eclipse.org/uml2/5.0.0/UML"
                xmlns:sysml="http://www.eclipse.org/papyrus/1.6.0/SysML"
                xmlns:xmi="http://www.omg.org/spec/XMI/20131001"
                exclude-result-prefixes="uml sysml xmi">

    <xsl:output method="xml" indent="yes"/>

    <!-- Template for the XMI root element -->
    <xsl:template match="/xmi:XMI">
		<!-- Apply templates to all contained elements -->
		<xsl:apply-templates select="//uml:Model"/>
    </xsl:template>

    <!-- Template for UML Model -->
    <xsl:template match="uml:Model">
		<model>
			<id><xsl:value-of select="@xmi:id"/></id>
			<name><xsl:value-of select="@name"/></name>
			<xsl:apply-templates select="nestedClassifier|packagedElement|ownedComment"/>
		</model>
    </xsl:template>

    <!-- Template for building a element including it sub elements -->
    <xsl:template match="nestedClassifier|packagedElement|ownedComment">
		<xsl:variable name="id" select="@xmi:id" />
		<element>
			<id><xsl:value-of select="@xmi:id"/></id>
			<name><xsl:value-of select="@name"/></name>
			<profile>
				<id><xsl:value-of select="@xmi:id"/></id>
				<type><xsl:value-of select="@xmi:type"/></type>
				<name><xsl:value-of select="@name"/></name>
			</profile>
			<xsl:for-each select="//*[@base_NamedElement=$id]|//*[@base_Classifier=$id]">
			<profile>
				<id><xsl:value-of select="@xmi:id"/></id>
				<type><xsl:value-of select="name(.)"/></type>
				<xsl:for-each select="./@*">
					<xsl:variable name="name" select="name(.)" />
					<xsl:element name="{$name}"><xsl:value-of select="."/></xsl:element>
				</xsl:for-each>
			</profile>
			</xsl:for-each>
			<link>
				<id></id>
				<name></name>
				<direction></direction>
			</link>
			<xsl:apply-templates select="nestedClassifier|packagedElement|ownedComment"/>
		</element>
    </xsl:template>
</xsl:stylesheet>