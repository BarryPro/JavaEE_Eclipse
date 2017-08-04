 <%
  /*
   * 功能: 勋章兑换礼品配置修改 e017
   * 版本: 1.0
   * 日期: 2011/7/5
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="import java.text.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
//---------------------------------java代码区------------------------------------
	String opCode = "e017";	
	String opName = "勋章兑换礼品配置修改";	//header.jsp需要的参数   
	//读取session信息
	String loginNo=(String)session.getAttribute("workNo");    //工号 
	String orgCode = (String)session.getAttribute("orgCode");   	
	String regionCode =(String)session.getAttribute("regCode");  
	String groupId =(String)session.getAttribute("groupId"); 
	String orgName =(String)session.getAttribute("orgName"); 
	String loginAccept=getMaxAccept();//获取流水
	%>
<html>
	<head>
	<title>勋章兑换礼品配置修改</title>
	<script language=javascript>
	onload=function() {
		self.status="";
	}

	function doProcess(packet) {
		self.status="";
		var type = packet.data.findValueByName("type");
		if(type == "call_giftInfo"){
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
			if(errCode=="000000")
			{
			  var loginNo=packet.data.findValueByName("loginNo");
			  var giftName=packet.data.findValueByName("giftName");
			  var giftDescribe=packet.data.findValueByName("giftDescribe");
			  var medalCount=packet.data.findValueByName("medalCount");
			  var beginTime=packet.data.findValueByName("beginTime");
			  var endTime=packet.data.findValueByName("endTime");
			  var groupId=packet.data.findValueByName("groupId");		  		  
			  var groupName=packet.data.findValueByName("groupName");		
			  var opNote=packet.data.findValueByName("opNote");		  
			  document.form1.giftDescribe.value=giftDescribe;
	      document.form1.giftName.value=giftName;
	      document.form1.medalCount.value=medalCount;     
			  document.form1.startTime.value=beginTime;
			  document.form1.endTime.value=endTime;
			  document.form1.groupId.value=groupId;
			  document.form1.oldGroupId.value=groupId;
			  
			  document.form1.groupName.value=groupName;
			  document.form1.opNote.value=opNote;
			  document.form1.submit1.disabled=false; 				
			}else
			{
				rdShowMessageDialog("获取礼品代码失败，错误信息："+errMsg+"，错误代码："+errCode,0);
				history.go(-1);
			}	
 
		  }
		}

	//----弹出一个新页面选择组织节点--- 增加
			function select_groupId(regionCode,row)
			{
				var path = "groupTreeUpdate.jsp";
			  window.open(path,'_blank','height=600,width=300,scrollbars=yes');
			}	
	
	//-----日历-----	
	function fPopUpCalendarDlg(timeName)
	{
		var time_name=document.getElementById(timeName);
		if(false)
		{
			showx = 220 ; // + deltaX;
			showy = 220; // + deltaY;
		}
		else
		{
			showx = event.screenX - event.offsetX - 4 - 210 ; // + deltaX;
			showy = event.screenY - event.offsetY + 18; // + deltaY;
		}
		newWINwidth = 210 + 4 + 18;
		if(false)
		{
			window.top.captureEvents (Event.CLICK|Event.FOCUS);
			window.top.onclick=IgnoreEvents;
			window.top.onfocus=HandleFocus;
			winPopupWindow.args = timeName;
			winPopupWindow.returnedValue = new Array();
			winPopupWindow.args = timeName;
			newWINwidth = 202;
			winPopupWindow.win = window.open("/js/common/date/CalendarDlg.htm","CalendarDialog","dependent=yes,left="+showx + ",top=" + showy + ",width="+newWINwidth + ",height=182px" )
			winPopupWindow.win.focus()
			return winPopupWindow;
		}
		else
		{
			retval = window.showModalDialog("/js/common/date/CalendarDlg.htm", "", "dialogWidth:197px; dialogHeight:210px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:yes;scrollbars:no;Resizable=no; ");
		}
		if(retval != null && retval != "")
		{
			retval = retval.replace(/\//g,"");
			var myDate = new Date();
			var year = myDate.getFullYear();
			var mon = myDate.getMonth();
			mon = mon + 1 + "";
			if(mon < 10){
				mon = "0" + mon;
			}
			var day = myDate.getDate();
			if(day < 10){
				day = "0" + day;
			}
			var today = year + mon + day;
			//alert("today : " + today + "|" + retval + "|")
	    time_name.value = retval;
		}
		else if(retval == "")
		{
			time_name.value = "";
		}else{
		}
	}
	//-----查询礼品代码-----
	function call_getGiftCode(){
  var group_Id = "<%=groupId%>";
	var pageTitle = "礼品选择";
	var fieldName = "地市代码|地市名称|礼品代码|礼品名称|营业厅代码|营业厅名称|";//弹出窗口显示的列、列名
	var selType = "S";    //'S'单选；'M'多选
	var retQuence = "6|0|1|2|3|4|5";//返回字段
	var retToField = "regionCode|regionName|giftCode|giftName|groupId|groupName|";//返回赋值的域
 	var sqlStr="select c.group_id,c.group_name,c.gift_code,c.gift_name,c.forgroup_id ,d.group_name  from( "+
			"select b.group_name,b.group_id,a.gift_code,a.gift_name,a.forgroup_id "+  
			"from sMedalCode a, dchngroupmsg b where a.GROUP_ID  ";
			if(group_Id=="10014")
			{
				sqlStr+=	"in ('10031','10032','10033','10034','10035','10036','10037','10038','10039','10040','10041','10042','10043') ";
			}else
			{
				sqlStr+=	"='"+group_Id+"' ";
			}
		
	sqlStr+="and a.group_id=b.group_id) c,dchngroupmsg d where c.forgroup_id=d.group_id"; 
  
  if(MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,80));
	}
	
function MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,dialogWidth)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    retInfo = window.showModalDialog(path,"","dialogWidth:"+dialogWidth);
    if(retInfo ==undefined)
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");

    }
    
    	//-----查询代理商帐户列表-----
		if(document.form1.giftCode.value!="")
		{
			var giftCode=document.form1.giftCode.value;
			var type = "call_giftInfo";
			var myPacket = new AJAXPacket("fe017_getInfo.jsp","正在提交，请稍候......");
			myPacket.data.add("regionCode",document.all.regionCode.value);
			myPacket.data.add("groupId",document.all.groupId.value);
			myPacket.data.add("giftCode",document.all.giftCode.value);
			myPacket.data.add("type",type);
			core.ajax.sendPacket(myPacket);
			myPacket=null;	  
		}
}	
		//--------------------------------提交表单------------------------------------
		function commit()
		{
			getAfterPrompt();
	if(document.form1.giftCode.value=="")
	{
		rdShowMessageDialog("礼品代码不能为空!");
		document.form1.giftCode.focus();
		return false;
	}		
	
	if(document.form1.regionCode.value=="")
	{
		rdShowMessageDialog("地市代码不能为空!");
		document.form1.regionName.focus();
		return false;
	}	
	if(document.form1.giftDescribe.value=="")
	{
		rdShowMessageDialog("礼品描述不能为空!");
		document.form1.giftDescribe.focus();
		return false;
	}		
	if(document.form1.giftName.value=="")
	{
		rdShowMessageDialog("礼品名称不能为空!");
		document.form1.giftName.focus();
		return false;
	}		
	if(document.form1.medalCount.value=="")
	{
		rdShowMessageDialog("扣勋章数不能为空!");
		document.form1.medalCount.focus();
		return false;
	}		
	if(document.form1.groupId.value=="")
	{
		rdShowMessageDialog("领取营业厅不能为空!");
		document.form1.groupId.focus();
		return false;
	}		
	if(document.form1.startTime.value=="")
	{
		rdShowMessageDialog("请选择开始时间!");
		document.form1.startTime.focus();
		return false;
	}	
	if(document.form1.endTime.value=="")
	{
		rdShowMessageDialog("请选择结束时间!");
		document.form1.endTime.focus();
		return false;
	}	
	var begin_time=document.form1.startTime.value;
	var end_time=document.form1.endTime.value;
	if(begin_time>=end_time)
  {
    rdShowMessageDialog("开始时间应小于结束时间，请重新输入！");
    return false;
  }
  if(document.form1.opNote.value=="" || document.form1.opNote.value.trim()=="勋章兑换礼品配置新增")
  {
  	document.form1.opNote.value="勋章兑换礼品配置修改";
  }		
  isSaleHall();	

 }

		//-----------------------------------空验证-----------------------------------------
		function checkform1(){
			if(check(document.form1)){
				return true;
		  }
		}

		//---------------------------------清空表单---------------------------------------
		function resetJSP(){
			document.form1.giftName.value = "";
			document.form1.giftDescribe.value = "";
			document.form1.medalCount.value = "";
			document.form1.groupName.value = "";
			document.form1.startTime.value = "";
			document.form1.endTime.value = "";
			document.form1.opNote.value = "";
		}
		
		
	 	 function isSaleHall()
	 	 {
				var myPacket = new AJAXPacket("fe017_isDisHall.jsp","正在提交，请稍候......");
				myPacket.data.add("groupId",document.all.groupId.value);
				myPacket.data.add("regionCode",document.all.regionCode.value);
				core.ajax.sendPacket(myPacket,doIsSaleHall);
				myPacket=null; 	 	
	 	 } 
	
	
	 	 function doIsSaleHall(packet){
					var isSaleHall = packet.data.findValueByName("isSaleHall");
					var errCode = packet.data.findValueByName("errCode");
					var errMsg = packet.data.findValueByName("errMsg");
					
					
			 		if(errCode=="000000")
			 		{
			 			if(isSaleHall=="1")
			 			{
			 				var isdisHall = packet.data.findValueByName("isdisHall");
							if(isdisHall=="1")
							{
									if(checkform1()){
										form1.action="fe017Cfm.jsp";
										form1.submit();
										return true;
									}	
							}else
							{
								rdShowMessageDialog("不能跨地市配置礼品!");
								document.form1.endTime.focus();									
							}	
			 			}else
			 			{
							rdShowMessageDialog("领取营业厅必须选至营业厅级!");
							document.form1.endTime.focus();		 				
			 			}	
			 			
			 		}
		 }		
</script>
</head>
<%//--------------------------------------页面区域--------------------------------------------%>
<body>
<form name="form1" method="post">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">基本信息</div>
		</div>
    <table  cellspacing="0">
      	<tr> 
            <td  class="blue" >礼品代码</td>
            <td> 
		            <input  type="text"  name="giftCode" value="" v_must="1" maxlength="8" readonly class="InputGrey">
            		<input type="button" name="getGiftCode" class="b_text" value="查询" onClick="call_getGiftCode()" >
            		<font class="orange">*</font>
            </td>
            <td class="blue">地市代码</td>
            <td> 
			          <input   type="hidden"  v_must="1" name="regionCode"  value="" readonly class="InputGrey">
			          <input   type="text"  v_must="1" name="regionName"  value="" readonly class="InputGrey">
            		<font class="orange">*</font>
            </td>            
        </tr>
        <tr> 
            <td class="blue">礼品名称</td>
            <td>
            	<input   type="text"  v_must="1" name="giftName" v_type="string" maxlength="50" size="40">
					    <font class="orange">*</font>
            </td>        	
            <td  class="blue">礼品描述</td>
            <td> 
			          <input type="text"   v_must="1" name="giftDescribe" value=""  maxlength="100" size="30">
            		<font class="orange">*</font>
            </td>
        </tr>
        <tr> 
            <td  class="blue">扣勋章数</td>
            <td> 
		          	<input   type="text"   name="medalCount" v_type="cfloat" onblur = "checkElement(this)" >
            		<font class="orange">*</font>
            </td>
            <td class="blue">领取营业厅</td>
            <td> 
		        		<input type="text" name="groupName" v_must="1" value=""  v_type="string" maxlength="60" class="button" readonly>&nbsp;<font color="orange">*</font>
								<input type="hidden" name="groupId">
								<input type="hidden" name="oldGroupId">
								<input name="addButton" class="b_text" type="button" value="选择" onClick="select_groupId()" >	
            </td>
        </tr>
        <tr> 
            <td  class="blue">开始时间</td>
            <td>    		
            	<input type="text" name="startTime" id="startTime" v_must="1" v_type="date" class="button" maxlength="8" readonly/>&nbsp;<font color="orange">*</font>
							<input type="button" name="dateButton" class="b_text" alt="弹出日历下拉菜单" onclick="fPopUpCalendarDlg('startTime');return false" value="日历" />            		
            </td>
            <td class="blue">结束时间</td>
            <td> 
							<input type="text" name="endTime" id="endTime" v_must="1" v_type="date" class="button" maxlength="8" readonly/>&nbsp;<font color="orange">*</font>
							<input type="button" name="dateButton" class="b_text" alt="弹出日历下拉菜单" onclick="fPopUpCalendarDlg('endTime');return false" value="日历" />			 
            </td>
        </tr>
        <tr> 
            <td  class="blue">备注</td>
            <td colspan="3"> 
            		<input type="text"   name="opNote"  size="60" maxlength="100">
            </td>

        </tr>
       </table>
       <table>
	        <tr> 
	            <td id="footer"> 	             
	                <input name="submit1" class="b_foot"  type="button"  value="确认" onClick="commit()" disabled>
	                &nbsp; 
	                <input name="clear" class="b_foot"  type="button"  value="清除" onClick="resetJSP()">
	                &nbsp; 
	                <input name="back"  class="b_foot"  onClick="history.go(-1)" type="button"  value="返回">	                
	            </td>
	        </tr>  
  	</table>
  	<%@ include file="/npage/include/footer.jsp" %>
  	<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
</form>
</body>
</html>

