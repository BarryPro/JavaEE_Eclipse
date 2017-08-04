<%
   /*
   * 功能: 快速检索
　 * 版本: v2.0
　 * 日期: 2013/11/19
　 * 作者: quyl
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人         修改目的
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%
	//String nodeId = "Z";
	String resKey = "-1";
	String resValue = "-1";
	String nodeId = resKey + "@" + resValue;
	String loginNo = (String)session.getAttribute("workNo");//登录工号
	String loginPwd = (String)session.getAttribute("password");//登录密码
	String IpAddress = (String)session.getAttribute("ipAddr");
	String groupId =  (String)session.getAttribute("groupId");
	String regionCode = (String)session.getAttribute("regCode");//区域
%>
<html>
	<head>
		<title>终端选择</title>
	</head>
	<body>
			<form name="frm" action="" method="post">
			<div id="operation">
				<div id="operation_table">
					<table>
						<tr>
							<td>
								<div id="rootTree" style="height: 450px; width: 240px; border: 1px solid #c3daf9;"
									align="left">
								</div>
							</td>
							<td>
								<div id="div_gift"
									style="height: 450px; width: 240px;  border: 1px solid #c3daf9;overflow-y:auto;"
									align="right" >
									<table class="list" id="giftTable">
										<tr>
											<th>
												选择
											</th>
											<th>
												终端品牌
											</th>
											<th>
												终端型号
											</th>
											<th>
												成本价
											</th>
										</tr>
									</table>
								</div>
							</td>
						</tr>
					</table>
					<div id="operation_button">
						<input class="b_foot" type="button" name="qry" value="确定"
							onclick="add_do()" />
						<input class="b_foot" type="button" name="re" value="取消"
							onclick="window.close()" />
					</div>
				</div>
				
				</div>
			</form>
	</body>
</html>
<script language="JavaScript">
window.onload=function(){
	$("#rootTree").css({ "display": "block", "height":"450px"});
	createRoot("终端目录","tree","rootTree");
}
function createRoot(rootName,treeNameValue,treeDivIdValue){
	treeName = treeNameValue;
	treeDivId = treeDivIdValue;
	tree = new stdTree(treeNameValue,treeDivIdValue);
	tree.imgSrc= "<%=request.getContextPath()%>/npage/se112/UI/mztree";
	with(tree){
		N['<%=nodeId%>']='<%=nodeId%>;'+rootName+';000;1';
	}
	tree.writeTree();		
	tree = null;
}
//点击树节点触发事件
function stGetTreeNode(chId)
{
	qryGift(chId);
}	
function qryGift(nodeID)
{
	var packet = null;
	packet = new AJAXPacket("loadhljClient.jsp","请稍后...");
	packet.data.add("parentCode",nodeID);
	core.ajax.sendPacketHtml(packet,doGift,true);
	packet =null;
}
//回调方法
function doGift(data)
{	
	if(trim(data)=="9999"){
		alert("该目录下无数据");
		return false;
	}
	tree = new stdTree("tree","rootTree");
	tree.imgSrc= "<%=request.getContextPath()%>/npage/se112/UI/mztree";
	with(tree)
	{
		eval(data);
	}
	tree.writeTree();
	tree=null;
}
function T(nodeId,nodeName){
	var packet = null;
	packet = new AJAXPacket("hljclientContent.jsp","请稍后...");
	packet.data.add("nodeId",nodeId);
	core.ajax.sendPacketHtml(packet,doGiftCat,true);
	packet =null;
}
function doGiftCat(data){
	var tab = document.all("giftTable");
	for(i=1;i<tab.rows.length;){
		tab.deleteRow(i);
	}
	if(trim(data)=="9999"){
		alert("该目录下无终端");
		return false;
	}
	var arr = data.split(";");
	for(i=0;i<arr.length-1;i++){
		var gift = arr[i].split(",");
		if(gift.length&&gift.length>0){
			var row = tab.insertRow();
			var cell = row.insertCell();
			cell.innerHTML="<input type='radio' name='giftBox' value='"+arr[i]+"' />";
			cell = row.insertCell();
			cell.innerHTML=gift[0];
			cell = row.insertCell();
			cell.innerHTML=gift[1];
			cell = row.insertCell();
			cell.innerHTML=gift[2];
		}
	}
}
function giftContent(nodeId,nodeName){
	
}
function add_do(){
	var boxList = document.getElementsByName("giftBox");
	var num = 0 ; 
	var giftList = "";
	for(i=0;i<boxList.length;i++){
		if(boxList[i].checked){
			num++;
			giftList+=boxList[i].value+";";
		}
	}
	if(num==0){
		showDialog("请选择终端",1);
	}else{
		window.opener.addhljClient(giftList);
		window.close();
	}
}
</script>
