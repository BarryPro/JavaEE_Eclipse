 <%
  /*
   * ����: ѫ�¶һ���Ʒ�����޸� e017
   * �汾: 1.0
   * ����: 2011/7/5
   * ����: huangrong
   * ��Ȩ: si-tech
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
//---------------------------------java������------------------------------------
	String opCode = "e017";	
	String opName = "ѫ�¶һ���Ʒ�����޸�";	//header.jsp��Ҫ�Ĳ���   
	//��ȡsession��Ϣ
	String loginNo=(String)session.getAttribute("workNo");    //���� 
	String orgCode = (String)session.getAttribute("orgCode");   	
	String regionCode =(String)session.getAttribute("regCode");  
	String groupId =(String)session.getAttribute("groupId"); 
	String orgName =(String)session.getAttribute("orgName"); 
	String loginAccept=getMaxAccept();//��ȡ��ˮ
	%>
<html>
	<head>
	<title>ѫ�¶һ���Ʒ�����޸�</title>
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
				rdShowMessageDialog("��ȡ��Ʒ����ʧ�ܣ�������Ϣ��"+errMsg+"��������룺"+errCode,0);
				history.go(-1);
			}	
 
		  }
		}

	//----����һ����ҳ��ѡ����֯�ڵ�--- ����
			function select_groupId(regionCode,row)
			{
				var path = "groupTreeUpdate.jsp";
			  window.open(path,'_blank','height=600,width=300,scrollbars=yes');
			}	
	
	//-----����-----	
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
	//-----��ѯ��Ʒ����-----
	function call_getGiftCode(){
  var group_Id = "<%=groupId%>";
	var pageTitle = "��Ʒѡ��";
	var fieldName = "���д���|��������|��Ʒ����|��Ʒ����|Ӫҵ������|Ӫҵ������|";//����������ʾ���С�����
	var selType = "S";    //'S'��ѡ��'M'��ѡ
	var retQuence = "6|0|1|2|3|4|5";//�����ֶ�
	var retToField = "regionCode|regionName|giftCode|giftName|groupId|groupName|";//���ظ�ֵ����
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
    
    	//-----��ѯ�������ʻ��б�-----
		if(document.form1.giftCode.value!="")
		{
			var giftCode=document.form1.giftCode.value;
			var type = "call_giftInfo";
			var myPacket = new AJAXPacket("fe017_getInfo.jsp","�����ύ�����Ժ�......");
			myPacket.data.add("regionCode",document.all.regionCode.value);
			myPacket.data.add("groupId",document.all.groupId.value);
			myPacket.data.add("giftCode",document.all.giftCode.value);
			myPacket.data.add("type",type);
			core.ajax.sendPacket(myPacket);
			myPacket=null;	  
		}
}	
		//--------------------------------�ύ��------------------------------------
		function commit()
		{
			getAfterPrompt();
	if(document.form1.giftCode.value=="")
	{
		rdShowMessageDialog("��Ʒ���벻��Ϊ��!");
		document.form1.giftCode.focus();
		return false;
	}		
	
	if(document.form1.regionCode.value=="")
	{
		rdShowMessageDialog("���д��벻��Ϊ��!");
		document.form1.regionName.focus();
		return false;
	}	
	if(document.form1.giftDescribe.value=="")
	{
		rdShowMessageDialog("��Ʒ��������Ϊ��!");
		document.form1.giftDescribe.focus();
		return false;
	}		
	if(document.form1.giftName.value=="")
	{
		rdShowMessageDialog("��Ʒ���Ʋ���Ϊ��!");
		document.form1.giftName.focus();
		return false;
	}		
	if(document.form1.medalCount.value=="")
	{
		rdShowMessageDialog("��ѫ��������Ϊ��!");
		document.form1.medalCount.focus();
		return false;
	}		
	if(document.form1.groupId.value=="")
	{
		rdShowMessageDialog("��ȡӪҵ������Ϊ��!");
		document.form1.groupId.focus();
		return false;
	}		
	if(document.form1.startTime.value=="")
	{
		rdShowMessageDialog("��ѡ��ʼʱ��!");
		document.form1.startTime.focus();
		return false;
	}	
	if(document.form1.endTime.value=="")
	{
		rdShowMessageDialog("��ѡ�����ʱ��!");
		document.form1.endTime.focus();
		return false;
	}	
	var begin_time=document.form1.startTime.value;
	var end_time=document.form1.endTime.value;
	if(begin_time>=end_time)
  {
    rdShowMessageDialog("��ʼʱ��ӦС�ڽ���ʱ�䣬���������룡");
    return false;
  }
  if(document.form1.opNote.value=="" || document.form1.opNote.value.trim()=="ѫ�¶һ���Ʒ��������")
  {
  	document.form1.opNote.value="ѫ�¶һ���Ʒ�����޸�";
  }		
  isSaleHall();	

 }

		//-----------------------------------����֤-----------------------------------------
		function checkform1(){
			if(check(document.form1)){
				return true;
		  }
		}

		//---------------------------------��ձ�---------------------------------------
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
				var myPacket = new AJAXPacket("fe017_isDisHall.jsp","�����ύ�����Ժ�......");
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
								rdShowMessageDialog("���ܿ����������Ʒ!");
								document.form1.endTime.focus();									
							}	
			 			}else
			 			{
							rdShowMessageDialog("��ȡӪҵ������ѡ��Ӫҵ����!");
							document.form1.endTime.focus();		 				
			 			}	
			 			
			 		}
		 }		
</script>
</head>
<%//--------------------------------------ҳ������--------------------------------------------%>
<body>
<form name="form1" method="post">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">������Ϣ</div>
		</div>
    <table  cellspacing="0">
      	<tr> 
            <td  class="blue" >��Ʒ����</td>
            <td> 
		            <input  type="text"  name="giftCode" value="" v_must="1" maxlength="8" readonly class="InputGrey">
            		<input type="button" name="getGiftCode" class="b_text" value="��ѯ" onClick="call_getGiftCode()" >
            		<font class="orange">*</font>
            </td>
            <td class="blue">���д���</td>
            <td> 
			          <input   type="hidden"  v_must="1" name="regionCode"  value="" readonly class="InputGrey">
			          <input   type="text"  v_must="1" name="regionName"  value="" readonly class="InputGrey">
            		<font class="orange">*</font>
            </td>            
        </tr>
        <tr> 
            <td class="blue">��Ʒ����</td>
            <td>
            	<input   type="text"  v_must="1" name="giftName" v_type="string" maxlength="50" size="40">
					    <font class="orange">*</font>
            </td>        	
            <td  class="blue">��Ʒ����</td>
            <td> 
			          <input type="text"   v_must="1" name="giftDescribe" value=""  maxlength="100" size="30">
            		<font class="orange">*</font>
            </td>
        </tr>
        <tr> 
            <td  class="blue">��ѫ����</td>
            <td> 
		          	<input   type="text"   name="medalCount" v_type="cfloat" onblur = "checkElement(this)" >
            		<font class="orange">*</font>
            </td>
            <td class="blue">��ȡӪҵ��</td>
            <td> 
		        		<input type="text" name="groupName" v_must="1" value=""  v_type="string" maxlength="60" class="button" readonly>&nbsp;<font color="orange">*</font>
								<input type="hidden" name="groupId">
								<input type="hidden" name="oldGroupId">
								<input name="addButton" class="b_text" type="button" value="ѡ��" onClick="select_groupId()" >	
            </td>
        </tr>
        <tr> 
            <td  class="blue">��ʼʱ��</td>
            <td>    		
            	<input type="text" name="startTime" id="startTime" v_must="1" v_type="date" class="button" maxlength="8" readonly/>&nbsp;<font color="orange">*</font>
							<input type="button" name="dateButton" class="b_text" alt="�������������˵�" onclick="fPopUpCalendarDlg('startTime');return false" value="����" />            		
            </td>
            <td class="blue">����ʱ��</td>
            <td> 
							<input type="text" name="endTime" id="endTime" v_must="1" v_type="date" class="button" maxlength="8" readonly/>&nbsp;<font color="orange">*</font>
							<input type="button" name="dateButton" class="b_text" alt="�������������˵�" onclick="fPopUpCalendarDlg('endTime');return false" value="����" />			 
            </td>
        </tr>
        <tr> 
            <td  class="blue">��ע</td>
            <td colspan="3"> 
            		<input type="text"   name="opNote"  size="60" maxlength="100">
            </td>

        </tr>
       </table>
       <table>
	        <tr> 
	            <td id="footer"> 	             
	                <input name="submit1" class="b_foot"  type="button"  value="ȷ��" onClick="commit()" disabled>
	                &nbsp; 
	                <input name="clear" class="b_foot"  type="button"  value="���" onClick="resetJSP()">
	                &nbsp; 
	                <input name="back"  class="b_foot"  onClick="history.go(-1)" type="button"  value="����">	                
	            </td>
	        </tr>  
  	</table>
  	<%@ include file="/npage/include/footer.jsp" %>
  	<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
</form>
</body>
</html>

