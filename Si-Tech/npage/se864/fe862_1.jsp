<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<%
   response.setHeader("Pragma","No-cache");
   response.setHeader("Cache-Control","no-cache");
   response.setDateHeader("Expires", 0);
		//String opCode = request.getParameter("opCode");
		//String opName = request.getParameter("opName");
		String opCode="e862";
		String opName="集团重要成员调入审批";
		String workNo = (String)session.getAttribute("workNo");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		%>
	<script language="javascript" type="text/javascript" src="json2.js"></script>
	<script language="javascript" type="text/javascript" src="fe860.js"></script>
		<script language="javascript">
			var familyRoleList = new FamRoleList();
			var sns="0";
		function doReset(){
			window.location.href = "fe862_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
		}
		function returnBefo() {
		  window.location.href = "fe861_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
		}
		function quechoosee() {
		 		
				var phoneNos =$("#phoneNo").val();
				if(phoneNos=="") {

				}
				else {

				}

  document.all.quchoose.disabled = true;
	var myPacket = new AJAXPacket("fe862_qry.jsp","正在查询信息，请稍候......");
	myPacket.data.add("PhoneNo",phoneNos);
	myPacket.data.add("opCode","<%=opCode%>");
	myPacket.data.add("opName","<%=opName%>");
	core.ajax.sendPacketHtml(myPacket,checkSMZValue,true);
	getdataPacket = null;

		}
  function checkSMZValue(data) {
  document.all.quchoose.disabled = false;
				//找到添加表格的div
				var markDiv=$("#gongdans"); 
				//清空原有表格
				markDiv.empty();
				markDiv.append(data);
}
	function confirmS() {
	
		var radio1 = document.getElementsByName("jtradio");
				var opValert="";
				var sm= new Array();
				var unit_id="";
				var zgdsl_id="";
				var grp_name="";
				var grp_id="";
				var schecks=0;
        var iToneType="";
				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						schecks++;
						sm = radio1[i].value.split("|");;
						unit_id=sm[0];
						zgdsl_id=sm[1];
						grp_name=sm[2];
						grp_id=sm[3];
						}
						}
			if(schecks==0) {
						 rdShowMessageDialog("请选择要审批的项！");
		         return false;				
				}
		 //return false;
		 var shenpitype = $("#shenpitype").val();
		 if(shenpitype=="nn") {
		 rdShowMessageDialog("审批类型不能为空，请选择！");
		 return false;
		 }
		 			if(!check(frm))
		 {
			 return false;
		 }
		 
	var grpids = document.getElementById("grpID"+grp_id).value;
	var grpnames = document.getElementById("grpName"+grp_id).value;
	
	var getdataPacket = new AJAXPacket("fe862_submit.jsp","正在提交中，请稍候......");
	//getdataPacket.data.add("PhoneNo",opValert);
	getdataPacket.data.add("opCode","<%=opCode%>");
	getdataPacket.data.add("opName","<%=opName%>");
	getdataPacket.data.add("myJSONText",$("#myJSONText").val());
	getdataPacket.data.add("shenpitype",$("#shenpitype").val());
	getdataPacket.data.add("shenpimsg",$("#shenpimsg").val());
	getdataPacket.data.add("unit_id",grpids);
	getdataPacket.data.add("zgdsl_id",zgdsl_id);
	getdataPacket.data.add("grpnames",grpnames);
	core.ajax.sendPacket(getdataPacket);
	getdataPacket = null;
					  
	
	}
			function doProcess(packet) {

			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			if(retCode == "000000"){
				rdShowMessageDialog(retMsg,2);
				doReset();
				//removeCurrentTab();
			}else {
				rdShowMessageDialog("提交失败，错误代码："+retCode+"错误信息："+retMsg,0);
				//removeCurrentTab();
			}
		}
		function setJSONText(){
		familyRoleList = new FamRoleList();
		familyRoleList.setBegintime($("#begin_time").val());
		familyRoleList.setCompanyname($("#jtnames1").val());
		familyRoleList.setIncity($("#intocity").val());	
		var myJSONText = JSON.stringify(familyRoleList,function(key,value){
				return value;
				});
			//alert(myJSONText);
			$("#myJSONText").val(myJSONText);
		}		
		
		function queGrp() {
			var radio1 = document.getElementsByName("jtradio");
				var opValert="";
				var sm= new Array();
				var unit_id="";
				var zgdsl_id="";
				var grp_name="";
				var num="";
				var schecks=0;
				
				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						schecks++;
						sm = radio1[i].value.split("|");;
						unit_id=sm[0];
						zgdsl_id=sm[1];
						//grp_name=sm[2];
						num=sm[3];
						}
						}
			if(schecks==0) {
						 rdShowMessageDialog("请选择要修改集团名称的项！");
		         return false;				
				}
				grp_name = document.getElementById("grpName"+num).value;
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
				var path="<%=request.getContextPath()%>/npage/se864/fe864_qryGrp.jsp?opCode=<%=opCode%>&grp_name="+grp_name+"&num="+num;
						var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
						//var ret=window.showModalDialog(path,"",prop);
					 // var someValue=	window.showModalDialog("fe864_qryGrp.html","","dialogWidth=500px;dialogHeight=500px;status=no;help=no;scrollbars=no");
            var newWin = window.open(path,'','height=800,width=600,top=200,left=200,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no,status=no'); 
			    	//window.open(path);
				
		}
		</script>
	</head>
		<body>
		<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	      <table cellspacing="0" >
		  <tr>
		    <td class="blue" width="15%">手机号码</td>
		    <td colspan="3">
		  <input name="phoneNo" type="text"   id="phoneNo" value=""   v_type="mobphone"  maxlength="11" size="17">
      &nbsp;&nbsp;<input type="button"  name="quchoose" class="b_text" value="查询" onclick="quechoosee()" />	
		</td>

	</tr>
</table>


	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
						
				<input name="back" onClick="doReset()" type="button" class="b_foot"  value="清除">
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();"/>
				&nbsp;
				<input type="button" name="rets" class="b_foot" value="返回" onClick="returnBefo()"/>
			</div>
			</td>
		</tr>
	</table>
		<div id="gongdans">
		</div>	  
<input type="hidden" id="myJSONText" name="myJSONText" />	    
 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>