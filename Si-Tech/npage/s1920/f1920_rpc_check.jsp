<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-04 页面改造,修改样式
     *
     ********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String login_no = (String)session.getAttribute("workNo");//工号
		String login_passwd = (String)session.getAttribute("password");//工号密码
		String org_code = (String)session.getAttribute("orgCode");
		String[][] callData = null;
		String stringArray="";
		String returnMessage="";
		String returnCode="";
		HashMap runCode=new HashMap();
		runCode.put("A","正常")     ;
		runCode.put("B","冒高")     ;
		runCode.put("C","冒单")     ;
		runCode.put("D","欠停")     ;
		runCode.put("E","欠单")     ;
		runCode.put("F","高额")     ;
		runCode.put("G","报停")     ;
		runCode.put("H","挂失")     ;
		runCode.put("I","预销")     ;
		runCode.put("J","预拆")     ;
		runCode.put("K","强开")     ;
		runCode.put("L","强关")     ;
		runCode.put("a","销号")     ;
		runCode.put("b","拆机")     ;
		runCode.put("c","转网")     ;
		runCode.put("M","PPS保号期");
		
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneno"));
		String passwd = "";  //因为前一个页面的客户密码验证废弃,所以为空
		String [] inputParam = new String [6] ;
		inputParam[0]="01";
		inputParam[1]=phoneNo;
		inputParam[2]=passwd;
		inputParam[3]="";
		inputParam[4]="";
		inputParam[5]=login_no;
		//String [] userInfo = callWrapper.callService("sPubCustCheck",inputParam,"5");
%>
		<wtc:service name="sPubCustCheck" routerKey="phone" routerValue="<%=phoneNo%>" outnum="5" >
		<wtc:param value="<%=inputParam[0]%>"/>
		<wtc:param value="<%=inputParam[1]%>"/>
		<wtc:param value="<%=inputParam[2]%>"/>
		<wtc:param value="<%=inputParam[3]%>"/>
		<wtc:param value="<%=inputParam[4]%>"/>
		<wtc:param value="<%=inputParam[5]%>"/>
		</wtc:service>
		<wtc:array id="sPubCustCheckArr" scope="end"/>
<% 
		String custname="";
		String runcode="";
		String brand="";
		returnCode = retCode;
		returnMessage = retMsg;
		if(returnMessage==null){
			returnMessage = "";
		}
		int retCodeInt = retCode==""?999999:Integer.parseInt(retCode);
		if(retCodeInt==0){
			if(sPubCustCheckArr!=null&&sPubCustCheckArr.length>0){
					custname=sPubCustCheckArr[0][3];
					runcode=sPubCustCheckArr[0][0];
					brand=sPubCustCheckArr[0][2];
			}

				runcode=runcode+"->"+runCode.get(runcode.substring(1,2));
				System.out.println("############runcode##"+runcode+"##");
				String[] paramsIn = new String[]  {org_code,login_no,login_passwd,"","1920",phoneNo};
				//retArray=callWrapper.callFXService("s1984PhoneOut", paramsIn, "15");
%>
					<wtc:service name="s1984PhoneOut" routerKey="phone" routerValue="<%=phoneNo%>" outnum="15" >
					<wtc:param value="<%=paramsIn[0]%>"/>
					<wtc:param value="<%=paramsIn[1]%>"/>
					<wtc:param value="<%=paramsIn[2]%>"/>
					<wtc:param value="<%=paramsIn[3]%>"/>
					<wtc:param value="<%=paramsIn[4]%>"/>
					<wtc:param value="<%=paramsIn[5]%>"/>
					</wtc:service>
					<wtc:array id="switchTypeArray" start="8" length="1" scope="end"/>
					<wtc:array id="switchNameArray" start="9" length="1" scope="end"/>
					<wtc:array id="switchBizArray" start="11" length="1" scope="end"/>
					<wtc:array id="switchOpenArray" start="12" length="1" scope="end"/>
					<wtc:array id="switchCloseArray" start="13" length="1" scope="end"/>
<%
				if(switchTypeArray!=null&&switchTypeArray.length>0){
					stringArray = "var arrMsg = new Array(";
						callData=new String[switchTypeArray.length][5];
						for(int i=0;i<switchTypeArray.length;i++){
							callData[i][0]=switchTypeArray[i][0];
							callData[i][1]=switchNameArray[i][0];
							callData[i][2]=switchBizArray[i][0];
							callData[i][3]=switchOpenArray[i][0];
							callData[i][4]=switchCloseArray[i][0];
						}
						int flag = 1;
						for (int i = 0; i < callData.length; i++) {
				      if (flag == 1) {
				        stringArray += "new Array()";
				        flag = 0;
				      }
				      else if (flag == 0) {
				        stringArray += ",new Array()";
				      }
				    }
			
				  stringArray += ");";	  
				}else{
					callData=new String[][]{};
					stringArray="var arrMsg = new Array();";
				}	
		}else{
			callData=new String[][]{};
			stringArray="var arrMsg = new Array();";
		}
%>
		<%=stringArray%>
<%
for(int i = 0 ; i < callData.length ; i ++){
  for(int j = 0 ; j < callData[i].length ; j ++){
		if(callData[i][j].trim().equals("") || callData[i][j] == null){
		   callData[i][j] = "";
		}
		//System.out.println("#######################f1920_rpc_check.jsp->callData["+i+"]["+j+"]=[" + callData[i][j].trim() + "]");
%>
		arrMsg[<%=i%>][<%=j%>] = "<%=callData[i][j].trim()%>";
<%
  }
}
%>  
		var response = new AJAXPacket();
		response.data.add("verifyType","phoneno");
		response.data.add("errorCode","<%=returnCode%>");
		response.data.add("errorMsg","<%=returnMessage%>");
		response.data.add("custname","<%=custname%>");
		response.data.add("runcode","<%=runcode%>");
		response.data.add("brand","<%=brand%>");
		response.data.add("backArrMsg",arrMsg);
		core.ajax.receivePacket(response);
