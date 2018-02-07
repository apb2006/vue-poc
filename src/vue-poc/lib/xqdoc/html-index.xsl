<?xml version="1.0" encoding="UTF-8"?>
<!-- Generates html index page. Project: xqdoc Author: Andy Bunce Date: 20170101 
	Version: 0.1 Comments: I/p is files e.g <c:directory name="adminlog" xml:base="file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/adminlog/"> 
	<c:file name="logs.xqm"/> -->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:doc="http://www.xqdoc.org/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/02/xpath-functions"
	xmlns:qd="http://www.quodatum.com/ns/xsl" exclude-result-prefixes="xs doc fn"
	xmlns:c="http://www.w3.org/ns/xproc-step" version="2.0">
	<!-- build project index" -->
	<xsl:param name="project" as="xs:string" />

	<xsl:param name="resources" as="xs:string" select="'resources/'" />

	<xsl:variable name="css" select="concat($resources,'base.css')" />

	<xsl:template match="/">
		<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
				<meta http-equiv="Generator"
					content="xqdoc-r - https://github.com/quodatum/xqdoc-r" />

				<title>
					<xsl:value-of select="'Index'" />
					- xqDoc
				</title>
				<link rel="shortcut icon" type="image/x-icon" href="{$resources}xqdoc.png" />
				<link rel="stylesheet" type="text/css" href="{$resources}page.css" />
				<link rel="stylesheet" type="text/css" href="{$resources}query.css" />
				<link rel="stylesheet" type="text/css" href="{$resources}base.css" />

				<link rel="stylesheet" type="text/css" href="{$resources}prettify.css" />

				<script src="{$resources}prettify.js" type="text/javascript">&#160;</script>
				<script src="{$resources}lang-xq.js" type="text/javascript">&#160;</script>
			</head>

			<body class="home" id="top">
				<div id="main">
					<h1>
						XQDoc for
						<xsl:value-of select="$project" />
					</h1>
					<xsl:call-template name="toc" />

					<div id="file">
						<h1>Files</h1>
						<ul>
							<xsl:apply-templates select=".//c:file" />
						</ul>
					</div>

					<div id="ns">
						<h1>Namespace</h1>
						<ul>
							<xsl:apply-templates select=".//c:file" />
						</ul>
					</div>

					<div class="footer">
						<p style="text-align:right">
							|
							generated at
							<xsl:value-of select="current-dateTime()" />
						</p>
					</div>
				</div>

			</body>
		</html>
	</xsl:template>

	<xsl:template match="c:file">
		<li>
			<a href="F{position()}/index.html">
				<xsl:value-of select="qd:path(@name)" />

			</a>
			<xsl:value-of select="position()" />
		</li>
	</xsl:template>

	<xsl:template name="toc">
		<nav id="toc">
			<h2>
				<a id="contents"></a>
				<span class="namespace">
					<xsl:value-of select="$project" />
				</span>
			</h2>
			<ol class="toc">
				<li>
					<a href="#main">
						<span class="secno">1 </span>
						<span class="content">Introduction</span>
					</a>
				</li>
				<li>
					<a href="#ns">
						<span class="secno">2 </span>
						<span class="content">Namespaces</span>
					</a>
				</li>
				<li>
					<a href="#file">
						<span class="secno">3 </span>
						<span class="content">Files</span>
					</a>
				</li>
			</ol>
		</nav>
	</xsl:template>

	<!-- path -->
	<xsl:function name="qd:path" as="xs:string">
		<xsl:param name="file" />
		<xsl:sequence select="concat('*',$file)" />
	</xsl:function>
</xsl:stylesheet>
