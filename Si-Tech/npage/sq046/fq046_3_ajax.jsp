<%
  /*
   * ����:�ͻ������ɷѴ���
�� * �汾:  v1.0
�� * ����: 2009-01-15 10:00
�� * ����: wanglj
�� * ��Ȩ: sitech
��*/
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

	String op_Name = "һ���Է��ýɷ�";
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
	String sOprGroupId = (String) session.getAttribute("objectId");//  ��������Ӫҵ��  
	String sOpTime = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
	String orgCode = (String) session.getAttribute("orgCode");	
	String sRegionCode   = (String) session.getAttribute("cityId");	
	String sBureauId = (String) session.getAttribute("siteId"); //�����
	String sObjectId = (String) session.getAttribute("objectId"); //�����
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
		sysNote = "����Ա"+ workNo +"�Զ���"+ sCustOrderId +"����һ�����շѽɷѲ���";
	}
	if(opNote == null || "".equals(opNote)){
		opNote = "����Ա"+ workNo +"�Զ���"+ sCustOrderId +"����һ�����շѽɷѲ���";
	}
	
	
		String  groupIdH = (String)session.getAttribute("groupId");	
	if(sOprGroupId == null) sOprGroupId = groupIdH;
	if(sBureauId == null) sBureauId = groupIdH;
	if(sObjectId == null) sObjectId = groupIdH;
	if(sRegionCode ==null ) sRegionCode = orgCode.substring(0,2);   
	
	  /********tianyang add at 20090928 for POS�ɷ�����****start*****/
	  String payType				 = request.getParameter("payType");/**�ɷ����� payType=BX �ǽ��� payType=BY �ǹ���**/
	 // System.out.println("========== ningtn payType ["+payType+"]");
		String MerchantNameChs = request.getParameter("MerchantNameChs");/**�Ӵ˿�ʼ����Ϊ���в���**/
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
		/********tianyang add at 20090928 for POS�ɷ�����****end*******/
	
	
		/*-------hejwa add 2013��11��20��11:47:19 ���ڱ����г���Ӫ��2013��8�µڶ���ҵ��֧��ϵͳ����ĺ�-�����ն�ҵ��ȡ�����ܵ�����-------------------*/
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
			
			
			String 	g798BillTypeArr[]      = g798BillTypeArrStr.split("��",-1);	
			String 	g798BillNameArr[]      = g798BillNameArrStr.split("��",-1);	
			String 	g798ActualFeeUppeArr[] = g798ActualFeeUppeArrStr.split("��",-1);	
			String 	g798ActualFeeLoweArr[] = g798ActualFeeLoweArrStr.split("��",-1);	
			String 	g798BrandNameArr[]     = g798BrandNameArrStr.split("��",-1);	
			String 	g798TypeNameArr[]      = g798TypeNameArrStr.split("��",-1);	
			
	 
	
     UType toprInfo = new UType();
		      toprInfo.setUe("LONG","0");           // lLoginAccept ������ˮ     
					toprInfo.setUe("STRING",opCode);                  // sOpCode ��������                     
					toprInfo.setUe("STRING",workNo);	               // sLoginNo ������                      
					toprInfo.setUe("STRING",workPwd);      // sLoginPwd ��������                   
					toprInfo.setUe("STRING",sIpAddress);         // sIpAddress IP��ַ                    
					toprInfo.setUe("STRING",sOprGroupId);                 // sOprGroupId ��������Ӫҵ��           
					toprInfo.setUe("STRING",sOpTime);              // sOpTime ����ʱ��                     
					toprInfo.setUe("STRING",sRegionCode);                    // sRegionCode �������д���  
					toprInfo.setUe("STRING",opNote);                    // ��ע 
					toprInfo.setUe("STRING",sBureauId);                    //  ����� 
					toprInfo.setUe("STRING",sObjectId);                    //  �����
      		toprInfo.setUe("STRING",sysNote);
      		
      		toprInfo.setUe("STRING",checkNo);//֧Ʊ��
      		toprInfo.setUe("STRING",bankCode);//���д���
      		toprInfo.setUe("STRING",checkPay);//���
      		
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
      		
					System.out.println("--------------------opCode      ---------------"+ opCode      );          // sOpCode ��������                     
					System.out.println("--------------------workNo	    ---------------"+ workNo	    );         // sLoginNo ������                      
					System.out.println("--------------------workPwd     ---------------"+ workPwd     );      // sLoginPwd ��������                   
					System.out.println("--------------------sIpAddress  ---------------"+ sIpAddress  );     // sIpAddress IP��ַ                    
					System.out.println("--------------------sOprGroupId ---------------"+ sOprGroupId );              // sOprGroupId ��������Ӫҵ��           
					System.out.println("--------------------sOpTime     ---------------"+ sOpTime     );       // sOpTime ����ʱ��                     
					System.out.println("--------------------sRegionCode ---------------"+ sRegionCode );                 // sRegionCode �������д���  
					System.out.println("--------------------opNote      ---------------"+ opNote      );            // ��ע 
					System.out.println("--------------------sBureauId   ---------------"+ sBureauId   );               //  ����� 
					System.out.println("--------------------sObjectId   ---------------"+ sObjectId   );               //  �����
      		System.out.println("--------------------sysNote     ---------------"+ sysNote     );
 
 		UType u1 = new UType();//�ͻ�������б�
     for (int i = 0 ; i < arrayOrders.length ; i++ ){
         UType u11 = new UType(); //�ͻ������i
          u11.setUe("STRING",arrayOrders[i]);//�ͻ���������ID
          UType u112 = new UType(); //���񶨵��б�
             for (int j = 0 ; j < serverOrders.length ; j++ ){ 
             		 System.out.println(serverOrders[j]+".............."+arrayOrders[i]);
               if(!serverOrders[j].startsWith(arrayOrders[i]+"~")) continue;
               UType u1121 = new UType(); 
               u1121.setUe("STRING",serverOrders[j].split("~")[1]);//���񶨵�ID
               UType u11212 = new UType();// ���񶨵��ɷ���ϸ�б�
                    for(int k = 0 ; k < fees.length ; k++){
                         			if(!fees[k].startsWith(serverOrders[j]+"~")) continue; 
                              UType uu = new UType();//#���񶨵���i
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
			* ���ڱ����г���Ӫ��2013��8�µڶ���ҵ��֧��ϵͳ����ĺ�-�����ն�ҵ��ȡ�����ܵ����� hejwa add
			*/
			
     UType g798UType = new UType();//�ͻ�������б�
     for(int i=0;i<g798BillTypeArr.length;i++){
	     	UType g798BillUType = new UType();//#���񶨵���i
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
		
		 UType phonePayUType = new UType();//�ֻ�֧��
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
		String statisLoginAccept = loginAccept; /*��ˮ*/
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
							System.out.println("url��"+url);
							%>
<jsp:include page="<%=url%>" flush="true" />
	
	
var response = new AJAXPacket();
response.data.add("errorCode","<%=ret_code%>");
response.data.add("retMessage","<%=retMessage%>");
response.data.add("is_release","<%=is_release%>");
response.data.add("prtAccpetLoginStr","<%=prtAccpetLoginStr%>");
core.ajax.receivePacket(response);

<%}%>   
