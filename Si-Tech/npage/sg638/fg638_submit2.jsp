<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/02/16 关于融合套餐界面优化功能
* 作者: liangyl
* 版权: si-tech
*/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%> 

 <%
  String workNo = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password");
	String orgCode  = (String)session.getAttribute("orgCode");
	String groupId  = (String)session.getAttribute("groupId");
	String orgId    = (String)session.getAttribute("orgId");
	String masterPhone = WtcUtil.repNull(request.getParameter("masterPhone"));
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String custPwd = (String)Encrypt.encrypt(WtcUtil.repNull(request.getParameter("custPwd")));
	String masterCustName = WtcUtil.repNull(request.getParameter("masterCustName"));
	String masterIdType = WtcUtil.repNull(request.getParameter("masterIdType"));
	String masterIdIccid = WtcUtil.repNull(request.getParameter("masterIdIccid"));
	String masterIdAdress = WtcUtil.repNull(request.getParameter("masterIdAdress"));
	String masterIdDate = WtcUtil.repNull(request.getParameter("masterIdDate"));
	String postNo = WtcUtil.repNull(request.getParameter("postNo"));
	String contactName = WtcUtil.repNull(request.getParameter("contactName"));
	String contactPhone = WtcUtil.repNull(request.getParameter("contactPhone"));
	String faxNo = WtcUtil.repNull(request.getParameter("faxNo"));
	String email = WtcUtil.repNull(request.getParameter("email"));
	String masterCustId = WtcUtil.repNull(request.getParameter("masterCustId"));
	String masterUserId = WtcUtil.repNull(request.getParameter("masterUserId"));
	String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
	String address = WtcUtil.repNull(request.getParameter("address"));
	System.out.println("+++++++++++++++++++++++++fg638_submit.jsp.address="+address);
	
	if ("".equals(postNo)) {
	     postNo = "无";
	}
	if ("".equals(faxNo)) {
	     faxNo = "无";
	}
	if ("".equals(email)) {
	     email = "无";
	}
%>
<wtc:service name="spubGetId" routerKey="region" routerValue="<%=regionCode%>" retCode="retCode" retMsg="retMsg" outnum="3" >
	<wtc:param value="<%=regionCode%>"/>
	<wtc:param value="0"/>
	<wtc:param value="0"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%
    String retnewId = "";
    String createNote = "新建家庭客户";
    
		if(result!=null&&result.length>0){
	    retnewId = result[0][2];	
	    createNote = createNote +": 客户ID["+retnewId+"]";
		} 
    if(! retCode.equals("000000"))
    {
%>
      <script>
	      rdShowMessageDialog("获取客户ID失败！",0);
          location="fg638_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	    </script>
<%
		}	
%>

<wtc:service name="sG638Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
	    <wtc:param value="<%=loginAccept%>"/>
	    <wtc:param value="01"/>
	    <wtc:param value="<%=opCode%>"/>
	    <wtc:param value="<%=workNo%>"/>
	    <wtc:param value="<%=password%>"/>
	    <wtc:param value=""/>
		<wtc:param value=""/>
	    <wtc:param value="<%=retnewId%>"/>
		<wtc:param value="<%=masterPhone%>"/>  
        <wtc:param value="0"/>  
        <wtc:param value="<%=custPwd%>"/>  
        <wtc:param value="<%=masterCustName%>"/>   
        <wtc:param value="<%=masterIdType%>"/>  
        <wtc:param value="<%=masterIdIccid%>"/> 
        <wtc:param value="<%=masterIdAdress%>"/>  
        <wtc:param value="<%=masterIdDate%>"/>   
        <wtc:param value="<%=postNo%>"/>  
        <wtc:param value="<%=contactName%>"/>  
        <wtc:param value="<%=contactPhone%>"/>   
        <wtc:param value="<%=faxNo%>"/>  
        <wtc:param value="<%=email%>"/> 
        <wtc:param value="<%=regionCode%>"/>  
        <wtc:param value="<%=orgCode%>"/>  
        <wtc:param value="<%=groupId%>"/>  
        <wtc:param value="<%=orgId%>"/>   
        <wtc:param value="<%=createNote%>"/>    
        <wtc:param value="<%=masterCustId%>"/>   
        <wtc:param value="<%=masterUserId%>"/>   
        <wtc:param value="<%=address%>"/>      
</wtc:service>	
<%	
	if(retCode.equals("000000"))
    {
%>
      <script>
  //  rdShowMessageDialog("家庭客户创建成功！",2);
          
          var cusId = "<%=retnewId%>";
  				var custName = "<%=masterCustName%>";
  				location="fg638_choose_sale2.jsp?opCode=g629&gCustId="+cusId+"&loginType=10&phone_no=<%=masterPhone%>&activePhone=<%=masterPhone%>";
  				openCustMain(cusId,custName,'10',"<%=masterPhone%>");
									  
					function openCustMain(custId,custName,loginType,phone_no)
					{
							iCustId = custId;
						  if($("#contentArea iframe").size() < 11){
										parent.addTab(true,"custid"+custId,custName,'childTab2.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&activePhone='+phone_no);
									  parent.removeTab("<%=opCode%>");
							}else{
									 rdShowMessageDialog("只能打开10个一级tab");
							}
					}
          
	    </script>
<%
   }
   else
   {
%>
	   <script>
	     rdShowMessageDialog('错误<%=retMsg%>，请重新操作！',0);
                  location="fg638_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	   </script>
<%
   }
%>		