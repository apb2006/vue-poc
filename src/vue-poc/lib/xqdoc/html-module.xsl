<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:doc="http://www.xqdoc.org/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/02/xpath-functions"
	xmlns:qd="http://www.quodatum.com/ns/xsl" exclude-result-prefixes="xs doc fn"
	version="2.0">
	<!-- Standalone xqdoc:xqdoc transform 
	mode"restxq"
	-->
	<xsl:param name="project" as="xs:string" />
	<xsl:param name="source" as="xs:string" />
	<xsl:param name="filename" as="xs:string" />
	<xsl:param name="show-private" as="xs:boolean" select="false()" />
	<xsl:param name="resources" as="xs:string" select="'../resources/'" />

	<xsl:variable name="index" select="'../index.html'" />
	<xsl:variable name="vars"
		select="//doc:variable[$show-private or not(doc:annotations/doc:annotation/@name='private')]" />
	<xsl:variable name="funs"
		select="//doc:function[$show-private or not(doc:annotations/doc:annotation/@name='private')]" />
	<xsl:variable name="docuri"
		select="//doc:xqdoc/doc:module/doc:uri/string()" />
	<!-- uses RESTXQ namespace -->
	<xsl:variable name="restxq"
		select="//doc:namespace[@uri='http://exquery.org/ns/restxq']/@prefix/string()" />
	<!-- generate module html // -->
	<xsl:template match="//doc:xqdoc">
		<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
				<meta http-equiv="Generator"
					content="xqdoc-r - https://github.com/quodatum/xqdoc-r" />

				<title>
					<xsl:value-of select="$docuri" />
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
					<xsl:apply-templates select="doc:module" />

					<xsl:call-template name="toc" />
					<xsl:apply-templates select="doc:variables" />
					<xsl:apply-templates select="doc:functions" />

					<xsl:apply-templates select="doc:namespaces" />
					<xsl:apply-templates select="doc:functions"
						mode="restxq" />
					<div>
						<h3 id="source">Original Source Code</h3>
						<pre class="prettyprint lang-xq">
							<xsl:value-of select="$source" />
						</pre>
					</div>
					<br />

					<div class="footer">
						<p style="text-align:right">
							<i>
								<xsl:value-of select="$filename" />
								<a href="xqdoc.xml" target="xqdoc">
									xqdoc
								</a>
								<a href="xparse.xml" target="xparse">
									xparse
								</a>
							</i>
							|
							generated at
							<xsl:value-of select="current-dateTime()" />
						</p>
					</div>
				</div>

				<script type="application/javascript">
					window.onload = function(){ prettyPrint(); }
				</script>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="doc:module">
		<h1>
			<xsl:value-of select="@type" />
			module&#160;
			<span class="namespace">
				<xsl:value-of select="doc:uri" />
			</span>
		</h1>
		<dl>
			<xsl:apply-templates select="doc:comment/doc:description" />
			<dt>Tags</dt>
			<dd>
				<xsl:if test="$restxq">
					<span class="tag tag-success">RESTXQ</span>
				</xsl:if>
				<xsl:apply-templates
					select="doc:comment/* except doc:comment/doc:description" />
			</dd>
		</dl>
	</xsl:template>

	<xsl:template match="doc:namespaces[doc:namespace]">
		<div id="namespaces">
			<h3>
				<a href="#namespaces">Namespaces</a>
			</h3>
			<p>The following namespaces are defined:</p>
			<table class="data" style="float:none">
				<thead>
					<tr>
						<th>Prefix</th>
						<th>Uri</th>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="doc:namespace">
						<xsl:sort select="lower-case(@prefix)" />
						<tr>
							<td>
								<xsl:value-of select="string(@prefix)" />
							</td>
							<td>
								<xsl:value-of select="string(@uri)" />
							</td>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
		</div>
	</xsl:template>

	<xsl:template match="doc:variables[doc:variable]">
		<div id="variables">
			<h3>
				<a href="#variables">Variables</a>
			</h3>
			<xsl:for-each select="$vars">
				<xsl:sort select="lower-case(doc:name)" />
				<xsl:apply-templates select="." />
			</xsl:for-each>
		</div>
	</xsl:template>


	<xsl:template match="doc:variable">
		<xsl:variable name="id" select="concat('$',doc:name)" />
		<div id="{ $id }">
			<h4>
				<a href="#{$id}">
					<xsl:value-of select="$id" />
				</a>
			</h4>
			<dl>
				<xsl:apply-templates select="doc:comment/doc:description" />
				<dt class="label">Type</dt>
				<dd>
					<xsl:value-of select="doc:type" />
					<xsl:value-of select="doc:type/@occurrence" />
				</dd>
			</dl>

		</div>
	</xsl:template>

	<xsl:template match="doc:uri">
		<xsl:value-of select="." />
	</xsl:template>

	<xsl:template match="doc:functions[doc:function]">
		<div id="functions">
			<h3>
				<a href="#functions">Functions</a>
			</h3>
			<xsl:for-each-group select="$funs" group-by="doc:name">
				<xsl:sort select="lower-case(doc:name)" />

				<xsl:call-template name="function">
					<xsl:with-param name="fun" select="current-group()" />
				</xsl:call-template>

			</xsl:for-each-group>
			<!-- <xsl:apply-templates select="doc:function" /> -->

		</div>
	</xsl:template>

	<!-- o/p details for function $fun has all defined arities -->
	<xsl:template name="function">
		<xsl:param name="fun" as="element(doc:function)*" />
		<xsl:variable name="id" select="$fun[1]/doc:name" />
		<xsl:variable name="funs">
			<xsl:for-each select="fun">
				<xsl:sort select="@arity" data-type="number" />
				<xsl:copy-of select="." />
			</xsl:for-each>
		</xsl:variable>

		<div id="{$id}">
			<h4>
				<a href="#{$id}">
					<xsl:value-of select="$id" />
				</a>
			</h4>

			<xsl:apply-templates select="$fun/doc:comment/doc:description[1]" />
			<dt class="label">Signature</dt>
			<dd>
				<xsl:apply-templates select="$fun" mode="signature" />
			</dd>
			<xsl:apply-templates select="$fun[1]/doc:parameters" />
			<xsl:apply-templates select="$fun[1]/doc:return" />
			<xsl:apply-templates select="$fun[1]/doc:comment/doc:error" />

		</div>
	</xsl:template>

	<xsl:template match="doc:function" mode="signature">
		<div class="proto">
			<code class="function">
				<xsl:value-of select="doc:name" />
			</code>
			<xsl:text>( </xsl:text>
			<xsl:for-each select="doc:parameters/doc:parameter">
				<code class="arg">
					<xsl:value-of select="doc:name" />
				</code>
				<code class="as">&#160;as&#160;</code>
				<code class="type">
					<xsl:value-of select="doc:type" />
					<xsl:value-of select="doc:type/@occurrence/string()" />
				</code>
				<xsl:if test="position() != last()">
					<xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:for-each>
			<xsl:text> )</xsl:text>
			<code class="as">&#160;as&#160;</code>
			<code class="return-type">
				<xsl:value-of select="doc:return/doc:type" />
				<xsl:value-of select="doc:return/doc:type/@occurrence/string()" />
			</code>
		</div>
		<xsl:apply-templates select="doc:annotations" />
	</xsl:template>

	<xsl:template match="doc:functions[doc:function]" mode="restxq">
		<div id="restxq">
			<h3>
				<a href="#restxq">RestXQ</a>
			</h3>
			<xsl:for-each-group select="qd:restxq($funs)"
				group-by="doc:literal/string()">
				<xsl:sort select="current-grouping-key()" />
				<xsl:variable name="id" select="current-grouping-key()" />
				<div id="{$id}">
					<h4>
						<a href="#{ $id }">
							<xsl:value-of select="$id" />
						</a>
					</h4>
					<ul>
					<xsl:for-each select="current-group()/../..">
					 <li>
					 <a href="#{ doc:name }"><xsl:value-of select="doc:name"/></a>
					 </li>
					</xsl:for-each>
					</ul>
					
				</div>
			</xsl:for-each-group>
			<!-- <xsl:apply-templates select="doc:function" /> -->
		</div>
	</xsl:template>

	<xsl:template match="doc:parameters">
		<dt class="label">Parameters</dt>
		<dd>
			<ul>
				<xsl:apply-templates select="doc:parameter" />
			</ul>
		</dd>
	</xsl:template>

	<xsl:template match="doc:parameter">
		<li>
			<xsl:value-of select="doc:name" />
			as
			<xsl:value-of select="doc:type" />
			<xsl:value-of select="doc:type/@occurrence" />
			<xsl:variable name="name" select="string(doc:name)" />
			<xsl:for-each
				select="../../doc:comment/doc:param[starts-with(normalize-space(.), $name) or starts-with(normalize-space(.), concat('$',$name))]">
				<xsl:value-of select="substring-after(normalize-space(.), $name)" />
			</xsl:for-each>
		</li>
	</xsl:template>

	<xsl:template match="doc:return">
		<dt class="label">Return</dt>
		<dd>
			<ul>
				<li>
					<xsl:value-of select="doc:type" />
					<xsl:value-of select="doc:type/@occurrence" />
					<xsl:for-each select="../doc:comment/doc:return">
						<xsl:text>: </xsl:text>
						<xsl:copy-of select="node()|text()" />
					</xsl:for-each>
				</li>
			</ul>
		</dd>
	</xsl:template>



	<xsl:template match="doc:error">
		<dt class="label">Error</dt>
		<dd>
			<xsl:copy-of select="node()|text()" />
		</dd>
	</xsl:template>

	<xsl:template match="doc:annotations">
	<table class="data">
	 <caption style="text-align: left;">Annotations</caption>
	 <tbody>
			<xsl:for-each select="doc:annotation">
				<tr>
				<td>
					<code class="function">
						<xsl:text>%</xsl:text>
						<xsl:value-of select="@name" />
					</code>
					</td>
					<td>
					<code class="arg">
						<xsl:value-of select="doc:literal" />
					</code>
					</td>
				</tr>
			</xsl:for-each>
		</tbody>
		</table>
	</xsl:template>

	<xsl:template match="doc:comment">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="doc:description">
		<dt class="label">Summary</dt>
		<dd>
			<xsl:copy-of select="node()|text()" />
		</dd>
	</xsl:template>

	<xsl:template match="doc:author">
		<p>
			Author:
			<xsl:value-of select="." />
		</p>
	</xsl:template>

	<xsl:template match="doc:version">
		<p>
			Version:
			<xsl:value-of select="." />
		</p>
	</xsl:template>

	<xsl:template match="doc:custom">
		<p>
			<xsl:value-of select="@tag" />
			:
			<xsl:value-of select="." />
		</p>
	</xsl:template>
	<xsl:template match="doc:see">
		See also:
		<xsl:for-each select="tokenize(.,'[ \t\r\n,]+')[. ne '']">
			<xsl:if test="position() ne 1">
				<xsl:text>, </xsl:text>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="contains(.,'#')">
					<a
						href="#{ concat('func_', replace(substring-before(.,'#'), ':', '_'),
            '_', substring-after(.,'#')) }">
						<xsl:value-of select="." />
					</a>
				</xsl:when>
				<xsl:when test="starts-with(.,'$')">
					<a href="#{ concat('var_', replace(substring-after(.,'$'), ':', '_')) }">
						<xsl:value-of select="." />
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="." />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="doc:control" />

	<xsl:template match="text()" mode="custom #default">
		<xsl:value-of select="normalize-space(.)" />
	</xsl:template>

	<xsl:template name="toc">
		<nav id="toc">
			<div>
				<a href="{$index}">
					&#8624;
					<xsl:value-of select="$project" />
				</a>
			</div>
			<h2>
				<a id="contents"></a>
				<span class="namespace">
					<xsl:value-of select="$docuri" />
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
					<ol class="toc">
						<li>
							<a href="#variables">
								<span class="secno">2 </span>
								<span class="content">Variables</span>
							</a>
							<ol class="toc">
								<xsl:for-each select="$vars">
									<xsl:sort select="doc:name" />
									<xsl:variable name="id" select="concat('$',doc:name)" />
									<li>
										<a href="#{$id}">
											<span class="secno">
												<xsl:value-of select="concat('2.',position())" />
											</span>
											<span class="content">
												<xsl:value-of select="$id" />
											</span>
										</a>
									</li>
								</xsl:for-each>
							</ol>
						</li>
					</ol>
				</li>
				<li>
					<ol class="toc">
						<li>
							<a href="#functions">
								<span class="secno">3 </span>
								<span class="content">Functions</span>
							</a>
							<ol class="toc">
								<xsl:for-each-group select="$funs" group-by="doc:name">
									<xsl:sort select="lower-case(doc:name)" />
									<xsl:variable name="id" select="current-grouping-key()" />
									<li>
										<a href="#{$id}">
											<span class="secno">
												<xsl:value-of select="concat('3.',position())" />
											</span>
											<span class="content"
												title="{string((current-group()//doc:description)[1])}">
												<xsl:value-of select="$id" />
												<xsl:if test="qd:restxq(current-group())">
													<div class="tag tag-success" style="float:right"
														title="RESTXQ: { qd:restxq(current-group())/doc:literal/string() }">R
													</div>
												</xsl:if>
												<xsl:if test="qd:is-updating(current-group())">
													<div class="tag tag-danger" title="Updating" style="float:right">U</div>
												</xsl:if>
											</span>
										</a>
									</li>
								</xsl:for-each-group>
							</ol>
						</li>
					</ol>

				</li>
				<li>
					<a href="#namespaces">
						<span class="secno">4 </span>
						<span class="content">Namespaces</span>
					</a>
				</li>
				<li>
					<ol class="toc">
						<li>
							<a href="#restxq">
								<span class="secno">5 </span>
								<span class="content">Restxq</span>
							</a>
							<ol class="toc">
								<xsl:for-each-group select="qd:restxq($funs)"
									group-by="doc:literal/string()">
									<xsl:sort select="current-grouping-key()" />
									<xsl:variable name="id" select="current-grouping-key()" />
									<li>
										<a href="#{ current-grouping-key() }">
											<span class="secno">
												<xsl:value-of select="concat('5.',position())" />
											</span>
											<span class="content">
												<xsl:value-of select="current-grouping-key()" />
											</span>
										</a>
									</li>
								</xsl:for-each-group>
							</ol>
						</li>
					</ol>

				</li>
			</ol>
		</nav>
	</xsl:template>

	<!-- annotation analysis -->
	<xsl:function name="qd:restxq" as="element(doc:annotation)*">
		<xsl:param name="fun" as="element(doc:function)*" />
		<xsl:variable name="found"
			select="$fun/doc:annotations/doc:annotation[@name=concat($restxq,':path')]" />
		<xsl:message>
			<xsl:copy-of select="$found" />
		</xsl:message>
		<xsl:sequence select="$found"></xsl:sequence>
	</xsl:function>

	<xsl:function name="qd:is-updating" as="xs:boolean">
		<xsl:param name="fun" as="element(doc:function)*" />
		<xsl:variable name="found"
			select="$fun/doc:annotations/doc:annotation[@name='updating']" />
		<xsl:sequence select="not(empty($found))" />
	</xsl:function>
</xsl:stylesheet>