<%
/********************
 version v2.0
������: si-tech
����:�ۺ���Ϣ��ѯ֮Ԥ�������Ϣ
update:liutong@2008-8-13
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "1500";
	String opName = "�ۺ���Ϣ��ѯ֮Ԥ�������Ϣ";
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String paytype  = request.getParameter("paytype");
	String phoneNo  = request.getParameter("phoneNo");
	String begindt  = request.getParameter("begindt");
	String work_no=(String)session.getAttribute("workNo");
 
	//add by diling for ��ȫ�ӹ��޸ķ����б�
	String loginNo = (String)session.getAttribute("workNo");
	String password = (String) session.getAttribute("password");
	
    begindt = begindt.substring(0,6);
 
	System.out.println("ddddddddddddddddddddddddddd is paytype is   "+paytype+" and phoneNo is "+phoneNo+" and begindt is "+begindt);
	String[][] result1  = null ;	
		%>
		 
 <wtc:service name="scbQry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="4">
	<wtc:param value="<%=work_no%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=paytype%>"/>
	<wtc:param value="<%=begindt%>"/>
 </wtc:service>
 <wtc:array id="sVerifyTypeArr1" scope="end" start="0"  length="2" />
 <wtc:array id="s_result" scope="end" start="2"  length="2" />
<%
		result1 = sVerifyTypeArr1; 
		if(result1!=null&&result1.length>0 &&retCode1.equals("000000"))
		{
			%>
			<body>
	<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title"  >
				<div id="title_zi">ר�������</div>
			</div>
 
		 <TABLE  cellSpacing="0">
				  <TBODY>
					<TR align="center">
					  <th>�������</th>
					  <th>״̬</th>
					   
					</TR>
				<%
					System.out.println("aaaaaaaaaaaaaaaaaaaaaaaa s_result.length is "+s_result.length);
					for(int i=0;i<s_result.length;i++)
					{
						if(s_result[i][1]=="1" ||s_result[i][1].equals("1"))
						{
							%>
							<tr>
								<td><%=s_result[i][0]%></td>
								<td>���</td>
							</tr>
							<%
						}
						 
					}
					 
				%>	
				<tr> 
					<td id=footer colspan=13>
					  &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
					  &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
					  &nbsp; 
					</td>
				</tr>		  
				 

			</TBODY>
			</TABLE>
				
		<%@ include file="/npage/include/footer.jsp" %>
	 
	</BODY>
			<%
		}
		else
		{
			System.out.println("��ѯ���Ϊ��~~~~~~~~~~~~~~~~~~~~~~");
			%>
				<script language="JavaScript">
				rdShowMessageDialog("��ѯ����! �������:"+"<%=retCode1%>,����ԭ��:"+"<%=retMsg1%>");
				history.go(-1);
				</script>
			<%
		}	
%>
  
	


