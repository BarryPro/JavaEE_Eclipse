<%
  /*
   * ����: 
   * �汾: 1.0
   * ����: gaopeng 2015/02/11 9:50:29 ����11�·ݼ��ſͻ���CRM��BOSS�;���ϵͳ����ĺ�-7-��ҵӦ��������BOSSϵͳ����
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
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String loginAccept = getMaxAccept();
%>

  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		
		function doQryAccept(){
			
			
			var phoneNo = "";
			var opAccept = $.trim($("#opAccept").val());
			var iccid = $.trim($("#iccid").val());
			
			if(opAccept.length == 0 && iccid.length == 0){
				rdShowMessageDialog("ҵ����ˮ��֤��������������һ�",1);
				return false;
			}
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm257/fm257QryAccept.jsp","���ڻ�����ݣ����Ժ�......");
			
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
			
				$("#resultContent").show();
				$("#resultContent3").hide();
				$("#appendBody").empty();
				$("#appendBody3").empty();
				
				
				var appendTh = 
					"<tr>"
					+"<th width='5%'>ѡ��</th>"
					+"<th width='17%'>������ˮ</th>"
					+"<th width='10%'>�ͻ�����</th>"
					+"<th width='10%'>�ͻ��ֻ�����</th>"
					+"<th width='17%'>֤������</th>"
					+"<th width='17%'>��������</th>"
					+"<th width='17%'>����ʱ��</th>"
					+"<th width='10%'>�ʷ�</th>"
					
					+"</tr>";
				$("#appendBody").append(appendTh);	
				
				for(var i=0;i<infoArray.length;i++){
					
					
					
					var opLoginNo = infoArray[i][0];
					var opTime = infoArray[i][1];
					var opAccept = infoArray[i][2];
					var opCustName = infoArray[i][3];
					var opPhoneNo = infoArray[i][4];
					var oIdNo = infoArray[i][5];
					
					
					
					var appendStr = "<tr>";
						
					appendStr += "<td width='5%' align='center' id='selectRadio'><input type='radio' name='selectRadios' phoneNoM = '"+opPhoneNo+"' value='"+opAccept+"' onclick='doQry(this);'/></td>"
											+"<td width='10%' align='center' id='opAccept'>"+opAccept+"</td>"
											+"<td width='10%' align='center' id='opCustName'>"+opCustName+"</td>"
											+"<td width='5%' align='center' id='opPhoneNo'>"+opPhoneNo+"</td>"
											+"<td width='10%' align='center' id='oIdNo'>"+oIdNo+"</td>"
											+"<td width='10%' align='center' id='opLoginNo'>"+opLoginNo+"</td>"
											+"<td width='10%' align='center' id='opTime'>"+opTime+"</td>"
											+"<td width='10%' align='center' id='postFee'>"+"<input type='text' id='"+opAccept+"_postFee' name='postFee' v_type='money' value='' onblur='checkElement(this);'/>"+"</td>"
										
					appendStr +="</tr>";	
					
					$("#appendBody").append(appendStr);
					
					$("#configBtn").attr("disabled","");
				}
				
				
			}else{
				$("#configBtn").attr("disabled","disabled");
				$("#resultContent").hide();
				$("#appendBody").empty();
				$("#resultContent3").hide();
				$("#appendBody3").empty();
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
			var getdataPacket = new AJAXPacket("/npage/sm257/fm257Qry.jsp","���ڻ�����ݣ����Ժ�......");
			
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
			
		if(retCode == "000000" && infoArray.length > 0){
			
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
					
					
					var newCardMoney = 
					"		<select id='singlePrice' name='singlePrice' >"
					+"     	<option value='10.00'>10.00</option>"
					+"     	<option value='20.00'>20.00</option>"
					+"     	<option value='30.00'>30.00</option>"
					+"     	<option value='50.00'>50.00</option>"
					+"     	<option value='100.00'>100.00</option>"
					+"     	<option value='200.00'>200.00</option>"
					+"     	<option value='300.00'>300.00</option>"
					+"     	<option value='500.00'>500.00</option>"
					+"    </select>";
					
					var oldCardNoStart = infoArray[i][0];
					var oldCardNoEnd = infoArray[i][1];
					var newCardNoStart = infoArray[i][2];
					var newCardNoEnd = infoArray[i][3];
					var isgua = infoArray[i][4];//0 �� 1 ��
					var isguaText = isgua==0?"��":"��";
					
					var custName = infoArray[i][5];
					var phoneNo = infoArray[i][6];
					var iccid = infoArray[i][7];
					var ispost = infoArray[i][8];//�Ƿ��ʼ� 0 �� 1 �ʼ��� 2 ���ʼ�
					var ispostText = ispost==0?"��":"��";
					var callNo = infoArray[i][9];//Ͷ�ߵ���
					var cardMoney = infoArray[i][10];//����ֵ
					
					var opAccept = infoArray[i][11];//����ֵ
					
					
					var appendStr = "<tr>";
						
					appendStr += "<td width='25%' align='center' id='oldCardNoStart'>"+"<input type='text'  name='oldCardNoStart' value='"+oldCardNoStart+"' class='InputGrey' readonly/>"+"</td>"
											+"<td width='25%' align='center' id='cardMoney'>"+cardMoney+"</td>"
											+"<td width='25%' align='center' id='newCardNo'>"+"<input type='text'  name='newCardNo' v_type='0_9' maxlength='17' v_must = '0' onblur='checkElement(this);' value=''/>"+"&nbsp;&nbsp;</td>"
											+"<td width='25%' align='center' id='newCardMoney'>"+newCardMoney+"</td>"
					appendStr +="</tr>";	
					
					$("#appendBody3").append(appendStr);
					
					$("#configBtn").attr("disabled","");
					
				}
				
				
			}else{
				$("#configBtn").attr("disabled","disabled");
				$("#resultContent3").hide();
				$("#appendBody3").empty();
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				
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
		 
			opr_info += "����ҵ��ǧԪ������ʡ��ֵ������ʡ�տ��ʼ�"+"|";
			opr_info += "������ˮ��<%=loginAccept%>       "+"|";
			
			
			
			$("#appendBody3 tr:gt(0)").each(function(){
					var temp_iNewCardNoStart = $(this).find("td:eq(2)").find("input").val().trim();
					var temp_iNewMoney       = $(this).find("td:eq(3)").find("select").find("option:selected").val().trim();
					if($.trim(temp_iNewCardNoStart).length != 0){
					opr_info += "�³�ֵ���ţ�"+temp_iNewCardNoStart+"        �³�ֵ����ֵ��"+temp_iNewMoney+"Ԫ"+"|";
					}	
			});
			
			
			note_info1 += "��ע���ͻ�����ֵ�����ں������ƶ����ɺ������ƶ�����ֵ�������������Ϣ������������˾�����ɷ�����˾���������˾������ֵ���Ƿ񾭹���ֵ��"+"|";
			note_info1 += "���У�����δ������ֵ�ģ�������˾����������ֵ���ĵ�ֵ����ֵ������������˾��"+"|";
			
			retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		 	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
		 	
		  return retInfo;
		  
		}
		
		
	
		/*2015/02/11 9:42:59 gaopeng �ύ����*/
		function nextStep(){
			
				var postFlag = true;
				
				var postFee = $.trim($("#"+globeAccept+"_postFee").val());
				var postFeeObj = $("#"+globeAccept+"_postFee")[0];
				
				if(postFee.length == 0){
					rdShowMessageDialog("�������ʷ�!",1);
					postFlag = false;
					return false;
				}
				if(!checkElement(postFeeObj)){
					postFlag = false;
					return false;
				}
			
				/*����,�ָ���¿�����*/
				var oldCardNoStr = "";
				var newCardNoStr = "";
				var newCardPriceStr = "";
				/*��ɢ����*/
				$("input[name='newCardNo']").each(function(){
					var newCardObj = $(this)[0];
					var newCardNo = $.trim($(this).val());
					if(!checkElement(newCardObj)){
							postFlag = false;
							return false;
					}
					if(newCardNo.length != 0){
						if(newCardNo.length != 17){
							rdShowMessageDialog("�¿��ű���Ϊ17λ!",1);
							postFlag = false;
							return false;
						}
					}
					if(newCardNo.length == 0){
						newCardNo = "0";
					}
					
					if($.trim(newCardNoStr).length == 0){
						newCardNoStr = newCardNo;
					}else{
						newCardNoStr += ","+newCardNo;
					}
				});
				
				/*��ֵ*/
				$("select[name='singlePrice']").each(function(){
					
					if($.trim(newCardPriceStr).length == 0){
						newCardPriceStr = $.trim($(this).find("option:selected").val());
					}else{
						newCardPriceStr += ","+$.trim($(this).find("option:selected").val());
					}
				});
				
				
				
				$("input[name='oldCardNoStart']").each(function(){
					
					if($.trim(oldCardNoStr).length == 0){
						oldCardNoStr = $.trim($(this).val());
					}else{
						oldCardNoStr += ","+$.trim($(this).val());
					}
				});
				
				if(postFlag){
					showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
        			
					if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
							/*ajax start*/
						var getdataPacket = new AJAXPacket("/npage/sm257/fm257Cfm.jsp","���ڻ�����ݣ����Ժ�......");
						
						var iLoginAccept = globeAccept;
						var iChnSource = "01";
						var iOpCode = "<%=opCode%>";
						var iLoginNo = "<%=loginNo%>";
						var iLoginPwd = "<%=noPass%>";
						var iPhoneNo = globePhoneNo;
						var iUserPwd = "";
						
						
						getdataPacket.data.add("iLoginAccept",iLoginAccept);
						getdataPacket.data.add("iChnSource",iChnSource);
						getdataPacket.data.add("iOpCode",iOpCode);
						getdataPacket.data.add("iLoginNo",iLoginNo);
						getdataPacket.data.add("iLoginPwd",iLoginPwd);
						getdataPacket.data.add("iPhoneNo",iPhoneNo);
						getdataPacket.data.add("iUserPwd",iUserPwd);
						
						getdataPacket.data.add("postFee",postFee);
						
						getdataPacket.data.add("oldCardNoStr",oldCardNoStr);
						getdataPacket.data.add("newCardNoStr",newCardNoStr);
						getdataPacket.data.add("newCardPriceStr",newCardPriceStr);
						
						
						core.ajax.sendPacket(getdataPacket,doRetCfm);
						getdataPacket = null;
				}
			}
		
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			
			
			if(retCode == "000000"){
				
				rdShowMessageDialog("�����ɹ�!",2);
				window.location.reload();
			}else{
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				window.location.reload();
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
		<table>
	    <tr>
	  		<td width="20%" class="blue">ҵ����ˮ</td>
	  		<td width="30%">
	  			<input type="text" id="opAccept" name="opAccept" v_type="0_9"  value="" onblur="checkElement(this)"/>&nbsp;&nbsp;
	  			<input type="button" id="qryUnitBtn" class="b_text" name="qryUnitBtn" value="��ѯ" onclick="doQryAccept();"/>
	  		</td>
	  		<td width="20%" class="blue">֤������</td>
	  		<td width="30%">
	  			<input type="text" id="iccid"  name="iccid"    value="" />
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
				<input class="b_foot" id="configBtn" name="configBtn"  type="button" value="ȷ��&��ӡ" disabled="disabled"  onclick="nextStep();">&nbsp;&nbsp;
				<input class="b_foot" id="resetBtn" name="resetBtn"  type="button" value="����"  onclick="javascript:window.location.href='/npage/sm257/fm257Main.jsp?opName=<%=opName%>&opCode=<%=opCode%>'">&nbsp;&nbsp;
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
