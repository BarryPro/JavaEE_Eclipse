<%
/********************
version v2.0
������: si-tech
update:anln@2009-02-24 ҳ�����,�޸���ʽ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../include/remark1.htm" %>
<%
	String opCode = (String)request.getParameter("opCode");	
	String opName = (String)request.getParameter("opName");	

	String error_code = "0";
	String error_msg = "";
		
	String workNo   = (String)session.getAttribute("workNo");
	String workName =(String)session.getAttribute("workName");

    

	String sInLoginNo         = request.getParameter("loginNo");          //��������
	String sInLoginPasswd     = request.getParameter("loginPwd");         //��������
	String sInOpCode          = request.getParameter("opCode");           //���ܴ���
	String sInOpNote          = request.getParameter("opNote");           //�û���ע
	String sInOrgCode         = request.getParameter("orgCode");          //�������Ź���
	String sInSystemNote      = request.getParameter("sysNote");          //ϵͳ��ע
	String sInIpAddr          = request.getParameter("ip_Addr");          //����IP��ַ
	String sInLoginAccept     = request.getParameter("loginAccept");      //��ˮ
	String sInPhoneNo         = request.getParameter("phone_no");         //�û��ֻ���
	String sInOldLoginAccept  = request.getParameter("loginAcceptOld");   //��������ˮ
	String sInCreateType      = "9";	  //ҵ����������:09:BOSS
	String sInShowFlag        = "000";    //��������:000:ֻȡ��������
	String regionCode         = (String)session.getAttribute("regCode");
		  
	/*ArrayList paramsIn = new ArrayList();
	
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
	paramsIn.add(new String[]{sInPhoneNo        });
	paramsIn.add(new String[]{sInShowFlag       });*/

	//retStr = callView.callService("s7962Cfm", paramsIn, "3", "region", regionCode);
%>	
	<wtc:service name="s7962Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4" >
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
		<wtc:param value="<%=sInPhoneNo%>"/>
		<wtc:param value="<%=sInShowFlag%>"/>		
	</wtc:service>
	
<%
	error_code = retCode1;
	error_msg  = retMsg1;
	if(!error_code.equals("000000")){
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=error_msg%>",0);
			history.go(-2);
		</script>
<%	}
	else
	{
%>
		<script language="JavaScript">
			rdShowMessageDialog("������ҵ������ɹ�",2);
			history.go(-2);
		</script>
<%
	}
%>

<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+sInLoginNo+"&loginAccept="+sInLoginAccept+"&pageActivePhone="+sInPhoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />