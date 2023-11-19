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
			<xsl:if test="@xmi:type = 'uml:Package'">
                <stereotype>
                    <id><xsl:value-of select="@xmi:id"/></id>
                    <type>Package</type>
                    <profile>uml</profile>
					<name><xsl:value-of select="@name"/></name>
                </stereotype>
			</xsl:if>
			<xsl:if test="@xmi:type = 'uml:Activity'">
                <stereotype>
                    <id><xsl:value-of select="@xmi:id"/></id>
                    <type>Activity</type>
                    <profile>uml</profile>
					<name><xsl:value-of select="@name"/></name>
                </stereotype>
			</xsl:if>
			<xsl:if test="@xmi:type = 'uml:Class'">
                <stereotype>
                    <id><xsl:value-of select="@xmi:id"/></id>
                    <type>Class</type>
                    <profile>uml</profile>
					<name><xsl:value-of select="@name"/></name>
                </stereotype>
			</xsl:if>
			<xsl:if test="@xmi:type = 'uml:Comment'">
                <stereotype>
                    <id><xsl:value-of select="@xmi:id"/></id>
                    <type>Comment</type>
                    <profile>uml</profile>
					<text><xsl:value-of select="."/></text>
                </stereotype>
			</xsl:if>
			<xsl:for-each select="//*[@base_NamedElement=$id]|//*[@base_Classifier=$id]">
				<xsl:if test="name(.) = 'Requirements:Requirement'">
                <stereotype>
                    <id><xsl:value-of select="@xmi:id"/></id>
                    <type>Requirement</type>
                    <profile>Requirements</profile>
                    <text><xsl:value-of select="@text"/></text>
                </stereotype>
                </xsl:if>
                
                <xsl:if test="name(.) = 'ModelElements:Stakeholder'">
                <stereotype>
                    <id><xsl:value-of select="@xmi:id"/></id>
                    <type>Stakeholder</type>
                    <profile>ModelElements</profile>
                </stereotype>
                </xsl:if>
                
                <xsl:if test="name(.) = 'ProST:ManagedElement'">
                <stereotype>
                    <id><xsl:value-of select="@xmi:id"/></id>
                    <type>Managed Element</type>
                    <profile>ProST</profile>
					<xsl:for-each select="@*">
						<xsl:variable name="tagname" select="name(.)" />
						<xsl:element name="{$tagname}">
							<xsl:value-of select="."/>
						</xsl:element>
					</xsl:for-each>
                </stereotype>
                </xsl:if>
				
                <xsl:if test="name(.) = 'ProST:StakeholderInput'">
                <stereotype>
                    <id><xsl:value-of select="@xmi:id"/></id>
                    <type>Stakeholder Input</type>
                    <profile>ProST</profile>
                </stereotype>
                </xsl:if>
                
                <xsl:if test="name(.) = 'ProST:StakeholderNeed'">
                <stereotype>
                    <id><xsl:value-of select="@xmi:id"/></id>
                    <type>Stakeholder Need</type>
                    <profile>ProST</profile>
                </stereotype>
                </xsl:if>
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