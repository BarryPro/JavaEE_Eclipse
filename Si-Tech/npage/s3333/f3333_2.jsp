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
    
 		String opCode = "3333";
 		String opName = "ͣ����ѯ";
 		String regionCode  = (String)session.getAttribute("regCode");
 		String loginNo =(String)session.getAttribute("workNo");
 		String pass = (String)session.getAttribute("password"); 	
 			
 		String phone_no = WtcUtil.repNull(request.getParameter("phone_no"));
		String startMonth = WtcUtil.repNull(request.getParameter("startMonth"));
		String endMonth = WtcUtil.repNull(request.getParameter("endMonth"));
		
		
%>		 
		<wtc:service  name="s3070Qry"  routerKey="region"  routerValue="<%=regionCode%>" 
				outnum="4" retcode="retCode" retmsg="retMsg">
			<wtc:param  value="<%=loginNo%>"/>
			<wtc:param  value="<%=pass%>"/>
			<wtc:param  value=""/>
			<wtc:param  value="<%=phone_no%>"/>
			<wtc:param  value="<%=startMonth%>"/>
			<wtc:param  value="<%=endMonth%>"/>
		</wtc:service>
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%
	if(!"000000".equals(retCode)){
%>
		<script language="javascript">
			rdShowMessageDialog("������룺<%=retCode%>��������Ϣ��<%=retMsg%>",0);
		</script>
<%
	}else{
%>

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
				<th>��������</th>
				<th>����ʱ��</th>
				<th>��������</th> 
			</tr> 
	<%
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='4'>");
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
			</tr>
	<%				
				}
			}
	%>			
	 </table>	
 	</div>
</body>
</html>  	 			
<%
	}
%>