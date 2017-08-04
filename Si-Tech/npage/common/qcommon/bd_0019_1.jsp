<script>
	function addSla(){
		var colArray = new Array();
		colArray.push(g("servsla_name").value);
		colArray.push(g("servsla_value").value);
		colArray.push(g("servsla_seq").value);
		colArray.push(g("servsla_level").value);
		var v_value=g("servsla_name").value+"~"+g("servsla_value").value+"~"+g("servsla_seq").value+"~"+g("servsla_level").value+"~|";
		g("sla_info").value = g("sla_info").value + v_value;
		colArray.push("<input type='button'  class='b_text' v_value='"+v_value+"' value='删除' onclick='delSla();delTr()'>");
		addTr("tbl_0019","1",colArray,"0|1"); 
	}	
	function delSla(){
		var obj = event.srcElement;
		var slaInfo0 = obj.v_value;
		var slaInfo = g("sla_info").value;
		alert(g("sla_info").value);
		g("sla_info").value = slaInfo.substring(0,slaInfo.indexOf(slaInfo0))+slaInfo.substring(slaInfo.indexOf(slaInfo0)+slaInfo0.length);
		alert(g("sla_info").value);
	}
</script>
<div class="title"><div class="text">服务SLA信息</div></div>
<div class="list">
	<table id="tbl_0019">
		<tr>
			<th>指标名称</th>
			<th>指标值</th>
			<th>指标序号</th>
			<th>服务水平条款</th>
			<th>操作</th>
		</tr>
		<tr>
					<td>
						<input type="text" name="servsla_name"  id="servsla_name" class="required numOrLetter"/>
					</td>
					<td>
					    <input type="text"  name="servsla_value"  id="servsla_value"  class="required forInt" />
					</td>
					<td>
					          <input type="text" name="servsla_seq"  id="servsla_seq"  class="required forInt"/>
					</td> 
					<td>
					          <input type="text" class="notNegReal" id="servsla_level"  name="servsla_level"/>
					</td>	
					<td>
					          <input type="button" class="b_text" name="add_sla" value="添加" onclick="addSla()"/>
					</td>				
				</tr>				 			 
			</table>
			<input type="hidden" name="sla_info" value="">
</div>