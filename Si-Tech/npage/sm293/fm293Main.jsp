<%
  /*
   * ����: 
   * �汾: 1.0
   * ����: 2015/07/28 R_CMI_HLJ_guanjg_2015_2350528@���ڹ��ֹ�˾Ϊ�ڶ�������������뿪ͨ���֤ɨ����ʹ��Ȩ�޵���ʾ
   * ����: gejing
   * ��Ȩ: si-tech
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
		/*��*/
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
		/*���سɹ����� ����Ĭ����ת����ѯ��Դ����ҳ��*/
		/* function onAsyncSuccess(event, treeId, treeNode, msg) {
			$("#codeBtn").attr("disabled",false);
		}
		
		//�����ڵ�չ�����νṹ��ͨ��isLeaf�ֶ��ж������Ƿ����ӽڵ�
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
		    rdShowMessageDialog("���ؽڵ�ʧ�ܣ�",0);
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
			
			if(treeId.name == "ȫѡ"){
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
			
			/*��ֵ*/
			/* var opcodeName = $("#opcodeName");
			var opcode = $("#opcode");
			opcodeName.attr("value", v);
			opcodeName.attr("title", v);
			opcode.val(id);
			//hideMenu(); */
		/* } */
		/*չ�����νṹ����*/
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
		/*����*/
		
		function findGroupById(){
			//$("#opcodeName").val("");
			//$("#opcode").val("");
			$("#groupName").val("");
			//$("#codeBtn").attr("disabled","disabled");
			var iGroupId	= $("#groupId").val().trim();			//�������
			if(iGroupId == null || iGroupId == ''){
				rdShowMessageDialog("����д������룡",1);
				return false;
			}else{
				var packet = new AJAXPacket("fm293Query.jsp","���Ժ�...");
				packet.data.add("iLoginAccept" ,"");//��ˮ��������д�������Զ���ȡ
				packet.data.add("iChnSource" ,"01");//������ʶ
				packet.data.add("iOpCode" ,"<%=iOpCode%>");//��������
				packet.data.add("iLoginNo" ,"<%=iLoginNo%>");//��������	
				packet.data.add("iLoginPwd" ,"<%=iLoginPwd%>");//������������
				packet.data.add("iPhoneNo" ,"");//�ֻ�����
				packet.data.add("iUserPwd" ,"");//�û�����
				packet.data.add("iOpNote","��ѯ����");
				packet.data.add("iGroupId" ,iGroupId);//�������
				core.ajax.sendPacket(packet,getGroup,true);//�첽
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
					/* //��ʼ����
				  	$.fn.zTree.init($("#opcodeTree"), setting);
				 	zTree = $.fn.zTree.getZTreeObj("opcodeTree");
				 	//�������飬�����ڵ�
				 	
				 	zTree.addNodes(null, {"id":000,"name":"ȫѡ"});
				 	
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
			var iGroupId = $("#groupId").val();//�������
			var iGroupName	= $("#groupName").val().trim();			
			//var opcode = $("#opcode").val();
			if(iGroupName == null || iGroupName == ''){
				rdShowMessageDialog("����д���㣬����ѯ�����У�飡",1);
				return false;
			}
			/* else if(opcode == null || opcode == ''){
				rdShowMessageDialog("��ѡ��ҵ��",1);
				return false;
			} */
			
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
				/*ajax start*/
				var getdataPacket = new AJAXPacket("fm293Submit.jsp","�����ύ���ݣ����Ժ�......");
				getdataPacket.data.add("iLoginAccept" ,"");//��ˮ��������д�������Զ���ȡ
				getdataPacket.data.add("iChnSource" ,"01");//������ʶ
				getdataPacket.data.add("iOpCode" ,"<%=iOpCode%>");//��������
				getdataPacket.data.add("iLoginNo" ,"<%=iLoginNo%>");//��������	
				getdataPacket.data.add("iLoginPwd" ,"<%=iLoginPwd%>");//������������
				getdataPacket.data.add("iPhoneNo" ,"");//�ֻ�����
				getdataPacket.data.add("iUserPwd" ,"");//�û�����
				getdataPacket.data.add("iOpNote","¼���������������");//��ע
				getdataPacket.data.add("iGroupId" ,iGroupId);//������� �ش�
				
				core.ajax.sendPacket(getdataPacket,doSuccess,true);
				getdataPacket = null;
			}
			
		}
		
		function doSuccess(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				rdShowMessageDialog("¼��ɹ���",2);
				window.location.reload();
			} else{
				rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
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
					<td width="15%" class="blue">�������</td>
			  		<td>
			  			<input type="text" id="groupId" v_type=string onblur="findGroupById();"/>
			  		</td>
			  		<td width="15%" class="blue">��������</td>
			  		<td>
			  			<input type="text" id="groupName" value="" v_type=string v_must=1  readonly="readonly" disabled="disabled"/>
			  			<font class="orange">*</font>
			  		</td>
			   		<!-- <td width="15%" class="blue">ҵ���б�</td>
			  		<td>
			  			<input type="text" id="opcodeName"  name="opcodeName" value="" class="treetext" readonly="readonly" v_must=1 v_type=string/>
						<input type="hidden" id="opcode" name="opcode" value=""/>
						<input type="button" name="codeBtn" id="codeBtn" class="b_text"  value="ѡ��" disabled="disabled" onclick="showAssignGroup();"/>
						<font class="orange">*</font>
			  		</td> -->
			    </tr>
		  	</table>
		 </div>
		 
		 <div>
			 <table>
			   <tr>
					<td align=center colspan="4" id="footer">
						<input type="button" value="¼��" class="b_foot" onClick="subPage();"/>
						&nbsp;&nbsp;
						<input class="b_foot" id="resetBtn" name="resetBtn"  type="button" value="����"  onclick="javascript:window.location.href='/npage/sm293/fm293Main.jsp?opName=<%=opName%>&opCode=<%=opCode%>'">
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
