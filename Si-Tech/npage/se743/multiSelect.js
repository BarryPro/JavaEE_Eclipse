(function($) {
    $.fn.multiSelect = function(options) {
          var opts = $.extend({}, $.fn.multiSelect.defaults, options);
          return this.each(function() {
             $this = $(this);
             $.fn.multiSelect.createSelectDiv($this.attr("id"), opts);
         });
     }
 
     //创建div
     $.fn.multiSelect.createSelectDiv = function(select_id, opts) {
         //取得select的jquery对象
         var $obj = $("#" + select_id);
         /*
         //获取select的title值
         var title = $obj.attr("title") == undefined ? opts.titleName : $obj.attr("title");
         */
         //开始构建div
         var div_str = '<div id="' + select_id + '_multiSelect_div" class="select_div" style="position:absolute;height:' + opts.height + 'px;width:' + opts.width + 'px;display:none;top:20px;left:0px;float:left;">';
		 div_str += '<table id="' + select_id + '_table" style="table-layout:auto;border:#d9e9fe 1px solid;" >';
         //创建table内容tr和td
         div_table_trtd = $.fn.multiSelect.createTrTd(select_id, opts);
         div_str += div_table_trtd + '</table><div class="select_div_bottom"><input id="' + select_id + '_ok" type="button" class="b_foot" value="收起"></div></div>';
         //添加到页面上
         $(div_str).appendTo('#' + opts.parentId);
 
         //定义打开函数
         $.fn.multiSelect.opener(select_id, opts);
         //定义div里的checkbox点击事件
         $.fn.multiSelect.checkboxClick(select_id, opts);
         //定义确定按钮的点击事件
         $.fn.multiSelect.okClick(select_id, opts);
     }
 
     $.fn.multiSelect.checkboxClick = function(select_id, opts) {
     	 var sign = opts.sign;
         //获取div的jquery对象
         $obj = $("#" + select_id + "_multiSelect_div :checkbox");
 		
         //定义点击事件
         $obj.click(function() {
 
             //改变背景颜色
             if ($(this).attr("checked")) {
                 $(this).parent().parent().addClass("selected");
             }
             else {
                 $(this).parent().parent().removeClass("selected");
             }
 
             $checked_obj = $("#" + select_id + "_multiSelect_div :checkbox:checked");
 
             var val = '';
         //    var text = '';
             for (var i = 0; i < $checked_obj.length; i++) {
                 val += $checked_obj.eq(i).val() + sign;
         //        text += $checked_obj.eq(i).attr("value") + ";";
             }
             val = val.substr(0, val.length - 1);
         //    text = text.substr(0, text.length - 1);
         //    if (text == "") text = opts.titleName;
             //把值赋给一个控件
             /*
             document.getElementById(opts.hiddenFieldID).value = text;
             if (text.length > 5 && text != opts.titleName) text = text.substr(0, 5) + "..";
             */
             document.getElementById(select_id).value = val;
         });
    }

    //定义确定按钮的点击事件，点击后div消失
    $.fn.multiSelect.okClick = function(select_id, opts) {
        $("#" + select_id + "_ok").click(function() {
            $("#" + select_id + "_multiSelect_div").slideUp("fast", function() {
                $("#" + select_id).css("visibility", "visible");
            });
            $checked_obj = $("#" + select_id + "_multiSelect_div  :checkbox:checked");
 			//liujian add
			 var rstArray = new Array();
             for (var i = 0; i < $checked_obj.length; i++) {
              	 var el = {};//{name:xxx,code:xxx}
                 el.code = $checked_obj.eq(i).val();
                 el.name  = $checked_obj.eq(i).attr("text");
                 rstArray.push(el);
             }
            opts.callBack(rstArray);
        });
    }

    //定义打开div函数
    $.fn.multiSelect.opener = function(select_id, opts) {
        $obj = $("#" + select_id); // + "_open"
        $obj.click(function() {
       	 	$('#' + select_id).val('');
            //todo 关掉所有打开的div
            $('div[id$="_multiSelect_div"]').slideUp('fast');
            $obj.css("visibility", "visible");
            $("#" + select_id + "_multiSelect_div").slideDown('fast');
        });
    }

    //创建tr和td
    $.fn.multiSelect.createTrTd = function(select_id, opts) {
    	var sign = opts.sign;//liujian 2012-8-20 14:57:22 添加分隔符
        var bg_class = "odd";
        var b = opts.arr;
		var oc = opts.chosedArr;
		var trHtml = new Array();
        for (var i = 0; i < b.length; i++) {
        	trHtml.push('<tr class="' + bg_class + '">');
        	trHtml.push('	<td>' + b[i].name + '</td>');
        	var chosedFlag = false;
        	if(oc) {
        		var c = split(oc,sign);
        		for(var j=0,len2=c.length;j<len2;j++) {
					if(b[i].value == c[j]) {
						trHtml.push('	<td class="right_td"><input text="' + b[i].name + '" type="checkbox" checked value="' + b[i].value + '"></td>');
						//删除c的当前元素
						 c.splice(j, 1);
						 var _$select = $('#' + select_id);
						 if(_$select.val() == '请选择' || _$select.val() == '') {
						 	_$select.val(b[i].value);
						 }else {
						 	_$select.val(_$select.val() + sign + b[i].value);
						 }
						 chosedFlag = true;
						break;
					}        		
	        	}
        	}
        	if(!chosedFlag) {
        		trHtml.push('	<td class="right_td"><input text="' + b[i].name + '" type="checkbox" value="' + b[i].value + '"></td>');	
        	}
        	trHtml.push('</tr>');
        }
        if(trHtml.length > 0) {
        	return trHtml.join('');
        }else {
        	return '';
        }
    }


    $.fn.multiSelect.defaults = {
        width: 100,
        height: 100,
        iframe: true,
        titleName: ""
    }

})(jQuery);