<%

/********************

 * version v2.0

 * 开发商: si-tech

 * update by qidp @ 2009-01-16

 ********************/

%>

<%@page contentType="text/html;charset=GBK"%>

<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="org.apache.log4j.Logger"%>

<%

	//读取用户session信息

	String opCode ="g222";

	String opName ="集团成员包年续签冲正";

	String workNo   = (String)session.getAttribute("workNo");                   //工号

	String workName = (String)session.getAttribute("workName");                 //工号姓名

	String org_code = (String)session.getAttribute("orgCode");

	String regionCode = org_code.substring(0,2);

	String ip_Addr  = (String)session.getAttribute("ipAddr");

	String nopass  = (String)session.getAttribute("password");                  //登陆密码

	String group_id = request.getParameter("group_id");							//集团用户编号

	

	Logger logger = Logger.getLogger("fg222_qry.jsp");

	

	//SPubCallSvrImpl impl = new SPubCallSvrImpl();	

	

	//获取输入的信息

	String verifyType = request.getParameter("verifyType");

	String sys_note = request.getParameter("sys_note");

	String to_note = request.getParameter("to_note");

	String login_accept = request.getParameter("login_accept");

	String accept_no = request.getParameter("accept_no");



 	String paraArr[] = new String[8];

	paraArr[0] = workNo;

	paraArr[1] = nopass;

	paraArr[2] = "1037";

	paraArr[3] = to_note;

	paraArr[4] = login_accept;

	paraArr[5] = sys_note;

	paraArr[6] = accept_no;

	paraArr[7] = ip_Addr;





    int errCode=-1;

    String errMsg="";

  

	//ArrayList acceptList = new ArrayList();				

	//acceptList = impl.callFXService("s1037Cfm",paraArr,"2");

	%>

    <wtc:service name="s222Init" routerKey="region" routerValue="<%=regionCode%>" retcode="s3521CfmCode" retmsg="s3521CfmMsg" outnum="12" >

    	<wtc:param value="0"/>

    	<wtc:param value="01"/> 

        <wtc:param value="<%=opCode%>"/>

        <wtc:param value="<%=workNo%>"/>

        <wtc:param value="<%=nopass%>"/>

        <wtc:param value=""/>

        <wtc:param value=""/>

        <wtc:param value="<%=accept_no%>"/>

    </wtc:service>

    <wtc:array id="s3521CfmArr" scope="end"/>

    <%

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

response.data.add("errorCode","<%=s3521CfmCode%>");

response.data.add("errorMsg","<%=s3521CfmMsg%>");
<%if(s3521CfmArr.length>0) {%>
response.data.add("jtuserid","<%=s3521CfmArr[0][0]%>");
response.data.add("jtprodid","<%=s3521CfmArr[0][1]%>");
response.data.add("jtprodname","<%=s3521CfmArr[0][2]%>");
response.data.add("jtkehuid","<%=s3521CfmArr[0][3]%>");
response.data.add("jtkehuname","<%=s3521CfmArr[0][4]%>");
response.data.add("caozuotime","<%=s3521CfmArr[0][5]%>");
response.data.add("liushui","<%=s3521CfmArr[0][6]%>");
response.data.add("yingyeyuan","<%=s3521CfmArr[0][7]%>");
response.data.add("bgqproductid","<%=s3521CfmArr[0][8]%>");
response.data.add("bgqproductname","<%=s3521CfmArr[0][9]%>");
response.data.add("bghproductid","<%=s3521CfmArr[0][10]%>");
response.data.add("bghproductname","<%=s3521CfmArr[0][11]%>");
<%}%>
core.ajax.receivePacket(response);



