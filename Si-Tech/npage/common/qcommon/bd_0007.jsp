<%
/*
 * ����: ��ע��Ϣ
 * �汾: v1.0
 * ����: 2009/01/19
 * ����: wanglj
 * ��Ȩ: sitech
 * �޸���ʷ
 * �޸�����      �޸���      �޸�Ŀ��
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
					<td class="blue"  width=18%>ϵͳ��ע</td>
					<td>
							<input type="text" size="100"  value="" maxlength="60" onkeyup="stopSpe(this)" readonly class="isLengthOf haveSpe" v_maxlength="60" name="sys_note" id="sys_note" />
					</td>					 
				</tr>
				<tr>
					<td class="blue"  width=18%><span id="bd_0007_opnote">�û���ע</span></td>
					<td>
							<input type="text" size="100"  value=""  maxlength="60" onkeyup="stopSpe(this)" class="isLengthOf haveSpe" v_maxlength="60" name="op_note" id="op_note"/>
					</td>
				</tr>				 
			</table>
		</div>		 


