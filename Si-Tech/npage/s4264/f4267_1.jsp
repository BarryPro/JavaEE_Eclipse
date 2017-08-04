<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:备注信息查询
   * 版本: 1.0
   * 日期: 2009/3/31
   * 作者: dujl
   * 版权: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "4267";
	String opName = "备注信息查询";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	

function resetJsp()
{
	document.frm.opNote.value="";
}

function commitJsp()
{
	if(document.frm.opNote.value=="")
	{
		rdShowMessageDialog("请输入备注信息");
		return false;
	}
	else
	{
		if(check(frm)){
		   	var opNote = document.frm.opNote.value;
		   	document.middle.location="f4267info.jsp?opNote="+opNote;
		   	tabBusi.style.display="";
	    }
	}
}
 		
</script> 
 
<title>备注信息查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="" method="post" name="frm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">备注信息查询</div>
	</div>
<table cellspacing="0">             
	<tr> 
		<td class="blue" nowrap>备注信息</td>
		<td> 
			<input type="text" name="opNote" id="opNote" size="60" maxlength="60" class="button">
    	</td>
  	</tr>
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			
			<input type="button" name="confirm" class="b_foot" value="查询" onclick="commitJsp()">
			&nbsp;
			<input type="button" name="reset" class="b_foot" value="清除" onclick="resetJsp()">
			&nbsp;
		</td>
	</tr>
</table>
	<TABLE id="tabBusi" style="display:none" width="100%"  align="center" id="mainOne" cellspacing="0" border="0" >	
		<TR> 
			<td nowrap>
				<IFRAME frameBorder=0 id=middle name=middle scrolling="yes" 
				style="HEIGHT: 1200%; VISIBILITY: inherit; WIDTH: 99%; Z-INDEX: 1">
				</IFRAME>
			</td> 
		</TR>
	</TABLE>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
