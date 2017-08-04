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
		String opCode = "g807";
		String opName = "校园放号激活返费金额修改";
		String orgCode     = (String)session.getAttribute("orgCode");
		String regionCode  = orgCode.substring(0,2);
		String workno      = (String)session.getAttribute("workNo");
		String workname    = (String)session.getAttribute("workName");
		String nopass      = (String)session.getAttribute("password");

		String[] inParam = new String[2];
		inParam[0]="select region_code,region_name from sregioncode order by region_code asc ";
		
%>
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
		<wtc:param value="<%=inParam[0]%>"/> 
	</wtc:service>
	<wtc:array id="region_arr" scope="end" />
<HTML>
<HEAD>
<script language="JavaScript">
 function inits()
 {
	 //alert("orgCode is "+"<%=orgCode%>"+" and regionCode is "+"<%=regionCode%>");
	 document.getElementById("bygh").style.display="none";
	 document.getElementById("byds").style.display="none";
 }
 function getTj()
 {
	var objSel = document.getElementById("cxtj").value;
	//alert(objSel);
	if(objSel==1)
	{
		//alert("01");
		document.getElementById("bygh").style.display="block";
		document.getElementById("byds").style.display="none";
	}
	else if(objSel==2)
	{
		//alert("11");
		document.getElementById("bygh").style.display="none";
		document.getElementById("byds").style.display="block";
	}
	else
	{
		//alert("111");
		document.getElementById("bygh").style.display="none";
		document.getElementById("byds").style.display="none";
	}
 }
 function docheck()
 {
	var pzds = document.getElementById("pzds").value;//0请选择
	var cxtj = document.getElementById("cxtj").value;//0请选择 1工号 2地市
	var pzgh = document.all.s_login_no.value;//配置工号
	//alert("pzds is "+pzds+" and cxtj is "+cxtj);	
	if(cxtj=="0")
	{
		rdShowMessageDialog("请选择查询条件！");
		return false;
	}
	else if(cxtj=="1")//工号
	{
		//这个还加判断 地市是否ok
		if(pzgh=="")
		{
			rdShowMessageDialog("请输入配置工号！");
			return false;
		}
		else
		{
			document.frm.action="g807_2.jsp?pzgh="+pzgh+"&flag=1";
			document.frm.submit();
		}
	}
	else
	{
		if(pzds=="0")
		{
			rdShowMessageDialog("请选择配置地市！");
			return false;
		}
		else
		{
			document.frm.action="g807_2.jsp?pzds="+pzds+"&flag=2";
			document.frm.submit();
		}
	}
	/*
	if(cxtj=="0")
	{
		rdShowMessageDialog("请选择查询条件！");
		return false;
	}
	else if(pzds=="0" &&cxtj=="2")
	{
		rdShowMessageDialog("请选择配置地市！");
		return false;
	}
	else
	{
		
		document.frm.action="g807_2.jsp";
		document.frm.submit();
	}
	*/
 }
  
 
 


 
 
  function doclear() {
 		frm.reset();
 }


 



-->
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">请选择查询条件</div>
		</div>
	<table cellspacing="0">
    
	<tr > 
      <td class="blue">查询条件 </td>
      <td  colspan=3>
        <select id="cxtj" name="cxtjname" onchange="getTj()">
			<option value=0>---请选择</option>
			<option value=1>按工号查询</option>
			<option value=2>按地市查询</option>
		</select>
      </td>
     
      
    </tr>
	 
		<tr id="bygh"> 
		  <td class="blue"  >配置工号</td>
		  <td> 
			<input class="button"type="text" name="s_login_no" size="20" maxlength="12"   >
		  </td>
		  
		  
		</tr>
 
	
	 
		<tr id="byds"> 
		   
		  <td class="blue">配置地市</td>
		  <td > 
			<select id="pzds" name="pzdsname">
				<option value="0" selected>--请选择</option>
				<%
				for(int i=0; i<region_arr.length; i++)
				{%>
					<option value="<%=region_arr[i][0]%>">
					
					<%=region_arr[i][0]%>--><%=region_arr[i][1]%></option>
					<%
				}%>
			</select>
		  </td>
		  
		</tr>
 

	

  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="查询" onclick="docheck()" >
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