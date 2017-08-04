<div class="title"><div id="title_zi">服务定单信息</div></div> 
<div class="input">	
<table id="serviceOrderInfoTab">
	<tr>
		<td class="blue"  width=18%> 工单城区标志 </td>
		<td>
			<select name="serviceOrderGroupId" id="serviceOrderGroupId" class="required" >
				<option value="">---请选择---</option>
				<wtc:qoption name="sPubSelect" outnum="2">
					<wtc:sql>select group_id,group_name from dchngroupmsg where erp_code='013' and substr(dist_code,1,2)='<%=regionCode%>'</wtc:sql>
				</wtc:qoption>
			</select>
			<font class="orange">*</font>
		</td>
	</tr> 
</table>
</div>