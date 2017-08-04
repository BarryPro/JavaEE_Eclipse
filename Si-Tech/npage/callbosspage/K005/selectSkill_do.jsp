<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<html>
<head>
<title>选择坐席技能</title>
<script type="text/javascript" language="javascript" src="../../../njs/csp/public.js"></script>
<script language=javascript>
	
	//判断一个字符串是否在数组中出现
function isExit(strData,array){
	if(array!=null){
		for(var j=0;j<array.length;j++){
     		if(strData==array[j]){
     			return true;
     		}
		}
	}
	return false;
}
//从数组中移除某一坐标的值
Array.prototype.remove = function(dx) 
{ 
    if(isNaN(dx)||dx>this.length){return false;} 
    this.splice(dx,1); 
} 
   
//在数组中获取指定值的元素索引   
Array.prototype.getIndexByValue= function(value)  
{  
    var index = -1;  
    for (var i = 0; i < this.length; i++)  
    {  
        if (this[i] == value)  
        {  
            index = i;  
            break;  
        }  
    }  
    return index;  
}  
	
	
	var arrnew=new Array();
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
				//tr.insertCell().innerHTML='<input name="skillitem" type="checkbox" id="'+retData[i][0]+'"  value="'+retData[i][1]+'" checked />';
				//tr.insertCell().innerHTML=retData[i][1];
				tr.insertCell().appendChild(document.createElement('<input name="skillitem" type="checkbox" id="'+retData[i][0]+'"  value="'+retData[i][1] + '>'));
				appendText(tr.insertCell(),retData[i][1],null,0);
			}
		}
		
		window.onload = function(){
				findSkillList();
				defaultSelect();
		}
		
		function defaultSelect(){
			var skillListStr = parent_win.skillListStr;
			if(!skillListStr || skillListStr == "")
				return;
			var checkAllB = document.getElementById("checkAll");
			if(skillListStr == ""){
				selectAll();
			}else{
				//checkAllB.checked=false;
				var skillList=skillListStr.split(",");
				var allSelected = false;
				var checkBoxItems = document.getElementsByTagName("input");
				for(var i = 0; i < skillList.length ;i++){
					for(var j = 0;j< checkBoxItems.length; j++){
						if(checkBoxItems[j] && checkBoxItems[j].type == 'checkbox' && checkBoxItems[j].id == skillList[i])
							checkBoxItems[j].checked = true;
					}
				}
			}
		}

		function ischeckBoxSelect(Arr){
			var flag = 1;
			if(Arr !=="" && Arr !=null){
				var str = Arr.split(",");
				var checkBoxItems = document.getElementsByTagName("input");  	
				for(var i=0;i<checkBoxItems.length;i++){
						
					if(checkBoxItems[i].type=='checkbox')
					{
						//checkBoxItems[i].checked=false;
						if("checkAll" == checkBoxItems[i].id)
						{
							continue;
						}
						for (var j=0;j<str.length-1;j++)
						{
								if(str[j]==checkBoxItems[i].id){
									checkBoxItems[i].checked=true;
									arrnew.push(checkBoxItems[i].id);
								 
								}
						}
					}
				}
			}
		}
		
		
		function ischeckBoxNoSelect(Arr){
			var flag = 1;
			if(Arr !=="" && Arr !=null){
				var str = Arr.split(",");
				var checkBoxItems = document.getElementsByTagName("input");  	
				for(var i=0;i<checkBoxItems.length;i++){
						
					if(checkBoxItems[i].type=='checkbox')
					{
						//checkBoxItems[i].checked=false;
						if("checkAll" == checkBoxItems[i].id)
						{
							continue;
						}
						for (var j=0;j<str.length-1;j++)
						{
								if(str[j]==checkBoxItems[i].id){
									if(arrnew.length>0){
									var dx=arrnew.getIndexByValue(checkBoxItems[i].id);
									arrnew.remove(dx);
				
									if(isExit(checkBoxItems[i].id,arrnew)){
										  checkBoxItems[i].checked=true;
										}else{
											checkBoxItems[i].checked=false;
											}
									}else{
										checkBoxItems[i].checked=false;
										}
								}
						}
					}
				}
			}
		}
</script>

</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<table id="sQryCnttOnlyTable">
			<tr>
			<td>
		      <input name="trans" type="button" class="b_text"  id="trans" value=" 确定 " onClick="confirmClick()">
		      <input name="delete" type="button" class="b_text"  id="delete" value=" 关闭 " onClick="cancelClick()">	
		    </td>
		  </tr>
		</table>	
		<table id="ddtable">
			<tr>
  		<td width="20%">
      <input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="selectAll('skillitem')"/>全选
      </td>
  		<td width="75%">
       技能名称
	  	</td>
			</tr>
		</table>	
		<table id="dataTable" >
			
		</table>	
	
	</div>
</form>
</body>
</html>