<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%		
    int error_code = 0;
    String error_msg = "";

	String opCode = "7413";
	String opName = "����100ҵ����˶�";
    String iLoginAccept    = request.getParameter("login_accept");     //������ˮ��
    String iOpCode         = request.getParameter("op_code");          //��������
    String iWorkNo         = request.getParameter("WorkNo");           //����Ա����
    String iLogin_Pass     = request.getParameter("NoPass");           //����Ա����
    String iOrgCode        = request.getParameter("OrgCode");          //����Ա��������
    String iSys_Note       = request.getParameter("sysnote");          //ϵͳ������ע
    String iOp_Note        = request.getParameter("tonote");           //�û�������ע
    String iIpAddr         = request.getParameter("ip_Addr");          //����ԱIP��ַ
    String iGrp_Id         = request.getParameter("grp_id");           //�����û�ID
    String delMemFlag      = "0";           						   //��Ҫɾ����Ա��־(0:��ɾ���� 1��ɾ��)
    String iRegion_Code = iOrgCode.substring(0,2);
    
    String resLoginAccept = "";
%>
<wtc:service name="s7413Cfm" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iWorkNo%>"/>
	<wtc:param value="<%=iLogin_Pass%>"/>
	<wtc:param value="<%=iOrgCode%>"/>
	
	<wtc:param value="<%=iSys_Note%>"/>
	<wtc:param value="<%=iOp_Note%>"/>
	<wtc:param value="<%=iIpAddr%>"/>
	<wtc:param value="<%=iGrp_Id%>"/>
	<wtc:param value="<%=delMemFlag%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>	
<%
	error_code = retCode1==""?999999:Integer.parseInt(retCode1);
	error_msg  = retMsg1;
	resLoginAccept = result.length>0?result[0][0]:"";
	
	if(error_code == 0){
%>
	<script language='jscript'>
        rdShowMessageDialog("����100ҵ����˶��ɹ���",2);
        location = "f7413.jsp";
    </script>
<%
	}
	else 
	{
%>
    <script language='jscript'>
        rdShowMessageDialog("������룺" + "<%=error_code%>" + "��������Ϣ��" + "<%=error_msg%>",0);
        history.go(-1);
    </script>
<%
    }
%>
    
<%
	 System.out.println("%%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
	 String cnttOpCode = opCode;
	 String cttOpName = opName;
	 String cnttWorkNo = iWorkNo;
	 String retCodeForCntt = String.valueOf(error_code);
	 String cnttLoginAccept = resLoginAccept;
	 String cnttContactId = iGrp_Id;
	 String cnttUserType = "grp";
	 
	 String url = "/npage/contact/upCnttInfo.jsp?opCode="+cnttOpCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+cttOpName+"&workNo="+cnttWorkNo+"&loginAccept="+cnttLoginAccept+"&contactId="+cnttContactId+"&contactType="+cnttUserType;
	 System.out.println("--------------url----:"+url);
	 System.out.println("--------------iLoginAccept----:"+iLoginAccept);
%>
		
	<jsp:include page="<%=url%>" flush="true" />

<%
	 System.out.println("%%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");
%>
