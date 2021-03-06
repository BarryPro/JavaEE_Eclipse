<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	
	String xml = request.getParameter("specialallfunds");
	
	System.out.println("specialallfunds=xml===AAAAAAAAAAAAAAAAAAAAAA====" + xml);
	MapBean mb = new MapBean();
%>	
<%@ include file="getMapBean.jsp"%>
<%
	
	List fundsList = null;
	Iterator it =null;
	
	if(null != mb){
	
		fundsList = mb.getList("OUT_DATA.H34.ALL_SPECIAL_FUNDS_LIST.ALL_SPECIAL_FUNDS_INFO");
	
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
							全网专款详细信息
						</div>
					</div>
					<div class="input">
					<table>
					<%
						java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
						java.util.Calendar calendar =java.util.Calendar.getInstance();// 日历对象 

						
						if(null!=it){
							while(it.hasNext()){
							Map stMap = mb.isMap(it.next());
							if(null==stMap)continue;
						
							String stagesIndex = (String)stMap.get("INDEX");
							String payType = (String)stMap.get("PAY_TYPE") == null ? "":(String)stMap.get("PAY_TYPE");
							String payMoney = (String)stMap.get("PAY_MONEY") == null ? "":(String)stMap.get("PAY_MONEY");
							String validFlag = (String)stMap.get("VALID_FLAG") == null ?"":(String)stMap.get("VALID_FLAG");
							String comsumeTime = (String)stMap.get("CONSUME_TIME") == null ? "" : (String)stMap.get("CONSUME_TIME");
							String startTime = (String)stMap.get("START_TIME") == null ? "" : (String)stMap.get("START_TIME");
							String returnType = (String)stMap.get("RETURN_TYPE") == null ? "" : (String)stMap.get("RETURN_TYPE");
							String returnClass = (String)stMap.get("RETURN_CLASS") == null ? "" : (String)stMap.get("RETURN_CLASS");
							String feeDirec = (String)stMap.get("FEE_DIREC") == null ? "" : (String)stMap.get("FEE_DIREC");
							String paymentType = (String)stMap.get("PAYMENT_TYPE") == null ?"":(String)stMap.get("PAYMENT_TYPE"); //缴费类型 

					 %>
							<tr>
								
								<th>
									专款类型
								</th>
								
								<td id="stageDesc<%=stagesIndex%>">
									<%= payType%>					
								</td>
								<th>收费金额</th>
								<td>
								<%= payMoney%>
								</td>
							</tr>
							
							<tr>
								
								<th>专款生效标识</th>
								<td>
								<%if("0".equals(validFlag)){
									out.print("立即生效");
								}else if("1".equals(validFlag)){
									out.print("下月生效");
								}else if("2".equals(validFlag)) out.print("自定义时间");
								
								%>
								</td> 
								<th>消费期限</th>
								<td>
								<%=comsumeTime%>
								</td>
								
							</tr>
							<tr>
								<th>返还方式</th>
								<td>
								<%if("0".equals(returnType)){
									out.print("活动预存");
								}else if("1".equals(returnType)){
									out.print("底线预存");
								}
								%>
								</td> 
								<th>返还类型</th>
								<td>
								<%
								if("1".equals(returnClass)){
									out.print("按月返还累计");
								}else if("2".equals(returnClass)){
									out.print("拆包");
								}else if("3".equals(returnClass)){
									out.print("按月返还累计加拆包");
								}else if("4".equals(returnClass)){
									out.print("按月返还不累计");
								}
								%>
								</td>
								
							</tr>
							<% if("2".equals(validFlag)){ %>
							<tr>
								
								<th>开始时间</th>
								<td>
								<%
							 if("2".equals(validFlag)){
									out.print(startTime);
								}
								%>
								</td>
								<td>
								</td>
							</tr>
							<%} %>
							<tr>
								<th>缴费类型</th>
								<td>
								<%
								 if("2".equals(paymentType)){
									 out.print("D账本转入");
								 }else if("1".equals(paymentType)){
									 out.print("正常办理");
								 }
								%>
								</td>
							</tr>
						<%
							}
						}%>
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