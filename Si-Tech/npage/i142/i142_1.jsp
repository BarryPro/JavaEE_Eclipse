 <!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 号码信息查询5186
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode="i142";
	String opName="VPMN业务使用时长查询";
	//String phoneNo = (String)request.getParameter("activePhone");			//手机号码
	activePhone = request.getParameter("activePhone");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>VPMN业务使用时长查询</TITLE>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
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
	//if(jtrim(document.frm5186.cus_pass.value).length ==0)
	//	document.frm5186.cus_pass.value="123456";   
	if(document.frm5186.phoneNo.value=="")
	{	rdShowMessageDialog("请输入查询条件！");
		document.frm5186.phoneNo.focus();
		return false;
	} 
	else{
	document.frm5186.action="i142_2.jsp";
	document.frm5186.Button1.disabled=true;
	frm5186.submit();
	}
	return true;
}

</SCRIPT>

<FORM method=post name="frm5186">
	<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="opCode"  value="5186">
<input type="hidden" name="custPass"  value="">
	<div class="title">
		<div id="title_zi">VPMN业务使用时长查询</div>
	</div>
<table cellspacing="0">
	<TR> 
	    	<td class="blue">服务号码</TD>
          <td>
          	<input type="text"  name="phoneNo" readonly size="20" maxlength="11" onKeyDown="if(event.keyCode==13){doCheck();return false}" value="<%=activePhone%>">
			<input type="submit" class="b_text" name="Button1" value="查询" onclick="doCheck()">
          </td>
          <td class="blue">&nbsp;</td>
          <td>&nbsp;
          </td>
          </TR>
		     
			 
			 
			
			   
	    <TR> 
	      <TD align="center" id="footer" colspan="4"> 
	        &nbsp;<input class="b_foot" name=reset  type=reset onClick="" value=清除>
	        &nbsp;&nbsp;<input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
	        &nbsp; 
	      </TD>
	    </TR>
	    </table> 
    <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</body>
</html> 
