<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/01/01 关于物联卡功能优化的需求
* 作者: liangyl
* 版权: si-tech
*/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("===gaopengSeeLog========= fm239Qry.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		String startCust =  request.getParameter("startCust");
		
		String opType =  request.getParameter("opType");
		String startphoneNo =  request.getParameter("startphoneNo");
		String endphoneNo =  request.getParameter("endphoneNo");
		
		if(iPhoneNo != null && !"".equals(iPhoneNo)){
			String iPhoneNoHead10648 = iPhoneNo.substring(0,5);
			String iPhoneNoHead147 = iPhoneNo.substring(0,3);
			
			
			/*
			if("10648".equals(iPhoneNoHead10648)){
				iPhoneNo = iPhoneNo.replaceFirst("10648","205");
			}
			else if("147".equals(iPhoneNoHead147)){
				iPhoneNo = iPhoneNo.replaceFirst("147","206");
			}
			*/
			%>
			
			<wtc:service name="sm317Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_sTSInfoBack" retmsg="retMessage_sTSInfoBack" outnum="1"> 
		    <wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=iOpCode%>"/>
				<wtc:param value="<%=iLoginNo%>"/>
				<wtc:param value="<%=iLoginPwd%>"/>
				<wtc:param value="<%=iPhoneNo%>"/>
			  <wtc:param value=""/>
		  </wtc:service>  
		  <wtc:array id="result_sTSInfoBack"  scope="end"/>
	
		<%
		if(result_sTSInfoBack.length > 0){
			iPhoneNo = result_sTSInfoBack[0][0];
			System.out.println("gaopengSeeLogm239-----------------iPhoneNo="+iPhoneNo);
		}
		%>
		
			<%
			
		}
		if(startphoneNo != null && !"".equals(startphoneNo)){
			String iPhoneNoHead10648 = startphoneNo.substring(0,5);
			String iPhoneNoHead147 = startphoneNo.substring(0,3);
			/*
			if("10648".equals(iPhoneNoHead10648)){
				startphoneNo = startphoneNo.replaceFirst("10648","205");
			}
			else if("147".equals(iPhoneNoHead147)){
				startphoneNo = startphoneNo.replaceFirst("147","206");
			}
			*/
			%>
			<wtc:service name="sm317Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_sTSInfoBack2" retmsg="retMessage_sTSInfoBack2" outnum="1"> 
		    <wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=iOpCode%>"/>
				<wtc:param value="<%=iLoginNo%>"/>
				<wtc:param value="<%=iLoginPwd%>"/>
				<wtc:param value="<%=startphoneNo%>"/>
			  <wtc:param value=""/>
		  </wtc:service>  
		  <wtc:array id="result_sTSInfoBack2"  scope="end"/>
	
		<%
		if(result_sTSInfoBack2.length > 0){
			startphoneNo = result_sTSInfoBack2[0][0];
			System.out.println("gaopengSeeLogm239-----------------startphoneNo="+startphoneNo);
		}
		%>
			<%
			
		}
		if(endphoneNo != null && !"".equals(endphoneNo)){
			String iPhoneNoHead10648 = endphoneNo.substring(0,5);
			String iPhoneNoHead147 = endphoneNo.substring(0,3);
			/*
			if("10648".equals(iPhoneNoHead10648)){
				endphoneNo = endphoneNo.replaceFirst("10648","205");
			}
			else if("147".equals(iPhoneNoHead147)){
				endphoneNo = endphoneNo.replaceFirst("147","206");
			}
			*/
			%>
			<wtc:service name="sm317Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_sTSInfoBack3" retmsg="retMessage_sTSInfoBack3" outnum="1"> 
		    <wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=iOpCode%>"/>
				<wtc:param value="<%=iLoginNo%>"/>
				<wtc:param value="<%=iLoginPwd%>"/>
				<wtc:param value="<%=endphoneNo%>"/>
			  <wtc:param value=""/>
		  </wtc:service>  
		  <wtc:array id="result_sTSInfoBack3"  scope="end"/>
	
		<%
		if(result_sTSInfoBack3.length > 0){
			endphoneNo = result_sTSInfoBack3[0][0];
			System.out.println("gaopengSeeLogm239-----------------endphoneNo="+endphoneNo);
		}
		%>
			<%
			
		}
		
		String  inputParsm [] = new String[14];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = startCust;
		
		inputParsm[8] = opType;
		inputParsm[9] = startphoneNo;
		inputParsm[10] = endphoneNo;
		
		
		
		
		
		String retCode11 = "";
		String retMsg11 = "";
		
		String prt_flag  = "0";
try{		
%>
		<wtc:service name="m239Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="17">
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
	<wtc:array id="infoRet1" scope="end" start="0"  length="16"  />
	<wtc:array id="result_t" scope="end" start="16"  length="1" />
			
	var infoArray = new Array();
	
<%
	
 
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
		
			if(result_t.length>0){
				prt_flag  = result_t[0][0];
			}
			System.out.println("============ fm239Qry.jsp ==========" + infoRet1.length);
			
				for(int i=0;i<infoRet1.length;i++){
					
				%>
					infoArray[<%=i%>] = new Array();
					infoArray[<%=i%>][0] = "<%=infoRet1[i][0]%>";
					infoArray[<%=i%>][1] = "<%=infoRet1[i][1]%>";
					infoArray[<%=i%>][2] = "<%=infoRet1[i][2]%>";
					infoArray[<%=i%>][3] = "<%=infoRet1[i][3]%>";
					infoArray[<%=i%>][4] = "<%=infoRet1[i][4]%>";
					infoArray[<%=i%>][5] = "<%=infoRet1[i][5]%>";
					infoArray[<%=i%>][6] = "<%=infoRet1[i][6]%>";
					infoArray[<%=i%>][7] = "<%=infoRet1[i][7]%>";
					infoArray[<%=i%>][8] = "<%=infoRet1[i][8]%>";
					infoArray[<%=i%>][9] = "<%=infoRet1[i][9]%>";
					infoArray[<%=i%>][10] = "<%=infoRet1[i][10]%>";
					infoArray[<%=i%>][11] = "<%=infoRet1[i][11]%>";
					infoArray[<%=i%>][12] = "<%=infoRet1[i][12]%>";
					infoArray[<%=i%>][13] = "<%=infoRet1[i][13]%>";
					infoArray[<%=i%>][14] = "<%=infoRet1[i][14]%>";
					infoArray[<%=i%>][15] = "<%=infoRet1[i][15]%>";
				
					
				<%
				
			System.out.println("============ fm239Qry.jsp ==========infoRet1["+i+"][0]" + infoRet1[i][0]);
			System.out.println("============ fm239Qry.jsp ==========infoRet1["+i+"][1]" + infoRet1[i][1]);
			System.out.println("============ fm239Qry.jsp ==========infoRet1["+i+"][2]" + infoRet1[i][2]);
			System.out.println("============ fm239Qry.jsp ==========infoRet1["+i+"][3]" + infoRet1[i][3]);
			System.out.println("============ fm239Qry.jsp ==========infoRet1["+i+"][4]" + infoRet1[i][4]);
			System.out.println("============ fm239Qry.jsp ==========infoRet1["+i+"][5]" + infoRet1[i][5]);
			System.out.println("============ fm239Qry.jsp ==========infoRet1["+i+"][6]" + infoRet1[i][6]);
			System.out.println("============ fm239Qry.jsp ==========infoRet1["+i+"][7]" + infoRet1[i][7]);
			System.out.println("============ fm239Qry.jsp ==========infoRet1["+i+"][8]" + infoRet1[i][8]);
			System.out.println("============ fm239Qry.jsp ==========infoRet1["+i+"][9]" + infoRet1[i][9]);
			System.out.println("============ fm239Qry.jsp ==========infoRet1["+i+"][10]" + infoRet1[i][10]);
			System.out.println("============ fm239Qry.jsp ==========infoRet1["+i+"][11]" + infoRet1[i][11]);
			System.out.println("============ fm239Qry.jsp ==========infoRet1["+i+"][12]" + infoRet1[i][12]);
			System.out.println("============ fm239Qry.jsp ==========infoRet1["+i+"][13]" + infoRet1[i][13]);
			System.out.println("============ fm239Qry.jsp ==========infoRet1["+i+"][14]" + infoRet1[i][14]);
			System.out.println("============ fm239Qry.jsp ==========infoRet1["+i+"][15]" + infoRet1[i][15]);
				}
			
		}else{
			System.out.println("============ fm239Qry.jsp 失败==========");
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
response.data.add("prt_flag","<%=prt_flag %>");
response.data.add("infoArray",infoArray);
core.ajax.receivePacket(response);