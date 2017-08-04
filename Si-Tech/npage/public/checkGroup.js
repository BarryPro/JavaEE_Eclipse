var Pz;
specialGroupTitle = new Array();
specialGroupMin = new Array();
specialGroupMax = new Array();
if(!Pz) {
	Pz = {};
}
Pz.busi = function() {
	function operBusi($obj,attr,canMutli,num) {
		//要统一放置组标识的属性，默认为title
		attr = attr || "groupTitle";
		
		$obj.parent().mousemove(function(){
	       	mouseOverListener($(this),attr);
	    }).mouseout(function(){
	        mouseOutListener($(this),attr);
	    });
	}
	
	
	function mouseOverListener($obj,attr) {
		var _obj = $obj;
		attr = attr || "groupTitle";
		var groupId = $obj.find('input').attr(attr);
		if($.trim(groupId) !== "") {
			_obj.parent().parent().find('input[@groupTitle="' + groupId + '"]').parent().css('background-color','#D7EDFA');
		}else {
			_obj.css('background-color','#D7EDFA');
		}
		
	}
	
	function mouseOutListener($obj,attr) {
		var _obj = $obj;
		attr = attr || "groupTitle";
		var groupId = _obj.find('input').attr(attr);
		if($.trim(groupId) !== "") {
			_obj.parent().parent().find('input[@groupTitle="' + groupId + '"]').parent().css('background-color','');
		}else {
			_obj.css('background-color','');
		}
	}
	return {
		operBusi : operBusi
	}
}();

function clickListener($obj,attr,canMutli){
		var _obj = $obj;
		var retFlag = true;
		if(_obj.attr("checked")){
			var groupId = _obj.attr(attr);
			var strNum = findStrNumInArr(groupId,specialGroupTitle);
			var maxnum ;
			if(strNum >= 0){
				maxnum = specialGroupMax[strNum];
			}else{
				maxnum = $obj.parent().parent().find('input[@groupTitle="' + groupId + '"]').attr("maxNum");
			}
			if($.trim(groupId) !== "" && !checkGroup(_obj,groupId,canMutli,maxnum)) {
					retFlag = false;
				  rdShowMessageDialog("该组最多允许选择" + maxnum + "个");
				  showFadeTo($obj,groupId);
			}
		}
		return retFlag;
	}
	
	function checkGroup($obj,groupId,canMutli,num){
		var isChecked = false;
		var len = $obj.parent().parent().find('input[@groupTitle="' + groupId + '"][checked]').length;

		if(canMutli) {
			if(len > num) {
				return false;
			}
		}else {
			if(len > 1) {
				return false;
			}
		}
		return true;
	}
	function findStrNumInArr(str1,arrObj){
		var reFlag = -1;
		$.each(arrObj,function(i,n){
			if(n == str1){
				reFlag = i;
			}
		});
		return reFlag;
	}

	function checkmin($obj,attr){
		var _obj = $obj;
		attr = attr || "groupTitle";
		var returnFlag = true;
		$.each(_obj,function(i,val){
			if(returnFlag){
				var minnum = $(val).attr("minNum");
				var groupPart = $(val).attr(attr);
				var len = $obj.parent().parent().find('input[@groupTitle="' + groupPart + '"][checked]').length;
				if(len < minnum){
					rdShowMessageDialog("该组最少选择" + minnum + "个");
					returnFlag = false;
					showFadeTo($obj,groupPart);
				}
			}
		});
		return returnFlag;
	}

function showFadeTo($obj,groupPart){
	$obj.parent().parent().find('input[@groupTitle="' + groupPart + '"]').fadeTo("slow",0.25,function(){
		$obj.parent().parent().find('input[@groupTitle="' + groupPart + '"]').parent().css('background-color','#FD7829');
		$obj.parent().parent().find('input[@groupTitle="' + groupPart + '"]').fadeTo("slow",1,function(){
			$obj.parent().parent().find('input[@groupTitle="' + groupPart + '"]').parent().css('background-color','');
		});
	});
}
function setSpecialGroup(groupTitle,minNum,maxNum){
		var len = specialGroupTitle.length;
		specialGroupTitle[len] = groupTitle;
		specialGroupMin[len] = minNum;
		specialGroupMax[len] = maxNum;
		
	}