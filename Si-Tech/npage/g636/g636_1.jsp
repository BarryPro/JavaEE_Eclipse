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
		String region_code = org_code.substring(0,2);
		String [] inParas = new String[2];
		String return_code="";
		String ret_msg="";
		String return_page = "g636_1.jsp";
		inParas[0]="SELECT REGION_CODE,to_char(ILEVEL),begin_ymdh,end_ymdh,HOLIDAY_NAME,LOGIN_NO,OP_TIME,OP_NOTE FROM CHOLIDAY_UNSTOP_NEW WHERE region_code=:region_code ";
    inParas[1]="region_code="+region_code;
		String opCode = "g636";
		String opName = "�ڼ�������";
		String login_no = (String)session.getAttribute("workNo");
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
   											"<option value='13'>13</option>"+
   											"<option value='14'>14</option>"+
   											"<option value='15'>15</option>"+
   											"<option value='16'>16</option>"+
   											"<option value='17'>17</option>"+
   											"<option value='18'>18</option>"+
   											"<option value='19'>19</option>"+
   											"<option value='20'>20</option>"+
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
  /*
  if(document.frm.year.value=="")  {
     rdShowMessageDialog("���������!");
     document.frm.year.value = "";
     document.frm.year.focus();
     return false;
  }*/
 /*
  if(document.frm.year.value.length < 4)  {
     rdShowMessageDialog("���Ϊ4λ!");
     document.frm.year.value = "";
     document.frm.year.focus();
     return false;
  }
*/	
/*
 if(!isNaN(document.frm.year.value) )  {
 	
 	if(document.frm.year.value.indexOf(".") > -1){
	     rdShowMessageDialog("���Ϊ4λ���ֻ�1��*!");
	     document.frm.year.value = "";
	     document.frm.year.focus();
	     return false;
	}
 	if(document.frm.year.value.length < 4){
	     rdShowMessageDialog("���Ϊ4λ���ֻ�1��*!!");
	     document.frm.year.value = "";
	     document.frm.year.focus();
	     return false;
	}
 }
 
  if(isNaN(document.frm.year.value) )  {
 	if(document.frm.year.value!="*"){
	     rdShowMessageDialog("���Ϊ4λ���ֻ�1��*!!!");
	     document.frm.year.value = "";
	     document.frm.year.focus();
	     return false;
	}
  }
 */
 /*************************************************/ 
 /*
 if(document.frm.month.value=="")  {
     rdShowMessageDialog("�������·�!");
     document.frm.month.value = "";
     document.frm.month.focus();
     return false;
 }
 if(!isNaN(document.frm.month.value) )  {
 	
 	if(document.frm.month.value.indexOf(".") > -1){
	     rdShowMessageDialog("�·�Ϊ2λ���ֻ�1��*!");
	     document.frm.month.value = "";
	     document.frm.month.focus();
	     return false;
	}
 	if(document.frm.month.value.length < 2){
	     rdShowMessageDialog("�·�Ϊ2λ���ֻ�1��*!!");
	     document.frm.month.value = "";
	     document.frm.month.focus();
	     return false;
	}
	
	if(document.frm.month.value > 12){
	     rdShowMessageDialog("�·�ӦС��12!");
	     document.frm.month.value = "";
	     document.frm.month.focus();
	     return false;
	}
 }
 
  if(isNaN(document.frm.month.value) )  {
 	if(document.frm.month.value!="*"){
	     rdShowMessageDialog("�·�Ϊ2λ���ֻ�1��*!!!");
	     document.frm.month.value = "";
	     document.frm.month.focus();
	     return false;
	}
  }
 */
 /************************************************/

  /*
  if(document.frm.begin_time.value=="")  {
     rdShowMessageDialog("�����뿪ʼʱ��!");
     document.frm.begin_time.value = "";
     document.frm.begin_time.focus();
     return false;
  }
  
  if(document.frm.begin_time.value.length < 4)  {
     rdShowMessageDialog("��ʼʱ��Ϊ4λ!");
     document.frm.begin_time.value = "";
     document.frm.begin_time.focus();
     return false;
  }
  
  if(document.frm.begin_time.value.substring(0,2) > 31)  {
     rdShowMessageDialog("��ʼ����Ӧ��С�ڵ���31!");
     document.frm.begin_time.value = "";
     document.frm.begin_time.focus();
     return false;
  }
  
  if(document.frm.begin_time.value.substring(2) > 24)  {
     rdShowMessageDialog("��ʼʱ��Ӧ��С�ڵ���24!");
     document.frm.begin_time.value = "";
     document.frm.begin_time.focus();
     return false;
  }
  
  if(document.frm.end_time.value =="")  {
     rdShowMessageDialog("���������ʱ��!");
     document.frm.end_time.value = "";
     document.frm.end_time.focus();
     return false;
  }
  
  if(document.frm.end_time.value.length < 4)  {
     rdShowMessageDialog("����ʱ��Ϊ4λ!");
     document.frm.end_time.value = "";
     document.frm.end_time.focus();
     return false;
  }
  
    if(document.frm.end_time.value.substring(0,2) > 31)  {
     rdShowMessageDialog("��������Ӧ��С�ڵ���31!");
     document.frm.end_time.value = "";
     document.frm.end_time.focus();
     return false;
  }
  
  if(document.frm.end_time.value.substring(2) > 24)  {
     rdShowMessageDialog("����ʱ��Ӧ��С�ڵ���24!");
     document.frm.end_time.value = "";
     document.frm.end_time.focus();
     return false;
  }
  */
 
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

 </script> 
 
<title>������BOSS-�ڼ�������</title>
</head>
<BODY>
<form action="g636_2.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">�ڼ�������</div>
		</div>  
  <table cellspacing="0">
  	<tr>
  	  <td align="left" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <select name="region_code" >
          	<%=region_options%>                   
          </select><font color="#FF0000">*</font>
      </td>     
      <td align="left" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="level" size="10" maxlength="1" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*��3��7�������������꣩</font>
      </td>        
    </tr>
    <!---- update by zhangleij 2016-02-15 �����Ǽ��ͻ��ڼ�����ͣ��ǰ̨�����Ż������� begin ---->
    <tr>
    	<td align="left" class="blue">��&nbsp;&nbsp;ʼ&nbsp;&nbsp;ʱ&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
    		<select style="width:10%" name="begin_year"><%=year_options%></select> �� 
    		<select style="width:8%" name="begin_month"><%=month_options%></select> �� 
    		<select style="width:8%" name="begin_day"><%=day_options%></select> �� 
    		<select style="width:8%" name="begin_hour"><%=hour_options%></select> ʱ 
    		<font color="#FF0000">*</font><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    		��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;2016050100(2016��5��1��0�㿪ʼ)
    	</td>
    	<td align="left" class="blue">��&nbsp;&nbsp;��&nbsp;&nbsp;ʱ&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
    		<select style="width:10%" name="end_year"><%=year_options%></select> �� 
    		<select style="width:8%" name="end_month"><%=month_options%></select> �� 
    		<select style="width:8%" name="end_day"><%=day_options%></select> �� 
    		<select style="width:8%" name="end_hour"><%=hour_options%></select> ʱ 
    		<font color="#FF0000">*</font><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    		��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;2016050323(2016��5��3��23��59:59����)
    		<!--
    		<select>
    			<option <% if(tV=="01"){out.print("selected='selected'");}%>>01</option>
    			<option <% if(tV=="02"){out.print("selected='selected'");}%>>02</option>
    		</select>-->
    	</td>
    </tr>
    <!---- update by zhangleij 2016-02-15 �����Ǽ��ͻ��ڼ�����ͣ��ǰ̨�����Ż������� end ---->
    
    <!--
    <tr>
      <td align="left" class="blue" width="15%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="year" size="10" maxlength="4" ><font color="#FF0000">*</font>��ʽ��YYYY������Ϊ*
      </td>
      <td align="left" class="blue" width="15%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="month" size="10" maxlength="2" ><font color="#FF0000">*</font>��ʽ��MM������Ϊ*
      </td>   
    </tr>
    
    <tr>
      <td align="left" class="blue" width="15%">��ʼ����ʱ��:&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="begin_time" size="10" maxlength="4" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>���磺0501(5��1�㿪ʼ)
      </td>
      <td align="left" class="blue" width="15%">��������ʱ��:&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="end_time" size="10" maxlength="4" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>���磺0524(5��24�����)
      </td>   
    </tr>
    -->
    
    <tr>
      <td align="left" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="holiday_name" size="20" maxlength="10" >
        <font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;˵&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="op_note" size="20" maxlength="20" >
        <font color="#FF0000">*</font>
      </td>   
    </tr>
    
    
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query" class="b_foot" value="ȷ��" onclick="commit()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>
  <div class="title">
			<div id="title_zi">��ѯ���</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
        <th>��������</th>
        <th>�ͻ��ȼ�</th>   
        <th>��ʼ����ʱ��</th>    
        <th>��������ʱ��</th> 
        <th>��������</th> 
        <th>¼�빤��</th>  
        <th>����ʱ��</th> 
        <th>��ע</th> 
        <th>����</th>          
      </tr>
<%	
   return_code = retCode;
   ret_msg = retMsg;
   if(return_code.equals("000000"))
   {
     for(int i=0; i<tempArr.length ;i++)
     {
%>   
     <tr align="center">
        <td><%=tempArr[i][0]%></td>
        <td><%=tempArr[i][1]%></td>
        <td><%=tempArr[i][2]%></td>
        <td><%=tempArr[i][3]%></td>
        <td><%=tempArr[i][4]%></td>
        <td><%=tempArr[i][5]%></td>
        <td><%=tempArr[i][6]%></td>
        <td><%=tempArr[i][7]%></td>
        <td><a href="g636_3.jsp?region_code=<%=tempArr[i][0]%>&ilevel=<%=tempArr[i][1]%>&begin_ymdh=<%=tempArr[i][2]%>&end_ymdh=<%=tempArr[i][3]%>" onclick= "return   confirm( 'ȷ��ɾ��ѡ�еļ�¼�� '); "> ɾ��</a>
            <a href="g636_4.jsp?region_code=<%=tempArr[i][0]%>&ilevel=<%=tempArr[i][1]%>&begin_ymdh=<%=tempArr[i][2]%>&end_ymdh=<%=tempArr[i][3]%>" onclick= "return   confirm( 'ȷ���޸�ѡ�еļ�¼�� '); "> �޸�</a></td>
      </tr>
<%}}

else{
%>
		<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("��Ϣ��ѯ����!<br>������룺'<%=return_code%>'��������Ϣ��'<%=ret_msg%>'��");
			window.location.href="<%=return_page%>";
		</SCRIPT>
<%	}
%>      
    </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>

