<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	
	String xml = request.getParameter("bindingFeeInfo");
	
	System.out.println("assiFeeInfo=xml===AAAAAAAAAAAAAAAAAAAAAA====" + xml);
 	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%
	List fundsList = null;
	Iterator it =null;
	
	if(null != mb){
	
		fundsList = mb.getList("OUT_DATA.H41.ADD_BINDING_LIST.ADD_BINDING_INFO");
	
		if(null!=fundsList)
			it =fundsList.iterator();
	}
	
 %>
<html>
	<head>
	<title></title>
	</head>
	<body>
		<div id="operation">
		<form method="post" name="frm4938" action="">
				
				<div id="operation_table">
					 <div class="title">
						<div class="text">
							必绑附加资费详细信息
						</div>
					</div>
					<div class="input">
					<table>
					<%
						if(null!=it){
							while(it.hasNext()){
							Map stMap = mb.isMap(it.next());
							if(null==stMap)continue;
							String ADD_BINDING_CODE = (String)stMap.get("ADD_BINDING_CODE") == null ? "":(String)stMap.get("ADD_BINDING_CODE");
							String ADD_BINDING_NAME = (String)stMap.get("ADD_BINDING_NAME") == null ? "":(String)stMap.get("ADD_BINDING_NAME");
							System.out.println("ADD_BINDING_CODE========="+ADD_BINDING_CODE);
							System.out.println("ADD_BINDING_NAME========="+ADD_BINDING_NAME);
					 %>
							<tr>
								<th>
									必绑附加资费代码
								</th>
								<td>
								<%=ADD_BINDING_CODE%>					
								</td>
								<th>必绑附加资费名称</th>
								<td>
								<%=ADD_BINDING_NAME%>
								</td>
							</tr>
						<%}}%>
						</table>
						</div>
					<div id="operation_button">
						<input type="button" class="b_foot" value="关闭" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
				</div>
			</form>
		</div>
		<%@ include file="/npage/include/footer_pop.jsp"%>
	</body>
	<script type="text/javascript">
	
	function closeWin(){
		closeDivWin();
	}
	</script>
</html>