<%
/*
 * 功能: 备注信息
 * 版本: v1.0
 * 日期: 2009/01/19
 * 作者: wanglj
 * 版权: sitech
 * 修改历史
 * 修改日期      修改人      修改目的
 */
%> 
	<script>
	function stopSpe(ele)
	{
		var b=ele.value;
		if(/[^0-9a-zA-Z\u4E00-\u9FA5]/.test(b)) ele.value=ele.value.replace(/[^0-9a-zA-Z\u4E00-\u9FA5]/g,'');
	}
	</script>
		<div class="input">	
			<table>
				<tr>
					<td class="blue"  width=18%>系统备注</td>
					<td>
							<input type="text" size="100"  value="" maxlength="60" onkeyup="stopSpe(this)" readonly class="isLengthOf haveSpe" v_maxlength="60" name="sys_note" id="sys_note" />
					</td>					 
				</tr>
				<tr>
					<td class="blue"  width=18%><span id="bd_0007_opnote">用户备注</span></td>
					<td>
							<input type="text" size="100"  value=""  maxlength="60" onkeyup="stopSpe(this)" class="isLengthOf haveSpe" v_maxlength="60" name="op_note" id="op_note"/>
					</td>
				</tr>				 
			</table>
		</div>		 


