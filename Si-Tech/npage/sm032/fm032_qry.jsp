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
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="sitech.www.frame.util.DataSourceUtils" %>
<%@ page import="sitech.www.frame.util.DataAccessException" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.DataSource" %>	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%        
	String regionCode =  (String)session.getAttribute("regCode");
	String phoneNo  = request.getParameter("phoneNo");
	String opCode  = request.getParameter("opCode");
	String cardNo  = request.getParameter("cardNo");
	String cust_name  = request.getParameter("custName");
	String work_no=(String)session.getAttribute("workNo");
	String work_name=request.getParameter("workName");
	String password = (String) session.getAttribute("password");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
        	
     <wtc:service name="sM032Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="16">
        <wtc:param value="<%=printAccept%>"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=work_no%>"/>
        <wtc:param value="<%=password%>"/>
        <wtc:param value="<%=phoneNo%>"/>
        <wtc:param value=""/>
        <wtc:param value="<%=cardNo%>"/>
        </wtc:service>
        <wtc:array id="retarrays" scope="end"/>
<%
		String str_src1 ="";
		if(retCode2.equals("000000")) {
			if(retarrays.length>0) {
				str_src1 = request.getContextPath()+"/npage/public/pubGetImg.jsp?svcName=sM032Qry&outNum=8&inNum=8&outPos=0&param0=0&param1=01&param2="+opCode+"&param3="+work_no+"&param4="+password+"&param5="+phoneNo+"param6=&param7="+cardNo;
				System.out.println("base64��Ϊ"+str_src1);
			}
		}
%>

<HTML><HEAD><TITLE>֤����Ϣ��ѯ</TITLE>
</HEAD>
<body>
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi"><%if("m033".equals(opCode)) {%>ͼƬ��ѯ<%}else{%>������Ϣ��ѯ<%}%></div>
			</div>
	    <table cellspacing="0">
		<%
		if(retCode2.equals("000000")) {
		if(retarrays.length>0) {

		%>
		
		<tr>
			<th align='center' width = '50%' colspan = '4'>���֤����ͼ��</th>
		</tr>
		<tr>
			<td align='center' colspan = '4' >
				<img src = '<%=str_src1%>' width = '102px' height = '126px'>
			</td>			
		</tr>
		<%if("m034".equals(opCode)) {%>
		<tr>
			<td WIDTH = '15%' ALIGN = 'CENTER' class = 'blue' >֤������</TD> 
			<td WIDTH = '35%'>
       <%=retarrays[0][1]%>
			</TD> 		
			<td WIDTH = '15%' ALIGN = 'CENTER' class = 'blue' >֤������</TD> 
			<td WIDTH = '35%'>
	     <%=retarrays[0][3]%>
			</TD> 
		</tr>
		<tr>
		<tr>
			<td WIDTH = '15%' ALIGN = 'CENTER' class = 'blue' >֤����ַ</TD> 
			<td WIDTH = '35%'>
		   <%=retarrays[0][2]%>	
			</TD> 					
			<td WIDTH = '15%' ALIGN = 'CENTER' class = 'blue' >֤����Ч��</TD>  
			<td WIDTH = '35%'>
		   <%=retarrays[0][4]%>			
			</TD> 					
		</tr>	
				<tr>
			<td WIDTH = '15%' ALIGN = 'CENTER' class = 'blue' >����ʱ��</TD> 
			<td WIDTH = '35%'>
      <%=retarrays[0][5]%>		
			</TD> 					
			<td WIDTH = '15%' ALIGN = 'CENTER' class = 'blue' >��������</TD>  
			<td WIDTH = '35%'>
      <%=retarrays[0][6]%>				
			</TD> 					
		</tr>	
		<tr>
			<td WIDTH = '15%' ALIGN = 'CENTER' class = 'blue' >��������</TD> 
			<td colspan="4">
<%=retarrays[0][7]%>
			</TD> 										
		</tr>	

		<%
		}
		    
		  }else {
		%>
<tr height='25' align='center' ><td colspan='4'>��ѯ��ϢΪ�գ�</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='4'>������룺<%=retCode2%>��������Ϣ��<%=retMsg2%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>

