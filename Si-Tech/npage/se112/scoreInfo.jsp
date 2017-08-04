<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	String xml = request.getParameter("scoreInfo");
	String meansId = request.getParameter("meansId");
	System.out.println("scoreInfo=xml===AAAAAAAAAAAAAAAAAAAAAA====" + xml);
 	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%	List scoreList = null;
	String scoreValue = null;
	String scoreType = null;
	String zh_name = null;
	Iterator it =null;
	if(null!= mb){
		scoreList = mb.getList("OUT_DATA.H12");
		System.out.println("_________scoreList________" + scoreList.toString());
		if(null!=scoreList)
			it =scoreList.iterator();
	}
	
 %>
<html>
	<head>
	<title></title>
	</head>
	<body>
		<div id="operation">
		<form method="post" name="frm1147" action="">
				
				<div id="operation_table">
					 <div class="title">
						<div class="text">
							积分详细信息
						</div>
					</div>
					<div class="input">
					<table>
					<%
						if(null!=it){
						while(it.hasNext()){
						Map stMap = mb.isMap(it.next());
						if(null==stMap)continue;
						
						 scoreValue = (String)stMap.get("SCORE_VALUE") == null?"":(String)stMap.get("SCORE_VALUE");
						 scoreType = (String)stMap.get("SCORE_TYPE") == null ? "" : (String)stMap.get("SCORE_TYPE");
						if("ADD".equals(scoreType)){
							zh_name = "赠送";
						}else{
							zh_name = "扣减";
						}
					 %>
							<tr>
								<th>
									积分额度
								</th>
								<td>
									<input  name = "score_value" id = "score_value"  value="<%= scoreValue%>"></input>
								</td>
								<th>积分类型</th>
								<td>
								<%= zh_name%>积分
								</td>
							</tr>
						<%}
						}%>
						</table>
						</div>
					<div id="operation_button">
						<input type="button" class="b_foot" value="确定" id="btnSubmit"
							name="btnSubmit" onclick="btnRsSubmit()" />
						<input type="button" class="b_foot" value="关闭" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
				</div>
			</form>
		</div>
	</body>
	<script type="text/javascript">
	
	function closeWin(){
		closeDivWin();
	}
	
	function btnRsSubmit(){
		var scoreValue = document.getElementById("score_value").value;
		var desc = "<%=zh_name%>" + scoreValue + "积分";	
		parent.addScoreData(scoreValue);
		parent.document.getElementById("scoreDetails<%=meansId%>").innerHTML = desc;	
		closeDivWin();
	}
		
	</script>
</html>