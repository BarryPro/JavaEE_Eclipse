<%
  /*
   * ����: У԰��Ϣ¼�� m132
   * �汾: 1.0
   * ����: 2014/6/27
   * ����: 
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	/*===========��ȡ����============*/
	String iLoginAccept = (String)request.getParameter("iLoginAccept");
  String iChnSource = (String)request.getParameter("iChnSource");
	String opCode = (String)request.getParameter("iOpCode");
	
	String iLoginNo = (String)request.getParameter("iLoginNo");
	String iLoginPwd = (String)request.getParameter("iLoginPwd");
	String iPhoneNo = (String)request.getParameter("iPhoneNo");
	String iUserPwd = (String)request.getParameter("iUserPwd");
	
	String iCardNo = (String)request.getParameter("iCardNo");
	String iCustName = (String)request.getParameter("iCustName");
	String iSchoolName = (String)request.getParameter("iSchoolName");
	String iMajorName = (String)request.getParameter("iMajorName");
	String iAddrs = (String)request.getParameter("iAddrs");
	
	String opName = (String)request.getParameter("iOpName");
 	
  String regionCode = (String)session.getAttribute("regCode");		
  
  String[] iCardNos = new String[]{""};
  String[] iCustNames = new String[]{""};
  String[] iSchoolNames = new String[]{""};
  String[] iMajorNames = new String[]{""};	
  String[] iAddrss = new String[]{""};	
  
  iCardNos = iCardNo.split(",");
  iCustNames = iCustName.split(",");
  iSchoolNames = iSchoolName.split(",");
  iMajorNames = iMajorName.split(",");
  iAddrss = iAddrs.split(",");
  
  if(iCardNos.length == 0){
		iCardNos = new String[]{""};
	}
	if(iCustNames.length == 0){
		iCustNames = new String[]{""};
	}
	if(iSchoolNames.length == 0){
		iSchoolNames = new String[]{""};
	}
	if(iMajorNames.length == 0){
		iMajorNames = new String[]{""};
	}
	if(iAddrss.length == 0){
		iAddrss = new String[]{""};
	}
  
  String inParam[] = new String[7];
  
  inParam[0] =  iLoginAccept;                 
  inParam[1] =  iChnSource ;
  inParam[2] =  opCode;                  
  inParam[3] =  iLoginNo;                  
  inParam[4] =  iLoginPwd;                  
  inParam[5] =  iPhoneNo;        
  inParam[6] =  iUserPwd;   
      
%>
<wtc:service name="sm132Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="3">
		<wtc:param value="<%=inParam[0]%>" />
		<wtc:param value="<%=inParam[1]%>" />
		<wtc:param value="<%=inParam[2]%>" />
		<wtc:param value="<%=inParam[3]%>" />
		<wtc:param value="<%=inParam[4]%>" />
		<wtc:param value="<%=inParam[5]%>" />
		<wtc:param value="<%=inParam[6]%>" />
		<wtc:params value="<%=iCardNos%>" />
		<wtc:params value="<%=iCustNames%>" />
		<wtc:params value="<%=iSchoolNames%>" />
		<wtc:params value="<%=iMajorNames%>" />
		<wtc:params value="<%=iAddrss%>" />
	</wtc:service>
	<wtc:array id="result1" start="0" length="2" scope="end" />
	<wtc:array id="result2" start="2" length="1" scope="end" />
<%
	if("000000".equals(errCode)){
		System.out.println("���÷��� sBatchCustCfm in fm108BatCfm.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
	</script>
<%
	}else{
		System.out.println(" ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
		window.location.href="/npage/sm132/fm132_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
	}		
%>	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
	</script>
</head>
<body>
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">������Ϣ�б�</div>
	</div>
	<div>
		<table>
			<%if("000000".equals(errCode)){
				if(result2.length > 0){
			%>
			<tr>
				<td colspan="2">ʧ��������<%=result2[0][0]%></td>
			</tr>
			<%}}%>
			<tr>
				<th>�ֻ�����</th>
				<th>ʧ��ԭ��</th>
			</tr>
			
				<%if("000000".equals(errCode)){
					for(int i=0;i<result1.length;i++){
				%>
				<tr>
					<td><%=result1[i][0]%></td>
					<td><%=result1[i][1]%></td>
				</tr>
				<%}}%>
			 <tr> 
					<td align="center" colspan="2" id="footer">
						<input class="b_foot" name="sure"  type="button" value="����"  onclick="window.location.href='/npage/sm132/fm132_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';" />
						<input class="b_foot" name="close" onClick="removeCurrentTab()" type=button value="�ر�" />
					</td>
			 </tr>
		</table>
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>

