<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-19
 ********************/
%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.config.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.amd.viewbean.*"%>
<%
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String password = (String)session.getAttribute("password");
	String op_code = "3505";
	String retType = request.getParameter("retType");
	String cust_code = request.getParameter("cust_code"); 
	String sm_code = request.getParameter("sm_code");
	String ip_address = (String)session.getAttribute("ipAddr");
	String service_name = "";
	int errCode = 0;
	String errMsg = "";



	 String[] paraAray = new String[7];
     String[] retList = new String[] {};
     //SPubCallSvrImpl impl = new SPubCallSvrImpl();


/* @inparam	loginAccept	流水	可以输入，如果不输入则在服务中取流水
 * @inparam	opCode	功能代码
 * @inparam	loginNo	操作工号
 * @inparam	loginPasswd	经过加密的工号密码
 * @inparam	orgCode	操作工号归属
 * @inparam	ipAddr	IP地址
 * @inparam	idcMebNo IDC用户编码
 * @inparam smCode
 * @outparam loginAccept	流水	返回在服务中生成的流水，或还原传入的流水
 * @outparam SVR_ERR_NO
 * @outparam SVR_ERR_MSG
 */
//void s3511Cfm( TPSVCINFO *transb )

        paraAray[0] = op_code;
        paraAray[1] = work_no;
        paraAray[2] = password;
        paraAray[3] = org_code;
        paraAray[4] = ip_address;
        paraAray[5] = cust_code;
		paraAray[6] = sm_code;

   
		//retList = impl.callService("s3511Cfm",paraAray,"2");
		%>
        <wtc:service name="s3511Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s3511CfmCode" retmsg="s3511CfmMsg" outnum="2" >
        	<wtc:param value="<%=paraAray[0]%>"/>
        	<wtc:param value="<%=paraAray[1]%>"/> 
            <wtc:param value="<%=paraAray[2]%>"/>
            <wtc:param value="<%=paraAray[3]%>"/>
            <wtc:param value="<%=paraAray[4]%>"/>
            <wtc:param value="<%=paraAray[5]%>"/>
            <wtc:param value="<%=paraAray[6]%>"/>
        </wtc:service>
        <wtc:array id="s3511CfmArr" scope="end"/>
        <%
		//("s3511Cfm",paraAray,"3","phone_no",phone_no);
		errCode = Integer.parseInt(s3511CfmCode);   
        errMsg = s3511CfmMsg;

		System.out.println("   ...   errCode "+errCode+"    .   . errMsg"+errMsg+"  retType"+retType);

  
		/*if (errCode == 0) {
				         errMsg = "检验用户编码信息成功!";
			}else{
					   errCode=1;
					   errMsg="该用户编码信息不存在!";
				  }*/
%>
var response = new AJAXPacket();
var retType = "";
var errCode = "";
var retMsg = "";

retType = "<%=retType%>";
errCode = "<%=errCode%>";
retMsg = "<%=errMsg%>";

response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType",retType);
response.data.add("retCode",errCode);
response.data.add("retMsg",retMsg);

core.ajax.receivePacket(response);