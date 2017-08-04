<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
	String retType = request.getParameter("retType");
	String result = request.getParameter("result");
	
	String phoneNo     = request.getParameter("phoneNo");
	String serOId      = request.getParameter("serOId");
	String opCode1     = request.getParameter("opCode1");
	String opCode2     = request.getParameter("opCode2");
	String loginAccept = request.getParameter("loginAccept");    
	
	System.out.println("--------------------phoneNo    ----------------"+phoneNo    );
	System.out.println("--------------------serOId     ----------------"+serOId     );
	System.out.println("--------------------opCode1    ----------------"+opCode1    );
	System.out.println("--------------------opCode2    ----------------"+opCode2    );
	System.out.println("--------------------loginAccept----------------"+loginAccept);
	
%>
<wtc:utype name="sReverInfo" id="retVal" scope="end" >
          <wtc:uparam value="<%=phoneNo%>" type="String"/>      
          <wtc:uparam value="<%=serOId%>" type="String"/>      
          <wtc:uparam value="<%=opCode1%>" type="String"/>      
          <wtc:uparam value="<%=opCode2%>" type="String"/>      
          <wtc:uparam value="<%=loginAccept%>" type="LONG"/>      	
 </wtc:utype>
<%
	String retCode=retVal.getValue(0);
	String retMsg=retVal.getValue(1);
	String retPPV1 = "";
	String custPPv1 = "";
	String custPPv2 = "";
	String custPPv3 = "";
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
	System.out.println(logBuffer.toString());
	
	System.out.println("--------------------retCode    ----------------"+retCode    );
	System.out.println("--------------------retMsg     ----------------"+retMsg);
	                                                          
  String retResultStr = "";                                                          
  String retNowOfferId = "";     
  String retRevsOfferId = "";
  /* ningtn 2012-2-27 10:23:03 宽带返回串，与语音业务区分开 */     
  String broadReturnStr = "";
	if(opCode2.equals("127b"))
	{
		if(retVal.getSize("2.1")>0){   
					retResultStr += "新套餐类型："+retVal.getValue("2.1.2")+"--"+retVal.getValue("2.1.3")+"|";
					retRevsOfferId +=retVal.getValue("2.1.2");
		}
	}

	int tempCount = 0;
	if(retVal.getSize("2.2")>0){ 
			  
			tempCount = retVal.getSize("2.2");
			for(int i=0;i<tempCount;i++){
			
			if(opCode2.equals("3264")){
				retResultStr += "冲正的可选包年资费："+retVal.getValue("2.2."+i+".2")+"--"+retVal.getValue("2.2."+i+".3")+"|";
				}
			else{
				if(!opCode2.equals("127b"))
					retResultStr += "冲正前附加资费："+retVal.getValue("2.2."+i+".2")+"--"+retVal.getValue("2.2."+i+".3")+"|";
				}
				custPPv1 = retVal.getValue("2.2."+i+".4");
			}
	}

	if(retVal.getSize("2.1")>0){   
		custPPv2 = retVal.getValue("2.1.4");
	}
	
	if(retVal.getSize("2.0")>0){   
		custPPv3 = retVal.getValue("2.0.4");
	}
		
	if(opCode2.equals("127b"))
	{
		/*
		if(retVal.getSize("2.1")>0){   
		retResultStr += "冲正后主资费："+retVal.getValue("2.1.2")+"--"+retVal.getValue("2.1.3")+"|";
		custPPv2 = retVal.getValue("2.1.4");
		}
		*/
		retNowOfferId +=retVal.getValue("2.1.2");
	}
	else if(opCode2.equals("1257"))
	{
		if(retVal.getSize("2.1")>0){   
		retResultStr += "包年前："+retVal.getValue("2.1.2")/*+"--"+retVal.getValue("2.1.3")*/+"|";
		custPPv2 = retVal.getValue("2.1.4");
		}
	}
	
	int tempCount1 = 0;
	if(retVal.getSize("2.3")>0){   
			tempCount1 = retVal.getSize("2.3");
			for(int i=0;i<tempCount1;i++){
				retResultStr += "冲正后附加资费："+retVal.getValue("2.3."+i+".2")+"--"+retVal.getValue("2.3."+i+".3")+"|";
			}
	}
	
	System.out.println("--------------retResultStr-------------");
	System.out.println(retResultStr);
	System.out.println("--------------retResultStr-------------");
	
	if(opCode2.equals("3264"))
		retPPV1= custPPv1;
	else if(opCode2.equals("1121"))
		retPPV1= custPPv3;	
	else
		retPPV1= custPPv2;	
		
%>
<%
	/* ningtn */
	if(opCode2.equals("e093")){
		if(retVal.getSize("2.1") > 0){
			broadReturnStr = "原主资费：" + retVal.getValue("2.1.2") + " " + retVal.getValue("2.1.3");
		}
	}else if(opCode2.equals("e094")){
		if(retVal.getSize("2.0") > 0){
			broadReturnStr = "预约主资费：" + retVal.getValue("2.0.2") + " " + retVal.getValue("2.0.3");
		}
		if(retVal.getSize("2.1") > 0){
			broadReturnStr += "|当前主资费：" + retVal.getValue("2.1.2") + " " + retVal.getValue("2.1.3") + "|";
		}
	}
	System.out.println(" ningtn broadReturnStr " + broadReturnStr);
%>
 
var response = new AJAXPacket();

response.data.add("retType","<%=retType%>");
response.data.add("retNowOfferId","<%=retNowOfferId%>");
response.data.add("retRevsOfferId","<%=retRevsOfferId%>");
response.data.add("retResultStr","<%=retResultStr%>");
response.data.add("retPPV1","<%=retPPV1%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("broadReturnStr","<%=broadReturnStr%>");

core.ajax.receivePacket(response);