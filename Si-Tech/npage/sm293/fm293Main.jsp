<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: 2015/07/28 R_CMI_HLJ_guanjg_2015_2350528@关于哈分公司为第二批社会渠道申请开通身份证扫描仪使用权限的请示
   * 作者: gejing
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    	String regionCode = (String)session.getAttribute("regCode");
    	String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String loginAccept = getMaxAccept();
		
    	String iLoginNo = loginNo;
 		String iLoginPwd = noPass;
 		String iOpCode = opCode;
 		String iPhoneNo = phoneNo;
%>

  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<!-- <link rel="stylesheet" href="../../css/zTreeStyle/zTreeLastest.css" type="text/css"/>
	<link rel="stylesheet" href="../../css/zTreeStyle/demo.css" type="text/css"/>
	<script src="/njs/extend/mztree/MzTreeView12.js"  type="text/javascript"></script>
	<script src="/njs/extend/mztree/jquery.ztree.core-3.5.js" type="text/javascript"></script>
	<script src="/njs/extend/mztree/jquery.ztree.excheck-3.5.js" type="text/javascript"></script>
	<script src="/njs/extend/mztree/jquery.ztree.exedit-3.5.js" type="text/javascript"></script> -->
	<style type="text/css">
		/* .ztree li a {
			padding: 1px 3px 0px 0px;
			margin: 0px 10px 0px 0px;
			cursor: none;
			height: 16px;
			color: #333;
			background-color: transparent;
			text-decoration: none;
			vertical-align: top;
			display: inline-block;
		} */
	</style>
	<script language="javascript">
		/*树*/
		/* var setting = {
		    check: {
		    	enable: true,
				chkStyle: "checkbox",
				chkboxType :{ "Y" : "", "N" : "" }
		    },
		    data: {
		        simpleData: {
		            enable: true,
		            idKey : "id",
		            pIdKey : "pId",
		            rootPId : 0,
		            showLine : true
		        },
		       key: {
		       		name: "name",
		       		title: "name"
		       }
		    },
		    view: {
		    	dblClickExpand: false,
				showIcon: false,
				fontCss: setFontCss
		    },
		    callback: {
		    	beforeExpand: zTreeBeforeExpand,
		        onAsyncSuccess: onAsyncSuccess,
		        onAsyncError: onAsyncError,
		        onClick: zTreeOnClick,
		        onExpand: zTreeOnExpand,
		        onCheck: onCheck
		    }
		};
		
		function setFontCss(treeId, treeNode) {
			return treeNode.id == 000 ? {color:"blue"} : {};
		};

		function zTreeBeforeExpand(treeId, treeNode) {
		    return true;
		};
		
		function zTreeOnExpand(event, treeId, treeNode) {
		    
		}; */
		/*加载成功方法 这里默认跳转到查询资源分类页面*/
		/* function onAsyncSuccess(event, treeId, treeNode, msg) {
			$("#codeBtn").attr("disabled",false);
		}
		
		//单机节点展开树形结构，通过isLeaf字段判断其下是否有子节点
		function zTreeOnClick(event, treeId, treeNode) {
			var treeObj = $.fn.zTree.getZTreeObj("opcodeTree");
			if(treeNode.hasChild){
				treeNode.isParent = true;
				treeNode.icon="../../css/zTreeStyle/img/folderOpen.gif";
				treeObj.reAsyncChildNodes(treeNode, "refresh");
			}
		}
	
		function onAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {
		    var zTree = $.fn.zTree.getZTreeObj("opcodeTree");
		    rdShowMessageDialog("加载节点失败！",0);
		    treeNode.icon = "";
		    zTree.updateNode(treeNode);
		}
		
		var zTree;
		var array;
		
		function onCheck(e, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("opcodeTree");
			var nodesList = zTree.getNodes();
			var nodes = zTree.getCheckedNodes(true);
			var dataNodes = new Array();
			for(var j=0; j<nodes.length; j++){
				if(nodes[j].id != 000){
					dataNodes.push(nodesList[j]);
				}
			}
			
			var v = "";
			var id = "";
			var tId = "";
			
			if(treeId.name == "全选"){
				if(treeId.getCheckStatus().checked){
					var v = "";
					var id = "";
					var tId = "";
					for(var j=0; j<nodesList.length; j++){
						if(nodesList[j].id != 000){
							zTree.checkNode(nodesList[j], true, false);
							v += nodesList[j].name + ",";
							id += nodesList[j].id + ",";
							tId+= nodesList[j].tId + ",";
						}
						
					}
				}else{
					zTree.checkAllNodes(false);
				}
			}else{
				for (var i=0, l=nodes.length; i<l; i++) {
					if(nodes[i].id != 000){
						v += nodes[i].name + ",";
						id += nodes[i].id + ",";
						tId+= nodes[i].tId + ",";
					}
				}
				if(array.length == dataNodes.length){
					zTree.checkAllNodes(true);
				}else{
					for(var j=0; j<nodesList.length; j++){
						if(nodesList[j].id == 000){
							zTree.checkNode(nodesList[j], false, false);
						}
					}
				}
			} */
			
			/*groupName*/
			/* if (v.length > 0 ) v = v.substring(0, v.length-1); */
			/*groupId*/
			/* if (id.length > 0 ) id = id.substring(0, id.length-1); */
			/*treeId*/
			/* if (tId.length > 0 ) tId = tId.substring(0, tId.length-1); */
			
			/*赋值*/
			/* var opcodeName = $("#opcodeName");
			var opcode = $("#opcode");
			opcodeName.attr("value", v);
			opcodeName.attr("title", v);
			opcode.val(id);
			//hideMenu(); */
		/* } */
		/*展开树形结构方法*/
		/* function showAssignGroup() {
			var parentObj = $("#opcodeName");
			var cityOffset = $("#opcodeName").offset();
			$("#opcodeContent").css({left:cityOffset.left + "px", top:cityOffset.top + parentObj.outerHeight() + "px"}).slideDown("fast");
			$("html").bind("mousedown", onBodyDown);
		}
		function hideMenu() {
			$("#opcodeContent").fadeOut("fast");
			$("html").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "codeBtn" || event.target.id == "opcodeName" || event.target.id == "opcodeContent" || $(event.target).parents("#opcodeContent").length>0)) {
				hideMenu();
			}
		} */
		/*结束*/
		
		function findGroupById(){
			//$("#opcodeName").val("");
			//$("#opcode").val("");
			$("#groupName").val("");
			//$("#codeBtn").attr("disabled","disabled");
			var iGroupId	= $("#groupId").val().trim();			//网点代码
			if(iGroupId == null || iGroupId == ''){
				rdShowMessageDialog("请填写网点代码！",1);
				return false;
			}else{
				var packet = new AJAXPacket("fm293Query.jsp","请稍后...");
				packet.data.add("iLoginAccept" ,"");//流水，不用填写，服务自动获取
				packet.data.add("iChnSource" ,"01");//渠道标识
				packet.data.add("iOpCode" ,"<%=iOpCode%>");//操作代码
				packet.data.add("iLoginNo" ,"<%=iLoginNo%>");//操作工号	
				packet.data.add("iLoginPwd" ,"<%=iLoginPwd%>");//操作工号密码
				packet.data.add("iPhoneNo" ,"");//手机号码
				packet.data.add("iUserPwd" ,"");//用户密码
				packet.data.add("iOpNote","查询网点");
				packet.data.add("iGroupId" ,iGroupId);//网点代码
				core.ajax.sendPacket(packet,getGroup,true);//异步
				packet = null;
			}
			
		}
		
		function getGroup(packet){
			var vGroupName = packet.data.findValueByName("vGroupName");
			//array = packet.data.findValueByName("infoArray");
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				if(vGroupName != null && vGroupName != ""){
					$("#groupName").removeAttr("disabled").val(vGroupName);
					//$("#groupName").val(vGroupName);
					/* //初始化树
				  	$.fn.zTree.init($("#opcodeTree"), setting);
				 	zTree = $.fn.zTree.getZTreeObj("opcodeTree");
				 	//遍历数组，新增节点
				 	
				 	zTree.addNodes(null, {"id":000,"name":"全选"});
				 	
				 	for(var i = 0 ; i < array.length ; i++){
			 			var newNode = {"id":array[i][0],"name":array[i][1]};
			 			zTree.addNodes(null, newNode);
				 	}
				 	
				  	$("#codeBtn").removeAttr("disabled"); */
				}
			}else{
				rdShowMessageDialog(retMsg,1);
			}
			
		}
		
		function subPage(){
			var iGroupId = $("#groupId").val();//网点代码
			var iGroupName	= $("#groupName").val().trim();			
			//var opcode = $("#opcode").val();
			if(iGroupName == null || iGroupName == ''){
				rdShowMessageDialog("请填写网点，并查询，完成校验！",1);
				return false;
			}
			/* else if(opcode == null || opcode == ''){
				rdShowMessageDialog("请选择业务！",1);
				return false;
			} */
			
			if(rdShowConfirmDialog('确认要提交信息吗？')==1){
				/*ajax start*/
				var getdataPacket = new AJAXPacket("fm293Submit.jsp","正在提交数据，请稍候......");
				getdataPacket.data.add("iLoginAccept" ,"");//流水，不用填写，服务自动获取
				getdataPacket.data.add("iChnSource" ,"01");//渠道标识
				getdataPacket.data.add("iOpCode" ,"<%=iOpCode%>");//操作代码
				getdataPacket.data.add("iLoginNo" ,"<%=iLoginNo%>");//操作工号	
				getdataPacket.data.add("iLoginPwd" ,"<%=iLoginPwd%>");//操作工号密码
				getdataPacket.data.add("iPhoneNo" ,"");//手机号码
				getdataPacket.data.add("iUserPwd" ,"");//用户密码
				getdataPacket.data.add("iOpNote","录入读卡器网点配置");//备注
				getdataPacket.data.add("iGroupId" ,iGroupId);//网点代码 必传
				
				core.ajax.sendPacket(getdataPacket,doSuccess,true);
				getdataPacket = null;
			}
			
		}
		
		function doSuccess(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				rdShowMessageDialog("录入成功！",2);
				window.location.reload();
			} else{
				rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
			}
		}
	</script>
</head>
<body>
	<form action="" method="post" name="f1">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<div>
			<table>
				<tr>
					<td width="15%" class="blue">网点代码</td>
			  		<td>
			  			<input type="text" id="groupId" v_type=string onblur="findGroupById();"/>
			  		</td>
			  		<td width="15%" class="blue">网点名称</td>
			  		<td>
			  			<input type="text" id="groupName" value="" v_type=string v_must=1  readonly="readonly" disabled="disabled"/>
			  			<font class="orange">*</font>
			  		</td>
			   		<!-- <td width="15%" class="blue">业务列表</td>
			  		<td>
			  			<input type="text" id="opcodeName"  name="opcodeName" value="" class="treetext" readonly="readonly" v_must=1 v_type=string/>
						<input type="hidden" id="opcode" name="opcode" value=""/>
						<input type="button" name="codeBtn" id="codeBtn" class="b_text"  value="选择" disabled="disabled" onclick="showAssignGroup();"/>
						<font class="orange">*</font>
			  		</td> -->
			    </tr>
		  	</table>
		 </div>
		 
		 <div>
			 <table>
			   <tr>
					<td align=center colspan="4" id="footer">
						<input type="button" value="录入" class="b_foot" onClick="subPage();"/>
						&nbsp;&nbsp;
						<input class="b_foot" id="resetBtn" name="resetBtn"  type="button" value="重置"  onclick="javascript:window.location.href='/npage/sm293/fm293Main.jsp?opName=<%=opName%>&opCode=<%=opCode%>'">
					</td>
				</tr>
			</table>
		</div>
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
	
	<!-- <div id="opcodeContent"  style="display:none; position: absolute;">
		<ul id="opcodeTree" class="ztree" style="margin-top:0; width:290px; height: 300px;"></ul>
	</div> -->
	
</body>
</html>
