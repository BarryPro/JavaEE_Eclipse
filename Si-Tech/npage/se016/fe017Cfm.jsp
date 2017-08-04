<%
  /*
   * 功能: 勋章兑换礼品配置修改 e017
   * 版本: 1.0
   * 日期: 2011/7/5
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%> 
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "e017";	
	String opName = "勋章兑换礼品配置修改";	//header.jsp需要的参数   
	//读取session信息	
	String loginNo = (String)session.getAttribute("workNo");    //工号 
	String nopass = (String)session.getAttribute("password");		
	String regionCode = (String)session.getAttribute("regCode"); 
	String loginAccept=request.getParameter("loginAccept");//获取流水
	String chnSource="01";
	String iregionCode = request.getParameter("regionCode");							//地市代码
	String giftCode = request.getParameter("giftCode");					//礼品代码
	String giftName = request.getParameter("giftName");		//礼品名称
	String giftDescribe = request.getParameter("giftDescribe");				//礼品描述
	String medalCount = request.getParameter("medalCount");			//扣勋章数
	String startTime = request.getParameter("startTime");	//开始时间
	String endTime = request.getParameter("endTime");		//结束时间 
	String groupId = request.getParameter("groupId");							//领取营业厅代码修改后
	String oldGroupId = request.getParameter("oldGroupId");							//	领取营业厅代码修改前
	
	String opNote = request.getParameter("opNote");								//备注
	String retMsg = null;

	/****************调用  sE017Cfm  ***********************/
 
	%>
	<wtc:service name="sE017Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=chnSource%>"/>		
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=nopass%>"/>			
		<wtc:param value=" "/>
		<wtc:param value=" "/>		
	  <wtc:param value="<%=iregionCode%>"/>								
		<wtc:param value="<%=giftCode%>"/>			
		<wtc:param value="<%=giftName%>"/>	
		<wtc:param value="<%=giftDescribe%>"/>	
		<wtc:param value="<%=medalCount%>"/>						
		<wtc:param value="<%=startTime%>"/>	
		<wtc:param value="<%=endTime%>"/>	
		<wtc:param value="<%=oldGroupId%>"/>				
		<wtc:param value="<%=groupId%>"/>	
	  <wtc:param value="<%=opNote%>"/>	
	</wtc:service>	
	<%    
	String returnCode="0";  //错误代码	        
	String returnMsg=""; //错误信息
		
	returnCode=retCode1; //错误代码	
	returnMsg=retMsg1;//错误信息
	

	if("000000".equals(returnCode)){
		retMsg = "勋章兑换礼品配置修改成功";
		%>
		
		<script language="JavaScript">
		    rdShowMessageDialog("<%=retMsg%>",2);
        window.location="/npage/se016/fe016_login.jsp?opCode=e017&opName=勋章兑换礼品配置修改";
		</script>
	<%}else{
		retMsg = returnMsg;%>
		<script language="JavaScript">
		    rdShowMessageDialog("<%=retMsg%>",0);
		    history.go(-1);
		</script>
	<%}
	

%>


