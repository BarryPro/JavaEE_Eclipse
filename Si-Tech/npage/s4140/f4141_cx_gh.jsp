 <%
	/********************
	 version v2.0
	������: si-tech
	update:zhangshuaia@2009-08-10 ҳ�����,�޸���ʽ
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
	<title>Ͷ���˷Ѳ�ѯ</title>
	<%@ include file="../../npage/s4140/head_4141_1_javascript.htm" %>
<%
  	//String opCode = "4141";		
  	String opCode = "4141";		
	String opName = "�˷Ѳ�ѯ";	//header.jsp��Ҫ�Ĳ���
	
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
	
	String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);
    String groupId = (String)session.getAttribute("groupId");
	String contextPath = request.getContextPath();
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
</script>
<!--20091220 end -->


<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>

function docomm(subButton)
{
	var begin_time = document.all.begin_time.value.substring(0,4)+document.all.begin_time.value.substring(5,7)+document.all.begin_time.value.substring(8,10);
	var end_time1 = document.all.end_time1.value.substring(0,4)+document.all.end_time1.value.substring(5,7)+document.all.end_time1.value.substring(8,10);
	var login_no = document.all.login_no.value;
 
	
	if(login_no=="")
	{
		rdShowMessageDialog("��ѯ���Ų���Ϊ�գ�");
		return;
	}
	else 
	
	if(begin_time=="")
	{
		rdShowMessageDialog("��ʼʱ�䲻��Ϊ�գ�");
		return;
	}
	else if(end_time1=="")
	{
		rdShowMessageDialog("����ʱ�䲻��Ϊ�գ�");
		return;
	}
	
else
	{
		/*
		frm.action="zg69_2.jsp?begin_time="+begin_time+"&end_time="+end_time1;
		frm.submit();
		*/
		document.getElementById("qryOprInfoFrame").style.display="block";
		document.qryOprInfoFrame.location = "f4141_getInfo.jsp?begin_time="+begin_time+"&login_nos="+login_no+"&end_time="+end_time1+"&qry_flag=2";
	}
} 
 
 

function init()
{
	document.all.kjlx[document.all.kjlx.selectedIndex].value="";
	document.all.jflx[document.all.jflx.selectedIndex].value="";
	document.all.ywsysj.value="";
	document.all.hjsj.value="";
}

function sel1()
{
	window.location.href='f4141_cx.jsp';
}
function sel2()
{
	window.location.href='f4141_cx_gh.jsp';
}
</script>


</head>
<body>
<form name="frm" method="POST" >

	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">�˷Ѳ�ѯ</div>
	</div>
	<table>
		<tr>
			<tr> 
			  <td class="blue" width="15%">��ѯ��ʽ</td>
			  <td colspan="3"> 
				<q vType="setNg35Attr">
				<input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1"  >
				�������ѯ 
				</q>
				<q vType="setNg35Attr">
				<input name="busyType1" type="radio" onClick="sel2()" value="2"  checked>
				�����Ų�ѯ 
				</q>
                    
		</tr>

	<tr >
			<td width="15%" class="blue" nowrap>��ѯ����</td>
			<td><input type="text" name="login_no" id="login_no" colspan=6  maxlength=11 size="18" value="<%=work_no%>">&nbsp;&nbsp;</td>
	</tr>
		<!--xl add end ��ѯ����-->
 
		<tr >		
			<td width="15%" class="blue" nowrap>��ʼʱ��</td>
			<td width="35%">
				<input type="text" name="begin_time" id="begin_time" size="18" readonly="true"/>&nbsp;
				<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(begin_time);return false' alt=�������������˵� align=absMiddle readonly><font class="orange">*</font></td>
			</td>
		
			<td width="15%" class="blue" nowrap>����ʱ��</td>
			<td width="35%">
				<input type="text" name="end_time1" id="end_time1" size="18" readonly="true"/>&nbsp;
				<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(end_time1);return false' alt=�������������˵� align=absMiddle readonly><font class="orange">*</font></td>
			</td>
		</tr>
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
					<input type=button name="confirm"class="b_foot"  value="ȷ��" onClick="docomm()">    
					<input type=button name=back value="���" class="b_foot" onmouseup="clearnew()" onClick="clearnew()">
					<input type=button name=qryP value="����" class="b_foot" onClick="window.location.href='f4141.jsp'">             
				</td>
			</tr>
		</table>
<%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html> 