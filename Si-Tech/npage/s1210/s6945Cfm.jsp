<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-08-28 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
	String srv_no = request.getParameter("srv_no");
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String op_code = "6945";
	String paraStr[] = new String[24];
	String stream = WtcUtil.repNull(request.getParameter("loginAccept"));
	String OpNote = WtcUtil.repNull(request.getParameter("assuNote"));
	System.out.println("stream=" + stream);
	String thework_no = work_no;
%>
<%--@ include file="../../npage/public/fPubSavePrint.jsp" --%>

<%
    paraStr[2] = op_code;
    paraStr[0] = work_no;
    paraStr[1] = WtcUtil.repNull(request.getParameter("srv_no"));
    paraStr[3] = OpNote;

    //String[] fg = co.callService("s6945Cfm", paraStr, "1", "phone", srv_no);
%>
		<wtc:service name="s6945Cfm" routerKey="phone" retCode="initRetCode" retMsg="initRetMsg" routerValue="<%=srv_no%>" outnum="1">
			<wtc:param value="<%=paraStr[0]%>"/>
			<wtc:param value="<%=paraStr[1]%>"/>
			<wtc:param value="<%=paraStr[2]%>"/>
			<wtc:param value="<%=paraStr[3]%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
	  System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");		
    int s6945CfmRetCode = 999999;
    if(initRetCode!=null&&initRetCode!=""){
    	s6945CfmRetCode = Integer.parseInt(initRetCode);
    }
    String s6945CfmRetMsg = initRetMsg;
    System.out.println("errCode = " + s6945CfmRetCode);
	String cnttActivePhone = srv_no;    
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+paraStr[2]+"&retCodeForCntt="+initRetCode+"&opName=ԤԼ���ſ�ͨ&workNo="+paraStr[0]+"&loginAccept="+stream+"&pageActivePhone="+cnttActivePhone+"&retMsgForCntt="+s6945CfmRetMsg+"&opBeginTime="+opBeginTime;
 %>
 	<jsp:include page="<%=url%>" flush="true" />
 <%
 		System.out.println("%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");	
    if (s6945CfmRetCode == 0) {     
%>
	<script>
	    rdShowMessageDialog("�����ɹ���", 2);
	    location = "s6945Login.jsp?activePhone=<%=activePhone%>";
	</script>
<%
	} else {
	%>
		<script>
		    rdShowMessageDialog('����<%=s6945CfmRetCode%>��' + '<%=s6945CfmRetMsg%>�������²�����');
		    location = "s6945Login.jsp?activePhone=<%=activePhone%>";
		</script>
<%
    }
%>
