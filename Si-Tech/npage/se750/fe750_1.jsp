<%
    /********************
     version v
     ������: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*,java.util.Calendar"%>

<%
    	String opCode = "e750";
    	String opName = "���ͣ�������������־";     
      String sql="";	
      String flag = request.getParameter("flag");	
      
      
      String regionCode = (String)session.getAttribute("regCode");
      String beginTime=request.getParameter("begintime");
			String endTime=request.getParameter("endtime");
			String loginno = request.getParameter("loginno");
			String phoneno = request.getParameter("phoneno");
			if("null".equals(phoneno)){
				phoneno = "";
			}
			if("null".equals(loginno)){
				loginno = "";
			}
			
			if(endTime==null){
				endTime = "";
			}
			
			if(beginTime==null){
				beginTime = "";
			}
			
      if("true".equals(flag)){			
			String tables = "";
			String table = "wobspanprovopr";
			int beginTime_ym = 0;
			int endTime_ym = 0;
			
			int beginTime_m = 0;
			int endTime_m = 0;
			
			int beginTime_y = 0;
			int endTime_y = 0;
			
			int beginTime_ymd = 0;
			int endTime_ymd = 0;
			
			int beginTime_d= 0;
			
			beginTime_ym = Integer.parseInt(beginTime.substring(0,6));
			endTime_ym = Integer.parseInt(endTime.substring(0,6));
			
			beginTime_ymd = Integer.parseInt(beginTime);
			endTime_ymd = Integer.parseInt(endTime);
			
			beginTime_d = Integer.parseInt(beginTime.substring(6,8));
			
			beginTime_m = Integer.parseInt(beginTime.substring(4,6));
			endTime_m = Integer.parseInt(endTime.substring(4,6));
			
			beginTime_y = Integer.parseInt(beginTime.substring(0,4));
			endTime_y = Integer.parseInt(endTime.substring(0,4));
			System.out.println("beginTime_ymd--------->"+beginTime_ymd+"<-------------");
			System.out.println("endTime_ymd--------->"+endTime_ymd+"<-------------");
			while(beginTime_ym<=endTime_ym)
			{
				tables = table+beginTime_ym;
				System.out.println("��ǰ����--------->"+tables+"<-------------");
				System.out.println("phoneno------>"+phoneno+"<--------");
				System.out.println("loginno------>"+loginno+"<--------");
				System.out.println("zhoujf1111111111111------>"+loginno+"<--------");
				if(!"".equals(loginno)&&loginno.substring(0,2).equals("80"))//loginno���գ�����80��ͷ
				{
					System.out.println("loginnoǰ��λ------>"+loginno.substring(0,2)+"<--------");
					if("".equals(sql))//sqlΪ��
					{
						if(!"".equals(phoneno)){//phonenoҲ����
							sql = "select to_char(op_time,'yyyymmddhh24miss'),phone_no,login_no,decode(op_code,'4220','ͣ��','4222','����',op_code)  from "+tables+" where op_code in ('4220','4222') and osnduns = '4510' and phone_no="+phoneno+" and login_no = '"+loginno+"' and to_char(op_time,'yyyymmdd') between '"+beginTime+"' and  '"+endTime+"'";
							System.out.println("111111111111111111loginno��80��ͷ����phoneno������");
						}
						else if("".equals(phoneno))//phonenoΪ��
						{
							sql = "select to_char(op_time,'yyyymmddhh24miss'),phone_no,login_no,decode(op_code,'4220','ͣ��','4222','����',op_code)  from "+tables+" where op_code in ('4220','4222') and osnduns = '4510' and login_no = '"+loginno+"' and to_char(op_time,'yyyymmdd') between '"+beginTime+"' and  '"+endTime+"'";
							System.out.println("222222222222222222loginno���գ�80��ͷ����phoneno��");
						}
					}
					else//sql����
					{
						if(!"".equals(phoneno))
						{//phonenoҲ����
							sql = sql + " union all select to_char(op_time,'yyyymmddhh24miss'),phone_no,login_no,decode(op_code,'4220','ͣ��','4222','����',op_code)  from "+tables+" where op_code in ('4220','4222') and osnduns = '4510' and phone_no="+phoneno+" and login_no = '"+loginno+"' and to_char(op_time,'yyyymmdd') between '"+beginTime+"' and  '"+endTime+"'";
							System.out.println("333333333333333333333loginno��80��ͷ����phoneno������");
						}
						else if("".equals(phoneno))//phonenoΪ��
						{
							sql = sql + " union all select to_char(op_time,'yyyymmddhh24miss'),phone_no,login_no,decode(op_code,'4220','ͣ��','4222','����',op_code)  from "+tables+" where op_code in ('4220','4222') and osnduns = '4510' and login_no = '"+loginno+"' and to_char(op_time,'yyyymmdd') between '"+beginTime+"' and  '"+endTime+"'";
							System.out.println("44444444444444444444loginno���գ�80��ͷ����phoneno��");
						}
					}
				}
				else if("".equals(loginno))//loginnoΪ�գ����������80��ͷ����Ϣ
				{
					if("".equals(sql))
					{
						if(!"".equals(phoneno)){//phoneno����1111
							sql = "select to_char(op_time,'yyyymmddhh24miss'),phone_no,login_no,decode(op_code,'4220','ͣ��','4222','����',op_code)  from "+tables+" where op_code in ('4220','4222') and osnduns = '4510' and phone_no="+phoneno+" and login_no like '80%' and to_char(op_time,'yyyymmdd') between '"+beginTime+"' and  '"+endTime+"'";
							System.out.println("555555555555555555loginnoΪ�գ�phoneno����");
						}
						else if("".equals(phoneno))//phonenoҲΪ��
						{
							sql = "select to_char(op_time,'yyyymmddhh24miss'),phone_no,login_no,decode(op_code,'4220','ͣ��','4222','����',op_code)  from "+tables+" where op_code in ('4220','4222') and osnduns = '4510' and login_no like '80%' and to_char(op_time,'yyyymmdd') between '"+beginTime+"' and  '"+endTime+"'";
							System.out.println("66666666666666666loginnoΪ�գ�phoneno��");
						}
					}
					else//sql����
					{
						if(!"".equals(phoneno)){//phoneno����
							sql = sql + " union all select to_char(op_time,'yyyymmddhh24miss'),phone_no,login_no,decode(op_code,'4220','ͣ��','4222','����',op_code)  from "+tables+" where op_code in ('4220','4222') and osnduns = '4510' and phone_no="+phoneno+" and login_no like '80%' and to_char(op_time,'yyyymmdd') between '"+beginTime+"' and  '"+endTime+"'";
							System.out.println("77777777777777777loginnoΪ�գ�phoneno����");
						}
						else if("".equals(phoneno))//phonenoҲΪ��
						{
							sql = sql + " union all select to_char(op_time,'yyyymmddhh24miss'),phone_no,login_no,decode(op_code,'4220','ͣ��','4222','����',op_code)  from "+tables+" where op_code in ('4220','4222') and osnduns = '4510' and login_no like '80%' and to_char(op_time,'yyyymmdd') between '"+beginTime+"' and  '"+endTime+"'";
							System.out.println("88888888888888888loginnoΪ�գ�phoneno��");
						}
					}
				}
				//loginno���գ�������80��ͷ����������
				System.out.println("��ǰsql��--------->"+sql+"<-------------");
				beginTime_m = beginTime_m+1;
				if(beginTime_m == 13)
				{
					beginTime_y = beginTime_y +1;
					beginTime_m = 1;
				}  
				beginTime_ym = beginTime_y*100 + beginTime_m;
				beginTime_ymd = beginTime_y*10000 + beginTime_m*100+beginTime_d;
			}
			System.out.println("���sql��--------->"+sql+"<-------------");
			}
			Calendar ca = Calendar.getInstance();
			int year = ca.get(Calendar.YEAR);// ��ȡ���
			int month = ca.get(Calendar.MONTH);// ��ȡ�·�
			int day = ca.get(Calendar.DATE);// ��ȡ��
			String currentdate = "";//��ǰ����
			String begindate = "";//�ȵ�ǰ����С��һ���µ�����
			if(month>9)
			{
				if(day>9)
				{
					currentdate = String.valueOf(year)+String.valueOf(month+1)+String.valueOf(day);
					begindate = String.valueOf(year)+String.valueOf(month)+String.valueOf(day);
				}
				else
				{
					currentdate = String.valueOf(year)+String.valueOf(month+1)+"0"+String.valueOf(day);
					begindate = String.valueOf(year)+String.valueOf(month)+"0"+String.valueOf(day);
				}
			}
			else
			{
				if(day>9)
				{
					currentdate = String.valueOf(year)+"0"+String.valueOf(month+1)+String.valueOf(day);
					begindate = String.valueOf(year)+"0"+String.valueOf(month)+String.valueOf(day);
				}
				else
				{
					currentdate = String.valueOf(year)+"0"+String.valueOf(month+1)+"0"+String.valueOf(day);
					begindate = String.valueOf(year)+"0"+String.valueOf(month)+"0"+String.valueOf(day);
				}
			}
%>
<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=sql%>"/>
</wtc:service>
	<wtc:array id="result" scope="end"/>
<HTML>
	<HEAD>
		<TITLE>���ͣ�������������־</TITLE>
		<%
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
		%>
	<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
	</HEAD>
	<BODY>
		<SCRIPT language="JavaScript">
			function getFormatDate(date_obj,date_templet)
			{
			  var year,month,day,hour,minutes,seconds,short_year,full_month,full_day,full_day,full_hour,full_minutes,full_seconds;
			  if(!date_templet)date_templet = "yyyy-mm-dd hh:ii:ss";
			  year = date_obj.getFullYear().toString();
			  short_year = year.substring(2,4);
			  month = (date_obj.getMonth()+1).toString();
			  month.length == 1 ? full_month = "0"+month : full_month = month;
			  day = date_obj.getDate().toString();
			  day.length == 1 ? full_day = "0"+day : full_day = day;
			  hour = date_obj.getHours().toString();
			  hour.length == 1 ? full_hour = "0"+hour : full_hour = hour;
			  minutes = date_obj.getMinutes().toString();
			  minutes.length == 1 ? full_minutes = "0"+minutes : full_minutes = minutes;
			  seconds = date_obj.getSeconds().toString();
			  seconds.length == 1 ? full_seconds = "0"+seconds : full_seconds = seconds;
			  return date_templet.replace("yyyy",year).replace("mm",full_month).replace("dd",full_day).replace("yy",short_year).replace("m",month).replace("d",day).replace("hh",full_hour).replace("ii",full_minutes).replace("ss",full_seconds).replace("h",hour).replace("i",minutes).replace("s",seconds);
			}
			
			function   CheckIsDate(value)   
			{   
			  var   strValue     =   new   String();       
			  var   year   =   new   String();   
			  var   month   =   new   String();   
			  var   day   =   new   String();   
			  strValue   =   value;
			  year   =   strValue.substr(0,4);   
			  month   =   strValue.substr(4,2);   
			  month   =   month-1;     
			  day   =   strValue.substr(6,2);   
			  var   testDate   =   new   Date(year,month,day); 
			  return     (year   ==   testDate.getFullYear())   &&   (month   ==testDate.getMonth())&&(day   ==   testDate.getDate());   
			}
			
			function monthCheck(date1,date2,months)
			{
			  var year1 = parseInt(date1.substr(0,4)); 
			  var year2 = parseInt(date2.substr(0,4));
			  var month1 = parseInt(date1.substr(4,1))*10+parseInt(date1.substr(5,1));
			  var month2 =  parseInt(date2.substr(4,1))*10+parseInt(date2.substr(5,1));
			  var flag = 0;
			  if(year2 == year1) flag =0;
			  else if(year2 - year1 == 1) flag = 1;
			  else 
			  {
			  	return false;
			  }
			  //rdShowMessageDialog(year2+" "+year1+" "+month1+" "+month2+" "+flag);
			  if((flag*12+month2-month1)<months)
			  {
			  	return true;
			  }
			  else
			  {
			  	return false;  	
			  }
			}
	
			<!-- ��ѯ -->
			function query()
			{
				var nowDate = getFormatDate(new Date(),"yyyymmdd");
				var inbegintime = document.frme750_1.begintime.value;	
				var inEndtime = document.frme750_1.endtime.value;
				
				if(document.frme750_1.begintime.value.length != 8)
			  {
			    rdShowMessageDialog("��ʼʱ�䳤�Ȳ���ȷ��");
			    document.frme750_1.begintime.value="";
			    document.frme750_1.begintime.select();
			    return false;
			  }
			  if(document.frme750_1.endtime.value.length != 8)
			  {
			    rdShowMessageDialog("����ʱ�䳤�Ȳ���ȷ��");
			    document.frme750_1.endtime.value="";
			    document.frme750_1.endtime.select();
			    return false;
			  }
			  if(!CheckIsDate(inbegintime))
			  {
			    rdShowMessageDialog("��ʼʱ�䲻�Ϸ���");
			    document.frme750_1.begintime.value="";
			    document.frme750_1.begintime.select();
			    return false;
			  }
			  if(!CheckIsDate(inEndtime))
			  {
			    rdShowMessageDialog("����ʱ�䲻�Ϸ���");
			    document.frme750_1.endtime.value="";
			    document.frme750_1.endtime.select();
			    return false;
			  }
				
				
				if(monthCheck(inbegintime.substr(0,6),inEndtime.substr(0,6),6)==false)
				{
					rdShowMessageDialog("��ѯ��Ȳ��ܳ���6����!");
					return false;
				}
				if(""!=(document.frme750_1.phoneno.value)){
					if(document.frme750_1.phoneno.value.length != 11)
					{
						rdShowMessageDialog("������11λ�ֻ�����!");
						return false;
					}
				}
				if(nowDate.localeCompare(inEndtime)<0)
				{
					//��������������ڵ�ǰ�������趨Ϊ��ǰ����
					document.frme750_1.endtime.value = nowDate;
					inbegintime = nowDate;h
				}
				
				if(nowDate.localeCompare(inbegintime)<0)
				{
					//�����ʼ�������ڵ�ǰ�������趨Ϊ��ǰ����
					document.frme750_1.begintime.value = nowDate;
					inEndtime = nowDate;
				}
				
				if(inEndtime.localeCompare(inbegintime)<0)
				{
					rdShowMessageDialog("��ʼʱ�䲻�ܴ��ڽ���ʱ��!");
					return;
				}
				document.frme750_1.flag.value = true;
				document.frme750_1.action="fe750_1.jsp"
				document.frme750_1.submit();
			}
		</SCRIPT>
		
		
		<!-- �� -->
		<FORM method=post name="frme750_1">
		<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<input type="hidden" name="flag" value="">
				<div id="title_zi">���ͣ�������������־</div>
			</div>
			<TABLE cellSpacing="0">
        <TR>
        	<td  class="blue">��ʼʱ��</td>
					<TD>
          	<input type="text" name="begintime" size="10" maxlength="8" value="<%= begindate%>" onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true})">
          </TD>
        	<td  class="blue">����ʱ��</td>
					<TD>
          	<input type="text" name="endtime" size="10" maxlength="8"  value="<%= currentdate%>" onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true})">
          </TD>
        </TR>
        <TR>
        	<td  class="blue">�ֻ�����</td>
					<TD>
						<%if(phoneno==null){%>
						<input type="text" name="phoneno" size="11" maxlength="11" value="" >
        <%} else{%>
        		<input type="text" name="phoneno" size="11" maxlength="11" value="<%= phoneno%>">
        <%}%>
          </TD>
        	<td  class="blue">��������</td>
					<TD>
						<%if(loginno==null){%>
						<input type="text" name="loginno" size="11" maxlength="6" value="" >
        <%} else{%>
        		<input type="text" name="loginno" size="11" maxlength="6" value="<%= loginno%>">
        <%}%>
          </TD>
        </TR>
      </TABLE>
			<TABLE cellSpacing="0">
				<tr> 
	        <td id="footer"> 
	           <input type="button" name="queryButton"  class="b_foot" value="��ѯ" style="cursor:hand;" onclick="query()">&nbsp;
	        </td>
		     </tr>
			</TABLE>
		<br />
			<table border="0" align="center" cellspacing="0">
				<tr>
					<%if(result.length!=0){%>
        	<font color="orange">�� <%= result.length%>��</font>
        <%} else{%>
        <font color="orange">��ǰ��¼Ϊ�գ�</font>
        <%}%>
        <td class=orange>��ʼʱ�䣺</td>
				<td class=blue><%=beginTime%></td>
				<td class=orange>����ʱ�䣺</td>
				<td class=blue><%=endTime%></td>
				</tr>
			</table>
			<table cellspacing="0" id="tabList">
			<tr>				
				<th nowrap>����ʱ��</th>
				<th nowrap>�ֻ�����</th>
				<th nowrap>��������</th>
				<th nowrap>��������</th>
			</tr>
		<%
		if("true".equals(flag)){
			if(result!=null&&result.length!=0){
			 for(int y=0;y<result.length;y++)
		   {
			   	out.println("<tr>");
			   	for(int j=0;j<result[0].length;j++)
			   	{
			   		out.println("<td align='left' nowrap>" + result[y][j] + "</td>");
			   	}
			   	out.println("</tr>");
		   }
			}
		}
		%>
		</table>
		</FORM>
  <BODY>
<HTML>
