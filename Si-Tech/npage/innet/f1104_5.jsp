<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.08.29
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
/*
 输入参数： 
	手机号码
	机构编码
	业务类型
	SIM卡卡号
	SIM卡卡类型
 输出参数： 
      错误代码
      错误消息

*/

        //得到输入参数
	    //Logger logger = Logger.getLogger("f1104_5.jsp");        
        //ArrayList retArray = new ArrayList();
        //String[][] result = new String[][]{};
	    //--------------------------
	    String retType = request.getParameter("retType");
	    String sIn_Phone_no = request.getParameter("sIn_Phone_no");
	    String sIn_OrgCode = request.getParameter("sIn_OrgCode");
	    String region_code = sIn_OrgCode.substring(0,2);
	    String sIn_Sm_code = request.getParameter("sIn_Sm_code");
	    String sIn_Sim_no = request.getParameter("sIn_Sim_no");
	    String sIn_Sim_type = request.getParameter("sIn_Sim_type");
	    String sIn_zph = request.getParameter("zph");
	    String sIn_cardtype=request.getParameter("sIn_cardtype");
	    String sIn_workno=request.getParameter("workno");
	    

		//String ret_message = "";
		//int ret_code=9;
		//String[] retStr=null;
		String serviceName="sChekPhoneSimNo";
		String outParaNum="0";
		String[] paraStrIn = new String[]{sIn_Phone_no,sIn_OrgCode,sIn_Sm_code,sIn_Sim_no,sIn_Sim_type,sIn_zph,sIn_cardtype,sIn_workno};
		//SPubCallSvrImpl callSvrImpl = new SPubCallSvrImpl();
%>
	    <wtc:service name="sChekPhoneSimNo" routerKey="region" routerValue="<%=region_code%>"  retcode="ret_code" retmsg="ret_message"  outnum="4" >
        <wtc:params value="<%=paraStrIn%>"/>
		</wtc:service>
		<wtc:array id="retStr" scope="end" />

<%   

		   // retStr = callSvrImpl.callService(serviceName, paraStrIn, outParaNum);
			//callSvrImpl.printRetValue();
		   // ret_code = callSvrImpl.getErrCode();
		//	ret_message = callSvrImpl.getErrMsg();	
			System.out.println("=========================================ret_code    in f1104_5.jsp"+ret_code);
			System.out.println("=========================================ret_message        in f1104_5.jsp"+ret_message);
			
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";

retType = "<%=retType%>";
retCode = "<%=ret_code%>";
retMessage = "<%=ret_message%>";
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
core.ajax.receivePacket(response);

