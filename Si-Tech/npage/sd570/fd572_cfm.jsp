<%
/********************
 version v2.0
 ������: si-tech
 ģ��: ���뻶�ּ�ͥ
 create by wanglma 
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%
	String work_no = (String)session.getAttribute("workNo");
	String passWord = (String)session.getAttribute("password");
	String regCode = (String)session.getAttribute("regCode");
	String org_code = (String)session.getAttribute("orgCode");
	String opName = "���뻶�ּ�ͥ";
	String opCode = request.getParameter("opCode");
    String phoneNo = request.getParameter("phoneNo");
    String memberNo = request.getParameter("memberNo");
    String mainFeeId = request.getParameter("mainFeeId");/*��ǰ���ʷ�*/
    
    String opMainFeeId = request.getParameter("opMainFeeId");/*�������ʷ�*/
    String opFuFeeId = request.getParameter("opFuFeeId");/*�������ʷ�*/
    String famProdId = request.getParameter("famProdId");/*��ͥ����*/
    /* ��ˮ */
    String printAccept="";
    printAccept = getMaxAccept();


%>
	<wtc:service name="sd572Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>	
	<wtc:param value="<%=opCode%>"/>	
	<wtc:param value="<%=work_no%>"/>
	<wtc:param value="<%=passWord%>"/>
	<wtc:param value="<%=memberNo%>"/><!--��Ա����-->
	<wtc:param value=""/><!--��Ա��������-->
		
	<wtc:param value="<%=opMainFeeId%>"/><!--���ּ�ͥ���ʷ�-->
	<wtc:param value="<%=opFuFeeId%>"/>	<!--���ּ�ͥ��ѡ�ʷ�-->
			
	<wtc:param value="<%=phoneNo%>"/><!--�ҳ�����-->					
	<wtc:param value="<%=mainFeeId%>"/>	<!--��ǰ���ʷ�-->	
	<wtc:param value="<%=famProdId%>"/>	<!--��ͥ����-->
	<wtc:param value="<%=org_code%>"/><!--��������-->
	<wtc:param value="���ּ�ͥ��Ա����"/><!--������־-->
	</wtc:service>
	<wtc:array id="result"  scope="end"/>

<%
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("ҵ�����ɹ�!",2);
   window.location="fd570.jsp?opCode=d572&activePhone=<%=phoneNo%>&opName=<%=opName%>";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("ҵ�����ʧ��!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	window.location="fd570.jsp?opCode=d572&activePhone=<%=phoneNo%>&opName=<%=opName%>";
</script>
<%}%>
