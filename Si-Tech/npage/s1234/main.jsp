<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-09-05 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/common/pwd_comm.jsp" %>	
<html>
<head>
<title>�û������޸�</title>
<%	
		
		//String opName = "�û������޸�";
		String org_code_note = (String)session.getAttribute("orgCode");
		String regionCode_note=org_code_note.substring(0,2);
		String activePhone1=request.getParameter("activePhone1");
		String loginNote="";
		String sqlStrNote = "select back_char1 from snotecode where region_code='"+regionCode_note+"' and op_code='XXXX'";
%>
			<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=activePhone1%>" outnum="1">
	    <wtc:sql><%=sqlStrNote%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="resultNote" scope="end"/>
<%
    for(int i=0;i<resultNote.length;i++){
			 loginNote = (resultNote[i][0]).trim();
		}
		loginNote = loginNote.replaceAll("\"","");
		loginNote = loginNote.replaceAll("\'","");
		loginNote = loginNote.replaceAll("\r\n","   ");  
		loginNote = loginNote.replaceAll("\r","   "); 
		loginNote = loginNote.replaceAll("\n","   "); 
		System.out.println("@@@@@@@@@loginNote="+loginNote);
%>
<%
    String iLoginAccept = "0";
    String iChnSource = "01";
    String iUserPwd = "";
		String dWorkNo = (String)session.getAttribute("workNo");
		String dNopass = (String)session.getAttribute("password");
		String rCus = request.getParameter("r_cus");
			
	  String work_no = (String)session.getAttribute("workNo");
	  String loginName = (String)session.getAttribute("workName");
	  String org_code = (String)session.getAttribute("orgCode");
		String[][] temfavStr=(String[][])session.getAttribute("favInfo");
		String[] favStr=new String[temfavStr.length];
		for(int i=0;i<favStr.length;i++)
			favStr[i]=temfavStr[i][0];
	
		boolean hfrf=false;
		String op_code = request.getParameter("opCode");
		String op_name = request.getParameter("opName");
		String strIdenType="";
		String strIdenInfo="";
		if(rCus.equals("0")){
			op_code = "1234";
			op_name = "�޸�����";
		}else{
			op_code = "1235";
			op_name = "��������";
		}
		String broadPhone = request.getParameter("broadPhone");
		String opCode = op_code;
		String opName = op_name;
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone1%>" id="sLoginAccept"/>
<%	
		String loginAccept = "";
		loginAccept = sLoginAccept;

//---------------�����ύҳ�������������-----------------------------
    String ReqPageName=request.getParameter("ReqPageName");
    String phone_no = request.getParameter("cus_id");
%>
 	<wtc:service name="s1234Init" routerKey="phone" routerValue="<%=activePhone1%>"  outnum="48" >
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=dNopass%>"/>		
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=iUserPwd%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end"/>


<%
	if(result1.length==0){
	%>
	    <script language="javascript">
 	      window.location="f1234.jsp?ReqPageName=main&retMsg=1&activePhone1=<%=activePhone1%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
 	  <%
	}else if(result1==null){
			%>
	    <script language="javascript">
 	      window.location="f1234.jsp?ReqPageName=main&retMsg=2&activePhone1=<%=activePhone1%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
 	  <%
	}
 	//��ȡ���������Ϣ
	ArrayList custDoc = new ArrayList();		
	if(result1!=null&&result1.length>0){
    for(int i=0;i<result1[0].length;i++){
    	custDoc.add(result1[0][i]);
    }
  }
  String sm_name = "";
  sm_name = (String)custDoc.get(3);
%>

<%        
    
    StringBuffer sq2StringBuffer = new StringBuffer();
    sq2StringBuffer.append("select hand_fee ,trim(favour_code) from snewFunctionFee where region_code='");
    sq2StringBuffer.append((String)custDoc.get(20));
    sq2StringBuffer.append("' and function_code='");
    sq2StringBuffer.append(op_code);
    sq2StringBuffer.append("'");
    String baseHandFeeString = sq2StringBuffer.toString();
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=activePhone1%>" outnum="2">
	  <wtc:sql><%=baseHandFeeString%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="baseHandFeeArr" scope="end"/>
<% 
		if(baseHandFeeArr!=null&&baseHandFeeArr.length>0){
			custDoc.add(baseHandFeeArr[0][0]);
			custDoc.add(baseHandFeeArr[0][1]);
		}else{
			custDoc.add("");
			custDoc.add("");	
		}    
        

%>

<%     
	
	if(request.getParameter("ReqPageName").equals("f1234")){
		String smcodee=WtcUtil.repNull(result1[0][2]);
		if(smcodee.equals("cb")){      
   %>
	    <script language="javascript">
 	      window.location="f1234.jsp?ReqPageName=main&retMsg=12&activePhone1=<%=activePhone1%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
 	  <%
 	  
		}

		String passTrans=WtcUtil.repNull(request.getParameter("cus_pass"));
	  if(!passTrans.equals("")){
			String passFromPage=Encrypt.encrypt(passTrans);
//2010-8-20 10:12 wanghfa�޸� ������֤�޸� start
%>
		<script language=javascript>
			var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
			checkPwd_Packet.data.add("custType","01");				//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
			checkPwd_Packet.data.add("phoneNo","<%=activePhone1%>");	//�ƶ�����,�ͻ�id,�ʻ�id
			checkPwd_Packet.data.add("custPaswd","<%=passFromPage%>");//�û�/�ͻ�/�ʻ�����
			checkPwd_Packet.data.add("idType","en");				//en ����Ϊ���ģ�������� ����Ϊ����
			checkPwd_Packet.data.add("idNum","");					//����
			checkPwd_Packet.data.add("loginNo","<%=work_no%>");		//����
			core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
			checkPwd_Packet=null;
			
			function doCheckPwd(packet) {
				var retResult = packet.data.findValueByName("retResult");
				var msg = packet.data.findValueByName("msg");
				if (retResult != "000000") {
					rdShowMessageDialog(msg);
					window.location="f1234.jsp?activePhone1=<%=activePhone1%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
				}
			}
		</script>
<%
/*
		  if(0==Encrypt.checkpwd2((result1[0][5]),passFromPage))		   
				response.sendRedirect("f1234.jsp?ReqPageName=main&retMsg=3&activePhone1="+activePhone1);
*/
//2010-8-20 10:12 wanghfa�޸� ������֤�޸� end
	  }
	}
		
		
	if(((String)custDoc.get(49)).trim().equals("") || ((String)custDoc.get(49)).trim().equals("0")){
		hfrf=true; 
	}else{
  	int favFlag = 0 ;
		for(int i = 0 ; i < temfavStr.length ; i ++){
			if(temfavStr[i][0].trim().equals(((String)custDoc.get(50)).trim())){
				favFlag = 1;
				i = 99;
			}
		}
			
		if(favFlag==0){
			hfrf=true;
		}
	}


	//*****************�ж��굥����**********************/
	System.out.println("�ж��굥����");
	if(!rCus.equals("0")){
		System.out.println("�ж��굥����1");
		strIdenType = request.getParameter("identity_type");
		strIdenInfo = request.getParameter("identity_info");

		System.out.println("strIdenType="+strIdenType);
		System.out.println("strIdenInfo="+strIdenInfo);
		
		if (strIdenType.equals("01")){
			System.out.println("�ж��굥����2");
			String paraAray[] = new String[9];
			paraAray[0] = iLoginAccept;
		  paraAray[1] = iChnSource;
		  paraAray[2] = op_code;//��������
		  paraAray[3] = work_no; //����
		  paraAray[4] = dNopass; //��������
		  paraAray[5] = phone_no;//�ֻ�����
		  paraAray[6] = iUserPwd;
			paraAray[7] = strIdenType;//��������
			paraAray[8] = strIdenInfo;//��Ϣ��
			//String[] ret= implqry.callService("s1234PrtQry",paraAray,"2","phone",phone_no);
%>
		<wtc:service name="s1234PrtQry" routerKey="phone" routerValue="<%=activePhone1%>" retCode="s1234PrtQryRetCode" retMsg="s1234PrtQryRetMsg" outnum="2" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		</wtc:service>
<% 	  
	 		int errCode = s1234PrtQryRetCode==""?999999:Integer.parseInt(s1234PrtQryRetCode);
			String errMsg = s1234PrtQryRetMsg;
			
			if (123487 == errCode){			
	  %>
	    <script language="javascript">
 	      window.location="f1234.jsp?ReqPageName=main&retMsg=8&activePhone1=<%=activePhone1%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
 	  <%
 	  
			}else	if (0 != errCode ){
				
					%>
	    <script language="javascript">
 	      window.location="f1234.jsp?ReqPageName=main&retMsg=7&activePhone1=<%=activePhone1%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
 	  <%
				
			}	
		}	
 }		

		String sqIdtype = "select id_type,id_name from sidtype";
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=activePhone1%>" outnum="2">
	  <wtc:sql><%=sqIdtype%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sIdTypeStr" scope="end"/>
<% 

%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
	var printFlag=9;
	
$(document).ready(function(){
  $('input[name="t_new_pass"]').blur(function(){
    checkPwdEasy(document.frm.t_new_pass.value);
  });
});

function getFew()
{
  if(window.event.keyCode==13)
  {
    var fee=document.all.t_handFee;
    var fact=document.all.t_factFee;
    var few=document.all.t_fewFee;
    if(jtrim(fact.value).length==0)
    {
	  rdShowMessageDialog("ʵ�ս���Ϊ�գ�");
	  fact.value="";
	  fact.focus();
	  return;
    }

    if(parseFloat(fact.value)<parseFloat(fee.value))
    {
  	    few.value="0";
    }  
    else
    {
	    var tem1=((parseFloat(fact.value)-parseFloat(fee.value))*100+0.5).toString();
	    var tem2=tem1;
	    if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
        few.value=(tem2/100).toString();
    }
    few.focus();
  }
}


//----------------------------------------------------ȷ�Ϸ���---------------------------
function submitt(){
	
		/*
		 * hejwa add R_CMI_HLJ_guanjg_2015_2299953@�����Ż�1235�û��������ý���ĺ� �ύǰУ���û�����֤������
		 */
		
	if($("input[name='idenType']").val()=="03"){//�����֤�˶����
		if($("#t_cus_name").val().trim()==""){
			rdShowMessageDialog("�����֤�˶������������ͻ�����");
			$("#t_cus_name").focus();
			return;
		}
		
		if($("#t_idno").val().trim()==""){
			rdShowMessageDialog("�����֤�˶������������֤������");
			$("#t_idno").focus();
			return;
		}
		
		if("<%=(String)custDoc.get(4)%>"!=$("#t_cus_name").val()&&"<%=((String)custDoc.get(11)).trim()%>"!=$("#t_idno").val()){
			rdShowMessageDialog("��֤δͨ����������Ϣ��ϵͳ��¼����");
			$("#t_cus_name").val("");
			$("#t_cus_name").focus();
			return;
		}
		
		if("<%=(String)custDoc.get(4)%>"!=$("#t_cus_name").val()){
			rdShowMessageDialog("��֤δͨ�����ͻ���������");
			$("#t_cus_name").val("");
			$("#t_cus_name").focus();
			return;
		}
		
		if("<%=((String)custDoc.get(11)).trim()%>"!=$("#t_idno").val()){
			rdShowMessageDialog("��֤δͨ����֤��������Ϣ����");
			$("#t_idno").val("");
			$("#t_idno").focus();
			return;
		}
	}		
		
		
		getAfterPrompt();
		if(document.frm.t_new_pass.value.length==0){
			rdShowMessageDialog("�����벻��Ϊ�գ�");
			return;
		}
		if(document.frm.t_new_pass.value.trim().len() != 6){
			rdShowMessageDialog("������ĳ���Ӧ����6λ");
			return;
		}
		
		if(!forNonNegInt(document.frm.t_new_pass)){
			return;
		}
		
		if(document.frm.t_conf_pass.value.trim().len()==0){
			rdShowMessageDialog("У�����벻��Ϊ��!");
			return;				
		}
		
		if(!forNonNegInt(document.frm.t_conf_pass)){
			return;
		}
		
		if(document.frm.t_new_pass.value!=document.frm.t_conf_pass.value){
			rdShowMessageDialog("������������벻һ�£�");
			return;
		}
		
		/*begin diling update for ���״���������ʱУ�������Ƿ��Ǽ����룬�����ӡ����ʱ��ϵͳ����ʾ�ͻ�������ڼ򵥣�Ӱ���û���֪��@2012/6/19*/
		checkPwdEasy(document.frm.t_new_pass.value);	//2010-8-9 9:52 wanghfa��� �ͻ�������������
		if(v_retResult=="0"){
		  var idJ = 0 ;
  		var inputIdType = 0;
  		for(idJ = 0 ; idJ < document.frm.asIdType.length ; idJ ++){
  			if(document.frm.asIdType.options[idJ].selected==true){
  				inputIdType = document.frm.asIdType.options[idJ].value;
  			}
  		}
  		document.frm.asIdTypenew.value=inputIdType;
  		
  
  		if(document.all.t_sys_remark.value.trim().len()==0){
  			if(document.all.opCode.value == "1234"){
  		     document.all.t_sys_remark.value="����Ա"+document.frm.workNo.value+"�����û������޸�";
  		  }
  		  else if(document.all.opCode.value == "1235"){
  		  	 document.all.t_sys_remark.value="����Ա"+document.frm.workNo.value+"�����û���������";
  		  }
  			 
  		}
  		
  		if(document.all.asNotes.value.trim().len()==0){	
  			if(document.all.opCode.value == "1234"){
  				 document.all.asNotes.value="����Ա"+document.frm.workNo.value+"�����û������޸�";
  		  }
  		  else if(document.all.opCode.value == "1235"){
  		  	 document.all.asNotes.value="����Ա"+document.frm.workNo.value+"�����û���������";
  		  }
  			
  		}
  		
   		document.frm.b_submit.disabled=true;		
  		//��ӡ����		
  		printCommit();
  		if(printFlag!=1){
  			return false;
  		}
  	
  		document.frm.action="submit.jsp";
  		document.frm.submit();
		}
		/*end diling update@2012/6/19*/
}

//2010-8-9 8:43 wanghfa��� ��֤������ڼ� start
function checkPwdEasy(pwd) {
	var checkPwd_Packet = new AJAXPacket("../public/pubCheckPwdEasy.jsp","������֤�����Ƿ���ڼ򵥣����Ժ�......");
	checkPwd_Packet.data.add("password", pwd);
	checkPwd_Packet.data.add("phoneNo", "<%=activePhone1%>");
	checkPwd_Packet.data.add("idNo", "<%=((String)custDoc.get(11)).trim()%>");
	checkPwd_Packet.data.add("opCode", "<%=op_code%>");

	core.ajax.sendPacket(checkPwd_Packet, doCheckPwdEasy);
	checkPwd_Packet=null;
}

var v_retResult;
function doCheckPwdEasy(packet) {
	var retResult = packet.data.findValueByName("retResult");

	if (retResult == "1") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ��ͬ���������룬��ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		document.frm.b_submit.disabled=true;	
		return;
	} else if (retResult == "2") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ���������룬��ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		document.frm.b_submit.disabled=true;	
		return;
	} else if (retResult == "3") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ�ֻ������е��������֣���ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		document.frm.b_submit.disabled=true;	
		return;
	} else if (retResult == "4") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ֤���е��������֣���ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		document.frm.b_submit.disabled=true;	
		return;
	} else if (retResult == "0") {
	  v_retResult = retResult;
	  document.frm.b_submit.disabled=false;	
	  /*
		var idJ = 0 ;
		var inputIdType = 0;
		for(idJ = 0 ; idJ < document.frm.asIdType.length ; idJ ++){
			if(document.frm.asIdType.options[idJ].selected==true){
				inputIdType = document.frm.asIdType.options[idJ].value;
			}
		}
		document.frm.asIdTypenew.value=inputIdType;
		

		if(document.all.t_sys_remark.value.trim().len()==0){
			if(document.all.opCode.value == "1234"){
		     document.all.t_sys_remark.value="����Ա"+document.frm.workNo.value+"�����û������޸�";
		  }
		  else if(document.all.opCode.value == "1235"){
		  	 document.all.t_sys_remark.value="����Ա"+document.frm.workNo.value+"�����û���������";
		  }
			 
		}
		
		if(document.all.asNotes.value.trim().len()==0){	
			if(document.all.opCode.value == "1234"){
				 document.all.asNotes.value="����Ա"+document.frm.workNo.value+"�����û������޸�";
		  }
		  else if(document.all.opCode.value == "1235"){
		  	 document.all.asNotes.value="����Ա"+document.frm.workNo.value+"�����û���������";
		  }
			
		}
		
 		document.frm.b_submit.disabled=true;		
		//��ӡ����		
		printCommit();
		if(printFlag!=1){
			return false;
		}
	
		document.frm.action="submit.jsp";
		document.frm.submit();*/
	}
}
//2010-8-9 8:43 wanghfa��� ��֤������ڼ� end

		/************���ñ�**********/
		function doClear(){
			document.frm.b_submit.disabled= false;
			document.frm.t_new_pass.value="";
			document.frm.t_conf_pass.value="";
			document.frm.reset();
		}

/*
 * hejwa 2015-6-11 10:58:48 �����Ż�1235�û��������ý���ĺ�
 * ����֤���͡�������03-->�����֤�˶ԡ�����������ӡ��ͻ�����(����򡢱���)���͡�֤������(����򡢱���)����ͬʱ������չʾ�ġ��ͻ��������͡�֤�����롱ȥ��
 * ����Ŀͻ�������֤��������ϵͳ�еĻ�����Ϣ���к���
 */
$(document).ready(function(){
	if($("input[name='idenType']").val()=="03"){
		$("#t_cus_name").val("");
		$("#t_cus_name").removeClass("InputGrey");
		$("#t_cus_name").removeAttr("readonly");
		
		$("#t_idno").val("");
		$("#t_idno").removeClass("InputGrey");
		$("#t_idno").removeAttr("readonly");
		
		//���ѡ�˷����֤�����������Ѿ������֤������ʾ���ر�ҳ�棬��˶2015��6��18��16:52:16�绰֪ͨ����
		if("<%=(String)custDoc.get(10)%>".trim()=="���֤"){
			rdShowMessageDialog("���û�֤������Ϊ���֤����ͨ�����֤������֤");
			$("input[name='b_back']").click();
		}
	}
});


			
</script>
</head>
<body>
<form name="frm" method="POST" action="">
<input type="hidden" name="cus_id" id="cus_id" value="<%=custDoc.get(1)%>">
<input type="hidden" name="region_code" id="region_code" value="<%=((String)custDoc.get(20)).trim()%>">
<input type="hidden" name="cust_name" id="cust_name" value="<%=(String)custDoc.get(4)%>">
<input type="hidden" name="ReqPageName" id="ReqPageName" value="main">
<input type="hidden" name="oriHandFee" id="oriHandFee" value="<%=((String)custDoc.get(49)).trim()%>">
<input type="hidden" name="oldPass" id="oldPass" value="<%=((String)custDoc.get(26)).trim()%>">
<input type="hidden" name="cust_info">
<input type="hidden" name="opr_info">
<input type="hidden" name="note_info1">
<input type="hidden" name="note_info2">
<input type="hidden" name="note_info3">
<input type="hidden" name="note_info4">
<input type="hidden" name="printcount">
<input type="hidden" name="asIdTypenew">
<input type="hidden" name="activePhone1" value="<%=activePhone1%>">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">ѡ���������</div>
		</div>
<table cellspacing="0">
<tr>
    <td class="blue" width="13%">�û�����</td>
    <td>
        <input type="text" readonly class="InputGrey" name="t_cus_name" id="t_cus_name" value="<%=(String)custDoc.get(4)%>">
    </td>
    <jsp:include page="/npage/common/pwd_2.jsp">
        <jsp:param name="width1" value="13%"/>
        <jsp:param name="width2" value=""/>
        <jsp:param name="pname" value="t_new_pass"/>
        <jsp:param name="pcname" value="t_conf_pass"/>
    </jsp:include>
</tr>

<tr>
    <td class="blue" nowrap>�û���������</td>
    <td>
        <input type="text" readonly class="InputGrey" name="t_region" id="t_region" value="<%=(String)custDoc.get(21)%>">
    </td>
    <td class="blue">��������</td>
    <td>
        <select name="s_city" id="s_city" disabled>
        	<option value="<%=(String)custDoc.get(22)%>"><%=(String)custDoc.get(23)%></option>
        </select>
    </td>
    <td class="blue">��������</td>
    <td>
        <select name="s_spot" id="s_spot" disabled>
        	<option value="<%=(String)custDoc.get(24)%>"><%=(String)custDoc.get(25)%></option>       	
        </select>
    </td>
</tr>
<tr>
    <td class="blue">�û�״̬</td>
    <td>
        <select name="s_cus_status" disabled>
        	<option value="<%=(String)custDoc.get(27)%>"><%=(String)custDoc.get(28)%></option>    
        </select>
    </td>
    <td class="blue">�û����</td>
    <td style="display:none">
        <select name="s_cus_level" disabled>
            <option value="<%=(String)custDoc.get(6)%>"><%=(String)custDoc.get(30)%></option>
        </select>
    </td>
    <td>
        <select name="s_cus_type" disabled>
             <option value="<%=(String)custDoc.get(7)%>"><%=(String)custDoc.get(31)%></option>     	     	
        </select>
    </td>
    <td class="blue">֤������</td>
    <td>
        <select name="s_idtype" disabled>
        	<option value="<%=(String)custDoc.get(9)%>"><%=(String)custDoc.get(10)%></option>
        </select>
    </td>
</tr>
<tr style="display:none">
    <td class="blue">&nbsp;</td>
    <td>
        <input type="text" class="InputGrey" size="30" name="t_cus_address" id="t_cus_address" value="<%=(String)custDoc.get(8)%>" readonly>
    </td>
    <td class="blue">&nbsp;</td>
    <td>
		&nbsp;
    </td>
    <td class="blue">&nbsp;</td>
    <td>
        <input type="hidden" class="InputGrey" name="aaa" id="aaa" value="<%=((String)custDoc.get(11)).trim()%>" readonly>
    </td>
</tr>
<tr>
    <td class="blue">֤����ַ</td>
    <td>
        <input type="text" size="30" class="InputGrey" name="t_id_address" id="t_id_address" value="<%=(String)custDoc.get(19)%>" readonly>
    </td>
    <td class="blue">֤����Ч��</td>
    <td>
        <input type="text" class="InputGrey" name="t_id_valid" id="t_id_valid" value="<%=(String)custDoc.get(29)%>" readonly>

    </td>
    <td class="blue">֤������</td>
    <td>
        <!--<input type="hidden" class="InputGrey" name="t_comm_name" id="t_comm_name" value="<%=(String)custDoc.get(14)%>" readonly>-->
        <input type="text" class="InputGrey" name="t_idno" id="t_idno" value="<%=((String)custDoc.get(11)).trim()%>" readonly>
    </td>
</tr>
<tr>
    <td class="blue">��ϵ������</td>
    <td style="display:none">
        <input type="hidden" class="InputGrey" name="t_comm_phone" id="t_comm_phone" value="<%=(String)custDoc.get(33)%>" readonly>
    </td>
    <td>
    	<input type="text" class="InputGrey" name="t_comm_name" id="t_comm_name" value="<%=(String)custDoc.get(32)%>" readonly>
    </td>
    <td class="blue">��ϵ�˵�ַ</td>
    <td>
        <input type="text" size="30" class="InputGrey" readonly name="t_comm_address" id="t_comm_address" value="<%=(String)custDoc.get(34)%>">
    </td>
    <td class="blue">��ϵ���ʱ�</td>
    <td>
        <input type="text" size="30" class="InputGrey" readonly name="t_comm_postcode" id="t_comm_postcode" value="<%=(String)custDoc.get(35)%>">
    </td>
</tr>
<tr>
    <td class="blue" nowrap>��ϵ��ͨѶ��ַ</td>
    <td>
        <input type="text" size="30" class="InputGrey" readonly name="t_comm_comm" id="t_comm_comm" value="<%=(String)custDoc.get(36)%>">
    </td>
    <td class="blue" nowrap>��ϵ�˴���</td>
    <td>
        <input type="text" class="InputGrey" readonly name="t_comm_fax" id="t_comm_fax" value="<%=(String)custDoc.get(37)%>">
    </td>
    <td class="blue" nowrap>��ϵ��EMAIL</td>
    <td>
        <input type="text" class="InputGrey" readonly name="t_comm_email" id="t_comm_email" value="<%=(String)custDoc.get(38)%>">
    </td>
</tr>
<tr>
    <td class="blue">�û��Ա�</td>
    <td>
        <select name="s_cus_sex" disabled>
        	<option value="<%=(String)custDoc.get(39)%>"><%=(String)custDoc.get(40)%></option>     
        </select>
    </td>
    <td class="blue">��������</td>
    <td>
        <input type="text" class="InputGrey" readonly name="t_birth" id="t_birth" value="<%=(String)custDoc.get(41)%>">
    </td>
    <td class="blue">ְҵ����</td>
    <td>
        <select name="s_busi_type" disabled>
        	<option value="<%=(String)custDoc.get(42)%>"><%=(String)custDoc.get(43)%></option>
        </select>
    </td>
</tr>
<tr>
    <td class="blue">ѧ��</td>
    <td>
        <select name="s_edu" disabled>
        	<option value="<%=(String)custDoc.get(44)%>"><%=(String)custDoc.get(45)%></option>
        </select>
    </td>
    <td class="blue">�û�����</td>
    <td>
        <input type="text" class="InputGrey" readonly name="t_cus_love" id="t_cus_love" value="<%=(String)custDoc.get(46)%>">
    </td>
    <td class="blue">�û�ϰ��</td>
    <td>
        <input type="text" class="InputGrey" readonly name="t_cus_habit" id="t_cus_habit" value="<%=(String)custDoc.get(47)%>">
    </td>
</tr>
<tr style="display:none">
    <td class="blue"> ����������</td>
    <td>
        <input id=Text2 type=text size=17 name=asCustName maxlength=20
               value="<%=(String)custDoc.get(12)%>"
               onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
    </td>
    <td class="blue">��������ϵ�绰</td>
    <td>
        <input id=Text2 type=text size=17 name=asCustPhone maxlength=20 value="<%=(String)custDoc.get(13)%>">
    </td>
    <td>��ϵ��ַ</td>
    <td colspan=2>
        <input id=Text2 type=text size=17 name=asContractAddress maxlength=20
               value="<%=(String)custDoc.get(17)%>"
               onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
    </td>
</tr>
<tr style="display:none">
    <td class="blue"> ������֤������</td>
    <td>
        <select size=1 name=asIdType>
            <%for (int i = 0; i < sIdTypeStr.length; i++) {%>
            <option value="<%=sIdTypeStr[i][0]%>"><%=sIdTypeStr[i][1]%>
            </option>
            <%}%>
        </select>
    </td>
    <td class="blue">֤������</td>
    <td>
        <input id=Text2 type=text size=17 name=asIdIccid maxlength=20 value="<%=(String)custDoc.get(15)%>" >
    </td>
    <td class="blue">֤����ַ</td>
    <td colspan=2>
        <input id=Text2 type=text size=17 name=asIdAddress maxlength=20
               value="<%=(String)custDoc.get(16)%>"
               onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
    </td>
</tr>
<tr>
    <td nowrap width="10%" class="blue">������</td>
    <td nowrap width="23%">
        <input type="text" index="3" name="t_handFee" id="t_handFee" readonly value="<%=((String)custDoc.get(48)).trim()%>" v_type=float v_name="������">
    </td>
    <td nowrap width="10%" class="blue">ʵ��</td>
    <td nowrap width="24%">
        <input type="text" index="4" name="t_factFee" id="t_factFee" onKeyUp="getFew()" v_type=float v_name="ʵ��" <%if(hfrf){%>value="<%=((String)custDoc.get(48)).trim()%>" readonly<%}%>>
    </td>
    <td nowrap width="10%" class="blue"> ����</td>
    <td nowrap width="23%">
        <input type="text" name="t_fewFee" id="t_fewFee" readonly>
    </td>
</tr>
<tr>
    <td nowrap width="10%" class="blue">ϵͳ��ע</td>
    <td nowrap colspan="5" bgcolor="eeeeee">
        <input type="text" name="t_sys_remark" id="t_sys_remark" size="45" readonly>
    </td>
</tr>
<tr style="display:none">
    <td class="blue">�û���ע</td>
    <td nowrap colspan="5">
        <input id=Text2 type=text size=45 name=asNotes maxlength=30 value=""
               onKeyUp="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" v_must=0 v_maxlength=60
               v_type=string v_name="�û���ע">
    </td>
</tr>
</table>
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=loginAccept%>"  />
	<jsp:param name="showBody" value="01"  />
	<jsp:param name="sopcode" value="<%=opCode%>"  />
</jsp:include>
<table>
<tr>
    <td nowrap colspan="6" id="footer">
        <input class="b_foot" type="button" name="b_submit" value="ȷ��" onClick="submitt()"onKeyUp="if(event.keyCode==13){submitt()}" >
        <input class="b_foot" type="button" name="b_clear" value="���" onClick="doClear()">
        <input class="b_foot" type="button" name="b_back" value="����" onClick="window.location.href='f1234.jsp?activePhone1=<%=activePhone1%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>'">
        <input class="b_foot" type="button" name="b_close" value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
    </td>
</tr>
</table>
    <%@ include file="/npage/include/footer.jsp" %>     
<input type=hidden name=loginAccept value="<%=loginAccept%>">
<input type=hidden name=opCode value="<%=op_code%>">
<input type=hidden name=opName value="<%=opName%>">
<input type=hidden name=workNo value="<%=dWorkNo%>">
<input type=hidden name=nopass value="<%=dNopass%>">
<input type=hidden name=orgCode value="<%=org_code%>">
<input type=hidden name=rCusNew value="<%=rCus%>">
<input type=hidden name=opType value="1">
<input type=hidden name=opFlag value="1">
<input type=hidden name=phonePass value="<%=((String)custDoc.get(5)).trim()%>">
<input type=hidden name=idNo value="<%=phone_no%>">
<input type=hidden name=payFee value="<%=((String)custDoc.get(48)).trim()%>">
<input type=hidden name=selfIpAddr value="<%=request.getRemoteAddr()%>">
<input type=hidden name=backLoginAccept>
<input type=hidden name=inputPhoneNo value="<%=phone_no%>">
<input type=hidden name=idenType value="<%=strIdenType%>">
<input type=hidden name=idenInfo value="<%=strIdenInfo%>">
<input type=hidden name=simBell value="   �ֻ�������ѡ�ײ��Żݵ�GPRS������ָCMWAP�ڵ����������.  �������أ�1.��������꿨,�ͼ�ֵ88Ԫ������ء�  2.��½������ɣ�wap.hljmonternet.com��ʹ���ֻ�����������ͼ�����ء�������Ѷ�����������������������������ʱ������,������Ϣ�ѣ�����1860��ͨGPRS ��">
<input type=hidden name=worldSimBell value="    �������ҵ��󣬼���Ϊ�ҹ�˾ȫ��ͨǩԼ�ͻ�����ǩԼ������ʹ���ҹ�˾ҵ�񼰲�Ʒ��ͬʱִ���µ����������ߡ������ɵ�Ԥ�����������������������ϣ�ͬʱ�������Ļ����ڻ���ʹ�����޺󷽿�ʹ�á�       ��Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�       ��Ϊȫ��ͨ�ͻ������������ҹ�˾Ϊ���ṩ��������">
<input type="hidden" name="broadPhone" id="broadPhone" value="<%=broadPhone%>" />
</form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
<script language="JavaScript">
function printCommit()
{          
	showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");  	
}

function showPrtDlg(printType,DlgMessage,submitCfn)
{  //��ʾ��ӡ�Ի��� 
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1"; 
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var firstIdStr = $("#firstId").val();	
	var secondIdStr = $("#secondId").val();
	var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
	var sysAccept = document.all.loginAccept.value;	
   var printStr = printInfo(printType);
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage + "&iccidInfo=" +firstIdStr +"|"+secondIdStr + "&accInfoStr="+accInfoStr;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=op_code%>&sysAccept="+sysAccept+"&phoneNo=<%=phone_no%>&submitCfm=" + submitCfn+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	 var ret=window.showModalDialog(path,printStr,prop);
	if(ret==""){
		ret="confirm";
	}
   if(typeof(ret)!="undefined")
   {
     if((ret=="confirm")&&(submitCfn == "Yes"))
     {
       if(rdShowConfirmDialog('ȷ��Ҫ���д��������')==1)
       {
        document.all.printcount.value="1";
       	printFlag=1;
       }
     }
     if(ret=="continueSub")
	{
		if(rdShowConfirmDialog('ȷ��Ҫ���д��������')==1)
		{
			document.all.printcount.value="0";
			printFlag=1;
		}
	}
   }
   else
		{
			if(rdShowConfirmDialog('ȷ��Ҫ���д��������')==1)
			{
				document.all.printcount.value="0";
				printFlag=1;
			}
		}
}

function printInfo(printType)
{
    var retInfo = "";
    var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
    if(printType == "Detail")
    {
    
    var retInfo = "";
    cust_info+="�ͻ�������"+document.all.t_cus_name.value+"|";
    cust_info+="�ֻ����룺"+document.all.idNo.value+"|";  
    cust_info+="֤�����룺"+document.all.t_idno.value+"|";
    cust_info+="�ͻ���ַ��"+document.all.t_cus_address.value+"|";
    cust_info+="��ϵ�˵绰��"+document.all.t_comm_phone.value+"|";
    
    
    opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"�û�Ʒ�ƣ�"+"<%=sm_name%>"+"|";
    
	if(document.all.opCode.value == "1234")
	{
	 	opr_info+="����ҵ��"+"�����޸�"+"  "+"ҵ����ˮ��"+document.all.loginAccept.value+"|";
	}else
	{
		if (document.frm.idenType.value == "01")
		{
			opr_info+="����ҵ��"+"��������  ����ʽ: �굥�˶�"+"  "+"ҵ����ˮ��"+document.all.loginAccept.value+"|";
		}else if (document.frm.idenType.value == "02")
		{
			opr_info+="����ҵ��"+"��������  ����ʽ��ƾ֤��"+"  "+"ҵ����ˮ��"+document.all.loginAccept.value+"|";
		}else{
			opr_info+="����ҵ��"+"��������"+"  "+"ҵ����ˮ��"+document.all.loginAccept.value+"|";	
		}
	}
	note_info1="��ע:"+document.all.asNotes.value+"|";	
   
    document.all.cust_info.value=cust_info+"#";
	document.all.opr_info.value=opr_info+"#";
	document.all.note_info1.value=note_info1+"#";
	document.all.note_info2.value=note_info2+"#";
	document.all.note_info3.value=note_info3+"#";
	document.all.note_info4.value=note_info4+"#";
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    
	
    }  
    if(printType == "Bill")
    {	//��ӡ��Ʊ
    }
    return retInfo;	
}
</script>
<script>
function printBill(){
	   var infoStr="";                                                                         
	   infoStr+=" "+"|";
	   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		 infoStr+=document.frm.inputPhoneNo.value+"|";//�ƶ�����                                                   
		 infoStr+=""+"|";//��ͬ����                                                          
		 infoStr+=document.frm.cust_name.value+"|";//�û�����                                                
		 infoStr+=document.frm.t_cus_address.value+"|";//�û���ַ 
		 infoStr+="�ֽ�"+"|";
		 infoStr+=document.frm.t_handFee.value+"|";                                                
		 infoStr+="�û������޸ġ�*�����ѣ�"+(document.frm.t_factFee.value-document.frm.t_fewFee.value)+"*��ˮ�ţ�"+document.frm.backLoginAccept.value+"|";
		 location="chkPrint.jsp?retInfo="+infoStr+"&dirtPage=f1234.jsp&activePhone1=<%=activePhone1%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
}
</script>
</html>
