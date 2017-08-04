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
		String opCode = "g138";
		String opName = "集团客户欠费视图";
		String[] inParas2 = new String[3];
		inParas2[0]="select distinct sm_code,sm_name from ssmcode";
		inParas2[1]="select distinct region_code,region_name from sregioncode";
		inParas2[2]="select distinct owner_code,owner_name from sgrpownercode";
		
%>
<wtc:service name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=inParas2[0]%>"/> 	
	</wtc:service>
<wtc:array id="ret_val" scope="end" />

<wtc:service name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=inParas2[1]%>"/> 	
	</wtc:service>
<wtc:array id="ret_region" scope="end" />

<wtc:service name="TlsPubSelCrm"   retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=inParas2[2]%>"/> 	
	</wtc:service>
<wtc:array id="ret_client" scope="end" />

<HTML>
<HEAD>
<script language="JavaScript">
<!--	


 

 function docheck()
 {
	
 
	  if(document.frm.min_ym.value==""  )
	  {
			rdShowMessageDialog("请输入欠费年月!");
			document.frm.min_ym.focus();
			return false;
	  }
	  var i_len=document.frm.min_ym.value-"201210";
	  //alert("i_len is "+i_len);
	  if(i_len<0)
	  {
		  rdShowMessageDialog("查询年月必须是201210以后!");
		  return false;
	  }	
	  var objSel_region = document.getElementById("region_type");
	  var region_sel=objSel_region.value;
	  var objSel_sm = document.getElementById("sm_type");
	  //var sm_sel=objSel_sm.value;
	  var sm_sel= objSel_sm.options(objSel_sm.selectedIndex).text;
	  var objSel_client = document.getElementById("client_type");
	  var client_sel=objSel_client.value;
	//  alert("region_sel is "+region_sel+" and sm_sel is "+sm_sel+" and client_sel is "+client_sel); 
		 
	   document.frm.action="g138_2.jsp?min_ym="+document.frm.min_ym.value+"&region_value="+region_sel+"&sm_value="+sm_sel+"&client_value="+client_sel;
 
	   document.frm.submit();
 
	 
 } 
 
 


 
 
  function doclear() {
 		frm.reset();
 }

 


-->
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">请输入查询条件</div>
		</div>
	<table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">地市</td>
      <td> 
        <select id="region_type">
			 
			<%for(int i=0; i<ret_region.length; i++){%>
			<option value="<%=ret_region[i][0]%>">
			
			<%=ret_region[i][0]%>--><%=ret_region[i][1]%></option>
			<%}%>
 
		 </select>
      </td>
      <td class="blue">欠费月(YYYYMM)</td>
      <td> 
        <input type="text" name="min_ym" size="6" maxlength="6" onKeyPress="return isKeyNumberdot(0)" value="201210" ><font color=red>*</font>
      </td>
       
    </tr>
	<tr>
		<td class="blue">产品类型</td>
      <td> 
        <select id="sm_type">
			<option value="0" selected>-->请选择</option> 
			<%for(int i=0; i<ret_val.length; i++){%>
			<option value="<%=ret_val[i][0]%>">
			
			 <%=ret_val[i][1]%></option>
			<%}%>
 
		 </select>
      </td>
       <td class="blue">客户级别</td>
      <td> 
        <select id="client_type">
			 <option value="0" selected>-->请选择</option>
			 <%for(int i=0; i<ret_client.length; i++){%>
			<option value="<%=ret_client[i][0]%>">
			
			<%=ret_client[i][0]%>--><%=ret_client[i][1]%></option>
			<%}%>
		</select>
      </td>
	</tr>

	 


  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="查询" onclick="docheck()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
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