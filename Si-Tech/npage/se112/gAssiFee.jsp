
<%@page import="utils.system"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	String meansId = request.getParameter("meansId");
	String phoneNo = request.getParameter("phoneNo");
	String reginCode = request.getParameter("reginCode");
	String loginNo = request.getParameter("loginNo");
	String password = request.getParameter("password");
	String orderId = request.getParameter("orderId");
	String H11_effDateStr = request.getParameter("H11_effDateStr");//���Ӫ�����ʷѵĿ�ʼʱ��
	String act_type   = (String)request.getParameter("act_type");//�С��
	String H15   = (String)request.getParameter("H15");//�С��
	
	System.out.println("meansId��"+meansId);
	System.out.println("++========meansId=====" + meansId);	
	System.out.println("==++======phoneNo=====" + phoneNo);	
	System.out.println("=++=======reginCode=====" + reginCode);	
	System.out.println("===++=====loginNo=====" + loginNo);	
	System.out.println("==++======password=====" + password);	
	System.out.println("=++=======orderId=====" + orderId);	
	System.out.println("====------H11_effDateStr:"+H11_effDateStr);
	System.out.println("=++=======act_type=====" + act_type);
	System.out.println("=++=======H15=====" + H15);
	
	String xml = request.getParameter("assiFeeInfo").trim();
	String feeChooseType = "";
	String validFlag = "";
 	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%	
	List fundsList = null;
 	String MNET_CODE="";
	if(null != mb){
		fundsList = mb.getList("OUT_DATA.H11.ADD_FEE_LIST.ADD_FEE_INFO");		
	}
	
	StringBuffer offerIdStr = new StringBuffer();
 %>
 
<style type="text/css">
	.input th {
		text-align: right;
		width: 50px;
		white-space: nowrap;
		border-bottom: 1px solid #cbcbcb;
		border-right: 1px solid #cbcbcb;
		background-color: #f9f9f9;
	}
</style>
<html>
	<head>
	<title></title>
	</head>
	<body>
		<div id="operation">
		<form method="post" name="frm4938" action="">
				
				<div id="operation_table">
					 <div class="title">
						<div class="text">
							�����ʷ���ϸ��Ϣ
						</div>
					</div>
					<div class="input">
					<table id="selectTable">
					<%
						Map sMap = (Map)fundsList.get(0);
						
						for(int i=0;i<fundsList.size();i++){
							Map stMap = (Map)fundsList.get(i);
							if(null!=stMap.get("ADD_FEE_TYPE")&&!"".equals(stMap.get("ADD_FEE_TYPE"))||null!=stMap.get("ADD_FEE_VALID_FLAG")&&!"".equals(stMap.get("ADD_FEE_VALID_FLAG"))){
								fundsList.remove(i);
							}
						}
						feeChooseType = sMap.get("ADD_FEE_TYPE").toString();
						if(null==sMap.get("ADD_FEE_VALID_FLAG")||"".equals(sMap.get("ADD_FEE_VALID_FLAG"))){
							validFlag = "0";
						}else{
							validFlag = sMap.get("ADD_FEE_VALID_FLAG").toString();
						}
						if("1".equals(sMap.get("ADD_FEE_TYPE"))){
							System.out.println("��ѡһ");
							for(int i=0;i<fundsList.size();i++){
								Map maps = (Map)fundsList.get(i);
								String ADD_FEE_CODE = (String)maps.get("ADD_FEE_CODE") == null ? "":(String)maps.get("ADD_FEE_CODE");
								offerIdStr.append(ADD_FEE_CODE).append("#");
								String ADD_FEE_NAME = (String)maps.get("ADD_FEE_NAME") == null ? "":(String)maps.get("ADD_FEE_NAME");
								String ADD_FEE_SCORE = (String)maps.get("ADD_FEE_SCORE") == null ? "":(String)maps.get("ADD_FEE_SCORE");
								String OFFSET_TYPE = (String)maps.get("ADD_FEE_OFFSET_TYPE") == null ? "":(String)maps.get("ADD_FEE_OFFSET_TYPE");
								System.out.println("OFFSET_TYPE========="+OFFSET_TYPE);
								String addFeeScoreView = "";
								if("1".equals(OFFSET_TYPE)){
									addFeeScoreView = ADD_FEE_SCORE +"��";
								}else{
									addFeeScoreView = ADD_FEE_SCORE +"����";
								}
						 %>
								<tr>
									<%if(i==0){
									%><th><input type="radio" name="ADD_FEE_NAM" id="<%=ADD_FEE_CODE %>" checked="checked"/></th><% 
									}else{
									%><th><input type="radio" name="ADD_FEE_NAM" id="<%=ADD_FEE_CODE %>"/></th><%
									} %>
									
									<th>�ʷѴ���</th>
									<td id="<%=ADD_FEE_CODE %>_1">
										<%=ADD_FEE_CODE%>	
									</td>
									<th>�ʷ�����</th>
									<td id="<%=ADD_FEE_CODE %>_2">
										<%=ADD_FEE_NAME%>
									</td>
									<th>����</th>
									<td id="<%=ADD_FEE_CODE %>_3">
										<%=addFeeScoreView%>
									</td> 
									<td id="<%=ADD_FEE_CODE %>_4" style="display:none">
										<%=OFFSET_TYPE%>
									</td>
									<td id="<%=ADD_FEE_CODE %>_5" style="display:none">
										<%=ADD_FEE_SCORE%>
									</td>
									<td id="<%=ADD_FEE_CODE %>_6" style="display:none">
										<%=validFlag%>
									</td>
									<th>С������</th>
									<td id="<%=ADD_FEE_CODE %>_7">
									</td>
									<td id="<%=ADD_FEE_CODE %>_8" style="display:none">
									</td>
								</tr>
						
						<%}}else{
							System.out.println("ȫѡ");
							for(int i=0;i<fundsList.size();i++){
								Map maps = (Map)fundsList.get(i);
								String ADD_FEE_CODE = (String)maps.get("ADD_FEE_CODE") == null ? "":(String)maps.get("ADD_FEE_CODE");
								offerIdStr.append(ADD_FEE_CODE).append("#");
								String ADD_FEE_NAME = (String)maps.get("ADD_FEE_NAME") == null ? "":(String)maps.get("ADD_FEE_NAME");
								String ADD_FEE_SCORE = (String)maps.get("ADD_FEE_SCORE") == null ? "":(String)maps.get("ADD_FEE_SCORE");
								String OFFSET_TYPE = (String)maps.get("ADD_FEE_OFFSET_TYPE") == null ? "":(String)maps.get("ADD_FEE_OFFSET_TYPE");
								System.out.println("OFFSET_TYPE========="+OFFSET_TYPE);
								//System.out.println("ADD_FEE_CODE========="+ADD_FEE_CODE);
								//System.out.println("ADD_FEE_NAME========="+ADD_FEE_NAME);
								//System.out.println("ADD_FEE_SCORE========="+ADD_FEE_SCORE);
								String addFeeScoreView = "";
								if("1".equals(OFFSET_TYPE)){
									addFeeScoreView = ADD_FEE_SCORE +"��";
								}else{
									addFeeScoreView = ADD_FEE_SCORE +"����";
								}
						 %>
								<tr>
									<th><input type="checkbox" name="ADD_FEE_NAM" id="<%=ADD_FEE_CODE %>" checked="checked" disabled="disabled"></th>
									<th>�ʷѴ���</th>
									<td id="<%=ADD_FEE_CODE %>_1">
										<%=ADD_FEE_CODE%>					
									</td>
									<th>�ʷ�����</th>
									<td id="<%=ADD_FEE_CODE %>_2">
										<%=ADD_FEE_NAME%>
									</td>
									<th>����</th>
									<td id="<%=ADD_FEE_CODE %>_3">
										<%=addFeeScoreView%>
									</td> 
									<td id="<%=ADD_FEE_CODE %>_4" style="display:none">
										<%=OFFSET_TYPE%>
									</td>
									<td id="<%=ADD_FEE_CODE %>_5" style="display:none">
										<%=ADD_FEE_SCORE%>
									</td>
									<td id="<%=ADD_FEE_CODE %>_6" style="display:none">
										<%=validFlag%>
									</td>
									<th>С������</th>
									<td id="<%=ADD_FEE_CODE %>_7">
									</td>
									<td id="<%=ADD_FEE_CODE %>_8" style="display:none">
									</td>
								</tr>
						
						<%}}  if("3".equals(sMap.get("ADD_FEE_TYPE"))){   %>
							<tr>
							    	   <th></th>
							    	   <th>����˺�</th>
								       <td>
							    	        <input type="text"  style= "width:95%" id="MNET_CODE" value=""/>
							    	   </td>
							        </tr>
						<%} %>
						</table>
						</div>
					<div id="operation_button">
						<input type="button" class="b_foot" value="ѡ��" id="btnCancel"
							name="btnCancel" onclick="subCheckFeeCode()" />					
						<input type="button" class="b_foot" value="�ر�" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
				</div>
			</form>
		</div>
		<%@ include file="/npage/include/footer_pop.jsp"%>
	</body>
	<script type="text/javascript">
	var codes = "";
	var feeNames = "";
	var showNames = "";
	var feeScores = "";
	var orderStr = "";
	var gFeeCodeStr = "";
	var gFeeDescStr = "";
	var gFeeNoteStr = "";
	var qryfee_code = "";
	var qryfee_msg = "";
	var MNET_CODE = "";
	var xqCodes = "";//С������
	var xqNames = "";//С������
	function subCheckFeeCode(){
		 $("#btnCancel").attr("disabled", "true");
		var checkEle = $("#selectTable input:checked");
		var code="";
		var name="";
		var xqFalg = "";
		var xqCode = "";
		for(var i=0; i<checkEle.length; i++){
			var tid = $(checkEle[i]).attr("id");			
			code = $.trim($("#"+tid+"_1").text());
			name = $.trim($("#"+tid+"_2").text());
			xqFlag = $.trim($("#"+tid+"_8").text());
			if(xqFlag == 'Y'){
				xqCode = $.trim($("#"+tid+"_7 option:selected").val());
				if(xqCode == ""){
					alert("��ѡ��С������",1);
					return;
				}
			}
		}

		var sPacket = null;
		sPacket = new AJAXPacket("gAssiFeeCheckFee.jsp","���Ժ�......");
		
		sPacket.data.add("loginNo","<%=loginNo%>");
		sPacket.data.add("iPhoneNo","<%=phoneNo%>");
		sPacket.data.add("fee_code",code);
		sPacket.data.add("fee_name",name);
		sPacket.data.add("meansId","<%=meansId%>");
		sPacket.data.add("act_id","");
		//==================================================
		core.ajax.sendPacketHtml(sPacket,doResCat,true);
		sPacket = null;

	}
	
	function doResCat(data){
		var sdata = data.split("~");
		var retCode = sdata[0];
		var retMsg = sdata[1];
		if(retCode != 0){
			showDialog(retMsg,0);
			return false;
		}
		subAll(retMsg);
	}
	
	function subAll(retMsg){		
		var checkEle = $("#selectTable input:checked");
		var split = "";
		var split2 = "";
		var split3 = "";
		var iPhoneNoStr="";//�ֻ����봮
		var iOprTypeStr="";//�ʷѱ�ʶ��
		var iDateTypeStr="";//�ʷ����ʹ�
		var iOfferTypeStr="";//�ʷ����ʹ�
		var iUnitStr="";//�ʷ����ʹ�
		for(var i=0; i<checkEle.length; i++){
			var tid = $(checkEle[i]).attr("id");			
			var code = $.trim($("#"+tid+"_1").text());
			var name = $.trim($("#"+tid+"_2").text());
			var score = $.trim($("#"+tid+"_5").text());
			var offsetType = $.trim($("#"+tid+"_4").text());
			if(offsetType == "" || offsetType == "N/A"){
				offsetType = "6";
			}
			var xqFlag = $.trim($("#"+tid+"_8").text());
			var xqCode = "";
			var xqName = "";
			if(xqFlag == "Y"){
				xqCode = $.trim($("#"+tid+"_7 option:selected").val());
				xqName = $.trim($("#"+tid+"_7 option:selected").text());
			}else{
				xqCode = "";
				xqName = "";
			}

			var validflag = "";
			if(retMsg == 1){ //�������� �ʷ�ԤԼ����
				validflag = "2";
			}else{
				validflag = $.trim($("#"+tid+"_6").text());
			}
			
			codes = codes + split + code;
			feeNames = feeNames + split + name;
			showNames = showNames + split2 + name;
			feeScores =  feeScores + split + score;
			orderStr = orderStr + split3 + "N";
			//=============================������Чʱ���ʧЧʱ����ýӿ�==============================			
			iPhoneNoStr = iPhoneNoStr + split + "<%=phoneNo%>";
			iOprTypeStr = iOprTypeStr + split + "1";
			iDateTypeStr = iDateTypeStr + split + validflag;
			iOfferTypeStr = iOfferTypeStr + split + "1";
			iUnitStr = iUnitStr + split + offsetType;
			xqCodes = xqCodes + split + xqCode;
			xqNames = xqNames + split + xqName;
			split = "#";
			split2 = "<br>";
			split3 = ",";
		}
		if(codes == ""){			
			alert("������ѡ��һ�������ʷ�",1);
			return false;
		}
		if("2" != "<%=feeChooseType%>"){
			if("19" == "<%=act_type%>" || ("16" == "<%=act_type%>" && "<%=H15%>" != "1")){//���˿����ǩ��ģ�ʱ�䶼Ҫ�����ʷ�����
				var sPacket = new AJAXPacket("getNetEffectTime.jsp","���Ժ�......");
				sPacket.data.add("H11_effDateStr","<%=H11_effDateStr%>");
				sPacket.data.add("feeScores",feeScores);
				sPacket.data.add("actType","<%=act_type%>");
			}else{
				var sPacket = new AJAXPacket("getEffectTime.jsp","���Ժ�......");
				sPacket.data.add("iChnSource","<%=reginCode%>");
				sPacket.data.add("iLoginNo","<%=loginNo%>");
				sPacket.data.add("iLoginPWD","<%=password%>");
				sPacket.data.add("iPhoneNo","<%=phoneNo%>");
				sPacket.data.add("iOprAccept","<%=orderId%>");
				sPacket.data.add("iPhoneNoStr",iPhoneNoStr);
				sPacket.data.add("iOfferIdStr",codes);
				sPacket.data.add("iOprTypeStr",iOprTypeStr);
				sPacket.data.add("iUnitStr",iUnitStr);
				sPacket.data.add("iDateTypeStr",iDateTypeStr);
				sPacket.data.add("iOfferTypeStr",iOfferTypeStr);
				sPacket.data.add("iOffsetStr",feeScores);
				sPacket.data.add("meansId","<%=meansId%>");
			}
			
			//==================================================
			core.ajax.sendPacket(sPacket,doserviceResCat);
			sPacket = null;
		}else{
			var sPacket = new AJAXPacket("getFollowEffTime.jsp","���Ժ�......");
			sPacket.data.add("feeCodes", codes+"#");
			sPacket.data.add("effTimes", feeScores+"#");
			core.ajax.sendPacket(sPacket,doserviceResCat);
			sPacket = null;
		}
	}

	
	function doserviceResCat(packet){
		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
		
		var effDateStr = packet.data.findValueByName("effDateStr");
		var expDateStr = packet.data.findValueByName("expDateStr");
		if(RETURN_CODE!="000000"){
			codes="";
			feeScores = "";
			showDialog(RETURN_MSG,0);
			return false;
		}
		
		/* add  date:2015-10-10
			//71-��Լ�ƻ�Ԥ�湺��  С�������ʷ��������ʷ�����������ҵ���ӿڻ�ȡ
		modify date:2016-03-28
                       ��С��ȥ��������С�඼�����ʷ�������ѯ�ӿڣ�չʾ�ʷ�������������ת��Ϣ����
		*/
		<%-- if("71" == "<%=act_type%>" ){
		} --%>
		var assiFeeDesc = "";	
		multiOffQry();
			if(trim(qryfee_code)!="000000"){
				showDialog("���÷���sMultiOffQryWS_XML��ȡ�ʷ�����ʧ�ܣ�"+qryfee_msg,0);
				return false;
			}
			if(gFeeCodeStr!="" && gFeeDescStr !=""){
				var qryCodeArr = gFeeCodeStr.split("#");
				var qryDescArr = gFeeDescStr.split("#");
				var codeArr = codes.split("#");
				var feeNamesArr = feeNames.split("#");
				var newShowNames = "";
				
				for(var i=0; i<codeArr.length; i++){
					var code  = codeArr[i];
					for(var j = 0;j<qryCodeArr.length;j++){
						if(code==qryCodeArr[j]){
							newShowNames = newShowNames + "�ײ����ƣ�"+feeNamesArr[i]+",�ײ�������"+qryDescArr[j]+";";
						}
					}
				}
				assiFeeDesc = newShowNames;
				if(gFeeNoteStr!=""){
					newShowNames = newShowNames + gFeeNoteStr;
				}
				
				showNames = newShowNames;
			}
		
		MNET_CODE = $("#MNET_CODE").val();
		if(MNET_CODE!=null&&MNET_CODE!=""&&MNET_CODE!="null"){
			MNET_CODE = trim($("#MNET_CODE").val());
		}
		if(MNET_CODE!=null&&MNET_CODE!=""&&MNET_CODE!="null"){
			showNames=showNames+" ����˺ţ�"+MNET_CODE;
		}
		if("<%=feeChooseType%>"=="3"){
			if(MNET_CODE==""||MNET_CODE==null){
			  	showDialog("ʡ��ħ�ٺ�ҵ������д����˺�",0);
				codes="";
				feeScores = "";
			  	return false;
			}			
		}
//		alert("codes="+codes+"; feeNames="+feeNames+"; showNames= "+showNames+";MNET_CODE="+MNET_CODE);
		parent.saveAssFee("<%=meansId%>", codes, feeNames, showNames, feeScores, orderStr,effDateStr,expDateStr,MNET_CODE,xqCodes, xqNames);
		parent.saveAssFeeNote(assiFeeDesc,gFeeNoteStr);
		closeWin();	
	}
	function closeWin(){
		closeDivWin();
	}
	
	
	function multiOffQry(){
		var myPacket = null;
		myPacket = new AJAXPacket("multiOffQry.jsp","���Ժ�...");
		myPacket.data.add("iLoginAccept","<%=orderId%>");
		myPacket.data.add("iChnSource","01");
		myPacket.data.add("iOpCode","g794");
		myPacket.data.add("iLoginNo","<%=loginNo%>");
		myPacket.data.add("iLoginPwd","<%=password%>");
		myPacket.data.add("iPhoneNo","<%=phoneNo%>");
		myPacket.data.add("iUserPwd","");
		myPacket.data.add("iOfferStr",codes+"#");
		core.ajax.sendPacket(myPacket,setMultiOffer);
		myPacket =null;
	}
	function setMultiOffer(packet){
		qryfee_code = packet.data.findValueByName("RETURN_CODE");
		qryfee_msg = packet.data.findValueByName("RETURN_MSG");
		var feeCodeStr = packet.data.findValueByName("feeCodeStr");
		var feeDescStr = packet.data.findValueByName("feeDescStr");
		var feeNoteStr = packet.data.findValueByName("feeNoteStr");
		/* if(trim(RETURN_CODE)!="000000"){
			showDialog(RETURN_MSG,0);
			return false;
		} */
		gFeeCodeStr = feeCodeStr;
		gFeeDescStr = feeDescStr;
		gFeeNoteStr = feeNoteStr;
	}

	$(document).ready(function(){
		var sPacket = null;
		sPacket = new AJAXPacket("gAssiFeeDistriInfo.jsp","���Ժ�......");
		
		sPacket.data.add("loginNo","<%=loginNo%>");
		sPacket.data.add("phoneNo","<%=phoneNo%>");
		sPacket.data.add("password", "<%=password%>");
		sPacket.data.add("offferIdStr","<%=offerIdStr%>");
		//==================================================
		core.ajax.sendPacketHtml(sPacket,setMultiXqOffer);
		sPacket = null;
	});
	
	function setMultiXqOffer(packet){
		var result = packet.split("~");
		var offerId = result[2];
		var xqFlag = result[3];
		var xqCode = result[4];
		var xqName = result[5];
		
		var offerIds = offerId.split("#");
		var xqFlags = xqFlag.split("#");
		var xqCodes = xqCode.split("#");
		var xqNames = xqName.split("#");
		
		for(var i = 0; i < offerIds.length; i++){
			if(xqFlags[i] == "Y"){
				var selStr = "<select id='"+offerIds[i]+"_9'>";
				var optionsStr = "<option value =''>��ѡ��</option>";
				var optionValue = xqCodes[i].split("|");
				var optionName = xqNames[i].split("|");
				for(var j = 0; j < optionValue.length; j++){
					optionsStr += "<option value ='"+optionValue[j]+"'>"+optionName[j]+"</option>";
				}
				selStr += optionsStr;
				selStr += "</select>";
				$("#"+offerIds[i]+"_7").html(selStr);
				$("#"+offerIds[i]+"_8").text(xqFlags[i]);
			}else{
				$("#"+offerIds[i]+"_7").text("��С������");
				$("#"+offerIds[i]+"_8").text(xqFlags[i]);
			}
			
		}
	}
	</script>
</html>
