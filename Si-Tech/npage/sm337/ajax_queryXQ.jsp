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
	String xiaoqunameccc  = request.getParameter("xiaoqunameccc");	
	String opType  = request.getParameter("opType");	
	String showTip = "���������С����Ϣ���Բ�ѯ��Ӧ���ʷ���Ϣ";
	/*2016/4/21 21:12:00 gaopeng С��������Ϣ��ѯ*/
	if("managerConfig".equals(opType)){
		showTip = "���������С����Ϣ���Բ�ѯ��Ӧ��С��������Ϣ";
	}

	
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
     	
	<wtc:service name="sM337KDQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=beizhuss%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=xiaoqunameccc%>"/>
	</wtc:service>
  <wtc:array id="result2" scope="end"/>

	
<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">С����Ϣ(<font color='red'><%=showTip%></font>)</div>
			</div>
	    <table cellspacing="0" >
	      <tr align="center"> 

	        <th>��������</th>
	        <th>С������</th>
	        <th>С������</th>
	        <th>С���������ʴ���</th>
					<th>С��������������</th>	        

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
							/*2016/4/21 21:15:46 gaopeng �����С���ͻ������ѯ*/
		%>				
							<%if("managerConfig".equals(opType)){
							%>
								<tr id="manager<%=y%>" align="center" onclick="sBroadManagerQry('manager<%=y%>');" >
							<%
							}else{
								%>
								<tr align="center" onclick="queryofferidajax('<%=result2[y][1]+"|"+result2[y][3]%>');" >
							<%
							}
							%>
						
							
						<td class="<%=tbClass%>"><%=result2[y][0]%></td>					
						<td class="<%=tbClass%>"><%=result2[y][1]%></td>
						<td class="<%=tbClass%>"><%=result2[y][2]%></td>
						<td class="<%=tbClass%>"><%=result2[y][3]%></td>
						<td class="<%=tbClass%>"><%=result2[y][4]%></td>
	
		</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center' ><td colspan='6'>��ѯС����ϢΪ�գ�</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='6'>��ѯС����Ϣʧ�ܣ�<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>

