<%@page contentType="text/html;charset=gb2312"%>
<%
	//String[][] result = new String[][]{};
//	 
//	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
//	String[][] baseInfoSession = (String[][])arrSession.get(0);
//	String[][] otherInfoSession = (String[][])arrSession.get(2);
//	
	String workName = "测试人员";
//	String orgCode = baseInfoSession[0][16];
	String workNo = "aa0001";
//	String ip_Addr = request.getRemoteAddr();
//	String org_code = baseInfoSession[0][16];
//	String[][] pass = (String[][])arrSession.get(4);
//	String nopass  = pass[0][0];
//	String regionCode=org_code.substring(0,2);
//	
	String op_name = "工单统计报表";
	String opName = "工单统计报表";
//
//	//yyyyMMdd形式的当前日期
//	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
	
	
	
%>
<html>
<head>
<title><%=op_name%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_image.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_single.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<%@ include file="../../public/head_view_wf.jsp" %>
</head> 
<script language=javascript>
function showtbs1()
{	
	tbs1.style.display="";
	tbs2.style.display="none";
	tbs3.style.display="none";
	tbs4.style.display="none";
	document.all.font1.color='222222';
	document.all.font2.color='999999';
	document.all.font3.color='999999';
	document.all.font4.color='999999';
	//document.form2.reset();
}

//-----显示删除页面--------
function showtbs2()
{	
	tbs1.style.display="none";
	tbs2.style.display="";
	tbs3.style.display="none";
	tbs4.style.display="none";
	document.all.font1.color='999999';
	document.all.font2.color='222222';
	document.all.font3.color='999999';
	document.all.font4.color='999999';
	//document.form1.reset();
	//document.form2.giftclasscode.value="";
}

//-----显示修改页面--------
function showtbs3()
{	
	tbs1.style.display="none";
	tbs2.style.display="none";
	tbs3.style.display="";
	tbs4.style.display="none";
	document.all.font1.color='999999';
	document.all.font2.color='999999';
	document.all.font3.color='222222';
	document.all.font4.color='999999';
	//rescode1();
}

//-----显示查询页面--------
function showtbs4()
{	
	tbs1.style.display="none";
	tbs2.style.display="none";
	tbs3.style.display="none";
	tbs4.style.display="";
	document.all.font1.color='999999';
	document.all.font2.color='999999';
	document.all.font3.color='999999';
	document.all.font4.color='222222';
}
function fsubmit(){
	document.form1.hParams1.value= "PRC_7059_RPT('"+document.form1.workNo.value+"','1','"+document.form1.state.value+"','"+document.form1.state2.value+"'";
    
	document.form1.submit();
}
function fsubmit2()
{
	var work1 = document.form2.work_id1.value;
	var work2 = document.form2.work_id2.value;
	if(work1==""){
		 rdShowMessageDialog("请输入起始工号！");
		 return false;
	}
	if(work2==""){
		 rdShowMessageDialog("请输入结束工号！");
		 return false;
	}
	document.form2.hParams1.value= "PRC_7060_Rpt('"+document.form2.workNo.value+"','2','"+document.form2.work_id1.value+"','"+document.form2.work_id2.value+"'";
    
	document.form2.submit();
}
function fsubmit3()
{
	var b = document.form3.begin;
	var e = document.form3.end;
	if(!compareDate(b,e)){
		return false;
	}
document.form3.hParams1.value= "PRC_7059_Rpt('"+document.form3.workNo.value+"','3','"+document.form3.begin.value+"','"+document.form3.end.value+"'";
    
	document.form3.submit();
	}

function fsubmit4()
{	
	var b = document.form4.begin;
	var e = document.form4.end;
	if(!compareDate(b,e)){
		return false;
	}
	document.form4.hParams1.value= "PRC_7059_Rpt('"+document.form4.workNo.value+"','4','"+document.form4.begin.value+"','"+document.form4.end.value+"'";
    
	document.form4.submit();
}
function compareDate(beginTime,endTime){
	var theTotalDate1="";
	var theTotalDate2="";
  var one="";
  var two="";
  var flag="0123456789";
  for(i=0;i<beginTime.value.length;i++)
  { 
     one=beginTime.value.charAt(i);
     if(flag.indexOf(one)!=-1)
		 theTotalDate1+=one;
  }
   for(i=0;i<endTime.value.length;i++)
  { 
     two=endTime.value.charAt(i);
     if(flag.indexOf(two)!=-1)
		 theTotalDate2+=two;
  }
  if(parseInt(theTotalDate1) > parseInt(theTotalDate2))
		{
			rdShowMessageDialog("结束日期应大于开始日期",0);
			return false;
		}
		return true;
}

</script>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >

		<div id="Operation_Table">	
		<TABLE align=center border=0 cellSpacing=0 cellPadding=0 width="98%" height=20 bgcolor="#FFFFFF">
        	<tr height=20 background="../../images/jl_background_4.gif" style="height=100%">
              	<TD  style="height=100%" width="8%" nowrap><a id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs1()" value="1">&nbsp;&nbsp;
              		<font id="font1" >按订单状态统计&nbsp;&nbsp;</font></a>
              	</TD>    
			  	<TD  style="height=100%" width="8%" nowrap><a id="tabhead2" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs2()" value="1">&nbsp;&nbsp;
			  		<font id="font2" color='222222'>按分配工号统计&nbsp;&nbsp;</font></a>
			  	</TD>		  
			  	<TD  style="height=100%" width="8%" nowrap><a id="tabhead3" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs3()" value="1">&nbsp;&nbsp;
			  		<font id="font3" >按调度时间统计&nbsp;&nbsp;</font></a>
			  	</TD>
              	<TD  style="height=100%" width="8%" nowrap><a id="tabhead4" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs4()" value="1">&nbsp;&nbsp;
              		<font id="font4" >按完成时间统计&nbsp;&nbsp;</font></a>
              	</TD>
            	<td width="68%"></td> 
            </tr> 
		</table>
		
   		<div id=tbs1 style=display="none">
		<TABLE  width=98% height=25 align="center" cellspacing="1" border="0"  bgcolor="#FFFFFF">
		<form name="form1" method="post" action="/page/rpt/print_rpt.jsp">
			<input type="hidden" name="workNo" id="workNo" value="<%=workNo%>">
			 <input type="hidden" name="hDbLogin" value ="dbchange">
			 <input type="hidden" name="hParams1" value="">
			 <input type="hidden" name="hTableName" value="dReportTable">
      <TBODY>
		  <TR bgcolor="#f0f6f8" > 
		  
        	<TD height = 20 align="center">工单状态：&nbsp;&nbsp;
			 <select name="state">
			<%
				for(int i=0;i < 11;i ++){
			%>
				<option value='<%=i%>'><%=i%></option>
			<%
				}
			%>
			</select>
			<input type="hidden" name="state2" value=" ">
			 </TD>	
			 </TR>
      </TBODY>
		</TABLE> 
		<table align=center width="98%" border="0" height="30" bgcolor="#f0f6f8">
			<tr> 
				<td align = center height="30">		
					<input class="button" type="button" name="bSubmit" onClick="if(check(form1)) fsubmit()" value="确定">
					<input class="button" type="button" name="Return1" onClick="back()" value="返回">
				</td>
			</tr>
		</form>
		</table>
   		</div>
		
		
  		<div id=tbs2 style=display="">
		<TABLE  width=98% height=25 align="center" cellspacing="1" border="0"  bgcolor="#FFFFFF" >
		<form name="form2" method="post" action="/page/rpt/print_rpt.jsp">
			<input type="hidden" name="workNo" id="workNo" value="<%=workNo%>">
			 <input type="hidden" name="hDbLogin" value ="dbchange">
			 <input type="hidden" name="hParams1" value="">
			 <input type="hidden" name="hTableName" value="dReportTable">
     	<TBODY>
		<TR bgcolor="#f0f6f8" > 
		<TD height = 20 width="15%">起始工号：</TD>
          <TD height = 20>
			 <input type="text"  name="work_id1" maxlength=15 value="" v_name="起始工号" v_must=1>
			 <font color="#FF0000">*</font>
			 </TD>
			 <TD height = 20 width="15%">结束工号：</TD>
          <TD height = 20>
			 <input type="text" name="work_id2" maxlength=15 value="" v_name="结束工号" v_must=1>
			 <font color="#FF0000">*</font>
			 </TD>
		</TR> 
      </TBODY>
    </TABLE> 
		<table align=center width="98%" border="0" height="30" bgcolor="#f0f6f8">
			<tr> 
				<td align = center height="30">
					<input class="button" type="button" name="bSubmit1" onClick="if(check(form2)) fsubmit2()" value="确定">
					<input class="button" type="button" name="Return2" onClick="back()" value="返回">
				</td>
			</tr>
		</form>
		</table>
  		</div>
  
  		<div id=tbs3 style=display="none">
		<TABLE  width=98% height=25 align="center" cellspacing="1" border="0"  bgcolor="#FFFFFF" >
		<form name="form3" method="post" action="/page/rpt/print_rpt.jsp">
			<input type="hidden" name="workNo" id="workNo" value="<%=workNo%>">
			 <input type="hidden" name="hDbLogin" value ="dbchange">
			 <input type="hidden" name="hParams1" value="">
			 <input type="hidden" name="hTableName" value="dReportTable">
      <TBODY>
        <TR bgcolor="#f0f6f8" > 
        	<TD height = 20 width="15%">起始时间：</TD>
          <TD height = 20 width="35%">
			 <input type="text" v_type="date_time" v_minlength=0 v_maxlength=17 v_name="起始时间" v_must=1 name="begin" maxlength=17 value="">
			 <font color="#FF0000">*</font>(yyyymmdd hh:mm:ss)
			 </TD>					
		<TD height = 20 width="15%">结束时间：</TD>
          <TD height = 20 width="35%">
		   <input type="text"   v_type="date_time" v_minlength=0 v_maxlength=17 v_name="结束时间" v_must=1 name="end" maxlength=17 value="">
	       <font color="#FF0000">*</font>(yyyymmdd hh:mm:ss)
          </TD>
		  </TR>
      </TBODY>
        </TABLE>
		<table align=center width="98%" border="0" height="30" bgcolor="#f0f6f8">
			<tr> 
				<td align = center height="30">		
					<input class="button" type="button" name="bSubmit3" onClick="if(check(form3)) fsubmit3()" value="确定">
					<input class="button" type="button" name="Return3" onClick="back()" value="返回">
				</td>
			</tr>
		</form>
		</table>
		</div>
	
	<div id=tbs4 style=display="none">
			<TABLE  width=98% height=25 align="center" cellspacing="1" border="0"  bgcolor="#FFFFFF" >
				<form name="form4" method="post" action="/page/rpt/print_rpt.jsp">
				<input type="hidden" name="workNo" id="workNo" value="<%=workNo%>">
			 <input type="hidden" name="hDbLogin" value ="dbchange">
			 <input type="hidden" name="hParams1" value="">
			 <input type="hidden" name="hTableName" value="dReportTable">
        <TR bgcolor="#f0f6f8" > 
        	<TD height = 20 width="15%">起始时间：</TD>
          <TD height = 20 width="35%">
			 <input type="text"  v_type="date_time" v_minlength=0 v_maxlength=17 v_name="起始时间" v_must=1 name="begin" maxlength=17 value="">
			 <font color="#FF0000">*</font>(yyyymmdd hh:mm:ss)
			 </TD>					
		<TD height = 20 width="15%">结束时间：</TD>
          <TD height = 20 width="35%">
		   <input type="text"  v_type="date_time" v_minlength=0 v_maxlength=17 v_name="结束时间" v_must=1 name="end" maxlength=17 value="">
	       <font color="#FF0000">*</font>(yyyymmdd hh:mm:ss)
         </TD>
		  </TR>
      </TBODY>
        </TABLE>
		<table align=center width="98%" border="0" height="30" bgcolor="#f0f6f8">
			<tr> 
				<td align = center height="30">		
					<input class="button" type="button" name="bSubmit4" onClick="if(check(form4)) fsubmit4()" value="确定">
					<input class="button" type="button" name="Return4" onClick="back()" value="返回">
				</td>
			</tr>
		</form>
		</table>
		</div>
	</div>		
<%@ include file="../../public/foot.jsp" %>	
</body>
</html>
