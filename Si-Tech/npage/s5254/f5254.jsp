 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-07 ҳ�����,�޸���ʽ
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="import java.text.*"%>

<%
//---------------------------------java������------------------------------------
	String opCode = "5254";	
	String opName = "���г�ֵ�������޸�";	//header.jsp��Ҫ�Ĳ���   
	//��ȡsession��Ϣ
	String loginNo=(String)session.getAttribute("workNo");    //���� 
	String orgCode = (String)session.getAttribute("orgCode");   	
	String regionCode =(String)session.getAttribute("regCode");   
	String districtCode = orgCode.substring(2,4);			
	String retFlag="0";
	String retMsg="";
	
	//----------------��ȡ��������----------------------
	String errCode2 = "0";
	String errMsg2 = "";

	//SPubCallSvrImpl impl2 = new SPubCallSvrImpl();

	//ArrayList retList2 = new ArrayList();
	String sqlStr2 = "select agt_type,agt_name from sagttype where region_code='"+regionCode+"'";
	String outParaNums2 = "2";

	//���ù������ݿ��ѯ����
	//retList2 = impl2.sPubSelect(outParaNums2,sqlStr2,"region",regionCode);
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="<%=outParaNums2%>">
		<wtc:sql><%=sqlStr2%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result2" scope="end" />
	
	<%
	
	//��ӡ�������
	//errCode2 = impl2.getErrCode(); //�������	
	//errMsg2 = impl2.getErrMsg(); //������Ϣ
	
	errCode2=retCode2; //�������
	System.out.println("errCode2=========:"+retCode2);		
	errMsg2=retMsg2;//������Ϣ
	System.out.println("errMsg2========:"+errMsg2);
	

	//��ȡ���
	String[][] retListString2 = null;
	String[] agentType=new String[50];
	String[] typeName=new String[50];
	int i=0;
	if("000000".equals(errCode2)){
		//retListString2 = (String[][])retList2.get(0);
		retListString2=result2;
		if(retListString2!=null&&retListString2.length!=0){
			for(i=0;i<retListString2.length;i++){
				System.out.println(i);
				agentType[i]=retListString2[i][0];
				typeName[i]=retListString2[i][1];
			}
		}
		else{
			retFlag="1";
			retMsg="���Ĵ���������Ϊ�գ�";
		}
	}


%>

<html>
	<head>
	<title>���г�ֵ�������޸�</title>
	<%//-----------------------------------js����-------------------------------------%>	
	<script language=javascript>
		//-------------------------------------����RPC------------------------------------
		<%if(retFlag.equals("1")){%>
	    		rdShowMessageDialog("<%=retMsg%>");
	  <%}%>
	onload=function() {
		self.status="";
	 	//core.rpc.onreceive = doProcess;
	}

	function doProcess(packet) {
		self.status="";
		var type = packet.data.findValueByName("type");
		
		if(type == "call_UserList"){
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
			var errCode2 = packet.data.findValueByName("errCode2");
			var errMsg2 = packet.data.findValueByName("errMsg2");

			var agentPhone = packet.data.findValueByName("agentPhone");
		  var UserCode = packet.data.findValueByName("UserCode");
		  var UserStatus = packet.data.findValueByName("iStatus");
		  
		  var agtAddress=packet.data.findValueByName("agtAddress");
		  var agtStatus=packet.data.findValueByName("agtStatus");
		  var regionCode2=packet.data.findValueByName("regionCode2");
		  var districtCode2=packet.data.findValueByName("districtCode2");
		  var legalName=packet.data.findValueByName("legalName");
		  var legalId=packet.data.findValueByName("legalId");
		  var agtType=packet.data.findValueByName("agtType");
		  var agtZip=packet.data.findValueByName("agtZip");
		  var contactName=packet.data.findValueByName("contactName");
		  var contactId=packet.data.findValueByName("contactId");
		  var contactPhone=packet.data.findValueByName("contactPhone");
		  var bankName=packet.data.findValueByName("bankName");
		  var accountNo=packet.data.findValueByName("accountNo");
		  var depositFee=packet.data.findValueByName("depositFee");
		  var tabletSize=packet.data.findValueByName("tabletSize");
		  var signTime=packet.data.findValueByName("signTime");
		  
  		var Entity_groupId=packet.data.findValueByName("Entity_groupId");
		  var Entity_groupName=packet.data.findValueByName("Entity_groupName");
		  
		  
		  var isG3=packet.data.findValueByName("isG3");
		 	var g3RoleCode=packet.data.findValueByName("g3RoleCode");
		  var gThreePhone=packet.data.findValueByName("gThreePhone");
		  var parterid=packet.data.findValueByName("parterid");
			
			var prepay_fee = packet.data.findValueByName("prepay_fee");
			
			if(g3RoleCode=="01"){
				//������
				document.getElementById("parter_row").style.display="block";
			}
			if(g3RoleCode=="02"){
				//������
				document.getElementById("parter_row").style.display="none";
				document.getElementById("parterid").value="";
			}
		  
		  if(Entity_groupId=='')
		  {
		  	document.form1.entryType.value='0';
		  	entryTypeChange();
		  }
		  else
		  {
		  	document.form1.entryType.value='1';
		  	entryTypeChange();
		  }
		  
		  
			  document.form1.agentPhone.value=agentPhone;
			  document.form1.UserCode.value=UserCode;
			  document.form1.UserStatus.value=UserStatus;
			  document.form1.agentAddress.value=agtAddress;
			  document.form1.agtStatus.value=agtStatus;
			  document.form1.regionCode.value=regionCode2;
			  document.form1.districtCode.value=districtCode2;  
			  document.form1.legalPresent.value=legalName;
			  document.form1.legalId.value=legalId;
			  document.form1.angentClass.value=agtType;
			  document.form1.zip.value=agtZip;
			  document.form1.contactName.value=contactName;
			  document.form1.contactId.value=contactId;
			  document.form1.contactPhone.value=contactPhone;
			  document.form1.bankName.value=bankName;
			  document.form1.accountNo.value=accountNo;
			  document.form1.deposit.value=depositFee;
			  document.form1.pb_size.value=tabletSize;
			  document.form1.signTime.value=signTime.substring(0,8);
			  document.form1.Entity_groupId.value=Entity_groupId; 
			  document.form1.Entity_groupName.value=Entity_groupName;
				document.form1.is_ghtree.value=isG3;
				document.form1.g3roleCode.value=g3RoleCode;
			  document.form1.gthree_phone.value=gThreePhone;
		  	document.form1.parterid.value=parterid;
		  	document.form1.prepay_fee.value=prepay_fee;
			  
	 
			  
			  
			  document.form1.submit1.disabled=false;
			  
			  document.form1.agentAddress.readOnly=false;
		  	document.form1.legalPresent.readOnly=false;
		  	document.form1.legalId.readOnly=false;
		  	document.form1.angentClass.disabled=false;
		  	document.form1.zip.readOnly=false;
		  	document.form1.contactName.readOnly=false;
		  	document.form1.contactId.readOnly=false;
		  	document.form1.contactPhone.readOnly=false;
		  	document.form1.contactId.readOnly=false;
		  	document.form1.bankName.readOnly=false;
		  	document.form1.accountNo.readOnly=false;
		  	document.form1.deposit.readOnly=false;
		  	document.form1.pb_size.readOnly=false;
		  	
			  if(document.form1.opNote.value==""){
			    document.form1.opNote.value = "����:"+"<%=loginNo%>"+"���п��г�ֵ�������޸�,�����̱��:"+document.form1.groupId.value;
				}
			if(agtStatus=="N"){
				document.form1.agentAddress.readOnly=true;
			  	document.form1.legalPresent.readOnly=true;
			  	document.form1.legalId.readOnly=true;
			  	document.form1.angentClass.disabled=true;
			  	document.form1.zip.readOnly=true;
			  	document.form1.contactName.readOnly=true;
			  	document.form1.contactId.readOnly=true;
			  	document.form1.contactPhone.readOnly=true;
			  	document.form1.contactId.readOnly=true;
			  	document.form1.bankName.readOnly=true;
			  	document.form1.accountNo.readOnly=true;
			  	document.form1.deposit.readOnly=true;
			  	document.form1.pb_size.readOnly=true;
/*
			  	rdShowMessageDialog("�ô�����״̬Ϊ'��Ч',�������κ��޸�!");
				window.close();
*/
		  }

		}
	}

	
	//-----��ѯ������-----
	function call_getagentId(){
		var regionCode = "<%=regionCode%>";
		var districtCode = "<%=districtCode%>";
		var pageTitle = "������ѡ��";
		var fieldName = "�����̱��|����������";  //����������ʾ���С����� 
    var sqlStr = "select a.group_id,a.group_name from dChnGroupMsg a where a.boss_org_code like '"+regionCode+districtCode+"%' and class_code = '150' Order by a.group_id";
    var selType = "S";
    var retQuence = "0|1";                  //�����ֶ�
    var retToField = "groupId|agentName";    //���ظ�ֵ����
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
    		
	  //-----��ѯ�������ʻ��б�-----
	  if(document.form1.groupId.value!=""){
				var groupId=document.form1.groupId.value;
				var type = "call_UserList";
				var myPacket = new AJAXPacket("f5254_RPC.jsp","�����ύ�����Ժ�......");
				myPacket.data.add("groupId",groupId);
				myPacket.data.add("type",type);
				core.ajax.sendPacket(myPacket);
				myPacket=null;	  
		}
	}


		//--------------------------------�ύ��------------------------------------
		function commit(){
			
			if(document.form1.agtStatus.options[2].selected == true)
			{
				var prepayFee = document.form1.prepay_fee.value;
				if(prepayFee==""){prepayFee="0.00";}
				if(!confirm("��ǰѺ�����Ϊ"+prepayFee+"Ԫ,ȷ�Ͻ��δ���������Ч?"))
				{
					return;
				}
			}
			
		  if(document.form1.entryType.value=='')
	    {
	        rdShowMessageDialog("��ѡ��'�����Ƿ�Ϊ��˾��������ʵ������'!");
	        return false;
	     }
	    if(document.form1.entryType.value=='1'&&document.form1.Entity_groupName.value=='')
	    {
	        rdShowMessageDialog("��ѡ��'ʵ��������֯�ڵ�'!");
	        return false;
	     }
			getAfterPrompt();
			if(document.form1.opNote.value==""){
				    document.form1.opNote.value = "����:"+"<%=loginNo%>"+"���п��г�ֵ�������޸�,�����̱��:"+document.form1.groupId.value;
			}
			if(checkform1()){
				form1.action="f5254_update.jsp?angentClass="+document.form1.angentClass.value;
				form1.submit();
				return true;
			}
	  	}

		//-----------------------------------����֤-----------------------------------------
		function checkform1(){
			if(document.form1.agtStatus.options[0].selected == true){
				rdShowMessageDialog("'������״̬'����Ϊ��!");
				return false;
			}
			if(document.form1.angentClass.options[0].selected == true){
				rdShowMessageDialog("'��������'����Ϊ��!");
				return false;
			}
			if(!checkElement(document.form1.signTime))return false;			
			if(check(document.form1)){
				return true;
		  }
		}

		//---------------------------------��ձ�---------------------------------------
		function resetJSP(){
			for(i=0;i<document.form1.elements.length;i++){
				if (document.form1.elements[i].type=="text"){
					document.form1.elements[i].value = "";
				}else if (document.form1.elements[i].type=="password"){
					document.form1.elements[i].value = "";
				}else if(document.form1.elements[i].name=="agtStatus" || document.form1.elements[i].name=="angentClass" || document.form1.elements[i].name=="UserStatus"){
					document.form1.agtStatus.options[0].selected = true;
					document.form1.angentClass.options[0].selected = true;
					//document.form1.UserStatus.options[0].selected = true;
				}
			}
			document.form1.submit1.disabled=true;
		}

//��̬�ı�ʵ����������
function entryTypeChange()
{
	if (document.form1.entryType.value == 1) 
	{
		entryId.style.display = "";
	}
	if (document.form1.entryType.value == 0||document.form1.entryType.value == '') 
	{
		entryId.style.display = "none";
	}
}

//----����һ����ҳ��ѡ����֯�ڵ�--- ����
function select_groupId()
{
	var path = "/npage/rpt/common/grouptree.jsp?grpId=Entity_groupId&grpName=Entity_groupName&grpType=form1";
    window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}

	function chgSelParterType(){
		var g3role = document.getElementById("g3roleid").value;
		if(g3role=="01"){
			//������
			document.getElementById("parter_row").style.display="block";
		}
		if(g3role=="02"){
			//������
			document.getElementById("parter_row").style.display="none";
			document.getElementById("parterid").value="";
		}
	}
	
	function chgSelParterType(){
		var g3role = document.getElementById("g3roleid").value;
		if(g3role=="01"){
			//������
			document.getElementById("parter_row").style.display="block";
		}
		if(g3role=="02"){
			//������
			document.getElementById("parter_row").style.display="none";
			document.getElementById("parterid").value="";
		}
	}
</script>


</head>
<%//--------------------------------------ҳ������--------------------------------------------%>
<body>
<form name="form1" method="post">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">���г�ֵ������ע��</div>
		</div>
      <table  cellspacing="0">
      	<tr> 
            <td  class="blue" >�����̱��</td>
            <td> 
		<input  type="text"  name="groupId" value="" v_must="1" maxlength="8" readonly class="InputGrey">
            		<input type="button" name="getAgentId" class="b_text" value="��ѯ" onClick="call_getagentId()" >
            		<font class="orange">*</font>
            </td>
            <td class="blue">����������</td>
            <td>
            	<input   type="text"  v_must="1" name="agentName" value="" v_type="string" maxlength="60" >
			<font class="orange">*</font>
            </td>
        </tr>
        <tr> 
            <td  class="blue">�����̵�ַ</td>
            <td> 
			 <input type="text"   v_must="1" name="agentAddress" value="" v_type="string" maxlength="60" size="30" onblur="checkElement(this)">
            		<font class="orange">*</font>
            </td>
            <td class="blue">������״̬</td>
            <td>
            	<select  name="agtStatus" v_must="1"  >
            		<option value=""></option>
            		<option value="Y">��Ч</option>
			<option value="N">��Ч</option>
            	</select>
            </td>
        </tr>
        <tr> 
            <td  class="blue">���д���</td>
            <td> 
			<input   type="text"  v_must="1" name="regionCode"  value="" readonly class="InputGrey">
            		<font class="orange">*</font>
            </td>
            <td class="blue">���ش���</td>
            <td> 
              	<input   type="text"  v_must="1" name="districtCode" value="" readonly class="InputGrey">
		<font class="orange">*</font>
            </td>
        </tr>
        <tr> 
            <td  class="blue">���˴�������</td>
            <td> 
			<input  type="text"  v_must="1" onblur="checkElement(this)" name="legalPresent" value=""  v_type="string" maxlength="60">
            		<font class="orange">*</font>
            </td>
            <td class="blue">���˴������֤��</td>
            <td> 
              	<input  type="text" name="legalId" v_must="1" onblur="checkElement(this)" value="" maxlength="18"  v_type="idcard" onChange="return forIdCard(this)">
			 <font class="orange">*</font>
            </td>
        </tr>
        <tr> 
            <td  class="blue">��������</td>
            <td> 
			  				<select  name="angentClass" v_must="1"  >
			  					<option value=""></option>
			  				<%
			  					for(i=0;i<agentType.length;i++){
			  						if(agentType[i]!=null){
			  						%>	  						
			  							<option value="<%=agentType[i]%>"><%=agentType[i]%>-><%=typeName[i]%></option>
			  					<%}}
			  				%>
			  				</select>
            		<font class="orange">*</font>
            </td>
            <td class="blue">�ʱ�</td>
            <td > 
              	<input  type="text" name="zip" value="" v_must="1" onblur="checkElement(this)" v_type="zip" maxlength="6" onChange="if(forPostCode(this)) return forNonNegInt(this)" v_minlength="6">
		<font class="orange">*</font>
            </td>
        </tr>
        <tr class="blue"> 
            <td  >��ϵ������</td>
            <td> 
			 <input  type="text" name="contactName" v_must="1" onblur="checkElement(this)" v_type="string" value="" maxlength="60" >
            		<font class="orange">*</font>
            </td>
            <td class="blue">��ϵ�����֤</td>
            <td > 
              	<input  type="text" name="contactId" v_must="1" onblur="checkElement(this)" value="" v_type="idcard" maxlength="18"  onChange="return forIdCard(this)">
		<font class="orange">*</font>
            </td>
        </tr>  
        <tr> 
            <td  class="blue">��ϵ�˵绰</td>
            <td> 
			 <input  type="text" name="contactPhone" v_must="1" onblur="checkElement(this)"  value=""  v_type="phone" maxlength="11" onChange="return forTel(this)">
            		<font class="orange">*</font>
            </td>
            <td class="blue">��������</td>
            <td> 
              	<input  type="text" name="bankName" v_must="1" onblur="checkElement(this)" value="" maxlength="60"  v_type="string">
		<font class="orange">*</font>
            </td>
        </tr>
        <tr> 
            <td  class="blue">��Ӧ�ʺ�</td>
            <td> 
			  <input  type="text" name="accountNo"  v_must="1" onblur="checkElement(this)" value="" v_type="0_9" maxlength="20" onChange="return forNonNegInt(this)" >
            		<font class="orange">*</font>
            </td>
            <td class="blue">Ѻ����</td>
            <td> 
              	<input  type="text" name="deposit" maxlength="20" v_type="money" v_must="1" onblur="checkElement(this)"  onChange="return forMoney(this)">
              	<input  type="hidden" name="prepay_fee" v_type="money" value="0.00">
								<font class="orange">*</font>
            </td>
        </tr>
        <tr> 
            <td  class="blue">���ҳߴ�</td>
            <td> 
			  <input  type="text" name="pb_size" v_must="1" onblur="checkElement(this)" maxlength="20"  v_type="0_9" onChange="return forNonNegInt(this)">
            		<font class="orange">*</font>
            </td>
            <td class="blue">ǩԼʱ��</td>
            <td> 
              	<input  type="text" name="signTime" v_must="1"  value="" maxlength="8"  v_type="date" onChange="return forDate(this)" readonly class="InputGrey">
		<font class="orange">*</font>
            </td>
        </tr>
        <tr> 
            <td  class="blue">�����ֻ���</td>
            <td colspan="3"> 
			  <input name="agentPhone" type="text"  id="agentPhone" maxlength="11"  v_type="mobphone" v_must="1" onChange="agentPhoneChange(this)" readonly class="InputGrey">
            		<font class="orange">*</font>
            </td>
        </tr>
        
        
	<tr> 
			<td class="blue">��ֵ�ʻ�����</td>
       <td colspan="3">
				<input name="UserCode" type="text"  v_must="1" id="UserCode" readonly="true" class="InputGrey"  v_type="int" v_must="1" maxlength="11" onChange="UserCodeChange(this)" v_minlength="11">
				<font class="orange">*</font>
	   	</td>      
			<input type="hidden"  name="UserStatus" v_must="1" >						
  </tr>


    <!--wanglz 20141009-->
  	<tr > 
	     <td class="blue" >
	     	�Ƿ�����G3��Ʒ
	     	<select name="is_ghtree">
	     			<option value=""></option>
						<option value='Y'>��</option>
						<option value='N'>��</option>
					</select>
	     	</td>
	     <td class="blue">
					G3����ƽ̨��ɫ����
				<select name="g3roleCode" id="g3roleid" onchange="chgSelParterType()">
					<option value=""></option>
					<option value="01">������</option>
					<option value="02">������</option>
				</select>
		    </td>
	      <td class="blue">��¼�ֻ�����</td>
	      <td>
					<input name="gthree_phone" type="text"  id="gthree_phone"  v_type="string" >
					<font class="orange">*</font>						
		    </td>
    </tr>

		    	<tr id="parter_row" style="display:none;">
		    		<td class="blue">
		    			������
		    		</td>	
		    		
		    			<td>
							<%
								String mysql = "select parter_id,parter_name from dpartermsg where parter_type='06' order by parter_id";
								String outParaNums = "2";
							%>
							<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="<%=outParaNums%>">
								<wtc:sql><%=mysql%></wtc:sql>
								</wtc:pubselect>
							<wtc:array id="retList" scope="end" />
								<select name="parterid" id="parterid">
									<option></option>
									<%
									if(retList!=null&&retList.length>0){
									for(int kkk = 0 ;kkk<retList.length ;kkk++){
									%>
									<option value="<%=retList[kkk][0]%>"><%=retList[kkk][1]%></option>	
									<%}}%>
								</select>
		    		  </td>
		    		  <td></td><td></td>	
		    	</tr>


	<tr > 
					<td class="blue">�����Ƿ�Ϊ��˾��������ʵ������
					</td>
					<td colspan="3"> 
						<select name="entryType" onChange="entryTypeChange()">
						  <option value=""></option>
							<option value="0">��</option>
								<option value="1">��</option>
						</select><font class="orange"> *</font>
					</td>
	</tr>
				
	<tr style="display:none" id="entryId">
					<td class="blue">�����Ӧ����
					</td>
					<td colspan="3">
						<input type="hidden" name="Entity_groupId">
						<input type="text" name="Entity_groupName" value="" v_type="string" maxlength="60" size="40" class="InputGrey" readonly>&nbsp;<font class="orange">*</font>
						<input name="addButton" class="b_text" type="button" value="ѡ��" onClick="select_groupId()" >
					</td>
	</tr>
  
  <tr> 
            <td class="blue">��ע</td>
            <td colspan="3"> 
              <input name="opNote" type="text"  id="opNote" size="50" maxlength="60" readonly class="InputGrey" v_type="string" >
            	<font class="orange">*</font>
            </td>
  </tr>
</table>
    
    <table>
	        <tr> 
	            <td id="footer"> 	             
	                <input name="submit1" class="b_foot"  type="button"  value="ȷ��" onClick="commit()" disabled>
	                &nbsp; 
	                <input name="reset" class="b_foot"  type="button"  value="���" onClick="resetJSP()">
	                &nbsp; 
	                <input name="back"  class="b_foot"  onClick="removeCurrentTab()" type="button"  value="����">	                
	            </td>
	        </tr>  
  	</table>
  	<%@ include file="/npage/include/footer.jsp" %>
  	
</form>
</body>
</html>
