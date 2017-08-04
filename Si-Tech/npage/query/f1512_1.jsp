<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-07
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>过户历史资料查询</TITLE>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<%
    
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
    String opCode = "1512";
    String opName = "过户历史资料查询";
%>
<%
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String Department = (String)session.getAttribute("orgCode");
	String regionCode = Department.substring(0,2);
	
	String phoneNo = (String)request.getParameter("activePhone");
%>
</HEAD>

<body>
<SCRIPT language="JavaScript">
function isNumberString (InString,RefString)
{
if(InString.length==0) return (false);
	for (Count=0; Count < InString.length; Count++)  {
		TempChar= InString.substring (Count, Count+1);
		if (RefString.indexOf(TempChar, 0)==-1)  
		return (false);
	}
	return true;
}

function doCheck()
{	
	if( document.frm1512.phoneNo.value.length<11 || (isNumberString(document.frm1512.phoneNo.value,"1234567890")!=1 || parseInt(document.frm1512.phoneNo.value.substring(0,3),10)<134 || (parseInt(document.frm1512.phoneNo.value.substring(0,3),10)>139 )&&(parseInt(document.frm1512.phoneNo.value.substring(0,2),10) !=15)&&(parseInt(document.frm1512.phoneNo.value.substring(0,2),10) !=14)&&(parseInt(document.frm1512.phoneNo.value.substring(0,2),10) !=18))) 
	{	
	
		rdShowMessageDialog("请输入正确的查询条件！");
		document.frm1512.phoneNo.select();
		return false;
		
	} else {
    	document.frm1512.action="f1512_2.jsp";
    	frm1512.submit();
	}
	return true;
}

</SCRIPT>

<FORM method=post name="frm1512" OnSubmit="return doCheck()"">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">过户历史资料查询</div>
</div>
<input type="hidden" name="opCode"  value="1512">

	<TABLE cellSpacing=0>
        <TR> 
          <TD class=blue>服务号码</TD>
          <TD><input type="text" name="phoneNo" value="<%=phoneNo%>" size="20" maxlength="11">
          	<input type="submit" class="b_text" name="Button1" value="查询" onclick="doCheck()">
          </TD>
        </TR>

  <tr id="footer" > 
    <td colspan=2>
      <input class="b_foot" name=reset  type=reset onClick="" value=清除>
      <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
    </td>
  </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>

</BODY></HTML>
<!--***********************************************************************-->
