<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html"/>

  <xsl:template match="/testgroup">
    <html>
      <head>
        <script src="jquery-1.5.min.js" />
        <script src="testgroup.js" />

        <title>Test Group Results</title>
        <link rel="stylesheet" href="testgroup_style.css" type="text/css" />
      </head>
      <body onLoad="notifyParrent( 1 );">

        <xsl:call-template name="printTestGroup"/>

		<div id="popup" style="display: none;">
			<table class="popupstyle">
				<tr>
					<td align="right" class="testcase"  colspan="2">
						<a style="cursor:pointer" onclick="hide('popup')">Close [X]</a>
					</td>
				</tr>
				<tr>
					<td id="popup_id" class="testcaseheader">ID </td>
					<td id="popup_verdict" class="testcaseheader">Verdict </td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="popupinnerstyle">
							<iframe id="ifr_popup" name='popup_link' width="100%" frameborder="no" scrolling="auto"></iframe>
						</div>
					</td>
				</tr>
			</table>
		</div>

	  </body>
    </html>    
  </xsl:template>


  <xsl:template name="printTestGroup">
    <div id="testgroup">
		<div id="testgroupheader">
			<img id="testgroupheader_plusmin" src="plus.gif" onclick="showHideTestGroup();">
			</img>
			<div id="testgroupheader_id"> 
				<xsl:value-of select="@id" />
			</div>
			<xsl:call-template name="printTotalsAbove"/>
			<xsl:call-template name="filter"/>
		</div>

		<div id="prepare" style="display:none;">
			<xsl:for-each select="./prepare">
				<xsl:call-template name="printSteps"/>
			</xsl:for-each>
		</div> 

		<div id="subTestGroups" style="display:none;">
			<xsl:for-each select="./testgrouplink">
				<xsl:call-template name="printTestGroupLink"/>
			</xsl:for-each>
		</div> 

		<div id="testcases" style="display:none;">
			<xsl:if test="count(testcaselink)>0">
				<table class="testcasetable">
					<xsl:for-each select="./testcaselink">
						<xsl:call-template name="printTestCase"/>
					</xsl:for-each>
				</table>
			</xsl:if>
		</div>

		<div id="restore" style="display:none;">
			<xsl:for-each select="./restore">
				<xsl:call-template name="printSteps"/>
			</xsl:for-each>
		</div> 

		<div id="testLogs" style="display:none;">
			<xsl:if test="count(logFiles/logFile)>0">
				<table class="testgrouplogfiles">
					<tr>
						<td class="leftside">TestGroup Logs:</td>
						<td>
							<xsl:for-each select="./logFiles/logFile">
								<xsl:call-template name="printLogFileLink"/>
							</xsl:for-each>
						</td>
					</tr>
				</table>
			</xsl:if>
		</div>

		<xsl:call-template name="printTotalsBeneath"/>

	</div>
  </xsl:template>

  <xsl:template name="printLogFileLink">
	<span class="logfilelink">
		<a target="_blank">
			<xsl:attribute name='href'>
				<xsl:value-of select="."/>
			</xsl:attribute>
			<xsl:value-of select="@type" />
		</a>
	</span>
  </xsl:template>

  <xsl:template name="printSteps">
	<table class="steptable">
		<xsl:for-each select="*">
			<tr>
				<td class="step_id"><xsl:value-of select="displayName" /></td>
<!-- 				<xsl:if test="command">
					<td class="stepcommand"><xsl:value-of select="./command" /></td>
				</xsl:if>
				<xsl:if test="script">
					<td class="stepscript"><xsl:value-of select="./script" /></td>
				</xsl:if>
 -->
 				<td>
					<xsl:attribute name='class'>
						<xsl:choose>
							<xsl:when test="./result='PASSED'">
								step_r_pass
							</xsl:when>
							<xsl:otherwise>
								step_r_fail
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:value-of select="./result" />
				</td>
				<td class="step_logfile">
					<xsl:if test="count( logfile ) > 0">
						<xsl:for-each select="logfile">
							<xsl:call-template name="printLogFileLink"/>
						</xsl:for-each>
					</xsl:if>
				</td>
				<td class="step_comment">
				  <xsl:call-template name="breakNewlines">
				    <xsl:with-param name="text" select="./comment"/>
				  </xsl:call-template>
				</td>
			</tr>
		</xsl:for-each>
	</table>
  </xsl:template>

  <!-- here is another template that replaces newlines with <br> -->
  <xsl:template name="breakNewlines">
    <xsl:param name="text" select="."/>
    <xsl:choose>
      <xsl:when test="contains($text, '&#xa;')">
        <xsl:value-of select="substring-before($text, '&#xa;')"/>
        <br/>
        <xsl:call-template name="breakNewlines">
	  <xsl:with-param name="text" select="substring-after($text,'&#xa;')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="printTestGroupLink">
	<iframe frameborder="no" width="100%" scrolling="no" height="48">
		<xsl:attribute name='id'>ifr_<xsl:value-of select="@id"/></xsl:attribute>
		<xsl:attribute name='src'>
			<xsl:value-of select="./link"/>?id=<xsl:value-of select="@id"/>
		</xsl:attribute>
	</iframe>
  </xsl:template>

  <xsl:template name="printTestCase">
	<xsl:variable name="class_type">
		<xsl:choose>
			<xsl:when test="round(position() div 2)=position() div 2">tc_even</xsl:when>
			<xsl:otherwise>tc_uneven</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>    
	<tr>
		<xsl:attribute name='class'><xsl:value-of select="$class_type"/></xsl:attribute>
		<xsl:attribute name='onclick'>
				showPopup('<xsl:value-of select="@id"/>', '<xsl:value-of select="verdict"/>', '<xsl:value-of select="link"/>');
		</xsl:attribute>
		<td class="tc_id">
			<xsl:value-of select="@id"/>
		</td>
		<td>
			<xsl:attribute name='class'>
				<xsl:choose>
					<xsl:when test="verdict='PASSED'">
						tc_r_pass
					</xsl:when>
					<xsl:otherwise>
						tc_r_fail
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:value-of select="verdict" />
		</td>
		<td class="tc_comment">
			<xsl:value-of select="comment"/>
		</td>
	</tr>
  </xsl:template>

  <xsl:template name="printTotalsBeneath">
	<div id="totalsBeneath" style="display:none;">
		<table class="testtotals">
			<tr>
				<td class="leftside">Total:</td>
				<td><xsl:value-of select="summary/totaltestcases" /></td>
			</tr>
			<tr>
				<td class="leftside">Passed:</td>
				<td><xsl:value-of select="summary/totalpassed" /></td>
			</tr>
			<tr>
				<td class="leftside">Failed:</td>
				<td><xsl:value-of select="summary/totalfailed" /></td>
			</tr>
			<tr>
				<td class="leftside">Unknown:</td>
				<td><xsl:value-of select="summary/totalunknown" /></td>
			</tr>
			<tr>
				<td class="leftside">Error:</td>
				<td><xsl:value-of select="summary/totalerror" /></td>
			</tr>
		</table>
	</div>
  </xsl:template>

  <xsl:template name="printTotalsAbove">
	<div id="testGroupHeaderInfo" style="display:block;">
		<div id="totalAboveItem">
			<span id="totalAboveLabel">Total:</span>
			<span id="totalAboveValue"><xsl:value-of select="summary/totaltestcases" /></span>
		</div>
		<div id="totalAboveItem">
			<span id="totalAboveLabel">Passed:</span>
			<span id="totalAboveValue"><xsl:value-of select="summary/totalpassed" /></span>
		</div>
		<div id="totalAboveItem">
			<span id="totalAboveLabel">Failed:</span>
			<span id="totalAboveValue"><xsl:value-of select="summary/totalfailed" /></span>
		</div>
		<div id="totalAboveItem">
			<span id="totalAboveLabel">Unknown:</span>
			<span id="totalAboveValue"><xsl:value-of select="summary/totalunknown" /></span>
		</div>
		<div id="totalAboveItem">
			<span id="totalAboveLabel">Error:</span>
			<span id="totalAboveValue"><xsl:value-of select="summary/totalerror" /></span>
		</div>
	</div>
  </xsl:template>

  <xsl:template name="filter">
	<xsl:variable name="idform">
		<xsl:value-of select="@id"/>
	</xsl:variable>
	<div id="testGroupHeaderFilter" style="display:none;">
		<form name="resultfilter">
			<select id="{@id}" name="menu" onchange="showHideRows(this.id, this.options[this.selectedIndex].value);" value="START">
				<option value="all">All</option>
				<option value="passed">Passed</option>
				<option value="failed">Failed</option>
				<option value="error">Error</option>
				<option value="unknown">Unknown</option>
			</select>
		</form>   
	</div>
  </xsl:template>

</xsl:stylesheet>
