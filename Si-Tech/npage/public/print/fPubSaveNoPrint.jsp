<%
/********************
 version v2.0
������: si-tech
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
			/***�û��ֻ���	phone_no**��������	login_no**Ʊ������	bill_type*/
 
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


		/**------------��������--------------*/

UType uBasicInfo=new UType();
	uBasicInfo.setUe("STRING",opCode);
	uBasicInfo.setUe("LONG",billType);
	uBasicInfo.setUe("STRING",arrayOrderId);
	uBasicInfo.setUe("LONG",login_accept);
	System.out.println(opCode+"      "+billType+"    "+arrayOrderId+"    "+login_accept);
/**
 * �������ӡ����
 * @inparam uInParam
 *         <uInParam>
 *           <uBasicInfo>			 ������Ϣ
 *             sOpCode �������� 
 *             lBillType Ʊ������ 
 *             serv_order_id ������ˮ 
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
     errMsg="ȡ����ӡ�ɹ���";
}else{ 
		 errCode="000001";
     errMsg="����ӡ��ʾʧ�ܣ�";
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

