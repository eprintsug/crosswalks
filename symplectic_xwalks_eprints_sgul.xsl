<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:crosswalks="info:symplectic/crosswalks" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:pubs="http://www.symplectic.co.uk/publications/atom-api" version="1.0">

	<xsl:import href="symplectic_xwalks_toolkit.xsl" />
	<xsl:variable name="crosswalk-mappings" select="document('')//crosswalks:mappings" />
	<xsl:variable name="crosswalk-dictionaries" select="document('')//crosswalks:dictionaries" />
	<xsl:variable name="crosswalk-datasource-precedences" select="document('')//crosswalks:datasource-precedences" />

	<!--
		The feed from Elements may contain publication data from multiple sources (eg. pubmed, wos) - the toolkit will select
		one of these sources by looking at the crosswalks:datasource-precedences setting:
	-->
	<crosswalks:datasource-precedences>
		<crosswalks:datasource-precedence>pubmed</crosswalks:datasource-precedence>
		<crosswalks:datasource-precedence>web-of-science</crosswalks:datasource-precedence>
		<crosswalks:datasource-precedence>wos-lite</crosswalks:datasource-precedence>
		<crosswalks:datasource-precedence>isi-precedings</crosswalks:datasource-precedence>
		<crosswalks:datasource-precedence>manual-entry</crosswalks:datasource-precedence>
		<crosswalks:datasource-precedence>arxiv</crosswalks:datasource-precedence>
		<crosswalks:datasource-precedence>dblp</crosswalks:datasource-precedence>
		<crosswalks:datasource-precedence>scopus</crosswalks:datasource-precedence>
	</crosswalks:datasource-precedences>

	<!--
		Once a source has been selected the following mappings will be applied:
	-->
	<crosswalks:mappings for="eprints">
		<crosswalks:mapping eprints="abstract"		elements="abstract" />
		<crosswalks:mapping eprints="creators"		elements="authors" />
		<crosswalks:mapping eprints="id_number"		elements="doi,patent-number" />
		<crosswalks:mapping eprints="editors"		elements="editors" />
		<crosswalks:mapping eprints="series"		elements="series" /> 
		<crosswalks:mapping eprints="isbn"		elements="isbn-10,isbn-13" />
		<crosswalks:mapping eprints="ispublished"	elements="publication-status" />
		<crosswalks:mapping eprints="issn"		elements="issn,eissn" />
		<crosswalks:mapping eprints="number"		elements="issue" />
		<crosswalks:mapping eprints="official_url"	elements="publisher-url" />
		<crosswalks:mapping eprints="pagerange"		elements="pagination" />
		<crosswalks:mapping eprints="pages"		elements="pagination" />
		<crosswalks:mapping eprints="article_number"	elements="pagination" />
		<crosswalks:mapping eprints="publication"	elements="journal" />
		<crosswalks:mapping eprints="publisher"		elements="publisher" />
		<crosswalks:mapping eprints="funders"		elements="funding-acknowledgements" />
		<crosswalks:mapping eprints="projects"		elements="funding-acknowledgements" />
		<crosswalks:mapping eprints="related_url"	elements="author-url,arxiv-pdf-url"/>
		<crosswalks:mapping eprints="event_title"	elements="name-of-conference" />
		<crosswalks:mapping eprints="title"		elements="title" />
		<crosswalks:mapping eprints="volume"		elements="volume" />
		<crosswalks:mapping eprints="place_of_pub"	elements="place-of-publication" />
		<crosswalks:mapping eprints="output_media"	elements="medium" />
		<crosswalks:mapping eprints="note"		elements="notes" />
		<crosswalks:mapping eprints="book_title"	elements="parent-title" />
		<crosswalks:mapping eprints="event_location"	elements="location" />
		<crosswalks:mapping eprints="contributors"	elements="associated-authors" />
		<crosswalks:mapping eprints="references"	elements="references" />
		<crosswalks:mapping eprints="thesis_type"	elements="thesis-type" />
		<crosswalks:mapping eprints="event_dates"	list-elements="start-date,finish-date" list-separator=" - " date-format="dd.mon.yyyy"/>
		<crosswalks:mapping first-mapped-only="y">
			<crosswalks:mapping if-elements="publication-date">
				<crosswalks:mapping eprints="date"            elements="publication-date" />
				<crosswalks:mapping eprints="date_type"       text="published" />
			</crosswalks:mapping>
			<crosswalks:mapping if-elements="filed-date">
				<crosswalks:mapping eprints="date"            elements="filed-date" />
				<crosswalks:mapping eprints="date_type"       text="filed" />
			</crosswalks:mapping>
		</crosswalks:mapping>
	</crosswalks:mappings>

	<!--
		Custom mappings for specific fields can be defined.

		To override the mapping for the pubs:foo field first create a template that matches pubs:foo in "mapping" mode:

		<xsl:template match="pubs:foo" mode="mapping">
			<xsl:param name="name" />
			<xsl:param name="repo_field" />

			<xsl:apply-templates select=".">
				<xsl:with-param name="name" select="$name" />
				<xsl:with-param name="repo_field" select="$repo_field" />
			</xsl:apply-templates>
		</xsl:template>

		Then create a template that matches pubs:foo:

		<xsl:template match="pubs:funding-acknowledgements">
			<xsl:param name="name" />
			<xsl:param name="repo_field" />

			... do something funky ...

		</xsl:template>

	-->

	<!-- <xsl:template match="pubs:pagination" mode="mapping"> already defined in symplectic_xwalks_toolkit_mapping_fieldtypes.xsl -->
	<xsl:template match="pubs:pagination">
		<xsl:param name="name" />
		<xsl:param name="repo_field" />

		<xsl:choose>
			<xsl:when test="$repo_field='pages'">
				<xsl:apply-templates select="." mode="pagecount" />
			</xsl:when>
			<xsl:when test="$repo_field='pagerange'">
				<xsl:apply-templates select="." mode="pagerange" />
			</xsl:when>
			<xsl:when test="$repo_field='article_number'">
				<xsl:apply-templates select="." mode="artnum" />
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="pubs:pagination" mode="pagerange">
		<xsl:choose>
			<xsl:when test="pubs:begin-page and not(pubs:end-page) and starts-with(pubs:begin-page, 'e')"/>
			<xsl:when test="pubs:begin-page or pubs:end-page">
				<xsl:if test="pubs:begin-page">
					<xsl:value-of select="normalize-space(pubs:begin-page)"/>
				</xsl:if>
				<xsl:text>-</xsl:text>
				<xsl:if test="pubs:end-page">
					<xsl:value-of select="normalize-space(pubs:end-page)"/>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="pubs:pagination" mode="artnum">
		<xsl:if test="pubs:begin-page and not(pubs:end-page) and starts-with(pubs:begin-page, 'e')">
			<!-- eg. e1001258 -->
			<xsl:value-of select="normalize-space(pubs:begin-page)"/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="pubs:funding-acknowledgements" mode="mapping">
		<xsl:param name="name" />
		<xsl:param name="repo_field" />

		<xsl:apply-templates select=".">
			<xsl:with-param name="name" select="$name" />
			<xsl:with-param name="repo_field" select="$repo_field" />
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="pubs:funding-acknowledgements">
		<xsl:param name="name" />
		<xsl:param name="repo_field" />

		<xsl:choose>
			<xsl:when test="$repo_field='projects'">
				<xsl:for-each select="pubs:grants/pubs:grant">
					<xsl:element name="item">
						<xsl:value-of select="pubs:grant-id"/>
					</xsl:element>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$repo_field='funders'">
				<xsl:for-each select="pubs:grants/pubs:grant">
					<xsl:element name="item">
						<xsl:value-of select="pubs:organisation"/>
					</xsl:element>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--
		The toolkit uses dictionaries to map Elements values to EPrints sets/namedsets
	-->
	<crosswalks:dictionaries>

		<crosswalks:dictionary elements="publication-status">
			<crosswalks:entry elements="Published"		eprints="pub" />
			<crosswalks:entry elements="Submitted"		eprints="submitted" />
			<crosswalks:entry elements="Accepted"		eprints="inpress" />
			<crosswalks:entry elements="Unpublished"	eprints="unpub" />
		</crosswalks:dictionary>

		<crosswalks:dictionary elements="thesis-type">
			<crosswalks:entry elements="Master's Thesis"		eprints="masters" />
			<crosswalks:entry elements="PhD Thesis"			eprints="phd" />
			<crosswalks:entry elements="Undergraduate Dissertation"	eprints="other" />
		</crosswalks:dictionary>

	</crosswalks:dictionaries>

	<!--
		It is possible to crosswalk data from ANY part of the feed (not just the selected source as in the crosswalks:mappings section)
		by defining "feed" mode templates
	-->

	<xsl:template match="atom:feed/pubs:id" mode="feed">
		<xsl:element name="symplectic_id">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="atom:feed/atom:entry/pubs:data-source" mode="feed">
		<xsl:choose>
			<xsl:when test="pubs:source-name = 'pubmed'">
				<xsl:element name="pmid">
					<xsl:value-of select="pubs:id-at-source"/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="pubs:source-name = 'wos'">
				<xsl:element name="wosid">
					<xsl:value-of select="pubs:id-at-source"/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="pubs:source-name = 'web-of-science'">
				<xsl:element name="wosid">
					<xsl:value-of select="pubs:id-at-source"/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="pubs:source-name = 'wos-lite'">
				<xsl:element name="wosid">
					<xsl:value-of select="pubs:id-at-source"/>
				</xsl:element>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="atom:feed/pubs:organisational-details" mode="feed">
		<xsl:element name="divisions">
			<xsl:for-each select="pubs:group">
				<item><xsl:value-of name="org-id" select="@org-id"/></item>
			</xsl:for-each> 
		</xsl:element>
	</xsl:template>

	<xsl:template match="atom:feed/pubs:all-labels/pubs:keywords" mode="feed">
		<xsl:element name="keywords">
			<xsl:for-each select="pubs:keyword">
				<xsl:element name="item">
					<xsl:value-of select="."/>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>

	<xsl:template match="atom:feed/atom:category[2]" mode="feed">
		<xsl:variable name="element_type" select="@term"/> 
		<xsl:element name="type">
			<xsl:value-of select="document('')//crosswalks:type-map/entry[@elements=$element_type]"/>
		</xsl:element>
	</xsl:template>

	<!--
		Map Elements item type to EPrints item type
	-->
	<crosswalks:type-map>
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
		<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/design">design</entry>
		<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/internet-publication">internet_publication</entry>
		<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/report">report</entry>
		<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/scholarly-edition">scholarly_edition</entry>
		<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/software">software</entry>
		<entry elements="http://www.symplectic.co.uk/publications/atom-terms/1.0/thesis-or-dissertation">thesis</entry>
	</crosswalks:type-map>

</xsl:stylesheet>
