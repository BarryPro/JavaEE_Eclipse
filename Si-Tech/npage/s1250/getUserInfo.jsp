<%
  /**
  * 模块：积分兑换冲正
  * 日期：2008.12.1
  * 作者：zhaohaitao
  **/ 
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=gb2312" %>

<%
int iCount = 0;
//ArrayList retArray = new ArrayList();
String[][] userInfo = new String[][]{};
String retCode ="";                 
String retMessage = "";     

String phoneNo = request.getParameter("phoneNo");
String loginAccept = request.getParameter("loginAccept");
String totalDate = request.getParameter("totalDate");

//add by diling for 安全加固修改服务列表
String opCode = "1450";
String work_no =(String)session.getAttribute("workNo");
String password = (String)session.getAttribute("password");

//SPubCallSvrImpl callWrapper = new SPubCallSvrImpl();
//ArrayList inputParam = new ArrayList();
//String  outList[][] = new String [][]{{"0","12"}};

//inputParam.add(phoneNo);
//inputParam.add(loginAccept);
//inputParam.add(totalDate);

try
{
   	//retArray = callWrapper.callFXService("s1450Init",inputParam,"3",outList); 
%>
   	<wtc:service name="s1450Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="12" >
		<wtc:param value="<%=loginAccept%>"/>
    <wtc:param  value=""/>
    <wtc:param  value="<%=opCode%>"/>
    <wtc:param  value="<%=work_no%>"/>
    <wtc:param  value="<%=password%>"/>
    <wtc:param  value="<%=phoneNo%>"/>
    <wtc:param  value=""/>
  	<wtc:param value="<%=totalDate%>"/>  
		</wtc:service>
	<wtc:array id="tempArr" start="0" length="12" scope="end"/>
<%                    
    retCode = retCode1;
    retMessage = retMsg1;
	System.out.println("retCode = " + retCode);
	System.out.println("retMessage = " + retMessage);
    if(retCode.equals("000000"))
    {
        userInfo = tempArr;        	
        iCount = userInfo.length; 
		System.out.print(iCount);
	}                                    
}catch(Exception e){
    System.out.println("1250 Call s1445Init  is Failed!");
}   
	System.out.println("userInfo.length=="+userInfo.length);
  if(userInfo.length==0){
%>
	var response = new AJAXPacket();
	//response.guid = '<%= request.getParameter("guid") %>';
	response.data.add("backString","");
	response.data.add("flag","9");
	response.data.add("errCode","<%=retCode%>");
	response.data.add("errMsg","<%=retMessage%>");
	core.ajax.receivePacket(response);

<%

}else{

%>
<%
	String strArray = WtcUtil.createArray("userInfo",userInfo.length);
%>
	<%=strArray%>
<%

	for(int i = 0 ; i < userInfo.length ; i ++){
      for(int j = 0 ; j < userInfo[i].length ; j ++){
        System.out.println("userInfo=="+userInfo[i][j]);
%>
		userInfo[<%=i%>][<%=j%>] = "<%=userInfo[i][j].trim()%>";
<%
	}
}
%>
	var response = new AJAXPacket();
	response.data.add("backString",userInfo);
	response.data.add("errCode","<%=retCode%>");
	response.data.add("errMsg","<%=retMessage%>");
	response.data.add("flag","0");

	core.ajax.receivePacket(response);
<%}%>