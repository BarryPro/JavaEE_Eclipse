<%
/********************
 version v2.0
开发商: si-tech
*
*update:yanpx@2008-11-12 
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
 

<%	
			/***用户手机号	phone_no**操作工号	login_no**票据类型	bill_type*/
 
		String opCode=request.getParameter("opCode");
		String login_accept=request.getParameter("login_accept");
		String retType=request.getParameter("retType");
		String billType=request.getParameter("billType");
		String phoneNo=request.getParameter("phoneNo");
		String arrayOrderId=request.getParameter("arrayOrderId");
		
		
	    String errCode="";
	    String errMsg="";
	    
	    System.out.println("opCode="+opCode);
	    System.out.println("login_accept="+login_accept);
	    System.out.println("retType="+retType);
	    System.out.println("billType="+billType);


		/**------------构建参数--------------*/

UType uBasicInfo=new UType();
	uBasicInfo.setUe("STRING",opCode);
	uBasicInfo.setUe("LONG",billType);
	uBasicInfo.setUe("STRING",arrayOrderId);
	uBasicInfo.setUe("LONG",login_accept);
	System.out.println(opCode+"      "+billType+"    "+arrayOrderId+"    "+login_accept);
/**
 * 免填单不打印服务
 * @inparam uInParam
 *         <uInParam>
 *           <uBasicInfo>			 基本信息
 *             sOpCode 操作代码 
 *             lBillType 票据类型 
 *             serv_order_id 操作流水 
 *           </uBasicInfo>
 *         </uInParam>
 * @author	wangmq
 * @return NULL
*/
%>

	<wtc:utype name="sCtOEltDPrint" id="retVal" scope="end">
		<wtc:uparam value="<%=uBasicInfo%>" type="UTYPE"/>
	</wtc:utype>

<%
String retCode=retVal.getValue(0).trim();
String retMsg=retVal.getValue(1);


if(retCode.equals("0")){   
		 errCode="000000";
     errMsg="取消打印成功！";
}else{ 
		 errCode="000001";
     errMsg="不打印标示失败！";
}
%>
var response = new AJAXPacket();
var retType = "";
var errCode = ""
var errMsg = "";
retType = "<%=retType%>";
errCode = "<%=errCode%>";
errMsg = "<%=errMsg%>";

response.data.add("retType",retType);
response.data.add("errCode",errCode);
response.data.add("errMsg",errMsg);
core.ajax.receivePacket(response);

