<tr>
	<td  class="blue">�Ƿ�ʹ�û���</td>
	<td colspan="5">
		<input type="checkbox" name="ifUseIntegral" id="ifUseIntegral" value="" onclick="ifUseIntegralBtn();"/>
	</td>	
</tr>
<tbody id="IntegralFiled" style="display:none">
<tr >
	<td  class="blue">�ֻ�����</td>
	<td ><input type="text" name="intePhoneNo" id="intePhoneNo" value=""/><font class="orange">*</font></td>	
	<td  class="blue">��������</td>
	<td >
		<input type="password" name="intePassWord" id="intePassWord" value=""/><font class="orange">*</font>
		<input type="button" class="b_text" name="inteValide" id="inteValide" value="У��" onclick="getIntegral();"/>
	</td>
	<td  class="blue">�ͻ�����</td>
	<td ><input type="text" name="inteCustName" id="inteCustName" value="" class="InputGrey" readonly/></td>
</tr>
<tr >
	<td class="blue">��ǰ���û���</td>
	<td><input type="text" name="inteNumber" id="inteNumber" value="" class="InputGrey" readonly/></td>	
	<td class="blue">����ֵ</td>
	<td><input type="text" name="inteUseNum" id="inteUseNum" v_type="0_9" onblur="checkIngegralNum();" value=""/><font class="orange">*</font></td>
	<td class="blue">�ֿ۽��</td>
	<td><input type="text" name="intePrice" id="intePrice" value="" class="InputGrey" readonly/></td>
	<!--������ �洢���ֿ۽�� -->
	<input type="hidden" name="maxIntegralNum" id="maxIntegralNum" value="" />
</tr>
</tbody>
