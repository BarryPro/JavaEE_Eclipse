<%
	/********************
	 version v2.0
	������: si-tech
	*
	*update:zhanghonga@2008-08-12 ҳ�����,�޸���ʽ
	*
	********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%--������com.sitech.boss.pub.util.Encrypt,��Ϊ���صļ��ܷ�ʽ��ʱ�޷��滻--%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
	String opCode = "1502";
	String opName = "�ۺ���Ϣ��ʷ��ѯ";
	
	String workNo = (String)session.getAttribute("workNo");
  String workName=(String)session.getAttribute("workName");
	String Department = (String)session.getAttribute("orgCode");
	String ip_Addr = "172.16.23.13";
	String regionCode = Department.substring(0,2);
	String password = (String)session.getAttribute("password"); //diling add for ��ȫ�ӹ�


//������� ��ѯ���ͣ���ѯ�������������룬���ţ�Ȩ�޴��롣
	String queryType = request.getParameter("QueryType");//��ѯ����
	String condText  = request.getParameter("condText"); //��ѯ����
	String custPass  = request.getParameter("custPass"); //�û�����


	/**
		*����ʹ��WtcUtil.encrypt()������.�������ļ��ܷ�ʽ�����ֺ�ɽ���Ķ���һ��.
		*����ʹ����Encrypt�ļ���,��Encrypt�е����˱��ص�java���ܷ�ʽ
	***/
	String passwd = Encrypt.encrypt(custPass);
	System.out.println("-------passwd="+passwd);
	
	session.setAttribute("verifyFlag","false");
	session.setAttribute("userPhoneNo",condText);
	
	String authFlag = "0";
	String tempStr = "";
	String[][] favInfo = (String[][])session.getAttribute("favInfo");
	String[] favStr = new String[favInfo.length];
	for(int i = 0 ;i < favStr.length; i++){ 
		tempStr = favInfo[i][0].trim();
		if(tempStr.compareTo("a272") == 0) {     
			authFlag = "1";         
		}
	}
 
     
	/**
	try
	{	 
		s1500View viewBean = new s1500View();//ʵ����viewBean		 
		arlist = viewBean.view_s1500_1(queryType,condText,workNo,passwd,regionCode,opCode); 
 	}
	catch(Exception e)
	{
		//System.out.println("����EJB����ʧ�ܣ�");
	}
	**/
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>

		<wtc:service name="s1500PhoneQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9" >
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=passwd%>"/>
		<wtc:param value="<%=queryType%>"/>
		<wtc:param value="<%=condText%>"/>
		<wtc:param value="<%=regionCode%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%	

	String return_code = result[0][0];
	String return_message = result[0][1];
	System.out.println("lllllllllllllreturn_code="+return_code);
	System.out.println(result.length);
	
	if ((result.length==1  && return_code.equals("000000"))) {
		response.sendRedirect("f1502_Main.jsp?parStr="+result[0][2]+"|"+result[0][3]+"&passFlag=0");
		return;
	} else if (return_code.equals("150099")) {
		response.sendRedirect("f1502_Main.jsp?parStr="+result[0][2]+"|"+result[0][3]+"&passFlag=1");
		return;
	}
%>


<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
	<TITLE>�ۺ���Ϣ��ѯ+<%=authFlag%></TITLE>
</HEAD>
<BODY>

<FORM method=post name="frm1500">
<input type="hidden" name="opCode"  value="1500">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�û���Ϣ</div>
	</div> 
<!------------------------>
    <table>
      <tr align="center">
        <th>�������</th>
        <th>�û�ID��</th>
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
					for(int j=2;j<result[y].length-1;j++){
				%>
						<td height="25">
							<div align="center">
								<a href="f1502_Main.jsp?parStr=<%=result[y][2]+"|"+result[y][3]%>" ><%= result[y][j]%> </a>
							</div>
						</td>
				<%
					}
				%>
			</tr>
	<%
	  }
	%>
	</tr>
	</td>
</table>

<table>
  <tr> 
    <td id="footer">
      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
    </td>
  </tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
