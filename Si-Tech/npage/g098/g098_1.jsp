<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 赠送预存款 8379
   * 版本: 1.0
   * 日期: 2010/3/12
   * 作者: sunaj
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>投诉退费统计查询</title>
<%
  //String opCode="8379";
 //String opName="赠送预存款";
	
    String opCode="g098"; 
	String opName="拆包信息查询";	
 
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
	//activePhone = request.getParameter("activePhone");
	
		//2011/6/23 wanghfa添加 对密码权限整改 start
  boolean pwrf=false;
	String pubOpCode = opCode;
	String pubWorkNo = (String)session.getAttribute("workNo");
	String phoneNo = (String)request.getParameter("activePhone");
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
	System.out.println("====wanghfa====f7123.jsp==== pwrf = " + pwrf);
	//2011/6/23 wanghfa添加 对密码权限整改 end
%>
<%
  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();
  String date1="";
  String date2="";
  String date_now="";
  String[] inParas2 = new String[1];
  inParas2[0]="select to_char(add_months(to_date(to_char(sysdate,'YYYYMM'),'YYYYMM'),-1),'YYYYMM'),to_char(add_months(to_date(to_char(sysdate,'YYYYMM'),'YYYYMM'),-6),'YYYYMM'),to_char(sysdate,'YYYYMMDD') from dual";
	
  String[] inParas2_now = new String[1];
  inParas2_now[0]="select to_char(trunc(add_months(last_day(sysdate), -1) + 1), 'yyyymmdd') from dual ";
  String date_dy="";	 
%>
 <wtc:service name="TlsPubSelBoss"  outnum="1" >
			<wtc:param value="<%=inParas2_now[0]%>"/>
		</wtc:service>
		<wtc:array id="sid_date" scope="end" />
 <%
	date_dy=sid_date[0][0];
	
 %>
	<wtc:service name="TlsPubSelBoss"  retcode="retCode1" retmsg="retMsg1" outnum="3">
		<wtc:param value="<%=inParas2[0]%>"/>
	</wtc:service>
	<wtc:array id="dateRet" scope="end" /> 
<%
	date1=dateRet[0][0];
	date2=dateRet[0][1];
	date_now=dateRet[0][2];
	//date_now="20130401";
	 

%> 
<script language="javascript">//alert("tets  date1 is "+"<%=date1%>"+" and date2 is "+"<%=date2%>");</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</head>  
<body>
<form action="" name="frm" method="POST">
 	<input type="hidden" name="opcode" value = "g098" >
	<input type="hidden" name="opname" value = "拆包信息查询" >
	<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">拆包信息查询</div>
</div>	 
	<table cellspacing="0" id="tabList">
	   
	   <tr >
			<td class="blue"  colspan=3>
				手机号码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="tfhm" maxlength=11 value="<%=phoneNo%>"  > 
			  </td>
		</tr>
		 
		<tr >
			<%
				if(date_now==date_dy ||date_now.equals(date_dy))
				{
					%>
					<td class="blue" >
						查询开始时间<input type="text" name="beginYm" value="<%=date1%>" maxlength=6 onKeyPress="return isKeyNumberdot(0)"  >(YYYYMM)
					</td>
					<td class="blue" >
						查询结束时间<input type="text" name="endYm" value="<%=date1%>" maxlength=6 onKeyPress="return isKeyNumberdot(0)" >(YYYYMM)
						<input type="hidden" name="date_now" value="<%=date_now%>">
					</td>
					<%
				}
				else
				{
					%>
					<td class="blue" >
						查询开始时间<input type="text" name="beginYm" value="<%=date2%>" maxlength=6 onKeyPress="return isKeyNumberdot(0)">(YYYYMM)
					</td>
					<td class="blue" >
						查询结束时间<input type="text" name="endYm" value="<%=date1%>" maxlength=6 onKeyPress="return isKeyNumberdot(0)">(YYYYMM)
						<input type="hidden" name="date_now" value="<%=date_now%>">
					</td>
					<%
				}
			%>
			
		</tr>
		 
	  <input type="hidden" name="password"/>
		<tr >
			<td align=center colspan=2><input type=button class="b_foot" name="check2" value="查询" id="cz" onclick="docfm()" >
			<!--
			<input type=button class="b_foot" value="生成报表" onclick="printTable(tabList)" >
			-->
			
			<input type=reset class="b_foot" value="重置" >
			</td>
		<tr>
		</tr>
		
	</table>
</div>
 
 
 
</table>
 
 
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<script language="javascript">
  //onload=function()
  function onloads()
  {
  //2010-7-21 14:05 wanghfa添加 密码框使用新的单密码框 start
  	if ("true" == "<%=pwrf%>") {
  	 	document.all.chief_cus_pass.disabled = true;
  	 	document.all.cus_pass.disabled = true;
  		document.all.cus_pass_button[0].disabled = true;
  		document.all.cus_pass_button[1].disabled = true;
  	} else if ("false" == "<%=pwrf%>") {
  	 	document.all.chief_cus_pass.disabled = false;
  	 	document.all.cus_pass.disabled = false;
  		document.all.cus_pass_button[0].disabled = false;
  		document.all.cus_pass_button[1].disabled = false;
  	}
  //2010-7-21 14:05 wanghfa添加 密码框使用新的单密码框 start
      document.all.chief_srv_no.focus();
  	document.all.opFlag.value= "one";
  	document.all.member_id.style.display="none";
  }
	
	 
	function docfm()
	{
		var beginYm = document.all.beginYm.value;
		 
		var endYm = document.all.endYm.value;

		var nowYm = document.all.date_now.value;

		var tfhm = document.all.tfhm.value;
		 
		if(tfhm=="")
		{
			rdShowMessageDialog("请输入查询号码");
			return false;
		}
		/*
		if(document.frm.cus_pass.value=="")
		{
			rdShowMessageDialog("请输入用户密码!");
			return false;
		}*/
		//alert(endYm+" and "+nowYm);
		if(endYm>=nowYm)
	    {
			rdShowMessageDialog("查询月份不可超过当月!");
			return false;
		}
		//document.frm.password.value=document.frm.cus_pass.value;
		  var year1 =  beginYm.substr(0,4);
		  var year2 =  endYm.substr(0,4); 
		  var month1 = beginYm.substr(4,2);
		  var month2 = endYm.substr(4,2);
		  
		  var len=(year2-year1)*12+(month2-month1)+1;
		  //alert(len);
		  if(len>6)
		  {
			  rdShowMessageDialog("只可以查询6个月内的记录！");
			  return false;
		  }
		var actions = "g098_2.jsp?beginYm="+beginYm+"&endYm="+endYm+"&tfhm="+tfhm;
		document.all.frm.action=actions;
		document.all.frm.submit();
			
		 
		
		
	}

 

</script>
 
 