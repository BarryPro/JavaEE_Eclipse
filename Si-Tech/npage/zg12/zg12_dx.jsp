<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
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
String opCode = "zg12";
String opName = "增值税专票开具申请";
String workno = (String)session.getAttribute("workNo");
String contextPath = request.getContextPath();

String[] inParas_dx = new String[2]; 
//购方名称 tax_id 流水 操作时间 产品号码
//查询 近两个月的记录
//增加s_type_flag判断 !=4 
inParas_dx[0]="select tax_name,phone_no,begin_dt,end_dt, to_char(login_accept),to_char(op_time,'YYYYMMDD hh24:mi:ss'),to_char(xf_info) from dinvoice_tax_sp where spr=:s_no and to_char(op_time,'YYYYMM')>=to_char(add_months(sysdate,-1),'yyyymm') and  s_type_flag !=4 order by op_time desc";
inParas_dx[1]="s_no="+workno;
%> 
<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="15004675829"  retcode="retCodeims" retmsg="retMsgims" outnum="7">
	<wtc:param value="<%=inParas_dx[0]%>"/>
	<wtc:param value="<%=inParas_dx[1]%>"/>	
</wtc:service>
<wtc:array id="ret_ims" scope="end" />
<HTML>
<HEAD>
<script language="JavaScript">
 function doclear() {
 		frm.reset();
 }


 function inits()
 {
	 //document.getElementById("query_id").disabled=true;
 }
 function sel1()
 {
	window.location.href='zg12_1.jsp';
 }
 function sel2()
 {
	 window.location.href='zg12_tax.jsp';
 }
 function doQry(phone_no)
 {
	document.frm.action="zg12_2_new.jsp?login_accept="+phone_no;
	//alert("test?"+document.frm.action);
	document.frm.submit();
 }
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
<%@ include file="/npage/include/header.jsp" %>   
   
 
  
  <table cellSpacing="0">	 
	 <tr>
		<td><b>购方纳税人名称</b></td>
		<td><b>产品号码</b></td>
		<td><b>专票开具申请开始年月</b></td>
		<td><b>专票开具申请结束年月</b></td>
		<td><b>业务流水</b></td>
		<td><b>销方账号</b></td>
		<td><b>操作时间</b></td>
		<td><b>操作</b></td>
	 </tr>
		<%
			
			for(int i=0;i<ret_ims.length;i++)
			{
				%>
					<tr>
						<td><%=ret_ims[i][0]%></td>
						<td><%=ret_ims[i][1]%></td>
						<td><%=ret_ims[i][2]%></td>
						<td><%=ret_ims[i][3]%></td>
						<td><%=ret_ims[i][4]%></td>
						<td><%=ret_ims[i][6]%></td>
						<td><%=ret_ims[i][5]%></td>
						<td><input type="button" name="qry" value="查询" onclick="doQry('<%=ret_ims[i][4]%>')"></td>
					</tr>
				<%
			}
		%>	
	 
<input type="hidden" name="tax_contract_no">
<input type="hidden" name="tax_name">
<input type="hidden" name="tax_no1">
<input type="hidden" name="tax_address">
<input type="hidden" name="tax_phone">
<input type="hidden" name="tax_khh">
  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
 
	  <input type="button" id="back_id" name="back" class="b_foot" value="返回" onclick="window.location.href='zg12_1.jsp'" >
 
	  <input type="button" id="query_id" name="query" class="b_foot" value="查询" onclick="doQry()" >
          &nbsp;
		    <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
	  <!--
	  <input type="button" id="test" name="test" class="b_foot" value="测试展示pay_note" onclick="do_paynote()" >
	  <input type="button" id="query_id" name="export" class="b_foot" value="javabeantest" onclick="doTest()" >
		   <input type="button" id="query_id" name="export" class="b_foot" value="导出" onclick="doExport()" >	
		   <input type="button" id="imp_id" name="import" class="b_foot" value="导入" onclick="doImport()" >	
           <input type="button" id="query_id" name="query" class="b_foot" value="查询" onclick="docheck()" >
          &nbsp;
		    <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
			  -->
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>