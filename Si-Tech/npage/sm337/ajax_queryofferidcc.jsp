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
<%!

%>
<%        
	
	String regionCode =  (String)session.getAttribute("regCode");		
	String work_no = (String)session.getAttribute("workNo");	
	
	String offeridccc  = request.getParameter("offeridccc");	
	String offernameccc  = request.getParameter("offernameccc");	

	
	//add by diling for ��ȫ�ӹ��޸ķ����б�
	String password = (String) session.getAttribute("password");	
	String  inputParsm [] = new String[17];
			inputParsm[0] = "0";
			inputParsm[1] = "01";
			inputParsm[2] = "m337";
			inputParsm[3] = work_no;
			inputParsm[4] = password;
			inputParsm[5] = "";
			inputParsm[6] = "";
			String beizhuss =work_no+"���п���ʷѲ�ѯ";

%>
     	
	<wtc:service name="sM337OfferQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="4">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=beizhuss%>"/>
			<wtc:param value="<%=offeridccc%>"/>
			<wtc:param value="<%=offernameccc%>"/>
	</wtc:service>

        <wtc:array id="result2" scope="end"  />
	
<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">�ʷ���Ϣ(����������ʷѿ��Բ�ѯ��Ӧ��С����Ϣ)</div>
			</div>
	    <table cellspacing="0" >
	      <tr align="center"> 

	        <th>�ʷѴ���</th>
	        <th>�ʷ�����</th>
	        <th>�ʷ�Ʒ��</th>
	        <th>Ʒ������</th>

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
						<tr align="center" onclick="queryxiaoquccajax('<%=result2[y][0]%>')" >
						<td class="<%=tbClass%>"><%=result2[y][0]%></td>					
						<td class="<%=tbClass%>"><%=result2[y][1]%></td>
						<td class="<%=tbClass%>"><%=result2[y][2]%></td>
						<td class="<%=tbClass%>"><%=result2[y][3]%></td>
		</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center' ><td colspan='4'>��ѯ�ʷ���ϢΪ�գ�</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='4'>��ѯ�ʷ���Ϣʧ�ܣ�<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>

