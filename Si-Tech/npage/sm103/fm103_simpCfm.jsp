<%
  /*
   * ����: LTE������������ m103
   * �汾: 1.0
   * ����: 2014/5/13
   * ����: diling
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode="m103";
	String opName="LTE������������";
  String cardNo = (String)request.getParameter("cardNo");//�տ�����
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
<%

   String paraAray[] = new String[9];
	 paraAray[0]=printAccept;
	 paraAray[1]="01";
	 paraAray[2]=opCode;
	 paraAray[3]=workNo;
	 paraAray[4]=password;
	 paraAray[5]="";
	 paraAray[6]="";
	 paraAray[7]=workNo+"������"+opName+"����";
	 paraAray[8]=cardNo;
%>
<wtc:service name="sM103Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg"  outnum="2">
	<wtc:param value="<%=paraAray[0]%>" />
	<wtc:param value="<%=paraAray[1]%>" />
	<wtc:param value="<%=paraAray[2]%>" />
	<wtc:param value="<%=paraAray[3]%>" />
	<wtc:param value="<%=paraAray[4]%>" />
	<wtc:param value="<%=paraAray[5]%>" />
	<wtc:param value="<%=paraAray[6]%>" />
	<wtc:param value="<%=paraAray[7]%>" />
	<wtc:param value="<%=paraAray[8]%>" />
</wtc:service>
<wtc:array id="result1" scope="end" />
<%
	if("000000".equals(retCode)){
%>
	<script language="JavaScript">
		rdShowMessageDialog("LTE�����������۰���ɹ���",2);
		window.location = 'fm103_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
	</script>
<%
	}else{
%>
	<script language="JavaScript">
		rdShowMessageDialog("����ʧ�ܣ�������룺<%=retCode%><br>������Ϣ��<%=retMsg%>",0);
		window.location = 'fm103_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
	</script>
<%
	}		

%>	