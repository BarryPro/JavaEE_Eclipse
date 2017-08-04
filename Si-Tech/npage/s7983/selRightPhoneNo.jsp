<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wanglma @ 20110419
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
    String regionCode = (String)session.getAttribute("regCode");
    SimpleDateFormat df = new SimpleDateFormat("yyyyMM");
    String sysAccept = request.getParameter("sysAccept");
    String sql = " select phone_no from wloginopr"+df.format(new java.util.Date())+" where login_accept="+sysAccept;
    System.out.println("======================sql===============================    "+sql);
    String returnCode = "";
    String returnMsg = "";
    String flag = "";
    try{
        %>
         <wtc:pubselect name="sPubSelect"  retcode="retCode" retmsg="retMsg" routerKey="region" routerValue="<%=regionCode%>" outnum="1" >
  	       <wtc:sql><%=sql%></wtc:sql>
         </wtc:pubselect>
        <wtc:array id="result" scope="end" />
        <%
        returnCode = retCode;
        returnMsg = retMsg;
        System.out.println("==========-----------=======================    "+result.length);
        if(result.length > 0){
           for(int i=0;i<result.length;i++){
             flag = flag + result[i][0] + ",";
           }
        }
        System.out.println("# return from pubCheckPhoneNo.jsp by Service sCheckPhoneNo -> returnCode = "+retCode);
        System.out.println("# return from pubCheckPhoneNo.jsp by Service sCheckPhoneNo -> returnMsg  = "+retMsg);
        System.out.println("# return from pubCheckPhoneNo.jsp by Service sCheckPhoneNo -> flag  = "+flag);
    }catch(Exception e){
        returnCode = "999999";
        returnMsg = "调用服务sCheckPhoneNo失败！";
        e.printStackTrace();
    }

%>
var response = new AJAXPacket();
var result1 = "<%=flag%>";
var returnCode = "<%=returnCode%>";
var returnMessage = "<%=returnMsg%>";

response.data.add("result",result1);
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMessage);
core.ajax.receivePacket(response);
