<TR id="responsibleInfo1" style="display:none"> 
  <TD class="blue" > 
    <div align="left">责任人姓名</div>
  </TD>
  <TD> 
    <input id="responsibleName" name="responsibleName" class="button" value="" v_type="string"  maxlength="60" size=20 index="19" v_must='0' v_maxlength=60 onblur="if(checkElement(this)){checkCustNameFunc16New(this,2,0)}">
    <font class=orange>*</font>
    <font class=orange></font>
  </TD>
 <TD class="blue" > 
    <div align="left">责任人联系地址</div>
  </TD>
  <TD> 
    <input id="responsibleAddr" name="responsibleAddr"  class="button" v_must='0' v_type="addrs" size=30 index="21"  onblur="if(checkElement(this)){ checkAddrFunc(this,5,0);}">
    <font class=orange>*</font> </TD>
</TR>
 <tr id="responsibleInfo2" style="display:none"> 
  <td width=16% class="blue" > 
    <div align="left">责任人证件类型</div>
  </td>
  <td id="tdappendSome2" width=34%> 
    <select id="responsibleType" name="responsibleType" onchange="validateresponIdTypes(this.value)">
    	<option value="0|身份证" selected>身份证</option>
    	<!-- <option value="1|军官证">军官证</option> -->
    	<option value="2|户口簿">户口簿</option>
    	<option value="3|港澳通行证">港澳通行证</option>
    	<!-- <option value="4|警官证">警官证</option> -->
    	<option value="5|台湾通行证">台湾通行证</option>
    	<option value="6|外国公民护照">外国公民护照</option>
    </select>
    &nbsp;&nbsp;
    	<input type="button" name="scan_idCard_two3zrr" id="scan_idCard_two3zrr" class="b_text"   value="读卡" onClick="Idcard_realUser('zerenren')" style="display:none" />
   		<input type="button" name="scan_idCard_two57zrr" id="scan_idCard_two57zrr" class="b_text"   value="读卡(2代)" onClick="Idcard2('57')" />
   		<input type="button" id="sendProjectList2" name="sendProjectList2" class="b_text" value="下发工单" onclick="sendProLists2()"/>
        <input type="button" id="qryListResultBut2" name="qryListResultBut2" class="b_text" value="工单结果查询" onclick="qryListResults2()"/>
  </td>
  <td width=16% class="blue" > 
    <div align="left">责任人证件号码</div>
  </td>
  <td width=34%> 
    <input id="responsibleIccId" name="responsibleIccId" v_must='0'  value=""  v_minlength=4 v_maxlength=20 v_type="string"  maxlength="18"    value="" onBlur="if(checkElement(this)){ checkIccIdFunc16New(this,2,0);}">
    <font class=orange>*</font>
    <input type="hidden" name="isSendListFlag2" id="isSendListFlag2" value="N" />
    <input type="hidden" id="isQryListResultFlag2"  name="isQryListResultFlag2"  value="N"  v_minlength=0 v_maxlength=14  v_type="0_9" maxlength="14" />
    </td>
</tr>
<script type="text/javascript">
//下发工单
function sendProLists2(){
	var phonenos=document.all.sendProjectPhones1.value.trim();
	if(phonenos=="") {
			rdShowMessageDialog("开户号码不能为空！");
			document.all.sendProjectPhones1.focus();
			return false;
		}
	if(!checkElement(document.all.sendProjectPhones1)){
    return false;
    }else{	
    
    if(phonenos.substring(0,3)=="209") {
     if(phonenos.length!=14) {
    rdShowMessageDialog("209开头的开户号码要求输入209+11位手机号码，请重新输入！");
			document.all.sendProjectPhones1.focus();
			return false;
     }
     
     phonesimstatus=0;
    
    }else {
    
    	var myPacketsd = new AJAXPacket("/npage/sq100/checkPhoneStatus.jsp","正在验证新SIM类型，请稍候......");
				myPacketsd.data.add("phoneNo",phonenos);
				core.ajax.sendPacket(myPacketsd,checkphonestatus2);
				myPacketsd=null;
	
    }
    
    if(phonesimstatus!=0) {      
     return false;
    }
		var packet = new AJAXPacket("/npage/sq100/fq100_ajax_sendProLists.jsp","正在获得数据，请稍候......");
		packet.data.add("opCode","<%=opCode%>");
		packet.data.add("phoneNo",phonenos);
		core.ajax.sendPacket(packet,doSendProLists2);
		packet = null;
		
			}
}

function checkphonestatus2(packet) {
    var simtypesz = packet.data.findValueByName("simtypesz");

	if(simtypesz=="0") {
		rdShowMessageDialog("该号码的状态不是允许开户的状态，请重新输入！");
		phonesimstatus="1";
		document.all.sendProjectPhones1.focus();
		document.all.sendProjectPhones1.select();
	}
	else {
		phonesimstatus="0";
	}
}
function doSendProLists2(packet){
  	var retCode = packet.data.findValueByName("retCode");
		var retMsg =  packet.data.findValueByName("retMsg");
		if(retCode != "000000"){
			rdShowMessageDialog( "下发工单失败!<br>错误代码："+retCode+"<br>错误信息："+retMsg,0 );
			//记录为没点击
			$("#isSendListFlag2").val("N");
		}else{
			rdShowMessageDialog( "下发工单成功!",2 );
			//记录为点击
			$("#isSendListFlag2").val("Y");
		}
  }

//工单结果查询
function qryListResults2(){
	var h=450;
	var w=800;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;status:no;help:no";
	var ret=window.showModalDialog("/npage/sq100/f1100_qryListResults.jsp?opCode=<%=opCode%>&opName=<%=opName%>&accp="+Math.random(),"",prop);
	if(typeof(ret) == "undefined"){
		rdShowMessageDialog("如果没有工单查询结果，请先进行下发工单操作！");
		$("#isQryListResultFlag2").val("N");//选择了工单查询结果
	}else if(ret!=null && ret!=""){
		$("#isQryListResultFlag2").val("Y");//选择了工单查询结果
		$("#responsibleName").val(ret.split("~")[0]); //客户姓名
		$("#responsibleIccId").val(ret.split("~")[1]); //证件号码
		if($("#responsibleIccId").val() != ""){
			checkIccIdFunc16New(document.all.responsibleIccId,0,0);
			rpc_chkX('responsibleType','responsibleIccId','A');
		}
		$("#responsibleAddr").val(ret.split("~")[2]);  //证件地址
		
		$("#responsibleIccId").attr("class","InputGrey");
		$("#responsibleIccId").attr("readonly","readonly");
		$("#responsibleName").attr("class","InputGrey");
		$("#responsibleName").attr("readonly","readonly");
		$("#responsibleAddr").attr("class","InputGrey");
		$("#responsibleAddr").attr("readonly","readonly");	
	}
}
</script>