function check_all(b_name,v){
	var list=document.getElementsByName(b_name);
	if(list!=undefined){	
		if(list.length!=undefined){
			for(i=0;i<list.length;i++){
			if(list[i].disabled==false){
				list[i].checked=v;
				}
			}
		}else{
			if(list.disabled==false){
				list.checked=v;
				}
			}
		}
}

function isCheckAll(b_name,obj){
	if(!obj.checked){
		document.getElementById(b_name).checked = false;
	}else{
		var list=document.getElementsByName(obj.name);
		var all_num = list.length;
		var check_num = 0;
		for(i=0;i<list.length;i++){
			if(list[i].checked){
				check_num++;
			}
		}
		if(all_num == check_num){
			document.getElementById(b_name).checked = true;
		}
	}
}
//ȥ��ո�;
function ltrim(s){
    return s.replace( /^\s*/, "");
}

//ȥ�ҿո�;
function rtrim(s){
    return s.replace( /\s*$/, "");
}

//ȥ���ҿո�;
function trim(s){
    return rtrim(ltrim(s));
}