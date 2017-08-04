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
	String opCode="zgau";
	String opName="高额退费金额工号配置";
 
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>高额退费金额工号配置</TITLE>
 
</HEAD>

<body>
<SCRIPT language="JavaScript">

function doCheck()
{
	//if(jtrim(document.frm5186.cus_pass.value).length ==0)
	//	document.frm5186.cus_pass.value="123456";   
	var s_login_no = document.frm5186.s_login_no.value;
	if(s_login_no=="")
	{
		rdShowMessageDialog("请输入欲配置的工号!");
		return false;
	}
	else if (s_login_no.substr(0,2)!="80")
	{
		rdShowMessageDialog("只有客服工号可以进行此配置!");
		return false;
	}
	else{
		document.frm5186.action="zgau_2.jsp?s_login_no="+s_login_no;
		//alert(document.frm5186.action);
		document.frm5186.submit();
	}
	 
}
function qry()
{
	document.frm5186.action="zgau_3.jsp";
	document.frm5186.submit();
}

</SCRIPT>

<FORM name="frm5186"  method=post>
<%@ include file="/npage/include/header.jsp" %>
 
	<div class="title">
		<div id="title_zi">高额退费金额工号配置</div>
	</div>
<table cellspacing="0">
		<TR> 
	      <td class="blue">配置工号</TD>
          <td colspan=3>
			<input type="text" name="s_login_no" maxlength=6>	
		  </td>
		</TR>
		<tr>
			<td colspan=3>
				备注：配置成功的工号进行退费操作，则退费限额为300元；未进行配置的工号限额为150元。
			</td>
		</tr> 	 
	    <TR> 
	      <TD align="center" id="footer" colspan="4"> 
		  <input type=button class="b_foot" name="Button1" value="添加" onclick="doCheck()">
	        &nbsp; 
	        &nbsp;&nbsp;<input class="b_foot" name="qry1" onClick="qry()" type=button value="已配置工号信息查询">
	        &nbsp; 
	        &nbsp;&nbsp;<input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
	      </TD>
	    </TR>
	    </table> 
    <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</body>
</html> 
