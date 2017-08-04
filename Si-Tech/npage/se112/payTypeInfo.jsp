<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	String xml = request.getParameter("bankPayFee");
	String meansId = request.getParameter("meansId");
	System.out.println("payType=xml===AAAAAAAAAAAAAAAAAAAAAA====" + xml);
 	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%
	List payTypeList = null;
	Iterator it =null;
	String payBankStr ="";
	if(null!= mb){
		payTypeList = mb.getList("OUT_DATA.H06.PAY_TYPE_LIST.PAY_TYPE_INFO");
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
							缴费方式信息
						</div>
					</div>
					<div class="input">
						<table>
							<tr>
								<th>
								<%
									Map sMap = (Map)payTypeList.get(0);
									for(int i=0;i<payTypeList.size();i++){
										Map stMap = (Map)payTypeList.get(i);
										System.out.println(i+"----------"+(String)stMap.get("PAY_MONTH_NUM"));
										if(null==stMap.get("PAY_MONTH_NUM")&&null == stMap.get("PAY_MONTH_PERCENT")){
											payTypeList.remove(i);
										}
									}
									String pay_bank = (String)sMap.get("PAY_BANK");
									String pay_type_value = (String)sMap.get("PAY_TYPE_VALUE");
									
								%>	
									<input type = "radio" id= "payTypeList" name = "payTypeList" value="<%=pay_type_value %>" checked>
									<input type = "hidden" id="payTypeName" value="银行分期付款"/>
								</th>
								
								<td>
									银行分期付款
								</td>
							</tr>
						</table>
					</div>
					<div id="eitable" class="input">
						<table>
							<%
								if(pay_bank != null){
									if("GH".equals(pay_bank)){
										payBankStr = "工商银行";
									}
									if("ZH".equals(pay_bank)){
										payBankStr = "招商银行";
									}
							%>
							<tr>
								<th>分期银行:</th>
								<td><%=payBankStr %></td>
							</tr>
							<%if(payTypeList != null){
								for(int i=0;i<payTypeList.size();i++){
									Map maps = (Map)payTypeList.get(i);
									String PAY_MONTH_NUM = (String)maps.get("PAY_MONTH_NUM") == null ? "":(String)maps.get("PAY_MONTH_NUM");
									String PAY_MONTH_PERCENT = (String)maps.get("PAY_MONTH_PERCENT") == null ? "":(String)maps.get("PAY_MONTH_PERCENT");
								%>
								<tr>
									<th><input type="radio" name="monthvalue" value="<%=PAY_MONTH_NUM %>_<%=PAY_MONTH_PERCENT %>" /></th>
									<td><%=PAY_MONTH_NUM %>月期，贴息比率<%=PAY_MONTH_PERCENT %>%</td>
								</tr>
							<%}}}%>
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
		var selectPayType = $(":input[name=payTypeList][checked]").val();
		if(selectPayType =="" || selectPayType== undefined){
				showDialog("请选择缴费方式!",0);
			return;
		}
		var payBank = "";
		var payBankStr = "";
		var payMonth = "";
		var montValue ="";
		var bankRateStr = "";
		//缴费方式名称
		var payTypeName = $(":input[name=payTypeList][checked]").next().val();
		//alert(selectPayType);
		if(selectPayType == 'EI'){
			var pay_month_value = $("#eitable input:checked").val();
			if(!pay_month_value){
				showDialog("请选择分期数!",0);
				return;
			}
			var payData = pay_month_value.split("_");
			payBank = "<%=pay_bank %>";
			payBankStr = "<%=payBankStr %>";
			payMonth = payData[0];
			montValue = payData[1];
			bankRateStr = payBankStr + "，账期：" + payMonth +"个月，贴息比率：" + montValue + "%";
			payTypeName += "，" + bankRateStr;
		}
		
		parent.document.getElementById("payTypeInfo<%=meansId%>").innerHTML = payTypeName;
		parent.addPayTypeData(selectPayType, payBank, payMonth, montValue);
		parent.specialfund_Checkfuc();
		closeDivWin();
	}
	
	</script>
</html>