<%
  /*
   * ����: R_CMI_HLJ_guanjg_2015_2303829@�����Ż�ʵ����ʶϵ�й��ܵ�����ʾ
   * �汾: 1.0
   * ����: 2015/7/13 15:00:57
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regionCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
 		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String loginAccept = getMaxAccept();
		
		String ipAddrM = (String)session.getAttribute("ipAddr");
 		String inst = "ͨ��phoneNo[" + phoneNo + "]��ѯ";
		String custName = "";
		
%>

<wtc:service name="sUserCustInfo" outnum="41" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=loginNo%>"/>
      <wtc:param value="<%=noPass%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value="<%=ipAddrM%>"/>
      <wtc:param value="<%=inst%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>

	<wtc:array id="result11" scope="end" />

<%
		if(result11.length <= 0)
		{
%>
<script language="JavaScript">
			rdShowMessageDialog("���û����������û���״̬��������");
			removeCurrentTab();
</script>
<%
			return ;
		}
		else
		{
			custName = result11[0][5];
		}
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept" />

  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		var globelOpCode = "";
		
		$(document).ready(function(){
			changeType("<%=opCode%>");
		});
		
		
		

		
		function doQry(){
			
			/*�ֻ�����*/
			var phoneNo = $.trim($("#phoneNo").val());
			/*��Ʒ����*/
			var giftNo = $.trim($("#giftNo").val());
			/*��Ʒ����*/
			var giftName = $.trim($("#giftName").val());
			
				
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm285/fm285Qry.jsp","���ڻ�����ݣ����Ժ�......");
		 	getdataPacket.data.add("phoneNo",phoneNo);
			getdataPacket.data.add("opCode",globelOpCode);
			getdataPacket.data.add("giftNo",giftNo);
			getdataPacket.data.add("giftName",giftName);
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
		}
		
	function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			var canUseJf = packet.data.findValueByName("canUseJf");
			
		
			if(retCode == "000000"){
				if(infoArray.length == 0){
					rdShowMessageDialog("û�пɶһ���Ʒ!",1);
					return false;
				}	
				/*��ֵ���û���*/
				$("#canUseJf").val(canUseJf);
				var optionStr = "<option value='' selected>--��ѡ��--</option>";
				for(var i=0;i<infoArray.length;i++){
					var giftSum = infoArray[i][0];
					if(giftSum == "0"){
						rdShowMessageDialog("�޿ɶһ���Ʒ��");
						return false;
					}
					var giftNo = infoArray[i][0];
					var giftName = infoArray[i][1];
					var giftContent = infoArray[i][2];
					/*0���ն� 1�ն�*/
					var giftType = infoArray[i][3];
					var giftJf = infoArray[i][5];
					var giftPrice = infoArray[i][7];
					var initPrice = 0;
					if(giftPrice.length != 0){
						initPrice = Number(giftPrice)/100;
					}
					
					optionStr += "<option value='"+giftNo+"|"+giftName+"|"+giftContent+"|"+giftJf+"|"+initPrice+"|"+giftType+"'>"+giftName+"-->"+giftJf+"����</option>"

				}
				$("select[name='giftSel']").empty();
				$("select[name='giftSel']").append(optionStr);
				$("#qryContent1").show();
				$("#qryContent2").show();
				$("#qryContent3").show();
				$("#qryContent4").show();
				
			}else{
				$("#qryContent1").hide();
				$("#qryContent2").hide();
				$("#qryContent3").hide();
				$("#qryContent4").hide();
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				
			}
		}
		
		function showPrtDlg(printType,DlgMessage,submitCfm)
		  {  //��ʾ��ӡ�Ի���
			var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
		  var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
			var sysAccept ="<%=sysAccept%>";                       // ��ˮ��
			var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
			var mode_code=null;                        //�ʷѴ���
			var fav_code=null;                         //�ط�����
			var area_code=null;                    //С������
			var opCode =   globelOpCode;                         //��������
			var phoneNo = "<%=phoneNo%>";                           //�ͻ��绰

		   	var h=300;
		   	var w=400;
		   	var t=screen.availHeight/2-h/2;
		   	var l=screen.availWidth/2-w/2;

		   	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
			var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
		  }

		  function printInfo(printType)
		  {	
		  	if(globelOpCode == "m285"){
			  	var giftSel = $.trim($("select[name='giftSel']").find("option:selected").val());
			  	/*��������ֵ*/
					var giftJf = $.trim($("#giftJf").val());
					var needUseJf = Number(giftJf) * Number($("#dhNum").val());
					var giftArray = new Array();
					giftArray = giftSel.split("|");
					
					//var jfp84 = Math.ceil(Number(needUseJf/84));
					
	        var cust_info=""; //�ͻ���Ϣ
	      	var opr_info=""; //������Ϣ
	      	var retInfo = "";  //��ӡ����
	      	var note_info1=""; //��ע1
	      	var note_info2=""; //��ע2
	      	var note_info3=""; //��ע3
	      	var note_info4=""; //��ע4
	
					cust_info+=" "+"|";
					
					cust_info+="�ֻ����룺"+"<%=phoneNo%>"+"|";
	      	cust_info+="�ͻ�������<%=custName%>|";
					opr_info+="��Ʒ��Ϣ��"+giftArray[1]+"|";
					opr_info+="�һ�������"+$("#dhNum").val()+"|";
					opr_info+="����ֵ��"+needUseJf+"|";
						
						
					
					opr_info+="ҵ������:<%=opName%>"+"|";
					opr_info+="ҵ����ˮ��<%=sysAccept%>"+"|";
					note_info1+= "��ע��|";
					note_info1+="�𾴵Ŀͻ���������ʹ��"+needUseJf+"���ֶһ�"+giftArray[1]+"��Ʒ������δ��ͨ�й��ƶ��Ͱ�ҵ���򱾴ζһ���Ϊ����ѿ�ͨ��ҵ�񣬿�ͨ��ʹ�úͰ�ҵ�񲻻�����κη��ã����ζһ���ʹ��"+needUseJf+"���ֶһ���"+(Number(giftArray[4])*Number($("#dhNum").val()))+"Ԫ�Ͱ�����ȯ����ʹ��"+(Number(giftArray[4])*Number($("#dhNum").val()))+"Ԫ����ȯ�һ�"+giftArray[1]+"��Ʒ��|";
					
					retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		  	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
	
		    	return retInfo;
		  	}else if(globelOpCode == "m336"){
		  		
		  		var radioChl = $.trim($("input[name='radioChl'][checked]").val());
		  		//alert(radioChl);
		  		var infoArr = new Array();
					infoArr = radioChl.split("|");
					
		  		
		  		var cust_info=""; //�ͻ���Ϣ
	      	var opr_info=""; //������Ϣ
	      	var retInfo = "";  //��ӡ����
	      	var note_info1=""; //��ע1
	      	var note_info2=""; //��ע2
	      	var note_info3=""; //��ע3
	      	var note_info4=""; //��ע4
	
					cust_info+=" "+"|";
					
					cust_info+="�ֻ����룺"+"<%=phoneNo%>"+"|";
	      	cust_info+="�ͻ�������<%=custName%>|";
						
					
					opr_info+="ҵ������:<%=opName%>"+"|";
					opr_info+="ҵ����ˮ��<%=sysAccept%>"+"|";
					opr_info+="������Ʒ��"+infoArr[3]+"|";
					opr_info+="�������룺"+infoArr[7]+"|";
					opr_info+="���γ������֣�"+infoArr[8]+"|";
					note_info1+= "��ע��|";
						
					retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		  	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
	
		    	return retInfo;
		  		
		  	}
		  	
		  }
		
	
		function doCfm(){
			
			var opType = $("input[name='opType'][checked]").val();
			if(opType == "m285"){
				
				var giftSel = $.trim($("select[name='giftSel']").find("option:selected").val());
				if(giftSel.length == 0){
					rdShowMessageDialog("��ѡ����Ʒ��");
					return false;
				}
				var dhNumObj = $("#dhNum")[0];
				if(!checkElement(dhNumObj)){
					return false;
				}
				var dhNum = $.trim($("#dhNum").val());
				if(Number(dhNum) <= 0){
					rdShowMessageDialog("�һ���������Ҫ1����");
					return false;
				}
				/*��������ֵ*/
				var giftJf = $.trim($("#giftJf").val());
				var needUseJf = Number(giftJf) * Number($("#dhNum").val());
				var canUseJf = $.trim($("#canUseJf").val()); 
				if(needUseJf > Number(canUseJf)){
					rdShowMessageDialog("���û���ֵ������");
					return false;
				}
				
				var giftArray = new Array();
				giftArray = giftSel.split("|");
				var giftNo = giftArray[0];
			
			}else if(opType == "m336"){
				
				var radioChl = $.trim($("input[name='radioChl'][checked]").val());
				if(radioChl.length==0){
					rdShowMessageDialog("��ѡ�����ѡ�");
					return false;
				}
			}
			
			var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
			if(typeof(ret)!="undefined")
			  {
			    if((ret=="confirm"))
			    {
			      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
			      {
				   		formConfirm();
			      }
					}
				if(ret=="continueSub")
				{
			      if(rdShowConfirmDialog('ȷ���ύ��Ϣô��')==1)
			      {
				    	formConfirm();
			      }
				}
			  }
			else
			  {
			     if(rdShowConfirmDialog('ȷ���ύ��Ϣô��')==1)
			     {
				     formConfirm();
			     }
			  }	
			  return true;
			
			
			
			
		}
		function formConfirm(){
			
			var opType = $("input[name='opType'][checked]").val();
			
			if(opType == "m285"){
				
				var giftSel = $.trim($("select[name='giftSel']").find("option:selected").val());
			
				var dhNumObj = $("#dhNum")[0];
				
				var dhNum = $.trim($("#dhNum").val());
				if(!checkElement($("#dhNum")[0])){
					return false;
				}
				
				var giftType = $.trim($("#giftType").val());
				
				/*��������ֵ*/
				var giftJf = $.trim($("#giftJf").val());
				var needUseJf = Number(giftJf) * Number($("#dhNum").val());
				var canUseJf = $.trim($("#canUseJf").val()); 
				
				
				var giftArray = new Array();
				giftArray = giftSel.split("|");
				var giftNo = giftArray[0];
				
				/*�ύ*/
					/*ajax start*/
				var getdataPacket = new AJAXPacket("/npage/sm285/fm285Cfm.jsp","���ڻ�����ݣ����Ժ�......");
				
				var printAccept = "<%=sysAccept%>";
				/*����opcode��ֵΪopType ��Ϊ�п�����m285����г���m336����*/
				var iOpCode = opType;
				var iPhoneNo = "<%=phoneNo%>";
				
				getdataPacket.data.add("opCode",iOpCode);
				getdataPacket.data.add("phoneNo",iPhoneNo);
				getdataPacket.data.add("giftNo",giftNo);
				getdataPacket.data.add("dhNum",dhNum);
				getdataPacket.data.add("giftJf",giftJf);
				getdataPacket.data.add("giftType",giftType);
				
				getdataPacket.data.add("printAccept",printAccept);
				
				
				core.ajax.sendPacket(getdataPacket,doRetCfm);
				getdataPacket = null;
					
			}else if(opType == "m336"){
				
				var radioChl = $.trim($("input[name='radioChl'][checked]").val());
				var infoArr = new Array();
				infoArr = radioChl.split("|");
								
				var czLoginAccept = $.trim(infoArr[6]);
				var czStringCode = $.trim(infoArr[7]);
				
				/*�ύ*/
					/*ajax start*/
				var getdataPacket = new AJAXPacket("/npage/sm285/fm285CzCfm.jsp","���ڻ�����ݣ����Ժ�......");
				
				var printAccept = "<%=sysAccept%>";
				/*����opcode��ֵΪopType ��Ϊ�п�����m285����г���m336����*/
				var iOpCode = opType;
				var iPhoneNo = "<%=phoneNo%>";
				
				getdataPacket.data.add("opCode",iOpCode);
				getdataPacket.data.add("phoneNo",iPhoneNo);
				getdataPacket.data.add("czLoginAccept",czLoginAccept);
				getdataPacket.data.add("czStringCode",czStringCode);
				
				getdataPacket.data.add("printAccept",printAccept);
				
				
				core.ajax.sendPacket(getdataPacket,doRetCfm);
				getdataPacket = null;
				
			}	
		
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				rdShowMessageDialog("�����ɹ���",2);
				window.location.reload();
			}else{
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				window.location.reload();
			}
			
		}
		
		/*��Ʒ��Ϣ�б�������*/
		function changeGift(){
			var giftSel = $.trim($("select[name='giftSel']").find("option:selected").val());
			if(giftSel.length == 0){
				rdShowMessageDialog("��ѡ����Ʒ��");
				$("#giftContent").html("");
				return false;
			}
			var giftArray = new Array();
			giftArray = giftSel.split("|");
			var giftNo = giftArray[0];
			var giftName = giftArray[1];
			var giftContent = giftArray[2];
			var giftJf = giftArray[3];
			var giftType = giftArray[5];
			/*0���ն�1�ն� �ն�ֻ����һ�1�� ���ն˿��Զһ����*/
			if(giftType == "0"){
				$("#dhNum").attr("class","");	
				$("#dhNum").attr("readonly",false);				
			}
			if(giftType == "1"){
				$("#dhNum").attr("class","InputGrey");	
				$("#dhNum").attr("readonly","readonly");				
			}
			$("#giftContent").html(giftContent);
			$("#giftJf").val(giftJf);
			$("#giftType").val(giftType);
			
		}
		
		/*����ͳ���*/
		function changeType(opCode){
			globelOpCode = opCode;
			if(opCode == "m285"){
				$("input[name='opType']").eq(0).attr("checked","checked");
				
				$("#banliContent").show();
				$("#resultContent").hide();
			}else if(opCode == "m336"){
				
				$("input[name='opType']").eq(1).attr("checked","checked");
				$("#banliContent").hide();
				doCzQuery();
				
				/*���ò�ѯ���� ��ѯ��������*/
			}
		}
		
		
		function doCzQuery(){
			
			/*�ֻ�����*/
			var phoneNo = $.trim($("#phoneNo").val());
				
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm285/fm285CzQry.jsp","���ڻ�����ݣ����Ժ�......");
		 	getdataPacket.data.add("phoneNo",phoneNo);
			getdataPacket.data.add("opCode",globelOpCode);
			
			core.ajax.sendPacket(getdataPacket,doRetRegionCz);
			getdataPacket = null;
			
		}
		
		function doRetRegionCz(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			
			$("#resultContent").show();
			$("#appendBody").empty();
		
			if(retCode == "000000"){
				for(var i=0;i<infoArray.length;i++){
					
					var czPhoneNo = infoArray[i][0];
					var czCustName = infoArray[i][1];
					var czGiftNo = infoArray[i][2];
					var czGiftName = infoArray[i][3];
					var czOpTime = infoArray[i][4];
					var czOpLogin = infoArray[i][5];
					var czLoginAccept = infoArray[i][6];
					var czStringCode = infoArray[i][7];
					var czPoint = infoArray[i][8];
					
					var stringSub = czStringCode.substring(czStringCode.length-6,czStringCode.length);
					
					var appendxing = "";
					for(var j=0;j<(czStringCode.length-6);j++){
						appendxing += "*";
					}
					
					
					var appendStr = "<tr>";
					var appendCheckBoxStr = "<input type='radio' name='radioChl' value='"+czPhoneNo+"|"+czCustName+"|"+czGiftNo+"|"+czGiftName+"|"+czOpTime+"|"+czOpLogin+"|"+czLoginAccept+"|"+czStringCode+"|"+czPoint+"'/> ";
					appendStr += "<td width='10%'>"+appendCheckBoxStr+"</td>"
											+"<td width='12%'>"+czPhoneNo+"</td>"
											+"<td width='12%'>"+czCustName+"</td>"
											+"<td width='13%'>"+czGiftNo+"</td>"
											+"<td width='13%'>"+czGiftName+"</td>"
											+"<td width='13%'>"+appendxing+stringSub+"</td>"
											+"<td width='13%'>"+czOpTime+"</td>"
											+"<td width='13%'>"+czOpLogin+"</td>"
											
					appendStr +="</tr>";	
									
					$("#appendBody").append(appendStr);
				}
				
			}else{
				$("#appendBody").empty();
				//$("#export").attr("disabled","disabled");
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				
			}
		}
	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
		
		 <table id=""  cellspacing="0">      	
       <tr>
        		<td width=20% class="blue">��������</td>
        		<td width=80% colspan="3">
        			<span id="radio1"><input type="radio" name="opType"	value="m285"   onclick="changeType(this.value);" checked/>���� &nbsp;&nbsp;</span>
							<span id="radio2"><input type="radio" name="opType"	value="m336"  onclick="changeType(this.value);"/>���� &nbsp;&nbsp;</span>
						</td>
       </tr>
     </table>  				
		<table id="banliContent">
			
	    <tr>
	  		<td width="20%" class="blue">�������</td>
	  		<td width="80%" colspan="3">
	  			<input type="text" id="phoneNo" name="phoneNo" value="<%=phoneNo%>" class="InputGrey" readonly />
	  			&nbsp;
	  			<input type="button" class="b_text" name="qryBtn" value="��ѯ" onclick="doQry();"/>
	  		</td>
	  	</tr>
	  	<tr style="display:none">
	  			<td width="20%" class="blue">��Ʒ����</td>
		  		<td width="80%" colspan="3">
		  			<input type="text" id="giftNo" name="giftNo"  value=""/>
		  		</td>
	  	</tr>
	  	<tr style="display:block">
		  		<td width="20%" class="blue">��Ʒ����</td>
		  		<td width="80%" colspan="3">
		  			<input type="text" id="giftName" name="giftName" value="" />
		  		</td>
		  	</tr>
	  	<div id="qryContent">
		  	<tr id="qryContent1" style="display:none">
		  		<td width="20%" class="blue">���û���</td>
		  		<td width="80%" colspan="3">
		  			<input type="text" id="canUseJf" name="canUseJf" value="" class="InputGrey" readonly />
		  		</td>
		  		
		  	</tr>
		  	<tr id="qryContent4" style="display:none">
		  		<td width="20%" class="blue">��Ʒ��Ϣ</td>
		  		<td width="80%" colspan="3">
		  			<select name="giftSel" onchange= "changeGift();" style="width:320px">
		  				
		  			</select>
		  		</td>
		  	</tr>
		  	<tr id="qryContent2" style="display:none">
		  		<td width="20%" class="blue">��Ʒ����</td>
		  		<td width="80%" colspan="3" id="giftContent">
		  			
		  		</td>
		  	</tr>
		  	<tr id="qryContent3" style="display:none">
		  		<td width="20%" class="blue">�һ�����</td>
		  		<td width="80%" colspan="3">
		  			<input type="text" id="dhNum" class="InputGrey" name="dhNum" value="1" v_type="0_9" v_must="1" readOnly/>
		  			
		  			<input type="hidden" id="giftJf" name="giftJf" value="" />
		  			<input type="hidden" id="giftType" name="giftType" value="" />
		  			
		  		</td>
		  	</tr>
	  	</div>
	  	
		</table>
		
		<!-- ��ѯ����б� -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">��ѯ����б�</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<th width="10%">ѡ��</th>
			<th width="12%">�ֻ�����</th>
			<th width="12%">�ͻ�����</th>
			<th width="13%">�һ���Ʒ����</th>
			<th width="13%">�һ���Ʒ����</th>
			<th width="13%">�ն˶һ���</th>
			<th width="13%">����ʱ��</th>
			<th width="13%">��������</th>
			
			<tbody id="appendBody">
				
			</tbody>
		</table>
	</div>
			
		<table>
			<tr>
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="sure"  type="button" value="ȷ��&��ӡ"  onclick="doCfm();">&nbsp;&nbsp;
					<input class="b_foot" name="sure"  type="button" value="����"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
					<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=�ر�>
				</td>
			</tr>	
		</table>
	</div>
	<div id="OfferAttribute"></div><!--����Ʒ����-->
	

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel;
	rows=obj.rows.length;
	if(rows>0){
		try{
			excelObj = new ActiveXObject("excel.Application");
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			  for(i=0;i<rows;i++){
			    cells=obj.rows[i].cells.length;
			    for(j=0;j<cells;j++)
			      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
			}
		}
		catch(e){}
	} else {
		
	}
}
</script>
</body>


</html>
