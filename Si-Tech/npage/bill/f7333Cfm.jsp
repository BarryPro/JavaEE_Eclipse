<%
/********************
 version v2.0
 ������: si-tech
 ģ��: ��ͥ����ƻ����
 update zhaohaitao at 2009.1.6
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>


<%	
	String work_no = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String regCode = (String)session.getAttribute("regCode"); 
	String opName = "��ͥ����ƻ����";
	String returnPage = WtcUtil.repNull(request.getParameter("return_page"));
	String show_phone = (String)request.getParameter("main_card");
	String opType = (String)request.getParameter("op_type");
	String paraAray[] = new String[17];
String loginPwd    = (String)session.getAttribute("password");
    paraAray[7] = request.getParameter("op_type");//������
    paraAray[8] = request.getParameter("main_card"); //�ҳ�����
    paraAray[9] = request.getParameter("fam_prod_id");//��ͥ��Ʒ����
	paraAray[3] = work_no;//����
	paraAray[10] = org_code;//��������
    paraAray[2] = request.getParameter("op_code");;//��������     
 	paraAray[11] = request.getParameter("opNote");//������ע
	paraAray[12] = request.getParameter("printAccept");//��ӡ��ˮ
	paraAray[13] = request.getParameter("friend_no"); //�������
 	paraAray[14] = request.getParameter("new_friend_no"); //���������
 	paraAray[15] = request.getParameter("pay_fee"); //���������
 	paraAray[16] = request.getParameter("village"); //С������
	//String[] ret = impl.callService("s7333Cfm",paraAray,"2");
%>
	<wtc:service name="s7333Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="11">			
	<wtc:param value="<%=paraAray[0]%>"/>	
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>	
	<wtc:param value="<%=loginPwd%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>	
	<wtc:param value="<%=paraAray[7]%>"/>
	<wtc:param value="<%=paraAray[8]%>"/>
	<wtc:param value="<%=paraAray[9]%>"/>
	<wtc:param value="<%=paraAray[10]%>"/>	
	<wtc:param value="<%=paraAray[11]%>"/>	
	<wtc:param value="<%=paraAray[12]%>"/>	
	<wtc:param value="<%=paraAray[13]%>"/>	
	<wtc:param value="<%=paraAray[14]%>"/>	
	<wtc:param value="<%=paraAray[15]%>"/>
	<wtc:param value="<%=paraAray[16]%>"/>	
	</wtc:service>	
	<wtc:array id="result"  scope="end"/>
<%
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+paraAray[5]+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[7]+"&pageActivePhone="+show_phone+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime+"&contactId="+show_phone+"&contactType=user"; 
	System.out.println("############################f7123Cfm->url->"+url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%	
	String errCode = retCode1;
	String errMsg = retMsg1;
	if (errCode.equals("000000"))
	{
%>
<script language="JavaScript">	
	   rdShowMessageDialog("��ͥ��Ʒ�������ɹ�!",2);
	   location="<%=returnPage%>";
   //removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("��ͥ����Ʒ������ʧ��!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	window.location = "f7333_login.jsp?activePhone=<%=show_phone%>&opCode=<%=paraAray[2]%>&opName=���ļ�ͥ��Ʒ����";
</script>
<%}%>
