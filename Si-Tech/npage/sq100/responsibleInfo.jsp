<TR id="responsibleInfo1" style="display:none"> 
  <TD class="blue" > 
    <div align="left">����������</div>
  </TD>
  <TD> 
    <input name="responsibleName" class="button" value="" v_type="string"  maxlength="60" size=20 index="19" v_must='0' v_maxlength=60 onblur="if(checkElement(this)){checkCustNameFunc16New(this,2,0)}">
    <font class=orange>*</font>
    <font class=orange></font>
  </TD>
 <TD class="blue" > 
    <div align="left">��������ϵ��ַ</div>
  </TD>
  <TD> 
    <input name="responsibleAddr"  class="button" v_must='0' v_type="addrs" size=30 index="21"  onblur="if(checkElement(this)){ checkAddrFunc(this,5,0);}">
    <font class=orange>*</font> </TD>
</TR>
 <tr id="responsibleInfo2" style="display:none"> 
  <td width=16% class="blue" > 
    <div align="left">������֤������</div>
  </td>
  <td id="tdappendSome2" width=34%> 
    <select name="responsibleType" id="responsibleType" onchange="validateresponIdTypes(this.value)">
    	<option value="0|���֤" selected>���֤</option>
    	<!-- <option value="1|����֤">����֤</option> -->
    	<option value="2|���ڲ�">���ڲ�</option>
    	<option value="3|�۰�ͨ��֤">�۰�ͨ��֤</option>
    	<!-- <option value="4|����֤">����֤</option> -->
    	<option value="5|̨��ͨ��֤">̨��ͨ��֤</option>
    	<option value="6|���������">���������</option>
    </select>
    &nbsp;&nbsp;
    
    	<input type="button" name="scan_idCard_two3zrr" id="scan_idCard_two3zrr" class="b_text"   value="����" onClick="Idcard_realUser('zerenren')" style="display:none" />
   		<input type="button" name="scan_idCard_two57zrr" id="scan_idCard_two57zrr" class="b_text"   value="����(2��)" onClick="Idcard2('57')" />
   	
  </td>
  <td width=16% class="blue" > 
    <div align="left">������֤������</div>
  </td>
  <td width=34%> 
    <input name="responsibleIccId"  id="responsibleIccId" v_must='0'  value=""  v_minlength=4 v_maxlength=20 v_type="string"  maxlength="18"    value="" onBlur="if(checkElement(this)){ checkIccIdFunc16New(this,2,0);}">
    <font class=orange>*</font>
    </td>
</tr>