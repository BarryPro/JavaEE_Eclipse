<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-16
 ********************/
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%
	//��ȡ�û�session��Ϣ
	String opCode =request.getParameter("opCode");
	String opName =request.getParameter("opName");
	String workNo   = (String)session.getAttribute("workNo");                   //����
	String workName = (String)session.getAttribute("workName");                 //��������
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String ip_Addr  = (String)session.getAttribute("ipAddr");
	String nopass  = (String)session.getAttribute("password");                  //��½����
	String group_id = request.getParameter("group_id");							//�����û����
	
	Logger logger = Logger.getLogger("f3521_rpc_submit.jsp");
	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();	
	
	//��ȡ�������Ϣ
	String verifyType = request.getParameter("verifyType");
	String sys_note = request.getParameter("sys_note");
	String to_note = request.getParameter("to_note");
	String login_accept = request.getParameter("login_accept");
	String accept_no = request.getParameter("accept_no");

 	String paraArr[] = new String[8];
	paraArr[0] = workNo;
	paraArr[1] = nopass;
	paraArr[2] = "3521";
	paraArr[3] = to_note;
	paraArr[4] = login_accept;
	paraArr[5] = sys_note;
	paraArr[6] = accept_no;
	paraArr[7] = ip_Addr;


    int errCode=-1;
    String errMsg="";
  
	//ArrayList acceptList = new ArrayList();				
	//acceptList = impl.callFXService("s3521Cfm",paraArr,"2");
	%>
    <wtc:service name="s3521Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s3521CfmCode" retmsg="s3521CfmMsg" outnum="2" >
    	<wtc:param value="<%=paraArr[0]%>"/>
    	<wtc:param value="<%=paraArr[1]%>"/> 
        <wtc:param value="<%=paraArr[2]%>"/>
        <wtc:param value="<%=paraArr[3]%>"/>
        <wtc:param value="<%=paraArr[4]%>"/>
        <wtc:param value="<%=paraArr[5]%>"/>
        <wtc:param value="<%=paraArr[6]%>"/>
        <wtc:param value="<%=paraArr[7]%>"/>
    </wtc:service>
    <wtc:array id="s3521CfmArr" scope="end"/>
    <%
	//errCode=impl.getErrCode();   
	//errMsg=impl.getErrMsg();
	errCode = Integer.parseInt(s3521CfmCode);
	errMsg = s3521CfmMsg;
	   
    String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+s3521CfmCode+"&retMsgForCntt="+s3521CfmMsg
		+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+login_accept+"&pageActivePhone="+group_id
		+"&opBeginTime="+opBeginTime+"&contactId="+group_id+"&contactType=grp"; 
    System.out.println(url);
%> 
	<jsp:include page="<%=url%>" flush="true" />
         
var response = new AJAXPacket();
response.data.add("verifyType","<%=verifyType%>");
response.data.add("errorCode","<%=errCode%>");
response.data.add("errorMsg","<%=errMsg%>");
core.ajax.receivePacket(response);

