<% 
  /*
   * ����: ������ȡ��ȷ��
�� * �汾: v1.00
�� * ����: 2008/03/25
�� * ����: sunzx
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸����� 2008-1-4     �޸��� leimd     �޸�Ŀ��
   *  
  */
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../include/remark.htm" %>

<%
	String opCode="7963";
	String opName="������ȡ��";
//    SPubCallSvrImpl callView = new SPubCallSvrImpl();
//    String[] retStr = null;
    String sInLoginNo         = (String)session.getAttribute("workNo");          	//��������
    String sInLoginPasswd     = (String)request.getParameter("loginPwd");          //��������
    String sInOpCode          = request.getParameter("opCode");           			//���ܴ���
    String sInOpNote          = request.getParameter("opNote");           			//�û���ע
    String sInOrgCode         = (String)session.getAttribute("orgCode");           	//�������Ź���
    String sInSystemNote      = request.getParameter("sysNote");          			//ϵͳ��ע
    String sInIpAddr          = (String)session.getAttribute("ipAddr");          	//����IP��ַ
    String sInLoginAccept     = request.getParameter("loginAccept");      			//��ˮ
    String sInPhoneNo         = request.getParameter("phone_no");         			//�û��ֻ���
    String sInCreateType      = "9";	                                  			//ҵ����������:09:BOSS
    String regionCode         = (String)session.getAttribute("regCode"); 
		  
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
    paramsIn.add(new String[]{sInCreateType     });
    paramsIn.add(new String[]{sInCreateType     });

//	retStr = callView.callService("s7963Cfm", paramsIn, "3", "region", regionCode);
//	callView.printRetValue();
%>
	<wtc:service name="s7963Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=sInLoginNo%>"/>
		<wtc:param value="<%=sInLoginPasswd%>"/>
		<wtc:param value="<%=sInOpCode%>"/>
		<wtc:param value="<%=sInOpNote%>"/>
		<wtc:param value="<%=sInOrgCode%>"/>
		<wtc:param value="<%=sInSystemNote%>"/>
		<wtc:param value="<%=sInIpAddr%>"/>
		<wtc:param value="<%=sInLoginAccept%>"/>
		<wtc:param value="<%=sInPhoneNo%>"/>
		<wtc:param value="<%=sInCreateType%>"/>
		<wtc:param value="<%=sInCreateType%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
    String error_code = retCode;
    String error_msg = retMsg;
    String url ="/npage/contact/upCnttInfo.jsp?opCode="+sInOpCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+sInLoginNo+"&loginAccept="+sInLoginAccept+"&pageActivePhone="+sInPhoneNo+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
    
	if(!(error_code.equals("000000")||error_code.equals("0"))){
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=error_msg%>",0);
			location = "f7963_1.jsp?activePhone=<%=sInPhoneNo%>";
		</script>
<%	}
	else
	{
%>
		<script language="JavaScript">
			rdShowMessageDialog("������ҵ��ȡ���ɹ�",2);
			location = "f7963_1.jsp?activePhone=<%=sInPhoneNo%>";
		</script>
<%
	}
%>
<jsp:include page="<%=url%>" flush="true" />