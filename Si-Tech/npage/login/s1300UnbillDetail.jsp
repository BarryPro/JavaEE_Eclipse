<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-18 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
 <%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
    
  String opCode = "1556";
	String opName="�˵���ѯ";
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	//����ʱ��
	Calendar calendar = new GregorianCalendar();
	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH);
  int day = 1;
	String Month ="";
	String LastMonth ="";
	if(month<10){
		Month="0"+month;
		LastMonth=year+Month+"01";
	}	
	
//System.out.println("LastMonth ="+LastMonth);
        
	Date date = new Date();
	String yearmonth = new java.text.SimpleDateFormat("yyyyMMdd").format(date);

//System.out.println("yearmonth222222 ="+yearmonth);
    
	String in_phoneno = request.getParameter("phone_no");    
	String in_contractno = request.getParameter("contractno");
    //System.out.println("\n11111111111111111111in_contractno ="+in_contractno);
	String in_begin_time = yearmonth.substring(0,6) + "01";
	String queryTime = yearmonth.substring(0,6);
  	String in_end_time = yearmonth;
  	String workno = (String)session.getAttribute("workNo");
	 
	String inParas[] = new String[8];
  inParas[0] = "2";
	inParas[1] = in_phoneno;
	inParas[2] = in_begin_time;
	inParas[3] = in_end_time;
	inParas[4] = "2";
  inParas[5] = in_contractno;
  inParas[6] = workno;
  inParas[7] = opCode;

  //xl add
	String[] inParas2 = new String[2];
	inParas2[0]="SELECT TO_CHAR(LAST_DAY(ADD_MONTHS(SYSDATE,-LEVEL+1)),'DD') DAY FROM DUAL CONNECT BY LEVEL <=12 and TO_CHAR(ADD_MONTHS(SYSDATE,-LEVEL+1),'YYYYMM')= :month1";
	inParas2[1]="month1="+queryTime;
	String queryDay="";

//20120203 xl add for �����ж��Ƿ��ǰ��·�̯
	String detNo = request.getParameter("detNo");
	String idNo = request.getParameter("idno");
	String ayFlag="";
 	//CallRemoteResultValue value = viewBean.callService("2",in_phoneno,"s1524_Qry","8",lens,inParas);

//xl add for ʱ���ѯ ��6����
	String time_sql="select to_char(add_months(to_date(to_char(sysdate, 'YYYYMMDD'), 'YYYYMMDD'),  -1),  'YYYYMM'),  to_char(add_months(to_date(to_char(sysdate, 'YYYYMMDD'), 'YYYYMMDD'),   -2),   'YYYYMM'),  to_char(add_months(to_date(to_char(sysdate, 'YYYYMMDD'), 'YYYYMMDD'), -3), 'YYYYMM'), to_char(add_months(to_date(to_char(sysdate, 'YYYYMMDD'), 'YYYYMMDD'), -4),  'YYYYMM'),to_char(add_months(to_date(to_char(sysdate, 'YYYYMMDD'), 'YYYYMMDD'), -5), 'YYYYMM')   from dual";

%>
	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode6" retmsg="retMsg6" outnum="5" >
		<wtc:param value="<%=time_sql%>"/>
		 
	</wtc:service>
	<wtc:array id="retTime" scope="end" />


	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode13" retmsg="retMsg13" outnum="1" >
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />
	<%
		if(ret_val==null||ret_val.length==0)
		{
			%><script language="javascript">rdShowMessageDialog("��ѯ���±���!");</script><%
		}
		else
		{
			queryDay=ret_val[0][0];
			 
		}
	%>
	
	<wtc:service name="s1524_Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="28" >
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	<wtc:param value="<%=inParas[6]%>"/>
	<wtc:param value="<%=inParas[7]%>"/>
	</wtc:service>
	<wtc:array id="result1" start="0" length="2" scope="end"/>
	<wtc:array id="result2" start="2" length="6" scope="end"/>	
	<wtc:array id="result3" start="8" length="3" scope="end"/>
	<wtc:array id="result4" start="24" length="2" scope="end"/>
<%
	String record_num = result1[0][0];
	String return_code = result1[0][1];
 	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
%>

<HTML>
<HEAD>
<TITLE>δ���ʻ�����ϸ��ѯ</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
</head>
<script language = "javascript">
function queryLSZD(){
	//if(!forDate(document.frm.beginDate)) return;
	if(parseFloat(document.frm.beginDate.value)<190001){
		rdShowMessageDialog("�������²���С��1900�꣡",0);
		return;
	}
	else{
		 
		var phoneNo= document.frm.phone_no.value;
		var path = 's1351Cfm.jsp?phoneNo=<%=request.getParameter("phone_no")%>'+'&beginDate='+document.frm.beginDate.value;
		//alert('path is '+path); 
		document.frames["iFrame1"].document.body.innerText = "";
		document.getElementById("iFrame1").src = path;         
        document.all.showCustWTab1.style.display="";
	}
	    
}
function showMonth(){
	var date = new Date();
	if(date.getMonth()<10 && date.getMonth()>0){
		document.getElementById("query_month").value = date.getYear().toString()+("0"+date.getMonth()).toString() ;
	}
	else if(date.getMonth()==0){
		document.getElementById("query_month").value = (date.getYear()-1).toString()+"12";
	}
	else{
		document.getElementById("query_month").value = date.getYear().toString()+date.getMonth().toString() ;
	}
}

</script>
<BODY onload = "showMonth(),queryLSZD()" style="width:96%">
<form name="frm" method="post" action="">      
<DIV id="Operation_Table">      	
		<div class="title">
			<div id="title_zi">δ������ϸ��Ϣ(���ṩ)</div>
		</div>

  <table cellspacing="0" >
      <tr align="center"> 
         
				 <th>��������</th>
				 <th>Ӧ��</th>
				 <th>ÿ�շ�̯���</th>
				 <th>�Ż�</th>
				 <th>�ʵ���Ŀ��</th>
				 <th>�ʵ�����</th>
				 <th>����</th>
				 
      </tr>

	  <% 
	     if (result2 != null && result3 != null) {
	     String tbClass="";
		 for (int i=0;i<result2.length; i++) {
			   if(i%2==0){
			  		tbClass="Grey";
			  	}else{
			  		tbClass="";	
			  	}
	  %>
      <tr align="center"> 
				 
				 <td class="<%=tbClass%>"><%=result2[i][2]%>&nbsp;</td>
				 <td class="<%=tbClass%>"><%=result2[i][3]%>&nbsp;</td>
				 <td class="<%=tbClass%>">
				 <%
						if(result4[i][0]=="1"||result4[i][0].equals("1"))
						{
							String v_money=result4[i][1];
					float moneys = Float.valueOf(v_money).floatValue();
					int days = Integer.parseInt(queryDay);
					float mon_per =moneys/days;
					//float new_mon_per = (float)(Math.round(mon_per*100))/100; 
					float new_mon_per = (float)(Math.floor(mon_per*100))/100; 
						%><%=new_mon_per%><%
						}
						else
						{
							 
						}
					 %>
				 </td>
				 <td class="<%=tbClass%>"><%=result2[i][4]%>&nbsp;</td>
				 <td class="<%=tbClass%>"><%=result2[i][5]%>&nbsp;</td> 
				<td class="<%=tbClass%>"><%=result2[i][0]%>&nbsp;</td>
				 <td class="<%=tbClass%>"><%=result2[i][1]%>&nbsp;</td>	 
					 
					 
				 
		
	  </tr>
	  
	  <%   } //ѭ����
	  %>
		<TR colspan=7>
		<!--������ ���� �ܼ�Ӧ�� �ܼ��Ż� �ܼ�ʵ��-->
		<td align="center">�ܼ�Ӧ��</td><td align="center"><%=result3[0][0]%> </td>
		<td align="center">�ܼ��Ż�</td><td align="center"><%=result3[0][1]%> </td>
		<td align="center"><font color="red"><b>�ܼ�ʵ��</b></font></td><td align="center"><%=result3[0][2]%> </td>
		</TR>
	  <%
	     }//�ǿյ�
	  %>
    <!-- <TR>
		������ ���� �ܼ�Ӧ�� �ܼ��Ż� �ܼ�ʵ��
		<td>�ܼ�Ӧ��</td><td><%=result3[0][0]%> </td>
		<td>�ܼ��Ż�</td><td><%=result3[0][1]%> </td>
		<td>�ܼ�ʵ��</td><td><%=result3[0][2]%> </td>
		</TR>-->
    <tr> 
      <td id="footer" colspan="7"> 
       
      </td>
    </tr>
  </table>
</DIV>
<!--xiaoliang ��ϸ�˵���ѯ���� ��ʼ-->
	<DIV id="Operation_Table">      	
		<div class="title">
			<div id="title_zi">��ʷ�˵���ϸ��Ϣ</div>
		</div>
      <table cellspacing="0">
      <tr align="center"> 
        <td>��ѯ�·�</td>
		<td>
		 
		<select name="beginDate" id="query_month" size=1 >
						 
							<%
							//System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaa retTime.length is "+retTime.length);
							for(int i=0; i<retTime.length; i++){%>
							<option value="<%=retTime[i][0]%>" selected>
								<%=retTime[i][0]%></option>
							<option value="<%=retTime[i][1]%>">
								<%=retTime[i][1]%></option>
							<option value="<%=retTime[i][2]%>">
								<%=retTime[i][2]%></option>	
							<option value="<%=retTime[i][3]%>">
								<%=retTime[i][3]%></option>
							<option value="<%=retTime[i][4]%>">
								<%=retTime[i][4]%></option>
							 
							<%}%>
		 </select>
	 </td>
		<td>
		<input type="button" class="b_text" id = "enter" value="��ѯ" onclick="queryLSZD()">
		</td>
      </tr>

	  
      <td id="footer" colspan="7"> 
       
      </td>
    </tr>
  </table>
    </DIV>
	 <!--xiaoliang ��ϸ�˵���ѯ���� ����-->
     <!--xialiang Ϊʵ����ϸ�˵� ��ʼ-->
			<div id="showCustWTab1" style="display:none">
				<iframe name="iFrame1" src=""  width="98%" height="350px" frameborder="0"  >
				</iframe>
				 
			</div>
			<!--xiaoliang ʵϰ��ϸ�˵� ����-->
<input type = "hidden" name = "contractNo" value = "<%=request.getParameter("contactNo")%>">
<input type = "hidden" name = "phone_no" value = "<%=request.getParameter("phone_no")%>">
</form>
</body>
</html>
