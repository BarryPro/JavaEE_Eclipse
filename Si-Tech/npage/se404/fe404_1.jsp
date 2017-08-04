<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 垃圾信息举报查询
   * 版本: 1.0
   * 日期: 2011-11-8 8:15:06
   * 作者: zhangyan
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "java.util.Calendar"%>   

<%
String hdword_no =(String)session.getAttribute("workNo");//工号
String opCode="e404";
String opName="垃圾信息举报查询";
String phoneNo = (String)request.getParameter("activePhone");

SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");   
Calendar lastDate = Calendar.getInstance();    
lastDate.add(Calendar.MONTH,-3);  
String nowSub3m=sdf.format(lastDate.getTime());  
String sqlOpType="select t.msg_code , t.msg_code ||'-->'||t.msg from sshortmsgmodel t "
	+"where t.op_code = '5432'  ";
	
SimpleDateFormat sdfToday=new SimpleDateFormat("yyyy-MM-dd");  
Calendar calToday = Calendar.getInstance(); 
String begin_time = sdfToday.format(calToday.getTime())+" 00:00:00";
String end_time = sdfToday.format(calToday.getTime())+" 23:59:59";

System.out.println( "sqlOpType==========================================="+sqlOpType );

%>

<wtc:pubselect name="sPubSelect" outnum="2">
	<wtc:sql><%=sqlOpType%></wtc:sql>
</wtc:pubselect>
<wtc:array id="opTypeArr" scope="end" />
			
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>黑龙江BOSS-业务查询－垃圾信息举报查询</title>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<form action="" method=post name="form1">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">垃圾信息举报查询</div>
</div>
<div>
	<table cellspacing="0">
	
	<tr>
		<td class="blue">开始时间</td>
		<td class="blue">
			<input type = "text" name = "begin_time" id = "begin_time" 
				value = "<%=begin_time%>" readonly>
			<img id = "begin_time_sel" 
				onclick="WdatePicker({el:'begin_time',startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
			 	src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			<font color = "red">*</font>
		</td>
		<td class="blue">结束时间</td>
		<td class="blue">
			<input type = "text" name = "end_time" id = "end_time" 
				value = "<%=end_time%>" readonly>
			<img id = "end_time_sel" 
				onclick="WdatePicker({el:'end_time',startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
			 	src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			<font color = "red">*</font>
		</td>
	</tr>	
	<tr>
		<td class="blue">受理号码</td>
		<td  class="blue">
			<input type = "text" name = "phone_no" id = "phone_no" value = "">
		</td>
		<td class="blue">被举报号码</td>
		<td  class="blue">
			<input type = "text" name = "phone_no_pos" id = "phone_no_pos" value = "">
		</td>
	</tr>
	<tr>
		<td class="blue">举报工号</td>
		<td class="blue">	
			<input type = "text" name = "login_no" id = "login_no" value = "">
		</td>
		<td class="blue">举报类型</td>
		<td class="blue">
			<select name = "op_type" id = "op_type"  style="width:420px;">
				<option value = "" >---请选择---</option>
				<%
				for ( int i = 0 ; i < opTypeArr.length ; i ++ )
				{
				%>
					<option value = "<%=opTypeArr[i][0]%>" ><%=opTypeArr[i][1]%></option>	
				<%
				}
				%>

			</select>	
		</td>
	</tr>

	<tr>
		<td align=center colspan="4"> 
			<input class="b_foot" name=sure  type=button value="查询" onClick="pageSubmit()" >
			<input class="b_foot" name=reset onClick="" type="reset" value="重置">
			<input class="b_foot" name=close onClick="removeCurrentTab()" type=button value=关闭>
		</td>
	</tr>
	</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</div>
<div style="height:380px;overflow: auto" id="divBodyOne">
 	<IFRAME frameBorder=0 id="e404_list" name="e404_list" scrolling="yes"  
 		style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX:1">
	</IFRAME>
</div>	
</form>
</body>
</html>
<%/*-----------------------------javascript区-------------------------------------*/%>
<script language="javascript">
	
	function checkform()
	{
		var 	begin_time_obj = document.getElementById("begin_time");
		var 	end_time_obj = document.getElementById("end_time");
		var	int_begin=begin_time_obj.value.replace(/\-|\:|\s/g , "");
		var	int_end=end_time_obj.value.replace(/\-/g , "").replace( /\:/g,"" ).replace(" ","");
		var nowSub3m = "<%=nowSub3m%>".replace(/\s|\:|\-/g,"");

		if (""==begin_time_obj.value)
		{
			rdShowMessageDialog("开始时间必须填写！", 0);
			return false;
		}
		else if (""==end_time_obj.value)
		{
			rdShowMessageDialog("结束时间必须填写！" , 0);
			return false;
		}
		else if ( int_begin > int_end)
		{
			rdShowMessageDialog("开始时间不能大于结束时间！" , 0);
			return false;			
		}
		else if ( int_begin<nowSub3m )
		{
			rdShowMessageDialog("只能查询近3个自然月内的数据！",0);
			return false;
		}
		else
		{
			return true;
		}
	}
	
	function pageSubmit()
	{
		var list_obj = document.e404_list;
		var phone_no_obj = document.getElementById("phone_no");
		var phone_no_pos_obj = document.getElementById("phone_no_pos");
		var login_no_obj = document.getElementById("login_no");
		var op_type_obj = document.getElementById("op_type");
		var begin_time_obj = document.getElementById("begin_time");
		var end_time_obj = document.getElementById("end_time");
		
		if ( !checkform ())
		{
			return false;
		}
		
		list_obj.location="fe404_2.jsp?phone_no="+phone_no_obj.value
			+"&phone_no_pos="+phone_no_pos_obj.value
			+"&login_no="+login_no_obj.value
			+"&op_type="+op_type_obj.value
			+"&begin_time="+begin_time_obj.value
			+"&end_time="+end_time_obj.value;
	}
</script>



