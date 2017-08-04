<%System.out.println("----------------------------agentInfo.jsp------------------------------------");  %>
		<div class="title"  id="agentTitleDiv" >
	<div id="title_zi">代理商信息</div>
</div>

<div class="input">	
<table id="agentInfoTab">
	<tr>
		<td class="blue">代收费商</td>
		<td>
			<input type="text" name="text_chargeGroupId" id="900d" />
			<select name="chargeGroupId" id="chargeGroupId" ></select>
		</td>
		<td class="blue">代安装商</td>
		<td>
			<input type="text" name="text_installGroupId" id="900f" />
			<select name="installGroupId" id="installGroupId"></select>
		</td>
	</tr> 
	<tr>	
		<td class="blue">代维护商</td>
		<td>
			<input type="text" name="text_maintGroupId" id="900c" />
			<select name="maintGroupId" id="maintGroupId"></select>
		</td>
		<td class="blue">代发展商</td>
		<td>
			<input type="text" name="text_devGroupId" id="900b" />
			<select name="devGroupId" id="devGroupId"></select>
		</td>										
	</tr>				 			 
</table>
</div>