 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:zhangshuaia@2009-08-10 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page language="java" import="java.sql.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<html>
	<head> 
	<title>一证多号欠费号码查询</title>
 
<%
  	//String opCode = "4141";		
  	String opCode = "zga7";		
	String opName = "一证多号欠费号码查询";	//header.jsp需要的参数
	//activePhone = request.getParameter("activePhone");
 	String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);
    String groupId = (String)session.getAttribute("groupId");
	String contextPath = request.getContextPath();
 
%>
 


<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>

function docomm(subButton)
{
	//确定flag 判断操作
	var phone_no  = document.all.phone_no.value;
	if(phone_no=="")
	{
		rdShowMessageDialog("请输入手机号码!");
		return false;
	}
	else
	{
		frm.action="zga7_2.jsp?phone_no="+phone_no;
		frm.submit();
	}
	
} 
 
 

function init()
{
	document.all.kjlx[document.all.kjlx.selectedIndex].value="";
	document.all.jflx[document.all.jflx.selectedIndex].value="";
	document.all.ywsysj.value="";
	document.all.hjsj.value="";
}
</script>


</head>
<body>
<form name="frm" method="POST" >

	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">一证多号欠费号码查询</div>
	</div>
	<table>
	<tr >
			<td width="15%" class="blue" nowrap>查询号码</td>
			<td><input type="text" name="phone_no" id="phone_no" colspan=6  maxlength=11 size="18">&nbsp;&nbsp;</td>
	</tr>
		<!--xl add end 查询条件-->
 
		 
		</table>
		<table cellspacing="0">
			<tr id="add_3">
				<td style="height:0;">
					<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="yes" style="height:300px;overflow-y:auto; visibility:inherit; width:1300px; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
				</td>
			</tr>
		</table>
		<table  cellspacing="0" >
			<tr>
				<td id="footer">     
					<input type=button name="confirm"class="b_foot"  value="确认" onClick="docomm()">    
					<input type=button name=back value="清除" class="b_foot" onmouseup="clearnew()" onClick="clearnew()">
					<input type=button name=qryP value="关闭" class="b_foot" onClick="removeCurrentTab();">             
				</td>
			</tr>
		</table>
<%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html> 