<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-16
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
    //得到输入参数
    String LoginNo = WtcUtil.repStr(request.getParameter("LoginNo")," ");        
    String orgCode = WtcUtil.repStr(request.getParameter("orgCode")," ");   
    String regionCode = orgCode.substring(0,2);    
    String Mng_user = WtcUtil.repStr(request.getParameter("Mng_user")," ");       
    String retType = WtcUtil.repStr(request.getParameter("retType")," ");        
    String op_code = WtcUtil.repStr(request.getParameter("op_code")," ");           
    //ArrayList retArray = new ArrayList();
    String[][] result = new String[][]{};
    String[] paramsIn = null;
    
    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
    String retResult  = "true";
    int retCode=0;
    String retMessage="校验成功！";
   
    paramsIn = new String[4];
    paramsIn[0] = LoginNo;
    paramsIn[1] = orgCode;
    paramsIn[2] = op_code;
    paramsIn[3] = Mng_user;

    //retArray = callView.callFXService("s6720MngCheck", paramsIn, "4", "region", "01");
    try{
    %>
        <wtc:service name="s6720MngCheckE" routerKey="region" routerValue="<%=regionCode%>" retcode="s6720MngCheckCode" retmsg="s6720MngCheckMsg" outnum="4" >
        	<wtc:param value="<%=paramsIn[0]%>"/>
        	<wtc:param value="<%=paramsIn[1]%>"/> 
    	    <wtc:param value="<%=paramsIn[2]%>"/>
    	    <wtc:param value="<%=paramsIn[3]%>"/>
        </wtc:service>
        <wtc:array id="s6720MngCheckArr" scope="end"/>
    <%
        retCode = Integer.parseInt(s6720MngCheckCode);
        retMessage = s6720MngCheckMsg;
        //callView.printRetValue();
        //retCode = callView.getErrCode(); 
        //retMessage = callView.getErrMsg();  
        System.out.println("# return from CheckMng_user.jsp -> retCode = "+retCode);
        System.out.println("# return from CheckMng_user.jsp -> retMessage = "+retMessage);
    }catch(Exception e){
        System.out.println("# Call Service s6720MngCheck Failed!");
        retCode = 99;
        retMessage="调用服务s6720MngCheck失败！";
        e.printStackTrace();
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
