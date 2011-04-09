<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html"/>

  <xsl:template match="/testgroup">
    <html>
      <head>
        <script src="testgroup.js" />

        <title>Test Group Results</title>
        <link rel="stylesheet" href="testgroup_style.css" type="text/css" />
      </head>
      <body onLoad="notifyParrent();">

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
			<div id="testgroupheader_id"> 
				<img id="{@id}plusmin" src="plus.gif" onclick="
					showHide('{@id}testLogs');
					showHide('testcases');
					showHide('testGroupHeaderInfo');
					showHide('subTestGroups');
					showHide('totalsBeneath'); 
					showHide('testGroupHeaderFilter');
					swapImg('{@id}plusmin');
					notifyParrent();">
				</img>&#160;
				<xsl:value-of select="@id" />
			</div>
			<xsl:call-template name="printTotalsAbove"/>
			<xsl:call-template name="filter"/>
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

		<div id="{@id}testLogs" style="display:none;">
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
			<xsl:value-of select="@comment"/>
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
		<div id="totalAboveItem">Total:&#160;<xsl:value-of select="summary/totaltestcases" /></div>
		<div id="totalAboveItem">Passed:&#160;<xsl:value-of select="summary/totalpassed" /></div>
		<div id="totalAboveItem">Failed:&#160;<xsl:value-of select="summary/totalfailed" /></div>
		<div id="totalAboveItem">Unknown:&#160;<xsl:value-of select="summary/totalunknown" /></div>
		<div id="totalAboveItem">Error:&#160;<xsl:value-of select="summary/totalerror" /></div>
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
