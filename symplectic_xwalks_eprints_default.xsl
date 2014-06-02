<?xml version="1.0" encoding="utf-8"?>
<!--
  ~ Copyright (c) 2012. Symplectic Ltd. All Rights Reserved
  -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:crosswalks="info:symplectic/crosswalks" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:pubs="http://www.symplectic.co.uk/publications/atom-api" version="1.0">
    <!-- Required for all crosswalks - import the standard toolkit -->
    <xsl:import href="symplectic_xwalks_toolkit.xsl" />

    <!-- Required for all crosswalks - load the data islands from the crosswalk stylesheet -->
    <xsl:variable name="crosswalk-mappings" select="document('')//crosswalks:mappings" />
    <!-- xsl:variable name="crosswalk-object-mappings" select="document('')//crosswalks:object-mappings" / -->
    <!-- xsl:variable name="crosswalk-label-mappings" select="document('')//crosswalks:label-mappings" / -->
    <xsl:variable name="crosswalk-dictionaries" select="document('')//crosswalks:dictionaries" />
    <xsl:variable name="crosswalk-datasource-precedences" select="document('')//crosswalks:datasource-precedences" />

    <!--
        Data Source Mappings
        ====================
        Map values from the data source into repository fields
    -->
    <crosswalks:mappings for="eprints">
        <!-- Default mappings -->
        <crosswalks:mapping eprints="abstract"     elements="abstract" />
        <crosswalks:mapping eprints="creators"     elements="authors" />
        <crosswalks:mapping eprints="id_number"    elements="doi" />
        <crosswalks:mapping eprints="editors"      elements="editors" />
        <crosswalks:mapping eprints="isbn"         elements="isbn-10,isbn-13" />
        <crosswalks:mapping eprints="ispublished"  elements="publication-status" />
        <crosswalks:mapping eprints="issn"         elements="issn" />
        <crosswalks:mapping eprints="number"       elements="issue" />
        <crosswalks:mapping eprints="official_url" elements="publisher-url" />
        <crosswalks:mapping eprints="pagerange"    elements="pagination" />
        <crosswalks:mapping eprints="publication"  elements="journal" />
        <crosswalks:mapping eprints="publisher"    elements="publisher" />
        <crosswalks:mapping eprints="related_url" if-elements="author-url">
            <crosswalks:mapping eprints="url"  elements="author-url" />
            <crosswalks:mapping eprints="type" text="author" />
        </crosswalks:mapping>
        <crosswalks:mapping eprints="source"   elements="name-of-conference" />
        <crosswalks:mapping eprints="subjects" elements="keywords" />
        <crosswalks:mapping eprints="title"    elements="title" />
        <crosswalks:mapping eprints="volume"   elements="volume" />

        <crosswalks:mapping first-mapped-only="y">
            <crosswalks:mapping if-elements="filed-date">
                <crosswalks:mapping eprints="date"            elements="filed-date" />
                <crosswalks:mapping eprints="date_type"       text="filed" />
            </crosswalks:mapping>
            <crosswalks:mapping if-elements="publication-date">
                <crosswalks:mapping eprints="date"            elements="publication-date" />
                <crosswalks:mapping eprints="date_type"       text="published" />
            </crosswalks:mapping>
        </crosswalks:mapping>
    </crosswalks:mappings>

    <!--
        Object level field mappings
        ===========================
        Map values from the publication fields into repository fields
    -->
    <!--

        <crosswalks:object-mappings for="eprints">
            <crosswalks:mapping eprints="keywords" list-elements="labels" />
        </crosswalks:object-mappings>
    -->

    <!--
        Label mappings
        ==============
    -->
    <!--
        <crosswalks:label-mappings for="eprints">
            <crosswalks:label-mapping eprints="subjects" list-separator=", ">
                <crosswalks:label-mapping origin="issn-inferred" />
                <crosswalks:label-mapping exclude-scheme="for" />
            </crosswalks:label-mapping>
            <crosswalks:label-mapping eprints="subjects" list-separator="; ">
                <crosswalks:label-mapping exclude-scheme="for" />
            </crosswalks:label-mapping>
            <crosswalks:label-mapping eprints="subjects" />
        </crosswalks:label-mappings>
    -->

    <!--
        Data Dictionaries
        =================
        Convert values supplied by Elements to values used in EPrints
    -->
    <crosswalks:dictionaries>
        <crosswalks:dictionary elements="publication-status">
            <crosswalks:entry elements="Published"      eprints="pub" />
            <crosswalks:entry elements="Submitted"      eprints="submitted" />
            <crosswalks:entry elements="Accepted"       eprints="inpress" />
            <crosswalks:entry elements="Unpublished"    eprints="unpub" />
        </crosswalks:dictionary>
    </crosswalks:dictionaries>

    <!--
        Data Source Precedences
        =======================
        Used when passing the full atom feed from Repository Tools.
        Please check your Elements instance to see what data sources are being used.
        Only data sources listed here will be considered for mapping.
    -->
    <crosswalks:datasource-precedences>
        <crosswalks:datasource-precedence>web-of-science</crosswalks:datasource-precedence>
        <crosswalks:datasource-precedence>wos-lite</crosswalks:datasource-precedence>
        <crosswalks:datasource-precedence>pubmed</crosswalks:datasource-precedence>
        <crosswalks:datasource-precedence>isi-precedings</crosswalks:datasource-precedence>
        <crosswalks:datasource-precedence>manual-entry</crosswalks:datasource-precedence>
        <crosswalks:datasource-precedence>arxiv</crosswalks:datasource-precedence>
        <crosswalks:datasource-precedence>dblp</crosswalks:datasource-precedence>
        <crosswalks:datasource-precedence>scopus</crosswalks:datasource-precedence>
    </crosswalks:datasource-precedences>
</xsl:stylesheet>
