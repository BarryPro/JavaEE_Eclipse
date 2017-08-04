<tr>
	<td  class="blue">是否使用积分</td>
	<td colspan="5">
		<input type="checkbox" name="ifUseIntegral" id="ifUseIntegral" value="" onclick="ifUseIntegralBtn();"/>
	</td>	
</tr>
<tbody id="IntegralFiled" style="display:none">
<tr >
	<td  class="blue">手机号码</td>
	<td ><input type="text" name="intePhoneNo" id="intePhoneNo" value=""/><font class="orange">*</font></td>	
	<td  class="blue">服务密码</td>
	<td >
		<input type="password" name="intePassWord" id="intePassWord" value=""/><font class="orange">*</font>
		<input type="button" class="b_text" name="inteValide" id="inteValide" value="校验" onclick="getIntegral();"/>
	</td>
	<td  class="blue">客户名称</td>
	<td ><input type="text" name="inteCustName" id="inteCustName" value="" class="InputGrey" readonly/></td>
</tr>
<tr >
	<td class="blue">当前可用积分</td>
	<td><input type="text" name="inteNumber" id="inteNumber" value="" class="InputGrey" readonly/></td>	
	<td class="blue">积分值</td>
	<td><input type="text" name="inteUseNum" id="inteUseNum" v_type="0_9" onblur="checkIngegralNum();" value=""/><font class="orange">*</font></td>
	<td class="blue">抵扣金额</td>
	<td><input type="text" name="intePrice" id="intePrice" value="" class="InputGrey" readonly/></td>
	<!--隐藏域 存储最大抵扣金额 -->
	<input type="hidden" name="maxIntegralNum" id="maxIntegralNum" value="" />
</tr>
</tbody>
