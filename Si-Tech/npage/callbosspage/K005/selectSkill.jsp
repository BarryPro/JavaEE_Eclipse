<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<html>
<head>
<title>选择坐席技能</title>

<script language=javascript>
	  var parent_win = window.dialogArguments;
		function selectAll(){
			var checkAllB = document.getElementById("checkAll");
			var allSelected = checkAllB.checked;
			var checkBoxItems = document.getElementsByTagName("input");  	
			for(var i=0;i<checkBoxItems.length;i++){
				if(checkBoxItems[i].type=='checkbox'){
						checkBoxItems[i].checked=allSelected;
				}
			}
		}
		function confirmClick(){
			var checkBoxItems = document.getElementsByTagName("input"); 
			var needChange =false; 	
			var skillCount = 0;
			var skillStr = '';
			var skillNameStr = '';
			for(var i=0;i<checkBoxItems.length;i++){
				if(checkBoxItems[i].type=='checkbox'&&checkBoxItems[i].name=='skillitem'){
						if(checkBoxItems[i].checked){
							  if(skillCount>0){
							  	skillStr += ',';
							  	skillNameStr += ',';
							  }
							  skillStr += checkBoxItems[i].id;		
							  skillNameStr += checkBoxItems[i].value;						
								skillCount++;	
						}else{
								needChange = true;
						}
				}
			}
			if(skillCount<1){
					rdShowMessageDialog('请至少选择一项技能',2);	
					return;
			}
			parent_win.cancelSignIn = 0;
			if(needChange){
					parent_win.needChangeSkill = 1;
					
					parent_win.skillListStr = skillStr;
					parent_win.skillListNameStr = skillNameStr;
			}
			window.close();
		}
		function cancelClick(){
			window.close();
		}
		function findSkillList(){
			var retData = parent_win.cCcommonTool.getAllSkillInfoEx();
			var tableid = document.getElementById('ddtable');
			for(var i=0;i<retData.length;i++){
				var tr=tableid.insertRow();
				tr.insertCell().innerHTML='<input name="skillitem" type="checkbox" id="'+retData[i][0]+'"  value="'+retData[i][1]+'" checked />';
				tr.insertCell().innerHTML=retData[i][1]; 
			}
		}
		window.onload = function(){
				findSkillList();
		}

</script>

</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<table id="ddtable">
			<tr>
  		<td width="20%">
      <input type="checkbox" id="checkAll" name="checkbox" value="checkbox" checked onclick="selectAll('skillitem')"/>全选
      </td>
  		<td width="75%">
       技能名称
	  	</td>
			</tr>
		</table>	
		<table id="dataTable" >
			
		</table>	
		<table id="sQryCnttOnlyTable">
			<tr>
			<td>
		      <input name="trans" type="button" class="b_text"  id="trans" value=" 确定 " onClick="confirmClick()">
		      <input name="delete" type="button" class="b_text"  id="delete" value=" 关闭 " onClick="cancelClick()">	
		    </td>
		  </tr>
		</table>	
	</div>
</form>
</body>
</html>