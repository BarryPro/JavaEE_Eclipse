<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% 
  /*
   * ����: ���˲����������
�� * �汾: v1.00
�� * ����: 2007/09/13
�� * ����: liubo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸����� 200-01-08     �޸��� leimd     �޸�Ŀ��
   *  
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode="6713";
	String opName="���˲�������/�������";
	String phoneNo = (String)request.getParameter("phone_no");
//    SPubCallSvrImpl callView = new SPubCallSvrImpl();
    
    //System.out.println("matureProdCode="+request.getParameter("CRProdCode2")+"=matureProdCode");
    String matureProdCode     = request.getParameter("CRProdCode2"); 
    //System.out.println("matureProdCode="+matureProdCode);
    
//    String[] retStr = null;
    String sInLoginNo         = request.getParameter("loginNo");					//��������        			 
    String sInLoginPasswd     = request.getParameter("loginPwd");         //��������             
    String sInOpCode          = request.getParameter("opCode");           //���ܴ���          
    String sInOpNote          = request.getParameter("opNote");           //�û���ע         
    String sInOrgCode         = request.getParameter("orgCode");          //�������Ź���       
    String sInSystemNote      = request.getParameter("sysNote");          //ϵͳ��ע           
    String sInIpAddr          = request.getParameter("ip_Addr");          //����IP��ַ              
    String sInLoginAccept     = request.getParameter("loginAccept");       //��ˮ
    String sInOldLoginAccept  = request.getParameter("loginAcceptOld");    //ԭ������ˮ    
    String sInCreateType      = "9";	                                    //ҵ����������:00:BOSS
    String sInShowFlag        = "001";    //��������:001:ֻȡ��������
    
    String regionCode         = sInOrgCode.substring(0,2);   
							                                                      
	ArrayList paramsIn = new ArrayList();
    paramsIn.add(new String[]{sInLoginNo        });
    paramsIn.add(new String[]{sInLoginPasswd    });
    paramsIn.add(new String[]{sInOpCode         });
    paramsIn.add(new String[]{sInOpNote         });
    paramsIn.add(new String[]{sInOrgCode        });
    paramsIn.add(new String[]{sInSystemNote     });
    paramsIn.add(new String[]{sInIpAddr         });
    paramsIn.add(new String[]{sInLoginAccept    });
    paramsIn.add(new String[]{sInOldLoginAccept });
    paramsIn.add(new String[]{sInCreateType     });
    paramsIn.add(new String[]{sInShowFlag       });

//			retStr = callView.callService("s6713Cfm", paramsIn, "3", "region", regionCode);
//			callView.printRetValue();
%>
	<wtc:service name="s6713Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=sInLoginNo%>"/>
		<wtc:param value="<%=sInLoginPasswd%>"/>
		<wtc:param value="<%=sInOpCode%>"/>
		<wtc:param value="<%=sInOpNote%>"/>
		<wtc:param value="<%=sInOrgCode%>"/>
		<wtc:param value="<%=sInSystemNote%>"/>
		<wtc:param value="<%=sInIpAddr%>"/>
		<wtc:param value="<%=sInLoginAccept%>"/>
		<wtc:param value="<%=sInOldLoginAccept%>"/>
		<wtc:param value="<%=sInCreateType%>"/>
		<wtc:param value="<%=sInCreateType%>"/>
		<wtc:param value="<%=sInShowFlag%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String error_code = retCode;
    String  error_msg  = retMsg;
			if(!error_code.equals("000000")){
			%>
			<script language="JavaScript">
				rdShowMessageDialog("<%=error_msg%>",0);
				history.go(-1);
			</script>
			<%}else{%>
			  <script language="JavaScript">
				rdShowMessageDialog('���˲���<%if(matureProdCode.equals("")){%>����<%}else{%>���<%}%>�����ɹ�',2);
				location = "f6713_1.jsp?activePhone=<%=phoneNo%>";
			</script>
			<%}	

	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+sInLoginNo+"&loginAccept="+sInLoginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
	<jsp:include page="<%=url%>" flush="true" />
