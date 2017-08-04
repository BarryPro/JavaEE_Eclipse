<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml" encoding="gb2312" omit-xml-declaration="yes" />
	<xsl:template match="/info">
		<table>
			<xsl:call-template name="display">
				<xsl:with-param name="level" select="0" />
			</xsl:call-template>
		</table>
	</xsl:template>
	<xsl:template name="display">
		<xsl:param name="level" />
		<xsl:for-each select="*">
			<xsl:sort select="@order" data-type="number" order="ascending" />
			<xsl:variable name="cell" select="3" />
			<xsl:variable name="remainder" select="number(@order mod $cell)" />
			<xsl:variable name="pos" select="number(position())" />
			<xsl:variable name="temp_option_flag" select="option_flag" />
			
			<xsl:if test="$remainder=0">
				<xsl:text disable-output-escaping="yes">&lt;TR&gt;</xsl:text>
			</xsl:if>
						<xsl:text disable-output-escaping="yes">&lt;TD class='blue' id='template_</xsl:text><xsl:value-of select="id_flag" /><xsl:text disable-output-escaping="yes">' &gt;</xsl:text>
							<xsl:choose>
							<xsl:when test="$temp_option_flag='Y'">
							  <xsl:text disable-output-escaping="yes">&lt;span class='orange' &gt;*</xsl:text><xsl:value-of select="info_name" /><xsl:text disable-output-escaping="yes">&lt;/span&gt;</xsl:text>
							</xsl:when>
							<xsl:otherwise>
											<xsl:value-of select="info_name" />
							</xsl:otherwise>
							</xsl:choose>
						<xsl:text disable-output-escaping="yes">&lt;/TD&gt;</xsl:text>
						<xsl:if test=" @dataType = 0 or @dataType=1 or @dataType=2 or @dataType=4 or @dataType=7 or @dataType=8 or @dataType=9 or @dataType=10 or @dataType=11 or @dataType=12 or @dataType=13 or @dataType=14 or @dataType=16 ">
							<TD>
								<xsl:call-template name="input_text">
									<xsl:with-param name="t_name" select="concat('s_',info_code)" />
									<xsl:with-param name="t_length" select="data_length" />
									<xsl:with-param name="t_type" select="@dataType" />
									<xsl:with-param name="v-name" select="info_name" />
									<xsl:with-param name="t_preci" select="data_preci" />
									<xsl:with-param name="t_readonly" select="read_only" />
									<xsl:with-param name="t_obj" select="default_value" />
									<xsl:with-param name="t_sql" select="info_obj" />
									<xsl:with-param name="t_control" select="option_flag" />
									<xsl:with-param name="t_flag" select="doc_flag" />
									<xsl:with-param name="t_size" select="show_length" />
								</xsl:call-template>
							</TD>
						</xsl:if>
						<xsl:if test=" @dataType = 5 or @dataType=15 ">
							<TD  name="{$remainder}">
								<xsl:variable name="temp_readonly" select="read_only" />
								<xsl:element name="select">
									<xsl:if test="$temp_readonly='Y'">
										<xsl:attribute name="disabled">true</xsl:attribute>
										<xsl:attribute name="v_readonly">Y</xsl:attribute>
									</xsl:if>
									<xsl:if test="$temp_readonly='N'">
										<xsl:attribute name="v_readonly">N</xsl:attribute>
									</xsl:if>
									<xsl:if test="@dataType = 15">
										<xsl:attribute name="multiple">
											<xsl:value-of select="true" />
										</xsl:attribute>
									</xsl:if>
									<xsl:attribute name="name">
										<xsl:value-of select="concat('s_',info_code)" />
									</xsl:attribute>
									<xsl:attribute name="v_type">
										<xsl:value-of select="@dataType" />
									</xsl:attribute>
									<xsl:attribute name="v_preci">
										<xsl:value-of select="data_preci" />
									</xsl:attribute>
									<xsl:attribute name="v_flag">
										<xsl:value-of select="doc_flag" />
									</xsl:attribute>
									<xsl:attribute name="v_name">
										<xsl:value-of select="info_name" />
									</xsl:attribute>
									<xsl:attribute name="v_sql">
										<xsl:value-of select="info_obj" />
									</xsl:attribute>
								  <xsl:attribute name="v_selVal">
										<xsl:value-of select="default_value" />
									</xsl:attribute>
								  <xsl:attribute name="v_optionFlag">
										<xsl:value-of select="option_flag" />
									</xsl:attribute>
								</xsl:element>
							</TD>
					</xsl:if>
			<xsl:if test=" ($pos=last()) or  $pos=$cell ">
				<xsl:text disable-output-escaping="yes">&lt;/TR&gt;</xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="input_text">
		<xsl:param name="t_name" />
		<xsl:param name="t_length" />
		<xsl:param name="t_type" />
		<xsl:param name="v-name" />
		<xsl:param name="t_preci" />
		<xsl:param name="t_readonly" />
		<xsl:param name="t_obj" />
		<xsl:param name="t_sql" />
		<xsl:param name="t_control" />
		<xsl:param name="t_flag" />
		<xsl:param name="t_size" />
		<xsl:choose>
					<xsl:when test="$t_type ='11'">
					    <input v_readonly="{$t_readonly}"  v_optionFlag="{$t_control}" name="{$t_name}" v_flag="{$t_flag}" value="{$t_obj}" v_type="{$t_type}" size="{$t_size}" v_name="{$v-name}" maxlength="{$t_length}"  v_preci="{$t_preci}" type="password" />
					</xsl:when>
					<xsl:when test="$t_type ='16'">
					    <input v_readonly="{$t_readonly}"  v_optionFlag="{$t_control}" name="{$t_name}" v_flag="{$t_flag}" value="{$t_obj}" v_type="{$t_type}" size="{$t_size}" readOnly="true" v_name="{$v-name}" maxlength="{$t_length}" v_preci="{$t_preci}" type="text" />
					    <input type="button" class="b_text" name="{concat('query',$t_name)}" v_flag="{$t_flag}" size="{$t_size}"  id="{concat('query',$t_name)}" v_sql="{$t_sql}"   value="获取" onclick="getObjInfo('{$t_name}')" />
					</xsl:when>
					<xsl:otherwise>
							<input  v_readonly="{$t_readonly}"  v_optionFlag="{$t_control}" name="{$t_name}" v_flag="{$t_flag}" value="{$t_obj}" v_type="{$t_type}" size="{$t_size}" v_name="{$v-name}" maxlength="{$t_length}" v_preci="{$t_preci}" type="text" />
					</xsl:otherwise>		
		</xsl:choose> 
	</xsl:template>

</xsl:stylesheet>
