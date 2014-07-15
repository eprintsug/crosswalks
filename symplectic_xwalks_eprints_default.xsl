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
        <crosswalks:mapping eprints="id_number"    elements="doi,patent-number" />
        <crosswalks:mapping eprints="editors"      elements="editors" />
        <crosswalks:mapping eprints="series"      elements="series" /> 
        <crosswalks:mapping eprints="isbn"         elements="isbn-10,isbn-13" />
        <crosswalks:mapping eprints="ispublished"  elements="publication-status" />
        <crosswalks:mapping eprints="issn"         elements="issn,eissn" />
        <crosswalks:mapping eprints="number"       elements="issue" />
        <crosswalks:mapping eprints="official_url" elements="publisher-url" />
        <crosswalks:mapping eprints="pagerange"    elements="pagination" />
        <crosswalks:mapping eprints="publication"  elements="journal" />
        <crosswalks:mapping eprints="publisher"    elements="publisher" />

        <crosswalks:mapping eprints="related_url" elements="author-url,arxiv-pdf-url"/>
    <!--    <crosswalks:mapping eprints="related_url" if-elements="author-url">
            <crosswalks:mapping eprints="url"  elements="author-url" />
            <crosswalks:mapping eprints="type" text="author" />
        </crosswalks:mapping> -->
        <crosswalks:mapping eprints="event_title"   elements="name-of-conference" />
        <crosswalks:mapping eprints="keywords" elements="keywords" />
        <crosswalks:mapping eprints="title"    elements="title" />
        <crosswalks:mapping eprints="volume"   elements="volume" />

        <crosswalks:mapping eprints="place_of_pub"    elements="place-of-publication" />
	<crosswalks:mapping eprints="output_media"    elements="medium" />
        <crosswalks:mapping eprints="note"   elements="notes" />
        <crosswalks:mapping eprints="book_title"   elements="parent-title" />
        <crosswalks:mapping eprints="event_location"   elements="location" />
<!--        <crosswalks:mapping eprints="event_dates"   elements="start-date,finish-date" /> -->
<!--        <crosswalks:mapping eprints="event_dates"   elements="finish-date" /> -->
        <crosswalks:mapping eprints="contributors"   elements="associated-authors" />
        <crosswalks:mapping eprints="funders"   elements="funding-acknowledgements" />
        <crosswalks:mapping eprints="references"   elements="references" />
        <crosswalks:mapping eprints="thesis_type"  elements="thesis-type" />

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
        <crosswalks:dictionary elements="thesis-type">
            <crosswalks:entry elements="Master's Thesis"      eprints="masters" />
            <crosswalks:entry elements="PhD Thesis"      eprints="phd" />
            <crosswalks:entry elements="Undergraduate Dissertation"    eprints="other" />
        </crosswalks:dictionary>
        <crosswalks:dictionary eprints="type">
            <crosswalks:entry elements="journal article"      eprints="article" />
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

<!-- Better way to do this? categories => types-->
  <crosswalks:type-map>
	<!--<entry elements="journal article">article</entry>-->
	<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/journal-article">article</entry>
	<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/chapter">book_section</entry>
	<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/conference-proceeding">conference_item</entry>
	<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/book">book</entry>
	<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/patent">patent</entry>
	<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/artefact">artefact</entry>
	<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/exhibition">exhibition</entry>
	<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/composition">composition</entry>
	<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/performance">performance</entry>
	<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/other">other</entry>
	<!-- Not in EPrints default set so added by RM -->
	<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/design">design</entry>
	<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/internet-publication">internet_publication</entry>
	<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/report">report</entry>
	<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/scholarly-edition">scholarly_edition</entry>
	<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/software">software</entry>

  </crosswalks:type-map>

  <xsl:template match="atom:feed/atom:category[2]" mode="feed">
     <xsl:variable name="element_type" select="@term"/> 
     <type><xsl:value-of select="document('')/*/crosswalks:type-map/entry[@elements=$element_type]"/></type>
  </xsl:template>
  <!-- RMs horror show for concatenating dates -->
  <xsl:template match="pubs:field" mode="feed">
	<xsl:if test="current()[@name='start-date']">
	<event_dates>	
	  <xsl:if test="pubs:date/pubs:year">
            <xsl:value-of select="normalize-space(pubs:date/pubs:year)"/>
            <xsl:if test="pubs:date/pubs:month or pubs:date/pubs:day">
                <xsl:text>-</xsl:text>
            </xsl:if>
          </xsl:if>
          <xsl:if test="pubs:date/pubs:month">
            <xsl:if test="string-length(normalize-space(pubs:date/pubs:month)) = 1"><xsl:text>0</xsl:text></xsl:if>
            <xsl:value-of select="normalize-space(pubs:date/pubs:month)"/>
            <xsl:if test="pubs:date/pubs:day">
                <xsl:text>-</xsl:text>
            </xsl:if>
          </xsl:if>
          <xsl:if test="pubs:date/pubs:day">
            <xsl:if test="string-length(normalize-space(pubs:date/pubs:day)) = 1"><xsl:text>0</xsl:text></xsl:if>
            <xsl:value-of select="normalize-space(pubs:date/pubs:day)"/>
          </xsl:if>
	  <xsl:if test="following-sibling::pubs:field[@name='end-date']">
	    <xsl:text>-</xsl:text>
	    <xsl:variable name="end" select="following-sibling::pubs:field[@name='end-date']/pubs:date"/>
	  <xsl:if test="$end/pubs:year">
            <xsl:value-of select="normalize-space($end/pubs:year)"/>
            <xsl:if test="$end/pubs:month or $end/pubs:day">
                <xsl:text>-</xsl:text>
            </xsl:if>
          </xsl:if>
          <xsl:if test="$end/pubs:month">
            <xsl:if test="string-length(normalize-space($end/pubs:month)) = 1"><xsl:text>0</xsl:text></xsl:if>
            <xsl:value-of select="normalize-space($end/pubs:month)"/>
            <xsl:if test="$end/pubs:day">
                <xsl:text>-</xsl:text>
            </xsl:if>
          </xsl:if>
          <xsl:if test="$end/pubs:day">
            <xsl:if test="string-length(normalize-space($end/pubs:day)) = 1"><xsl:text>0</xsl:text></xsl:if>
            <xsl:value-of select="normalize-space($end/pubs:day)"/>
          </xsl:if>
	 </xsl:if>
	</event_dates>
	</xsl:if>	
  </xsl:template>

</xsl:stylesheet>
