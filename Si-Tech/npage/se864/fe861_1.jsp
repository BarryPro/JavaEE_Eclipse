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
		String opCode="e861";
		String opName="������Ҫ��Ա��������";
		String workNo = (String)session.getAttribute("workNo");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		%>
	<script language="javascript" type="text/javascript" src="json2.js"></script>
	<script language="javascript" type="text/javascript" src="fe860.js"></script>
		<script language="javascript">
			var familyRoleList = new FamRoleList();
			var sns="0";
		function doReset(){
			window.location.href = "fe861_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
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
	var myPacket = new AJAXPacket("fe861_qry.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
	myPacket.data.add("PhoneNo",phoneNos);
	myPacket.data.add("opCode","<%=opCode%>");
	myPacket.data.add("opName","<%=opName%>");
	core.ajax.sendPacketHtml(myPacket,checkSMZValue,true);
	getdataPacket = null;

		}
  function checkSMZValue(data) {
  document.all.quchoose.disabled = false;
				//�ҵ���ӱ���div
				var markDiv=$("#gongdans"); 
				//���ԭ�б��
				markDiv.empty();
				markDiv.append(data);
}
	function confirmS() {
	
				var radio1 = document.getElementsByName("jtradio");
				var opValert="";
				var sm= new Array();
				var unit_id="";
				var zgdsl_id="";
				var schecks=0;

				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						schecks++;
						sm = radio1[i].value.split("|");;
						unit_id=sm[0];
						zgdsl_id=sm[1];
						}
						 }
			if(schecks==0) {
						 rdShowMessageDialog("��ѡ��Ҫ�������");
		         return false;				
				}
    
		 //return false;
		 var shenpitype = $("#shenpitype").val();
		 if(shenpitype=="nn") {
		 rdShowMessageDialog("�������Ͳ���Ϊ�գ���ѡ��");
		 return false;
		 }
		 			if(!check(frm))
		 {
			 return false;
		 }
		 setJSONText();
		 
	var getdataPacket = new AJAXPacket("fe861_submit.jsp","�����ύ�У����Ժ�......");
	//getdataPacket.data.add("PhoneNo",opValert);
	getdataPacket.data.add("opCode","<%=opCode%>");
	getdataPacket.data.add("opName","<%=opName%>");
	getdataPacket.data.add("myJSONText",$("#myJSONText").val());
	getdataPacket.data.add("shenpitype",$("#shenpitype").val());
	getdataPacket.data.add("shenpimsg",$("#shenpimsg").val());
	getdataPacket.data.add("unit_id",unit_id);
	getdataPacket.data.add("zgdsl_id",zgdsl_id);
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
				rdShowMessageDialog("�ύʧ�ܣ�������룺"+retCode+"������Ϣ��"+retMsg,0);
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
		    <td class="blue" width="15%">�ֻ�����</td>
		    <td colspan="3">
		  <input name="phoneNo" type="text"   id="phoneNo" value=""   v_type="mobphone"  maxlength="11" size="17">
      &nbsp;&nbsp;<input type="button"  name="quchoose" class="b_text" value="��ѯ" onclick="quechoosee()" />	
		</td>

	</tr>
</table>


	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
						
				<input name="back" onClick="doReset()" type="button" class="b_foot"  value="���">
				&nbsp;
				<input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();"/>
				&nbsp;
				<input type="button" name="rets" class="b_foot" value="����" onClick="returnBefo()"/>
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