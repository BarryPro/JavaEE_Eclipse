<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="java.util.*,java.text.SimpleDateFormat"%>
<%! 
	public  String ReturnSysTime(String strStyle) {
		String s = "";
		java.util.Date date = new java.util.Date();
		java.text.SimpleDateFormat dformat = new java.text.SimpleDateFormat(strStyle);
		s = dformat.format(date);
		return s;
	}
%>
<%
	String strActivePhone = WtcUtil.repNull(request.getParameter("strAcceptPhoneNo"));
	String strContactId= WtcUtil.repNull(request.getParameter("strContactId"));
	String loginAccept="";
	System.out.println("+++++++++++++++++++strContactId:"+strContactId+"++++++++");
	System.out.println("+++++++++++++++++++strActivePhone:"+strActivePhone+"++++++++");
	if(!("").equalsIgnoreCase(strContactId)){
	 //loginAccept=strContactId.substring(10, 21);
     loginAccept=strContactId.substring(18, 21)+ReturnSysTime("ddhhmmssSS");
   }else{
   strContactId= ReturnSysTime("yyyyMMdd")+"KF"+ReturnSysTime("ddhhmmssSS");
   System.out.println("+++++++++++++++++++strContactId:"+strContactId+"++++++++");
	 //loginAccept=strContactId.substring(10, 21);
	 loginAccept=strContactId.substring(18, 21)+ReturnSysTime("ddhhmmssSS");
	 }

	if(("").equalsIgnoreCase(strActivePhone)){
	strActivePhone="13803404010";
	}
	String retCodeForCntt = "000000";
	String opCode="90027";
  String opName="¼¨Ð§¿¼ÆÀ";
%>
<wtc:service name="sUpCnttInfo" outnum="0" retcode="cnttRetCode" retmsg="cnttRetMsg">
		<wtc:param value="<%=strContactId%>" />
		<wtc:param value="<%=loginAccept%>" />
		<wtc:param value="" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=opName%>" />
		<wtc:param value="<%=loginAccept%>" />
		<wtc:param value="<%=retCodeForCntt%>" />
		<wtc:param value="<%=strActivePhone%>" />
		<wtc:param value="<%=strActivePhone%>" />
	</wtc:service>

var response = new AJAXPacket();
response.data.add("retCode","000000");
core.ajax.receivePacket(response);