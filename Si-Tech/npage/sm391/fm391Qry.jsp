<%
  /*
   * ����: 
   * �汾: 1.0
   * ����: liangyl 2017/07/20 9:50:29 ���ڹ���������ҵ��У԰�Ʒ�ģʽ����ʾ
   * ����: liangyl
   * ��Ȩ: si-tech
  */
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("===liangylSeeLog========= fm391Qry.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		
		String iSchoolName =  request.getParameter("iSchoolName");
		String iBuildNo =  request.getParameter("iBuildNo");
		String iHouseNo =  request.getParameter("iHouseNo");
		String iBroadStatu =  request.getParameter("iBroadStatu");
		
		
		String  inputParsm [] = new String[11];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = iSchoolName;
		inputParsm[8] = iBuildNo;
		inputParsm[9] = iHouseNo;
		inputParsm[10] = iBroadStatu;
		
		System.out.println("============ fm391Qry.jsp ==========" + iLoginAccept);
		System.out.println("============ fm391Qry.jsp ==========" + iChnSource);
		System.out.println("============ fm391Qry.jsp ==========" + iOpCode);
		System.out.println("============ fm391Qry.jsp ==========" + iLoginNo);
		System.out.println("============ fm391Qry.jsp ==========" + iLoginPwd);
		System.out.println("============ fm391Qry.jsp ==========" + iPhoneNo);
		System.out.println("============ fm391Qry.jsp ==========" + iUserPwd);
		System.out.println("============ fm391Qry.jsp ==========" + iSchoolName);
		System.out.println("============ fm391Qry.jsp ==========" + iBuildNo);
		System.out.println("============ fm391Qry.jsp ==========" + iHouseNo);
		System.out.println("============ fm391Qry.jsp ==========" + iBroadStatu);
		
		
		
		String retCode11 = "";
		String retMsg11 = "";
		String phoneMsg = "";
		
try{		
%>
		<wtc:service name="sCampusBroadQry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="11">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=inputParsm[9]%>"/>
				<wtc:param value="<%=inputParsm[10]%>"/>
		</wtc:service>
		<wtc:array id="infoRet1" scope="end"/>
		
			
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			System.out.println("============ fm391Qry.jsp ==========" + infoRet1.length);
				//�ֻ�����|�Ͽͻ�����|�¿ͻ�����|��֤������|�¿ͻ���ַ|24�������Ʊ�ʶ
				
				for(int i=0;i<infoRet1.length;i++){
				%>
					infoArray[<%=i%>] = new Array();
					infoArray[<%=i%>][0] = "<%=infoRet1[i][0]%>";
					infoArray[<%=i%>][1] = "<%=infoRet1[i][1]%>";
					infoArray[<%=i%>][2] = "<%=infoRet1[i][2]%>";
				<%
				
			System.out.println("============ fm391Qry.jsp ==========infoRet1["+i+"][0]" + infoRet1[i][0]);
			System.out.println("============ fm391Qry.jsp ==========infoRet1["+i+"][1]" + infoRet1[i][1]);
			System.out.println("============ fm391Qry.jsp ==========infoRet1["+i+"][2]" + infoRet1[i][2]);
			System.out.println("============ fm391Qry.jsp ==========infoRet1["+i+"][3]" + infoRet1[i][3]);
			System.out.println("============ fm391Qry.jsp ==========infoRet1["+i+"][4]" + infoRet1[i][4]);
			System.out.println("============ fm391Qry.jsp ==========infoRet1["+i+"][5]" + infoRet1[i][5]);
		
			
				}
			
		}else{
			System.out.println("============ fm391Qry.jsp ʧ��==========");
		}
		}catch(Exception e){
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
response.data.add("infoArray",infoArray);
response.data.add("phoneMsg","<%=phoneMsg %>");
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         