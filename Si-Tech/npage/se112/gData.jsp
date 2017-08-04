<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	String svcNum = request.getParameter("svcNum");
	String loginNo = (String)session.getAttribute("workNo");
	String loginPwd = request.getParameter("password")==null?"":request.getParameter("password");
	String xml = request.getParameter("gDataInfo");
	String meansId = request.getParameter("meansId");
	System.out.println("gDATABUSI=xml===AAAAAAAAAAAAAAAAAAAAAA====" + xml);
	
	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%	
	
	List fundsList = null;
	Iterator it =null;
	
	if(null != mb){
	
		fundsList = mb.getList("OUT_DATA.H38.GDATA_LIST.GDATA_INFO");
	
		if(null!=fundsList)
			it =fundsList.iterator();
	}
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
							数据业务详细信息
						</div>
					</div>
					<div class="input">
					<table id="selectTable">
						<tr>
							<th>选择</th>
							<th>企业代码</th>
							<th>业务代码</th>
							<th>业务名称</th>
							<th>消费金额</th>
						</tr>
					<%
						if(null!=it){
							while(it.hasNext()){
							Map stMap = mb.isMap(it.next());
							if(null==stMap)continue;
							String ALL_DATA_COMP_CODE = (String)(stMap.get("ALL_DATA_COMP_CODE") == null ? "":stMap.get("ALL_DATA_COMP_CODE"));
							String ALL_DATA_BUSI_CODE = (String)(stMap.get("ALL_DATA_BUSI_CODE") == null ? "":stMap.get("ALL_DATA_BUSI_CODE"));
							String ALL_DATA_NAME = (String)(stMap.get("All_DATA_NAME") == null ? "":stMap.get("All_DATA_NAME"));
							String COST = (String)(stMap.get("ALL_DATA_PAYMONEY") == null?"":stMap.get("ALL_DATA_PAYMONEY"));
							//判断是否已经订购
							boolean isOrdered = false;
							for(int i=0; i<list.size(); i++){
								Map hmap = MapBean.isMap(list.get(i));
								if(hmap==null)continue;
								String compCode = (String)(hmap.get("COMP_CODE")==null?"":hmap.get("COMP_CODE"));
								String busiCode = (String)hmap.get(("BUSI_CODE")==null?"":hmap.get("BUSI_CODE"));
								if(ALL_DATA_COMP_CODE.equals(compCode)&&ALL_DATA_BUSI_CODE.equals(busiCode)){
									isOrdered = true;
									break;
								}
							}
							if(isOrdered)continue;
							String NEW_ID = ALL_DATA_COMP_CODE + "_" + ALL_DATA_BUSI_CODE;
					 %>
							<tr>
								<td>
									<input type="checkbox" name="fee" id="<%=NEW_ID %>"  size="1"/>
								</td>														
								<td id="<%=NEW_ID %>_1">
									<%=ALL_DATA_COMP_CODE%>	
									<input type = "hidden" id="<%=NEW_ID %>_h1" value="<%=ALL_DATA_COMP_CODE %>" />					
								</td>
								<td id="<%=NEW_ID %>_2">
									<%=ALL_DATA_BUSI_CODE%>
									<input type = "hidden" id="<%=NEW_ID %>_h2" value="<%=ALL_DATA_BUSI_CODE %>" />	
								</td>								
								<td id="<%=NEW_ID %>_3">
									<%=ALL_DATA_NAME%>
									<input type = "hidden" id="<%=NEW_ID %>_h3" value="<%=ALL_DATA_NAME %>" />	
								</td>
								<td id="<%=NEW_ID %>_4">
									<%=COST %>
									<input type = "hidden" id="<%=NEW_ID %>_h4" value="<%=COST %>" />								
								</td>
							</tr>
						
						<%}}%>
					</table>
					 <div class="title">
						<div class="text">
							已经办理的数据业务
						</div>
					</div>					
					<table id="oldTable">
						<tr>
							<th>选择</th>
							<th>企业代码</th>
							<th>业务代码</th>
							<th>业务名称</th>
						</tr>					
						<%Iterator itr = list.iterator();
							while (itr.hasNext()) {
							Map hmap = MapBean.isMap(itr.next());
							if(hmap == null)continue;
							String compCode = (String)(hmap.get("COMP_CODE")==null?"":hmap.get("COMP_CODE"));
							String busiCode = (String)(hmap.get("BUSI_CODE")==null?"":hmap.get("BUSI_CODE"));
							String name = (String)(hmap.get("NAME")==null?"":hmap.get("NAME"));	
							String bizType = (String)(hmap.get("TYPE")==null?"":hmap.get("TYPE"));
							String billType = (String)(hmap.get("BILL_TYPE")==null?"":hmap.get("BILL_TYPE"));
							if(!"7".equals(bizType)){
								continue;
							}
							String OLD_ID = compCode + "_" + busiCode;
						%>
							<tr>
								<td>
									<input type="checkbox" name="fee" id="<%=OLD_ID %>"  size="1" checked="checked"/>
									<input type="hidden" id = "<%=OLD_ID %>_4"  value = "<%=billType %>" />
								</td>
								<td id="<%=OLD_ID %>_1">
									<%=compCode %>
									<input type = "hidden" id="<%=OLD_ID %>_h1" value="<%=compCode %>" />
								</td>
								<td id="<%=OLD_ID %>_2">
									<%=busiCode %>
									<input type = "hidden" id="<%=OLD_ID %>_h2" value="<%=busiCode %>" />
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
	</body>
	<script type="text/javascript">
	function subAll(){
		var checkEle = $("#selectTable input:checked");
		var checkEleOld = $("#oldTable input:checked");
		var uncheckOld = $("#oldTable input:checkbox").not("input:checked");
		var comps = "";
		var busis = "";
		var names = "";
		var showNames = "";
		var split = "";
		var split2 = "";
		var allcost = 0;
		//拼写新订购的串
		for(var i=0; i<checkEle.length; i++){
			//因为业务代码中含有+会使jquery失效 改用源生html
			var tid = $(checkEle[i]).attr("id");
			var comp = $.trim(document.getElementById(tid+"_h1").value);//$("#"+tid+"_1").text().trim();
			var busi = $.trim(document.getElementById(tid+"_h2").value);//$("#"+tid+"_2").text().trim();
			var name = $.trim(document.getElementById(tid+"_h3").value);//$("#"+tid+"_3").text().trim();
			var cost = $.trim(document.getElementById(tid+"_h4").value);//$("#"+tid+"_4").text().trim();
			comps = comps + split + comp;
			busis = busis + split + busi;
			names = names + split + name;
			showNames = showNames + split2 + name;
			allcost = Number(allcost) + Number(cost);
			split = "~";
			split2 = "<br>";
		}
		//将旧订购的业务名称加入显示
		for(var i=0; i<checkEleOld.length; i++){
			var tid = $(checkEleOld[i]).attr("id");
			var name = $.trim($("#"+tid+"_3").text());
			showNames = showNames + split2 + name;
			split2 = "<br>";
		}
		//将取消的旧订购业务拼串
		var cancelStr = "";
		var cancelSplit = "";
		for(var i=0; i<uncheckOld.length; i++){
			var tid = $(uncheckOld[i]).attr("id");
			var comp = $.trim(document.getElementById(tid+"_h1").value);//$("#"+tid+"_1").text().trim();
			//因为业务代码中含有+会使jquery失效 改用源生html
			var busi = $.trim(document.getElementById(tid+"_h2").value);//$("#"+tid+"_2").text().trim();
			var billType = $.trim(document.getElementById(tid+"_h4").value);//$("#"+tid+"_4").val().trim();
			//无线音乐高级会员传特定的类型
			var biz_type = "7";//默认数据业务
			var key = "inOpCode";
			if(comp == "user_level"){
				biz_type = "5";
				key = "user_level";
			}
			//biz_type(7,无线音乐5)#订购标志(06订购07退订)#企业代码#业务代码#billType=2#key#value传空
			cancelStr = cancelStr + cancelSplit + biz_type + "#" + "07" + "#" + comp + "#" + busi + "#" + billType +"#"+ key +"#"
			cancelSplit = ",";
		}
		//存储内容
		parent.saveGData("<%=meansId%>", comps, busis, names, showNames, allcost, cancelStr);
		closeWin();
	}
	function closeWin(){
		closeDivWin();
	}
	
	
	</script>
</html>