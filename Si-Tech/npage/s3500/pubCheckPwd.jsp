<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-13
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
    //得到输入参数
    String cust_id = WtcUtil.repStr(request.getParameter("cust_id")," ");
    String phone_no = WtcUtil.repStr(request.getParameter("phone_no")," ");
	String service_no = WtcUtil.repStr(request.getParameter("user_no")," ");
    String retType = WtcUtil.repStr(request.getParameter("retType")," ");
    String Pwd1 = WtcUtil.repStr(request.getParameter("Pwd1")," ");
    ArrayList retArray = new ArrayList();
    //String[][] result = new String[][]{};
    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
    String retResult  = "false";
    String retCode="000000";
    String retMessage="密码校验成功！";
    try
    {
        String sqlStr = "";
        if (cust_id.trim().length() > 0) {
            sqlStr = "select cust_passwd from dCustDoc where cust_id = " + cust_id;
        } else if (phone_no.trim().length() > 0) {
            sqlStr = "select user_passwd from dCustMsg where phone_no = '" + phone_no + "' and substr(run_code,2,1) < 'a'";
        }
		else if (service_no.trim().length() > 0) {
            sqlStr = "select b.user_passwd from dAccountIdINfo a,dGrpUserMsg b where a.msisdn=b.user_no and a.service_no = '" + service_no + "' ";
        }
        //retArray = callView.sPubSelect("1",sqlStr);
%>
    <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phone_no%>" retcode="retCode2" retmsg="retMsg2" outnum="1">
    	<wtc:sql><%=sqlStr%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="result" scope="end" />
<%
        //result = (String[][])retArray.get(0);
        String cust_passwd = "";
        if(result.length > 0 && retCode2.equals("000000")){
            cust_passwd = (result[0][0]).trim();
        }
       	Pwd1 = Encrypt.encrypt(Pwd1);
       	Pwd1=Pwd1.trim();
        if (Encrypt.checkpwd2(cust_passwd,Pwd1) == 1)
            retResult = "true";
        System.out.println("客户密码Pwd1=[" + Pwd1 + "]cust_passwd=[" + cust_passwd + "]校验结果:" + retResult);
    }catch(Exception e){
        e.printStackTrace();
        retCode="0001";
        retMessage="密码校验失败！";
    }
%>
var response = new AJAXPacket();
var retType = "<%=retType%>";
var retMessage="<%=retMessage%>";
var retCode= "<%=retCode%>";
var retResult = "<%=retResult%>";

response.data.add("retType",retType);
response.data.add("retResult",retResult);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
core.ajax.receivePacket(response);
