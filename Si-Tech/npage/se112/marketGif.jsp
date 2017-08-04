<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	
	String xml = request.getParameter("marketGif");
	String H08 = request.getParameter("H08");
	String group_id = (String)session.getAttribute("groupId");
	System.out.println("marketGif=xml===AAAAAAAAAAAAAAAAAAAAAA====" + xml);
 	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%
	
	List fundsList = null;
	Iterator it =null;
	String giftModel ="";
	String rate = "";
	if(null != mb){
		fundsList = mb.getList("OUT_DATA.H07");
		rate = mb.getString("OUT_DATA.H07.AWARD_RATE");
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
				<input type="hidden" id="giftNO" value="" />
				<input type="hidden" id="giftName" value="" />
				<div id="operation_table">
					 <div class="title">
						<div class="text">
							选择促销品
						</div>
					</div>
					<div class="input">
						<table>
							<thead>
								<tr>
									<th>中奖率</th>
									<td><%=rate %>%</td>
								</tr>
								<tr>
									<th style="width:10%">选择</th>
									<th style="width:90%">礼品名称</th>
								</tr>
							</thead>
							<tbody>
								<%
								if(null!=it){
									while(it.hasNext()){
										Map stMap = mb.isMap(it.next());
										if(null==stMap)continue;
										giftModel = (String)stMap.get("GIFT_MODEL") == null?"":(String)stMap.get("GIFT_MODEL");//礼品模式：0单个礼品1礼品包
										List GIFT_NO_LIST = new ArrayList();
										List GIFT_NAME_LIST = new ArrayList();
										if(stMap.get("GIFT_NO") != null){
											if(stMap.get("GIFT_NO").getClass().isInstance(GIFT_NO_LIST)){
												GIFT_NO_LIST = (List)stMap.get("GIFT_NO");
												GIFT_NAME_LIST = (List)stMap.get("GIFT_NAME");
											}else{
												GIFT_NO_LIST.add(stMap.get("GIFT_NO"));
												GIFT_NAME_LIST.add(stMap.get("GIFT_NAME"));
											}
										}
										for(int i=0;i<GIFT_NO_LIST.size();i++){
											String GIFT_NAME = (String)GIFT_NAME_LIST.get(i);
											String GIFT_NO = (String)GIFT_NO_LIST.get(i);
											%>
												<tr>
													<td style="width:10%"><input name="radio" type="radio" onclick="selectGift(<%=i%>)" /></td>
													<td style="width:90%" id="giftName_<%=i %>"><%=GIFT_NAME %></td>
													<input type="hidden" id="giftNO_<%=i %>" value="<%=GIFT_NO %>" />
												</tr>
											<% 
										}
									}
								}
								%>
							</tbody>
						</table>
					</div>
					<div id="operation_button">
						<input type="button" class="b_foot" value="确定" id="btnSubmit"
							name="btnSubmit" onclick="giftSubmit()" />
						<input type="button" class="b_foot" value="关闭" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
				</div>
			</form>
		</div>
	</body>
<script type="text/javascript">
function giftSubmit(){
	var giftNO = $("#giftNO").val(); 
	var giftName = $("#giftName").val();
	if(giftNO.length == ""){
		showDialog("请选择促销品!",0);
		return;
	}
	<%
	if("1".equals(H08.trim())){
	%>
		var sPacket = new AJAXPacket("getCertGiftInfo.jsp","请稍候......");
		sPacket.data.add("giftModel","<%=giftModel%>");
		sPacket.data.add("groupId","<%=group_id%>");
		sPacket.data.add("giftNo",giftNO);
		core.ajax.sendPacket(sPacket,doserviceResCat);
		sPacket = null;
	<%}else{%>
		parent.addSelectGiftData(giftNO, giftName,"","");
		closeDivWin();
	<%}%>
}
function doserviceResCat(packet){
		var giftNO = $("#giftNO").val(); 
		var giftName = $("#giftName").val();
		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
		var Strgoodssub = packet.data.findValueByName("Strgoodssub");
		var StrbusInsub = packet.data.findValueByName("StrbusInsub");
		if(RETURN_CODE!="000000"){
			showDialog(RETURN_MSG,0);
			return false;
		}
		parent.addSelectGiftData(giftNO, giftName,Strgoodssub,StrbusInsub);
		closeDivWin();
}

function selectGift(radioId){
	var giftNO = $("#giftNO_"+radioId).val(); 
	var giftName = $("#giftName_"+radioId).text();
	$("#giftNO").val(giftNO);
	$("#giftName").val(giftName);
}	

function closeWin(){
	closeDivWin();
}	
</script>
</html>