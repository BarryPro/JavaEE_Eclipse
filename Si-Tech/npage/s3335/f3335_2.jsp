 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%
   /*
   * ����: ��˼�¼��ѯ-���ݽ����ѯ��Ϣ
�� * �汾: v3.0
�� * ����: 2008-10-10
 ��*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		/**��Ҫ�������.�������ҳ��,��ɾ��**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "3335";
 		String opName = "Ͷ�ߴ������������ѯ";
 		String regionCode  = (String)session.getAttribute("regCode");
 		String loginNo =(String)session.getAttribute("workNo");
 		String pass = (String)session.getAttribute("password"); 	
 			
 		String phone_no = WtcUtil.repNull(request.getParameter("phone_no"));
		String sql = "select phone_no,consume_info,cust_property,cust_base_info,state,complaints_mark,total,mark_level  from wreputationinfo where phone_no = '"+phone_no+"'";
		System.out.println("sql ============"+sql);
%>		 
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="8">
		<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="sVerifyTypeArr" scope="end" />			
<html>
<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
</head>
<body>
	<div id="Operation_Table">	
     <table cellspacing="0">
			<tr>
				<th>�ֻ�����</th>
				<th>������Ϣ</th>
				<th>�ͻ�����</th>
				<th>�ͻ�������Ϣ</th> 
				<th>��ǰ״̬</th>
				<th>Ͷ�߻���</th>
				<th>�ܷ�</th>
				<th>���ֵȼ�</th>
			</tr> 
	<%
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='8'>");
				out.println("<font class='orange'>û���κμ�¼��</font>");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				for(int i=0;i<sVerifyTypeArr.length;i++){
						tbclass = (i%2==0)?"Grey":"";
	%>			
			<tr>
				<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
				<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
				<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
				<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
				<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
				<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
				<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
				<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][7]%>&nbsp;</td>				
			</tr>
	<%				
				}
			}
	%>			
	 </table>	
 	</div>
</body>
</html>  	 			