<%
/********************
 version v2.0
������: si-tech
*
*liuxmc
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String org_code = (String)session.getAttribute("orgCode");
		String [] inParas = new String[2];
		String return_code="";
		String ret_msg="";
		String return_page = "g636_1.jsp";
		String region_code = request.getParameter("region_code").trim();
		String ilevel = request.getParameter("ilevel").trim();
		String begin_ymdh = request.getParameter("begin_ymdh").trim();
		String end_ymdh = request.getParameter("end_ymdh").trim();
		inParas[0]="SELECT REGION_CODE,to_char(ILEVEL),begin_ymdh,end_ymdh,HOLIDAY_NAME,LOGIN_NO,OP_TIME,OP_NOTE FROM CHOLIDAY_UNSTOP_NEW WHERE region_code=:region_code and ILEVEL=:ilevel and BEGIN_ymdh=:begin_ymdh and END_ymdh=:end_ymdh ";
    inParas[1]="region_code="+region_code+",ilevel="+ilevel+",begin_ymdh="+begin_ymdh+",end_ymdh="+end_ymdh;
		String opCode = "g636";
		String opName = "�ڼ����޸�";
	  String sqlStr1 = "select region_code,region_name from sregioncode where region_code = '"+region_code+"'";

%>
<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="return_msg1" retcode="return_code1">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		  </wtc:pubselect>
<wtc:array id="return_result1" scope="end"/>	
	
<wtc:service name="TlsPubSelBoss"   retcode="retCode" retmsg="retMsg" outnum="10">
			<wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>	
		</wtc:service>
<wtc:array id="tempArr" scope="end"/> 
<%
   String region_options ="<option value=>--��ѡ��--</option>";

   for(int i=0;i<return_result1.length;i++)
   {
      region_options += "<option value="+return_result1[i][0]+">"+return_result1[i][1]+"</option>";
   }
   
   String begin_year = begin_ymdh.substring(0, 4);
   String begin_month = begin_ymdh.substring(4, 6);
   String begin_day = begin_ymdh.substring(6, 8);
   String begin_hour = begin_ymdh.substring(8, 10);
   
   System.out.println("begin_year=" + begin_year + ",begin_month=" + begin_month + ",begin_day=" + begin_day + ",begin_hour=" + begin_hour);
   
   String end_year = end_ymdh.substring(0, 4);
   String end_month = end_ymdh.substring(4, 6);
   String end_day = end_ymdh.substring(6, 8);
   String end_hour = end_ymdh.substring(8, 10);
   
   System.out.println("end_year=" + end_year + ",end_month=" + end_month + ",end_day=" + end_day + ",end_hour=" + end_hour);
   
   /**** update by zhangleij 2016-02-15 �����Ǽ��ͻ��ڼ�����ͣ��ǰ̨�����Ż������� begin ****/
   String currYear=new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime());
   int nextYear = Integer.parseInt(currYear) + 1;
   int nextTwoYear = Integer.parseInt(currYear) + 2;
   String year_options = "<option value="+currYear+">"+currYear+"</option>"+
   											"<option value="+nextYear+">"+nextYear+"</option>"+
   											"<option value="+nextTwoYear+">"+nextTwoYear+"</option>";
   String month_options = "<option value='01'>01</option>"+
   												"<option value='02'>02</option>"+
   												"<option value='03'>03</option>"+
   												"<option value='04'>04</option>"+
   												"<option value='05'>05</option>"+
   												"<option value='06'>06</option>"+
   												"<option value='07'>07</option>"+
   												"<option value='08'>08</option>"+
   												"<option value='09'>09</option>"+
   												"<option value='10'>10</option>"+
   												"<option value='11'>11</option>"+
   												"<option value='12'>12</option>";
   String day_options = "<option value='01'>01</option>"+
   											"<option value='02'>02</option>"+
   											"<option value='03'>03</option>"+
   											"<option value='04'>04</option>"+
   											"<option value='05'>05</option>"+
   											"<option value='06'>06</option>"+
   											"<option value='07'>07</option>"+
   											"<option value='08'>08</option>"+
   											"<option value='09'>09</option>"+
   											"<option value='10'>10</option>"+
   											"<option value='11'>11</option>"+
   											"<option value='12'>12</option>"+
   											"<option value='12'>12</option>"+
   											"<option value='13'>13</option>"+
   											"<option value='14'>14</option>"+
   											"<option value='15'>15</option>"+
   											"<option value='16'>16</option>"+
   											"<option value='17'>17</option>"+
   											"<option value='18'>18</option>"+
   											"<option value='19'>19</option>"+
   											"<option value='20'0>20</option>"+
   											"<option value='21'>21</option>"+
   											"<option value='22'>22</option>"+
   											"<option value='23'>23</option>"+
   											"<option value='24'>24</option>"+
   											"<option value='25'>25</option>"+
   											"<option value='26'>26</option>"+
   											"<option value='27'>27</option>"+
   											"<option value='28'>28</option>"+
   											"<option value='29'>29</option>"+
   											"<option value='30'>30</option>"+
   											"<option value='31'>31</option>";
   String hour_options = "<option value='00'>00</option>"+
   											"<option value='01'>01</option>"+
   											"<option value='02'>02</option>"+
   											"<option value='03'>03</option>"+
   											"<option value='04'>04</option>"+
   											"<option value='05'>05</option>"+
   											"<option value='06'>06</option>"+
   											"<option value='07'>07</option>"+
   											"<option value='08'>08</option>"+
   											"<option value='09'>09</option>"+
   											"<option value='10'>10</option>"+
   											"<option value='11'>11</option>"+
   											"<option value='12'>12</option>"+
   											"<option value='12'>12</option>"+
   											"<option value='13'>13</option>"+
   											"<option value='14'>14</option>"+
   											"<option value='15'>15</option>"+
   											"<option value='16'>16</option>"+
   											"<option value='17'>17</option>"+
   											"<option value='18'>18</option>"+
   											"<option value='19'>19</option>"+
   											"<option value='20'0>20</option>"+
   											"<option value='21'>21</option>"+
   											"<option value='22'>22</option>"+
   											"<option value='23'>23</option>";
   											String tV = "02";
   /**** update by zhangleij 2016-02-15 �����Ǽ��ͻ��ڼ�����ͣ��ǰ̨�����Ż������� end ****/
%>
<HTML>
<HEAD>
<script language="JavaScript">

function commit(){
	
  if(document.frm.region_code.value =="")  {
     rdShowMessageDialog("��ѡ���������!");
     document.frm.region_code.value = "";
     document.frm.region_code.focus();
     return false;
  }
	
  if(document.frm.level.value=="")  {
     rdShowMessageDialog("������ͻ��ȼ�!");
     document.frm.level.value = "";
     document.frm.level.focus();
     return false;
  }
	
  if(document.frm.level.value < 3)  {
     rdShowMessageDialog("�ͻ��ȼ�Ϊ3��7��������������!");
     document.frm.level.value = "";
     document.frm.level.focus();
     return false;
  }
	
  if(document.frm.level.value > 7)  {
     rdShowMessageDialog("�ͻ��ȼ�Ϊ3��7��������������!");
     document.frm.level.value = "";
     document.frm.level.focus();
     return false;
  }
	
  if(document.frm.holiday_name.value=="")  {
     rdShowMessageDialog("�������������!");
     document.frm.holiday_name.value = "";
     document.frm.holiday_name.focus();
     return false;
  }
	
  if(document.frm.op_note.value=="")  {
     rdShowMessageDialog("���������˵��!");
     document.frm.op_note.value = "";
     document.frm.op_note.focus();
     return false;
  }
 
 /************************************************/
  
 /**** update by zhangleij 2016-02-15 �����Ǽ��ͻ��ڼ�����ͣ��ǰ̨�����Ż������� begin ****/
  if(document.frm.begin_year.value > document.frm.end_year.value) {
     rdShowMessageDialog("��ʼʱ����ݲ��ܴ��ڽ���ʱ�����!");
     return false;
  }
  
  if(document.frm.begin_year.value == document.frm.end_year.value) {
  	if(document.frm.begin_month.value > document.frm.end_month.value) {
  		rdShowMessageDialog("��ʼʱ���·ݲ��ܴ��ڽ���ʱ���·�!");
  		return false;
  	}
  }
  
  if(document.frm.begin_year.value == document.frm.end_year.value) {
  	if(document.frm.begin_month.value == document.frm.end_month.value) {
  		if(document.frm.begin_day.value > document.frm.end_day.value) {
  			rdShowMessageDialog("��ʼʱ�����ڲ��ܴ��ڽ���ʱ������!");
  			return false;
  		}
  	}
  }
  
  if(document.frm.begin_month.value == "02") {
  	if((document.frm.begin_year.value%4==0 && document.frm.begin_year.value%100!=0)||(document.frm.begin_year.value%100==0 && document.frm.begin_year.value%400==0)) {
  		if(document.frm.begin_day.value > 29) {
  			rdShowMessageDialog("��ʼʱ��2�·����ڲ��ܴ���29��!");
  			return false;
  		}
  	} else {
  		if(document.frm.begin_day.value > 28) {
  			rdShowMessageDialog("��ʼʱ��2�·����ڲ��ܴ���28��!");
  			return false;
  		}
  	}
  }
  
  if(document.frm.end_month.value == "02") {
  	if((document.frm.end_year.value%4==0 && document.frm.end_year.value%100!=0)||(document.frm.end_year.value%100==0 && document.frm.end_year.value%400==0)) {
  		if(document.frm.end_day.value > 29) {
  			rdShowMessageDialog("����ʱ��2�·����ڲ��ܴ���29��!");
  			return false;
  		}
  	} else {
  		if(document.frm.end_day.value > 28) {
  			rdShowMessageDialog("����ʱ��2�·����ڲ��ܴ���28��!");
  			return false;
  		}
  	}
  }
  
  if(document.frm.begin_month.value == "04" || document.frm.begin_month.value == "06" || document.frm.begin_month.value == "09" || document.frm.begin_month.value == "11") {
		if(document.frm.begin_day.value > 30) {
			rdShowMessageDialog("��ʼʱ��Ϊ4, 6, 9, 11��ʱ���ڲ��ܴ���30��!");
			return false;
  	}
  }
  
  if(document.frm.begin_month.value == "04" || document.frm.begin_month.value == "06" || document.frm.begin_month.value == "09" || document.frm.begin_month.value == "11") {
  	if(document.frm.end_day.value > 30) {
			rdShowMessageDialog("����ʱ��Ϊ4, 6, 9, 11��ʱ���ڲ��ܴ���30��!");
			return false;
  	}
  }
  
  if(document.frm.begin_year.value == document.frm.end_year.value) {
  	if(document.frm.begin_month.value == document.frm.end_month.value) {
  		if(document.frm.begin_day.value == document.frm.end_day.value) {
  			if(document.frm.begin_hour.value > document.frm.end_hour.value) {
  				rdShowMessageDialog("��ʼʱ��Сʱ���ܴ��ڽ���ʱ��Сʱ!");
  				return false;
  			}
  		}
  	}
  }
  /**** update by zhangleij 2016-02-15 �����Ǽ��ͻ��ڼ�����ͣ��ǰ̨�����Ż������� end ****/
  
	document.frm.submit();
	            
}
function doclear() {
 	frm.reset();
}

function fanhui() {
 	window.location.href="g636_1.jsp";
}

 </script> 
 
<title>������BOSS-�ڼ�������</title>
</head>
<BODY onload="initForm()">
<form action="g636_5.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">�ڼ����޸�</div>
		</div>  
  <table cellspacing="0">
  	<input  type="hidden" name="old_region_code"  value="<%=tempArr[0][0]%>"/>
  	<input  type="hidden" name="old_level"  value="<%=tempArr[0][1]%>"/>
  	<input  type="hidden" name="old_begin_ymdh"  value="<%=tempArr[0][2]%>"/>
  	<input  type="hidden" name="old_end_ymdh"  value="<%=tempArr[0][3]%>"/>
  	<tr>
  	  <td align="left" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <select name="region_code" >
        	<%=region_options%>                   
        </select>
        <font color="#FF0000">*</font>
      </td>     
      <td align="left" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="level" size="10" maxlength="1" value="<%=tempArr[0][1]%>" onKeyPress="return isKeyNumberdot(0)">
        <font color="#FF0000">*��3��7�������������꣩</font>
      </td>        
    </tr>
    
    <tr>
    	<td align="left" class="blue">��&nbsp;&nbsp;ʼ&nbsp;&nbsp;ʱ&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
    		<select style="width:10%" name="begin_year"><%=year_options%></select> �� 
    		<select style="width:8%" name="begin_month"><%=month_options%></select> �� 
    		<select style="width:8%" name="begin_day"><%=day_options%></select> �� 
    		<select style="width:8%" name="begin_hour"><%=hour_options%></select> ʱ 
    		<font color="#FF0000">*</font><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    		��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;2016050100(2016��5��1��00�㿪ʼ)
    	</td>
    	<td align="left" class="blue">��&nbsp;&nbsp;��&nbsp;&nbsp;ʱ&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
    		<select style="width:10%" name="end_year"><%=year_options%></select> �� 
    		<select style="width:8%" name="end_month"><%=month_options%></select> �� 
    		<select style="width:8%" name="end_day"><%=day_options%></select> �� 
    		<select style="width:8%" name="end_hour"><%=hour_options%></select> ʱ 
    		<font color="#FF0000">*</font><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    		��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;2016050200(2016��5��2��00�����,��һ��)
    	</td>
    </tr>
    
    <tr>
      <td align="left" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="holiday_name" size="20" maxlength="10" value="<%=tempArr[0][4]%>">
        <font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;˵&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="op_note" size="20" maxlength="20" value="<%=tempArr[0][7]%>">
        <font color="#FF0000">*</font>
      </td>   
    </tr>
    
    
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query" class="b_foot" value="�޸�" onclick="commit()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
		  &nbsp;
		  <input type="button" name="return2" class="b_foot" value="����" onClick="fanhui()" >
       </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>

<script language="javascript">
function initForm(){
	document.frm.region_code.value = "<%=region_code%>";
	document.frm.begin_year.value = "<%=begin_year%>";
	document.frm.begin_month.value = "<%=begin_month%>";
	document.frm.begin_day.value = "<%=begin_day%>";
	document.frm.begin_hour.value = "<%=begin_hour%>";
	document.frm.end_year.value = "<%=end_year%>";
	document.frm.end_month.value = "<%=end_month%>";
	document.frm.end_day.value = "<%=end_day%>";
	document.frm.end_hour.value = "<%=end_hour%>";
}
</script> 