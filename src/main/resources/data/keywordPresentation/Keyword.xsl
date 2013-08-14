<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
	<xsl:output method="html" />

	<xsl:template match="/TestStepDefinitions">
		<html>
			<head>

				<!-- <script src="jquery-1.5.min.js" /> -->
				<title>
					Keyword -
					<xsl:value-of select="TestStep[1]/@command" />
				</title>
				<link rel="stylesheet" href="KeywordStyle.css" type="text/css" />
			</head>

			<body>
				<div id="keywords">
					<xsl:for-each select="./TestStep">
						<xsl:call-template name="keyword" />
					</xsl:for-each>
				</div>
				<hr/>
				<p />
				<div id="examples">
					<xsl:for-each select="./TestStep">
						<xsl:call-template name="exampleMinimal" />
					</xsl:for-each>
				</div>
				<hr/>
				<p />
				<div id="examples">
					<xsl:for-each select="./TestStep">
						<xsl:call-template name="exampleAll" />
					</xsl:for-each>
				</div>

			</body>
		</html>
	</xsl:template>

	<xsl:template name="keyword">
		<div class="keyword">
			<div class="command">
				<xsl:value-of select="@command" />
			</div>
			<div class="description">
				<xsl:value-of select="Description" />
			</div>
			<p />
			<div id="parameters">
				<table class="parameterTable">
					<xsl:if test="count( Parameterspec ) > 0">
						<xsl:call-template name="parameterHeader" />
					</xsl:if>
					<xsl:for-each select="./Parameterspec">
						<xsl:call-template name="parameter" />
					</xsl:for-each>
				</table>
			</div>
			<p />
			<div id="returnValues">
				Returns:
				<xsl:for-each select="./ReturnValues/ReturnValue">
					<xsl:call-template name="return" />
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="parameterHeader">
		<tr>
			<th class="name">Parameter</th>
			<th class="type">Type</th>
			<th class="mandatory">Mandatory</th>
			<th class="value">Value</th>
			<th class="variable">Variable</th>
			<th class="empty">Empty</th>
			<th class="default">Default</th>
			<th class="comment">Comment</th>
		</tr>
	</xsl:template>

	<xsl:template name="parameter">
		<tr>
			<td>
				<xsl:value-of select="@name" />
			</td>
			<td>
				<xsl:value-of select="@type" />
			</td>
			<td>
				<xsl:if test="Optional='false'">
					<img class="check" src="check.jpg" />
				</xsl:if>
			</td>
			<td>
				<xsl:if test="ValueAllowed='true'">
					<img class="check" src="check.jpg" />
				</xsl:if>
			</td>
			<td>
				<xsl:if test="VariableAllowed='true'">
					<img class="check" src="check.jpg" />
				</xsl:if>
			</td>
			<td>
				<xsl:if test="EmptyAllowed='true'">
					<img class="check" src="check.jpg" />
				</xsl:if>
			</td>
			<td>
				<xsl:value-of select="Default" />
			</td>
			<td>
				<xsl:value-of select="Description" />
			</td>
		</tr>
	</xsl:template>

	<xsl:template name="return">
		<div class="returnValue">
			<xsl:value-of select="." />
		</div>
	</xsl:template>

	<xsl:template name="exampleMinimal">
		<div class="example">
			Example (minimal parameters):
			<p />
			<pre>
				<xsl:call-template name="exampleTeststepStartLine" />
				<xsl:call-template name="exampleCommandLine" />
				<xsl:for-each select="./Parameterspec">
					<xsl:call-template name="mandataryParamExample" />
				</xsl:for-each>
				<xsl:call-template name="exampleTeststepEndLine" />
			</pre>
		</div>
	</xsl:template>

	<xsl:template name="exampleAll">
		<div class="example">
			Example (all parameters):
			<p />
			<pre>
				<xsl:call-template name="exampleTeststepStartLine" />
				<xsl:call-template name="exampleCommandLine" />
				<xsl:call-template name="exampleDescription" />
				<xsl:for-each select="./Parameterspec">
					<xsl:call-template name="paramExample" />
				</xsl:for-each>
				<xsl:call-template name="exampleTeststepEndLine" />
			</pre>
		</div>
	</xsl:template>

	<xsl:template name="exampleTeststepStartLine">
		<span class="nl">&lt;teststep&gt;</span>
	</xsl:template>

	<xsl:template name="exampleCommandLine">
<!-- TODO: How to set the interface? Get as parameter? Read directory name? -->
		<span class="nl i1">&lt;command interface=&quot;interface name&quot;&gt;<xsl:value-of select="@command" />&lt;/command&gt;</span>
	</xsl:template>

	<xsl:template name="exampleDescription">
		<span class="nl i1">&lt;description&gt;Your specific description for this step. It will override the default description.&lt;/description&gt;</span>
	</xsl:template>

	<xsl:template name="mandataryParamExample">
		<xsl:if test="Optional='false'">
			<xsl:call-template name="paramExample" />
		</xsl:if>
	</xsl:template>

	<xsl:template name="paramExample">
		<span class="i1">&lt;parameter id=&quot;<xsl:value-of select="@name" />&quot;</span>
		<xsl:choose>
			<xsl:when test="ValueAllowed='true'">
				<span> type=&quot;<xsl:value-of select="@type"/>&quot;&gt;</span>
				<span class="nl i2">&lt;value&gt;<xsl:choose>
						<xsl:when test="@type='String'">Your string</xsl:when>
						<xsl:when test="@type='Int' or @type='Integer'">1</xsl:when>
						<xsl:when test="@type='Boolean'">true</xsl:when>
						<xsl:otherwise>Your value</xsl:otherwise>
					</xsl:choose>&lt;/value&gt;</span>
			</xsl:when>
			<xsl:when test="VariableAllowed='true'">
				<span>&gt;</span>
				<span class="nl i2">&lt;variable&gt;variable name&lt;/variable&gt;</span>
			</xsl:when>
		</xsl:choose>
		<span class="nl i1">&lt;/parameter&gt;</span>
	</xsl:template>

	<xsl:template name="exampleTeststepEndLine">
		<span class="nl">&lt;/teststep&gt;</span>
	</xsl:template>

</xsl:stylesheet>
