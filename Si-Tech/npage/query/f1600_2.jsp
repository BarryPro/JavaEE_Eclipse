<%
	/********************
	 version v2.0
	������: si-tech
	*
	*create by lipf 20120322
	*
	********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%--������com.sitech.boss.pub.util.Encrypt,��Ϊ���صļ��ܷ�ʽ��ʱ�޷��滻--%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
	String opCode = "e729";
	String opName = "�����Ϣ��ѯ";
	
	String workNo = (String)session.getAttribute("workNo");
  String workName=(String)session.getAttribute("workName");
	String Department = (String)session.getAttribute("orgCode");
	String ip_Addr = "172.16.23.13";
	String regionCode = Department.substring(0,2);


//������� ��ѯ���ͣ���ѯ�������������룬���ţ�Ȩ�޴��롣
	String queryType = request.getParameter("QueryType");//��ѯ����
	String condText  = request.getParameter("condText"); //��ѯ����
	//String custPass  = request.getParameter("custPass"); //�û�����
	String iCfmLogin="";
	String iIdIccid="";
	String iCustName="";
	String iContactName="";
	String iContactPhone="";
	if("0".equals(queryType)){
		iCfmLogin=condText;
	}else if("1".equals(queryType)){
		iIdIccid=condText;
	}else if("2".equals(queryType)){
		iCustName=condText;
	}else if("3".equals(queryType)){
		iContactName=condText;
	}else if("4".equals(queryType)){
		iContactPhone=condText;
	}
	System.out.println("1600     lipf   oldparam  =====queryType=condText========   " +queryType+"  ======  "+condText+"  ======  ");
	


	/**
		*����ʹ��WtcUtil.encrypt()������.�������ļ��ܷ�ʽ�����ֺ�ɽ���Ķ���һ��.
		*����ʹ����Encrypt�ļ���,��Encrypt�е����˱��ص�java���ܷ�ʽ
	***/
	//String passwd = Encrypt.encrypt(custPass);
	System.out.println("1600     lipf   newparam  =====queryType=condText========   " +queryType+"  ======  "+condText+"  ======  ");
	session.setAttribute("verifyFlag","false");
	session.setAttribute("userPhoneNo",condText);
	
	String authFlag = "0";
	boolean pwrf = false; 
	String pubOpCode = opCode;  
	String pubWorkNo = workNo;
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
	if(pwrf){
	    authFlag="1";
	}
%>

		<wtc:service name="sBroadQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="8" >
		<wtc:param value="0"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opName%>"/>
		<wtc:param value="<%=iCfmLogin%>"/>
		<wtc:param value="<%=iIdIccid%>"/>
		<wtc:param value="<%=iCustName%>"/>
		<wtc:param value="<%=iContactName%>"/>
		<wtc:param value="<%=iContactPhone%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>

<%	
	if(result!=null && result.length>0){
		String return_code = result[0][0];
		String return_message = result[0][1];
		System.out.println("lipf   1600  s1500PhoneQry     ===========return_code=result.length====        "+return_code+" =========  "+result.length);
	}
	/**  ������¼Ҳչʾ�б�
	if ((result.length==1  && return_code.equals("000000"))) {
		response.sendRedirect("f1600_Main.jsp?parStr="+result[0][2]+"|"+result[0][3]+"&passFlag=0");
		return;
	} else if (return_code.equals("150099")) {
		response.sendRedirect("f1600_Main.jsp?parStr="+result[0][2]+"|"+result[0][3]+"&passFlag=1");
		return;
	}
	*/
%>


<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
	<TITLE>�����Ϣ��ѯ+<%=authFlag%></TITLE>
</HEAD>
<BODY>

<FORM method=post name="frm1600">
<input type="hidden" name="opCode"  value="e729">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�û���Ϣ</div>
	</div> 
<!------------------------>
    <table>
      <tr align="center">
        <th>����˺�</th>
        <th>���֤��</th>
        <th>�ͻ�����</th>
        <th>�����װ��ϵ��</th>
        <th>��װ��ϵ�绰</th>
        <th>��װ��ַ</th>
      </tr>
	<%
		for(int y=0;y<result.length;y++){
	%>
			<tr>
				<%    
					for(int j=0;j<result[y].length-2;j++){
				%>
						<td height="25">
							<div align="center">
								<a href="f1600_Main.jsp?parStr=<%=result[y][6]+"|"+result[y][7]%>" ><%= result[y][j]%> </a>
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
