<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 098权限角色管理->维护权限功能->新增(业务逻辑)
　 * 版本: 1.0.0
　 * 日期: 2008/1/16
　 * 作者: fangyuan
　 * 版权: sitech
   * update:  yinzx 2009/07/17  客服功能调试  1.修改获取地市的服务名 使用sPubSelect 2 修改了回去地市的语句 去掉了条件 valid_flag = 'Y' 3.去点地市的事件  onchange="region.value=this.options[this.selectedIndex].tex" 不清楚为何要加这个
   * modify by 20091009  修改regioncode　 
*/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>来电原因信息维护</title>

<script language=javascript>

// 清除表单记录
function cleanValue(){
document.getElementById("groupName").value="";
document.getElementById("region_code").value="";	
document.getElementById("note").value="";	
var obj = document.getElementsByName("flag")[0];
if(obj.checked==true)
 {	
  obj.checked=false;
 } 	
}

function closeWin(){
	window.close();
}
function getFlag()
{
  var obj = document.getElementsByName("flag")[0]; 
     var check;
      if(obj.checked == true){///选中 
           check="1";
      } 
      if(obj.checked == false){///取消 
            check="0";
      } 
    return check;
}
function addNewNode(){
	var nodeName = document.getElementById("groupName").value;
	var strValue=document.getElementById("nodeType").options[document.getElementById("nodeType").selectedIndex].value;
	var parNode=document.getElementById("parNode").value;
	var cityid=document.getElementById("region_code").value;
	var flag=getFlag();
	var note=document.getElementById("note").value;
	
	if(nodeName == ""){
		rdShowMessageDialog("请输入来电原因名称！",1);
		return;
	}if(cityid == ""){
		rdShowMessageDialog("请输入所属地市！",1);
		return;
	}
	window.opener.insertNewNode(parNode,nodeName,strValue,note,cityid,flag);
	window.close();
}
function showObjectCheckTree(){
  openWinMid('k280_objectIdTree.jsp','选择被检对象类别',300, 250);
}

function openWinMid(url,name,iHeight,iWidth)
{
  //var url; //转向网页的地址;
  //var name; //网页名称，可为空;
  //var iWidth; //弹出窗口的宽度;
  //var iHeight; //弹出窗口的高度;
  var iTop = (window.screen.availHeight-30-iHeight)/1.1; //获得窗口的垂直位置;
  var iLeft = (window.screen.availWidth-10-iWidth)/1.4; //获得窗口的水平位置;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}
</script>
</head>

<body >
	<%
	     /*midify by yinzx 20091113 公共查询服务替换*/
 
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);
	%>
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<table>
						<tr>
  				<td class="blue">节点类别</td>
  				<td width="70%">
<select name="nodeType" size="1" id="nodeType"  
    onChange="changeType();">
 <option value="0" selected>同层节点</option>
 <option value="1">同层子节点</option>
</select>
	  			</td>
			</tr>
			<tr>
  				<td class="blue">上层节点编号</td>
  				<td width="70%">
      <input id="parNode" name ="parNode" size="30" type="text" readOnly  Class="InputGrey" value="">
	  			</td>
			</tr>
			<tr>
  				<td class="blue">上层节点名称</td>
  				<td width="70%">
       <input id="nodeName" name ="nodeName" size="30" type="text" readOnly  Class="InputGrey" value="">
	  			</td>
			</tr>
			<tr>
  				<td class="blue">新增节点名称</td>
  				<td  width="70%">
  					<input id="groupName" name ="groupName" size="20" type="text" value="">
	    			<font color="orange">*</font>
	  			</td>
			</tr>
			<tr>
  				<td class="blue">所属地市</td>
  				<td  width="70%">
  				<select id="region_code" name="1_=_region_code" size="1" onchange="">
  				<option value="" selected>--选择地市--</option>
				   <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag='Y' order by region_code</wtc:sql>
				   </wtc:qoption>	
        </select>
	    			<font color="orange">*</font>
	    			<input id="flag" type="checkbox" name="flag" checked onclick="getFlag()">是否显示
	  			</td>	
			</tr>
			
			<tr>
  				<td class="blue">描述</td>
  				<td  width="60%">
  					<textarea name="note" cols="30" rows="4"></textarea>

	  			</td>
			</tr>
			<tr >
  				<td colspan="2" align="center">
   					<input name="add" type="button" class="b_text" id="add" value="确定" onClick="addNewNode()">
   					<input name="clean" type="button" class="b_text" id="clean" value="重设" onClick="cleanValue()">
   					<input name="close" type="button" class="b_text" id="close" value="取消" onClick="closeWin()">
  				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>
<SCRIPT type=text/javascript> 
//节点选择事件
initValue();	
function initValue(){	
	var selectItemId =window.opener.tree.getSelectedItemId();
	var level=window.opener.tree.getLevel(selectItemId);
	if(level=='1'){
		  
		  document.getElementById("nodeName").value=window.opener.tree.getSelectedItemText();
	    document.getElementById("parNode").value=window.opener.tree.getSelectedItemId();
	    document.getElementById("nodeType").value="1";
	    document.getElementById("nodeType").disabled = true;
		}else{
	    var parnertId    =window.opener.tree.getParentId(selectItemId);	
      var parnertName  =window.opener.tree.getItemText(parnertId);	
		  document.getElementById("nodeName").value=parnertName;
	    document.getElementById("parNode").value=parnertId;
			}


}

function changeType(){
     var strValue=document.getElementById("nodeType").options[document.getElementById("nodeType").selectedIndex].value;
     var selectItemId =window.opener.tree.getSelectedItemId();
		if(strValue=="0"){
			var parnertId    =window.opener.tree.getParentId(selectItemId);	
      var parnertName  =window.opener.tree.getItemText(parnertId);	
		  document.getElementById("nodeName").value=parnertName;
	    document.getElementById("parNode").value=parnertId;

		}else{
			document.getElementById("nodeName").value=window.opener.tree.getSelectedItemText();
	    document.getElementById("parNode").value=selectItemId;
		}	
	}

</SCRIPT>
