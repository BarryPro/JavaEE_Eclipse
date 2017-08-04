<TR id="responsibleInfo1" style="display:none"> 
  <TD class="blue" > 
    <div align="left">责任人姓名</div>
  </TD>
  <TD> 
    <input name="responsibleName" class="button" value="" v_type="string"  maxlength="60" size=20 index="19" v_must='0' v_maxlength=60 onblur="if(checkElement(this)){checkCustNameFunc16New(this,2,0)}">
    <font class=orange>*</font>
    <font class=orange></font>
  </TD>
 <TD class="blue" > 
    <div align="left">责任人联系地址</div>
  </TD>
  <TD> 
    <input name="responsibleAddr"  class="button" v_must='0' v_type="addrs" size=30 index="21"  onblur="if(checkElement(this)){ checkAddrFunc(this,5,0);}">
    <font class=orange>*</font> </TD>
</TR>
 <tr id="responsibleInfo2" style="display:none"> 
  <td width=16% class="blue" > 
    <div align="left">责任人证件类型</div>
  </td>
  <td id="tdappendSome2" width=34%> 
    <select name="responsibleType" id="responsibleType" onchange="validateresponIdTypes(this.value)">
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
   	
  </td>
  <td width=16% class="blue" > 
    <div align="left">责任人证件号码</div>
  </td>
  <td width=34%> 
    <input name="responsibleIccId"  id="responsibleIccId" v_must='0'  value=""  v_minlength=4 v_maxlength=20 v_type="string"  maxlength="18"    value="" onBlur="if(checkElement(this)){ checkIccIdFunc16New(this,2,0);}">
    <font class=orange>*</font>
    </td>
</tr>