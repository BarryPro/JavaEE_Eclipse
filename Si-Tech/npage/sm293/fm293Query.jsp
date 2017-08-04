<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: 2015/07/28 R_CMI_HLJ_guanjg_2015_2350528@关于哈分公司为第二批社会渠道申请开通身份证扫描仪使用权限的请示
   * 作者: gejing
   * 版权: si-tech
  */
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("===requestInto========= fm293Query.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		String iOpNote = request.getParameter("iOpNote");
		String iGroupId =  request.getParameter("iGroupId");
		
		String  inputParsm [] = new String[9];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = iOpNote;
		inputParsm[8] = iGroupId;
		 
		String retCode11 = "";
		String retMsg11 = "";
		
		String groupName = "";
try{		
%>
		<wtc:service name="sm294Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="1">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
			<%-- <wtc:array id="result2" scope="end"  start="1"  length="2"/> --%>
			
	var infoArray = new Array();
	
		<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		System.out.println("========================================="+retCode);
		if("000000".equals(retCode)){
			System.out.println("============ fm293Query.jsp ==========" + result.length);
			
			if(result.length>0){
				groupName = result[0][0];
			}
			
			//for(int i=0;i<result2.length;i++){
					
			%>
				<%-- infoArray[<%=i%>] = new Array(); --%>
				<%//for(int j=0;j<result2[i].length;j++){%>
				<%-- infoArray[<%=i%>][<%=j%>] = "<%=result2[i][j]%>"; --%>
				
				<%
				//System.out.println("============ fm293Query.jsp ==========result2["+i+"]["+j+"]" + result2[i][j]);
				//}
				%>
			<%
			//}
			
		}else{
			System.out.println("============ fm293Query.jsp 失败==========");
		}
		}catch(Exception e){
			retCode11 = "444444";
			retMsg11 = "服务未启动或不正常，请联系管理员！";
			%>
				<!-- var infoArray = new Array(); -->
			<%
		}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11%>");
response.data.add("retMsg","<%=retMsg11%>");
response.data.add("vGroupName","<%=groupName%>");
response.data.add("iGroupId","<%=iGroupId%>");
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         