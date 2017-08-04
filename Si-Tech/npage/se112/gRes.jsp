
<%
	/*
	 * 功能： 全网数据业务信息页面
	 * 版本： v1.0
	 * 20121128 sunzj
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	String xml = request.getParameter("gResInfo");
	String meansId = request.getParameter("meansId");
	System.out.println("gAddFeeInfo=xml===AAAAAAAAAAAAAAAAAAAAAA====" + xml);
	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%	
	List fundsList = null;
	Iterator it =null;
	if(null != mb){
		fundsList = mb.getList("OUT_DATA.H39.GRES_LIST.GRES_INFO");
		if(null!=fundsList)
			it =fundsList.iterator();
	}
	String ALL_RES_UNDEADLINE = "";
	if(fundsList != null&&fundsList.size()>0){
		Map stMap = mb.isMap(fundsList.get(0));
		ALL_RES_UNDEADLINE = (String)stMap.get("ALL_RES_UNDEADLINE");
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
							终端详细信息
						</div>
					</div>
					<div class="input">
					<table>
						<tr>
							<th>IMEI码</th>
							<td>	
								<input type="text" name="imei_code" id="imei_code" value="" onkeyup="this.value=this.value.replace(/[^\d]/g,'');"/>
								<input type="button" class="b_text" name="verify" id="verify" onclick="chkrBrand()" value="验证"/>
								<font style="color:red"><b>*</b></font>
								<div id="td1" align="left">
							</td>
							<th>交付时间</th>
							<td>
								<input type="text" name="cmit_date" id="cmit_date"  class="required Wdate"  value=""
									readonly
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',onpicked:function(){validateElement(this)}})" />
								<font color="red"><b>*</b></font>
							</td>
						</tr>									
						<tr>
							<th>保修时限</th>
							<td><input type="text" name="quality_limit" id="quality_limit" value=""/></td>
							<th>拆包期限</th>
							<td>
								<%=ALL_RES_UNDEADLINE %>
							</td>
						</tr>					
					</table>
					<table>
						<tr>
							<th>选择</th>
							<th>终端品牌</th>
							<th>终端型号</th>
							<th>终端成本</th>
							<th>构机款</th>
						</tr>
					<%if(fundsList != null && fundsList.size()>1 ){
						for(int i=1; i<fundsList.size(); i++){
							Map stMap = mb.isMap(fundsList.get(i));
							if(null==stMap)continue;
							String All_RES_BRAND = (String)stMap.get("All_RES_BRAND") == null ? "":(String)stMap.get("All_RES_BRAND");
							String All_RES_MODEL = (String)stMap.get("All_RES_MODEL") == null ? "":(String)stMap.get("All_RES_MODEL");
							String All_RES_COST_PRICE = (String)stMap.get("All_RES_COST_PRICE") == null ? "":(String)stMap.get("All_RES_COST_PRICE");
							String All_RES_FEE = (String)stMap.get("All_RES_FEE") == null ? "":(String)stMap.get("All_RES_FEE");
							String ALL_RES_CODE = (String)stMap.get("All_RES_CODE") == null ? "":(String)stMap.get("All_RES_CODE");
							String All_RES_BRAND_CODE = (String)stMap.get("All_RES_BRAND_CODE") == null ? "":(String)stMap.get("All_RES_BRAND_CODE");
					 %>
							<tr>
								<td>
									<input type="radio" name="fee" id="<%=ALL_RES_CODE %>"  size="1"/>
									<input type="hidden" name="brand_code" id="<%=ALL_RES_CODE %>_11" value="<%=All_RES_BRAND_CODE %>" />
								</td>														
								<td id="<%=ALL_RES_CODE %>_1">
									<%=All_RES_BRAND%>					
								</td>
								<td id="<%=ALL_RES_CODE %>_2">
									<%=All_RES_MODEL%>
								</td>
								<td id="<%=ALL_RES_CODE %>_3">
									<%=All_RES_COST_PRICE%>
								</td>	
								<td id="<%=ALL_RES_CODE %>_4">
									<%=All_RES_FEE%>
								</td>																		
							</tr>
						
						<%}}%>
						</table>
						</div>
					<div id="operation_button">
						<input type="button" class="b_foot"  disabled="disabled" value="选择" id="btnSubmit"
							name="btnSubmit" onclick="subAll()" />					
						<input type="button" class="b_foot" value="关闭" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
				</div>
			</form>
		</div>
	</body>
	<script type="text/javascript">
	function subAll(){
		var cmit_date = $("#cmit_date").val();
		if(cmit_date==null||cmit_date=="null"||cmit_date==""){
			showDialog("请选择缴交付时间!",0);
		 	return false;		
		}
		var quality_limit=$("#quality_limit").val();
		var checkEle = $("input:checked");
		
		var res_code = $(checkEle[0]).attr("id");
		var brand =  $.trim($("#"+res_code+"_1").text());
		var model =  $.trim($("#"+res_code+"_2").text());
		var price =  $.trim($("#"+res_code+"_3").text());
		var fee =  $.trim($("#"+res_code+"_4").text());
		var imei =  $.trim($("#imei_code").val());
		var brand_code =  $.trim($("#"+res_code+"_11").val());
		var des = "终端品牌："+brand+"，终端型号："+model+"，购机款"+fee+"元"+"，保修时限"+quality_limit+"个月，拆包期限"+<%=ALL_RES_UNDEADLINE%>+"个月";
		//存储内容
		parent.saveGRes("<%=meansId%>", res_code, brand, model, price, fee, imei, cmit_date, quality_limit, brand_code, des, <%=ALL_RES_UNDEADLINE%>);
		closeWin();
	}
	
	function closeWin(){
		closeDivWin();
	}
	
	function chkrBrand(){
		var checkEle = $("input:checked");
		if(checkEle.length == 0){
			showDialog("请选择终端!",0);
			return;
		}
		var tid = $(checkEle[0]).attr("id");
		var imei_code = $("#imei_code").val();//IMEI
		var packet = null;
		packet = new AJAXPacket("checkResource.jsp","请稍后...");
		packet.data.add("imei_code",imei_code);
		packet.data.add("RESOURCE_RES_CODE",tid);
		core.ajax.sendPacketHtml(packet,doResourceCat,true);
		packet =null;
	}
	function doResourceCat(data){
		
		var idAndName =data.split(",");
		if(trim(idAndName[0])=="000000")
		{
			var td1 = document.getElementById("td1");
	 		td1.innerHTML=trim(idAndName[1]);
	 		$("#btnSubmit").attr("disabled",false);
	 		$("#imei_code").attr("readonly",true);
	 		$("input:radio").attr("disabled",true);
						
		}else if(trim(idAndName[0])!="000000")
		{
			var td1 = document.getElementById("td1");
	 		td1.innerHTML=trim(idAndName[1]);
			$("#btnSubmit").attr("disabled",true);
		}
	}
	
	</script>
</html>