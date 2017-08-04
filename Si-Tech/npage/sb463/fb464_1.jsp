<%
	/*
	 * 功能: wlan预付费卡密码补发- 主界面
	 * 版本: v1.0
	 * 日期: 2010/8/24
	 * 作者: jianglei
	 * 版权: sitech
	 * 修改历史
	 * 修改日期      修改人      修改目的
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	
	//读取用户session信息	
    String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));               //工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	
	String opCode = "sb464";
	String opName = "wlan预付费卡密码补发";
%>	
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=opName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<script language=javascript>
	
	
function querycard()
{
	if(check(form1)){
		tabBtn1.style.display="";
		var phone_no = document.all.phone_no.value;
		document.middle.location="fb464info.jsp?phone_no="+phone_no;
    	loading("正在加载查询信息，请稍候······");
	}
}	
function UnLoad(){
	unLoading();
}
</script>
</head>

<body>
<form action="" name="form1"  method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">wlan预付费卡密码补发</div>
</div>
	<table cellspacing="0" >
		<tr>
		<td class="blue"  nowrap>手机号码</td>
	    <td>
	    	<input  type="text" name="phone_no" id="phone_no" value="" size="20" >	
	    </td>
	</tr>
	</table>
	<TABLE id="tabBtn" style="display:''" id="mainOne" cellspacing="0" >	    
		<TR id="footer"> 
			<TD colspan = "4" align="center"> 
				<input name="queryAcBtn" style="cursor:hand" type="button" class="b_foot" value="查  询" onClick="querycard()">
			</TD>
		</TR>
	</TABLE> 
	<TABLE id="tabBtn1" style="display:none" id="mainOne" cellspacing="0" >
		<TR id="footer"> 
			<TD colspan = "4" align="center"> 
				<IFRAME frameBorder=0 id=middle name=middle style="HEIGHT: 306px; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
				</IFRAME>
			</TD>
		</TR>
	</TABLE> 
	
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

