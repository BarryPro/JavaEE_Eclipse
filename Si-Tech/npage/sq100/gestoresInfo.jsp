<TR id="gestoresInfo1" style="display:none"> 
  <TD class="blue" > 
    <div align="left">经办人姓名</div>
  </TD>
  <TD> 
    <input name="gestoresName" class="button" value="" v_type="string"  maxlength="60" size=20 index="19" v_must='0' v_maxlength=60 onblur="if(checkElement(this)){checkCustNameFunc16New(this,1,0)}">
    <font class=orange>*</font>
    <font class=orange></font>
  </TD>
 <TD class="blue" > 
    <div align="left">经办人联系地址</div>
  </TD>
  <TD> 
    <input name="gestoresAddr"  class="button" v_must='0' v_type="addrs" size=30 index="21"  onblur="if(checkElement(this)){ checkAddrFunc(this,4,0);}">
    <font class=orange>*</font> </TD>
</TR>
 <tr id="gestoresInfo2" style="display:none"> 
  <td width=16% class="blue" > 
    <div align="left">经办人证件类型</div>
  </td>
  <td id="tdappendSome2" width=34%> 
    <select name="gestoresIdType" id="gestoresIdType" onchange="validateGesIdTypes(this.value)">
    	<option value="0|身份证" selected>身份证</option>
    	<!-- <option value="1|军官证">军官证</option> -->
    	<option value="2|户口簿">户口簿</option>
    	<option value="3|港澳通行证">港澳通行证</option>
    	<!-- <option value="4|警官证">警官证</option> -->
    	<option value="5|台湾通行证">台湾通行证</option>
    	<option value="6|外国公民护照">外国公民护照</option>
    	<option value="D|军人身份证">军人身份证</option>
    </select>
    &nbsp;&nbsp;
    <%if(!"1993".equals(opCode)){%>
    	<input type="button" name="scan_idCard_two3" id="scan_idCard_two3" class="b_text"   value="读卡" onClick="Idcard_realUser('manage')" style="display:none" />
   		<input type="button" name="scan_idCard_two31" id="scan_idCard_two31" class="b_text"   value="读卡(2代)" onClick="Idcard2('31')" />
   	<%}%>
  </td>
  <td width=16% class="blue" > 
    <div align="left">经办人证件号码</div>
  </td>
  <td width=34%> 
    <input name="gestoresIccId"  id="gestoresIccId" v_must='0'  value=""  v_minlength=4 v_maxlength=20 v_type="string"  maxlength="18"    value="" onBlur="if(checkElement(this)){ checkIccIdFunc16New(this,1,0);}">
    <font class=orange>*</font>
    </td>
</tr>

<script>
	//默认身份证显示
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
</script>