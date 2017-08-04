
function showDateWithTime(node){
	//alert(node.value);
	//var dateArrays = node.value.split(' ')[0].split('-');
	//for(var i = 0; i < dateArrays.length; i ++){
	//	alert(dateArrays[i]);
	//}
	var s = "dateWithTime.jsp";
	var ret = window.showModalDialog(s,node.value,"dialogWidth:220px;dialogHeight:280px;center:1;dialogtop:"+   event.screenY+";dialogleft:"   +   event.screenX);
	
	if(String(ret) != "undefined" && ret != "$$$") node.value = ret;
}
