<script>
	function addSla(){
		if(g("servsla_name").value == "" || g("servsla_value").value == "" || g("servsla_seq").value == "" || g("servsla_level").value == "" ){
			rdShowMessageDialog("请填写SAL服务信息!",0);	
			return false;
		}
		var colArray = new Array();
		colArray.push(g("servsla_name").value);
		colArray.push(g("servsla_value").value);
		colArray.push(g("servsla_seq").value);
		colArray.push(g("servsla_level").value);
		var v_value=g("servsla_name").value+"~"+g("servsla_value").value+"~"+g("servsla_seq").value+"~"+g("servsla_level").value+"~|";
		g("sla_info").value = g("sla_info").value + v_value;
		colArray.push("<input type='button'  class='b_text' v_value='"+v_value+"' value='删除' onclick='delSla();delTr()'>");
		addTr("tbl_0019","1",colArray,"0|1"); 
		g("servsla_name").value ="";
		g("servsla_value").value ="";
		g("servsla_seq").value ="";
		g("servsla_level").value ="";
	}	
	function delSla(){
		var obj = event.srcElement;
		var slaInfo0 = obj.v_value;
		var slaInfo = g("sla_info").value;
		g("sla_info").value = slaInfo.substring(0,slaInfo.indexOf(slaInfo0))+slaInfo.substring(slaInfo.indexOf(slaInfo0)+slaInfo0.length);
	}
</script>
<div class="title"><div id="title_zi">服务SLA信息</div></div>
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
						<input type="text" name="servsla_name"  id="servsla_name" class="numOrLetter"/>
					</td>
					<td>
					    <input type="text"  name="servsla_value"  id="servsla_value"  class="forInt" />
					</td>
					<td>
					          <input type="text" name="servsla_seq"  id="servsla_seq"  class="forInt"/>
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