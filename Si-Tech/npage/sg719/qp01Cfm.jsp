<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name_p.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/npage/common/qcommon/print_include.jsp"%>
<%
	String retrunCode="";
	String returnMsg="";
  String chkFlag = WtcUtil.repNull(request.getParameter("chkFlag"));	
	String loginNo = (String)session.getAttribute("workNo");
	String groupId = (String)session.getAttribute("siteId");
	
	String oldofferId = WtcUtil.repNull(request.getParameter("oldofferId"));	
	String newofferId = WtcUtil.repNull(request.getParameter("newofferId"));	
	
	String feeFactor=WtcUtil.repNull(request.getParameter("feeFactor"));	
	int hasServOrderData = 0;
	int hasServOrderSlaInfo = 0;
	int hasServOrderBookingMsg = 0;
	
	String phoneNo=WtcUtil.repNull(request.getParameter("phoneNo"));	//13083154258	业务号码
	String offered=WtcUtil.repNull(request.getParameter("offId"));	//"100005329";	//  #销售品标识 100005610
  opCode=WtcUtil.repNull(request.getParameter("opCode"));	
	String opName=WtcUtil.repNull(request.getParameter("opName"));
	String servId=WtcUtil.repNull(request.getParameter("servId"));	//servId//  #主产品实例ID "900000783066";	10099000990
	String gCustId=WtcUtil.repNull(request.getParameter("gCustId"));//  #客户ID 900001942251	//900001942251 "900000782559";	
		
	String offerSrvId=WtcUtil.repNull(request.getParameter("idNo"));	//如果是新装就是 //新装销售品实例ID;如果是客户服务就是 idNo
	String orderArrayId=WtcUtil.repNull(request.getParameter("orderArrayId"));	//A0209022000000180  客户订单子项ID
	String custOrderId=WtcUtil.repNull(request.getParameter("custOrderId"));	//C0209022000000166  客户订单ID
	String servOrderId=WtcUtil.repNull(request.getParameter("servOrderId"));	//服务订单ID
	String servBusiId=WtcUtil.repNull(request.getParameter("servBusiId"));	//620
	String prtFlag=WtcUtil.repNull(request.getParameter("prtFlag"));
	String custOrderNo = WtcUtil.repNull(request.getParameter("custOrderNo"));
		
  String loginPwd =(String)session.getAttribute("password");
  String ipAddress =request.getRemoteAddr();	
  String oprGroupId =(String)session.getAttribute("groupId");	//10032 
  String opTime =new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());//"20080912 09:59:01";
  String regionCode =(String)session.getAttribute("regCode");	//bureau_Id  区域ID  相当与咱们原来的regionCode 
	regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);	//-------------lgz
  String opNote=opName+"["+oldofferId+"]->["+newofferId+"]";
  String bureauId =(String)session.getAttribute("groupId");	//site_id   处理点ID  相当于咱们原来的groupId
  String objectId =(String)session.getAttribute("workGroupId");	//object_id 处理局ID	//bureau_id >  object_id > site_id
	String servOrderNo ="0";	//客户服务定单编号(为外系统预留)
	String servOrderChangeId ="0";	//服务定单变更编号
	String idNo = WtcUtil.repNull(request.getParameter("offerSrvId"));
	String serviceNo =phoneNo;	//"0";//网络接入号码//-------------j	WtcUtil.repNull(request.getParameter("selNum"));
	String dispathRule ="0"; //替换0	工单派发规则标识
	String decomposeRule ="0"; //替换0	工单分解规则标识
	String addressId ="0"; //替换0	//地址ID//-------------j ----------------@@@@
	String orderStatus ="110"; //替换0 //0初始未调度状态	//待收费110
	String stateDate ="0";	//-------------j
	String stateReasonId ="3"; //替换0	//定单状态原因ID//-------------j
	String finishFlag ="N";	//未完成,已完成 N未竣工//-------------j
	String finishTime ="0";		//竣工时间//-------------j
	String finishLimitTime =opTime;	//完成期限//-------------j	//-------------------@@@@
	String warningTime =opTime;	//预警时间//-------------j	//-------------------@@@@
	String dealLevel ="1";		//1:普通优先级//-------------j  
	String payStatus ="0";		//缴费状态 char sPayState[1+1];//-------------j
	String backFlag ="0";		//退费标志//-------------j
	String exceptionTimes ="0";	//"int";	//异常出现次数//-------------j
	String servOrderSeq ="1";	//"int";	//服务定单调度顺序dOrderArrayOrder.serv_order_seq//-------------j//-------------------@@@@
	String isPreCreateStatus ="Y";	//"string";表示是否是预创建状态，dOrderArrayOrder.create_status，取值范围'Y','N'。对于组合业务服务定单是提前生成的	//表示是否是预创建状态，dOrderArrayOrder.create_status，取值范围'Y','N'。//-------------j
	/////对于组合业务服务定单是提前生成的。//----------------@@@@@
	String contactPerson ="0";	//服务定单级别的联系人
	String contactPhone =WtcUtil.repNull(request.getParameter("phoneNo"));	
///////////////////////////////////////////////////////servOrderData
	String classCode ="0";	//"long";	//对象类型  ----可空或默认
	String arraySeq ="0";	//"int";	//数组序号
	String classValue ="0";		//数组值
///////////////////////////////////////////////////////servOrderSlaInfo----可空----默认//-------------lgz
	String srvOrderSlaId ="0";	//定单SLA标识
	String slaIndexId ="0"; //替换0	//指标标识
	String salValueSeq ="0"; //替换0	//指标序号
	String slaValue ="0";	//指标序号
///////////////////////////////////////////////////////servOrderBookingMsg----可空----默认//-------------lgz
	String bookSrvId ="0";		//预约服务信息标识
	String modifyTime =opTime;	//最后修改时间
	String bookingTime =opTime;	//预约时间
///////////////////////////////////////////////////////servOrderExcpInfo
	String srvOrderExcpId ="0";	//异常信息标识
	String excpType ="1"; //替换0				//异常类型
	String excpReason ="0";		//异常原因
	String handleResult ="OK";		//异常处理结果
	String handleLogin ="0";		//异常处理人

	String brand ="0";			//用户的品牌信息，如：00 世界风 01 新势力 02 如意通。//-------------j
	String userNo ="0";		//用户的内部11位编码，用于出账//-------------j
	
	groupId=(String)session.getAttribute("groupId");	//用户归属。--------取用户的,和营业员的不同//-------------lgz
	
	String UseCustId =gCustId;	//使用客户ID

	stateDate =opTime;		//状态时间
	
	String operatorFlag0 ="0";
	String resType ="0";		//资源类型
	String resSeq ="0";		//资源序列
	String resNo =phoneNo;			//资源编号

	String paramType ="C";			//参数信息------------营业自费类型
	String paramCode ="C2";			//参数代码
	String paramValueBegin =feeFactor;	//开始参数值
	String paramValueEnd ="0";	
	String paramObj ="0";			//参数扩展信息

	//C       参数类型
	//C2      参数代码
	//MODE    开始值
	// 0        结束值
	// 0        参数对象
	//		 基本销售品ID

///////////////////////////////////////////////////////

String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
UType cfmParamUtype = new UType();
	//-------------取销售品,产品报文----------
%>
<%String regionCode_sCrtOrderMsg = (String)session.getAttribute("regCode");%>
<wtc:utype name="sCrtOrderMsg" id="retVal1" scope="end" routerKey="region" routerValue="<%=regionCode_sCrtOrderMsg%>">
	<wtc:uparam value="<%=loginNo%>" type="string"/>
  <wtc:uparam value="<%=loginAccept%>" type="long"/>
  <wtc:uparam value="<%=servId%>" type="long"/>
  <wtc:uparam value="<%=chkFlag%>" type="STRING"/>
</wtc:utype>	
<%
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal1,1,"2",logBuffer);
	System.out.println(logBuffer.toString());

	retCode = retVal1.getValue(0);
	retMsg  = retVal1.getValue(1).replaceAll("\\n"," ");
	if(retCode.equals("0")){
		cfmParamUtype = retVal1.getUtype("2");
	}else{  
%>
  <script language='JavaScript'>
        rdShowMessageDialog("<%=retrunCode%>:<%=retMsg%>");
        window.history.go(-1);
   </script> 
<%
 }
 

 String serverNameSub = "";
 if(opCode.equals("g719")){
 	 serverNameSub = "s1270ChgCfm";
 }else if(opCode.equals("1272")){
 	 serverNameSub = "s1272ChgCfm";
 }else{
 	 serverNameSub = "sProdChgCfm";
 }
 
 
 System.out.println("-----------------opCode-------------------------"+opCode);
 System.out.println("-----------------serverNameSub------------------"+serverNameSub);
%>
<%String regionCode_sProdChgCfm = (String)session.getAttribute("regCode");%>
<wtc:utype name="s1270ChgCfm" id="retVal" scope="end"  routerKey="region" routerValue="<%=regionCode_sProdChgCfm%>">
	<wtc:uparams name="ctrlInfo" iMaxOccurs="1">
			<wtc:uparam value="0" type="string"/>
	</wtc:uparams>	
	<wtc:uparams name="batchDataList" iMaxOccurs="1">
			<wtc:uparams name="batchData" iMaxOccurs="1">
				<wtc:uparam value="0" type="long"/>
				<wtc:uparam value="0" type="string"/>
				<wtc:uparam value="0" type="string"/>
			</wtc:uparams>	
	</wtc:uparams>	
	<wtc:uparams name="msgBodyType" iMaxOccurs="1">
		<wtc:uparams name="oprInfo" iMaxOccurs="1">
		        <wtc:uparam value="<%=loginAccept %>" type="long"/>
		        <wtc:uparam value="<%=opCode %>" type="string"/>
		        <wtc:uparam value="<%=loginNo %>" type="string"/>
		        <wtc:uparam value="<%=loginPwd %>" type="string"/>
		        <wtc:uparam value="<%=ipAddress %>" type="string"/>
		        <wtc:uparam value="<%=oprGroupId %>" type="string"/>
		        <wtc:uparam value="<%=opTime %>" type="string"/>
		        <wtc:uparam value="<%=regionCode %>" type="string"/>
		        <wtc:uparam value="<%=opNote %>" type="string"/>
		        <wtc:uparam value="<%=bureauId %>" type="string"/>
		        <wtc:uparam value="<%=objectId %>" type="string"/>
		</wtc:uparams>
		<wtc:uparams name="custOrder" iMaxOccurs="1">
		  <wtc:uparams name="custOrderMsg" iMaxOccurs="1">
		     <wtc:uparam value="<%=custOrderId %>" type="string"/>
		  </wtc:uparams>
		  <wtc:uparams name="orderArrayList" iMaxOccurs="1">		
		    <wtc:uparams name="orderArrayListContainer" iMaxOccurs="1">				
		      <wtc:uparams name="orderArrayMsg" iMaxOccurs="1">						
		          <wtc:uparam value="<%=orderArrayId %>" type="string"/>
		      </wtc:uparams>
		      <wtc:uparams name="servOrderList" iMaxOccurs="1">	
		        <wtc:uparams name="servOrderListContainer" iMaxOccurs="1">														
		          <wtc:uparams name="servOrderMsg" iMaxOccurs="1">										
		            <wtc:uparam value="<%=servOrderId %>" type="string"/>
		            <wtc:uparam value="<%=servOrderNo %>" type="string"/>
		            <wtc:uparam value="<%=servOrderChangeId %>" type="string"/>
		            <wtc:uparam value="<%=idNo %>" type="long"/>
		            <wtc:uparam value="<%=serviceNo %>" type="string"/>
		            <wtc:uparam value="<%=dispathRule %>" type="int"/>
		            <wtc:uparam value="<%=decomposeRule %>" type="int"/>
		            <wtc:uparam value="<%=addressId %>" type="long"/>
		            <wtc:uparam value="<%=orderStatus %>" type="int"/>
		            <wtc:uparam value="<%=stateDate %>" type="string"/>
		            <wtc:uparam value="<%=stateReasonId %>" type="int"/>
		            <wtc:uparam value="<%=servBusiId %>" type="string"/>
		            <wtc:uparam value="<%=finishFlag %>" type="string"/>
		            <wtc:uparam value="<%=finishTime %>" type="string"/>
		            <wtc:uparam value="<%=finishLimitTime %>" type="string"/>
		            <wtc:uparam value="<%=warningTime %>" type="string"/>
		            <wtc:uparam value="<%=dealLevel %>" type="int"/>
		            <wtc:uparam value="<%=payStatus %>" type="string"/>
		            <wtc:uparam value="<%=backFlag %>" type="string"/>
		            <wtc:uparam value="<%=exceptionTimes %>" type="int"/>
		            <wtc:uparam value="<%=servOrderSeq %>" type="int"/>
		            <wtc:uparam value="<%=isPreCreateStatus %>" type="string"/>
		            <wtc:uparam value="<%=contactPerson %>" type="string"/>
		            <wtc:uparam value="<%=contactPhone %>" type="string"/>
		          </wtc:uparams>
		          <wtc:uparams name="servOrderDataList" iMaxOccurs="1">										
							<%
							if(hasServOrderData == 1){ 
							%>
		              <wtc:uparams name="servOrderData" iMaxOccurs="1">								
		                <wtc:uparam value="<%=classCode %>" type="long"/>
		                <wtc:uparam value="<%=arraySeq %>" type="int"/>
		                <wtc:uparam value="<%=classValue %>" type="string"/>
		              </wtc:uparams>
							<%
							}
							%>
		          </wtc:uparams>
		          <wtc:uparams name="servOrderSlaList" iMaxOccurs="1">										
							<% 
							if(hasServOrderSlaInfo == 1){ 
							%>										
		            <wtc:uparams name="servOrderSlaInfo" iMaxOccurs="1">
		              <wtc:uparam value="<%=srvOrderSlaId %>" type="string"/>
		              <wtc:uparam value="<%=slaIndexId %>" type="int"/>
		              <wtc:uparam value="<%=salValueSeq %>" type="int"/>
		              <wtc:uparam value="<%=slaValue %>" type="double"/>
		            </wtc:uparams>
							<% 
							} 
							%>
		          </wtc:uparams>
		          <wtc:uparams name="servOrderBookingMsg" iMaxOccurs="1">											
		          <% 
		          if(hasServOrderBookingMsg == 1){ 
		          %>		
		            <wtc:uparam value="<%=bookSrvId %>" type="string"/>
		            <wtc:uparam value="<%=modifyTime %>" type="string"/>
		            <wtc:uparam value="<%=bookingTime %>" type="string"/>
							<% 
							}
						  %>
		          </wtc:uparams>
		          <wtc:uparams name="servOrderExcpInfo" iMaxOccurs="1">											
		            <wtc:uparam value="<%=srvOrderExcpId %>" type="string"/>
		            <wtc:uparam value="<%=excpType %>" type="int"/>
		            <wtc:uparam value="<%=excpReason %>" type="string"/>
		            <wtc:uparam value="<%=handleResult %>" type="string"/>
		            <wtc:uparam value="<%=handleLogin %>" type="string"/>
		          </wtc:uparams>
		        </wtc:uparams>
		      </wtc:uparams>
		    </wtc:uparams>
		  </wtc:uparams>
		</wtc:uparams>
		
		<wtc:uparams name="customer" iMaxOccurs="1">								
	    <wtc:uparams name="custDoc" iMaxOccurs="1">								
	      <wtc:uparams name="custDocBaseInfo" iMaxOccurs="1">				
	    	  <wtc:uparam value="<%=gCustId %>" type="long"/>
	      </wtc:uparams>
	     </wtc:uparams>
	     <wtc:uparam value="<%=cfmParamUtype%>" type="UTYPE"/>
		</wtc:uparams>
	 </wtc:uparams>

</wtc:utype>


<%
	System.out.println("2222=============================");
	retrunCode=retVal.getValue(0);//返回的retCode为LONG类型；
	returnMsg=retVal.getValue(1);
	System.out.println("returnCode=================="+retrunCode);
	System.out.println("returnMsg=======#################==========="+returnMsg);
%>
<%
 String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+
							"&retCodeForCntt="+retrunCode+
							"&opName="+opName+
							"&workNo="+loginNo+
							"&loginAccept="+loginAccept+
							"&pageActivePhone="+phoneNo+
							"&retMsgForCntt="+returnMsg+
							"&opBeginTime="+opBeginTime; 
%>
<%
	System.out.println("url："+url);
%>
<jsp:include page="<%=url%>" flush="true" />
<%	
	
	if(retrunCode.equals("0"))
	{
	
		String statisLoginAccept = request.getParameter("loginAccept"); /*流水*/
		String statisOpCode=opCode;
		String statisPhoneNo= request.getParameter("phoneNo");	
		String statisIdNo="";	
		String statisCustId="";
		String statisUrl = "/npage/public/pubCustSatisIn.jsp"
			+"?statisLoginAccept="+statisLoginAccept
			+"&statisOpCode="+statisOpCode
			+"&statisPhoneNo="+statisPhoneNo
			+"&statisIdNo="+statisIdNo	
			+"&statisCustId="+statisCustId;	
    	System.out.println("@zhangyan~~~~statisLoginAccept="+statisLoginAccept);
    	System.out.println("@zhangyan~~~~statisOpCode="+statisOpCode);
    	System.out.println("@zhangyan~~~~statisPhoneNo="+statisPhoneNo);
    	System.out.println("@zhangyan~~~~statisIdNo="+statisIdNo);
    	System.out.println("@zhangyan~~~~statisCustId="+statisCustId);
    	System.out.println("@zhangyan~~~~statisUrl="+statisUrl);
    	
   		if (statisOpCode.equals("g719")||statisOpCode.equals("1272"))
		{
		%>
		<jsp:include page="<%=statisUrl%>" flush="true" />	
		
		<%	
		}	
	%>
    <script language='JavaScript'>
        //rdShowMessageDialog("操作成功！");
        goNext("<%=custOrderId%>","<%=custOrderNo%>","<%=prtFlag%>");
    </script>            
<%
	}else{
%>
    <script language='JavaScript'>
        rdShowMessageDialog('错误<%=retrunCode%>：'+'<%=returnMsg%>，请重新操作！');
        window.history.go(-1);
   </script> 
<%     
  }            
%>
