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
	
	String show_phone = (String)request.getParameter("show_phone");
	
	String paraAray[] = new String[12];

    paraAray[0] = request.getParameter("open_type");//������
	paraAray[1] = request.getParameter("family_code");//��ͥ����
    paraAray[2] = request.getParameter("home_no");//��Ա����
	paraAray[3] = request.getParameter("phoneNo");//�ҳ�����
	paraAray[4] = request.getParameter("new_rate_code");//�ʷѴ���
	paraAray[5] = work_no;//����
	paraAray[6] = org_code;//��������
    paraAray[7] = request.getParameter("op_code");;//��������     
	paraAray[8] = request.getParameter("rate_name");//���ײʹ���
	paraAray[9] = "0";//��Ч��־
 	paraAray[10] = request.getParameter("opNote");//������ע
	paraAray[11] = request.getParameter("printAccept");//��ӡ��ˮ
 	
 	for(int ii=0;ii<paraAray.length;ii++)
 	System.out.println("# paraAray = "+paraAray[ii]);
	//String[] ret = impl.callService("s7123Cfm",paraAray,"2");
%>
	<wtc:service name="s7123CfmEx" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">			
	<wtc:param value="<%=paraAray[0]%>"/>	
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>	
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>	
	<wtc:param value="<%=paraAray[7]%>"/>
	<wtc:param value="<%=paraAray[8]%>"/>
	<wtc:param value="<%=paraAray[9]%>"/>	
	<wtc:param value="<%=paraAray[10]%>"/>
	<wtc:param value="<%=paraAray[11]%>"/>
	</wtc:service>	
	<wtc:array id="result"  scope="end"/>
<%
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+paraAray[7]+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[11]+"&pageActivePhone="+show_phone+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime+"&contactId="+show_phone+"&contactType=user"; 
	System.out.println("############################fg123Cfm->url->"+url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%	
	String errCode = retCode1;
	String errMsg = retMsg1;
	if (errCode.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("��ͥ����ƻ�����ɹ�!",2);
   removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("��ͥ����ƻ����ʧ��!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	history.go(-1);
</script>
<%}%>
