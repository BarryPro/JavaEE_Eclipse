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
	String loginPwd = (String)session.getAttribute("password");
	String org_code = (String)session.getAttribute("orgCode");
	String regCode = (String)session.getAttribute("regCode");
	String returnPage = WtcUtil.repNull(request.getParameter("return_page"));
	String opName = "��ͥ����ƻ����";
	String op_flag = request.getParameter("open_type");//��������
	String show_phone = (String)request.getParameter("show_phone");

	String paraAray[] = new String[13];

    paraAray[0] = request.getParameter("open_type");	//������
	paraAray[1] = request.getParameter("family_code");	//��ͥ����
    if(op_flag.equals("1") || op_flag.equals("4"))
    {
    paraAray[2] = request.getParameter("home_no"); 	//�����ͥ�ĳ�Ա����
	}
	else if(op_flag.equals("2"))
	{
		paraAray[2] = request.getParameter("show_phone");	//�˳���ͥ�ĳ�Ա����
	}
	paraAray[3] = request.getParameter("phoneNo");	//�ҳ�����
	paraAray[4] = work_no;	//����
	paraAray[5] = org_code;	//��������
  paraAray[6] = request.getParameter("op_code");	//��������
 	paraAray[7] = request.getParameter("opNote");	//������ע
	paraAray[8] = request.getParameter("printAccept");	//��ӡ��ˮ
	paraAray[12] = loginPwd;	//��������

	//String[] ret = impl.callService("s7328Cfm",paraAray,"2");
%>
	<wtc:service name="s7328Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">
	<wtc:param value="<%=paraAray[8]%>"/>
	<wtc:param value="01"/>	
	<wtc:param value="<%=paraAray[6]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[12]%>"/>	
	<wtc:param value="<%=paraAray[2]%>"/>		
	<wtc:param value=""/>							
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>		
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[7]%>"/>

	</wtc:service>
	<wtc:array id="result"  scope="end"/>
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+paraAray[6]+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[8]+"&pageActivePhone="+show_phone+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime+"&contactId="+show_phone+"&contactType=user";
	System.out.println("############################f7328Cfm->url->"+url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	String errCode = retCode1;
	String errMsg = retMsg1;
	if (errCode.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("ҵ�����ɹ�!",2);
   if(("<%=returnPage%>"!="")&&("<%=op_flag%>"=="2"))
   {
   		removeCurrentTab();
   	}
   	else if(("<%=returnPage%>"!="")&&(("<%=op_flag%>"=="0")||("<%=op_flag%>"=="1")||("<%=op_flag%>"=="3")||("<%=op_flag%>"=="4")   ))
	{
  		location="<%=returnPage%>";
	}
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("ҵ�����ʧ��!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	history.go(-1);
</script>
<%}%>
