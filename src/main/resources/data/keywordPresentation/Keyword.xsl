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
                <link rel="stylesheet" href="KeywordStyle.css"
                    type="text/css" />
            </head>

            <body>
                <div id="keywords">
                    <xsl:for-each select="./TestStep">
                        <xsl:call-template name="keyword" />
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
                <xsl:if test="not(Optional)">
                    <img class="check" src="check.jpg" />
                </xsl:if>
            </td>
            <td>
                <xsl:if test="boolean(ValueAllowed)">
                    <img class="check" src="check.jpg" />
                </xsl:if>
            </td>
            <td>
                <xsl:if test="boolean(VariableAllowed)">
                    <img class="check" src="check.jpg" />
                </xsl:if>
            </td>
            <td>
                <xsl:if test="boolean(EmptyAllowed)">
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

</xsl:stylesheet>
