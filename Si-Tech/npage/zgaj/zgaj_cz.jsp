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
	<title>投诉退费查询</title>
	<%@ include file="../../npage/s4140/head_4141_1_javascript.htm" %>
<%
  	//String opCode = "4141";		
  	String opCode = "zgaj";		
	String opName = "一键退费";	//header.jsp需要的参数
	//activePhone = request.getParameter("activePhone");
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
	
	String work_no = (String)session.getAttribute("workNo");
	//work_no="800111";
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);
    String groupId = (String)session.getAttribute("groupId");
	String contextPath = request.getContextPath();
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] mon = new String[]{"", "", "", "", "", ""};
	String account="2";
	String loginNo = (String)session.getAttribute("workNo");

	Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0, 4)),
			(Integer.parseInt(dateStr.substring(4, 6)) - 1), Integer.parseInt(dateStr.substring(6, 8)));
	for (int i = 0; i <= 5; i++) {
		if (i != 5) {
			mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
			//cal.add(Calendar.MONTH, -1);
		} else
			mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
	}
	// 下拉框
	String sql_reason = "select first_code,first_name from SREFUNDCheckType where valid_flag='2' order by first_code desc ";
%>
<script language=javascript>
function fPopUpCalendarDlg(ctrlobj)
{
	showx = event.screenX - event.offsetX - 4 - 210 ; // + deltaX;
	showy = event.screenY - event.offsetY + 18; // + deltaY;
	retval = window.showModalDialog("/js/common/date/CalendarDlg.htm", "", "dialogWidth:197px; dialogHeight:210px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:yes;scrollbars:no;Resizable=no; ");
	if(retval != null)
	{
		ctrlobj.value = retval;
	}
	else
	{
		//alert("canceled");
	}
}
function sel1()
{
	window.location.href='zgaj_1.jsp';
}
function sel2()
{
	window.location.href='zgaj_cz.jsp';
}
</script>
<!--20091220 end -->


<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>

function docomm(subButton)
{
	//确定flag 判断操作
	var phone_no  = document.all.phone_no.value;
	var tsdzls = document.all.tsdzls.value;
	if(phone_no=="")
	{
		rdShowMessageDialog("请输入手机号码!");
		return false;
	}
	else if(tsdzls=="")
	{
		rdShowMessageDialog("请输入投诉电子流水号码!");
		return false;
	}
	else
	{
		frm.action="zgaj_cz_init.jsp?phone_no="+phone_no+"&tsdzls="+tsdzls;
		frm.submit();
	}
	
} 
 
 

function inits()
{
//	alert("1");
	if("<%=work_no.substring(0,2)%>"==80)
	{
		if("<%=work_no%>"!="801001"&&"<%=work_no%>"!="800107" &&"<%=work_no%>"!="800227" &&"<%=work_no%>"!="800219" &&"<%=work_no%>"!="800294" &&"<%=work_no%>"!="800236")
		{
			rdShowMessageDialog("工号没有冲正权限!");
			window.location.href="zgaj_1.jsp";
		}
	}
}
</script>

 

</head>
<body onload="inits()">
<form name="frm" method="POST" >

	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">一键退费</div>
	</div>
	<table cellspacing="0">
		<tbody>
		<tr> 
        <td class="blue" width="16%">退费方式</td>
        <td colspan="4"> 
        	<q vType="setNg35Attr">
			  <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" >退费 
			</q>
			<q vType="setNg35Attr">
			  <input name="busyType1" id="busyType1" type="radio" onClick="sel2()" value="2" checked>冲正 
			</q>
		</tr>
		</tbody>
	</table>
	<table>
			<TD class="blue" width=16%>查询号码</td>
			<td><input type="text" name="phone_no" id="phone_no"  maxlength=11 size="18">&nbsp;&nbsp;</td>
			<TD class="blue" width=16%>业务流水</td>
			<td><input type="text" name="tsdzls" id="tsdzlsid" maxlength=30 size="30">&nbsp;&nbsp;</td>
	</tr>
		<!--xl add end 查询条件-->
 
		 
			 
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