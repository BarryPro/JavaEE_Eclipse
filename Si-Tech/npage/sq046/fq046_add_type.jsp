<%
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	
	 System.out.println("----------------------------------fq046_add_type.jsp------------------------");
%>

<%@ page contentType="text/html;charset=GB2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%
  String typeStr=WtcUtil.repNull(request.getParameter("typeStr"));	//������������ô�,������֤�µķ����Ƿ�Ϸ�
  
  String servOrderStr = WtcUtil.repNull(request.getParameter("servOrder"));
  String servBusId = servOrderStr.split("~")[2];	//�����ʶ
  String servOrder = servOrderStr.split("~")[1];	//���񶨵�
  System.out.println("----------------------------------typeStr------------------------"+typeStr);
  System.out.println("----------------------servOrderStr-------------------------------"+servOrderStr);
  System.out.println("-----------------------ervBusId----------------------"+servBusId);
%>
<html>
<head>
<script src="<%=request.getContextPath()%>/njs/si/makepy.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/si/autocomplete.js"  type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/validate_class.js"></script>
<script type="text/javascript">
	
  var feeFlag = true;
  var typeStr = "<%=typeStr%>";
  
	onload=function()
	{  
	}
		/*
		*������������
		*/
	function addType()
	{
		 	 var selectval = $('#feelist').val();//ģ����ѯ���صķ��ô�
		 	 var feeInfos = new Array();
		 	 feeInfos = selectval.split("~");
		 	 var feeName = feeInfos.pop();
		 	 var tmpstr = "<%=servOrder%>@"+feeInfos[1]+ "$";
		 	 var inputObj = "<input type='button' v_value='"+tmpstr+"' v_feeCode='"+feeInfos[1]+"' v_print='"+feeInfos[4]+"' v_feetype='"+feeInfos[5]+"' class='butDel' onclick='delFee();delTr()'>";
	 		 feeInfos.push(inputObj);
	 		 if(typeStr.indexOf(tmpstr)!=-1){
	 		 	rdShowMessageDialog("����Ŀ�Ѳ��ѣ��벻Ҫ�ظ���ȡ��",0);
				return false;
	 		 }
	 		 typeStr += tmpstr;
	 		 var array0 = new Array();//��̬��ӱ���õ�����
	 		 
	 		 array0.push(feeInfos[6]+"["+feeInfos[0]+"]");
	 		 array0.push($('#mustCash').val());	//Ӧ�շ���
	 		 array0.push($('#favourCash').val());	//��Ʒ�Żݷ���
	 		 var tmp = Number($('#mustCash').val()) - Number($('#favourCash').val());
	 		 array0.push(tmp);	//ʵ�շ���
	 		 array0.push(feeInfos[7]);
	 		 addTr("otherFeeList","1",array0,"0|1");
	 		 //���ظ��ɷѽ���ķ��ô�:
	 		 g("ret_value").value =  g("ret_value").value + feeInfos[0] + "~" + feeInfos[1] + "~" +  $('#mustCash').val()  + "~" +  $('#favourCash').val()  + "~" + (Number($('#mustCash').val()) - Number($('#favourCash').val())) + "~" + feeInfos[4] + "~" + feeInfos[5] + "~" + feeInfos[6] + "~|";
	 		 g("add_submit").disabled = false ;
	}
	   /*
		*ɾ����������
		*/
	function delFee(){
		var srcObj = event.srcElement;
		var srcValue = srcObj.v_value;
		typeStr = typeStr.substring(0,typeStr.indexOf(srcValue))+ typeStr.substring(typeStr.indexOf(srcValue)+srcValue.length);
		var retValue = g("ret_value").value;
		 var trContent = "";
		 var trObj = srcObj.parentNode.parentNode;
		 var tdObjs = trObj.childNodes;
		 var v_feeCode = srcObj.v_feeCode;
		 for(var i = 0; i < tdObjs.length-1 ; i++){
		 	if(i == 1 ){
		 			trContent += v_feeCode +"~";
		 	}	
		 trContent += 	tdObjs[i].innerHTML+"~";
		 }
		 //ɾ������ret_value�еķ��ô�
		 trContent += srcObj.v_print+"~"+srcObj.v_feetype+"~|";
		 g("ret_value").value = retValue.substring(0,retValue.indexOf(trContent))+ retValue.substring(retValue.indexOf(trContent)+trContent.length);
	}

	function re()
	{
		var re= $("#ret_value").val();
		window.returnValue = re;
		window.close();
	}
	function closeWin()
	{
		window.close();
	}

	/*-----------------------����ģ������BEGIN--------------------------*/
	
	function focusQuickTb(){ 
		if(feeFlag){
				focusQuickNav(document.all.tb);
			}else{
				$("#tb").val('');
			}
	}
	
	function focusQuickNav(obj)
		{
			if(feeFlag){
				feeFlag = false;
				obj.value="���ݼ�����...";
				getQuickNavData(obj);
			}else{
		 		obj.value="";
			}
		}
 
	function getQuickNavData(obj)
		{
			var packet = new AJAXPacket("fq046_getFeeInfo.jsp","���Ժ�...");
			packet.data.add("objId" ,obj.id);
			packet.data.add("servBusId" ,"<%=servBusId%>");
			core.ajax.sendPacket(packet,doProcessNav,true);//�첽
			packet =null;
		}
		
 	function doProcessNav(packet)
		{
	    content_array = packet.data.findValueByName("contentStr");
	    opStr_quick = packet.data.findValueByName("opStr");
		  objId  = packet.data.findValueByName("objId");
		  var obj = actb(document.getElementById('tb'),document.getElementById('tb_h'),opStr_quick);
		  $("#"+objId).val("");
			$("#"+objId).blur();
			$("#"+objId).focus();
		}
		
 	function quicknav(arr)
		{
			if(document.getElementById('tb_h').value!=-1)
			{
				var feeInfos = new Array();
	 			feeInfos = arr.split("~");
	 		  $('#mustCash').val(feeInfos[2]);
	 		  $('#favourCash').val(feeInfos[3]);
			//	document.getElementById("tb").value="";
				document.getElementById("feelist").value= arr;
				$("#add_btn").attr("disabled",false);
			}
		}
		
	/*-----------------------����ģ������END--------------------------*/	
	
 	function chgFee(){
 		 var selectval = $('#feelist').val(); 	
 		 var feeInfos = new Array();
 		 feeInfos = selectval.split("~");
 		 $('#mustCash').val(feeInfos[2]);
 		 $('#favourCash').val(feeInfos[3]);
 	}
 
 	function checkMoney(){
	 	var mustCash = $('#mustCash').val();
	 	var favourCash = $('#favourCash').val();
	 	if(mustCash != "" && favourCash!=""){
	 		if(Number(favourCash)>Number(mustCash)){
 				rdShowMessageDialog("Ӧ�ս��ܴ���Ӧ�ս�",0);
 				g("mustCash").value="";
 				g("favourCash").value="";
				return false;
 			}
 		} 	
 	}
</script>
</head>
<body>
<div id="operation"> 	 
<div id="operation_table">
<%@ include file="/npage/include/header_pop.jsp" %> 
<div class="title"><div id="title_zi">����������Ϣ</div></div>
<div class="input" id="missionTable">
<form name="iform">
<table ellSpacing=0 >
  <tr>
    <td class=blue>���ÿ�Ŀ</td>
    <td colspan="3">
			  <input type='text'  class="inp_name" id='tb' onfocus="focusQuickTb()" value='��������ÿ�Ŀ'/>
				<input type='hidden' id='tb_h' value='-1'/>
	  	  <input type="button" class="b_text" name="Submit" name="add_btn" id="add_btn" disabled="true" value="��ӵ��б�" onClick="addType()">
	 </td>
	</tr>
  <tr>
    <td class=blue>Ӧ�ս��</td>
    <td>
			<input name="mustCash" id="mustCash" type="text"   value="0" v_name="Ӧ�ս��" class="forMoney"  onchange="checkMoney()">	
		</td>
    <td class=blue>�Żݽ��</td>
    <td>
	  	<input name="favourCash"  id="favourCash" type="text" �� value="0" v_name="�Żݽ��" class="forMoney"  onchange="checkMoney()">
	  </td>
  </tr>
</table>
</form>
</div>

<div class="title"><div id="title_zi">������Ŀ�б�</div></div>
<div class="list" id="missionTable1">
<table id="otherFeeList"  cellSpacing=0 > 
  <tr>
    <th>���ÿ�Ŀ</th>
    <th>Ӧ�ս��</th>
    <th>�Żݽ��</th>
    <th>ʵ�ս��</th>
    <th>����</th>
  </tr>
  <tr>
  	<td id=footer colspan=5>
  		<div id="operation_button">
<input type="button" class="b_foot" name="add_submit" id="add_submit" disabled="true" value="ȷ��" onClick="re()">
<input type="button" class="b_foot" name="Submit" value="�ر�" onClick="closeWin()">
<inpt type="hidden" name="ret_value" id="ret_value" value="<%=servOrderStr%>|"> 
<inpt type="hidden" name="feelist" id="feelist" value=""> 
</div>
  	</td>
  </tr>
</table>
</div> 
</div>

</div>
</body>
</html>
