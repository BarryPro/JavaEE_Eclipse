
<%@ page contentType="text/html; charset=GBK" %>
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
	    String sIn_offerId=request.getParameter("offerId");
	    String sIn_simType=request.getParameter("simType");
      /*begin diling add for 关于对特殊号码审批专项测试结果进行优化的需求 增加参数：custIccid @2012/5/28 */
      String custIccid=(String)request.getParameter("custIccid")==null?"":(String)request.getParameter("custIccid");
      /*end diling add*/
	    String offerId = "";

		String[] paraStrIn = new String[]{sIn_Phone_no,sIn_OrgCode,sIn_Sm_code,sIn_Sim_no,sIn_Sim_type,sIn_zph,sIn_cardtype,sIn_workno,custIccid,sIn_offerId,sIn_simType};
		
		for(int hjw=0;hjw<paraStrIn.length;hjw++){
			System.out.println("---------------------------paraStrIn["+hjw+"]--------------------"+paraStrIn[hjw]);
		}

%>
	    <wtc:service name="sChekPhoneSimNo" routerKey="region" routerValue="<%=region_code%>"  retcode="ret_code" retmsg="ret_message"  outnum="4" >
        <wtc:params value="<%=paraStrIn%>"/>
		</wtc:service>
		<wtc:array id="retStr" scope="end" />
		
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

