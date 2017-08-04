
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
	String svcNum = request.getParameter("svcNum");
	String loginNo = (String)session.getAttribute("workNo");
	String loginPwd = request.getParameter("loginPwd")==null?"":request.getParameter("loginPwd");
	String xml = request.getParameter("gWlanInfo");
	String meansId = request.getParameter("meansId");
	System.out.println("gAddFeeInfo=xml===AAAAAAAAAAAAAAAAAAAAAA====" + xml);
	
 	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%	
	List fundsList = null;
	Iterator it =null;
	
	if(null != mb){
	
		fundsList = mb.getList("OUT_DATA.H37.GWLAN_LIST.GWLAN_INFO");
	
		if(null!=fundsList)
			it =fundsList.iterator();
	}
	System.out.println("svcnum==="+svcNum);
 %>
 <s:service name="sMarkSpQryWS_XML" >
    <s:param name="Root">
   			<s:param name="chn" type="string" value="01" />
   			<s:param name="opcode" type="string" value="e177" />
   			<s:param name="loginno" type="string" value="<%=loginNo%>" />
   			<s:param name="loginpwd" type="string" value="<%=loginPwd%>" />
   			<s:param name="svcnum" type="string" value="<%=svcNum%>" />
    </s:param>
</s:service>
<% 
	List list = result.getList("OUT_DATA.BUSI_INFO");
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
							WLAN详细信息
						</div>
					</div>
					<div class="input">
					<table id="selectTable">
						<tr>
							<th>选择</th>
							<th>业务代码</th>
							<th>WLAN名称</th>
							<th>消费金额</th>
						</tr>
					<%
						if(null!=it){
							while(it.hasNext()){
							Map stMap = mb.isMap(it.next());
							if(null==stMap)continue;
							String ALL_WLAN_BUSI_CODE = (String)(stMap.get("ALL_WLAN_BUSI_CODE") == null ? "":stMap.get("ALL_WLAN_BUSI_CODE"));
							String ALL_WLAN_NAME = (String)(stMap.get("All_WLAN_NAME") == null ? "":stMap.get("All_WLAN_NAME"));
							String COST = (String)(stMap.get("ALL_WLAN_PAYMONEY") == null ? "":stMap.get("ALL_WLAN_PAYMONEY"));
							//判断是否已经订购
							boolean isOrdered = false;
							for(int i=0; i<list.size(); i++){
								Map hmap = MapBean.isMap(list.get(i));
								if(hmap==null)continue;
								String busiCode = (String)(hmap.get("BUSI_CODE")==null?"":hmap.get("BUSI_CODE"));
								if(ALL_WLAN_BUSI_CODE.equals(busiCode)){
									isOrdered = true;
									break;
								}
							}
							if(isOrdered)continue;
							String NEW_ID = ALL_WLAN_BUSI_CODE;							
					 %>
							<tr>
								<td>
									<input type="radio" name="wlan" id="<%=NEW_ID %>"  size="1"/>
								</td>	
								<td id="<%=NEW_ID %>_2">
									<%=ALL_WLAN_BUSI_CODE%>
								</td>								
								<td id="<%=NEW_ID %>_3">
									<%=ALL_WLAN_NAME%>
								</td>
								<td id="<%=NEW_ID %>_4">
									<%=COST%>
								</td>							
							</tr>
						
						<%}}%>
					</table>
						
					<div class="title">
						<div class="text">
							已经办理的wlan
						</div>
					</div>
					<table id="oldTable">
						<tr>
							<th>选择</th>
							<th>业务代码</th>
							<th>业务名称</th>
						</tr>
						<%
						  Iterator itr = list.iterator();
							while (itr.hasNext()) {
								Map hmap = MapBean.isMap(itr.next());
								if(hmap == null)continue;
								String busiCode = (String)(hmap.get("BUSI_CODE")==null?"":hmap.get("BUSI_CODE"));
								String name = (String)(hmap.get("NAME")==null?"":hmap.get("NAME"));	
								String bizType = (String)(hmap.get("TYPE")==null?"":hmap.get("TYPE"));
								String billType = (String)(hmap.get("BILL_TYPE")==null?"":hmap.get("BILL_TYPE"));
								System.out.println(bizType);
								if(!"3".equals(bizType)){
									continue;
								}
								String OLD_ID = busiCode;
						%>	
							<tr>
								<td>
									<input type="radio" name="wlan" id="<%=OLD_ID %>"  size="1" checked="checked"/>
									<input type="hidden" id = "<%=OLD_ID %>_4"  value = "<%=billType %>" />
								</td>
								<td id="<%=OLD_ID %>_2">
									<%=busiCode %>
								</td>
								<td id="<%=OLD_ID %>_3">
									<%=name %>
								</td>								
							</tr>
						<%}%>																
					</table>						
					</div>
						
				
					<div id="operation_button">
						<input type="button" class="b_foot" value="选择" id="btnCancel"
							name="btnCancel" onclick="subAll()" />					
						<input type="button" class="b_foot" value="关闭" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
				</div>
			</form>
		</div>
		<%@ include file="/npage/include/footer_pop.jsp"%>
	</body>
	<script type="text/javascript">
	function subAll(){
		var checkEle = $("#selectTable input:checked");
		var checkEleOld = $("#oldTable input:checked");
		var uncheckOld = $("#oldTable input:checkbox").not("input:checked");
		var busi = "";
		var name = "";
		var cost = 0;
		var wlanStr = "";
		//wlan单选，所以已经订购的wlan如果存在必然只有一个
		//只存在以下两种情况 1选择了新的wlan 拼接订购串，
		//2选择了旧的wlan 不需要拼接订购串，
		//如果取消了旧的wlan(必然发生1)， 拼接取消订购串。
		if(checkEle.length > 0){
			var tid = $(checkEle[0]).attr("id");
			busi = $.trim($("#"+tid+"_2").text());
			name = $.trim($("#"+tid+"_3").text());
			cost = $.trim($("#"+tid+"_4").text());
			wlanStr = "3#06#0#" + busi + "#2#pack_code#";
		}
		if(checkEleOld.length > 0){
			var tid = $(checkEleOld[0]).attr("id");
			name = $.trim($("#"+tid+"_3").text());
		}
		if(uncheckOld.length > 0){
			var tid = $(uncheckOld[0]).attr("id");
			busi = $.trim($("#"+tid+"_2").text());
			billType = $.trim($("#"+tid+"_4").text());
			wlanStr = wlanStr + ",3#07#0#" + busi + "#" + billType + "#pack_code#";
		}
		//存储内容
		parent.saveGWlan("<%=meansId%>", busi, name, cost, wlanStr);
		closeWin();
	}
	function closeWin(){
		closeDivWin();
	}
	
	
	</script>
</html>