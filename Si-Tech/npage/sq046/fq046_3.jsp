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
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ include file="/npage/common/qcommon/print_include.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%String Readpaths = request.getRealPath("npage/properties")+"/getRDMessage.properties";%>

<%   
  System.out.println("----------------------------------fq046_3.jsp------------------------");
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
 System.out.println(".....................sCustOrderId"+sCustOrderId);
 System.out.println(".....................feeStr"+feeStr);
 System.out.println(".....................arrayOrder"+arrayOrder );
 System.out.println(".....................servOrder"+servOrder );
	if(arrayOrder.indexOf("|") == -1 || servOrder.indexOf("|") == -1){
%>
	<script>
		rdShowMessageDialog("客户订单查询错误!",0);
		if((typeof parent.removeTab )=="function")
		{
			  parent.removeTab('<%=opCode%>');
		}
	</script>
<%	 
}else{
	 arrayOrders = arrayOrder.split("\\|");
	 serverOrders = servOrder.split("\\|");
	 fees = feeStr.split("\\|");
	String workNo = (String) session.getAttribute("workNo");
	String workPwd = (String) session.getAttribute("password");
	String sOprGroupId = (String) session.getAttribute("objectId");//  操作归属营业厅  
	
	String sOpTime = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
	String orgCode = (String) session.getAttribute("orgCode");	
	
	
	String sRegionCode   = (String) session.getAttribute("cityId");	//=RegionCode
	String sBureauId = (String) session.getAttribute("siteId"); //处理点//=groupId
	String sObjectId = (String) session.getAttribute("objectId"); //处理局//=groupId
	String  groupIdH = (String)session.getAttribute("groupId");
	String sIpAddress =  request.getRemoteAddr();//IP	
	String sysNote = request.getParameter("sys_note");
	String opNote = request.getParameter("op_note");
	
	String checkNo = request.getParameter("checkNo");
	String bankCode = request.getParameter("bankCode");
	String checkPay = request.getParameter("checkPay");
	
	if(checkNo ==null )  checkNo = "";
	if(bankCode ==null ) bankCode = "";
	if(checkPay ==null ) checkPay = "";
	
	
	if(sOprGroupId == null) sOprGroupId = groupIdH;
	if(sBureauId == null) sBureauId = groupIdH;
	if(sObjectId == null) sObjectId = groupIdH;
	if(sRegionCode ==null ) sRegionCode = orgCode.substring(0,2);   
	
	
	
	
	if(sysNote == null || "".equals(sysNote)){
		sysNote = "操作员"+ workNo +"对订单"+ sCustOrderId +"进行一次性收费缴费操作";
	}
	if(opNote == null || "".equals(opNote)){
		opNote = "操作员"+ workNo +"对订单"+ sCustOrderId +"进行一次性收费缴费操作";
	}
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
 		System.out.println("=====arrayOrders.length=======" + arrayOrders.length);
     for (int i = 0 ; i < arrayOrders.length ; i++ ){
         UType u11 = new UType(); //客户子项订单i
          u11.setUe("STRING",arrayOrders[i]);//客户订单子项ID
          UType u112 = new UType(); //服务定单列表
          System.out.println("=====serverOrders.length=======" + serverOrders.length);
             for (int j = 0 ; j < serverOrders.length ; j++ ){ 
             		 System.out.println("serverOrders " + serverOrders[j]+".............."+arrayOrders[i]);
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
                                   uu.setUe("INT",ss[8]);
                                   uu.setUe("STRING",ss[9]); 
                                   uu.setUe("STRING",ss[10]); 
                                   uu.setUe("STRING",ss[11]); 
                                   uu.setUe("STRING",ss[12]); 
                                   uu.setUe("STRING",ss[13]); 
                                   uu.setUe("LONG",ss[14]); 
                                   
                             u11212.setUe(uu);
                    }
               u1121.setUe(u11212);
               u112.setUe(u1121);
            }
           u11.setUe(u112) ;
           u1.setUe(u11);
     } 
    // UtypeUtil.read(u1,0,out);
%>

<%String regionCode_sCustOrderPay = (String)session.getAttribute("regCode");%>
   <wtc:utype name="sCustOrderPay" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode_sCustOrderPay%>">
     <wtc:uparam value="<%=toprInfo%>" type="UTYPE"/> 
     <wtc:uparam value="<%=sCustOrderId%>" type="STRING"/>  
     <wtc:uparam value="<%=u1%>" type="UTYPE"/>  
   </wtc:utype>

<%
     String ret_code = retVal.getValue(0);
     String retMessage = retVal.getValue(1).replace('\n',' ');
     StringBuffer logBuffer_046 = new StringBuffer(80);
		WtcUtil.recursivePrint(retVal,1,"2",logBuffer_046);		
		System.out.println(logBuffer_046.toString());
	
     String isZXFlag="no";
     String yearMonthstr = new java.text.SimpleDateFormat("yyyyMM",Locale.getDefault()).format(new java.util.Date());
     if(ret_code.equals("0"))
     {
     	String is_release = retVal.getValue("2.1");
     	/**************start*wanghyd20131023增加如果是住资费变更*/
     		if(is_release.equals("Y")) {
     				String opcodeadds = request.getParameter("opcodeadd");
     						if("1270".equals(opcodeadds)) {
     						System.out.println("-----11111111111-----------------------"+sCustOrderId);
     										String newOfferIds="";
     										String liushuis="";
     										String sqlstr1="select to_char(create_accept) from dservordermsg where cust_order_id=:custorderids";
     										String sqlstr11="custorderids="+sCustOrderId;
     										%>
     										<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode_sCustOrderPay%>" retcode="retCode1" retmsg="retmsg1" outnum="1"> 
											    <wtc:param value="<%=sqlstr1%>"/>
											    <wtc:param value="<%=sqlstr11%>"/> 
											  </wtc:service>  
											  <wtc:array id="retResult1"  scope="end"/>	
     										<%
     										System.out.println("-----222222222222---------------------------"+retResult1.length);
     											if(retResult1.length>0) {
     													liushuis=retResult1[0][0];
     													System.out.println("-----333333333---------------------------"+liushuis);
     											}
     										 else {
		     										 	String sqlstr2="select create_accept  from dservordermsghis"+yearMonthstr+"  where cust_order_id=:custorderidss";	
		     										 	String sqlstr22="custorderidss="+sCustOrderId;
		     										%>
		     										<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode_sCustOrderPay%>" retcode="retCode2" retmsg="retmsg2" outnum="1"> 
													    <wtc:param value="<%=sqlstr2%>"/>
													    <wtc:param value="<%=sqlstr22%>"/> 
													  </wtc:service>  
													  <wtc:array id="retResult2"  scope="end"/>	
		     										<%
		     										System.out.println("-----444444444444---------------------------"+retResult2.length);
		     											if(retResult2.length>0) {
		     													liushuis=retResult2[0][0];
		     													System.out.println("-----5555---------------------------"+liushuis);
		     										  }else {
		     										  		liushuis="";
		     											}
     											}
     												if(!liushuis.equals("")) {
     											   	String sqlstr3="select offerid  from  prodoffertmpsect where opcode='1270' and offertype='10' and optype=1 and loginaccept=:loginaccepts";	
		     										 	String sqlstr33="loginaccepts="+liushuis;
		     										%>
		     										<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode_sCustOrderPay%>" retcode="retCode22" retmsg="retmsg22" outnum="1"> 
													    <wtc:param value="<%=sqlstr3%>"/>
													    <wtc:param value="<%=sqlstr33%>"/> 
													  </wtc:service>  
													  <wtc:array id="retResult22"  scope="end"/>	
		     										<%
		     											System.out.println("-----66666---------------------------"+retResult22.length);
		     											if(retResult22.length>0)	{
		     													newOfferIds= retResult22[0][0];
		     													System.out.println("-----777777777777777---------------------------"+newOfferIds);
		     											}	     										 	
     												}
     												if(!newOfferIds.equals("")) {
     														String sqlprod="select offer_id from product_offer where offer_attr_type in("+readValue("1270","bg","xz",Readpaths)+") and offer_id=:offersid ";
																String sqlprod2="offersid="+newOfferIds;
																System.out.println("-----888888888---------------------------"+sqlprod);	
																%>
																		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode_sCustOrderPay%>" retcode="retCode3" retmsg="retmsg3" outnum="1"> 
																	    <wtc:param value="<%=sqlprod%>"/>
																	    <wtc:param value="<%=sqlprod2%>"/> 
																	  </wtc:service>  
																	  <wtc:array id="retResult3"  scope="end"/>	
																<%
																System.out.println("-----888888888---------------------------"+retResult3.length);
																		if(retResult3.length>0) {
																				isZXFlag="yes";
																		}
     												}

     						}
     		}
     %>
     <script>
     	var feeFlag ="<%=feeStr%>";
     	
			function showPrtDlg()
			{  
				//显示打印对话框
				var h=210;
				var w=400;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				var pType="subprint";
			
				var mode_code=null;
				var fav_code=null;
				var area_code=null;
			
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
				var path = "<%=request.getContextPath()%>/npage/sq046/show1270Button.jsp?";
				var path = path  + "&phone_no=<%=activePhone%>";
				var ret=window.showModalDialog(path,"",prop);
				
					if (ret!=undefined)
				{
				var flag = ret;
							
					<%
					  int buttonnum=Integer.parseInt(readValue("1270","button","num",Readpaths));
						for(int i=1;i<=buttonnum;i++) {
					%>				
					if(flag=="<%=readValue("1270","button"+i,"value",Readpaths)%>") {
						parent.parent.L("<%=readValue("1270","tiaozhuan"+i,"openway",Readpaths)%>","<%=readValue("1270","tiaozhuan"+i,"opcode",Readpaths)%>","<%=readValue("1270","tiaozhuan"+i,"opname",Readpaths)%>","<%=readValue("1270","tiaozhuan"+i,"url",Readpaths)%>&activePhone=<%=activePhone%>&broadPhone=","000");		
					}
					<%}%>
					parent.removeTab('1270');
					parent.removeTab('q046');

			
				}else {
					parent.removeTab('1270');
					parent.removeTab('q046');
				}
			}
     	if(feeFlag == "noFee"){
     		//rdShowMessageDialog("该订单是免费订单，不进行收费!",2); 
     	}else{
     		  rdShowMessageDialog("业务受理成功！",2);
    	}
    	if("<%=is_release%>" == "Y"){
     			  /*parent.parent.removeTab("custid<%=gCustId%>");*/
     			  <%
     			  if(isZXFlag.equals("no")) {
     			  %>
     			  rdShowMessageDialog("业务受理成功！",2);
						parent.user_index.clearPage();
     			 <%}else {%>
     				
					showPrtDlg();
     			//parent.user_index.clearPage();  	
     			 <%}%>
     	}else{
		      parent.addTab(false,'q025','客户订单审核','/npage/sq025/fq025.jsp?gCustId=<%=gCustId%>&opCode=q025&opName=客户订单审核');
		      if((typeof parent.removeTab )=="function")
					{
					  parent.removeTab('<%=opCode%>');
					}
			}
     </script>
     <%}else{%>    	
     <script>
           rdShowMessageDialog('缴费失败!,<%=retMessage%>',1);
           <%
           if(prtAccpetLoginStr!=null&&!(prtAccpetLoginStr.equals(""))){
           	String[] prtAccpetLoginArr = prtAccpetLoginStr.split("\\|");
           	for (int i=0 ;i<prtAccpetLoginArr.length; i++){
           		String[] tmp = prtAccpetLoginArr[i].split("~");
           %>
           		deleteFail('<%=tmp[1]%>','<%=tmp[0]%>','<%=opCode%>');
           <%		
            }
            }
           %>
           removeCurrentTab();
           //parent.removeTab('<%=opCode%>');
     </script>			
    <%}
  }%>
