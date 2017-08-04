<%
  /*
   * 功能:客户订单缴费处理
　 * 版本:  v1.0
　 * 日期: 2009-01-15 10:00
　 * 作者: wanglj
　 * 版权: sitech
　*/
%> 
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
	String opCode = request.getParameter("opCode");
%>
<%@ page import="java.util.*"%>

<%   
System.out.println("----------------------------------fq046_3_ajax.jsp------------------------");

	String op_Name = "一次性费用缴费";
	String sysAcceptl = "";
	String phoneNo = "";
	
	
	
	String gCustId = request.getParameter("gCustId");
	String sCustOrderId = request.getParameter("custOrderId");
	String prtAccpetLoginStr = request.getParameter("prtAccpetLoginStr");
	String[] arrayOrders = new String[]{};
	String[] serverOrders  = new String[]{};
	String[] fees  = new String[]{};
	String prtFlag = request.getParameter("prtFlag");
	String feeStr = request.getParameter("feeStr") == null ? "noFee" :request.getParameter("feeStr");
	String arrayOrder = request.getParameter("arrayOrder");
	String servOrder = request.getParameter("servOrder");
	String loginAccept = request.getParameter("loginAccept");
	
	 System.out.println(".....................prtAccpetLoginStr"+prtAccpetLoginStr);
	 System.out.println(".....................sCustOrderId"+sCustOrderId);
     System.out.println(".....................feeStr"+feeStr);
     System.out.println(".....................arrayOrder"+arrayOrder );
     System.out.println(".....................servOrder"+servOrder );
	if(arrayOrder.indexOf("|") != -1 || servOrder.indexOf("|") != -1){
 
	 arrayOrders = arrayOrder.split("\\|");
	 serverOrders = servOrder.split("\\|");
	 fees = feeStr.split("\\|");
	String workNo = (String) session.getAttribute("workNo");
	String workPwd = (String) session.getAttribute("password");
	String sOprGroupId = (String) session.getAttribute("objectId");//  操作归属营业厅  
	String sOpTime = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
	String orgCode = (String) session.getAttribute("orgCode");	
	String sRegionCode   = (String) session.getAttribute("cityId");	
	String sBureauId = (String) session.getAttribute("siteId"); //处理点
	String sObjectId = (String) session.getAttribute("objectId"); //处理局
	String sIpAddress =  request.getRemoteAddr();//IP	
	String sysNote = request.getParameter("sys_note");
	String opNote = request.getParameter("op_note");
	
	
	String checkNo = request.getParameter("checkNo");
	String bankCode = request.getParameter("bankCode");
	String checkPay = request.getParameter("checkPay");
	String servPhoneNo = WtcUtil.repStr(request.getParameter("servPhoneNo"),"");
	String v_opCode_order = request.getParameter("v_opCode_order");
	
	String offeridkd = WtcUtil.repStr(request.getParameter("offeridkd"),"");
	String phonepayPhoneNo = WtcUtil.repStr(request.getParameter("phonepayPhoneNo"),"");
	String jifenPayFee = WtcUtil.repStr(request.getParameter("jifenPayFee"),"0");
	
	if(checkNo ==null )  checkNo = "";
	if(bankCode ==null ) bankCode = "";
	if(checkPay ==null ) checkPay = "";
	

	if(sysNote == null || "".equals(sysNote)){
		sysNote = "操作员"+ workNo +"对订单"+ sCustOrderId +"进行一次性收费缴费操作";
	}
	if(opNote == null || "".equals(opNote)){
		opNote = "操作员"+ workNo +"对订单"+ sCustOrderId +"进行一次性收费缴费操作";
	}
	
	
		String  groupIdH = (String)session.getAttribute("groupId");	
	if(sOprGroupId == null) sOprGroupId = groupIdH;
	if(sBureauId == null) sBureauId = groupIdH;
	if(sObjectId == null) sObjectId = groupIdH;
	if(sRegionCode ==null ) sRegionCode = orgCode.substring(0,2);   
	
	  /********tianyang add at 20090928 for POS缴费需求****start*****/
	  String payType				 = request.getParameter("payType");/**缴费类型 payType=BX 是建行 payType=BY 是工行**/
	 // System.out.println("========== ningtn payType ["+payType+"]");
		String MerchantNameChs = request.getParameter("MerchantNameChs");/**从此开始以下为银行参数**/
		String MerchantId      = request.getParameter("MerchantId");
		String TerminalId      = request.getParameter("TerminalId");
		String IssCode         = request.getParameter("IssCode");
		String AcqCode         = request.getParameter("AcqCode");
		String CardNo          = request.getParameter("CardNo");
		String BatchNo         = request.getParameter("BatchNo");
		String Response_time   = request.getParameter("Response_time");
		String Rrn             = request.getParameter("Rrn");
		String AuthNo          = request.getParameter("AuthNo");
		String TraceNo         = request.getParameter("TraceNo");
		String Request_time    = request.getParameter("Request_time");
		String CardNoPingBi    = request.getParameter("CardNoPingBi");
		String ExpDate         = request.getParameter("ExpDate");
		String Remak           = request.getParameter("Remak");
		String TC              = request.getParameter("TC");
		/********tianyang add at 20090928 for POS缴费需求****end*******/
	
	
		/*-------hejwa add 2013年11月20日11:47:19 关于报送市场经营部2013年8月第二批业务支撑系统需求的函-新增终端业务取消功能的需求-------------------*/
			String g798BillTypeArrStr = request.getParameter("g798BillTypeArr")==null?"":request.getParameter("g798BillTypeArr");
			String g798BillNameArrStr = request.getParameter("g798BillNameArr")==null?"":request.getParameter("g798BillNameArr");
			String g798ActualFeeUppeArrStr = request.getParameter("g798ActualFeeUppeArr")==null?"":request.getParameter("g798ActualFeeUppeArr");
			String g798ActualFeeLoweArrStr = request.getParameter("g798ActualFeeLoweArr")==null?"":request.getParameter("g798ActualFeeLoweArr");
			String g798BrandNameArrStr = request.getParameter("g798BrandNameArr")==null?"":request.getParameter("g798BrandNameArr");
			String g798TypeNameArrStr = request.getParameter("g798TypeNameArr")==null?"":request.getParameter("g798TypeNameArr");
			
			System.out.println("--------------g798BillTypeArrStr-------------------"+g798BillTypeArrStr);
			System.out.println("--------------g798BillNameArrStr-------------------"+g798BillNameArrStr);
			System.out.println("--------------g798ActualFeeUppeArrStr--------------"+g798ActualFeeUppeArrStr);
			System.out.println("--------------g798ActualFeeLoweArrStr--------------"+g798ActualFeeLoweArrStr);
			System.out.println("--------------g798BrandNameArrStr------------------"+g798BrandNameArrStr);
			System.out.println("--------------g798TypeNameArrStr-------------------"+g798TypeNameArrStr);
			
			
			String 	g798BillTypeArr[]      = g798BillTypeArrStr.split("§",-1);	
			String 	g798BillNameArr[]      = g798BillNameArrStr.split("§",-1);	
			String 	g798ActualFeeUppeArr[] = g798ActualFeeUppeArrStr.split("§",-1);	
			String 	g798ActualFeeLoweArr[] = g798ActualFeeLoweArrStr.split("§",-1);	
			String 	g798BrandNameArr[]     = g798BrandNameArrStr.split("§",-1);	
			String 	g798TypeNameArr[]      = g798TypeNameArrStr.split("§",-1);	
			
	 
	
     UType toprInfo = new UType();
		      toprInfo.setUe("LONG","0");           // lLoginAccept 操作流水     
					toprInfo.setUe("STRING",opCode);                  // sOpCode 操作代码                     
					toprInfo.setUe("STRING",workNo);	               // sLoginNo 操作工                      
					toprInfo.setUe("STRING",workPwd);      // sLoginPwd 工号密码                   
					toprInfo.setUe("STRING",sIpAddress);         // sIpAddress IP地址                    
					toprInfo.setUe("STRING",sOprGroupId);                 // sOprGroupId 操作归属营业厅           
					toprInfo.setUe("STRING",sOpTime);              // sOpTime 操作时间                     
					toprInfo.setUe("STRING",sRegionCode);                    // sRegionCode 归属地市代码  
					toprInfo.setUe("STRING",opNote);                    // 备注 
					toprInfo.setUe("STRING",sBureauId);                    //  处理点 
					toprInfo.setUe("STRING",sObjectId);                    //  处理局
      		toprInfo.setUe("STRING",sysNote);
      		
      		toprInfo.setUe("STRING",checkNo);//支票号
      		toprInfo.setUe("STRING",bankCode);//银行代码
      		toprInfo.setUe("STRING",checkPay);//金额
      		
      		/****tianyang add for pos start *****/
				  toprInfo.setUe("STRING", payType);
				  toprInfo.setUe("STRING", MerchantNameChs);
				  toprInfo.setUe("STRING", MerchantId);
				  toprInfo.setUe("STRING", TerminalId);
				  toprInfo.setUe("STRING", IssCode);
				  toprInfo.setUe("STRING", AcqCode);
				  toprInfo.setUe("STRING", CardNo);
				  toprInfo.setUe("STRING", BatchNo);
				  toprInfo.setUe("STRING", Response_time);
				  toprInfo.setUe("STRING", Rrn);
				  toprInfo.setUe("STRING", AuthNo);
				  toprInfo.setUe("STRING", TraceNo);
				  toprInfo.setUe("STRING", Request_time);
				  toprInfo.setUe("STRING", CardNoPingBi);
				  toprInfo.setUe("STRING", ExpDate);
				  toprInfo.setUe("STRING", Remak);
				  toprInfo.setUe("STRING", TC);
				  /****tianyang add for pos end *****/
      		
					System.out.println("--------------------opCode      ---------------"+ opCode      );          // sOpCode 操作代码                     
					System.out.println("--------------------workNo	    ---------------"+ workNo	    );         // sLoginNo 操作工                      
					System.out.println("--------------------workPwd     ---------------"+ workPwd     );      // sLoginPwd 工号密码                   
					System.out.println("--------------------sIpAddress  ---------------"+ sIpAddress  );     // sIpAddress IP地址                    
					System.out.println("--------------------sOprGroupId ---------------"+ sOprGroupId );              // sOprGroupId 操作归属营业厅           
					System.out.println("--------------------sOpTime     ---------------"+ sOpTime     );       // sOpTime 操作时间                     
					System.out.println("--------------------sRegionCode ---------------"+ sRegionCode );                 // sRegionCode 归属地市代码  
					System.out.println("--------------------opNote      ---------------"+ opNote      );            // 备注 
					System.out.println("--------------------sBureauId   ---------------"+ sBureauId   );               //  处理点 
					System.out.println("--------------------sObjectId   ---------------"+ sObjectId   );               //  处理局
      		System.out.println("--------------------sysNote     ---------------"+ sysNote     );
 
 		UType u1 = new UType();//客户子项订单列表
     for (int i = 0 ; i < arrayOrders.length ; i++ ){
         UType u11 = new UType(); //客户子项订单i
          u11.setUe("STRING",arrayOrders[i]);//客户订单子项ID
          UType u112 = new UType(); //服务定单列表
             for (int j = 0 ; j < serverOrders.length ; j++ ){ 
             		 System.out.println(serverOrders[j]+".............."+arrayOrders[i]);
               if(!serverOrders[j].startsWith(arrayOrders[i]+"~")) continue;
               UType u1121 = new UType(); 
               u1121.setUe("STRING",serverOrders[j].split("~")[1]);//服务定单ID
               UType u11212 = new UType();// 服务定单缴费明细列表
                    for(int k = 0 ; k < fees.length ; k++){
                         			if(!fees[k].startsWith(serverOrders[j]+"~")) continue; 
                              UType uu = new UType();//#服务定单项i
                                   String[] ss = fees[k].split("@")[1].split("~");
                                   uu.setUe("STRING",ss[0]);
                                   uu.setUe("DOUBLE",ss[1]);
                                   uu.setUe("DOUBLE",ss[2]);
                                   uu.setUe("DOUBLE",ss[4]);
                                   uu.setUe("DOUBLE",ss[3]);
                                   uu.setUe("STRING",ss[5]);
                                   uu.setUe("STRING",ss[6]); 
                                   uu.setUe("STRING",ss[7]);
                                   uu.setUe("INT",   ss[8]);
                                   uu.setUe("STRING",ss[9]); 
                                   uu.setUe("STRING",ss[10]); 
                                   uu.setUe("STRING",ss[11]); 
                                   uu.setUe("STRING",ss[12]); 
                                   uu.setUe("STRING",ss[13]); 
                                   uu.setUe("LONG",  ss[14]); 
                             u11212.setUe(uu);
                    }
               u1121.setUe(u11212);
               u112.setUe(u1121);
            }
           u11.setUe(u112) ;
           u1.setUe(u11);
     } 
     
			/***
			* 关于报送市场经营部2013年8月第二批业务支撑系统需求的函-新增终端业务取消功能的需求 hejwa add
			*/
			
     UType g798UType = new UType();//客户子项订单列表
     for(int i=0;i<g798BillTypeArr.length;i++){
	     	UType g798BillUType = new UType();//#服务定单项i
	     	g798BillUType.setUe("STRING",g798BillTypeArr[i]); 
	     	g798BillUType.setUe("STRING",g798BillNameArr[i]); 
	     	g798BillUType.setUe("STRING",g798ActualFeeUppeArr[i]); 
	     	g798BillUType.setUe("STRING",g798ActualFeeLoweArr[i]); 
	     	g798BillUType.setUe("STRING",g798BrandNameArr[i]); 
	     	g798BillUType.setUe("STRING",g798TypeNameArr[i]); 
	     	g798UType.setUe(g798BillUType);
     }
    StringBuffer logBuffer_uu = new StringBuffer(80);
		WtcUtil.recursivePrint(g798UType,1,"2",logBuffer_uu);		
		System.out.println(logBuffer_uu.toString());
		
		 UType phonePayUType = new UType();//手机支付
		 phonePayUType.setUe("STRING",servPhoneNo); 
		 phonePayUType.setUe("STRING",offeridkd); 
		 phonePayUType.setUe("STRING",phonepayPhoneNo);
		 phonePayUType.setUe("STRING",jifenPayFee);
     	System.out.println("liangyl----servPhoneNo-------"+servPhoneNo);
     	System.out.println("liangyl----offeridkd-------"+offeridkd);
     	System.out.println("liangyl----phonepayPhoneNo-------"+phonepayPhoneNo);
     	System.out.println("liangyl----jifenPayFee-------"+jifenPayFee);
%>

<%String regionCode_sCustOrderPay = (String)session.getAttribute("regCode");%>
   <wtc:utype name="sCustOrderPay" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode_sCustOrderPay%>">
     <wtc:uparam value="<%=toprInfo%>" type="UTYPE"/> 
     <wtc:uparam value="<%=sCustOrderId%>" type="STRING"/>  
     <wtc:uparam value="<%=u1%>" type="UTYPE"/>  
     <wtc:uparam value="<%=g798UType%>" type="UTYPE"/>
     <wtc:uparam value="<%=phonePayUType%>" type="UTYPE"/>
   </wtc:utype>

<%
     String ret_code = retVal.getValue(0);
     String retMessage = retVal.getValue(1).replace('\n',' ');
     StringBuffer logBuffer_046 = new StringBuffer(80);
		WtcUtil.recursivePrint(retVal,1,"2",logBuffer_046);		
		System.out.println(logBuffer_046.toString());
     String is_release= "";
     if(ret_code.equals("0"))
     {
     	 is_release = retVal.getValue("2.1");
     }
%>

<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+
							"&retCodeForCntt="+ret_code+
							"&opName="+op_Name+
							"&workNo="+workNo+
							"&loginAccept="+sysAcceptl+
							"&pageActivePhone="+phoneNo+
							"&retMsgForCntt="+retMessage+
							"&opBeginTime="+opBeginTime; 
	
	if("0".equals(ret_code)&&("1104".equals(v_opCode_order)||"g794".equals(v_opCode_order))){
		String statisLoginAccept = loginAccept; /*流水*/
	  	String statisOpCode=v_opCode_order;
	  	String statisPhoneNo= servPhoneNo;
	  	String statisUrl1 = "/npage/public/pubSendNPS.jsp"
  			+"?statisLoginAccept="+statisLoginAccept
  			+"&statisOpCode="+statisOpCode
  			+"&statisPhoneNo="+statisPhoneNo;
	%>
	<jsp:include page="<%=statisUrl1%>" flush="true" />
	<%
	}
	%>
							
							
							
							<%
							System.out.println("url："+url);
							%>
<jsp:include page="<%=url%>" flush="true" />
	
	
var response = new AJAXPacket();
response.data.add("errorCode","<%=ret_code%>");
response.data.add("retMessage","<%=retMessage%>");
response.data.add("is_release","<%=is_release%>");
response.data.add("prtAccpetLoginStr","<%=prtAccpetLoginStr%>");
core.ajax.receivePacket(response);

<%}%>   
