<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String workNo = (String)session.getAttribute("workNo");
String regionCode= (String)session.getAttribute("regCode");
String password = (String)session.getAttribute("password");
String smzflag ="";

String bianhao = request.getParameter("bianhao");
String cus_pass = request.getParameter("cus_pass");
String opnote =workNo+"����g529��ϸ��Ϣ��ѯ";
String orderNo = request.getParameter("odr_id");

	String svcName = "sA381Qry"; // sJQKTest sA381Qry
%>
			
  <wtc:service name="<%=svcName%>" outnum="40"
  	routerKey="region" routerValue="<%=regionCode%>" 
  	retcode="retCode1" retmsg="retMsg1">
    <wtc:param value=""/>
    <wtc:param value="01"/>
    <wtc:param value="a381"/>
    <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=password%>"/>
    <wtc:param value=""/>
    <wtc:param value=""/>
    	
    <wtc:param value="3"/>
    <wtc:param value="<%=orderNo%>"/>
    <wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value=""/>	
	<wtc:param value=""/>	
	<wtc:param value=""/>	
    	
  </wtc:service>
	<wtc:array id="rst0" start = "0" length = "1" scope="end" />
	<wtc:array id="dcust3" start = "6" length = "30" scope="end" />
<%
/*System.out.println("--wanghyd"+dcust2.length);*/
%>

<body>
	  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">��ѯ��Ϣ</div>
			</div>

							
								
							<%if(retCode1.equals("000000")) {
							   if(dcust3.length>0) {
							   for(int i=0;i<dcust3.length; i++) {
							%>
								<table >
						<tr>
         		<td class='blue' width="15%">��������</td>
						<td ><input type="text" value="<%=dcust3[i][0]%>" disabled class="required" maxlength="20" ></td>
         		<td class='blue' width="15%">֤������</td>
						<td ><input type="text" value="<%=dcust3[i][1]%>" disabled class="required" maxlength="20" ></td>																			
					 </tr>
					 						<tr>
         		<td class='blue' width="15%">֤������</td>
						<td ><input type="text" value="<%=dcust3[i][2]%>" disabled class="required" maxlength="20" ></td>
         		<td class='blue' width="15%">�Ա�</td>
						<td ><input type="text" value="<%if(dcust3[i][3].equals("1")) {out.print("��");}if(dcust3[i][3].equals("2")) {out.print("Ů");}%>" disabled class="required" maxlength="40" ></td>																			
					 </tr>

					 					 						<tr>
         		<td class='blue' width="15%">�ջ�������</td>
						<td ><input type="text" value="<%=dcust3[i][4]%>" disabled class="required" maxlength="20" ></td>
         		<td class='blue' width="15%">�ջ��˵绰</td>
						<td ><input type="text" value="<%=dcust3[i][5]%>" disabled class="required" maxlength="20" ></td>																			
					 </tr>
					 					 						<tr>
         		<td class='blue' width="15%">�ջ��˵�ַ</td>
						<td ><input type="text" value="<%=dcust3[i][6]%>" disabled class="required" maxlength="40" size="45"></td>
         		<td class='blue' width="15%">�ջ�������</td>
						<td ><input type="text" value="<%=dcust3[i][7]%>" disabled class="required" maxlength="20" ></td>																			
					 </tr>
					 					 					 						<tr>
         		<td class='blue' width="15%">��������</td>
						<td ><input type="text" value="<%=dcust3[i][8]%>" disabled class="required" maxlength="20" ></td>
         		<td class='blue' width="15%">���ͷ�ʽ</td>
						<td ><input type="text" size="45" value="<%if(dcust3[i][9].equals("1")) {out.print("ֻ�������ͻ���˫���ա����ղ��ͻ���");}if(dcust3[i][9].equals("2")) {out.print("˫���ա������ͻ��������ղ��ͻ���");}if(dcust3[i][9].equals("3")) {out.print("�����ա�˫��������վ����ͻ�");}%>" disabled class="required" maxlength="20" ></td>																			
					 </tr>
					 					 					 					 						<tr>
         		<td class='blue' width="15%">��ϵ������</td>
						<td ><input type="text" value="<%=dcust3[i][10]%>" disabled class="required" maxlength="20" ></td>
         		<td class='blue' width="15%">��ϵ�˵绰</td>
						<td ><input type="text" value="<%=dcust3[i][11]%>" disabled class="required" maxlength="20" ></td>																			
					 </tr>
					 					 					 					 						<tr>
         		<td class='blue' width="15%">��ϵ�˵�ַ</td>
						<td ><input type="text" value="<%=dcust3[i][12]%>" disabled class="required" maxlength="20" size="45"></td>
         		<td class='blue' width="15%">��ϵ������</td>
						<td ><input type="text" value="<%=dcust3[i][13]%>" disabled class="required" maxlength="20" ></td>																			
					 </tr>
					 					</tr>
										<tr height='25' align='center'><td colspan='4'>
											<input class="b_foot" name=close  onClick="window.close()" type=button value="�ر�" />
											</td>
					</tr>
					 
								</table>
						  		<%
		    }
		    }
		  else {
		%>
			<table >					
		<tr height='25' align='center'><td colspan='12'>��ѯ��ϢΪ�գ�</td></tr>
			</table>
<%}}else {
			%>
			<script language="JavaScript">
					    rdShowMessageDialog("<%=retCode1%>"+"<%=retMsg1%>",0);	
					</script>
					<%
	}%>
						
					</div>
				</div>
</body>
</html>
