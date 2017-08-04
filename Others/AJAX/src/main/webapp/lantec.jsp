<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>语言技术联动</title>
<script type="text/javascript" src="js/jquery-1.11.0.js"></script>
<script type="text/javascript">
	$(function(){
		$("#lan").change(function(){
			$.ajax({
				url:"TecControl",
				type:"post",
				data:"lan="+this.value,
				dataType:"xml",
				success:function(data){
					$("#tec option").remove();
					$(data).find("tec").each(function(){
						var name = $(this).children("name").text();//$(this)指的是tec本身
						var no = $(this).children("no").text();
						$("#tec").append("<option value='"+no+"'>"+name+"</option>");
					});
				}
			});
		});
	});
</script>
</head>
<body>
	<select id="lan">
		<optgroup label="语言">
			<option value="java">Java</option>
			<option value="c++">C++</option>
		</optgroup>
		<optgroup label="数据库">
			<option value="mysql">MySQL</option>
			<option value="oracle">Oracle</option>
		</optgroup>
	</select>
	<select id="tec"></select>
</body>
</html>