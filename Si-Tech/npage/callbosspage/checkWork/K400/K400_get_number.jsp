<%
  /*
   * 功能: 获取自动考评考评次数信息
　 * 版本: 1.0.0
　 * 日期: 
　 * 作者: 
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K400";
	String opName = "对流水进行自动考评";
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>


<%
	String plan_id = WtcUtil.repNull(request.getParameter("plan_id"));
	String object_id = WtcUtil.repNull(request.getParameter("object_id"));
	String group_flag = WtcUtil.repNull(request.getParameter("group_flag"));
	String bqcgrouptype = WtcUtil.repNull(request.getParameter("bqcgrouptype"));
	String content_id = WtcUtil.repNull(request.getParameter("content_id_checked"));
	String qc_objectvalue = WtcUtil.repNull(request.getParameter("qc_objectvalue"));
	String qc_contentvalue = WtcUtil.repNull(request.getParameter("qc_contentvalue"));
	String staffno =null;
	//out.print(plan_id+":"+object_id+":"+content_id_checked);
%>
<html>
<head>
<title>设置参数值</title>
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript"  src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script language=javascript>
	
	function grpClose(){
			window.opener = null;
			window.close();
	}
	//获取随机流水方法
	function getSerialNos(){
		var plan_id = '<%=plan_id%>';
		var bqcgrouptype = '<%=bqcgrouptype%>';
		var returnNum = document.getElementById("returnNum").value;
		if(returnNum == "" || returnNum == undefined ){
					similarMSNPop("请输入条数！");
					sitechform.returnNum.focus();
					return false;
				}
				
		var   r   =   /^\+?[1-9][0-9]*$/;
		if(!r.test(returnNum)){
			similarMSNPop("条数只能是正整数！ ");
			return false;
		}
		if(parseInt(returnNum)>10){
			similarMSNPop("每次最多抽取10条记录！ ");
			return false;
		}
		var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K400/K400_getSerialNos.jsp","请稍后...");
    chkPacket.data.add("plan_id",plan_id);
    chkPacket.data.add("bqcgrouptype",bqcgrouptype);
    chkPacket.data.add("returnNum", returnNum);
    core.ajax.sendPacket(chkPacket,doProcessGetSerialNos,true);
		chkPacket =null;
	}
	
	/*对返回值进行处理*/
function doProcessGetSerialNos(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var out_returnVal = packet.data.findValueByName("out_returnVal");
	var returnNum = packet.data.findValueByName("returnNum");
	if(retCode=="000000" && parseInt(returnNum)>0 ){
					similarMSNPop(retMsg);
					setTimeout(function(){openQcTab(out_returnVal,returnNum);},1200);
					//openQcTab(out_returnVal,returnNum);
	}else{
			//similarMSNPop("操作失败");
			similarMSNPop(retMsg);
			setTimeout("window.close()",1500);
	}
}

function openQcTab(out_returnVal,returnNum){
	var object_id = '<%=object_id%>';
	var content_id = '<%=content_id%>';
	var plan_id = '<%=plan_id%>';
	var group_flag = '<%=group_flag%>';
	var qc_objectvalue = '<%=qc_objectvalue%>';
	var qc_contentvalue = '<%=qc_contentvalue%>';
	var isOutPlanflag ="0";
	var opCode='<%=opCode%>';
	var returnNum = returnNum;
	var out_returnVal = out_returnVal;
	var getReturnVal;
	/*取返回的第一条记录*/
			if(out_returnVal.length>0){
					var loc = out_returnVal.indexOf("_",0);
					if(loc>0){
							getReturnVal = out_returnVal.substr(0,loc);
							out_returnVal = out_returnVal.substring(loc + 1,out_returnVal.length);
					}else{
							getReturnVal = out_returnVal;
					}
					
					var getArr = getReturnVal.split("-");
					var serialnum = getArr[0];
					var staffno = getArr[1];
					var qc_flag = getArr[2];
					/*
					for(var i=0;i<getArr.length;i++){
						alert(getArr[i]);
					}
					*/
					var tabId = opCode + getArr[0];
					//var path = '/npage/callbosspage/checkWork/K400/K400_exec_out_plan_qc_main.jsp?serialnum=' + serialnum + '&qc_objectvalue=' + qc_objectvalue + '&qc_contentvalue=' + qc_contentvalue + '&object_id='+object_id+ '&group_flag=' + group_flag + '&opCode=K400&opName=自动质检&content_id=' + content_id +'&isOutPlanflag=0&staffno=' + staffno + '&plan_id=' + plan_id + '&qc_flag=' + qc_flag + '&out_returnVal=' + out_returnVal + '&returnNum=' + returnNum  ;
					var path = '/npage/callbosspage/checkWork/K400/K400_out_plan_qc_form.jsp?serialnum=' + serialnum + '&qc_objectvalue=' + qc_objectvalue + '&qc_contentvalue=' + qc_contentvalue + '&object_id='+object_id+ '&group_flag=' + group_flag + '&opCode=K400&opName=自动质检&content_id=' + content_id +'&isOutPlanflag=0&staffno=' + staffno + '&plan_id=' + plan_id + '&qc_flag=' + qc_flag + '&out_returnVal=' + out_returnVal + '&returnNum=' + returnNum  ;
					var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
					var tabId = opCode+serialnum;
					if(!opener.parent.parent.document.getElementById(tabId)){
							path = path+'&tabId='+tabId;
					    opener.parent.parent.addTab(true,tabId.trim(),'自动考评',path);
					    opener.parent.parent.removeTab("K400");
					    window.close();
					}else{
							similarMSNPop("此流水质检窗口已打开！");
					}
			}
}
</script>

</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table" style="width:99%;">
		<table width="90%">
			<tr>
	  		<th width="40%">参数名称</th>
	  		<th width="40%">参数值</th>
  		</tr>
  		<tr>
  			<td width="40%">返回记录数</td>
  			<td>
      			<input type="text" name="returnNum" id="returnNum" value="" size="15">
    		</td>
			</tr>
		</table>	
		<table width="90%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
            <input class="b_text" name="submit" type="button" value="确认" onclick="getSerialNos();">
       		<input class="b_text" name="back" type="button" onclick="grpClose();" value="关闭"  >
        </td>
       </tr>  
     </table>
	</div>
</form>
</body>
</html>
