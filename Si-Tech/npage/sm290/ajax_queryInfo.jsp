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
	String work_no = (String)session.getAttribute("workNo");	
	String starttimess  = request.getParameter("starttimess");
	String endtimess  = request.getParameter("endtimess");
	starttimess=starttimess+"000000";
	endtimess=endtimess+"235959";


	//add by diling for ��ȫ�ӹ��޸ķ����б�
	String password = (String) session.getAttribute("password");	
	String  inputParsm [] = new String[17];
			inputParsm[0] = "0";
			inputParsm[1] = "01";
			inputParsm[2] = "m290";
			inputParsm[3] = work_no;
			inputParsm[4] = password;
			inputParsm[5] = "";
			inputParsm[6] = "";	
			String beizhuss =work_no+"����ԤԼ��Ϣ��ѯ";
%>
     	
	<wtc:service name="sPreInfoQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="10">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=beizhuss%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=starttimess%>"/>
			<wtc:param value="<%=endtimess%>"/>
	</wtc:service>
		<wtc:array id="result2" scope="end"  />

	
<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body>
    	
	    <table cellspacing="0" name="t1" id="t1">
	    	<tr style="display:none" align="center"> 
	    		<th ></th>
	    		<th ></th>
	    		<th ></th>
	    		<th ></th>
	    		<th ></th>
	    		<th ><B>�������(����)ԤԼ�����¼��</B></th>
	    	</tr>
	      <tr align="center"> 
	        <th >����</th>
	        <th >����</th>	      	
	        <th >�������</th>
	        <th>Ԥ��</th>
	        <th >�����Ѷ��(����)</th>
	        <th >��������(��ʱ��)</th>
	        <th >ԤԼʱ��</th>
	        <th>�ͻ�����</th>
	        <th >���֤����</th>
	        <th >״̬</th>
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
						<tr align="center"  >
						<td class="<%=tbClass%>"><%=result2[y][1]%></td>					
						<td class="<%=tbClass%>"><%=result2[y][2]%></td>
						<td class="<%=tbClass%>"><%=result2[y][0]%></td>
						<td class="<%=tbClass%>">1800</td>
						<td class="<%=tbClass%>">50</td>
						<td class="<%=tbClass%>">36</td>
						<td class="<%=tbClass%>"><%=result2[y][6]%></td>
						<td class="<%=tbClass%>"><%=result2[y][7]%></td>
						<td class="<%=tbClass%>"><%=result2[y][8]%></td>
						<td class="<%=tbClass%>"><%=result2[y][9]%></td>
		</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center' ><td colspan='10' >��ѯԤԼ��ϢΪ�գ�</td></tr>
<%}
	%>
	<tr style="display:none" align="center"> 
	    		<th ></th>
	</tr>
	<tr style="display:none" align="center"> 
	    		<th ></th>
	</tr>
	<tr style="display:none" align="center"> 
	    		<th >��¼�ˣ�</th>
	    		<th ></th>
	    		<th ></th>
	    		<th ></th>
	    		<th ></th>
	    		<th >�ල�ˣ�</th>
	</tr>
	<%
	}else {
			%>
			<tr height='25' align='center'><td colspan='10'>��ѯԤԼ��Ϣʧ�ܣ�<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}%>
		</table>
	
	
			



	</BODY>
</HTML>

