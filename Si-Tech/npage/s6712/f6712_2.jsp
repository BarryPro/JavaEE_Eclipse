<% 
  /*
   * ����: ���˲�������
�� * �汾: v1.00
�� * ����: 2007/09/13
�� * ����: liubo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸����� 2008-01-10     �޸���leimd      �޸�Ŀ��
   *  
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
//    SPubCallSvrImpl callView = new SPubCallSvrImpl();
	String regionCode = (String)session.getAttribute("regCode");			//���д���
//    String[] retStr = null;
    
    String sInLoginNo         = request.getParameter("loginNo");			//��������        			 
    String sInLoginPasswd     = request.getParameter("loginPwd");        	 //��������             
    String sInOpCode          = request.getParameter("opCode");          	 //���ܴ���          
    String sInOpNote          = request.getParameter("opNote");           	//�û���ע         
    String sInOrgCode         = request.getParameter("orgCode");          	//�������Ź���       
    String sInSystemNote      = request.getParameter("sysNote");          	//ϵͳ��ע           
    String sInIpAddr          = request.getParameter("ip_Addr");          	//����IP��ַ          
    String sInLoginAccept     = request.getParameter("loginAccept");    	//��ˮ                  
    String sInPhoneNo         = request.getParameter("phoneNo");         	//�û��ֻ���         
    String sInAddMode         = request.getParameter("mebProdCode");		//��ѡ�ײ�        				  
    String sInEndChgFlag      = request.getParameter("matureFlag")==null?"N":request.getParameter("matureFlag");  //����ת���±�־  
    String sInNextMode        = request.getParameter("matureProdCode")==null?"":request.getParameter("matureProdCode");	      //���ں�ת���²�Ʒ 
    System.out.println("sInPhoneNosInPhoneNosInPhoneNosInPhoneNo"+sInPhoneNo);
    String sInCreateType      = "9";	                                    //ҵ����������:00:BOSS
    
	  ArrayList paramsIn = new ArrayList();
	
    paramsIn.add(new String[]{sInLoginNo        });
    paramsIn.add(new String[]{sInLoginPasswd    });
    paramsIn.add(new String[]{sInOpCode         });
    paramsIn.add(new String[]{sInOpNote         });
    paramsIn.add(new String[]{sInOrgCode        });
    paramsIn.add(new String[]{sInSystemNote     });
    paramsIn.add(new String[]{sInIpAddr         });
    paramsIn.add(new String[]{sInLoginAccept    });
    paramsIn.add(new String[]{sInPhoneNo        });
    paramsIn.add(new String[]{sInAddMode        });
    paramsIn.add(new String[]{sInEndChgFlag     }); 
    paramsIn.add(new String[]{sInNextMode       });
    paramsIn.add(new String[]{sInCreateType       });
    
//		retStr = callView.callService("s6710Cfm", paramsIn, "3", "region", regionCode);
//		callView.printRetValue();
%>
	<wtc:service name="s6710Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=sInLoginNo%>"/>
		<wtc:param value="<%=sInLoginPasswd%>"/>
		<wtc:param value="<%=sInOpCode%>"/>
		<wtc:param value="<%=sInOpNote%>"/>
		<wtc:param value="<%=sInOrgCode%>"/>
		<wtc:param value="<%=sInSystemNote%>"/>
		<wtc:param value="<%=sInIpAddr%>"/>
		<wtc:param value="<%=sInLoginAccept%>"/>
		<wtc:param value="<%=sInPhoneNo%>"/>
		<wtc:param value="<%=sInAddMode%>"/>
		<wtc:param value="<%=sInEndChgFlag%>"/>
		<wtc:param value="<%=sInNextMode%>"/>
		<wtc:param value="<%=sInCreateType%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
   String error_code = retCode;
   String error_msg  = retMsg;
   String url = "/npage/contact/upCnttInfo.jsp?opCode="+sInOpCode+"&retCodeForCntt="+retCode+"&opName="+"���˲����Ʒ���"+"&workNo="+sInLoginNo+"&loginAccept="+sInLoginAccept+"&pageActivePhone="+sInPhoneNo+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
		if(!error_code.equals("000000")){
		%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=error_msg%>",0);
			history.go(-1);
		</script>
		<%}else{%>
		  <script language="JavaScript">
			rdShowMessageDialog("���˲����Ʒ����ɹ�",2);
			location = "f6712_1.jsp?activePhone=<%=sInPhoneNo%>";
		</script>
		<%	}	%>
		
<jsp:include page="<%=url%>" flush="true" />