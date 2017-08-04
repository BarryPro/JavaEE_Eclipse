<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	/* 定义入参 */
	String loginAccept = "";
	String chanelFlag = "01";
	String opCode = "1239";
	String workNo = (String)session.getAttribute("workNo");
	String workNoPsw = (String)session.getAttribute("password");
	String phoneNo = request.getParameter("phoneNo");
	String phonePsw = "";
	String regionCode= (String)session.getAttribute("regCode");
	//查询SORDERCOMPCONFIG表sql语句
	int successFlag = 0;
	
	/* 定义出参 */
	//返回码
	String retCode = "";
	//返回值
	String retMsg = "";
	//销售品列表
	String offerArray = "var offerMsg";
	//现有亲情号码
	String strArray = "var arrMsg; ";
	String hisArray = "var hisArrMsg; ";
	//新增生效失效时间
	String timeArray = "var timeArrMsg;";
	
%>
	<wtc:service name="s1239Query" routerKey="region" routerValue="<%=regionCode%>" 
					retcode="retCode1" retmsg="retMsg1" outnum="17">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=chanelFlag%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=workNoPsw%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=phonePsw%>"/>
	</wtc:service>
	<wtc:array id="commResult" scope="end" start="2" length="4"/>
	<wtc:array id="result1" scope="end" start="6" length="4"/>
	<wtc:array id="result2" scope="end" start="10" length="5"/>
	<wtc:array id="result3" scope="end" start="15" length="2"/>
		
	<%
	retCode = retCode1;
	retMsg  = retMsg1;
		if(!(retCode.equals("0") || retCode.equals("000000"))){
			System.out.println("======在f1239_getDate.jsp调用s1239Query失败！======");
			successFlag = 0;
		}else{
			System.out.println("======在f1239_getDate.jsp调用s1239Query成功！======");
			offerArray = WtcUtil.createArray("offerMsg",commResult.length);
			strArray = WtcUtil.createArray("arrMsg",result1.length);
			hisArray = WtcUtil.createArray("hisArrMsg",result2.length);
			timeArray = WtcUtil.createArray("timeArrMsg",result3.length);
			successFlag = 1;
		}
	%>
	<%=offerArray%>
	<%
		if(successFlag == 1){
			for(int i = 0 ; i < commResult.length ; i++){
				for(int j = 0; j < commResult[i].length; j++){
	%>
					offerMsg[<%=i%>][<%=j%>] = "<%=commResult[i][j].trim()%>";
	<%
				}
			}
		}
	%>
	
	<%=strArray%>
	<%
		if(successFlag == 1){
			for(int i = 0 ; i < result1.length; i++){
				for(int j = 0; j < result1[i].length; j++){
	%>
					arrMsg[<%=i%>][<%=j%>] = "<%=result1[i][j].trim()%>";
	<%
				}
			}
	}
	%>
	
	<%=timeArray%>
	<%
		if(successFlag == 1){
			for(int i = 0 ; i < result3.length; i++){
				for(int j = 0; j < result3[i].length; j++){
	%>
					timeArrMsg[<%=i%>][<%=j%>] = "<%=result3[i][j].trim()%>";
	<%
				}
			}
	}
	%>	
	
	<%=hisArray%>
	<%
		if(successFlag == 1){
			for(int i = 0 ; i < result2.length ; i++){
				for(int j = 0; j < result2[i].length; j++){
				if(j == 3){
					if("1".equals(result2[i][j])){
						result2[i][j] = "新增";
					}else if("3".equals(result2[i][j])){
						result2[i][j] = "删除";
					}else if("2".equals(result2[i][j])){
						result2[i][j] = "所属销售品预约取消";
					}
				}
	%>
					hisArrMsg[<%=i%>][<%=j%>] = "<%=result2[i][j].trim()%>";
	<%
				}
			}
		}
	%>

	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	response.data.add("offerMsg",offerMsg);
	response.data.add("arrMsg",arrMsg);
	response.data.add("hisArrMsg",hisArrMsg);
	response.data.add("timeArrMsg",timeArrMsg);
	core.ajax.receivePacket(response);
