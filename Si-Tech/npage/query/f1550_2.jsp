 <%
/********************
 version v2.0
������: si-tech
update:anln@2009-01-08 ҳ�����,�޸���ʽ
********************/
%> 

<%@ page contentType= "text/html;charset=gb2312" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%
	String workNo = (String)session.getAttribute("workNo");    //���� 
	String workName = (String)session.getAttribute("workName");//��������  	
	String regionCode= (String)session.getAttribute("regCode");//����
	String ip_Addr = "172.16.23.13";	
	String opCode = "1550";	
	String opName = request.getParameter("opName");	//header.jsp��Ҫ�Ĳ���     	
	
	//������� ��ѯ���ͣ���ѯ�������������룬���ţ�Ȩ�޴��롣	
	String queryType  = request.getParameter("QueryType");//��ѯ����	
	String condText  = request.getParameter("condText");  //�ֻ�����	
	String password ="password";
%>
<wtc:service name="s1550PhoneQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9" >
		<wtc:param value="<%=queryType%>"/>
		<wtc:param value="<%=condText%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=regionCode%>"/>
		<wtc:param value="<%=opCode%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>

<%	
	if(!retCode1.equals("000000")){
%>
	<script language="JavaScript">		
		rdShowMessageDialog("<%=retCode1%><br>������� '<%=retMsg1%>'��");
		history.go(-1);
	</script>
	<%	
		return;
	}else if(result==null||result.length==0){
%>
	<script language="javascript">
		rdShowMessageDialog("��ѯ���Ϊ��,�޴�������Ϣ���������!");
		history.go(-1);
	</script>
<%		
		return;
	}
	System.out.println("!@#$%^&*"+result.length);
	String return_code = result[0][0];
	String return_message = result[0][1];
	if ( (result.length==1)&&( return_code.equals("000000") ) ) {		
		response.sendRedirect("f1550_Main.jsp?parStr="+result[0][2]+"|"+result[0][3]);
		return;
	}
%>

<HTML>
	<HEAD>
		<TITLE>�ۺ���ʷ��Ϣ��ѯ</TITLE>
	</HEAD>
	<BODY>
		<FORM method=post name="frm1550">
			<input type="hidden" name="opCode"  value="1550">	
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title" id="changxun">
				<div id="title_zi">��ѯ���</div>
			</div>		
	    		<table  cellspacing="0">
			      	<tr align="center">
				        <th>�������</th>
				        <th>�û�ID��</th>
				        <th>�û�����</th>
				        <th>��������</th>
				        <th>��ǰ״̬</th>  
				        <th>״̬���ʱ��</th>  
				        <th>����ʱ��</th>
	     			</tr>
				<%
					for(int y=0;y<result.length;y++){
				%>	
					<tr>
					<%    
						for(int j=2;j<result[0].length;j++){
						/*2014/10/08 9:51:16 gaopeng ��������BOSS�;���ϵͳ�ͻ���Ϣģ����չʾ�ĺ���201409�� 
							�޸� �û����� ģ���� ��j==4ʱ Ϊ�û�����
						*/
						if(j == 4){
								String cust_name = result[y][j];
								if(cust_name != null && !"".equals(cust_name) && !"NULL".equals(cust_name)){
									if(cust_name.length() == 2 ){
										cust_name = cust_name.substring(0,1)+"*";
									}
									if(cust_name.length() == 3 ){
										cust_name = cust_name.substring(0,1)+"**";
									}
									if(cust_name.length() == 4){
										cust_name = cust_name.substring(0,2)+"**";
									}
									if(cust_name.length() > 4){
										cust_name = cust_name.substring(0,2)+"******";
									}
								}
							%>
							<td><div align="center"><a href="f1550_Main.jsp?parStr=<%=result[y][2]+"|"+result[y][3]%>"><%=cust_name %> </a></div></td>
							<%
						}else{
					%>
						<td><div align="center"><a href="f1550_Main.jsp?parStr=<%=result[y][2]+"|"+result[y][3]%>"><%= result[y][j]%> </a></div></td>
					<%
						
						}
					}
					%>
				</tr>
				<%
				    }
				%>
			</table>
			<table cellspacing="0">
				  <tr> 
					    <td id="footer">
						      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
						      &nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
						      &nbsp; 
					    </td>
				  </tr>
			</table>
		</FORM>
	</BODY>
</HTML>
