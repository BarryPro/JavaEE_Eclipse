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

<%        
	
	String regionCode =  (String)session.getAttribute("regCode");	
	String phoneNo  = request.getParameter("phoneNo");	
	String yewuliushui=request.getParameter("yewuliushui");
	String work_no = (String)session.getAttribute("workNo");
	
	String current_timeNAME=new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());

	
	//add by diling for ��ȫ�ӹ��޸ķ����б�
	String password = (String) session.getAttribute("password");
	
	String  inputParsm [] = new String[17];
	inputParsm[0] = yewuliushui;
	inputParsm[1] = "01";
	inputParsm[2] = "m265";
	inputParsm[3] = work_no;
	inputParsm[4] = password;
	inputParsm[5] = phoneNo;
	inputParsm[6] = "";

	String custnames="";
	String simstatuss="";
%>
     	
	<wtc:service name="sm265Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="20">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>

	</wtc:service>

 <wtc:array id="result2" scope="end" start="0"  length="6"/>
 <wtc:array id="result3" scope="end" start="6"  length="3"/>
 	<%
 	  if("000000".equals(retCode)) {
				if(result3.length>0) {
					custnames=result3[0][1];
					simstatuss=result3[0][2];
				}
		}
 	%>

	
<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">��ѯ��Ϣ</div>
			</div>
	    <table cellspacing="0" name="t1" id="t1">
	      <tr align="center"> 
					<th></th>
	        <th>�ֻ�����</th>
	        <th>����ʱ��</th>
	        <th>��������</th>
	        <th>ҵ������</th>
	        <th>���</th>
	        <th>��ˮ</th>


	      </tr>
		<%
		if("000000".equals(retCode)) {
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
						<td align="center"><input type="radio" name="opFlag" value="<%=result2[y][0]%><-!-><%=result2[y][4].trim()%><-!-><%=result2[y][5]%><-!-><%=custnames%><-!-><%=simstatuss%>"  > </td>
						<td class="<%=tbClass%>"><%=result2[y][0]%></td>
						<td class="<%=tbClass%>"><%=result2[y][1]%></td>		
						<td class="<%=tbClass%>"><%=result2[y][2]%></td>				
						<td class="<%=tbClass%>"><%=result2[y][3]%></td>
						<td class="<%=tbClass%>"><%=result2[y][4]%></td>
						<td class="<%=tbClass%>"><%=result2[y][5]%></td>

		</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center' ><td colspan='7'>��ѯ��ϢΪ�գ�</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='7'>��ѯʧ�ܣ�<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>

