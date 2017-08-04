<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>省市联动</title>
<script type="text/javascript" src="js/jquery-1.11.0.js"></script>
<script type="text/javascript">
	$(function(){
		$("#pro").change(function(){
			$("#city option").remove();
			$.ajax({
				url:"ProControl",
				type:"post",
				data:"proid="+this.value,//得到下拉框的值
				dataType:"text json",
				success:function(data){
					$(data).each(function(index){//index维数组的下标						
						$("#city").append("<option value='"+data[index].no+"'>"+data[index].name+"</option>");
					});
				}
			});
		});
	});
</script>
</head>
<body>
	<select id="pro">
		<optgroup label="东北">
			<option value="hlj">黑龙江</option>
			<option value="jl">吉林</option>
			<option value="ln">辽宁</option>
		</optgroup>
		<optgroup label="南方">
			<option value="sc">四川</option>
			<option value="hn">河南</option>
			<option value="yn">云南</option>
		</optgroup>
	</select>
	<select id="city">
	
	</select>
</body>
</html>