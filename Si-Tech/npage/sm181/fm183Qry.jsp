<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-13 ҳ�����,�޸���ʽ
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/npage/properties/getRDMessage.jsp" %>

<%        
	
	String regionCode =  (String)session.getAttribute("regCode");
	
	String phone_no  = request.getParameter("phone_no");	

	String bus_realPath = request.getRealPath("npage/properties")
     +"/jfInfo.properties";
     
	 String work_no = (String)session.getAttribute("workNo");
	String current_timeNAME=new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());

	
	//add by diling for ��ȫ�ӹ��޸ķ����б�
	String password = (String) session.getAttribute("password");
	
	String  inputParsm [] = new String[17];
	inputParsm[0] = "0";
	inputParsm[1] = "01";
	inputParsm[2] = "m183";
	inputParsm[3] = work_no;
	inputParsm[4] = password;
	inputParsm[5] = phone_no;
	inputParsm[6] = "";
	inputParsm[7] = "-9";
	inputParsm[8] = "-9";

	
%>
     	
	<wtc:service name="sm183Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="20">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
			<wtc:param value="<%=inputParsm[8]%>"/>
	</wtc:service>
<wtc:array id="result2222" scope="end"  start="0"  length="1"/>

  <%
  System.out.println("�������鳤��="+result2222.length);
			if(result2222.length>0) {
	System.out.println("��ѯ�ܹ��ж�����="+result2222[0][0]);		
					inputParsm[7] = "1";
	        inputParsm[8] = result2222[0][0];
	        
	        if("0".equals(result2222[0][0])) {
	        inputParsm[8] = "100";
	        }
	        	        
			}else {
					inputParsm[7] = "1";
	        inputParsm[8] = "100";				
			}
  %>
     	
	<wtc:service name="sm183Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="20">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
			<wtc:param value="<%=inputParsm[8]%>"/>
	</wtc:service>

     <wtc:array id="result2" scope="end"  start="1"  length="19"/>
     		
<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">��ѯ��Ϣ</div>
			</div>
	    <table cellspacing="0" name="t1" id="t1">
	      <tr align="center"> 

	        <th>ת�����ֻ�����</th>
	        <th>��Ч����</th>
	        <th>����ʱ��</th>
	        <th>������ʶ</th>
	        <th>������״̬</th>


	      </tr>
		<%
		if(retCode.equals("000000")) {
		System.out.println(result2.length);

		if(result2.length>0) {
			String tbClass="";
			for(int y=0;y<result2.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
		%>
						<tr align="center">
						<td class="<%=tbClass%>"><%=result2[y][0]%></td>
						<td class="<%=tbClass%>"><%=result2[y][1]%></td>
						<td class="<%=tbClass%>"><%=result2[y][2]%></td>						
						<td class="<%=tbClass%>"><%=readValue(result2[y][3],"jf","OrgID",bus_realPath)%></td>
						<td class="<%=tbClass%>"><%=readValue(result2[y][4],"jf","AssigneeStatus",bus_realPath)%></td>
		</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center' ><td colspan='5'>��ѯ��ϢΪ�գ�</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='5'>��ѯʧ�ܣ�<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>

