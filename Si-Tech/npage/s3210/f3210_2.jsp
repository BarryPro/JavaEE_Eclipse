 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-14 ҳ�����,�޸���ʽ
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.text.*"%>
<%@ include file="../../npage/common/serverip.jsp" %>
<%
	String loginAccept=request.getParameter("loginAccept"); 
	
	/*ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
    	String[][] baseInfoSession = (String[][])arrSession.get(0);
        String[][] otherInfoSession = (String[][])arrSession.get(2);
        String[][] pass = (String[][])arrSession.get(4);

        String loginNo = baseInfoSession[0][2];
        String loginName = baseInfoSession[0][3];
        String powerCode= otherInfoSession[0][4];  
        String orgCode = baseInfoSession[0][16];
        */        
        String loginNo=(String)session.getAttribute("loginNo");    //���� 
        String loginName =(String)session.getAttribute("workName");//�������� 
      	String orgCode = (String)session.getAttribute("orgCode");  
        String ip_Addr = request.getRemoteAddr();
        String regionCode = (String)session.getAttribute("regCode");  
        String userPhone = (String)request.getParameter("ISDNNO");
        
	String[] retStr = null;
	String error_code = "";
	String error_msg="ϵͳ��������ϵͳ����Ա��ϵ";
	int valid = 1;  //0:��ȷ��1��ϵͳ����2��ҵ�����
	String iErrorNo ="";
        String sErrorMessage = " ";
	//
	String grpName=request.getParameter("grpName");	 /* �������� baixf add 20070606   */
	//
	//ArrayList callData = null;
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	
	String opType = request.getParameter("opType");
	String op_code ="3210";
        String org_code  = request.getParameter("orgCode");	 /* ��������		   */
	String iRegion_Code = org_code.substring(0,2);
	String sSaveName="";
	String[] ParamsIn = null;
	//String server_ip_Addr=request.getServerName();//�õ�������ַ
	String server_ip_Addr=realip;//0.100��������ip�����淽���õ�����0.100����ʵip
      //System.out.println("luxc:server_ip_Addr="+server_ip_Addr);
	String srvIP=request.getServerName();
	StringTokenizer strToken1=null;
	StringTokenizer strToken2=null;
	//String  temp11="";  //����xls�ļ������ڱ�������ֻ���     baixf 20070606
	//String  temp22="";  //����xls�ļ������ڱ��������Ϣ       baixf 20070606    
	SmartUpload mySmartUpload = new SmartUpload();
	if (opType.equals("file")){
	//���ļ�¼��Ĳ���
	String filename = "vpmn"+new SimpleDateFormat("yyyyMMddHHmmss",Locale.getDefault()).format(new Date());
	sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename;
	}
	else
	sSaveName="";
	try {
        mySmartUpload.initialize(pageContext);
        mySmartUpload.upload();
		System.out.println("�ϴ����!!");
    }
    catch(Exception ex)   {
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
	
		try {
        
			com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
        
			if (!myFile.isMissing())
			{
           
				myFile.saveAs(sSaveName);
        
			}
    
		}
	
		catch(Exception ex)	{
        
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
		
		ParamsIn = new String[35];		   
		ParamsIn[0]  = mySmartUpload.getRequest().getParameter("loginNo");
		//ParamsIn[0]  = request.getParameter("loginNo");	 /* ��������		   */
		ParamsIn[1]  = mySmartUpload.getRequest().getParameter("orgCode");	 /* ��������		   */
		ParamsIn[2]  = mySmartUpload.getRequest().getParameter("opCode");	  /* ��������		   */
		ParamsIn[3]  = mySmartUpload.getRequest().getParameter("opNote");	 /* ������ע		   */
		ParamsIn[4]  = mySmartUpload.getRequest().getParameter("GRPID");	   /* ���ź�			 */
		ParamsIn[5]  = mySmartUpload.getRequest().getParameter("DEPT");   /* �û�����		   */
		ParamsIn[6]  = mySmartUpload.getRequest().getParameter("CLOSENO1");	/* �պ�Ⱥ��1		  */
		ParamsIn[7]  = mySmartUpload.getRequest().getParameter("CLOSENO2");	/* �պ�Ⱥ��2		  */
		ParamsIn[8]  = mySmartUpload.getRequest().getParameter("CLOSENO3");	/* �պ�Ⱥ��3		  */
		ParamsIn[9]  = mySmartUpload.getRequest().getParameter("CLOSENO4");	/* �պ�Ⱥ��4		  */
		ParamsIn[10] = mySmartUpload.getRequest().getParameter("CLOSENO5");	/* �պ�Ⱥ��5		  */
		ParamsIn[11] = mySmartUpload.getRequest().getParameter("USERPIN1");	/* �û�����		   */
		ParamsIn[12] = mySmartUpload.getRequest().getParameter("LOCKFLAG");		/* �û�������־	   */
		ParamsIn[13] = mySmartUpload.getRequest().getParameter("FLAGS");		/* �û�����Ȩ�޼�	 */
		ParamsIn[14] = mySmartUpload.getRequest().getParameter("STATUS");		/* ״̬������		 */
		ParamsIn[15] = mySmartUpload.getRequest().getParameter("USERTYPE");		/* �û�����		   */
		ParamsIn[16] = mySmartUpload.getRequest().getParameter("OUTGRP");		/* ������������	 */
		ParamsIn[17] = mySmartUpload.getRequest().getParameter("MAXOUTNUM");	/* ������������	 */
		ParamsIn[18] = mySmartUpload.getRequest().getParameter("FEEFLAG");		/* �����޶��־ѡ��   */
		ParamsIn[19] = mySmartUpload.getRequest().getParameter("LMTFEE");		/* �·����޶�		 */
		ParamsIn[20] = mySmartUpload.getRequest().getParameter("CURPKGTYPE");	/* ���·��ʷ��ײ����� */
		ParamsIn[21] = "0";														/* �����û�Ʒ��	   */
		ParamsIn[22] = mySmartUpload.getRequest().getParameter("PKGTYPE");		/* ���·��ʷ��ײ����� */
		ParamsIn[23] = "0";														/* �����û�Ʒ��	   */
		ParamsIn[24] = mySmartUpload.getRequest().getParameter("PKGDAY");		/* �ʷ��ײ���Ч����   */
		ParamsIn[25] = mySmartUpload.getRequest().getParameter("tmpR1");		/* �̺��봮		   */
		ParamsIn[26] = mySmartUpload.getRequest().getParameter("tmpR2");		/* ��ʵ���봮		 */
		ParamsIn[27] = mySmartUpload.getRequest().getParameter("tmpR3");		/* ֤�����봮		 */
		ParamsIn[28] = mySmartUpload.getRequest().getParameter("tmpR4");   /* �û�������		 */
		ParamsIn[29] = mySmartUpload.getRequest().getParameter("tmpR5");   /* ������Ϣ��		 */
		ParamsIn[30] = sSaveName;							/* �ļ���   */
		ParamsIn[31] = server_ip_Addr;						/* ����IP   */
		ParamsIn[32] = mySmartUpload.getRequest().getParameter("unit_id").substring(0,10); 
    ParamsIn[33] = mySmartUpload.getRequest().getParameter("ZHWW"); 
    ParamsIn[34] = mySmartUpload.getRequest().getParameter("phone_type"); 
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
	//	callData = callView.callFXService("s3210Cfm", ParamsIn, "3", "region", iRegion_Code);
//	}
	/*else
	{
		callData = callView.callService("s3214Cfm", ParamsIn, "2", "region", iRegion_Code);
	}
	*/
	
	%>
	<wtc:service name="s3210Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="3">
			<wtc:params value="<%=ParamsIn%>"/>
	</wtc:service>
	<wtc:array id="callData" scope="end" />		
	
	<%
	/*error_code = callView.getErrCode();
	error_msg= callView.getErrMsg();
	*/
	error_code=retCode1;
	error_msg= retMsg1;
	/*String[][] temp1 =(String[][])callData.get(1);
	String[][] temp2 =(String[][])callData.get(2);
	System.out.println("@@@@@@@@@@@@@@@@temp1"+temp1[0][0]);
	System.out.println("@@@@@@@@@@@@@@@@temp2"+temp2[0][0]);	*/
	System.out.println("================="+callData[0][1]);
	System.out.println("================="+callData[0][2]);
	strToken1=new StringTokenizer(callData[0][1],"|");
	strToken2=new StringTokenizer(callData[0][2],"|"); 
	 //temp11= temp1[0][0] ;
	 //temp22= temp2[0][0]  ;
	if(!error_code.equals("000000")){
		   %>
	 <SCRIPT type=text/javascript>
		
		 var path="<%=request.getContextPath()%>/npage/s3210/f3210_2_printxls.jsp?phoneNo=" + "<%=callData[0][1]%>";

	   		if (rdShowConfirmDialog("<br>�������:"+"<%=error_code%></br>"+"������Ϣ:"+"<%=error_msg%>"+"<br>�Ƿ񱣴������Ϣ��")==1)	
			{
				path = path + "&returnMsg=" + "<%=callData[0][2]%>"+ "&unitID=" + "<%=ParamsIn[4]%>";
	  			path = path + "&loginAccept=" + "<%=error_code%>"  ;
	  			path = path + "&op_Code=" + "<%=op_code%>"+"&grpName="+"<%=grpName%>";
	  			path = path + "&orgCode=" + "<%=org_code%>";
          			window.open(path);
			}	
		
	      history.go(-1);
		
	 </SCRIPT>
		<%
	}
		%>
<html>
<head>
<title>�û���Ϣ</title>
</head>
<SCRIPT type=text/javascript>
function previouStep(){
	frm.action="f3210.jsp";
	frm.method="post";
	frm.submit();
}


 function print_xls()
 {
   var path="<%=request.getContextPath()%>/npage/s3210/f3210_2_printxls.jsp?phoneNo=" + "<%=callData[0][1]%>";
   path = path + "&returnMsg=" + "<%=callData[0][2]%>"+ "&unitID=" + "<%=ParamsIn[4]%>";
   path = path + "&loginAccept=" + "<%=error_code%>"  ;
   path = path + "&op_Code=" + "<%=op_code%>"+"&grpName="+"<%=grpName%>";
   path = path + "&orgCode=" + "<%=org_code%>"; 
   window.open(path);         	 	
  
 }
				


</SCRIPT>
<body>
<%
	String opCode = "3210";	
	String opName = "δ�ɹ������б�";	//header.jsp��Ҫ�Ĳ���   
%>
<form name="frm" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">δ�ɹ������б�</div>
	</div>	
        <table cellspacing="0" >
                <TR> 			
                  <TD class="blue">δ��ӳɹ�����(����б�Ϊ�գ���ȫ��������ӳɹ���)</TD>
                  <TD class="blue">ʧ��ԭ��</TD>
                </TR>		
<%			
	while (strToken1.hasMoreTokens()) {
%>
				<TR>
				<td> <%= strToken1.nextToken()%> </td>
				<td> <%= strToken2.nextToken()%> </td>
				</TR>
<%
			}
%>	
        </table>    
	<table cellspacing="0">
		<tr> 
			<td id="footer"> 
				<input class="b_foot" name="previous"  type=button value="����" onclick="previouStep()">&nbsp;
				<input class="b_foot_long" name="prtxls"  type=button value="����XLS�ļ�" onclick="print_xls()" style="cursor:hand">&nbsp; &nbsp;
				<input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="�ر�">			    		
			</td>
		</tr>
  	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>



<%
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1
	+"&retMsgForCntt="+retMsg1+"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+loginAccept
	+"&pageActivePhone="+userPhone+"&opBeginTime="+opBeginTime+"&contactId="+ParamsIn[4]
	+"&contactType=grp";
%>
<jsp:include page="<%=url%>" flush="true" />
