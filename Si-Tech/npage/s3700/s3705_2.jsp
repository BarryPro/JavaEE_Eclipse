 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-10 ҳ�����,�޸���ʽ
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.text.*"%>
<%@ include file="/npage/common/serverip.jsp" %>
<%
       	String opCode = "4112";	
	String opName = "�������Ѽƻ����";	//header.jsp��Ҫ�Ĳ���    
	      
       	String op_code ="4112";       	
        String orgCode = (String)session.getAttribute("orgCode");       
	String ip_Addr = request.getRemoteAddr();
	String error_code = "0";
	String error_msg="ȷ�ϳɹ���";
	
	int valid = 1;  //0:��ȷ��1��ϵͳ����2��ҵ�����
	String iErrorNo ="";
    	String sErrorMessage = " ";
    	String unit_id =request.getParameter("unit_id");    
    	System.out.println("==================unit_id"+unit_id);

	//ArrayList callData = null;
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	String opType = request.getParameter("opMode");    
	String iRegion_Code = orgCode.substring(0,2);	
	
	String sSaveName="";	
	ArrayList  ParamsIn=new ArrayList();
	
	String server_ip_Addr=realip;//0.100��������ip�����淽���õ�����0.100����ʵip
	String srvIP=request.getServerName();
	
	StringTokenizer strToken1=null;
	StringTokenizer strToken2=null;
	SmartUpload mySmartUpload = new SmartUpload();
	String filename="";
	String workNo="";
	String unit_name="";
	String userPhone="";
	String login_accept = request.getParameter("login_accept");  
	String unit_name2 = request.getParameter( "unit_name2" );
	String v_effectRule = request.getParameter( "v_effectRule" );//��Ч����
	
	System.out.println("zhangyan unit_name2==="+unit_name2);
	if (opType.equals("file")){
		//���ļ�¼��Ĳ���
    		filename = "TYFF"+new SimpleDateFormat("yyyyMMddHHmmss",Locale.getDefault()).format(new Date());
		sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename;
	}
	else
	sSaveName="";
	try {
	        mySmartUpload.initialize(pageContext);
	        mySmartUpload.upload();
		System.out.println("�ϴ����!!");
    	} catch(Exception ex)   {
		System.out.println("�쳣�׳�!!");
		ex.printStackTrace();
        	iErrorNo = "321099";
        	sErrorMessage = "�����ļ������г���";	
%>            
	<script language='jscript'>                 
		rdShowMessageDialog('�����ļ������г���',0);                 
		location = "s3705.jsp";
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
				location = "s3705.jsp";        
			</script>
	<%	
	}
		//���ļ�¼���������	
		//ParamsIn = new String[24];		   
		String temFeeCode=WtcUtil.repNull(mySmartUpload.getRequest().getParameter("temFeeCode"));
		String temDetailCode=WtcUtil.repNull(mySmartUpload.getRequest().getParameter("temDetailCode"));
		String temRateCode=WtcUtil.repNull(mySmartUpload.getRequest().getParameter("temRateCode"));		 
		String temPayOrder=WtcUtil.repNull(mySmartUpload.getRequest().getParameter("temPayOrder"));	
		System.out.println("temFeeCode="+temFeeCode);
		System.out.println("temDetailCode="+temDetailCode);
		System.out.println("temRateCode="+temRateCode);
		System.out.println("temPayOrder="+temPayOrder);
			/****�ֽ��ַ���****/
		StringTokenizer token1=new StringTokenizer(temFeeCode,"#");
		StringTokenizer token2=new StringTokenizer(temDetailCode,"#");
		StringTokenizer token3=new StringTokenizer(temRateCode,"#");
		StringTokenizer token4=new StringTokenizer(temPayOrder,"#");
		String feeCode []=new String [token1.countTokens()];
		System.out.println("%%%%%%%%%%%token1.countTokens()="+token1.countTokens());
		/* add by wanglm 20110407  �׸ڼ����������Ѽƻ����ɾ����Աʧ����� 
		   ԭ���� ��token1.countTokens()Ϊ0ʱ������û�г�ʼ��
		*/
		if(token1.countTokens() == 0){
		  feeCode=new String[1];
	      feeCode[0]="   ";
		}
		String detai1Code []=new String [token2.countTokens()];
		System.out.println("--------------detai1Code-------------  "+token2.countTokens());
		if(token2.countTokens() == 0){
		  detai1Code=new String[1];
	      detai1Code[0]="   ";
		}
		String feeRate []=new String [token3.countTokens()];
		if(token3.countTokens() == 0){
		  feeRate=new String[1];
	      feeRate[0]="   ";
		}
		/* add by wanglm 20110407  �׸ڼ����������Ѽƻ����ɾ����Աʧ�����*/
		String payOrder []=new String [token4.countTokens()];
		int i=0;
		while(token1.hasMoreElements()){
			feeCode[i]=(String)token1.nextElement();
			detai1Code[i]=(String)token2.nextElement();
			feeRate[i]=(String)token3.nextElement();
			payOrder[i]=(String)token4.nextElement();
			System.out.println("%%%%%%%%%%%"+feeCode[i]);
			System.out.println("%%%%%%%%%%%"+detai1Code[i]);
			System.out.println("%%%%%%%%%%%"+feeRate[i]);
			i++;
		}
		//wuxy add 20090531 Ϊ�������ϸʱ�����񱨴� payOrderΪ������
		if(i==0)
	  {
	  	payOrder=new String[1];
	  	payOrder[0]="0";
	  }
		
		System.out.println("--------------payOrder="+payOrder);
		ParamsIn.add("0");	
		String kong=new String(" ");	
		//String kong = "";
		String 	opCode1=mySmartUpload.getRequest().getParameter("opCode");
		String 	workNo1=mySmartUpload.getRequest().getParameter("workNo");
		workNo=workNo1;
		String 	NoPass1=mySmartUpload.getRequest().getParameter("NoPass");
		
		String 	opType1=mySmartUpload.getRequest().getParameter("opType");
		String unit_name1=mySmartUpload.getRequest().getParameter("unit_name");
		unit_name=unit_name;
		String 	accountMsg1=mySmartUpload.getRequest().getParameter("accountMsg");
										
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("opCode")});	  /* ���ܴ���		   */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("workNo")});/* ��������		   */	
		ParamsIn.add( new String[]{ mySmartUpload.getRequest().getParameter("NoPass")});	 /* �������ܵĹ�������		   */
		ParamsIn.add( new String[]{orgCode});	 /* �������Ź���		   */

		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("opType")});	   /* ��������			 */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("unit_name")});   /* �����û�ID		   */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("accountMsg")});	/* �����ʻ�		  */
		ParamsIn.add( new String[]{" "});	/* ǰһ���ʵ����		  */
		ParamsIn.add( payOrder);	                                                /* ����˳��		  */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("limitNum")});	/* �޶�		  */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("detailFlag")});	/* ��ϸ��־		  */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("stopFlag")});	/* ͣ����־		   */
		
		String limitNum1=mySmartUpload.getRequest().getParameter("limitNum");
		String detailFlag1=mySmartUpload.getRequest().getParameter("detailFlag");
		String stopFlag1=mySmartUpload.getRequest().getParameter("stopFlag");
		System.out.println("--------------------------------detailFlag1-------------------------    "+detailFlag1);
		String should_handfee1=mySmartUpload.getRequest().getParameter("should_handfee");
		String real_handfee1=mySmartUpload.getRequest().getParameter("real_handfee");
		String sysnote1=mySmartUpload.getRequest().getParameter("sysnote");
		String tonote1=mySmartUpload.getRequest().getParameter("tonote");
		String userPhone1=mySmartUpload.getRequest().getParameter("userPhone");
		userPhone=userPhone1;
		ParamsIn.add( feeCode);		                                               /* ���ô���	   */
		ParamsIn.add( detai1Code);		                                           /* ��ϸ����	 */
		ParamsIn.add( feeRate);		                                               /* ���ñ���		 */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("should_handfee")});	  /* Ӧ��		   */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("real_handfee")});	  /* ʵ��	 */
		//ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("0.00")});		/* Ӧ��		   */
		//ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("0.00")});		/* ʵ��	 */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("sysnote")});	/* ϵͳ��ע	 */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("tonote")});		/* �û���ע   */
		ParamsIn.add( new String[]{ip_Addr});		/* ����ҵ�����IP��ַ		 */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("userPhone")});	/* ��������ʱ���� */
		ParamsIn.add( new String[]{sSaveName});														/* ���������ļ���	   */
		ParamsIn.add( new String[]{server_ip_Addr});		/* ���������ļ����ϴ�������ַ */
		
		//String[] retStr = callView.callService("s4112Cfm", ParamsIn, "3", "region", iRegion_Code);
		%>
		<wtc:service name="s4112Cfmexc" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
			<wtc:param value="<%=login_accept%>"/>			
			<wtc:param value="<%=opCode1%>"/>
			<wtc:param value="<%=workNo1%>"/>
			<wtc:param value="<%=NoPass1%>"/>									
			<wtc:param value="<%=orgCode%>"/>
			<wtc:param value="<%=opType1%>"/>
			<wtc:param value="<%=unit_name1%>"/>									
			<wtc:param value="<%=accountMsg1%>"/>
						
			<wtc:param value="<%=kong%>"/>
			
			<wtc:params value="<%=payOrder%>"/>					
			<wtc:param value="<%=limitNum1%>"/>
			<wtc:param value="<%=detailFlag1%>"/>
			<wtc:param value="<%=stopFlag1%>"/>	
									
			<wtc:params value="<%=feeCode%>"/>
			<wtc:params value="<%=detai1Code%>"/>
			<wtc:params value="<%=feeRate%>"/>	
						
			<wtc:param value="<%=should_handfee1%>"/>
			<wtc:param value="<%=real_handfee1%>"/>
			<wtc:param value="<%=sysnote1%>"/>			
			<wtc:param value="<%=tonote1%>"/>
			<wtc:param value="<%=ip_Addr%>"/>
			<wtc:param value="<%=userPhone1%>"/>			
			<wtc:param value="<%=sSaveName%>"/>
			<wtc:param value="<%=server_ip_Addr%>"/>	
			<wtc:param value="<%=v_effectRule%>"/>
		</wtc:service>
		<wtc:array id="retStr2" scope="end" start="1"  length="1"/>
		<wtc:array id="retStr3" scope="end"  start="2"  length="1"/>
		
		<%			
	    
	    	error_code=retCode1;
	    	error_msg=retMsg1;
	    	System.out.println("retStr================"+retStr2.length);
	    	System.out.println("retStr================"+retStr3.length);
	    	System.out.println("retCode1======================"+retCode1);
	    	System.out.println("retMsg1======================"+retMsg1);	   
	if(!error_code.equals("000000")){
		%>
	 <SCRIPT type=text/javascript>
	    var path="<%=request.getContextPath()%>/npage/s3700/f3705_2_printxls.jsp?";
     if (rdShowConfirmDialog("<br>�������:"+"<%=error_code%></br>"+"������Ϣ:"+"<%=error_msg%>"+"<br>�Ƿ񱣴������Ϣ��",0)==1)	
			{
				path = path + "&returnMsg=" + "<%=retMsg1%>"+ "&phoneNo=" + "<%=userPhone1%>";
				path = path + "&grpName="+"<%=unit_name1%>";
				path = path + "&unitID="+"<%=unit_id%>";
    	  		path = path + "&op_Code=" + "<%=op_code%>";
    	  		path = path + "&orgCode=" + "<%=orgCode%>";
                window.open(path);
    			}	
                
            history.go(-1);    
     
     
     
     
		//rdShowMessageDialog("�������:"+"<%=error_code%></br>"+"������Ϣ:"+"<%=error_msg%>",0);
		//history.go(-1);
	 </SCRIPT>
		<%
	}else{
		  String temp1="";
			for(int is=0;is<retStr2.length;is++) {
			    temp1+=retStr2[is][0];
			}
			String temp2="";
			for(int iss=0;iss<retStr3.length;iss++) {
			    temp2+=retStr3[iss][0];
			}

		String iPhoneNo = temp1.replaceAll("\\|","~");
		String retMsgForExcl = temp2.replaceAll("\\|","~");
		System.out.println("@@@@@@@@@@@@@@@@iPhoneNo="+iPhoneNo);
		System.out.println("@@@@@@@@@@@@@@@@retMsgForExcl"+retMsgForExcl);	
		System.out.println("@@@@@@@@@@@@@@@@temp1"+temp1);	
		System.out.println("@@@@@@@@@@@@@@@@temp2"+temp2);	
		strToken1=new StringTokenizer(temp1,"|");
		strToken2=new StringTokenizer(temp2,"|");
		%>

<html>
<head>
	<title>�û���Ϣ</title>
</head>
	<SCRIPT type=text/javascript>
		function previouStep(){
			frm.action="s3705.jsp";
			frm.method="post";
			frm.submit();
		}
	    function print_xls(){
	    	document.frm.action="/npage/public/pubExcl.jsp";
			document.frm.submit();
	    }		
	</SCRIPT>
<body>
	<form name="frm" method="post" action="">
<%
java.util.Date sysdate = new java.util.Date();
java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

String createTime = sf.format(sysdate);

String pnt_B1=unit_name2+"|"
	+unit_id+"|"
	+unit_name1+"|"
	+workNo+"|"
	+opName+"|"
	+createTime+"|"
	;
%>		
	
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">δ�ɹ������б�</div>
		</div>			
	        <table  cellspacing="0" >
	                <TR> 			
	                  <Th>δ��ӳɹ�����(����б�Ϊ�գ���ȫ��������ӳɹ���)</Th>
	                  <Th>ʧ��ԭ��</Th>
	                </TR>		
	<%			

			while (strToken1.hasMoreTokens()) {
			
			%>
					<TR >
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
	            	<input class="b_foot_long" name="prtxls" id="prtxls" type=button value="����XLS�ļ�" 
						onclick="print_xls()" style="cursor:hand">         
	                <input  name="previous"  class="b_foot" type=button value="����" onclick="previouStep()">
	                &nbsp;
	                <input name="back" class="b_foot" onClick="removeCurrentTab()" type="button"  value="�ر�">
	             </td>
	          </tr>
	        </table>
	        
<INPUT TYPE='hidden' ID = 'pnt_A' NAME = 'pnt_A' VALUE = '�������ƶ�ͨѶ��˾���ų�Ա�����ɹ���¼|'>
<INPUT TYPE='hidden' ID = 'pnt_B' NAME = 'pnt_B' VALUE = '��������|���ű��|���Ų�Ʒ�ʻ�|��������|��������|��������|'>
<INPUT TYPE='hidden' ID = 'pnt_B1' NAME = 'pnt_B1' VALUE = '<%=pnt_B1%>'>
<INPUT TYPE='hidden' ID = 'pnt_C' NAME = 'pnt_C' VALUE = 'δ�ɹ�����|ʧ��ԭ��|'>
<INPUT TYPE='hidden' ID = 'pnt_C1' NAME = 'pnt_C1' VALUE = "<%=iPhoneNo%>|<%=retMsgForExcl%>|">
<INPUT TYPE='hidden' ID = 'opCode' NAME = 'opCode' VALUE = "<%=opCode%>">		        
        </form>
        <%@ include file="/npage/include/footer.jsp" %>
</body>
</html>
<%}%>

<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+error_code+"&retMsgForCntt="+error_msg+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+login_accept+"&pageActivePhone="+userPhone+"&opBeginTime="+opBeginTime+"&contactId="+unit_id+"&contactType=grp";
	System.out.println("url======="+url);
%>
<jsp:include page="<%=url%>" flush="true" />
