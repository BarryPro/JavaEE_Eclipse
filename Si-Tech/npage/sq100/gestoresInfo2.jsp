<TR id="gestoresInfo1" style="display:none"> 
  <TD class="blue" > 
    <div align="left">����������</div>
  </TD>
  <TD> 
    <input id="gestoresName" name="gestoresName" class="button" value="" v_type="string"  maxlength="60" size=20 index="19" v_must='0' v_maxlength=60 onblur="if(checkElement(this)){checkCustNameFunc16New(this,1,0)}">
    <font class=orange>*</font>
    <font class=orange></font>
  </TD>
 <TD class="blue" > 
    <div align="left">��������ϵ��ַ</div>
  </TD>
  <TD> 
    <input id="gestoresAddr" name="gestoresAddr"  class="button" v_must='0' v_type="addrs" size=30 index="21"  onblur="if(checkElement(this)){ checkAddrFunc(this,4,0);}">
    <font class=orange>*</font> </TD>
</TR>
 <tr id="gestoresInfo2" style="display:none"> 
  <td width=16% class="blue" > 
    <div align="left">������֤������</div>
  </td>
  <td id="tdappendSome2" width=34%> 
    <select name="gestoresIdType" id="gestoresIdType" onchange="validateGesIdTypes(this.value)">
    	<option value="0|���֤" selected>���֤</option>
    	<!-- <option value="1|����֤">����֤</option> -->
    	<option value="2|���ڲ�">���ڲ�</option>
    	<option value="3|�۰�ͨ��֤">�۰�ͨ��֤</option>
    	<!-- <option value="4|����֤">����֤</option> -->
    	<option value="5|̨��ͨ��֤">̨��ͨ��֤</option>
    	<option value="6|���������">���������</option>
    	<option value="D|�������֤">�������֤</option>
    </select>
    &nbsp;&nbsp;
    <%if(!"1993".equals(opCode)){%>
    	<input type="button" name="scan_idCard_two3" id="scan_idCard_two3" class="b_text"   value="����" onClick="Idcard_realUser('manage')" style="display:none" />
   		<input type="button" name="scan_idCard_two31" id="scan_idCard_two31" class="b_text"   value="����(2��)" onClick="Idcard2('31')" />
   		<br/>
   		<input type="text" id="sendProjectPhones1"  name="sendProjectPhones1"  value=""  v_minlength=0 v_maxlength=14  v_type="0_9" maxlength="14" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
   		<input type="button" id="sendProjectList1" name="sendProjectList1" class="b_text" value="�·�����" onclick="sendProLists1()"/>
        <input type="button" id="qryListResultBut1" name="qryListResultBut1" class="b_text" value="���������ѯ" onclick="qryListResults1()"/>
   	<%}%>
  </td>
  <td width=16% class="blue" > 
    <div align="left">������֤������</div>
  </td>
  <td width=34%> 
    <input id="gestoresIccId" name="gestoresIccId" v_must='0'  value=""  v_minlength=4 v_maxlength=20 v_type="string"  maxlength="18"    value="" onBlur="if(checkElement(this)){ checkIccIdFunc16New(this,1,0);}">
    <font class=orange>*</font>
    <input type="hidden" name="isSendListFlag1" id="isSendListFlag1" value="N" />
    <input type="hidden" id="isQryListResultFlag1"  name="isQryListResultFlag1"  value="N"  v_minlength=0 v_maxlength=14  v_type="0_9" maxlength="14" />
    </td>
</tr>

<script type="text/javascript">
	//Ĭ�����֤��ʾ
if("<%=opCode%>" != "1993"){
  			$("#scan_idCard_two3").css("display","");
  			$("#scan_idCard_two31").css("display","");
	  		$("input[name='gestoresName']").attr("class","InputGrey");
	  		$("input[name='gestoresName']").attr("readonly","readonly");
	  		$("input[name='gestoresAddr']").attr("class","InputGrey");
	  		$("input[name='gestoresAddr']").attr("readonly","readonly");
	  		$("input[name='gestoresIccId']").attr("class","InputGrey");
	  		$("input[name='gestoresIccId']").attr("readonly","readonly");
	  		$("input[name='gestoresName']").val("");
	  		$("input[name='gestoresAddr']").val("");
	  		$("input[name='gestoresIccId']").val("");
  		}
//�·�����
function sendProLists1(){
	var phonenos=document.all.sendProjectPhones1.value.trim();
	if(phonenos=="") {
			rdShowMessageDialog("�·��������벻��Ϊ�գ�");
			document.all.sendProjectPhones.focus();
			return false;
		}
	if(!checkElement(document.all.sendProjectPhones1)){
    return false;
    }else{	
    
    if(phonenos.substring(0,3)=="209") {
     if(phonenos.length!=14) {
    rdShowMessageDialog("209��ͷ�Ŀ�������Ҫ������209+11λ�ֻ����룬���������룡");
			document.all.sendProjectPhones1.focus();
			return false;
     }
     phonesimstatus=0;
    }else {
    
    	var myPacketsd = new AJAXPacket("/npage/sq100/checkPhoneStatus1.jsp","������֤��SIM���ͣ����Ժ�......");
				myPacketsd.data.add("phoneNo",phonenos);
				core.ajax.sendPacket(myPacketsd,checkphonestatus1);
				myPacketsd=null;
	
    }
    
    if(phonesimstatus!=0) {      
     return false;
    }
		var packet = new AJAXPacket("/npage/sq100/fq100_ajax_sendProLists.jsp","���ڻ�����ݣ����Ժ�......");
		packet.data.add("opCode","<%=opCode%>");
		packet.data.add("phoneNo",phonenos);
		core.ajax.sendPacket(packet,doSendProLists1);
		packet = null;
	}
}

function checkphonestatus1(packet) {
    var simtypesz = packet.data.findValueByName("simtypesz");

 		if(simtypesz=="0") {
 		rdShowMessageDialog("�ú����״̬������������״̬�����������룡");
 		phonesimstatus="1";
 		document.all.sendProjectPhones1.focus();
 		document.all.sendProjectPhones1.select();
 		
 		}
 		else {
 		phonesimstatus="0";
 		}
}
function doSendProLists1(packet){
  	var retCode = packet.data.findValueByName("retCode");
		var retMsg =  packet.data.findValueByName("retMsg");
		if(retCode != "000000"){
			rdShowMessageDialog( "�·�����ʧ��!<br>������룺"+retCode+"<br>������Ϣ��"+retMsg,0 );
			//��¼Ϊû���
			$("#isSendListFlag1").val("N");
		}else{
			rdShowMessageDialog( "�·������ɹ�!",2 );
			//��¼Ϊ���
			$("#isSendListFlag1").val("Y");
		}
  }

//���������ѯ
function qryListResults1(){
	var h=450;
	var w=800;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;status:no;help:no";
	var ret=window.showModalDialog("/npage/sq100/f1100_qryListResults.jsp?opCode=<%=opCode%>&opName=<%=opName%>&accp="+Math.random(),"",prop);
	if(typeof(ret) == "undefined"){
		rdShowMessageDialog("���û�й�����ѯ��������Ƚ����·�����������");
		$("#isQryListResultFlag1").val("N");//ѡ���˹�����ѯ���
	}else if(ret!=null && ret!=""){
		$("#isQryListResultFlag1").val("Y");//ѡ���˹�����ѯ���
		$("#gestoresName").val(ret.split("~")[0]); //�ͻ�����
		$("#gestoresIccId").val(ret.split("~")[1]); //֤������
		if($("#gestoresIccId").val() != ""){
			checkIccIdFunc16New(document.all.gestoresIdType,0,0);
			rpc_chkX('gestoresIdType','gestoresIccId','A');
		}
		$("#gestoresAddr").val(ret.split("~")[2]);  //֤����ַ
		
		$("#gestoresIccId").attr("class","InputGrey");
		$("#gestoresIccId").attr("readonly","readonly");
		$("#gestoresName").attr("class","InputGrey");
		$("#gestoresName").attr("readonly","readonly");
		$("#gestoresAddr").attr("class","InputGrey");
		$("#gestoresAddr").attr("readonly","readonly");	
	}
}
</script>