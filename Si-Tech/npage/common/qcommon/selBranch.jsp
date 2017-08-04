<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%
String  object_id = WtcUtil.repNull(request.getParameter("object_id"));
%>
<html>
<head>
<script>
function  retBrach(obj){
	window.returnValue=obj;
	window.close();
}	
 $().ready(function(){
 	 getBrachById();
 	});

function  getBrachById(){
	var  object_id = document.frm_1.object_id.options[document.frm_1.object_id.selectedIndex].value;
	document.frm_1.action= "selBranch_list.jsp?object_id="+object_id;
	document.frm_1.target = "myframe";
	document.frm_1.submit();
	
	unLoading();
}

function  getBrachByName(){
	var  object_id = document.frm_1.object_id.options[document.frm_1.object_id.selectedIndex].value;
	var  branchName = document.frm_1.branchName.value;
	document.frm_1.action= "selBranch_list.jsp?object_id="+object_id+"&branchName="+branchName;
	document.frm_1.target = "myframe";
	document.frm_1.submit();
	
	unLoading();
}



</script>
</head>

<body>
		<div id="operation">
			<form action="" name="frm_1" method="post">
				
				<%@ include file="/npage/include/header_pop.jsp"%>
				<div id="operation_table">
					<div class="input">	
					<table>
						<tr>
							<th>处理局：</th>
							<td>
								<select  name="object_id"  onchange="getBrachById();">
									<wtc:pubselect name="sPubSelect" outnum="2">
										<wtc:sql>SELECT object_id,object_name FROM tcgav_object  WHERE up_object_id= '?' or  object_id='?'</wtc:sql>	
										<wtc:param  value="<%=object_id%>"/>
										<wtc:param  value="<%=object_id%>"/>										
									</wtc:pubselect>										 
									<wtc:iter id="retBranch" indexId="i" >
										<%
											if(retBranch[0].equals(object_id)){
												out.println("<option selected value='"+ retBranch[0] +"'>"+retBranch[1]+"</option>");
											}else{
												out.println("<option value='"+ retBranch[0] +"'>"+retBranch[1]+"</option>");	
											}
										%>
									</wtc:iter>	
								</select>
							</td>
							<th>名称：</th>
							<td>
								<input  type="text"  name="branchName"  size="15"  onkeypress="if(event.keyCode==13)getBrachByName();"/>
								<input  type="button" class="b_text" value="查询"  onclick="getBrachByName();" />
							</td>
						</tr>
					</table>
					<div>		
				</div>
  </form>
</div>
<iframe id="myframe"  name="myframe" src=""  width="100%"  height="300px"  scrolling="auto"></iframe>

</body>
</html>
