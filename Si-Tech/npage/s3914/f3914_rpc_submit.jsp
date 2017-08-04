<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-15
 ********************/
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");                   //工号
	String workName = (String)session.getAttribute("workName");                 //工号姓名
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String ip_Addr  = (String)session.getAttribute("ipAddr");
	String nopass  = (String)session.getAttribute("password");                  //登陆密码
	
	Logger logger = Logger.getLogger("f3914_rpc_submit.jsp");
	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();	
	
	//获取输入的信息
	String verifyType = request.getParameter("verifyType");
	String user_id = request.getParameter("user_id");
	String group_id = request.getParameter("group_id");
	String sys_note = request.getParameter("sys_note");
	String to_note = request.getParameter("to_note");
	String login_accept = request.getParameter("login_accept");

 	String paraArr[] = new String[8];
	paraArr[0] = workNo;
	paraArr[1] = nopass;
	paraArr[2] = "3914";
	paraArr[3] = to_note;
	paraArr[4] = login_accept;
	paraArr[5] = sys_note;
	paraArr[6] = user_id;
	paraArr[7] = ip_Addr;


    int errCode=-1;
    String errMsg="";
  
	//ArrayList acceptList = new ArrayList();				
	//acceptList = impl.callFXService("s3914Cfm",paraArr,"2");
	%>
    <wtc:service name="s3914Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s3914CfmCode" retmsg="s3914CfmMsg" outnum="2" >
    	<wtc:param value="<%=paraArr[0]%>"/>
    	<wtc:param value="<%=paraArr[1]%>"/> 
        <wtc:param value="<%=paraArr[2]%>"/>
        <wtc:param value="<%=paraArr[3]%>"/>
        <wtc:param value="<%=paraArr[4]%>"/>
        <wtc:param value="<%=paraArr[5]%>"/>
        <wtc:param value="<%=paraArr[6]%>"/>
        <wtc:param value="<%=paraArr[7]%>"/>
    </wtc:service>
    <wtc:array id="s3914CfmArr" scope="end"/>
    <%
    
	//errCode=impl.getErrCode();   
	//errMsg=impl.getErrMsg();
	errCode = Integer.parseInt(s3914CfmCode);
	errMsg = s3914CfmMsg;
	   
    String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+s3914CfmCode+"&retMsgForCntt="+s3914CfmMsg
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

