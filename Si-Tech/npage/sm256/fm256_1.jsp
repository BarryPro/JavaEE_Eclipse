<%
/********************
 
 -------------------------����-----------�ξ�ΰ(hejwa) 2015/3/30 9:37:17-------------------
������ʡ�мۿ����������ܡ�
��ѯ������֤������/ҵ����ˮ

�ȸ���֤��������в�ѯ����ѯ����Ӧ�Ĳ�����¼��ȷ��һ��������ˮ�����������ˮ����ȥ��ѯ��Ӧ�Ŀ���

 -------------------------��̨��Ա��jingang--------------------------------------------
 
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 

    String regionCode = (String)session.getAttribute("regCode");
    String loginNo    = (String)session.getAttribute("workNo");
 		String noPass     = (String)session.getAttribute("password");
 		String groupID    = (String)session.getAttribute("groupId");
 		
 		String opCode     = (String)request.getParameter("opCode");
		String opName     = (String)request.getParameter("opName");
		String phoneNo    = (String)request.getParameter("activePhone");
%>

  	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript">
		
		function doQryAccept(){
			
			
			var phoneNo = "";
			var opAccept = $.trim($("#opAccept").val());
			var iccid = $.trim($("#iccid").val());
			
			if(opAccept.length == 0 && iccid.length == 0){
				rdShowMessageDialog("ҵ����ˮ��֤��������������һ�",1);
				return false;
			}
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("fm256_2.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = phoneNo;
			var iUserPwd = "";
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iOpName","<%=opName%>");
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("opAccept",opAccept);
			getdataPacket.data.add("iccid",iccid);
			
			
			core.ajax.sendPacket(getdataPacket,doRetRegionAcc);
			getdataPacket = null;
			
			
		}
		
		function doRetRegionAcc(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			
		if(retCode == "000000" ){
			
			if(infoArray.length > 0){
				$("#resultContent").show();
				$("#appendBody").empty();
				
				
				var appendTh = 
					"<tr>"
					+"<th width='5%'>ѡ��</th>"
					+"<th width='10%'>������ˮ</th>"
					+"<th width='15%'>�ͻ�����</th>"
					+"<th width='15%'>�ͻ��ֻ�����</th>"
					+"<th width='22%'>֤������</th>"
					+"<th width='10%'>��������</th>"
					+"<th >����ʱ��</th>"
					
					+"</tr>";
				$("#appendBody").append(appendTh);	
				
				for(var i=0;i<infoArray.length;i++){
					
					
					
					var opLoginNo = infoArray[i][0];
					var opTime = infoArray[i][1];
					var opAccept = infoArray[i][2];
					var opCustName = infoArray[i][3];
					var opPhoneNo = infoArray[i][4];
					
					
					
					var appendStr = "<tr>";
						
					appendStr += "<td align='center'  ><input type='radio' name='selectRadios' phoneNoM = '"+opPhoneNo+"' value='"+opAccept+"' onclick='doQry(this);'/></td>"
											+"<td align='center'  >"+opAccept+"</td>"
											+"<td align='center'  >"+opCustName+"</td>"
											+"<td align='center'  >"+opPhoneNo+"</td>"
											+"<td align='center'  >"+infoArray[i][5]+"</td>"
											+"<td align='center'  >"+opLoginNo+"</td>"
											+"<td align='center'  >"+opTime+"</td>"
										
					appendStr +="</tr>";	
					
					$("#appendBody").append(appendStr);
					
					$("#configBtn").attr("disabled","");
				}
				
				}else{
					$("#configBtn").attr("disabled","disabled");
					$("#resultContent").hide();
					$("#appendBody").empty();
					rdShowMessageDialog("��ѯ���Ϊ��",1);
				}
			}else{
				$("#configBtn").attr("disabled","disabled");
				$("#resultContent").hide();
				$("#appendBody").empty();
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				
			}
		}
		
		
		var globeAccept = "";
		var globePhoneNo = "";
		function doQry(obj){
			
			/*ȫ�ֱ���������ˮ*/
			globeAccept = obj.value;
			globePhoneNo = obj.phoneNoM;
			
			var phoneNo = "";
			var opAccept = $.trim(obj.value);
			
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("fm256_3.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = phoneNo;
			var iUserPwd = "";
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iOpName","<%=opName%>");
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("opAccept",opAccept);
			getdataPacket.data.add("iccid","");
			
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
		}
		
	function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			
		if(retCode == "000000" ){
			if(infoArray.length > 0){
			
				$("#resultContent3").show();
				$("#appendBody3").empty();
				
				
				var appendTh = 
					"<tr>"
					+"<th width='25%'>�ɿ���</th>"
					+"<th width='25%'>�ɿ���ֵ</th>"
					+"<th width='25%'>�¿���</th>"
					+"<th width='25%'>�¿���ֵ</th>"
					+"</tr>";
				$("#appendBody3").append(appendTh);	
				
				for(var i=0;i<infoArray.length;i++){
				 
					var oldCardNoStart = infoArray[i][0];
					var oldCardNoEnd = infoArray[i][1];
					var newCardNoStart = infoArray[i][2];
					var newCardNoEnd = infoArray[i][3];
					var isgua = infoArray[i][4];//0 �� 1 ��
					var isguaText = isgua==0?"��":"��";
					
					var custName = infoArray[i][5];
					var phoneNo = infoArray[i][6];
					var iccid = infoArray[i][7];
					var cardMoney = infoArray[i][10];//����ֵ
					
					var opAccept = infoArray[i][11];//����ֵ
					
					
					var appendStr = "<tr>";
						
					appendStr += "<td align='center' >"+oldCardNoStart+"</td>"
										  +"<td align='center' >"+cardMoney+"</td>"
											+"<td align='center' >"+"<input type='text'  name='newCardNo' maxlength='17' onblur='get_NewCardMoney(this);' value=''  />"+"</td>"
											+"<td align='center' ></td>"
					appendStr +="</tr>";	
					
					$("#appendBody3").append(appendStr);
					$("#configBtn").attr("disabled","");
					
				}
				
				}else{	
					$("#configBtn").attr("disabled","disabled");
					$("#resultContent3").hide();
					$("#appendBody3").empty();
					rdShowMessageDialog("��ѯ���Ϊ��",1);
				}
			}else{
				$("#configBtn").attr("disabled","disabled");
				$("#resultContent3").hide();
				$("#appendBody3").empty();
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				
			}
		}
		
//У������Ƿ�Ϊ����
function fucCheckNUM(val){
	var reg = /^\d{17}$/;
	return reg.test(val);
}
	
var trObj = null;
//��ȡ�¿��ŵ���ֵ
function get_NewCardMoney(bt){
	var card_no = $(bt).val();
	if(card_no=="") return;
	
	if(!fucCheckNUM(card_no)){
		rdShowMessageDialog("���ű���Ϊ17λ����");
		return;
	} 
	
	var i_num = 0;
	$("#appendBody3 tr:gt(0)").each(function(){
		if(card_no==$(this).find("td:eq(0)").text().trim()){
			i_num ++;
		}
		if(card_no==$(this).find("td:eq(2)").find("input").val()){
			i_num ++ ;
		}
	});
	if(i_num > 1){//һ�����Լ�������һ�ο϶������ظ��Ŀ���
		rdShowMessageDialog("�ظ��Ŀ���");
		$(bt).val("");
		return;
	}
	
	trObj = $(bt).parent().parent();
	var packet = new AJAXPacket("fm256_5.jsp","���Ժ�...");
      packet.data.add("iNewCard",$(bt).val());//
    core.ajax.sendPacket(packet,doGet_NewCardMoney);
    packet =null;	
}
function doGet_NewCardMoney(packet){
	var NewCardMoney = packet.data.findValueByName("NewCardMoney");//�¿��Ŷ�Ӧ����ֵ
	if(NewCardMoney == ""){
		rdShowMessageDialog("δ�鵽�ÿ��ŵ���ֵ");
		trObj.find("td:eq(2)").find("input").val("");
	}else{
		trObj.find("td:eq(2)").find("input").attr("disabled","disabled");
		trObj.find("td:eq(3)").text(NewCardMoney);
		trObj = null;
	}
}


function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
	var pType="print";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
	var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
	var sysAccept ="<%=loginAccept%>";       // ��ˮ��
	var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
	var mode_code=null;                    //�ʷѴ���
	var fav_code=null;                     //�ط�����
	var area_code=null;                    //С������
	var opCode =   "<%=opCode%>";          //��������
	var phoneNo = "";                      //�ͻ��绰
	var h=150;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
}

function printInfo(printType)
{
         		
	var cust_info=""; //�ͻ���Ϣ
	var opr_info=""; //������Ϣ
	var retInfo = "";  //��ӡ����
	var note_info1=""; //��ע1
	var note_info2=""; //��ע2
	var note_info3=""; //��ע3
	var note_info4=""; //��ע4

	var idno = "";
	var ocontact_phone = "";
	var ocontact_name = "";
	//��ȡ֤������
	$("#appendBody tr:gt(0)").each(function(){
		if($(this).find("input[type='radio']").attr("checked")==true){
			idno           = $(this).find("td:eq(4)").text().trim();
			ocontact_phone = $(this).find("td:eq(3)").text().trim();
			ocontact_name  = $(this).find("td:eq(2)").text().trim();
		}
	});
	
  cust_info+="�ֻ����룺   "+ocontact_phone+"|";
  cust_info+="�ͻ�������   "+ocontact_name+"|";
  cust_info+="֤�����룺   "+idno+"|";
 
	opr_info += "����ҵ����ʡ���ֳ����������ǧԪ���£�"+"|";
	opr_info += "������ˮ��<%=loginAccept%>       ��ֵ�������ѣ�0Ԫ"+"|";
	
	$("#appendBody3 tr:gt(0)").each(function(){
			var temp_iOldCardNoStart = $(this).find("td:eq(0)").text().trim();
			var temp_iOldMoney       = $(this).find("td:eq(1)").text().trim();
			
			opr_info += "ԭ��ֵ���ţ�"+temp_iOldCardNoStart+"        ԭ��ֵ����ֵ��"+temp_iOldMoney+"Ԫ"+"|";
			
	});
	
	$("#appendBody3 tr:gt(0)").each(function(){
			var temp_iNewCardNoStart = $(this).find("td:eq(2)").find("input").val().trim();
			var temp_iNewMoney       = $(this).find("td:eq(3)").text().trim();
			if(temp_iNewCardNoStart!=""){
				opr_info += "�³�ֵ���ţ�"+temp_iNewCardNoStart+"        �³�ֵ����ֵ��"+temp_iNewMoney+"Ԫ"+"|";
			}
			
	});
	
	
	note_info1 += "��ע��ԭ��ֵ��������Ӫҵ��Ա����"+"|";
	
	retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
 	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
 	
  return retInfo;
  
}

//ҳ���ύ
function goSubmit(){
	
	var iOldCardNoStart = new Array();//�ɿ���ʼ
	var iNewCardNoStart = new Array();//�¿���ʼ
	
	var iOldMoney       = new Array();//�ɿ���ֵ
	var iNewMoney       = new Array();//�¿���ֵ
	
	var iNewMoneySum    = 0;
	$("#appendBody3 tr:gt(0)").each(function(){
			
			var temp_iOldCardNoStart = $(this).find("td:eq(0)").text().trim();
			var temp_iOldMoney       = $(this).find("td:eq(1)").text().trim();
			var temp_iNewCardNoStart = $(this).find("td:eq(2)").find("input").val().trim();
			var temp_iNewMoney       = $(this).find("td:eq(3)").text().trim();
			
			iNewMoneySum = parseInt(temp_iNewMoney) + iNewMoneySum;
			//У��ͨ��ѹ������
			iOldCardNoStart.push(temp_iOldCardNoStart);
			if(temp_iNewCardNoStart!=""){
				iNewCardNoStart.push(temp_iNewCardNoStart);
			}
			iOldMoney.push(temp_iOldMoney);
			if(temp_iNewMoney!=""){
				iNewMoney.push(temp_iNewMoney);
			}
		
	});
	
	if(iNewMoneySum>999){
		rdShowMessageDialog("�¿���ֵ�ܶ�ܳ���1000Ԫ");
		return;
	}
	//alert("iNewCardNoStart.length = "+iNewCardNoStart.length+"\niOldCardNoStart = "+iOldCardNoStart+"\niNewCardNoStart = "+iNewCardNoStart+"\niOldMoney="+iOldMoney+"\niNewMoney="+iNewMoney);
	if(iNewCardNoStart.length==0){
		rdShowMessageDialog("û���¿�");
		return;
	}
	var idno = "";
	//��ȡ֤������
	$("#appendBody tr:gt(0)").each(function(){
		if($(this).find("input[type='radio']").attr("checked")==true){
			idno = $(this).find("td:eq(4)").text().trim()
		}
	});
		
		showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
        			
		if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
			var packet = new AJAXPacket("fm256_4.jsp","���Ժ�...");
			    packet.data.add("opCode","<%=opCode%>");//opcode
			    packet.data.add("idno",idno);//
			    packet.data.add("iOldCardNoStart",iOldCardNoStart+"");//
			    packet.data.add("iOldCardNoEnd","");//
			    packet.data.add("iNewCardNoStart",iNewCardNoStart+"");//
			    packet.data.add("iNewCardNoEnd","");//
			    packet.data.add("iOpNote","����Ա<%=loginNo%>Ϊ�ͻ�"+$("#ocontact_name").text()+"����<%=opName%>");//
			    packet.data.add("icardnumber",$("#ocard_money").text());//
			    packet.data.add("iOldMoney",iOldMoney+"");//
			    packet.data.add("iNewMoney",iNewMoney+"");//
			    core.ajax.sendPacket(packet,doSubmit);
			    packet =null;
	}
}


function doSubmit(packet){
			var error_code = packet.data.findValueByName("code");//���ش���
    	var error_msg  = packet.data.findValueByName("msg");//������Ϣ

    	if(error_code=="000000"){//����ʧ�ɹ�
    		rdShowMessageDialog("�����ɹ�",2);
    		removeCurrentTab();
    	}else{
    		rdShowMessageDialog("����ʧ��"+error_code+"��"+error_msg,0);
    	}
}

	function resetThispage(){
		location = location;
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
		<table>
	    <tr>
	  		<td width="20%" class="blue">ҵ����ˮ</td>
	  		<td width="30%">
	  			<input type="text" id="opAccept" name="opAccept" v_type="0_9"  value="" onblur="checkElement(this)"/>&nbsp;&nbsp;
	  			<input type="button" id="qryUnitBtn" class="b_text" name="qryUnitBtn" value="��ѯ" onclick="doQryAccept();"/>
	  		</td>
	  		<td width="20%" class="blue">֤������</td>
	  		<td width="30%">
	  			<input type="text" id="iccid"  name="iccid"  value="" />
	    </tr>
	  </table>
	 </div>
	 
	 <!-- ��ѯ����б� -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">�мۿ�������Ϣ��ѯ���</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<tbody id="appendBody">
				
			
			</tbody>
		</table>
	</div>
	
	<div id="resultContent3" style="display:none">
		<div class="title">
			<div id="title_zi">�мۿ���Ϣ��ѯ���</div>
		</div>
		<table id="exportExcel3" name="exportExcel3">
			<tbody id="appendBody3">
				
			
			</tbody>
		</table>
	</div>
	
	 <table>
	   <tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" id="configBtn" name="configBtn"  type="button" value="�ύ" disabled="disabled"  onclick="goSubmit();">&nbsp;&nbsp;
				<input class="b_foot" id="resetBtn" name="resetBtn"  type="button" value="����"  onclick="resetThispage();">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=�ر�>
			</td>
		</tr>
		
		</table>
		<!-- ȷ�Ͻ���б� -->
	<div id="resultContent2" style="display:none">
		<div class="title">
			<div id="title_zi">������������&nbsp;&nbsp;&nbsp;&nbsp;<font class="orange" id="appendResultCon"></font></div>
		</div>
		<table id="exportExcel2" name="exportExcel2">
			<tbody id="appendBody2">
				
			
			</tbody>
		</table>
	</div>
	
	</div>
	
	 

	<%@ include file="/npage/include/footer.jsp" %>
</form>
 
</body>


</html>
