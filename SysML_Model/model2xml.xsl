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
			<profiles>
				<xsl:for-each select="//*[@base_NamedElement=$id]|//*[@base_Classifier=$id]">
				<xsl:if test="name(.) = 'Requirements:Requirement'">
				<profile>
					<id><xsl:value-of select="@xmi:id"/></id>
					<name>Requirement</name>
					<text><xsl:value-of select="@text"/></text>
				</profile>
				</xsl:if>
				
				<xsl:if test="name(.) = 'ModelElements:Stakeholder'">
				<profile>
					<id><xsl:value-of select="@xmi:id"/></id>
					<name>Stakeholder</name>
				</profile>
				</xsl:if>
				
				<xsl:if test="name(.) = 'ProST:StakeholderInput'">
				<profile>
					<id><xsl:value-of select="@xmi:id"/></id>
					<name>Stakeholder Input</name>
				</profile>
				</xsl:if>
				
				<xsl:if test="name(.) = 'ProST:StakeholderNeed'">
				<profile>
					<id><xsl:value-of select="@xmi:id"/></id>
					<name>Stakeholder Need</name>
				</profile>
				</xsl:if>
				</xsl:for-each>
			</profiles>
			<subelements>
				<xsl:apply-templates select="nestedClassifier|packagedElement|ownedComment"/>
			</subelements>
		</element>
    </xsl:template>
</xsl:stylesheet>