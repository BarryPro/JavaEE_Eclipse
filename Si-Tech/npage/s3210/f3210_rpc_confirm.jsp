 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-14 ҳ�����,�޸���ʽ
	********************/
%> 

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%
	String regionCode = (String)session.getAttribute("regCode");  
	//String[] retStr = null;
	int error_code = 0;
	String error_msg="ϵͳ��������ϵͳ����Ա��ϵ";
	int valid = 1;  //0:��ȷ��1��ϵͳ����2��ҵ�����
	String iErrorNo ="";
    	String sErrorMessage = " ";

	//String[] callData = null;
	Logger logger = Logger.getLogger("f3210_rpc_confirm.jsp");
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();

	String verifyType = request.getParameter("verifyType");
	String opType = request.getParameter("opType");
	String op_code = request.getParameter("opCode");
	String org_code  = request.getParameter("orgCode");	 /* ��������		   */
	String iRegion_Code = org_code.substring(0,2);
	String sSaveName="";
	String[] ParamsIn = null;
	String server_ip_Addr=request.getServerName();//�õ�������ַ
	String srvIP=request.getServerName();
	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+opType);
	if (opType.equals("file")){
	//���ļ�¼��Ĳ���
	String filename = "sim"+new SimpleDateFormat("yyyyMMddHHmmss",Locale.getDefault()).format(new Date());
	sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename;
	SmartUpload mySmartUpload = new SmartUpload();
	try
    {
        mySmartUpload.initialize(pageContext);
        mySmartUpload.upload();
		System.out.println("�ϴ����!!");
    }
    catch(Exception ex) 
    {
		System.out.println("�쳣�׳�!!");
		ex.printStackTrace();
        iErrorNo = "321099";
        sErrorMessage = "�����ļ������г���";
%>
            <script language='jscript'>
                 rdShowMessageDialog('�����ļ������г���',0);
                 location = "f3210.jsp";
            </script>
<%
	}
	try 
    {
        com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
        if (!myFile.isMissing())
		{
			System.out.println("��ʼ�洢�ļ�����");
           myFile.saveAs(sSaveName);
        }
    }
	catch(Exception ex)
	{
        iErrorNo = "321098";
        sErrorMessage = "�����ļ��洢ʱ����";
%>
        <script language='jscript'>
           rdShowMessageDialog('�����ļ��洢ʱ����',0);
           location = "f3210.jsp";
        </script>
<%
	}
	//���ļ�¼���������
	}

		ParamsIn = new String[32];
		ParamsIn[0]  = request.getParameter("loginNo");	 /* ��������		   */
		ParamsIn[1]  = request.getParameter("orgCode");	 /* ��������		   */
		ParamsIn[2]  = request.getParameter("opCode");	  /* ��������		   */
		ParamsIn[3]  = request.getParameter("op_note");	 /* ������ע		   */
		ParamsIn[4]  = request.getParameter("GRPID");	   /* ���ź�			 */
		ParamsIn[5]  = request.getParameter("deparment");   /* �û�����		   */
		ParamsIn[6]  = request.getParameter("CLOSENO1");	/* �պ�Ⱥ��1		  */
		ParamsIn[7]  = request.getParameter("CLOSENO2");	/* �պ�Ⱥ��2		  */
		ParamsIn[8]  = request.getParameter("CLOSENO3");	/* �պ�Ⱥ��3		  */
		ParamsIn[9]  = request.getParameter("CLOSENO4");	/* �պ�Ⱥ��4		  */
		ParamsIn[10] = request.getParameter("CLOSENO5");	/* �պ�Ⱥ��5		  */
		ParamsIn[11] = request.getParameter("USERPIN1");	/* �û�����		   */
		ParamsIn[12] = request.getParameter("LOCKFLAG");	/* �û�������־	   */
		ParamsIn[13] = request.getParameter("FLAGS");	   /* �û�����Ȩ�޼�	 */
		ParamsIn[14] = request.getParameter("STATUS");	  /* ״̬������		 */
		ParamsIn[15] = request.getParameter("USERTYPE");	/* �û�����		   */
		ParamsIn[16] = request.getParameter("OUTGRP");	  /* ������������	 */
		ParamsIn[17] = request.getParameter("MAXOUTNUM");   /* ������������	 */
		ParamsIn[18] = request.getParameter("FEEFLAG");	 /* �����޶��־ѡ��   */
		ParamsIn[19] = request.getParameter("LMTFEE");	  /* �·����޶�		 */
		ParamsIn[20] = request.getParameter("CURPKGTYPE");  /* ���·��ʷ��ײ����� */
		ParamsIn[21] = "0";								  /* �����û�Ʒ��	   */
		ParamsIn[22] = request.getParameter("PKGTYPE");	 /* ���·��ʷ��ײ����� */
		ParamsIn[23] = "0";								  /* �����û�Ʒ��	   */
		ParamsIn[24] = request.getParameter("PKGDAY");		/* �ʷ��ײ���Ч����   */
		ParamsIn[25] = request.getParameter("tmpR1");		/* �̺��봮		   */
		ParamsIn[26] = request.getParameter("tmpR2");		/* ��ʵ���봮		 */
		ParamsIn[27] = request.getParameter("id_card");		/* ֤�����봮		 */
		ParamsIn[28] = request.getParameter("user_name");   /* �û�������		 */
		ParamsIn[29] = request.getParameter("p_comment");   /* ������Ϣ��		 */
		ParamsIn[30] = sSaveName;							/* �ļ���   */
		ParamsIn[31] = server_ip_Addr;						/* ����IP   */
//	else
//	{
//		ParamsIn = new String[25];
//		ParamsIn[0]  = request.getParameter("loginNo");	 /* ��������		   */
//		ParamsIn[1]  = request.getParameter("orgCode");	 /* ��������		   */
//		ParamsIn[2]  = request.getParameter("opCode");	  /* ��������		   */
//		ParamsIn[3]  = request.getParameter("op_note");	 /* ������ע		   */
//		ParamsIn[4]  = request.getParameter("GRPID");	   /* ���ź�			 */
//		ParamsIn[5]  = request.getParameter("deparment");   /* �û�����		   */
//		ParamsIn[6]  = request.getParameter("CLOSENO1");	/* �պ�Ⱥ��1		  */
//		ParamsIn[7]  = request.getParameter("CLOSENO2");	/* �պ�Ⱥ��2		  */
//		ParamsIn[8]  = request.getParameter("CLOSENO3");	/* �պ�Ⱥ��3		  */
//		ParamsIn[9]  = request.getParameter("CLOSENO4");	/* �պ�Ⱥ��4		  */
//		ParamsIn[10] = request.getParameter("CLOSENO5");	/* �պ�Ⱥ��5		  */
//		ParamsIn[11] = request.getParameter("USERPIN1");	/* �û�����		   */
//		ParamsIn[12] = request.getParameter("LOCKFLAG");	/* �û�������־	   */
//		ParamsIn[13] = request.getParameter("FLAGS");	   /* �û�����Ȩ�޼�	 */
//		ParamsIn[14] = request.getParameter("STATUS");	  /* ״̬������		 */
//		ParamsIn[15] = request.getParameter("USERTYPE");	/* �û�����		   */
//		ParamsIn[16] = request.getParameter("OUTGRP");	  /* ������������	 */
//		ParamsIn[17] = request.getParameter("MAXOUTNUM");   /* ������������	 */
//		ParamsIn[18] = request.getParameter("FEEFLAG");	 /* �����޶��־ѡ��   */
//		ParamsIn[19] = request.getParameter("LMTFEE");	  /* �·����޶�		 */
//		ParamsIn[20] = request.getParameter("PKGTYPE");	 /* ���·��ʷ��ײ����� */
//		ParamsIn[21] = "0";								  /* �����û�Ʒ��	   */
//		ParamsIn[22] = request.getParameter("PKGDAY");	  /* �ʷ��ײ���Ч����   */
//		ParamsIn[23] = request.getParameter("tmpR1");	   /* ��������		   */
//		ParamsIn[24] = request.getParameter("tmpR2");	   /* ���봮����		 */
//	} 

	//if( opType.equals("a") )
//	{
		//callData = callView.callService("s3210Cfm", ParamsIn, "2", "region", iRegion_Code);
//	}
	/*else
	{
		callData = callView.callService("s3214Cfm", ParamsIn, "2", "region", iRegion_Code);
	}
	*/
	
	%>
	<wtc:service name="s3210Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:params value="<%=ParamsIn%>" />
	</wtc:service>
	<wtc:array id="callData" scope="end" />		   
	
	<%
	/*	
	error_code = callView.getErrCode();
	error_msg= callView.getErrMsg(); */
	error_code = retCode1;
	error_msg= retMsg1;
%>

var response = new AJAXPacket();
response.data.add("verifyType","<%= verifyType %>");
response.data.add("errorCode","<%= error_code %>");
response.data.add("errorMsg","<%= error_msg %>");
<%
	if (callData != null)
	{
%>
		response.data.add("backArrMsg","<%= callData[0][0]%>" );
		response.data.add("backArrMsg1","<%= callData[0][1] %>" );
<%
	}
%>
core.ajax.receivePacket(response);


