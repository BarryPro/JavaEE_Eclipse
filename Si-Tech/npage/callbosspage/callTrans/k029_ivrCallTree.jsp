<%@ page language="java"  pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<HTML>    
    <HEAD>    
        <LINK href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/style.css" type=text/css rel=STYLESHEET>    
        <LINK href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=STYLESHEET>    
        <SCRIPT src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></SCRIPT>    
        <SCRIPT src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></SCRIPT>
      </HEAD>
          
<BODY>           
<TABLE><TR><TD vAlign=top >
<DIV id="baseTree" ></DIV>
</TD>
<TD vAlign=top>
<DIV id="childTree">
	</DIV>
</TD>
        	
        </TR>
        
        </TABLE>
</BODY>        
</html>  
<SCRIPT type=text/javascript>
var ext2;
var typeFlag;
var toAthouDigitcode;
var inFlag = parent.document.getElementById("inFlag").value;
var CalledNo = parent.document.getElementById("CalledNo").value;
var CityCode = parent.document.getElementById("CityCode").value;
var UserClass = parent.document.getElementById("UserClass").value;
var ServiceNo = parent.document.getElementById("ServiceNo").value;
var userTypeBegin = parent.document.getElementById("userTypeBegin").value;
function fixImage(id) {
	switch (tree.getLevel(id)) {
	case 0:
		tree.setItemImage2(id, 'folderClosed.gif', 'folderOpen.gif',
				'folderClosed.gif');
		break;
	case 1:
		tree.setItemImage2(id, 'folderClosed.gif', 'folderOpen.gif',
				'folderClosed.gif');
		break;
	case 2:
		tree.setItemImage2(id, 'folderClosed.gif', 'folderOpen.gif',
				'folderClosed.gif');
		break;
	case 3:
		tree.setItemImage2(id, 'folderClosed.gif', 'folderOpen.gif',
				'folderClosed.gif');
		break;
	default:
		tree.setItemImage2(id, 'leaf.gif', 'folderClosed.gif',
				'folderOpen.gif');
		break;
	}
}
// 响应鼠标单击事件，查询数据库得到下一节点

function onNodeSelect(id) {
	var isLeaf = tree.getUserData(tree.getSelectedItemId(), "typeid");
	if (isLeaf == '2001' || isLeaf == '2003') {
		tree.showItemSign(tree.getSelectedItemId(), 1);
		if (tree.getOpenState(id) == 1) {
			tree.closeAllItems(id);
		} else if (tree.getOpenState(id) == -1) {
			tree.openItem(id);
		} else {
			getTreeListByNodeId(tree.getSelectedItemId()); // 用ajax动态查询数据
		}
	} else {
		if (tree.isItemChecked(id) == 0) {
			tree.setCheck(id, true);
			onCheckBoxsBySelect(id);
		} else {
			tree.setCheck(id, false);
			deleteBoxList(id);
		}
	}

}
// 响应checkbox选中事件，把提示信息显示到另外一个页面
// yanghy 20090917 添加最大数量的限制.最大数量是5.
function onCheckBoxsBySelect(id){
	var inReg;
	var arr;
	var allCheckItem=tree.getAllCheckedBranches();
	var isLeaf=tree.getUserData(id,"typeid");
	var digitcode=tree.getUserData(id,"digitcode");
	var ttansfercode=tree.getUserData(id,"ttansfercode");
	var typeId=tree.getUserData(id,"typeid");
	var usertype=tree.getUserData(id,"usertype");
	// 如果为业务办理传00，如果为咨询传01
	if(tree.isItemChecked(id)==0)
	{
		deleteBoxList(id);
	}
	if(tree.isItemChecked(id) != 0){// 判断选择开始.
		if(isLeaf=='2001'||isLeaf=='2002'){
			inReg="00";
		}
		if(isLeaf=='2003'||isLeaf=='2004'){
			inReg="01";
		}
		arr =allCheckItem.split(",");
		if( arr.length==2 ){
			typeFlag=tree.getUserData(arr[0],"typeid");
			ext2=id+"~"+inReg+"^"+CityCode+"^"+UserClass+"^"+userTypeBegin+"^"+digitcode+"^"+ServiceNo;
			if(typeFlag=='2001' || typeFlag=='2003'){
				toAthouDigitcode=digitcode;
			}
			else{
				toAthouDigitcode=digitcode.substr(0,2);
			}
			showNodeIdList(allCheckItem,id,ttansfercode,typeId,toAthouDigitcode,usertype);
		}
		if(arr.length>2){
			if(typeFlag=='2001'||typeFlag=='2003'){
				tree.setCheck(id,false); 
			}
			if(typeFlag=='2002'||typeFlag=='2004'){
				if(isLeaf=='2001'||isLeaf=='2003'){
					tree.setCheck(id,false);
				}
				else{
					ext2=ext2+","+id+"~"+inReg+"^"+CityCode+"^"+UserClass+"^"+userTypeBegin+"^"+digitcode+"^"+ServiceNo; 	
					showNodeIdList(allCheckItem,id,ttansfercode,typeId,toAthouDigitcode,usertype); 
				} 
			}
		}
	}// 判断选结束.
}   
	
// 取消所有的checkbox选中
function unCheckBoxBySelect(){
	var allCheckItem = tree.getAllCheckedBranches();
	if(allCheckItem != null && allCheckItem != ''){
		var str = new Array();
		str = allCheckItem.split(",");
		for(var i=0;i<str.length;i++){
			tree.setCheck(str[i],false);
		}
	}
}
// 取消
function deleteBoxList(node_id)
{
	var par_object=parent.document.getElementById("show_Name");
	var par_del_child=parent.document.getElementById("node_id");
	var children = par_object.childNodes; 
	deleteShowName(node_id);  
	for(var i=0;i<children.length;i++){	
		if(children[i].id==node_id){	
			par_object.removeChild(children[i]); 
		}
	}
	ext2=removeExt(ext2,node_id);
	parent.document.form1.ext2.value=ext2;
	var myselect=parent.document.form1.select_Name.options;
	for(var i=0;i<myselect.length;i++){
		if(myselect[i].value==node_id){
			myselect.remove(i);
			break;
		}
	}
}
function sendData(ttansfercode,typeId,toAthouDigitcode,usertype){
 // 组织数据，转IVR,取得ttansfercode
	parent.document.form1.ttansfercode.value=ttansfercode;
	parent.document.form1.typeId.value=typeId;
	parent.document.form1.DigitCode.value=toAthouDigitcode;
	parent.document.form1.userType.value=usertype;
	parent.document.form1.ext2.value=ext2;
	// alert("parent.document.form1.ext2.value"+parent.document.form1.ext2.value);
}
// 构建一个动态树
function initBaseTree(){
// 得到随路数据
	tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);    
	tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");   
	tree.enableCheckBoxes(1);
	// tree.enableDragAndDrop(1);
	tree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/callTrans/k029_createIvrTreeXml.jsp?CalledNo="+CalledNo+"&CityCode="+CityCode+"&UserClass="+UserClass+"&ServiceNo="+ServiceNo+"&inFlag="+inFlag);      
	tree.setOnClickHandler(onNodeSelect);
	tree.setOnCheckHandler(onCheckBoxsBySelect);
	tree.enableHighlighting(0);
	// tree.disableCheckbox("0",1);
	tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/callTrans/k029_createIvrTreeXml.jsp?CalledNo="+CalledNo+"&CityCode="+CityCode+"+&UserClass="+UserClass+"&ServiceNo="+ServiceNo+"&inFlag="+inFlag);
}    

// 根据选中的节点集合根据数据库里的值判断过滤到只留叶子节点
// 根据选中的节点id 返回该节点下子节点

function getTreeListByNodeId(strSelectedNodeid){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/callTrans/k029_getChildTreeList.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("nodeId",strSelectedNodeid);
	packet.data.add("inFlag",inFlag);
	core.ajax.sendPacket(packet,doProcessGetList,false);
	packet=null;
}
// getTreeListByNodeId的回调函数
function doProcessGetList(packet){
	var childNodeList = packet.data.findValueByName("worknos");
	var nodeId= packet.data.findValueByName("nodeId");
	insertChildNodeList(childNodeList);
} 
// 做插入操作的函数
function insertChildNodeList(retData){
	var varSubItems=tree.getSubItems(tree.getSelectedItemId()) ;
   	if( varSubItems == null || varSubItems == '' ){
		for(var i=0;i<retData.length;i++){
			tree.insertNewItem(retData[i][1],retData[i][0],retData[i][3],0,0,0,0,'SELECT') ; 
			tree.setUserData(retData[i][0],"superid",retData[i][1]);
			tree.setUserData(retData[i][0],"typeid",retData[i][2]);	
			tree.setUserData(retData[i][0],"servicename",retData[i][3]);
			tree.setUserData(retData[i][0],"ttansfercode",retData[i][4]);
			tree.setUserData(retData[i][0],"digitcode",retData[i][5]);
			tree.setUserData(retData[i][0],"userclass",retData[i][6]);
			tree.setUserData(retData[i][0],"usertype",retData[i][7]);
			// alert("getSubItems is null:\t"+retData[i][2]);
			if(retData[i][2]=='2001' || retData[i][2]=='2003'){
				// tree.showItemCheckbox(retData[i][0],0);
				// alert("retData[i][0]"+retData[i][0]);
				tree.showItemSign(retData[i][0],1);
				tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
			}	
			if(retData[i][2]=='2002' || retData[i][2]=='2004'){
				// tree.showItemCheckbox(retData[i][0],1);
				tree.showItemSign(retData[i][0],0);
				tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');		
			}	
		}
	}
}
// 将树的信息显示在页面下方
function showNodeIdList(allCheckItem,id,ttansfercode,typeId,toAthouDigitcode,usertype){
	sendData(ttansfercode,typeId,toAthouDigitcode,usertype); 
	// var els=parent.document.getElementsByTagName("span");
	// 得到选中节点名字
	var onCheckItemName=tree.getUserData(id,"servicename");
	var isLeaf=tree.getUserData(id,"typeid");
	// 将数据显示
	if(!isInShowName(id)){
		parent.document.form1.node_Id.value=parent.document.form1.node_Id.value+","+id;
		// parent.show_Name.innerHTML=parent.show_Name.innerHTML+"<span
		// id='"+id+"'>"+id+'→'+onCheckItemName+'<br></span>';
		var mytext=id+'→'+onCheckItemName;
		var myvalue=id;
		var myOption = new Option(mytext,myvalue);
		// alert("parent.select_Name"+parent.document.form1.select_Name);
		parent.document.form1.select_Name.options.add(myOption);
		// var aa=parent.document.form1.select_Name.options.add(new
		// Option(mytext,myvalue));
		// alert("aa"+aa)
		parent.document.form1.show_Name.value=parent.document.form1.show_Name.value+","+id+'→'+onCheckItemName;
		parent.document.getElementById("node_Name").value=parent.document.form1.show_Name.value;
		// parent.document.form1.node_Name.value=parent.show_Name.innerHTML;
	}
}
initBaseTree();
// 从数组中移出选定的项，返回剩余的项
function removeExt(ext,id){
	var dataStr='';
	var str=ext.split(",");
	if(ext==''||id==''||ext==undefined ||id==undefined){return false;}
	for(var i=0;i<str.length;i++){
		if(str[i].substr(0,str[i].indexOf("~"))==id){
			dataStr=str.slice(0,i)+','+str.slice(i+1);
			return dataStr;
		}
	}
}
 /*
	 * 从数组中删除选中相同的数据
	 */
function deleteShowName(node_id){
	var elsId=parent.document.getElementById("node_Id").value;
	var elsName = parent.document.getElementById("node_Name").value;
	var elsArray=elsId.split(",");
	var elsNameArray = elsName.split(",");
	var node_name = tree.getUserData(node_id,"servicename");
	node_name = node_id+"→"+node_name;
	if(elsId==null||elsId==undefined)return false;
	for(var i=1;i<elsArray.length;i++){
		if(elsArray[i]==node_id){
			elsArray.splice(i,1);
			parent.document.form1.node_Id.value=elsArray.toString();
		}
	}
	for(var i=1;i<elsNameArray.length;i++){
		if(elsNameArray[i]==node_name){
			elsNameArray.splice(i,1);
			parent.document.form1.node_Name.value=elsNameArray.toString();
			parent.document.form1.show_Name.value=elsNameArray.toString();
		}
	}
}
  
 /*
	 * 判断节点ID是否在选中的集合中
	 */
function isInShowName(node_id){
	var els =parent.document.form1.select_Name.options;
	if(els.length<0)return false;
	for(var i=0;i<els.length;i++){
		if(els[i].value==node_id){
			return true;
		}
	}
	return false;
}  
</SCRIPT>  