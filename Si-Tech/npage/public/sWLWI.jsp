<%
    /********************
     version v2.0
     ������: si-tech
     *����zhangzhea�����ã�gaopeng
     *2013/4/2 ���ڶ� 18:53:11 gaopeng ������liyana���󣬹�������
     *
     ********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
		String regionCode 			= (String)session.getAttribute("regCode");	
		
		String iLoginAccept 		=  request.getParameter("iLoginAccept");						//��ˮ
		String iChnSource  			=  request.getParameter("iChnSource");						//������ʶ
		String iOpCode  				=  request.getParameter("iOpCode");								//��������
		String iLoginNo  				=  (String)session.getAttribute("workNo");				//��������	
		String iLoginPwd 				=  (String)session.getAttribute("password");			//��������	
		String iPhoneNo 				=  request.getParameter("iPhoneNo");							//�ֻ�����	
		String iUserPwd				  =  request.getParameter("iUserPwd");							//��������
		String iOrgCode 				=  (String)session.getAttribute("orgCode");				//���Ź���
		String iIdNo 						=  request.getParameter("iIdNo");									//�û�ID		
		String iOldSim				  =  request.getParameter("iOldSim");								//�û���SIM����			
		String iOldSimStatus 		=  request.getParameter("iOldSimStatus");					//�û���SMI��״̬	
		String iNewSim 					=  request.getParameter("iNewSim");								//�û���SIM����	
		String iNewSimShouldFee =  request.getParameter("iNewSimShouldFee");			//�û���SIM��Ӧ�շ�		
		String iNewSimRealFee 	=  request.getParameter("iNewSimRealFee");				//�û���SIM��ʵ�շ�		
		String iHandShouldFee 	=  request.getParameter("iHandShouldFee");				//�û�������Ӧ��		
		String iHandRealFee 		=  request.getParameter("iHandRealFee");					//�û�������ʵ��	
		String iSystemNote 			=  request.getParameter("iSystemNote");						//ϵͳ��ע
		String iOpNote 					=  request.getParameter("iOpNote");								//�û���ע
		String iIpAddr 					=  request.getParameter("iIpAddr");								//IP��ַ
		String iCardBZ 					=  request.getParameter("iCardBZ");								//д��״̬
		String iCardStatus 			=  request.getParameter("iCardStatus");						//�տ�״̬
		String iCardNo 					=  request.getParameter("iCardNo");								//�տ�����
		String iTransConId		  =  request.getParameter("iTransConId");						//ת���ʻ�
		String iTransMoney	 		=  request.getParameter("iTransMoney");						//ת����
		String iTransPhoneNo	 	=  request.getParameter("iTransPhoneNo");					//ת���ֻ���
		String iTurnPhoneNo	 		=  request.getParameter("iTurnPhoneNo");					//ת����Դ����
		String iTurnType			  =  request.getParameter("iTurnType");							//ת����Դ��������
		String iRemindPhone	 		=  request.getParameter("iRemindPhone");					//Ƿ�����Ѻ���	
		
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
