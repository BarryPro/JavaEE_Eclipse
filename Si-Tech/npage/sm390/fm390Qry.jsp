<%
/********************
 * version v2.0
 * gaopeng 2015/02/11 9:50:29 关于哈尔滨分公司申请批量更正客户信息以及进行系统优化的请示
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("===gaopengSeeLog========= fm390Qry.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		String opAccept =  request.getParameter("opAccept");
		
		
		String  inputParsm [] = new String[11];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = opAccept;
		
		
		
		
		
		String retCode11 = "";
		String retMsg11 = "";
		String phoneMsg = "";
		String phoneIdNo = "";
		
try{		
%>
		<wtc:service name="sm376Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="7">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="m058"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
		</wtc:service>
		<wtc:array id="infoRet1" start="0" length="6"    scope="end"/>
		<wtc:array id="retStr2" start="6" length="1"  scope="end"/>
		
			
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			System.out.println("============ fm390Qry.jsp ==========" + infoRet1.length);
				//手机号码|老客户名称|新客户名称|新证件号码|新客户地址|24个月限制标识
				if(retStr2.length > 0){
					phoneMsg = retStr2[0][0];
					String phoneNNO =  phoneMsg.split("\\|")[0];
					
					String  inParamsMigu [] = new String[2];
			    inParamsMigu[0] = "select to_char(id_no) from dcustmsg where phone_no =:phoneNNO";
			    inParamsMigu[1] = "phoneNNO="+phoneNNO;
			    
			    %>
			    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1"> 
				    <wtc:param value="<%=inParamsMigu[0]%>"/>
				    <wtc:param value="<%=inParamsMigu[1]%>"/> 
			  	</wtc:service>  
			  <wtc:array id="result_migu"  scope="end"/>
			    <%
			    
			    if(result_migu.length > 0){
			    	phoneIdNo = result_migu[0][0];
			    	System.out.println("============ fm390Qry.jsp ========phoneIdNo==" + phoneIdNo);
			    }
    
				}
				
				for(int i=0;i<infoRet1.length;i++){
					if("0".equals(infoRet1[i][3]) || "2".equals(infoRet1[i][3])){
						infoRet1[i][4] = "";
					}else if("3".equals(infoRet1[i][3])){
						infoRet1[i][4] = "不能进行实名登记！";
					}
				%>
					infoArray[<%=i%>] = new Array();
					infoArray[<%=i%>][0] = "<%=infoRet1[i][0]%>";
					infoArray[<%=i%>][1] = "<%=infoRet1[i][1]%>";
					infoArray[<%=i%>][2] = "<%=infoRet1[i][2]%>";
					infoArray[<%=i%>][3] = "<%=infoRet1[i][3]%>";
					infoArray[<%=i%>][4] = "<%=infoRet1[i][4]%>";
					infoArray[<%=i%>][5] = "<%=infoRet1[i][5]%>";
					
					
					
				<%
				
			System.out.println("============ fm390Qry.jsp ==========infoRet1["+i+"][0]" + infoRet1[i][0]);
			System.out.println("============ fm390Qry.jsp ==========infoRet1["+i+"][1]" + infoRet1[i][1]);
			System.out.println("============ fm390Qry.jsp ==========infoRet1["+i+"][2]" + infoRet1[i][2]);
			System.out.println("============ fm390Qry.jsp ==========infoRet1["+i+"][3]" + infoRet1[i][3]);
			System.out.println("============ fm390Qry.jsp ==========infoRet1["+i+"][4]" + infoRet1[i][4]);
			System.out.println("============ fm390Qry.jsp ==========infoRet1["+i+"][5]" + infoRet1[i][5]);
		
			
				}
			
		}else{
			System.out.println("============ fm390Qry.jsp 失败==========");
		}
		}catch(Exception e){
			retCode11 = "444444";
			retMsg11 = "服务未启动或不正常，请联系管理员！";
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
response.data.add("phoneIdNo","<%=phoneIdNo %>");


core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         