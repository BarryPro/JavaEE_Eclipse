<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-09-04 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");

  HashMap hm=new HashMap();
  hm.put("1","û���û�ID��");
  hm.put("2","δ��ѯ���κ��������");
  hm.put("3","�û��������");
  hm.put("4","�����Ѳ�ȷ���������ܽ����κβ�����");
  hm.put("5","��������1��");
  hm.put("6","��������2��"); 
  hm.put("7","�굥��֤δͨ����"); 
  hm.put("8","�굥��֤�Ѿ��������,���������а���"); 
  hm.put("12","�ú���Ϊ�����к��룬������������룡");  
%>

<html>
<head>
<title>�û������޸�</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	System.out.println("ningtn opCode " + opCode);
	String opName = request.getParameter("opName");
	String inputType="0";
	/*changType �޸�0  ����1 */
	String changType="0";
	String op_code=request.getParameter("opCode");
	String workNo = (String)session.getAttribute("workNo");
	String broadPhone = request.getParameter("broadPhone");
	if("e357".equals(op_code)){
		changType = "0";
	}else if("e358".equals(op_code)){
		changType = "1";
	}
	String operationType=request.getParameter("oprationType");
	if (operationType!=null&&operationType.equals("change")){
		changType=request.getParameter("changType");
		if (changType.equals("1")){
			inputType="1";
		}else{ 
			inputType="0";
		}
	}
  String sqls="SELECT id_Name FROM sIdType order by id_type";
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=activePhone%>" outnum="1">
	<wtc:sql><%=sqls%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="metaData" scope="end" />
<%
  String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
  if(ReqPageName.equals("main"))
  {
     String retMsgx=WtcUtil.repNull(request.getParameter("retMsg"));
 %>
      <script>
	  		rdShowMessageDialog("<%=(String)(hm.get(retMsgx))%>");
	 		</script>
<%
  }
%>

<script language=javascript>

	onload=function()
	{
		if(<%=activePhone%>==null||<%=activePhone%>==""){
			rdShowMessageDialog("�����´򿪴��޸���ҳ��!");
			parent.removeTab("<%=opCode%>");
			return false;
		}
 		self.status="";
 		/* ����opcode�ж�Ӧ���ĸ�radio�н��� */
  	var opCode = "<%=opCode%>";
  	if(opCode == "e357"){
  		$("input[name='r_cus']:eq(0)").attr("checked",'checked');
  	}else{
  		$("input[name='r_cus']:eq(1)").attr("checked",'checked'); 
  	}
 		//��ʼ����ʱ��,�����û������Ƿ���Ҫ����
 		for(var i=0;i<document.getElementsByName("r_cus").length;i++){
 			if(document.getElementsByName("r_cus")[i].checked){
 				if(document.getElementsByName("r_cus")[i].value=="0"){
 					document.all.cus_pass.disabled = false;
 					document.all.cus_pass_button.disabled = false;
 					document.all.identity_print.style.display = "none";
 				}else{
 					document.all.cus_pass.disabled = true;
 					document.all.cus_pass_button.disabled = true;	
 					document.all.identity_print.style.display = "";
 				}
 			}
 		}
	}

	$(document).ready(function(){
		
	});

	function changeidtype()
	{
		if (document.all.identity_type.value == "01")
		{
			document.all.identity_info.disabled = false;
		}else{
			document.all.identity_info.disabled = true;
		}	
	}

//-------2---------��֤���ύ����-----------------
function doCfm()
{ 
		if (<%=changType%> == "1"){
			if (document.all.identity_type.value == "00")
			{
	    	rdShowMessageDialog("��ѡ����֤����!");
	      return;				
			}
			if(document.all.identity_type.value == "01"){
				if(document.all.identity_info.value.trim().len()==0){
					rdShowMessageDialog("ѡ���굥�˶�ʱ,��Ϣ���벻��Ϊ��!");
					document.all.identity_info.focus();
					return false;	
				}
			}
		}
		if(document.all.cus_pass.value.trim().len()==0 && <%=changType%> !="1"){
			rdShowMessageDialog("�û����벻��Ϊ�գ�");
 			document.all.cus_pass.focus();
 			return false;
 		}
 		//��֤���ź��ֻ��Ƿ���ͬһ������ ���ͨ��ֱ���ύ ʧ�ܾͷ���
 		validateGroupId();

}

function validateGroupId(){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/public/validateRegionCode.jsp","������֤���Ե�......");	
	packet.data.add("inPhone",document.s3216.cus_id.value);
	core.ajax.sendPacket(packet,doShowValidate);
	packet = null;
}

function doShowValidate(packet){
	var flag = packet.data.findValueByName("flag");//��־λ true ��ͬһ����  false ����ͬһ����
	if(flag == "false"){
		rdShowMessageDialog("���źͿͻ��ֻ������ز�һ�£�����ʧ��!");
		return ;
	}else{
		s3216.action="main.jsp";
    	s3216.submit();	
	}
}


function changeType(ichange)
{
	var opCode = "<%=opCode%>";
	var opName = "<%=opName%>";
	if (ichange=='1'){
		document.all.cus_pass.disabled = true;
		document.all.cus_pass_button.disabled = true;
		if(opCode == "1234" || opCode == "1235"){
			opCode = "1235";
			opName = "�û���������";
		}else{
			opCode = "e358";
			opName = "����û���������";
		}
		s3216.action="f1234.jsp?changType=1&oprationType=change&activePhone=<%=activePhone%>&opCode=" + opCode + "&opName=" + opName + "&broadPhone=<%=broadPhone%>";
		s3216.submit();
	}else {
		document.all.cus_pass.disabled = false;
		document.all.cus_pass_button.disabled = false;
		if(opCode == "1234" || opCode == "1235"){
			opCode = "1234";
			opName = "�û������޸�";
		}else{
			opCode = "e357";
			opName = "����û������޸�";
		}
		s3216.action="f1234.jsp?changType=0&activePhone=<%=activePhone%>&opCode=" + opCode + "&opName=" + opName + "&broadPhone=<%=broadPhone%>";
		s3216.submit();
	}
}
</script>
</head>
<body>

<form name="s3216" method="POST">
  <input type="hidden" name="ReqPageName" id="ReqPageName" value="f1234">
  <input type="hidden" name="rCus" value="">
  <input type="hidden" name="activePhone" value="<%=activePhone%>">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">ѡ���������</div>
		</div>
<table cellspacing="0">
<tr>
    <td class="blue">��������</td>
    <td colspan="3">
        <input type="radio" name="r_cus" index="0" value="0" <%=changType.equals("0")?"checked":""%> onclick="changeType('0');">�޸�����
        <input type="radio" name="r_cus" index="1" value="1" <%=changType.equals("1")?"checked":""%> onclick="changeType('1');">��������
    </td>
</tr>
<tr>
	<%
		if("e357".equals(opCode) || "e358".equals(opCode)){
	%>
		<td width="16%" class="blue">����˺�</td>
    <td>
       <input type="text" name="broadPhone" id="broadPhone" value="<%=broadPhone%>" class="InputGrey" readonly>
       <input type="hidden" name="cus_id" id="cus_id" value="<%=activePhone%>" />
    </td>
	<%
		}else{
	%>
    <td width="16%" class="blue">�������</td>
    <td>
       <input type="text" size="17" maxlength=11 name="cus_id" id="cus_id" value="<%=activePhone%>" class="InputGrey" readonly>
    </td>
  <%
  	}
  %>
    <td width="20%" class="blue">�û�����</td>
    <td>
        <jsp:include page="/npage/common/pwd_one_new.jsp">
            <jsp:param name="width1" value="16%"/>
            <jsp:param name="width2" value="34%"/>
            <jsp:param name="pname" value="cus_pass"/>
            <jsp:param name="pwd" value="12345"/>
            <jsp:param name="irCus" value='<%=inputType%>'/>
        </jsp:include>
    </td>
</tr>
<!-- ���������޸� ���� 2007��3��12�� -->
<tr id="identity_print" style="display:none">
    <td width="16%" class="blue">��֤����</td>
    <td>
        <select name="identity_type" index="15" onChange="changeidtype()">
            <option value="00" selected>*��ѡ��*</option>
            <option value="01">01 --> �굥�˶�</option>
            <option value="02">02 --> ƾ֤��</option>
        </select><font class="orange">*</font>
    </td>
    <td class="blue">��Ϣ�������(,)�ָ�</td>
    <td>
        <input type="text" name="identity_info" size="50" maxlength="100" v_must=1 value="" Disabled>
    </td>
</tr>
<tr>
    <td colspan="5" id="footer">
      <input class="b_foot" type=button name=qryPage value="ȷ��" onClick="doCfm()" index="2" onKeyUp="if(event.keyCode==13){doCfm()}">
      <input class="b_foot" type=button name=back value="���" onClick="s3216.reset()">
      <input class="b_foot" type=button name=qryPage value="�ر�" onClick="parent.removeTab('<%=op_code%>')">
    </td>
</tr>
</table>
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
<input type="hidden" name="opName" id="opName" value="<%=opName%>" />
  <%@ include file="/npage/include/footer_simple.jsp" %> 
   </form>
</body>
</html>