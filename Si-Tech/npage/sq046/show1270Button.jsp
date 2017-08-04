<%
/********************
*version v3.0
*开发商: si-tech
*
*update:ZZ@2013-10-23 wanghyd
*如果是1270主资费变更办理了自选资费则弹出按钮
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%String Readpaths = request.getRealPath("npage/properties")+"/getRDMessage.properties";%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>打印</TITLE>


</HEAD>

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String opCode = request.getParameter("opCode");
	/***************** update by diling @2012/3/14 19:40:41 start***************/

	String phoneNo = request.getParameter("phoneNo");

	System.out.println("phoneNo+++++++++++++++++++++++++++++++++++++" + phoneNo);
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/products.css" rel="stylesheet"type="text/css">
<link href="/nresources/<%=cssPath%>/css/portal.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="/njs/si/validate_class.js"></script>
<script language="javascript" type="text/javascript" src="/njs/extend/mztree/stTree.js"></script>
<SCRIPT type="text/javascript">



function doSub()
{

  window.close();
}
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
function gotorul(str) {
		window.returnValue=str;
		window.close();
}
</SCRIPT>

<!--**************************************************************************************-->

<body style="overflow-x:hidden;overflow-y:hidden">
	<head>
		<title>黑龙江移动BOSS</title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
	</head>
<FORM method=post name="spubPrint" target="_parent">
  <!------------------------------------------------------>
  
  <div class="popup" align=center >
  	<br>
	  	<div class="popup_ok" id="rdImage" align=center >
		  	<div class="popup_zi green" id="message" align=center><font size="4"><b>业务受理成功！</b></font></div>

		  	
		  </div>
			<br>

	    <div align="center"  style="line-height:100%">
	    	<%
	    	 int buttonnum=Integer.parseInt(readValue("1270","button","num",Readpaths));
	    	for(int i=1;i<=buttonnum;i++) {%>
				<input class="b_text" name=commit onClick="gotorul('<%=readValue("1270","button"+i,"value",Readpaths)%>')"  style="width:<%=readValue("1270","button"+i,"px",Readpaths)%>"  type=button value="<%=readValue("1270","button"+i,"name",Readpaths)%>">&nbsp;&nbsp;
				<%}%>					      
	      <input class="b_text" name=back onClick="gotorul('close')"  type=button value="取消">&nbsp;&nbsp;
	    </div>
	    <br>&nbsp;<br />
	 </div>


</FORM>
</BODY>
</HTML>
