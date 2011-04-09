<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html"/>

  <xsl:template match="/testrun">
    <html>
      <head>
		<script src="jquery-1.5.min.js" />
        <script src="testrun.js" />

        <title>Test Results</title>
        <link rel="stylesheet" href="testrun_style.css" type="text/css" />
        <link rel="stylesheet" href="testgroup_style.css" type="text/css" />
     </head>
      <body>

		<!-- div id="debug">
		  <table>
				<tr>
					<td id="debug_label">
					  Debug info
					</td>
					<td id="debug_value">
					  Value
					</td>
					<td onclick="document.getElementById('debug_value').innerHTML = 0">
					  Clear
					</td>
				</tr>
		  </table>
		</div -->

		<div id="logo">
			<img src="logo.png"/>
		</div>
		
        <div id="top">
          <h1>Test Results <span class="titlename"><xsl:value-of select="@name" /></span></h1>
		</div>

        <div id="info">
          <xsl:call-template name="printTestInfo"/>
        </div>

        <div id="systemundertest">
          <xsl:for-each select="./systemundertest">
            <xsl:call-template name="printSystemUnderTest"/>
          </xsl:for-each>
        </div>

        <div id="testgroups">
          <xsl:for-each select="./testgroup">
            <xsl:call-template name="printTestGroup"/>
          </xsl:for-each>
		</div>

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
							<iframe id="ifr_popup" name='popup_link' width="100%" frameborder="no" scrolling="no"></iframe>
						</div>
					</td>
				</tr>
			</table>
		</div>

	  </body>
    </html>    
  </xsl:template>


	<xsl:template name="printTestInfo">
		<div class="table">
			<table class="testinfo">
				<tr>
					<td class="leftside">Name:</td>
					<td><xsl:value-of select="@name" /></td>
				</tr>
				<tr>
					<td class="leftside">Suite:</td>
					<td><xsl:value-of select="@suite" /></td>
				</tr>
				<tr>
					<td class="leftside">Environment:</td>
					<td><xsl:value-of select="@environment" /></td>
				</tr>
				<tr>
					<td class="leftside">Project-phase:</td>
					<td><xsl:value-of select="@phase" /></td>
				</tr>
				<tr>
					<td class="leftside">Author:</td>
					<td><xsl:value-of select="@author" /></td>
				</tr>
				<tr>
					<td class="leftside">Machine:</td>
					<td><xsl:value-of select="@machine" /></td>
				</tr>
				<tr>
					<td class="leftside">Start date:</td>
					<td><xsl:value-of select="@startdate" /></td>
				</tr>
				<tr>
					<td class="leftside">Start time:</td>
					<td><xsl:value-of select="@starttime" /></td>
				</tr>
				<tr>
					<td class="leftside">State:</td>
					<td><xsl:value-of select="@status" /></td>
				</tr>
			</table>
		</div>
	</xsl:template>

	<xsl:template name="printSystemUnderTest">
		<div class="systemundertestheader">
			<span>System Under Test</span>
			<span class="systemundertestsummary">
				(<xsl:value-of select="@product" />
			</span>
			<span class="systemundertestsummary">
				 <xsl:value-of select="./version/@mainLevel" />.<xsl:value-of select="./version/@subLevel" />-<xsl:value-of select="./version/@patchLevel" />)
			</span>
		</div>

		<div class="systemundertestinfo">
			<table class="systemundertestinfo">
				<tr>
					<td class="leftside">Product:</td>
					<td><xsl:value-of select="@product" /></td>
				</tr>
				<tr>
					<td class="leftside">Version:</td>
					<td><xsl:value-of select="./version/@mainLevel" />.<xsl:value-of select="./version/@subLevel" /></td>
				</tr>
				<tr>
					<td class="leftside">Patchlevel:</td>
					<td><xsl:value-of select="./version/@patchLevel" /></td>
				</tr>
				<tr>
					<td class="leftside">Version Files:</td>
					<td>
						<xsl:for-each select="./version/logFiles/logFile">
							<xsl:call-template name="printLogFileLink"/>
						</xsl:for-each>
					</td>
				</tr>
			</table>
		</div>
	</xsl:template>

  <xsl:template name="printTestGroup">
    <div id="testgroup">
		<div id="testgroupheader">
			<img id="testgroupheader_plusmin" src="minus.gif" onclick="showHideTestGroup();">
			</img>
			<div id="testgroupheader_id"> 
				<xsl:value-of select="@id" />
			</div>
			<xsl:call-template name="printTotalsAbove"/>
			<xsl:call-template name="filter"/>
		</div>

		<div id="prepare" style="display:block;">
			<xsl:for-each select="./prepare">
				<xsl:call-template name="printSteps"/>
			</xsl:for-each>
		</div> 

		<div id="subTestGroups" style="display:block;">
			<xsl:for-each select="./testgrouplink">
				<xsl:call-template name="printTestGroupLink"/>
			</xsl:for-each>
		</div> 

		<div id="testcases" style="display:block;">
			<xsl:if test="count(testcaselink)>0">
				<table class="testcasetable">
					<xsl:for-each select="./testcaselink">
						<xsl:call-template name="printTestCase"/>
					</xsl:for-each>
				</table>
			</xsl:if>
		</div>

		<div id="restore" style="display:block;">
			<xsl:for-each select="./restore">
				<xsl:call-template name="printSteps"/>
			</xsl:for-each>
		</div> 

		<div id="testLogs" style="display:block;">
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
				<td class="stepscript"><xsl:value-of select="./script" /></td>
				<td class="stepresult"><xsl:value-of select="./result" /></td>
			</tr>
		</xsl:for-each>
	</table>
  </xsl:template>

  <xsl:template name="printTestGroupLink">
	<iframe frameborder="no" width="100%" scrolling="no" height="32">
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
	<div id="totalsBeneath" style="display:block;">
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
	<div id="testGroupHeaderInfo" style="display:none;">
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
	<div id="testGroupHeaderFilter" style="display:block;">
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
