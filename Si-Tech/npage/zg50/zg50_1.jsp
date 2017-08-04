<%
/********************
 version v2.0
开发商: si-tech
*
*add :huangqi IMS项目新增的 sFixCodeNew 表，配置界面
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
		String opCode = "zg50";
		String opName = "sFixCodeNew号段配置";
		String orgCode     = (String)session.getAttribute("orgCode");
		String regionCode  = orgCode.substring(0,2);
		String workno      = (String)session.getAttribute("workNo");
		String workname    = (String)session.getAttribute("workName");
		String nopass      = (String)session.getAttribute("password");
		String[] inParas2 = new String[2];
		inParas2[0]="select to_char(d.region_name)  from dloginmsg a ,dchngroupinfo b ,schnregionlist c ,sregioncode d where a.group_id = b.group_id and b.parent_group_id = c.group_id and c.group_id = d.group_id and a.login_no = :login_no";
		inParas2[1]="login_no="+workno;
		String reginName="";
%>
	<wtc:service name="TlsPubSelCrm" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />
		
<%
	if(ret_val!=null&&ret_val.length>0)
	{
		reginName = ret_val[0][0];
	}
%>

<HTML>
<HEAD>
<script language="JavaScript">
 function inits()
 {
	 //alert("orgCode is "+"<%=orgCode%>"+" and regionCode is "+"<%=regionCode%>");
	 document.getElementById("configType").value="0";
 }
 
 //根据configType的选择来展示不同table
function checkConfigType(configType){
	if("2"==configType){
		document.getElementById("dantiao").style.display="none";
		document.getElementById("piliang").style.display="block";
	}
	else if("1"==configType){
		document.getElementById("dantiao").style.display="block";
		document.getElementById("piliang").style.display="none";
	}	
	document.all.haoduan.value="";
	document.all.hdStart.value="";
	document.all.hdEnd.value="";
		document.all.note.value="";
	
}
 function docheck()
 {
 var configType=document.getElementById("configType");
// 	alert(configType.value);
 	if(configType.value==0)
	{
		rdShowMessageDialog("请选择配置类型！");
		return false;
	}
	
	if(configType.value=="1"){
			var s_login_no =  document.all.s_login_no.value;
			var haoduan = document.all.haoduan.value;
			if(haoduan=="")
			{
				rdShowMessageDialog("请输入号段！");
				document.all.haoduan.focus();
				return false;
			}else
			{
				document.frm.action="zg50_2.jsp";
			 	document.frm.submit();
			}
	}else if(configType.value=="2"){
			var s_login_no =  document.all.s_login_no.value;
			var hdStart = document.all.hdStart.value;
			var hdEnd = document.all.hdEnd.value;
			var hdStartStr=hdStart.substring(0,6);
			var hdEndStr=hdEnd.substring(0,6);
			var endno=new Number(hdEnd);
			var startno=new Number(hdStart);
			if(hdStart=="")
			{
				rdShowMessageDialog("请输入起始号段！");
				document.all.hdStart.focus();
				return false;
			}else if(hdEnd=="")
			{
				rdShowMessageDialog("请输入结束号段！");
				document.all.hdEnd.focus();
				return false;
			}else if(hdEndStr!=hdStartStr)
			{
				rdShowMessageDialog("起始号段前六位必须与结束号段前六位一致！");
				document.all.hdSrart.focus();
				return false;
			}else if(startno>endno)
			{
				rdShowMessageDialog("结束号段的数值必须大于起始号段！");
				document.all.hdEnd.focus();
				return false;
			}else
			{
				document.frm.action="zg50_2.jsp";
			 	document.frm.submit();
			}
	}

 
 }
 
  function doclear() {
 		frm.reset();
 }

 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">请输入号段</div>
		</div>
	<table cellspacing="0">
	

		<tr>
			<td class="blue" >配置类型</td>
      <td colspan=5> 
        <select id="configType" name="configType" onchange="checkConfigType(this.value)">
					<option value="0" selected>--请选择</option>
					<option value="1" >号段单个配置</option>
					<option value="2" >号段批量配置</option>
				</select> 
      </td>
    </tr>
<TBody id="dantiao">
	<tr >
		<td class="blue">号段</td>
      <td> 
        <input type="text" name="haoduan" size="20" maxlength="9" onKeyPress="return isKeyNumberdot(1)" >
      </td>
      	<td class="blue"></td>
      		<td></td>
	</tr>
</TBody>
<TBody id="piliang" style="display:none;">
<tr >
		<td class="blue">起始号段</td>
      <td> 
        <input type="text" name="hdStart" size="20" maxlength="9" onKeyPress="return isKeyNumberdot(1)" >
      </td>
    <td class="blue">结束号段</td>
       <td> 
        <input type="text" name="hdEnd" size="20" maxlength="9" onKeyPress="return isKeyNumberdot(1)" >
      </td>
	</tr>
</TBody>
<tr >
		<td class="blue">工文名</td>
      <td colspan=5> 
        <input type="text" name="note" size="50" maxlength="128"  >
      </td>
	</tr>
<tr >
      <td class="blue" width="15%">配置工号</td>
      <td> 
        <input class="button"type="text" name="s_login_no" size="20" maxlength="12"  value="<%=workno%>" readonly >
      </td>
      <td class="blue">配置地市</td>
      <td colspan=3> 
      	  <input class="button" type="text" name="pzdsname" size="20" maxlength="12"  value="<%=reginName%>" readonly >
      </td>
      
    </tr>
  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="确认" onclick="docheck()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="重置" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>