<%
/********************
 * version v2.0
 * gaopeng 2015/03/06 10:23:14 ��������ǰ̨���ͷ�����ͬ���ط�ҵ�������
 * ������: si-tech
 ********************/
%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.util.Calendar" %>

<%!
 		/**
     * ʹ�ò���Format��ʽ��Date���ַ���
     */
    public static String format(Date date, String pattern) {
        String returnValue = "";

        if (date != null) {
            SimpleDateFormat df = new SimpleDateFormat(pattern);
            returnValue = df.format(date);
        }

        return (returnValue);
    }

%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("===gaopengSeeLog========= fm225Cfm.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		
		String specialProduct =  request.getParameter("specialProduct");
		String run_code_now =  request.getParameter("run_code_now");
		
		String opNote = "����"+iLoginNo+"����"+iOpCode+"����";
		
		
		
		Date date = new Date();
		String nowDate = format(date,"yyyyMMdd HH:mm:ss");
		
		

		
		String  inputParsm [] = new String[17];
		
		String serviceName = "";
		if("A".equals(run_code_now)){
			serviceName = "sHLRDataDeal";
			inputParsm[0] = iLoginAccept;
			inputParsm[1] = iChnSource;
			inputParsm[2] = iOpCode;
			inputParsm[3] = iLoginNo;
			inputParsm[4] = iLoginPwd;
			inputParsm[5] = iPhoneNo;
			inputParsm[6] = iUserPwd;
			inputParsm[7] = specialProduct;
			
			
		}else{
			inputParsm[0] = iLoginAccept;
			inputParsm[1] = iChnSource;
			inputParsm[2] = iOpCode;
			inputParsm[3] = iLoginNo;
			inputParsm[4] = iLoginPwd;
			inputParsm[5] = iPhoneNo;
			inputParsm[6] = iUserPwd;
			
			inputParsm[7] = opNote;
			inputParsm[8] = nowDate;
			serviceName = "sReDoRunCode";
		}
		
		String retCode11 = "";
		String retMsg11 = "";
		
		String oActualNum="";
		String oActualTotal="";
		
try{		
%>
		<wtc:service name="<%=serviceName%>" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<%if(!"A".equals(run_code_now)){%>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<%}%>
				
				
		</wtc:service>
		<wtc:array id="infoRet1"  scope="end"/>

		
			
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			
		}else{
		
		}
		}catch(Exception e){
			e.printStackTrace();
			retCode11 = "444444";
			retMsg11 = "����δ����������������ϵ����Ա��";
			%>
				var infoArray = new Array();
			<%
		}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11 %>");
response.data.add("retMsg","<%=retMsg11 %>");

core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         