<%
/********************
 version v2.0
������: si-tech
<!-- baixf 20080613 modify �����������������������Ƹ���Ϊ�����ſͻ���ҵӦ��������  -->
********************/
%>
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.09
 ģ��:���ſͻ���ҵӦ������-����
********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>


<%	
	String opCode = "8033";
	String opName = "���ſͻ���ҵӦ����������";
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regCode = (String)session.getAttribute("regCode");
	
	String cust_name=request.getParameter("cust_name"); 
	String sum_money=request.getParameter("sum_money");
	String prepay_fee=request.getParameter("limit_pay"); 
	String sale_name=request.getParameter("sale_name");
	String card_info=request.getParameter("");
	String card_money=request.getParameter("");   
	String machine_type=request.getParameter("machine_type");
	String paraAray[] = new String[6];
	

	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("phone_no");
	paraAray[2] = request.getParameter("opcode");
    paraAray[3] = work_no;
    paraAray[4] = request.getParameter("backaccept");
	paraAray[5] = request.getParameter("opNote");
   
    	
	
              

	//String[] ret = impl.callService("s8033Cfm",paraAray,"2","region",org_code.substring(0,2));
%>
	<wtc:service name="s8033Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>	
	<wtc:param value="<%=paraAray[2]%>"/>	
	<wtc:param value="<%=paraAray[3]%>"/>	
	<wtc:param value="<%=paraAray[4]%>"/>	
	<wtc:param value="<%=paraAray[5]%>"/>
	</wtc:service>	
	<wtc:array id="retTemp"  scope="end"/>
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[1]+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime;
	String errCode = retCode1;
	String errMsg = retMsg1;
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	if (errCode.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("�ύ�ɹ�! ",2);
   removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("���ſͻ���ҵӦ����������ʧ��!(<%=errMsg%>",0);
	history.go(-2);
</script>
<%}%>
