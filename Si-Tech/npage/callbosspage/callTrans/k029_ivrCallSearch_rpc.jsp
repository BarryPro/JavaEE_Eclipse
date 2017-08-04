<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
String flag = ( null == request.getParameter("flag") ? "0" : request.getParameter("flag") );
String searchName = ( null == request.getParameter("searchName") ? "" : request.getParameter("searchName") );
String calledNo = ( null == request.getParameter("calledNo") ? "" : request.getParameter("calledNo") );
String userClass = ( null == request.getParameter("userClass") ? "" : request.getParameter("userClass") );
String cityCode = ( null == request.getParameter("cityCode") ? "" : request.getParameter("cityCode") );
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
System.out.println("呼叫转移参数测试.\tsearchName="+searchName+"\tflag="+flag+"\t&calledNo="+calledNo+"\t&calledNo="+calledNo+"\t&userClass="+userClass+"\t&cityCode="+cityCode);
String sqlStr = "";
StringBuffer searchStr = new StringBuffer();
if(!"".equals(searchName)){
if(flag.equals("0")){
	sqlStr = " select a.id,a.superid ,a.typeid,a.servicename,a.ttansfercode,a.digitcode,a.userclass,a.usertype from DSCETRANSFERTAB a where 1=1 ";
	if(!calledNo.equals(""))
	sqlStr += " and a.accesscode = :calledNo ";
	myParams = "calledNo="+calledNo;
	if(!userClass.equals(""))
	sqlStr +=" and a.userclass = :userClass ";
	myParams = myParams + ",userClass="+userClass;
	if(!cityCode.equals(""))
	sqlStr += " and a.citycode = :cityCode ";
	sqlStr += " and a.servicename like '%'||:searchName||'%'  ";
	sqlStr += " and a.typeid not in ('0','1','2','3') and not exists( select 1 from DSCETRANSFERTAB b where b.superid = a.id )   order by a.id" ;
	myParams = myParams + ",cityCode="+cityCode+",searchName="+searchName;
	searchStr.append("<div>");
	searchStr.append("<span style='font: bold ;' style='cursor:hand'>");
	searchStr.append("转业务办理搜索结果：");
	searchStr.append("</span></div>");
}
else{
	sqlStr = " select a.id,a.superid ,'2004',a.servicename,a.transfercode,a.digitcode,a.userclass,a.usertype from DZXSCETRANSFERTAB a where 1=1 ";
	if(!calledNo.equals(""))
	sqlStr += " and a.accesscode = :calledNo ";
	myParams = "calledNo="+calledNo;
	if(!userClass.equals(""))
	sqlStr += " and a.userclass = :userclass ";
	myParams = myParams + ",userclass="+userClass;
	if(!cityCode.equals(""))
	sqlStr += " and a.citycode = :cityCode ";
	sqlStr += " and a.servicename like '%'||:searchName||'%' ";
	myParams = myParams+",cityCode="+cityCode+",searchName="+searchName;
	sqlStr += " and a.visiable = '1' " ;
	sqlStr += " and (a.typeid = '2004' or not exists( select 1 from DZXSCETRANSFERTAB b where b.superid = a.id and b.visiable='1')) order by a.id ";
	/**修改叶子节点判断.2004是叶子节点.sqlStr += " and not exists( select 1 from DZXSCETRANSFERTAB b where b.superid = a.id ) order by a.id" ;*/
	searchStr.append("<div>");
	searchStr.append("<span style='font: bold ;' style='cursor:hand'>");
	searchStr.append("转咨询语音搜索结果：");
	searchStr.append("</span></div>");
}
/**System.out.println("呼叫转移.sql.");*/
/**System.out.println(sqlStr);*/
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
<wtc:param value="<%=sqlStr%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>	
<% 
searchStr.append("\n<TABLE><TR><TD vAlign=top>\n");
for (int i = 0; i < queryList.length; i++) {
  if(queryList[i][2].equals("2001")||queryList[i][2].equals("2003")){
	  //searchStr.append(" open=\"0\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\">");
        //xml.append(" child=\"1\">");   
    }else {    
    	//searchStr.append(" im0=\"leaf.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\">"); 
        //xml.append(" child=\"0\">");     
    }
	searchStr.append("\n<div class='child_show' style='padding: 0px;margin: 0px;'>\n");
	searchStr.append("<img style='cursor:hand' align=absMiddle border=0 src='/npage/callbosspage/k170/tree/images/T.gif'>");
	searchStr.append("<img style='cursor:hand' align=absMiddle border=0 src='/npage/callbosspage/k170/tree/images/icon-page.gif'>");
	searchStr.append("<input type='checkbox' onclick=\"checkBoxClick('");
	searchStr.append(queryList[i][0]);/**id*/
	searchStr.append("');\"  value='");
	searchStr.append(queryList[i][0]);/**id*/
	searchStr.append("' id ='chk");
	searchStr.append(queryList[i][0]);/**id*/
	searchStr.append("'><span class='item' style='cursor:hand' onclick=\"spanClick('");
	searchStr.append(queryList[i][0]);/**id*/
	searchStr.append("');return false;\" id='m");
	searchStr.append(queryList[i][0]);/**id*/
	searchStr.append("span' typeid='");
	searchStr.append(queryList[i][2]);/**typeid*/
	searchStr.append("' servicename='");
	searchStr.append(queryList[i][3]);/**servicename*/
	searchStr.append("' ttansfercode='");
	searchStr.append(queryList[i][4]);/**ttansfercode*/
	searchStr.append("' digitcode='");
	searchStr.append(queryList[i][5]);/**digitcode*/
	searchStr.append("' usertype='");
	searchStr.append(queryList[i][7]);/**usertype*/
	searchStr.append("' >");
	searchStr.append(queryList[i][3]);/**servicename*/
	searchStr.append("</span>\n</div>");
  
	/**searchStr.append("<userdata name='typeid'>"+queryList[i][2]+"</userdata>");  
	searchStr.append("<userdata name='super_id'>"+queryList[i][1]+"</userdata>");   
	searchStr.append("<userdata name='servicename'>"+queryList[i][3]+"</userdata>");
	searchStr.append("<userdata name='ttansfercode'>"+queryList[i][4]+"</userdata>"); 
	searchStr.append("<userdata name='digitcode'>"+queryList[i][5]+"</userdata>"); 
	searchStr.append("<userdata name='userclass'>"+queryList[i][6]+"</userdata>"); 
	searchStr.append("<userdata name='usertype'>"+queryList[i][7]+"</userdata>");*/
	}
searchStr.append("\n</TD></TR></TABLE>\n");
}
%>
<html>
<body>
<head>
<script src="<%=request.getContextPath()%>/njs/csp/mixedtree.js" type=text/javascript></script>
</head>
<style>
body {
	margin: 0;
	padding: 0;
	font: 12px Verdana, Arial, Helvetica, sans-serif, "宋体" ， "黑体";
	line-height: 1.8em;
	text-align: left;
	color: #003399;
	background-color: #eef2f7;
}
html {
	scrollbar-face-color: #d5e1f7;
	scrollbar-highlight-color: #FFFFFF;
	scrollbar-shadow-color: #DEEBF7;
	scrollbar-3dlight-color: #89b3e3;
	scrollbar-arrow-color: #121f54;
	scrollbar-track-color: #F4F0EB;
	scrollbar-darkshadow-color: #89b3e3;
	overflow: hidden;
}
</style>
<div style="height: 340px;width: 99%;margin: 0;border: 0;overflow: auto;background-color: white;">
					<%=searchStr %>
</div>
<script type=text/javascript>
var ext2 = parent.document.form1.ext2.value;
var typeFlag;
var toAthouDigitcode;
var inFlag = parent.document.getElementById("inFlag").value;
var CalledNo = parent.document.getElementById("CalledNo").value;
var CityCode = parent.document.getElementById("CityCode").value;
var UserClass = parent.document.getElementById("UserClass").value;
var ServiceNo = parent.document.getElementById("ServiceNo").value;
var userTypeBegin = parent.document.getElementById("userTypeBegin").value;
// 取消所有的checkbox选中
function unCheckBoxBySelect() {
	//alert();
	var checkBoxItems = document.getElementsByTagName("input");
	for ( var i = 0; i < checkBoxItems.length; i++) {
		if (checkBoxItems[i].type == 'checkbox'
				&& checkBoxItems[i].checked == true) {
			checkBoxItems[i].checked = false;
		}
	}
}
//取消
function deleteBoxList(node_id) {
	var par_object = parent.document.getElementById("show_Name");
	var par_del_child = parent.document.getElementById("node_id");
	var children = par_object.childNodes;
	deleteShowName(node_id);
	for ( var i = 0; i < children.length; i++) {
		if (children[i].id == node_id) {
			par_object.removeChild(children[i]);
		}
	}
	ext2 = removeExt(ext2, node_id);
	parent.document.form1.ext2.value = ext2;
	var myselect = parent.document.form1.select_Name.options;
	for ( var i = 0; i < myselect.length; i++) {
		if (myselect[i].value == node_id) {
			myselect.remove(i);
			break;
		}
	}
}
//TODO 添加短信查询.
function findMessegeByCheckedId() {
	//yanghy添加查询短信代码.2009.09.07 BEGIN
	var checkBoxItems = document.getElementsByTagName("input");
	var ids = "";
	for ( var i = 0; i < checkBoxItems.length; i++) {
		if (checkBoxItems[i].type == 'checkbox'
				&& checkBoxItems[i].checked == true) {
			ids += checkBoxItems[i].value + ",";
		}
	}
	//alert(msgValue);
	//alert(parent.sendSMS.document.getElementById("msg_content").value = msgValue);
	$.ajax({
		url : '<%=request.getContextPath()%>/npage/callbosspage/callTrans/findMessegeById_rpc.jsp?ids=' + ids,
		//data: sendData,
		type : "POST",
		dataType : "html",
		success : function(data) {
				//alert(data.trim());
				var temp_1 = eval('(' + data.trim() + ')');//将json,类型进行转换.
				//alert(parent.sendSMS);
				//if(parent.sendSMS.document == null){rdShowMessageDialog("页面加载请稍后！");}
				if (temp_1.data.length > 0) {//查询到数据将第一个显示.将数组传到对话框里面.
					parent.sendSMS.document.getElementById("msg_content").value = temp_1.data[0];//显示第一个元素.
					parent.sendSMS.document.getElementById("show_array_div").innerHTML = temp_1.show_array_div;
					//显示动态生成的连接.
					parent.sendSMS.messageArray = temp_1.data;
					//alert(temp_1.show_array_div);
					parent.sendSMS.onCharsChange(parent.sendSMS.document
							.getElementById("msg_content").value);
					//调用计算字数函数.
					//alert(temp_1.data);
				} else {//如果是没有查询到将数据置空.
					parent.sendSMS.document.getElementById("msg_content").value = "";
					parent.sendSMS.document.getElementById("show_array_div").innerHTML = "";
					parent.sendSMS.messageArray = new Array();
					parent.sendSMS.onCharsChange("");
				}
				temp_1 = null;
		}
	});

	//yanghy添加查询短信代码.2009.09.07 END
}
function sendData(ttansfercode, typeId, toAthouDigitcode, usertype) {
	//组织数据，转IVR,取得ttansfercode
	parent.document.form1.ttansfercode.value = ttansfercode;
	parent.document.form1.typeId.value = typeId;
	parent.document.form1.DigitCode.value = toAthouDigitcode;
	parent.document.form1.userType.value = usertype;
	parent.document.form1.ext2.value = ext2;
	//alert("parent.document.form1.ext2.value"+parent.document.form1.ext2.value);

}

function spanClick(par_id) {
	//alert();
	changeColor(par_id);
	var pardiv = document.getElementById('m' + par_id + 'span');
	//针对非叶子节点，打开加载数据
	if (pardiv.is_Leaf == '0') {
		//节点层数的限制
		if (pardiv.isOpen == '0') {
			if (pardiv.hasLoad == '0') {

				getChildren(par_id);
				pardiv.isOpen = '1';
				//pardiv.hasLoad='1';
				hideOrShow_(par_id);
			} else {
				pardiv.isOpen = '1';
				hideOrShow_(par_id);
			}
		} else {
			pardiv.isOpen = '0';
			hideOrShow_(par_id);
		}
	} else {
		var checkBoxItem = document.getElementById("chk" + par_id);
		if (checkBoxItem.checked == false) {
			checkBoxItem.checked = true;
		} else {
			checkBoxItem.checked = false;
		}
		checkBoxClick(par_id);
	}
}

function spandblClick(par_id) {

}
function checkBoxClick(id) {
	//alert(id);
	var pardiv = document.getElementById('m' + id + 'span');
	var inReg;
	var arr;
	var isLeaf = pardiv.typeid;
	var digitcode = pardiv.digitcode;
	var ttansfercode = pardiv.ttansfercode;
	var typeId = pardiv.typeid;
	var usertype = pardiv.usertype;
	changeColor(id);
	var checkBoxItem = document.getElementById("chk" + id);

	//yanghy 20090917 添加最大条数限制功能.将条数限制为5.BEGIN.
	var checkBoxItems_0 = document.getElementsByTagName("input");
	var max_id = 0;
	for ( var i = 0; i < checkBoxItems_0.length; i++) {
		if (checkBoxItems_0[i].type == 'checkbox'
				&& checkBoxItems_0[i].checked == true) {
			max_id ++;
		}
	}
	if(max_id > 5){
		rdShowMessageDialog("最多只能选择5个!",1);
		document.getElementById("chk" + id).checked = false;
		max_id = null;
		return;
	}
	checkBoxItems_0 = null;
	max_id = null;
	//yanghy 20090917 添加最大条数限制功能.将条数限制为5.END.
	
	//如果最大没有超过5条显示短信.yanghy添加查询短信代码.2009.09.07 BEGIN
	findMessegeByCheckedId();
	//yanghy添加查询短信代码.2009.09.07 END
	
	if (checkBoxItem.checked == false) {
		deleteBoxList(id);
	} else {
		if (isLeaf == '2001' || isLeaf == '2002') {
			inReg = "00";
		}
		if (isLeaf == '2003' || isLeaf == '2004') {
			inReg = "01";
		}
		var checkBoxItems = document.getElementsByTagName("input");
		var arr = new Array();
		var m = 0;

		for ( var i = 0; i < checkBoxItems.length; i++) {
			if (checkBoxItems[i].type == 'checkbox'
					&& checkBoxItems[i].checked == true) {
				arr[m] = checkBoxItems[i].value;
				m++;
			}
		}
		if (m == 1) {
			typeFlag = document.getElementById('m' + arr[0] + 'span').typeid;
			ext2 = id + "~" + inReg + "^" + CityCode + "^" + UserClass + "^"
					+ userTypeBegin + "^" + digitcode + "^" + ServiceNo;
			if (typeFlag == '2001' || typeFlag == '2003') {
				toAthouDigitcode = digitcode;
			} else {
				toAthouDigitcode = digitcode.substr(0, 2);
			}
			showNodeIdList('', id, ttansfercode, typeId, toAthouDigitcode,
					usertype);
		}
		if (m > 1) {
			if (arr[0] == checkBoxItem.value) {
				typeFlag = document.getElementById('m' + arr[1] + 'span').typeid;
			} else {
				typeFlag = document.getElementById('m' + arr[0] + 'span').typeid;
			}
			if (typeFlag == '2001' || typeFlag == '2003') {
				checkBoxItem.checked = false;
			}
			if (typeFlag == '2002' || typeFlag == '2004') {
				//外呼排除多选
				var outflag = top.opener.outCallFlag;
				if (outflag != undefined && outflag == 1) {
					checkBoxItem.checked = false;
				} else if (isLeaf == '2001' || isLeaf == '2003') {
					checkBoxItem.checked = false;
				} else {
					ext2 = ext2 + "," + id + "~" + inReg + "^" + CityCode + "^"
							+ UserClass + "^" + userTypeBegin + "^" + digitcode
							+ "^" + ServiceNo;
					showNodeIdList('', id, ttansfercode, typeId,
							toAthouDigitcode, usertype);
				}

			}
		}
	}
	//alert(parent.document.form1.node_Id.value);
	//alert(parent.document.form1.node_Name.value);
	//alert(parent.document.form1.show_Name.value);
	//alert(parent.document.form1.ext2.value);

}

//将树的信息显示在页面下方
function showNodeIdList(allCheckItem, id, ttansfercode, typeId,
		toAthouDigitcode, usertype) {
	sendData(ttansfercode, typeId, toAthouDigitcode, usertype);
	//var els=parent.document.getElementsByTagName("span");
	//得到选中节点名字
	var pardiv = document.getElementById('m' + id + 'span');
	var onCheckItemName = pardiv.servicename;
	var isLeaf = pardiv.typeid;
	//将数据显示
	if (!isInShowName(id)) {
		parent.document.form1.node_Id.value = parent.document.form1.node_Id.value
				+ "," + id;
		//parent.show_Name.innerHTML=parent.show_Name.innerHTML+"<span id='"+id+"'>"+id+'→'+onCheckItemName+'<br></span>';
		var mytext = id + '→' + onCheckItemName;
		var myvalue = id;
		var myOption = new Option(mytext, myvalue);
		//alert("parent.select_Name"+parent.document.form1.select_Name);
		parent.document.form1.select_Name.options.add(myOption);
		//var aa=parent.document.form1.select_Name.options.add(new Option(mytext,myvalue));
		//alert("aa"+aa);
		parent.document.form1.show_Name.value = parent.document.form1.show_Name.value
				+ "," + id + '→' + onCheckItemName;
		parent.document.getElementById("node_Name").value = parent.document.form1.show_Name.value;
		//parent.document.form1.node_Name.value=parent.show_Name.innerHTML; 
	}
}

//从数组中移出选定的项，返回剩余的项
function removeExt(ext, id) {
	var dataStr = '';
	var str = ext.split(",");
	if (ext == '' || id == '' || ext == undefined || id == undefined) {
		return false;
	}
	for ( var i = 0; i < str.length; i++) {
		if (str[i].substr(0, str[i].indexOf("~")) == id) {
			dataStr = str.slice(0, i) + ',' + str.slice(i + 1);
			return dataStr;
		}
	}
}
/*
 * 从数组中删除选中相同的数据
 */
function deleteShowName(node_id) {
	var elsId = parent.document.getElementById("node_Id").value;
	var elsName = parent.document.getElementById("node_Name").value;
	var elsArray = elsId.split(",");
	var elsNameArray = elsName.split(",");
	var pardiv = document.getElementById('m' + node_id + 'span');
	var node_name = pardiv.servicename;
	node_name = node_id + "→" + node_name;
	if (elsId == null || elsId == undefined)
		return false;
	for ( var i = 1; i < elsArray.length; i++) {
		if (elsArray[i] == node_id) {
			elsArray.splice(i, 1);
			parent.document.form1.node_Id.value = elsArray.toString();
		}
	}
	for ( var i = 1; i < elsNameArray.length; i++) {
		if (elsNameArray[i] == node_name) {
			elsNameArray.splice(i, 1);
			parent.document.form1.node_Name.value = elsNameArray.toString();
			parent.document.form1.show_Name.value = elsNameArray.toString();
		}
	}
}

/*
 *判断节点ID是否在选中的集合中
 */
function isInShowName(node_id) {
	var els = parent.document.form1.select_Name.options;
	if (els.length < 0)
		return false;
	for ( var i = 0; i < els.length; i++) {
		if (els[i].value == node_id) {
			return true;
		}
	}
	return false;
}
</script>  
</body>
</html>