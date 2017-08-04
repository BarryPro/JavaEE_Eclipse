<%
    /********************
     version v2.0
     开发商: si-tech
     *服务：zhangzhea，掉用：gaopeng
     *2013/4/2 星期二 18:53:11 gaopeng 物联网liyana需求，公共服务
     *
     ********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
		String regionCode 			= (String)session.getAttribute("regCode");	
		
		String iLoginAccept 		=  request.getParameter("iLoginAccept");						//流水
		String iChnSource  			=  request.getParameter("iChnSource");						//渠道标识
		String iOpCode  				=  request.getParameter("iOpCode");								//操作代码
		String iLoginNo  				=  (String)session.getAttribute("workNo");				//操作工号	
		String iLoginPwd 				=  (String)session.getAttribute("password");			//工号密码	
		String iPhoneNo 				=  request.getParameter("iPhoneNo");							//手机号码	
		String iUserPwd				  =  request.getParameter("iUserPwd");							//号码密码
		String iOrgCode 				=  (String)session.getAttribute("orgCode");				//工号归属
		String iIdNo 						=  request.getParameter("iIdNo");									//用户ID		
		String iOldSim				  =  request.getParameter("iOldSim");								//用户旧SIM卡号			
		String iOldSimStatus 		=  request.getParameter("iOldSimStatus");					//用户旧SMI卡状态	
		String iNewSim 					=  request.getParameter("iNewSim");								//用户新SIM卡号	
		String iNewSimShouldFee =  request.getParameter("iNewSimShouldFee");			//用户新SIM卡应收费		
		String iNewSimRealFee 	=  request.getParameter("iNewSimRealFee");				//用户新SIM卡实收费		
		String iHandShouldFee 	=  request.getParameter("iHandShouldFee");				//用户手续费应收		
		String iHandRealFee 		=  request.getParameter("iHandRealFee");					//用户手续费实收	
		String iSystemNote 			=  request.getParameter("iSystemNote");						//系统备注
		String iOpNote 					=  request.getParameter("iOpNote");								//用户备注
		String iIpAddr 					=  request.getParameter("iIpAddr");								//IP地址
		String iCardBZ 					=  request.getParameter("iCardBZ");								//写卡状态
		String iCardStatus 			=  request.getParameter("iCardStatus");						//空卡状态
		String iCardNo 					=  request.getParameter("iCardNo");								//空卡卡号
		String iTransConId		  =  request.getParameter("iTransConId");						//转存帐户
		String iTransMoney	 		=  request.getParameter("iTransMoney");						//转存金额
		String iTransPhoneNo	 	=  request.getParameter("iTransPhoneNo");					//转存手机号
		String iTurnPhoneNo	 		=  request.getParameter("iTurnPhoneNo");					//转赠资源号码
		String iTurnType			  =  request.getParameter("iTurnType");							//转赠资源号码类型
		String iRemindPhone	 		=  request.getParameter("iRemindPhone");					//欠费提醒号码	
		
	  String issqxh = request.getParameter("issqxh");
  	String zfsjhms = request.getParameter("zfsjhms");
  	String khlxdhs = request.getParameter("khlxdhs");
		
		System.out.println("iLoginAccept 		  "+iLoginAccept 		  );
		System.out.println("iChnSource  			"+iChnSource  			);
		System.out.println("iOpCode  				  "+iOpCode  				  );
		System.out.println("iLoginNo  				"+iLoginNo  				);
		System.out.println("iLoginPwd 				"+iLoginPwd 				);
		System.out.println("iPhoneNo 				  "+iPhoneNo 				  );
		System.out.println("iUserPwd				  "+iUserPwd				  );
		System.out.println("iOrgCode 				  "+iOrgCode 				  );
		System.out.println("iIdNo 						"+iIdNo 						);
		System.out.println("iOldSim				    "+iOldSim				    );
		System.out.println("iOldSimStatus 		"+iOldSimStatus 		);
		System.out.println("iNewSim 					"+iNewSim 					);
		System.out.println("iNewSimShouldFee  "+iNewSimShouldFee  );
		System.out.println("iNewSimRealFee 	  "+iNewSimRealFee 	  );
		System.out.println("iHandShouldFee 	  "+iHandShouldFee 	  );
		System.out.println("iHandRealFee 		  "+iHandRealFee 		  );
		System.out.println("iSystemNote 			"+iSystemNote 			);
		System.out.println("iOpNote 					"+iOpNote 					);
		System.out.println("iIpAddr 					"+iIpAddr 					);
		System.out.println("iCardBZ 					"+iCardBZ 					);
		System.out.println("iCardStatus 			"+iCardStatus 			);
		System.out.println("iCardNo 					"+iCardNo 					);
		System.out.println("iTransConId		    "+iTransConId		    );
		System.out.println("iTransMoney	 		  "+iTransMoney	 		  );
		System.out.println("iTransPhoneNo	 	  "+iTransPhoneNo	 	  );
		System.out.println("iTurnPhoneNo	 		"+iTurnPhoneNo	 		);
		System.out.println("iTurnType			    "+iTurnType			    );
		System.out.println("iRemindPhone	 		"+iRemindPhone	 		);
		
		
		

    String[] inPubParams = new String[31];
    inPubParams[0] = iLoginAccept 			;
    inPubParams[1] = iChnSource  				;
    inPubParams[2] = iOpCode  					;
    inPubParams[3] = iLoginNo  					;
    inPubParams[4] = iLoginPwd 					;
    inPubParams[5] = iPhoneNo 					;
    inPubParams[6] = iUserPwd				    ;
    inPubParams[7] = iOrgCode 					;
    inPubParams[8] = iIdNo 						  ; 
    inPubParams[9] = iOldSim				  	;
    inPubParams[10] =iOldSimStatus 		  ;
    inPubParams[11] =iNewSim 						;	
    inPubParams[12] =iNewSimShouldFee 	;
    inPubParams[13] =iNewSimRealFee 	;
    inPubParams[14] =iHandShouldFee 	; 	
    inPubParams[15] =iHandRealFee 		; 	
    inPubParams[16] =iSystemNote 			;	
    inPubParams[17] =iOpNote 					;	
    inPubParams[18] =iIpAddr 					;	
    inPubParams[19] =iCardBZ 					;	
    inPubParams[20] =iCardStatus 			;	
    inPubParams[21] =iCardNo 					;	
    inPubParams[22] =iTransConId		  ;	
    inPubParams[23] =iTransMoney	 		;  
    inPubParams[24] =iTransPhoneNo	 	;		
    inPubParams[25] =iTurnPhoneNo	 		; 	
		inPubParams[26] =iTurnType			  ;		
    inPubParams[27] =iRemindPhone	 		;  
    inPubParams[28] =issqxh	 		      ; 
    inPubParams[29] =zfsjhms	 		    ; 
    inPubParams[30] =khlxdhs	 		    ; 
%>                   		
		<wtc:service name="sWLWInterFace" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode1" retmsg="errMsg1"  outnum="2">
		<wtc:param value="<%=inPubParams[0]%>"/>
		<wtc:param value="<%=inPubParams[1]%>"/>
		<wtc:param value="<%=inPubParams[2]%>"/>
		<wtc:param value="<%=inPubParams[3]%>"/>
		<wtc:param value="<%=inPubParams[4]%>"/>
		<wtc:param value="<%=inPubParams[5]%>"/>
		<wtc:param value="<%=inPubParams[6]%>"/>
		<wtc:param value="<%=inPubParams[7]%>"/>
		<wtc:param value="<%=inPubParams[8]%>"/>
		<wtc:param value="<%=inPubParams[9]%>"/>	
		<wtc:param value="<%=inPubParams[10]%>"/>
		<wtc:param value="<%=inPubParams[11]%>"/>
		<wtc:param value="<%=inPubParams[12]%>"/>
		<wtc:param value="<%=inPubParams[13]%>"/>
		<wtc:param value="<%=inPubParams[14]%>"/>
		<wtc:param value="<%=inPubParams[15]%>"/>
		<wtc:param value="<%=inPubParams[16]%>"/>
		<wtc:param value="<%=inPubParams[17]%>"/>
		<wtc:param value="<%=inPubParams[18]%>"/>
		<wtc:param value="<%=inPubParams[19]%>"/>	
		<wtc:param value="<%=inPubParams[20]%>"/>
		<wtc:param value="<%=inPubParams[21]%>"/>	
		<wtc:param value="<%=inPubParams[22]%>"/>
		<wtc:param value="<%=inPubParams[23]%>"/>	
		<wtc:param value="<%=inPubParams[24]%>"/>	
		<wtc:param value="<%=inPubParams[25]%>"/>	
		<wtc:param value="<%=inPubParams[26]%>"/>
		<wtc:param value="<%=inPubParams[27]%>"/>
		<wtc:param value="<%=inPubParams[28]%>"/>
		<wtc:param value="<%=inPubParams[29]%>"/>
		<wtc:param value="<%=inPubParams[30]%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end"/>



<%
    String errCode = errCode1;
    String errMsg = errMsg1;
%>
var response = new AJAXPacket();
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
core.ajax.receivePacket(response);
