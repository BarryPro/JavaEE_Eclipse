<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%!
public static String createArray(String aimArrayName, int xDimension)
{
	String stringArray = "var " + aimArrayName + " = new Array(";
	int flag = 1;
	for(int i = 0; i < xDimension; i++)
	{
		if(flag == 1)
		{
			stringArray = stringArray + "new Array()";
			flag = 0;
			continue;
		}
		if(flag == 0)
		{
			stringArray = stringArray + ",new Array()";
		}
	}
	stringArray = stringArray + ");";
	return stringArray;
}
%>
<%
String dateStr2 =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
String[] inPubParams = new String[29];
inPubParams[0] = request.getParameter("loginAccept");//������ˮ
inPubParams[1] = request.getParameter("iChnSource");//������ʶ
inPubParams[2] = request.getParameter("opCode"); 
inPubParams[3] = request.getParameter("workNo");//����Ա����
inPubParams[4] = (String) session.getAttribute("password");//����Ա����

inPubParams[5] = request.getParameter("phoneNo");//�������
inPubParams[6] = request.getParameter("iUserPwd");//�û�����
inPubParams[7] = request.getParameter("radioIndex");//��������
inPubParams[8] = request.getParameter("phoneNo");//�������
inPubParams[9] = request.getParameter("cfmLogin");//����˺�

inPubParams[10] = request.getParameter("0");//���������
inPubParams[11] = request.getParameter("0");//����˺�������
inPubParams[12] = request.getParameter("vPhoneNo");//ת�����
inPubParams[13] = request.getParameter("vConID");//ת���˺�   
inPubParams[14] = request.getParameter("backPrepay");//ת����  
    
inPubParams[15] = request.getParameter("orgCode");
inPubParams[16] = request.getParameter("handFee");
inPubParams[17] = request.getParameter("factPay");
inPubParams[18] = request.getParameter("ipAdd");
inPubParams[19] =  request.getParameter("construct_request")==null?"û��":request.getParameter("construct_request");

inPubParams[20] =  request.getParameter("appointTime")==null?dateStr2:request.getParameter("appointTime");
inPubParams[21] = request.getParameter("sysRemark");

/*����Դ��Ϣ*/
inPubParams[22] = request.getParameter("portCodeOld");
inPubParams[23] = request.getParameter("deviceCodeOld");
inPubParams[24] = request.getParameter("ipAddressOld");
inPubParams[25] = request.getParameter("deviceInAddressOld");
inPubParams[26] = request.getParameter("cctIdOld");
/*inPubParams[26] = "001";*/
inPubParams[27] = "";//��׼��ַ��
inPubParams[28] = "";//��׼��ַ��
%>
<wtc:service name="sBroadBandChg"  outnum="3" 
	routerKey="phone" routerValue="<%=inPubParams[2]%>">
	<wtc:param value="<%=inPubParams[0]%>"/>
	<wtc:param value="<%=inPubParams[1]%>"/>
	<wtc:param value="<%=inPubParams[2]%>"/>
	<wtc:param value="<%=inPubParams[3]%>"/>
	<wtc:param value="<%=inPubParams[4]%>"/>
	<wtc:param value="<%=inPubParams[5]%>"/>
	<wtc:param value="<%=inPubParams[6]%>"/>
	<wtc:param value="<%=inPubParams[7]%>"/>
	<wtc:param value="<%=inPubParams[8]%>"/>
	<wtc:param value="<%=inPubParams[9]%>"/>	
	<wtc:param value="<%=inPubParams[10]%>"/>
	<wtc:param value="<%=inPubParams[11]%>"/>
	<wtc:param value="<%=inPubParams[12]%>"/>
	<wtc:param value="<%=inPubParams[13]%>"/>
	<wtc:param value="<%=inPubParams[14]%>"/>	
	<wtc:param value="<%=inPubParams[15]%>"/>	
	<wtc:param value="<%=inPubParams[16]%>"/>
	<wtc:param value="<%=inPubParams[17]%>"/>
	<wtc:param value="<%=inPubParams[18]%>"/>	
	<wtc:param value="<%=inPubParams[19]%>"/>	
	<wtc:param value="<%=inPubParams[20]%>"/>	
	<wtc:param value="<%=inPubParams[21]%>"/>
	<wtc:param value="<%=inPubParams[22]%>"/>
	<wtc:param value="<%=inPubParams[23]%>"/>	
	<wtc:param value="<%=inPubParams[24]%>"/>
	<wtc:param value="<%=inPubParams[25]%>"/>
	<wtc:param value="<%=inPubParams[26]%>"/>	
	<wtc:param value="<%=inPubParams[27]%>"/>
	<wtc:param value="<%=inPubParams[28]%>"/>	
</wtc:service>
<wtc:array id="backInfo" scope="end"/>
<%
    String errCode = retCode;
    String errMsg = retMsg;
    String b540LoginAccept="";
    if(backInfo.length>0){
    	b540LoginAccept = backInfo[0][0];
    	System.out.println("###################################f1213->f1213LoginAccept->"+b540LoginAccept);
    }
    //����ͳһ�Ӵ�	
    String opBeginTime1  = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());//ҵ��ʼʱ��
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+inPubParams[0]+"&retCodeForCntt="+retCode+"&opName=�ۺϱ��&workNo="+inPubParams[6]+"&loginAccept="+b540LoginAccept+"&pageActivePhone="+inPubParams[2]+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime1;
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
    System.out.println("Msg1 :" + errCode + ":" + errMsg);
    System.out.println(backInfo.length);
    String strArray = createArray("backInfo", backInfo.length);
%>
		<%=strArray%>
<%
		if(backInfo.length>0){
    	for (int j = 0; j < backInfo[0].length; j++) {
    	    	    System.out.println("backInfo[0][j]===="+backInfo[0][j]);
%>
				backInfo[0][<%=j%>] = "<%=backInfo[0][j]%>";
<%
    	}
    }
%>

		var response = new AJAXPacket();
		response.data.add("backString",backInfo);
		response.data.add("flag","1");
		response.data.add("errCode","<%=errCode%>");
		response.data.add("errMsg","<%=errMsg%>");
		core.ajax.receivePacket(response);

