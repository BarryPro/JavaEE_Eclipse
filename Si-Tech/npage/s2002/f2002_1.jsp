<%
  /*
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2008��10��25��
�� * ����: piaoyi
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
		response.setHeader("Pragma","No-Cache");
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0);
		String workName = (String)session.getAttribute("workName");
		String ipAddr = (String)session.getAttribute("ipAddr");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		System.out.println("regionCode="+regionCode);
		String opCode="2037";
		String opName="���ſͻ���Ϣͬ��";  
		String sqlStr="";
%>
<HTML>
<HEAD>
<link href="s2002.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<FORM name="form1" method="post">
<%@ include file="/npage/include/header.jsp" %>
<table>
	<tr>
   	<td width="15%" class="blue">�ϼ����ſͻ�����</td>
   	<td>
			<input type="text" class="" name="p_ParentCustomerNumber" id="p_ParentCustomerNumber" value="0" v_type="string" maxlength="30" v_maxlength="30">
			<input class="b_text" name=b0 type=button value=��ѯ id="findbutton" onClick="fatherIdSearch()" >
			<input class="b_text" name=b9 type=button value=��֤ id="yanbutton" onClick="fatherIdSearch()" >
    </td>
  </tr>
	<tr>
   	<td class="blue">��������</td>
   	<td>
   	  <select name="p_Action" id="p_Action" width=50>
  			<option value='1'>�������ſͻ�</option>
  			<option value='2'>������ſͻ�</option>
  			<option value='3'>��ͣ���ſͻ�</option>
      </select>
      <font class="orange">*</font>
    </td>
  </tr>
</table>
<br>
<div class="title"><div id="title_zi">EC������Ϣ</div></div>
<table cellSpacing=0 >
  <tr>
    <td width="15%" class="blue">
    ���ſͻ�����ʡ����
    </td>
    <td width="35%">
      <!--input value="����ʡ" readonly  size="6"--->
      <input type="hidden" name="p_CompanyID1" value="">
      <select name="p_CompanyID" id="p_CompanyID">
       <%sqlStr ="select detail_code, detail_name from sbbossListCode where list_code = 'CompanyID' and detail_code='451'order by detail_order ";%>
			 <wtc:qoption name="sPubSelect" outnum="2">
			 <wtc:sql><%=sqlStr%></wtc:sql>
			 </wtc:qoption>
      </select>
      <font class="orange">*</font>
    </td>
    <td class="blue">
    ���ſͻ�����ʡ����
    </td>
    <td>
       <input type="text" name="p_CustomerProvinceNumber" id="p_CustomerProvinceNumber" v_type="0_9" v_must="1" size="18" maxlength="18">
       <font class="orange">*</font>
       <input name="custQuery" type="button" class="b_text" onclick="getCustomerNumber()" id="getCustomerNumberBtn" value="��ѯ">
       <input name="custQuery1" type="button" class="b_text" onclick="getCustomerNumber()" id="getCustomerNumberBtn1" value="��֤">
    </td>
  </tr>
  <tr>
    <td width="15%" class="blue">
    EC���ſͻ�����
    </td>
    <td width="35%">
			<input type="text" name="p_CustomerNumber" id="p_CustomerNumber" v_type="0_9" value="0" v_must="1" size="30"   maxlength="30" readonly>
			<font class="orange">*</font>
    </td>
    <td class="blue">
    ���ſͻ�����
    </td>
    <td>
      <input name="p_CustomerName" id="p_CustomerName" v_type="string" v_must="1" maxlength="256" v_maxlength="256">
      <font class="orange">*</font>
    </td>
  </tr>
  <tr>
    <td class="blue">
    �ͻ������ʶ
    </td>
    <td>
      <input name="p_CustomerClassID" id="p_CustomerClassID" v_type="string" size="4" maxlength="2" v_maxlength="2" >
    </td>
    <td  class="blue">
    ���ż���
    </td>
    <td>
      <select align="left" name="p_CreditLevelID" id=p_CreditLevelID width=50>
       <%sqlStr ="select detail_code, detail_name from sbbossListCode where list_code = 'CreditLevelID' order by detail_order ";%>
			 <wtc:qoption name="sPubSelect" outnum="2">
			 <wtc:sql><%=sqlStr%></wtc:sql>
			 </wtc:qoption>
      </select>
      <font class="orange">*</font>
    </td>
   </tr>
   <tr>
    <td class="blue">
    �ͻ���Ҫ����
    </td>
    <td>
      <select align="left" name="p_CustomerRankID" id=p_CustomerRankID width=50>
       <%sqlStr ="select detail_code, detail_name from sbbossListCode where list_code = 'CustomerRankID' order by detail_order ";%>
			 <wtc:qoption name="sPubSelect" outnum="2">
			 <option value="">=====��=====</option>
			 <wtc:sql><%=sqlStr%></wtc:sql>
			 </wtc:qoption>
      </select>
    </td>
    <td class="blue">
    �ͻ��ҳ϶�
    </td>
    <td >
      <input name="p_LoyaltyLevelID" id="p_LoyaltyLevelID" type="string" size="8" maxlength="1" v_maxlength="1">
    </td>
  </tr>
  <tr>
    <td class="blue">
    ����ID���绰���ţ�
    </td>
    <td>
      <input type="text" name="p_NationID" id="p_NationID" v_type="0_9" size="8" maxlength="4">
    </td>
    <td class="blue">
    ֤�����
    </td>
    <td>
      <input type="text" name="p_TaxNum" v_must="1" id="p_TaxNum" size="20" v_type="string" >
    </td>
  </tr>
  <tr>
    <td class="blue">
    ���˴���
    </td>
    <td >
      <input type="text" name="p_Corporation" id="p_Corporation" v_type="string" size="20" maxlength="20" v_maxlength="20">
    </td>
    <td class="blue">
    ע���ʽ𣨵�λ����Ԫ��
    </td>
    <td>
      <input type="text" name="p_LoginFinancing" id="p_LoginFinancing" v_type="money" v_minvlaue="0" v_minvlaue="99999999.99" size="12" maxlength="11">
    </td>
  </tr>
  <tr>
    <td class="blue">
    ��ҵ���
    </td>
    <td>
      <select align="left" name="p_IndustryID" id=p_IndustryID width=50>
       <%sqlStr ="select detail_code, detail_name from sBizListCode where list_code = 'Industry' order by detail_order ";%>
			 <wtc:qoption name="sPubSelect" outnum="2">
			 <wtc:sql><%=sqlStr%></wtc:sql>
			 </wtc:qoption>
      </select>
      <font class="orange">*</font>
    </td>
    <td class="blue">
    ��ҵ����/��˾����
    </td>
    <td >
       <select align="left" name="p_OrganizationTypeID" id=p_OrganizationTypeID width=50>
       <%sqlStr ="select detail_code, detail_name from sbbossListCode where list_code = 'OrganizTypeID' order by detail_order ";%>
			 <wtc:qoption name="sPubSelect" outnum="2">
			 <option value="">=====��=====</option>
			 <wtc:sql><%=sqlStr%></wtc:sql>
			 </wtc:qoption>
      </select>
    </td>
  </tr>
  <tr>
    <td class="blue">
    ��ҵ��ģ
    </td>
    <td>
    	<input type="hidden" name="p_EmployeeAmountId" id="p_EmployeeAmountId" value="3"/>
    	<input type="text" name="p_EmployeeAmountIdText" id="p_EmployeeAmountIdText" value="3-С΢��" readonly class="InputGrey"/>
    </td>
    <td class="blue">
    ��ҵԱ����
    </td>
    <td>
    <input type="text" v_must="1" name="p_MemberCount" id="p_MemberCount" onblur="checkElement(this);makeInSum();" v_type="0_9" size="9" maxlength="9">
    <font class="orange">*</font>
    </td>
  </tr>
  <tr>
    <td class="blue">
    ����ʡ/����
    </td>
    <td >
       <select align="left" name="p_Location" id="p_Location" width=50>
       <%sqlStr ="select detail_code, detail_name from sbbossListCode where list_code = 'Location' order by detail_order ";%>
			 <wtc:qoption name="sPubSelect" outnum="2">
			 <option value="">=====��=====</option>
			 <wtc:sql><%=sqlStr%></wtc:sql>
			 </wtc:qoption>
      </select>
    </td>
    <td class="blue">
    �ʱ�
    </td>
    <td>
			<input type="text" name="p_PostCode" id="p_PostCode" type="string" size="8" maxlength="8" v_maxlength="8">
    </td>
  </tr>
  <tr>
    <td class="blue">
    	��ַ
    </td>
    <td>
    	 <input type="text" name="p_AddressFullName" id="p_AddressFullName" v_type="string" maxlength="255" v_maxlength="255">
    </td>
    <td class="blue">��˾��ҳ
    </td>

    <td>
    	 <input type="text" name="p_Homepage" id="p_Homepage" v_type="string" maxlength="40" v_maxlength="40">
    </td>
  </tr>
  <tr>
    <td class="blue">ҵ��ʹ�����/��˾����
    </td>
    <td>
    	 <input type="text" name="p_Background" id="p_Background" v_type="string" maxlength="40" v_maxlength="40">
    </td>
    <td class="blue">ʡBOSS�ڼ��ſͻ�����
    </td>
    <td>
    	 <input type="text" name="p_OrgCustID" id="p_OrgCustID" v_type="string" size="30" maxlength="30" v_maxlength="30">
    </td>
  </tr>
  <tr>
    <td class="blue">��ע��Ϣ
    </td>
    <td colspan="3">
    	 <input type="text" name="p_Description" id="p_Description" v_type="string" size="60" maxlength="120" v_maxlength="120">
    </td>
  </tr>
  <tr>
    <td class="blue">�ͻ�����ȼ�
    </td>
    <td colspan="3">
			<select name="customerServLevel" id="customerServLevel">
				<option value="1">���Ƽ�</option>
				<option value="2">���Ƽ�</option>
				<option value="3">ͭ�Ƽ�</option>
				<option value="4" selected>��׼��</option>
			</select>
    </td>
  </tr>
	<TR id="isDirectManageCustTr1" > 
		<td class="blue" >�Ƿ�ֱ�ܿͻ�
    </td>
    <td> 
      <select name="isDirectManageCust" id="isDirectManageCust" disabled >
      	<option value="0" selected>��</option>
      	<option value="1">��</option>
      </select>
    </td>
		<TD class="blue" >ֱ�ܿͻ����� 
		</TD>
		<TD> 
			<input type="text" name="directManageCustNo" id="directManageCustNo"  v_type="string"  disabled />
		</TD>
	</tr>
	<tr id="isDirectManageCustTr2"> 
		 <TD class="blue" >��֯�������� 
		</TD>
		<TD> 
			<input type="text" name="groupNo" id="groupNo"  v_type="string" disabled />
		</TD>
		<TD class="blue" >������Ӫҵ�� 
		</TD>
		<TD> 
			<input type="text" name="groupYearPay" id="groupYearPay" v_must="1" onblur="checkElement(this);makeInSum();"  v_type="money" />
			<font class="orange">��Ԫ*</font>
		</TD>
	</tr>
	<tr>
		<td class="blue" >���ſͻ�����2016�꣩ 
		</td>
		<td> 
			<select name="unitCustLevel">
				<option value="01" selected>01-A</option>
				<option value="02">02-B</option>
				<option value="03">03-C</option>
				<option value="04">04-D</option>
			</select>
		</td>
			
				<td class="blue" >֤������  </td>
		<td> 
			<select name="sel_idType" id="sel_idType">
				<option value="1">��֤��һӪҵִ��</option>
				<option value="2">Ӫҵִ��</option>
				<option value="3">��֯��������֤</option>
				<option value="4">˰��Ǽ�֤</option>
				<option value="5">��ҵ��λ����֤��</option>
				<option value="6">������巨�˵Ǽ�֤��</option>
				<option value="7">���ⵥλ����</option>
			</select>
		<td>
			
	</tr>
	
	<tr>
		<td class="blue" >�ͻ�֤��ɨ��� </td>
		<td> 
			 <input type="file" id="custIdScrenFile" name="custIdScrenFile"   />
		</td>
			 
		<td class="blue">���пͻ�֤��ɨ��� </td>
		<td> 
			 <input type="text" id="old_custIdScrenFile" name="old_custIdScrenFile"  readOnly="readOnly" class="InputGrey"   />
		</td>	
			
	</tr>
</table>
<br>
<div class="title"><div id="title_zi">�ͻ�������Ϣ</div></div>
<table cellSpacing=0>
	<tr>
    <td width="15%" class="blue">����
    </td>
    <td width="35%">
    	 <input type="text" name="p_StaffNumber" id="p_StaffNumber" v_type="string" size="20" maxlength="20" v_maxlength="20">
    </td>
    <td width="15%" class="blue">����
    </td>
    <td width="35%">
    	 <input type="text" name="p_StaffName" id="p_StaffName" v_type="string" v_must="1" v_type="string" maxlength="60" v_maxlength="60">
    	 <font class="orange">*</font>
    </td>
  </tr>
	<tr>
    <td class="blue">��ϵ�绰
    </td>
    <td>
    	 <input type="text" name="p_ContactPhone" id="p_ContactPhone" v_type="0_9" v_must="1" size="20" maxlength="20">
    	 <font class="orange">*</font>
    </td>

    <td class="blue">�ֻ�
    </td>
    <td>
    	 <input type="text" name="p_MobilePhone" id="p_MobilePhone" type="0_9" size="20" maxlength="20">
    </td>
  </tr>
	<tr>
    <td class="blue">����
    </td>
    <td>
    	 <input type="text" name="p_ContactFax" id="p_ContactFax" type="string" size="20" maxlength="20" v_maxlength="20">
    </td>
    <td class="blue">�����ʼ�
    </td>
    <td>
    	 <input type="text" name="p_E_mail" id="p_E_mail" type="string" maxlength="50" v_maxlength="50">
    </td>
  </tr>
	<tr>
    <td class="blue">�ͻ������ϼ��쵼����
    </td>
    <td>
    	 <input type="text" name="p_LeaderName" id="p_LeaderName" type="string" maxlength="50" v_maxlength="50">
    </td>
    <td class="blue">�ͻ������ϼ��쵼�绰
    </td>
    <td colspan="3">
    	 <input type="text" name="p_LeaderTel" id="p_LeaderTel" type="string" size="15" maxlength="15">
    </td>
  </tr>
</table>
<br>

<DIV id="div1_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div1_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">�ؼ�����Ϣ</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv1">
	 	  <DIV id="wait1"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>

<DIV id="div2_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div2_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">��չ��Ϣ&nbsp;&nbsp;</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv2">
	 	  <DIV id="wait2"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>


<DIV id="hiddendate_new" style="display:none">
</DIV>

<DIV id="hiddendate_delete" style="display:none">
</DIV>

<!--hejwa �й��ƶ�BBOSS��ʡ��˾����ҵ��ӿڹ淶V2.0.8-->
<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
<input type="hidden" name="hid_up_filePath"        id="hid_up_filePath">
<input type="hidden" name="hid_up_fileName"        id="hid_up_fileName">

<input type="hidden" name="hiddendate_keyperson_num"        id="hiddendate_keyperson_num">
<input type="hidden" name="hiddendate_extinfo_num"          id="hiddendate_extinfo_num">
<input type="hidden" name="hiddendate_cmccprd_num"          id="hiddendate_cmccprd_num">
<input type="hidden" name="hiddendate_keyperson_delete_num" id="hiddendate_keyperson_delete_num">
<input type="hidden" name="hiddendate_extinfo_delete_num"   id="hiddendate_extinfo_delete_num">
<input type="hidden" name="hiddendate_cmccprd_delete_num"   id="hiddendate_cmccprd_delete_num">
<input type="hidden" name="parentidflag"   id="parentidflag" value="0">
<input type="hidden" name="custidflag"   id="custidflag" value="0">
<table>
  <tr>
    <td align="center" id="footer" colspan="2">
      <input class="b_foot" name=next id=nextoper type=button value="ȷ��">
      <input class="b_foot" name=reset type=button value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
    </td>
  </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

<script type="text/javascript">
	var _jspPage =
	{"div1_switch":["mydiv1","f2002_KeyPerson_list.jsp","f"]
	,"div2_switch":["mydiv2","f2002_ExtInfo_list.jsp","f"]
	};
	function hiddenSpider()
	{
			document.getElementById("mydiv1").style.display='none';
	    document.getElementById("mydiv2").style.display='none';
	}

/*
i=[0]
vPoAttNameFile=[/iwebd2/applications/DefaultWebApp/npage/tmp/CustIdScFile119878645813.JPG]
vPoAttName=[CustIdScFile119878645813.JPG]
vContName=[CustIdScFile119878645813.JPG]
*/
	
function upLoadSuccess( jFilePath, jFileName) {
	/*
 alert(
 				"jFilePath=["+jFilePath+"]"+"\n"+
 				"jFileName=["+jFileName+"]"+"\n"
 			);
 	*/		
 			$("#hid_up_filePath").val(jFilePath);
 			$("#hid_up_fileName").val(jFileName);
 			nextoper_sub();
}	
function doUpload(){
	document.form1.target="hidden_frame";
  document.form1.encoding="multipart/form-data";
  document.form1.action="f2002_uploadFile.jsp";
  document.form1.method="post";
  document.form1.submit();
  loading();
}
function doUnLoading(){
  unLoading();
}	

function nextoper_sub(){
	if ("1"!=rdShowConfirmDialog("ȷ���ύ��?")){
		return false;
	}
	/*������select��input��text �� disabled��ֵΪfalse*/
	$("select").each(function() {
		$(this).attr("disabled","");
	});
	$("#nextoper").attr("disabled" , true);
   	document.form1.target="_self";
    document.form1.encoding="application/x-www-form-urlencoded";
    document.form1.method="post";
   	document.form1.action="f2002_cfm.jsp?isDirectManageCust="+$("#isDirectManageCust").val()+"&directManageCustNo="+$("#directManageCustNo").val()+"&groupNo="+$("#groupNo").val();
    document.form1.submit();
}
  function nextoper()
  {
  	
  	 if($("#p_Action").val()=="2")//�޸�
  	{
  	
  		if(!type2_query_flag&&$("#p_ParentCustomerNumber").val()!="0"){
  			rdShowMessageDialog("���ѯ�ϼ����ſͻ�����!");	
    		return;
  		}
  	}
  	
  	var confirmFlag = true;
  	var finalAcceptId = "";
  	/**/
  	if(!check(form1)){			
			return;
		}
	/*
	var p_TaxNum = $.trim($("#p_TaxNum").val());
	if(p_TaxNum.length != 0){
		var m = /^([0-9A-Za-z]*)$/;
		var flag = m.test(p_TaxNum);
		if(!flag){
			rdShowMessageDialog("˰��/Ӫҵִ�պ��������֡���ĸ��ɣ�");
			return false;
		}
	}	*/
	// add by wanglm 2010-09-25 ����ͻ������ʶֻ���뵥���ַ������� start
	if($("#p_CustomerClassID").val().length== 1){
		rdShowMessageDialog("�ͻ������ʶ���ȱ�������λ����Ϊ�գ�");	
    	return;
	}
	// add by wanglm 2010-09-25 ����ͻ������ʶֻ���뵥���ַ������� end
	if($("#p_StaffName").val()=="")
    {
  			rdShowMessageDialog("��������Ϊ��!");	
    		return;
    }
    
    if( !forInt(document.forms[0].p_ContactPhone) )
	{
	    	  return false;
	}	
	document.all.p_CompanyID1.value=document.all.p_CompanyID.value;
  	if($("#p_Action").val()=="1")//����
  	{
  		if($("#parentidflag").val()=="0")
  		{
  			rdShowMessageDialog("������֤�ϼ����ſͻ�����!");	
    		return;
  		}
  		if($("#custidflag").val()=="0")
  		{
  			rdShowMessageDialog("������֤���ſͻ�����ʡ����!");	
    		return;
  		}
  		
  	}
  	

  	
  	//$("DIV.KeyPerson","#hiddendate_keyperson").remove();
  	//$("DIV.ExtInfo","#hiddendate_extinfo").remove();
  	//$("DIV.CMCCPrdInfo","#hiddendate_cmccprd").remove();
  	
  	//$("DIV.KeyPerson","#hiddendate_delete").remove();  
  	//$("DIV.ExtInfo","#hiddendate_delete").remove();    
  	//$("DIV.CMCCPrdInfo","#hiddendate_delete").remove();
  	  	
  	$("#hiddendate_keyperson_num").val("0");
    $("#hiddendate_extinfo_num").val("0");
  	$("#hiddendate_cmccprd_num").val("0");
  	$("#hiddendate_keyperson_delete_num").val("0");
    $("#hiddendate_extinfo_delete_num").val("0");
  	$("#hiddendate_cmccprd_delete_num").val("0"); 
  	
    $("#hiddendate_keyperson_delete_num").val($("DIV.KeyPerson","#hiddendate_delete").size());
    $("#hiddendate_extinfo_delete_num").val($("DIV.ExtInfo","#hiddendate_delete").size());
  	$("#hiddendate_cmccprd_delete_num").val($("DIV.CMCCPrdInfo","#hiddendate_delete").size());  	

  	$.each($(".keyperson_contenttr"), function(i){
		var ii  = $("DIV.KeyPerson","#hiddendate_new").size();
  	    var newdate=
        "<DIV class='KeyPerson' style='display:none'>" +
        "<input type='text' name='tableid"+ii+"' value='0'>" +
        "<input type='text' name='opertype"+ii+"' value='U'>" +
        "<input type='text' name='a_Role"+ii+"' value='"+$(this).attr("a_Role")+"'>"+                                              //��Ա��ɫ
        "<input type='text' name='a_PartyName"+ii+"' value='"+$(this).attr("a_PartyName")+"'>"+                                    //����
        "<input type='text' name='a_Sex"+ii+"' value='"+$(this).attr("a_Sex")+"'>"+                                                //�Ա�
        "<input type='text' name='a_ContactPhone"+ii+"' value='"+$(this).attr("a_ContactPhone")+"'>"+                              //��ϵ�绰
        "<input type='text' name='a_Title"+ii+"' value='"+$(this).attr("a_Title")+"'>"+                                            //ְ��
        "<input type='text' name='a_Alias"+ii+"' value='"+$(this).attr("a_Alias")+"'>"+                                            //�ǳ�
        "<input type='text' name='a_Memorial"+ii+"' value='"+$(this).attr("a_Memorial")+"'>"+                                      //����
        "<input type='text' name='a_Birthday"+ii+"' value='"+$(this).attr("a_Birthday")+"'>"+                                      //������
        "<input type='text' name='a_Mate"+ii+"' value='"+$(this).attr("a_Mate")+"'>"+                                              //��ż����
        "<input type='text' name='a_Secretary"+ii+"' value='"+$(this).attr("a_Secretary")+"'>"+                                    //��������
        "<input type='text' name='a_School"+ii+"' value='"+$(this).attr("a_School")+"'>"+                                          //��ҵԺУ
        "<input type='text' name='a_ClassMates"+ii+"' value='"+$(this).attr("a_ClassMates")+"'>"+                                  //ͬ��
        "<input type='text' name='a_Hobby"+ii+"' value='"+$(this).attr("a_Hobby")+"'>"+                                            //��Ȥ������
        "<input type='text' name='a_Leader"+ii+"' value='"+$(this).attr("a_Leader")+"'>"+                                          //�ϼ��쵼
        "<input type='text' name='a_LeaderDept"+ii+"' value='"+$(this).attr("a_LeaderDept")+"'>"+                                  //�ϼ�����
        "<input type='text' name='a_Vassal"+ii+"' value='"+$(this).attr("a_Vassal")+"'>"+                                          //�¼�����
        "<input type='text' name='a_Intercourse"+ii+"' value='"+$(this).attr("a_Intercourse")+"'>"+                                //�罻Ȧ
        "<input type='text' name='a_CustomerProvinceNumber_KeyPerson"+ii+"' value='"+$(this).attr("a_CustomerProvinceNumber")+"'>"+//���Ź���ʡ����
        "</DIV>";
        $("#hiddendate_new").append(newdate);
        confirmFlag = true;
  	});  	
  	$("#hiddendate_keyperson_num").val($("DIV.KeyPerson","#hiddendate_new").size());

		/*2015/01/06 17:24:09 gaopeng ��չ��Ϣ*/
  	$.each($(".extinfo_contenttr"), function(i)
  	{
  	/*�¾ɱ�ʶ*/
  	var a_OperType = $(this).attr("a_OperType");
  	/*�޸�������ʶ*/
  	var paction = $("#p_Action").val();  		  
		var ii  = $("DIV.ExtInfo","#hiddendate_new").size();
		var a_ExtInfoAcceptID_NEW = $(this).attr("a_ExtInfoAcceptID_NEW");
		var a_ExtInfoAcceptID = $(this).attr("a_ExtInfoAcceptID");
		/*������ʶ*/
		if(paction == "1"){
			finalAcceptId = a_ExtInfoAcceptID;
		}else if(paction == "2"){
			if(a_OperType == "OLD"){
				finalAcceptId = a_ExtInfoAcceptID_NEW;
			}else if(a_OperType == "NEW"){
				finalAcceptId = a_ExtInfoAcceptID;
			}
		}else if(paction == "3"){
			if(a_OperType == "OLD"){
				finalAcceptId = a_ExtInfoAcceptID_NEW;
			}else if(a_OperType == "NEW"){
				finalAcceptId = a_ExtInfoAcceptID;
			}
		}
		 if(paction != "3"){
			var openFlag = $(this).attr("a_button_open_flag");
			
			if(a_ExtInfoAcceptID_NEW+"false" == openFlag){
				/*2015/01/07 10:21:39 gaopeng ����Ҫע�� ������ȥ�ˣ�����û�е��ȷ�ϰ�ť������ֱ�ӹر��ˣ�������һ������ʾδȷ��
					��ʱ���ǰ� a_CMCCPrdListCheck Ҳ����checkflag:extInfo[22] ��ֵΪ0 �������ͻ���������
					��Ʒ��
				*/
				$(this).attr("a_CMCCPrdListCheck","0");
				rdShowMessageDialog("��ѡ��"+$(this).attr("a_ITDeptName")+"������ȷ�ϴ���");
				confirmFlag = false;
				return false;
			}
		}
      	var newdate=
      	"<DIV class='ExtInfo' style='display:none'>" +
      	"<input type='text' name='tableid"+ii+"' value='1'>" +                                                                   //������ 0-���ſͻ��ؼ�����Ϣ 1-���ſͻ���չ��Ϣ 2-�ƶ���Ϣ����Ʒ 3-���ſͻ�������Ϣ
      	"<input type='text' name='opertype"+ii+"' value='U'>" +                                                                  //�������� Y-�������޸� N-ɾ��(0,1,2)
      	"<input type='text' name='a_ITDeptName"+ii+"' value='"+$(this).attr("a_ITDeptName")+"'>"+                                //�Ƿ���IT����
      	"<input type='text' name='a_HasITDept"+ii+"' value='"+$(this).attr("a_HasITDept")+"'>"+                                  //IT��������
      	"<input type='text' name='a_FeeCase"+ii+"' value='"+$(this).attr("a_FeeCase")+"'>"+                                      //�Ƿ���ר���ʷѷ���
      	"<input type='text' name='a_FeeCaseInfo"+ii+"' value='"+$(this).attr("a_FeeCaseInfo")+"'>"+                              //�ʷ��ײ�����
      	"<input type='text' name='a_ARPU"+ii+"' value='"+$(this).attr("a_ARPU")+"'>"+                                            //ƽ������
      	"<input type='text' name='a_DataARPU"+ii+"' value='"+$(this).attr("a_DataARPU")+"'>"+                                    //ƽ������ҵ������
      	"<input type='text' name='a_AvgFee"+ii+"' value='"+$(this).attr("a_AvgFee")+"'>"+                                        //Ա����ƽ������
      	"<input type='text' name='a_Quota"+ii+"' value='"+$(this).attr("a_Quota")+"'>"+                                          //�����±������
      	"<input type='text' name='a_RewardType"+ii+"' value='"+$(this).attr("a_RewardType")+"'>"+                                //���ѱ�����ʽ
        "<input type='text' name='a_UnicomTone"+ii+"' value='"+$(this).attr("a_UnicomTone")+"'>"+                                //�Ƿ�ʹ����ͨ����ҵ��
        "<input type='text' name='a_UnicomData"+ii+"' value='"+$(this).attr("a_UnicomData")+"'>"+                                //�Ƿ�ʹ����ͨ����ҵ��
        "<input type='text' name='a_Trends"+ii+"' value='"+$(this).attr("a_Trends")+"'>"+                                        //δ���仯����
        "<input type='text' name='a_MobileUser"+ii+"' value='"+$(this).attr("a_MobileUser")+"'>"+                                //�й��ƶ��ֻ���
        "<input type='text' name='a_MobileRate"+ii+"' value='"+$(this).attr("a_MobileRate")+"'>"+                                //�й��ƶ��ֻ��û�����
        "<input type='text' name='a_Informationize"+ii+"' value='"+$(this).attr("a_Informationize")+"'>"+                        //����Ϣ��������̶�
        "<input type='text' name='a_Intergration"+ii+"' value='"+$(this).attr("a_Intergration")+"'>"+                            //����Ϣ�����ɵ�����̶�
        "<input type='text' name='a_Terminal"+ii+"' value='"+$(this).attr("a_Terminal")+"'>"+                                    //����ҵ�ն˶��Ƶ�����̶�
        "<input type='text' name='a_TransProv"+ii+"' value='"+$(this).attr("a_TransProv")+"'>"+                                  //�Կ�ʡһ�廯ʵʩ����������
        "<input type='text' name='a_SinglePay"+ii+"' value='"+$(this).attr("a_SinglePay")+"'>"+                                  //��һ���˵����������
        "<input type='text' name='a_Mas"+ii+"' value='"+$(this).attr("a_Mas")+"'>"+                                              //��MAS������̶�
        "<input type='text' name='a_CustomerProvinceNumber_ExtInfo"+ii+"' value='"+$(this).attr("a_CustomerProvinceNumber")+"'>"+//���Ź���ʡ����
        "<input type='text' name='a_ExtInfoAcceptID"+ii+"' value='"+finalAcceptId+"'>"+                      //��չ��Ϣ��ˮ
        "</DIV>";
        //alert("��չ��Ϣ����==="+newdate);
        $("#hiddendate_new").append(newdate);
        /*2015/01/06 17:24:09 gaopeng ��Ʒ��Ϣ*/
      	var newarr = $(this).data("a_CMCCPrdList");
      	if(newarr){      		 
      		 $.each(newarr, function(iii)
      		 {
      		 	 var iiii  = $("DIV.CMCCPrdInfo","#hiddendate_new").size();
    	       var newedatei=
    	       "<DIV class='CMCCPrdInfo' style='display:none'>"+
    	       "<input type='text' name='tableid"+iiii+"'                          value='2'>"+
    	       "<input type='text' name='opertype"+iiii+"'                         value='U'>"+
    	       "<input type='text' name='a_CMCCPrd"+iiii+"'                        value='"+newarr[iii][0]+"'>"+
    	       "<input type='text' name='a_CustomerProvinceNumber_CMCCPrd"+iiii+"' value='"+newarr[iii][1]+"'>"+
    	       "<input type='text' name='a_ExtInfoAcceptID_CMCCPrd"+iiii+"'        value='"+finalAcceptId+"'>"+
    	       "<input type='text' name='a_CMCCAcceptID"+iiii+"'                   value='"+newarr[iii][3]+"'>"+    	       
             "</DIV>";
             //alert("��Ʒ��Ϣ����==="+newedatei);
             $("#hiddendate_new").append(newedatei);
      		 });
      	}
      	confirmFlag = true;
  	}); 
  	
  	$("#hiddendate_extinfo_num").val($("DIV.ExtInfo","#hiddendate_new").size());
  	$("#hiddendate_cmccprd_num").val($("DIV.CMCCPrdInfo","#hiddendate_new").size());
  if(confirmFlag == false){
  	return false;
  }
  
  
  	if($("#sel_idType").val()!="7"){
	  	if($("#custIdScrenFile").val()==""){
	  		rdShowMessageDialog("����ӿͻ�֤��ɨ���!");	
	    	return;
	  	}
  	}
  	
  	if($("#custIdScrenFile").val()!=""){
  		doUpload();
  	}else{
  		$("#hid_up_filePath").val($("#old_custIdScrenFile").val());
  		nextoper_sub();
  	}
  	
  }

  $(document).ready(function () {
		//���ؽ�����
		hiddenSpider();
		$("#findbutton").hide();
		$("#getCustomerNumberBtn").hide();
		
		$("#p_CompanyID").val("451");
		$("#p_CompanyID1").val("451");
		$('img.closeEl').bind('click', toggleContent);
		$('#nextoper').click(function(){
	     nextoper();
	  });
	  $("#p_Action").change( function() {
	  	document.all.p_CustomerProvinceNumber.readOnly=false;
	  	document.all.p_ParentCustomerNumber.readOnly=false;
	  	
	  	    if($("#p_Action").val()=="1")
	  	    {
	  	    	$("#findbutton").hide();
	  	    	$("#yanbutton").show();
	  	    	$("#getCustomerNumberBtn1").show();
	  	    	$("#getCustomerNumberBtn").hide();
	  	    	$("#parentidflag").val("0");
	  	    	$("#custidflag").val("0");
	  	    	$("#p_CompanyID").val("451");
	  	    	$("#p_CompanyID1").val("451");
	  	    	document.all.p_StaffNumber.readOnly=false;
	  	    	document.all.p_StaffName.readOnly=false;
	  	    	document.all.p_ContactPhone.readOnly=false;
	  	    	document.all.p_MobilePhone.readOnly=false;
	  	    	document.all.p_ContactFax.readOnly=false;
	  	    	document.all.p_E_mail.readOnly=false;
	  	    	document.all.p_LeaderName.readOnly=false;
	  	    	document.all.p_LeaderTel.readOnly=false;
	  	    	document.all.p_CompanyID1.value=document.all.p_CompanyID.value;
	  	    	
	  	    	$("#p_CompanyID").attr("disabled","");
	  	    	//��ҵ���ɸ�
	  	    	$("#p_IndustryID").attr("disabled","");
	  	    	//����ʡ/���пɸ�
	  	    	$("#p_Location").attr("disabled","");
	  	    }
	  	    else if($("#p_Action").val()=="2")
	  	    {
	  	    	$("#findbutton").show();
	  	    	$("#yanbutton").hide();
	  	    	$("#getCustomerNumberBtn1").hide();
	  	    	$("#getCustomerNumberBtn").show();
	  	    	$("#parentidflag").val("0");
	  	    	$("#custidflag").val("0");
	  	    	/*2014/12/25 10:13:34 gaopeng ���ڽ���һ��BBOSSϵͳ���ߵļ������ܵ��֪ͨ
	  	    		����
	  	    		���ſͻ�����ʡ����
							EC���ſͻ�����
							��ҵ���
							����ʡ/����
							
							���ܸģ�ʣ�µĶ��ܸ�

	  	    	*/
	  	    	//����
	  	    	document.all.p_StaffNumber.readOnly=false;
	  	    	//����
	  	    	document.all.p_StaffName.readOnly=false;
	  	    	//��ϵ�绰
	  	    	document.all.p_ContactPhone.readOnly=false;
	  	    	//�ֻ�
	  	    	document.all.p_MobilePhone.readOnly=false;
	  	    	//����
	  	    	document.all.p_ContactFax.readOnly=false;
	  	    	//�����ʼ�
	  	    	document.all.p_E_mail.readOnly=false;
	  	    	//�ͻ������ϼ��쵼����
	  	    	document.all.p_LeaderName.readOnly=false;
	  	    	//�ͻ������ϼ��쵼�绰
	  	    	document.all.p_LeaderTel.readOnly=false;
	  	    	document.all.p_CompanyID1.value=document.all.p_CompanyID.value;
	  	    	//���ſͻ�����ʡ����
	  	    	
	  	    	$("#p_CompanyID").attr("disabled","disabled");
	  	    	//��ҵ��𲻿ɸ�
	  	    	$("#p_IndustryID").attr("disabled","disabled");
	  	    	//����ʡ/���в��ɸ�
	  	    	$("#p_Location").attr("disabled","");
	  	    	
	  	    	
	  	    	
	  	    }
	  	    else if($("#p_Action").val()=="3")
	  	    {
	  	    	$("#findbutton").show();
	  	    	$("#yanbutton").hide();
	  	    	$("#getCustomerNumberBtn1").hide();
	  	    	$("#getCustomerNumberBtn").show();
	  	    	$("#parentidflag").val("0");
	  	    	$("#custidflag").val("0");
	  	    	/*2014/12/25 10:13:34 gaopeng ���ڽ���һ��BBOSSϵͳ���ߵļ������ܵ��֪ͨ
	  	    		����
	  	    		���ſͻ�����ʡ����
							EC���ſͻ�����
							��ҵ���
							����ʡ/����
							
							���ܸģ�ʣ�µĶ��ܸ�

	  	    	*/
	  	    	//����
	  	    	document.all.p_StaffNumber.readOnly=true;
	  	    	//����
	  	    	document.all.p_StaffName.readOnly=true;
	  	    	//��ϵ�绰
	  	    	document.all.p_ContactPhone.readOnly=true;
	  	    	//�ֻ�
	  	    	document.all.p_MobilePhone.readOnly=true;
	  	    	//����
	  	    	document.all.p_ContactFax.readOnly=true;
	  	    	//�����ʼ�
	  	    	document.all.p_E_mail.readOnly=true;
	  	    	//�ͻ������ϼ��쵼����
	  	    	document.all.p_LeaderName.readOnly=true;
	  	    	//�ͻ������ϼ��쵼�绰
	  	    	document.all.p_LeaderTel.readOnly=true;
	  	    	document.all.p_CompanyID1.value=document.all.p_CompanyID.value;
	  	    	//���ſͻ�����ʡ����
	  	    	
	  	    	$("#p_CompanyID").attr("disabled","disabled");
	  	    	//��ҵ��𲻿ɸ�
	  	    	$("#p_IndustryID").attr("disabled","disabled");
	  	    	//����ʡ/���в��ɸ�
	  	    	$("#p_Location").attr("disabled","disabled");
	  	    	
	  	    	$("#p_CustomerName").attr("readonly","readonly");
	  	    	$("#p_CustomerClassID").attr("readonly","readonly");
	  	    	$("#p_CreditLevelID").attr("disabled","disabled");
	  	    	$("#p_CustomerRankID").attr("disabled","disabled");
	  	    	$("#p_LoyaltyLevelID").attr("readonly","readonly");
	  	    	$("#p_NationID").attr("readonly","readonly");
	  	    	$("#p_TaxNum").attr("readonly","readonly");
	  	    	$("#p_Corporation").attr("readonly","readonly");
	  	    	$("#p_LoginFinancing").attr("readonly","readonly");
	  	    	$("#p_OrganizationTypeID").attr("disabled","disabled");
	  	    	$("#p_EmployeeAmountId").attr("disabled","disabled");
	  	    	$("#p_MemberCount").attr("readonly","readonly");
	  	    	$("#p_PostCode").attr("readonly","readonly");
	  	    	$("#p_AddressFullName").attr("readonly","readonly");
	  	    	$("#p_Homepage").attr("readonly","readonly");
	  	    	$("#p_Background").attr("readonly","readonly");
	  	    	$("#p_OrgCustID").attr("readonly","readonly");
	  	    	$("#p_Description").attr("readonly","readonly");
	  	    	$("#customerServLevel").attr("disabled","disabled");
	  	    	$("#p_OrgCustID").attr("readonly","readonly");
	  	    	$("#p_OrgCustID").attr("readonly","readonly");
	  	    	$("#p_OrgCustID").attr("readonly","readonly");
	  	    	$("#p_OrgCustID").attr("readonly","readonly");
	  	    	
	  	    	
	  	    	
	  	    }	  	    
	  	  	
	  	    $("#p_CustomerProvinceNumber").val("");
			$("#p_CustomerNumber").val("0");
			$("#p_CustomerName").val("");
			$("#p_CustomerClassID").val("");
			$("#p_CreditLevelID").val("00");
			$("#p_CustomerRankID").val("0");
			$("#p_LoyaltyLevelID").val("");
			$("#p_NationID").val("");
			$("#p_TaxNum").val("");
			$("#p_Corporation").val("");
			$("#p_LoginFinancing").val("");
			$("#p_MemberCount").val("");
			$("#p_PostCode").val("");
			$("#p_AddressFullName").val("");
			$("#p_Homepage").val("");
			$("#p_OrgCustID").val("");
			$("#p_Background").val("");
			$("#p_Description").val("");
			$("#p_StaffNumber").val("");
			$("#p_StaffName").val("");
			$("#p_ContactPhone").val("");
			$("#p_MobilePhone").val("");
			$("#p_ContactFax").val("");
			$("#p_E_mail").val("");
			$("#p_LeaderName").val("");
			$("#p_LeaderTel").val("");
			
			$("div.itemContent").slideUp(30);
			$("img.closeEl").attr({ src: "../../../nresources/default/images/jia.gif"});
	  		

	  	  
	  	  
	   });
	   
    }
  );

  var toggleContent = function(e)
  {  	
  	var targetContent = $( 'DIV.itemContent',this.parentNode.parentNode.parentNode);
  	var needBtn = "1";
  	if($("#p_Action").val() == "2")
  	{
  		var needBtn = "1";
  	}
  	if($("#p_Action").val() == "3")
  	{
  		var needBtn = "3";
  	}
  	
  	if (targetContent.css('display') == 'none') {
  		//if($("#p_CustomerNumber").val()){
  		   targetContent.slideDown(300);
  		   $(this).attr({ src: "../../../nresources/default/images/jian.gif"});
  		   //���÷���
  		   try{
  		   	var tmp = $(this).attr('id');
  		   	var tmp2 = eval("_jspPage."+tmp);
  		   	if(tmp2[2]=="f"&&tmp2[1]!=''&&tmp2[1]!=undefined)
  		   	{
  		   		$("#"+tmp2[0]).load(tmp2[1],{sCustomerProvinceNumber:$("#p_CustomerProvinceNumber").val(),
  		   			sp_Action:$("#p_Action").val(),
  		   			sNeedOpButton:needBtn});
  		   		//tmp2[2]="t";
  		   	}
  		   }catch(e)
  		   {
  		   }
  		//}else{
  		//   rdShowMessageDialog("��У��EC���ſͻ����룡��");
		//     return false;
  		//}

  	} else {
  		targetContent.slideUp(300);
  		$(this).attr({ src: "../../../nresources/default/images/jia.gif"});
  	}
  	return false;
  };

function getCustomerNumber()
{ 
	var retType = $("#p_Action").val();  	
	if(retType=="2") //�޸� 
	{
		if( !forInt(document.forms[0].p_CustomerProvinceNumber) )
	    {
	    	  return false;
	    }
		var packet = new AJAXPacket("f2002_getCustomerNumber_ajax.jsp","���Ժ�......");
		packet.data.add("sCustomerProvinceNumber",$("#p_CustomerProvinceNumber").val());
		core.ajax.sendPacket(packet);
		packet =null;
		$('img.closeEl').click();
		
	}
	else if(retType=="3")//���� 
	{
		if( !forInt(document.forms[0].p_CustomerProvinceNumber) )
	    {
	    	  return false;
	    }
		var packet = new AJAXPacket("f2002_getCustomerNumber_ajax.jsp","���Ժ�......");
		packet.data.add("sCustomerProvinceNumber",$("#p_CustomerProvinceNumber").val());
		core.ajax.sendPacket(packet);
		packet =null;
		$('img.closeEl').click();	
	}
	else if(retType=="1")//���� 
	{
		var pageTitle = "";
	    var fieldName = "";
	    var sqlStr = "";
	    var selType = "S";    //'S'��ѡ��'M'��ѡ
	    var retQuence = "";
	    var retToField = "";
	    if( !forInt(document.forms[0].p_CustomerProvinceNumber) )
	    {
	    	  return false;
	    }
	    
	    pageTitle = "���ſͻ���ѯ";
	    fieldName = "���ſͻ�ID|��ʡ���ſͻ�����|���ſͻ����� ";
	    sqlStr = "select a.cust_id , unit_id, unit_name "+
				" from dgrpcustmsg a ,dcustdoc b where a.cust_id=b.cust_id and b.owner_type='04' and b.region_code='<%=regionCode%>' and a.unit_id="+$("#p_CustomerProvinceNumber").val().trim();
	    retQuence = "1";
	    retToField = "p_CustomerProvinceNumber";
	    
	    var ret = PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,50,800,600);
 
	}
	
	    if ( (ret == undefined)  && (retType=="1"))
	    {
	    	$("#custidflag").val("1");
    		rdShowMessageDialog("��֤�ɹ�!");
    		qryDirectManageCustInfo();
	    	document.all.p_CustomerProvinceNumber.readOnly=true;
	    	//document.all.p_ParentCustomerNumber.readOnly=true;
	    	return;
	    }
	//if ( (ret == undefined)  && (retType=="2"))
	//    {
	//    	$("#custidflag").val("1");
    //		rdShowMessageDialog("��֤�ɹ�!");
	//    	document.all.p_CustomerProvinceNumber.readOnly=true;
	//    	document.all.p_ParentCustomerNumber.readOnly=true;
	//    	return;
	//    }
}
var type2_query_flag = false;  
function fatherIdSearch()
{
	
	var pageTitle = "";
    var fieldName = "";
    var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "";
    var retToField = "";
    
    if($("#p_Action").val() == "1")
    {
    	if($("#p_ParentCustomerNumber").val() == "0")
    	{
    		$("#parentidflag").val("1");
    		
    		rdShowMessageDialog("��֤�ɹ�!");
    		//$("#p_ParentCustomerNumber").attr("readonly","true");
    		document.all.p_ParentCustomerNumber.readOnly=true;
    		return;
    	}
    	else
    	{
	    	pageTitle = "�������ſͻ���ѯ";
	    	fieldName = "EC���ſͻ�����|���ſͻ�����ʡ����|���ſͻ�����|���ſͻ�����ʡ����";
	    	sqlStr = "select Custmoter_ec_id , Customer_id , Customer_name ,Customer_prov "+
					"from dCustomerInfo where customer_id='"+$("#p_ParentCustomerNumber").val()+"'";
	   		retQuence = "0";
	    	retToField = "p_ParentCustomerNumber";
	   }
	}
	else
	{
		
		pageTitle = "�޸ļ��ſͻ���ѯ";
	    fieldName = "�ϼ����ſͻ�����|EC���ſͻ�����|���ſͻ�����ʡ����|���ſͻ�����|���ſͻ�����ʡ����";
	    sqlStr = "select Customer_Parent_id, Custmoter_ec_id , Customer_id , Customer_name ,Customer_prov "+
				" from dCustomerInfo a,dgrpcustmsg b,dcustdoc c  where trim(a.Customer_id)=to_char(b.unit_id)  "+
				 " and b.cust_id=c.cust_id and c.region_code='<%=regionCode%>' and a.Customer_Parent_id='"+$("#p_ParentCustomerNumber").val()+"'";
	    retQuence = "1|2|3|4";
	    retToField = "p_CustomerNumber|p_CustomerProvinceNumber|p_CustomerName|p_CompanyID";
	}
    
    var ret = PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,50,800,600);
    
    alert(ret);
    
    if((ret==undefined) && ($("#p_Action").val() == "1") )
    {
    	$("#parentidflag").val("1");
    	rdShowMessageDialog("��֤�ɹ�!");
    	document.all.p_ParentCustomerNumber.readOnly=true;
    	return;
    }
    if ( (ret==undefined) && ($("#p_Action").val() == "2" || $("#p_Action").val() == "3") ) //���
    {
    	type2_query_flag = true;
    	//$("#p_CustomerProvinceNumber").attr("readonly","true");
    	document.all.p_CustomerProvinceNumber.readOnly=true;
    	document.all.p_ParentCustomerNumber.readOnly=true;
    	getCustomerNumber();
    	
			qryDirectManageCustInfo();//��ȡֱ�ܿͻ���Ϣ
    }
    
}

function qryDirectManageCustInfo(){
	var packet = new AJAXPacket("f2037_ajax_qryDirectManageCustInfo.jsp","���ڻ�����ݣ����Ժ�......");
	packet.data.add("unitId",$("#p_CustomerProvinceNumber").val());
	packet.data.add("opCode","<%=opCode%>");
	core.ajax.sendPacket(packet,doQryDirectManageCustInfo);
	packet = null;
}

function doQryDirectManageCustInfo(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg =  packet.data.findValueByName("retMsg");
	var v_isDirectManageCust =  packet.data.findValueByName("v_isDirectManageCust");
	var v_directManageCustNo =  packet.data.findValueByName("v_directManageCustNo");
	var v_groupNo =  packet.data.findValueByName("v_groupNo");
	if(retCode != "000000"){
		rdShowMessageDialog("��ѯֱ����Ϣ�쳣!");
		$("#nextoper").attr("disabled" , true);
	}else{
		$("#isDirectManageCust").val(v_isDirectManageCust);
		$("#directManageCustNo").val(v_directManageCustNo);
		$("#groupNo").val(v_groupNo);
		$('img.closeEl').click();
	}
}

function doProcess(packet)
{
   var retType = packet.data.findValueByName("retType");
   
   var retFlag = packet.data.findValueByName("retFlag");
   if(retType=="1")
   {
       
   }else if("2"=="2")
   {
       if("0"=="0")
       {
       	  
          var r_ParentCustomerNumber    = packet.data.findValueByName("r_ParentCustomerNumber");
          var r_CompanyID               = packet.data.findValueByName("r_CompanyID");
          var r_CustomerProvinceNumber  = packet.data.findValueByName("r_CustomerProvinceNumber");
          var r_CustomerNumber          = packet.data.findValueByName("r_CustomerNumber"); 
         
          var r_CustomerName            = packet.data.findValueByName("r_CustomerName");
          var r_CustomerClassID         = packet.data.findValueByName("r_CustomerClassID");
          var r_CreditLevelID           = packet.data.findValueByName("r_CreditLevelID");
          var r_CustomerRankID          = packet.data.findValueByName("r_CustomerRankID");
          var r_LoyaltyLevelID          = packet.data.findValueByName("r_LoyaltyLevelID");
          var r_NationID                = packet.data.findValueByName("r_NationID");
          var r_TaxNum                  = packet.data.findValueByName("r_TaxNum");
          var r_Corporation             = packet.data.findValueByName("r_Corporation");
          var r_LoginFinancing          = packet.data.findValueByName("r_LoginFinancing");
          var r_IndustryID              = packet.data.findValueByName("r_IndustryID");
          var r_OrganizationTypeID      = packet.data.findValueByName("r_OrganizationTypeID");
          var r_EmployeeAmountId        = packet.data.findValueByName("r_EmployeeAmountId");
          var r_MemberCount             = packet.data.findValueByName("r_MemberCount");
          var r_Location                = packet.data.findValueByName("r_Location");
          var r_PostCode                = packet.data.findValueByName("r_PostCode");
          var r_AddressFullName         = packet.data.findValueByName("r_AddressFullName");
          var r_Homepage                = packet.data.findValueByName("r_Homepage");
          var r_Background              = packet.data.findValueByName("r_Background");
          var r_OrgCustID               = packet.data.findValueByName("r_OrgCustID");
          var r_Description             = packet.data.findValueByName("r_Description");
          var r_StaffNumber             = packet.data.findValueByName("r_StaffNumber");
          var r_StaffName               = packet.data.findValueByName("r_StaffName");
          var r_ContactPhone            = packet.data.findValueByName("r_ContactPhone");
          var r_MobilePhone             = packet.data.findValueByName("r_MobilePhone");
          var r_ContactFax              = packet.data.findValueByName("r_ContactFax");
          var r_E_mail                  = packet.data.findValueByName("r_E_mail");
          var r_LeaderName              = packet.data.findValueByName("r_LeaderName");
          var r_LeaderTel               = packet.data.findValueByName("r_LeaderTel");	   		   		   	
          var r_CustomerServLevel       = packet.data.findValueByName("r_CustomerServLevel");
          
          var r_groupYearPay       = packet.data.findValueByName("r_groupYearPay");
          var r_unitCustLevel       = packet.data.findValueByName("r_unitCustLevel");
          
          var old_custIdScrenFile  = packet.data.findValueByName("old_custIdScrenFile");
          var old_sel_idType       = packet.data.findValueByName("old_sel_idType");
          
          $("#old_custIdScrenFile").val(old_custIdScrenFile);
          $("#sel_idType").val(old_sel_idType);
          
          
        $("#p_CompanyID").val(r_CompanyID);
        $("#p_CompanyID1").val(r_CompanyID);
        $("#p_CustomerProvinceNumber").val(r_CustomerProvinceNumber);
        $("#p_CustomerNumber").val(r_CustomerNumber);
        $("#p_CustomerName").val(r_CustomerName);
        $("#p_CustomerClassID").val(r_CustomerClassID);
        $("#p_CreditLevelID").val(r_CreditLevelID);
        $("#p_CustomerRankID").val(r_CustomerRankID);
        $("#p_LoyaltyLevelID").val(r_LoyaltyLevelID);
        $("#p_NationID").val(r_NationID);
        $("#p_TaxNum").val(r_TaxNum);
        $("#p_Corporation").val(r_Corporation);
        $("#p_LoginFinancing").val(r_LoginFinancing);
        $("#p_IndustryID").val(r_IndustryID);
        $("#p_OrganizationTypeID").val(r_OrganizationTypeID);
        $("#p_EmployeeAmountId").val(r_EmployeeAmountId);
        $("#p_MemberCount").val(r_MemberCount);
        $("#p_Location").val(r_Location);
        $("#p_PostCode").val(r_PostCode);
        $("#p_AddressFullName").val(r_AddressFullName);
        $("#p_Homepage").val(r_Homepage);
        $("#p_Background").val(r_Background);
        $("#p_OrgCustID").val(r_OrgCustID);
        $("#p_Description").val(r_Description);
        $("#p_StaffNumber").val(r_StaffNumber);
        $("#p_StaffName").val(r_StaffName);
        $("#p_ContactPhone").val(r_ContactPhone);
        $("#p_MobilePhone").val(r_MobilePhone);
        $("#p_ContactFax").val(r_ContactFax);
        $("#p_E_mail").val(r_E_mail);
        $("#p_LeaderName").val(r_LeaderName);
        $("#p_LeaderTel").val(r_LeaderTel);
        $("#customerServLevel").val(r_CustomerServLevel);
        
        
       
        $("#groupYearPay").val(r_groupYearPay);
        
        $("select[name='unitCustLevel']").find("option").each(function(){
        	if($(this).val() == r_unitCustLevel){
        		$(this).attr("selected",true);
        	}
        });
        
        
        if(r_CustomerNumber!="")
        {
          	                     
				document.all.p_CustomerProvinceNumber.readOnly=true;      
				document.all.p_ParentCustomerNumber.readOnly=true;        
        }
        
       }else if(retFlag=="1")
       {
          rdShowMessageDialog("δ�ҵ��ü��ſͻ�����ʡ���� !");
       }else if(retFlag=="2")
       {
       	  rdShowMessageDialog("��ѯ�쳣!");
       }else
       {
       	  rdShowMessageDialog("��ѯ�쳣!");
       }	       
   }	   
}

/*2015/06/23 8:45:20 gaopeng ���ڼ��ſͻ������Ż���֪ͨ*/
function makeInSum(){
	var p_MemberCount = Number($.trim($("#p_MemberCount").val()));
	var groupYearPay = Number($.trim($("#groupYearPay").val()));
	
	var p_EmployeeAmountIdObj = $("#p_EmployeeAmountId");
	var p_EmployeeAmountIdTextObj = $("#p_EmployeeAmountIdText");
	
	if(p_MemberCount >= 1000 || groupYearPay >= 30000){
		p_EmployeeAmountIdObj.val("0");
		p_EmployeeAmountIdTextObj.val("0-�ش���");
	}else if( (p_MemberCount < 1000 && p_MemberCount >= 100) || (groupYearPay < 30000 && groupYearPay >= 3000 ) ){
		p_EmployeeAmountIdObj.val("1");
		p_EmployeeAmountIdTextObj.val("1-����");
	}else if( (p_MemberCount < 100 && p_MemberCount >= 50 ) || (groupYearPay < 3000 && groupYearPay >= 1000) ){
		p_EmployeeAmountIdObj.val("2");
		p_EmployeeAmountIdTextObj.val("2-����");
	}else if( p_MemberCount < 50 || groupYearPay < 1000 ){
		p_EmployeeAmountIdObj.val("3");
		p_EmployeeAmountIdTextObj.val("3-С΢��");
	}
	
}
</script>
