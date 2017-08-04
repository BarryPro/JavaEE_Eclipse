<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	String xml = "<H33><ATTR_CTRL><IS_MODIFY type='string'></IS_MODIFY></ATTR_CTRL><ORDER_TYPE_VALUE type='string'>0</ORDER_TYPE_VALUE><ORDER_TYPE_VALUE type='string'>1</ORDER_TYPE_VALUE></H33>";
	String meansId = request.getParameter("meansId");
	String H10 = request.getParameter("H10");
	String H11 = request.getParameter("H11");
	Map hm = new HashMap();
	hm.put("0", "办理");
	hm.put("1", "预约办理");
	System.out.println("orderType=xml===CCCCCCCCCCCCCC====" + xml+hm);
	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%	
 	List payTypeList = null;
	Iterator it =null;
	if(null!= mb){
		payTypeList = mb.getList("OUT_DATA.H33.ORDER_TYPE_VALUE");
		System.out.println("_________payTypeList________" + payTypeList.toString());
		
		if(null!=payTypeList)
			it =payTypeList.iterator();
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
							订购方式信息
						</div>
					</div>
					<div class="input">
					<table>
					<%
						if(null!=it){
						while(it.hasNext()){
						String orderTypeinfo = (String)it.next();
						System.out.println(orderTypeinfo+"!!!!!!!!!!!!");
					 %>
							<tr>
								
								<th>
									<input type = "radio" id= "orderTypeList" name = "orderTypeList" value="<%=orderTypeinfo%>">
									<input type = "hidden" id="orderTypeName" value="<%=hm.get(orderTypeinfo) %>"/>
								</th>
								
								<td>
								<%=hm.get(orderTypeinfo) %>
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
		var selectOrderType = $(":input[name=orderTypeList][checked]").val();
		if(selectOrderType =="" || selectOrderType== undefined){
				showDialog("请选择订购方式!",0);
			return;
		}
		if( selectOrderType == "1" && ("<%=H10%>" =="1" || "<%=H11%>"=="1")){
			showDialog("预约办理活动不应有资费类的元素，请联系管理员!!",0);
			return false;
		}
		//订购方式名称
		var orderTypeName = $(":input[name=orderTypeList][checked]").next().val();
		parent.document.getElementById("orderTypeInfo<%=meansId%>").innerHTML = orderTypeName;
		parent.addOrderTypeData(selectOrderType);
		parent.orderType_Checkfuc();
		closeDivWin();
	}
	
	</script>
</html>