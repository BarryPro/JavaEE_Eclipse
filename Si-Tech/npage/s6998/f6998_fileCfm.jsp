<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: �������������Ϣ
�� * �汾: v1.0
�� * ����: 2012-1-30 10:47:05
�� * ����: zhangyan
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>

<%
/*4 route */
String regionCode = (String)session.getAttribute("regCode");

/*inc head*/
String opName = "�ͷ�������֤����";
String opCode="6998";

/*input param*/
String iLoginAccept="" ;/*������ˮ*/
String iChnSource ="";/*������ʶ*/
String iOpCode =opCode;/*��������*/
String iLoginNo=(String)session.getAttribute("workNo"); ;/* ��������*/
String iLoginPwd=WtcUtil.repNull((String)session.getAttribute("password"));;/* ��������*/
String iPhoneNo="";/* �ֻ�����*/
String iUserPwd="";/* �û�����*/
String iOpType=request.getParameter("opType") ;/*��������*/
String iFileName=request.getParameter("fileName");/* �ļ�����*/ 
String iSystemFlag=request.getParameter("sysFlagFile");
String iIpAddr= realip; /*IP��ַ*/
//String iIpAddr= "10.110.0.204"; /*IP��ַ*/

System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iLoginAccept=["+iLoginAccept+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iChnSource=["+iChnSource+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iOpCode=["+iOpCode+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iLoginNo=["+iLoginNo+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iLoginPwd=["+iLoginPwd+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iPhoneNo=["+iPhoneNo+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iUserPwd=["+iUserPwd+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iOpType=["+iOpType+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iFileName=["+iFileName+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iIpAddr=["+iIpAddr+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iSystemFlag=["+iSystemFlag+"]");
String retCode="";
String retMsg="";
%>
<wtc:service name="s6998BaCfm" routerKey="region" routerValue="<%=regionCode%>" 
	outnum="7"  retcode="code" retmsg="msg">
	<wtc:param value="<%=iLoginAccept%>"/>			
	<wtc:param value="<%=iChnSource%>"/>			
	<wtc:param value="<%=iOpCode%>"/>			
	<wtc:param value="<%=iLoginNo%>"/>			
	<wtc:param value="<%=iLoginPwd%>"/>			
	<wtc:param value="<%=iPhoneNo%>"/>			
	<wtc:param value="<%=iUserPwd%>"/>			
	<wtc:param value="<%=iOpType%>"/>			
	<wtc:param value="<%=iFileName%>"/>			
	<wtc:param value="<%=iIpAddr%>"/>			
	<wtc:param value="<%=iSystemFlag%>"/>			
</wtc:service>
<wtc:array id="result" scope="end"/>
	
<%
retCode=code;
retMsg=msg;
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]retCode=["+retCode+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]retMsg=["+retMsg+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]result.length=["+result.length+"]");

if ( !retCode.equals("000000") )
{
%>
<script language="JavaScript">
	rdShowMessageDialog("�������:"+"<%=retCode%></br>"+"������Ϣ:"+"<%=retMsg%>",0);
	window.location.replace("f6998_1.jsp");
</script>
<%
}
%>
<HTML>
	<HEAD>
		<TITLE> δ�ɹ������б� </TITLE>
	</HEAD>
	<body>
		<FORM method=post name="backandwhite">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
			<div id="title_zi">δ�ɹ���Ϣ�б�</div>
			</div>		
			<TABLE cellSpacing="0">
			<TBODY>
			<TR> 			
				<Th class = "blue">ϵͳ��ʶ</Th>
				<Th class = "blue">��ɫ����</Th>
				<Th class = "blue">��ɫ����</Th>
				<Th class = "blue">��������</Th>
				<Th class = "blue">����У���־</Th>
				<Th class = "blue">����ԭ��</Th>
			</TR>
			<%
			if  ( result.length > 0 )
			{
				if ( !result[0][0].equals("0") )
				{
					System.out.println("zhangyan@page=[f6998_fileCfm.jsp]result[i][0]=["+result[0][0]+"]");
				
					for (int i=0;i<result.length;i++) 
					{			
					%>
					<TR>
						<td> <%=result[i][1]%> </td>
						<td> <%=result[i][2]%> </td>
						<td> <%=result[i][3]%> </td>
						<td> <%=result[i][4]%> </td>
						<td> <%=result[i][5]%> </td>
						<td> <%=result[i][6]%> </td>
					</TR>
					<%
					}
				}
				%>			
				<TR>
					<td colspan = "6">����ʧ����Ϣ����:<%=result[result.length-1][0]%>��!</td>
				</TR>		
			<%	
			}
			else
			{
			%>				
				<TR>
					<td colspan = "6">ȫ���ɹ�!</td>
				</TR>
			<%		
			}
			%>
			</TBODY>
			</TABLE>			
			
			<table cellspacing=0>
			<tbody> 
				<tr> 
				<td id="footer">
				<input class="b_foot" name=back 
					onClick="window.location.href='f6998_1.jsp';" type=button value=����>
				<input class="b_foot" name=close 
					onClick="removeCurrentTab();" type=button value=�ر�>
				</td>
				</tr>
			</tbody> 
      		</table>
  			<%@ include file="/npage/include/footer.jsp" %>      
		</FORM>
	</BODY>
</HTML>
