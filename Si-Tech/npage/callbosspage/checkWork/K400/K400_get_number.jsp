<%
  /*
   * ����: ��ȡ�Զ���������������Ϣ
�� * �汾: 1.0.0
�� * ����: 
�� * ����: 
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	String opCode = "K400";
	String opName = "����ˮ�����Զ�����";
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
<title>���ò���ֵ</title>
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
	//��ȡ�����ˮ����
	function getSerialNos(){
		var plan_id = '<%=plan_id%>';
		var bqcgrouptype = '<%=bqcgrouptype%>';
		var returnNum = document.getElementById("returnNum").value;
		if(returnNum == "" || returnNum == undefined ){
					similarMSNPop("������������");
					sitechform.returnNum.focus();
					return false;
				}
				
		var   r   =   /^\+?[1-9][0-9]*$/;
		if(!r.test(returnNum)){
			similarMSNPop("����ֻ������������ ");
			return false;
		}
		if(parseInt(returnNum)>10){
			similarMSNPop("ÿ������ȡ10����¼�� ");
			return false;
		}
		var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K400/K400_getSerialNos.jsp","���Ժ�...");
    chkPacket.data.add("plan_id",plan_id);
    chkPacket.data.add("bqcgrouptype",bqcgrouptype);
    chkPacket.data.add("returnNum", returnNum);
    core.ajax.sendPacket(chkPacket,doProcessGetSerialNos,true);
		chkPacket =null;
	}
	
	/*�Է���ֵ���д���*/
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
			//similarMSNPop("����ʧ��");
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
	/*ȡ���صĵ�һ����¼*/
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
					//var path = '/npage/callbosspage/checkWork/K400/K400_exec_out_plan_qc_main.jsp?serialnum=' + serialnum + '&qc_objectvalue=' + qc_objectvalue + '&qc_contentvalue=' + qc_contentvalue + '&object_id='+object_id+ '&group_flag=' + group_flag + '&opCode=K400&opName=�Զ��ʼ�&content_id=' + content_id +'&isOutPlanflag=0&staffno=' + staffno + '&plan_id=' + plan_id + '&qc_flag=' + qc_flag + '&out_returnVal=' + out_returnVal + '&returnNum=' + returnNum  ;
					var path = '/npage/callbosspage/checkWork/K400/K400_out_plan_qc_form.jsp?serialnum=' + serialnum + '&qc_objectvalue=' + qc_objectvalue + '&qc_contentvalue=' + qc_contentvalue + '&object_id='+object_id+ '&group_flag=' + group_flag + '&opCode=K400&opName=�Զ��ʼ�&content_id=' + content_id +'&isOutPlanflag=0&staffno=' + staffno + '&plan_id=' + plan_id + '&qc_flag=' + qc_flag + '&out_returnVal=' + out_returnVal + '&returnNum=' + returnNum  ;
					var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
					var tabId = opCode+serialnum;
					if(!opener.parent.parent.document.getElementById(tabId)){
							path = path+'&tabId='+tabId;
					    opener.parent.parent.addTab(true,tabId.trim(),'�Զ�����',path);
					    opener.parent.parent.removeTab("K400");
					    window.close();
					}else{
							similarMSNPop("����ˮ�ʼ촰���Ѵ򿪣�");
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
	  		<th width="40%">��������</th>
	  		<th width="40%">����ֵ</th>
  		</tr>
  		<tr>
  			<td width="40%">���ؼ�¼��</td>
  			<td>
      			<input type="text" name="returnNum" id="returnNum" value="" size="15">
    		</td>
			</tr>
		</table>	
		<table width="90%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
            <input class="b_text" name="submit" type="button" value="ȷ��" onclick="getSerialNos();">
       		<input class="b_text" name="back" type="button" onclick="grpClose();" value="�ر�"  >
        </td>
       </tr>  
     </table>
	</div>
</form>
</body>
</html>
