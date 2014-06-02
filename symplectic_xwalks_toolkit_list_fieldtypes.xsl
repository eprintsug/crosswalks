<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:pubs="http://www.symplectic.co.uk/publications/atom-api"
                exclude-result-prefixes="pubs"
                version="1.0">

    <xsl:template match="pubs:boolean" mode="list">
        <xsl:param name="name" />
        <xsl:param name="repo_field" />

        <xsl:apply-templates select=".">
            <xsl:with-param name="name" select="$name" />
            <xsl:with-param name="repo_field" select="$repo_field" />
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="pubs:date" mode="list">
        <xsl:param name="name" />
        <xsl:param name="repo_field" />
        <xsl:param name="date-format" />

        <xsl:apply-templates select=".">
            <xsl:with-param name="name" select="$name" />
            <xsl:with-param name="repo_field" select="$repo_field" />
            <xsl:with-param name="date-format" select="$date-format" />
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="pubs:item" mode="list">
        <xsl:param name="name" />
        <xsl:param name="repo_field" />

        <xsl:apply-templates select=".">
            <xsl:with-param name="name" select="$name" />
            <xsl:with-param name="repo_field" select="$repo_field" />
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="pubs:keyword" mode="list">
        <xsl:param name="name" />
        <xsl:param name="repo_field" />

        <xsl:apply-templates select=".">
            <xsl:with-param name="name" select="$name" />
            <xsl:with-param name="repo_field" select="$repo_field" />
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="pubs:pagination" mode="list">
        <xsl:param name="name" />
        <xsl:param name="repo_field" />

        <xsl:apply-templates select=".">
            <xsl:with-param name="name" select="$name" />
            <xsl:with-param name="repo_field" select="$repo_field" />
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="pubs:person" mode="list">
        <xsl:param name="name" />
        <xsl:param name="repo_field" />

        <xsl:apply-templates select=".">
            <xsl:with-param name="name" select="$name" />
            <xsl:with-param name="repo_field" select="$repo_field" />
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="pubs:text" mode="list">
        <xsl:param name="name" />
        <xsl:param name="repo_field" />

        <xsl:apply-templates select=".">
            <xsl:with-param name="name" select="$name" />
            <xsl:with-param name="repo_field" select="$repo_field" />
        </xsl:apply-templates>
    </xsl:template>
</xsl:stylesheet>
