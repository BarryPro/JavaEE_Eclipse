<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����ת�Ʋ�����־��ѯ
   * �汾: 1.0
   * ����: 2011-11-11 10:50:20
   * ����: zhangyan
   * ��Ȩ: si-tech
   * update:zhangyan update
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "java.util.Calendar"%>   
<%
String hdword_no =(String)session.getAttribute("workNo");//����
String opCode="e410";
String opName="����ת�Ʋ�����־��ѯ";

SimpleDateFormat sdfToday=new SimpleDateFormat("yyyy-MM-dd");  
Calendar calToday = Calendar.getInstance(); 
String begin_time = sdfToday.format(calToday.getTime())+" 00:00:00";
String end_time = sdfToday.format(calToday.getTime())+" 23:59:59";

SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");   
Calendar lastDate = Calendar.getInstance();    
lastDate.add(Calendar.MONTH,-3);  
String nowSub3m=sdf.format(lastDate.getTime());  	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������BOSS-ҵ���ѯ-����ת�Ʋ�����־��ѯ</title>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<form action="" method=post name="form1">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">����ת�Ʋ�����־��ѯ</div>
</div>
<div>	
	<table cellspacing="0">
	<tr>
		<td class="blue">��ʼʱ��</td>
		<td class="blue">
			<input type = "text" name = "begin_time" id = "begin_time" 
				value = "<%=begin_time%>" readonly>
			<img id = "begin_time_sel" 
				onclick="WdatePicker({el:'begin_time',startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
			 	src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			<font color = "red">*</font>
		</td>
		<td class="blue">����ʱ��</td>
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
		<td class="blue">�ֻ�����</td>
		<td  class="blue">
			<input type = "text" name = "phone_no" id = "phone_no" value = "">
		</td>
		<td class="blue">��������</td>
		<td  class="blue">
			<input type = "text" name = "login_no" id = "login_no" value = "">
		</td>
	</tr>

	<tr>
		<td align=center colspan="4"> 
			<input class="b_foot" name=sure  type=button value=��ѯ onClick="pageSubmit()" >
			<input class="b_foot" name=reset onClick="" type="reset" value="����">
			<input class="b_foot" name=close onClick="removeCurrentTab()" type=button value=�ر�>
		</td>
	</tr>
	</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</div>
<div style="height:380px;overflow: auto" id="divBodyOne">
 	<IFRAME frameBorder=0 id="e410_list" name="e410_list" scrolling="yes"  
 		style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX:1">
	</IFRAME>
</div>	
</form>
</body>
</html>
<%/*-----------------------------javascript��-------------------------------------*/%>
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
			rdShowMessageDialog("��ʼʱ�������д��", 0);
			return false;
		}
		else if (""==end_time_obj.value)
		{
			rdShowMessageDialog("����ʱ�������д" , 0);
			return false;
		}
		else if ( int_begin > int_end)
		{
			rdShowMessageDialog("��ʼʱ�䲻�ܴ��ڽ���ʱ�䣡" , 0);
			return false;			
		}
		else if ( int_begin<nowSub3m )
		{
			rdShowMessageDialog("ֻ�ܲ�ѯ��3����Ȼ���ڵ�����",0);
			return false;
		}
		else
		{
			return true;
		}
	}
	
	function pageSubmit()
	{
		var list_obj = document.e410_list;
		var phone_no_obj = document.getElementById("phone_no");
		var login_no = document.getElementById("login_no");
		var begin_time_obj = document.getElementById("begin_time");
		var end_time_obj = document.getElementById("end_time");

		if ( !checkform ())
		{
			return false;
		}
		
		list_obj.location="fe410_2.jsp?phone_no="+phone_no_obj.value
			+"&login_no="+login_no.value
			+"&begin_time="+begin_time_obj.value
			+"&end_time="+end_time_obj.value;
	}
</script>

