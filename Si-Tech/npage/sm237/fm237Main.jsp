<%
  /*
   * ����: �����Ż�4GLTE-FIҵ����ع��ܵ�����
   * �汾: 1.0
   * ����: 2014/08/11 9:23:54
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
			window.location = '/npage/sm231/fm231Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
</script>
<%
			return ;
		}
		else
		{
			custName = result11[0][5];
		}
%>


  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		
		
		

		
		function doQry(){
			
			var phoneNo = $.trim($("#phoneNo").val());
			
			if(phoneNo.length == 0){
				rdShowMessageDialog("�������ֻ����룡",1);
				return false;
			}
			var filedName = $.trim($("#filedName").val());
				
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm237/fm237Qry.jsp","���ڻ�����ݣ����Ժ�......");
			
			getdataPacket.data.add("offerId","");
		 	getdataPacket.data.add("phoneNo","<%=phoneNo%>");
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("offerName",filedName);
			
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
		}
		
	function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			
			var inOffer = packet.data.findValueByName("inOffer");
			var vProdOfferName = packet.data.findValueByName("vProdOfferName");
			var vBothName = packet.data.findValueByName("vBothName");
			var vFlagCode = packet.data.findValueByName("vFlagCode");
			var vFlagName = packet.data.findValueByName("vFlagName");
			var vBothFlagName = packet.data.findValueByName("vBothFlagName");
			
			
		
		if(retCode == "000000"){
				if(infoArray.length == 0){
					rdShowMessageDialog("û�пɱ����С��!",1);
					return false;
				}	
				$("#resultContent").show();
				$("#appendBody").empty();
				$("#phoneNo").attr("readonly","readonly");
				$("#phoneNo").attr("class","InputGrey");
				
				var appendTh = 
					"<tr>"
					+"<th width='20%'>���ʷѴ���</th>"
					+"<th width='20%'>���ʷ�����</th>"
					+"<th width='20%'>�û���ǰС������</th>"
					+"<th width='20%'>�û���ǰС������</th>"
					+"<th width='20%'>��ѡС��</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);	
			
			
					var appendSelectStart = "<select name='selCode' >";
					var appendSelectEnd = "</select>";
					
					var appendSelectCons = "";
					for(var i=0;i<infoArray.length;i++){
						var msg0 = infoArray[i][0];
						var msg1 = infoArray[i][1];
						var appendStr = "<option value='"+msg0+"'>"+msg1+"</option>";
						appendSelectCons += appendStr;
					}
					
					
			
			
					var appendStr = "<tr>";
					
					appendStr += "<td width='20%'>"+inOffer+"</td>"
											+"<td width='20%'>"+vProdOfferName+"</td>"
											+"<td width='20%'>"+vFlagCode+"</td>"
											+"<td width='20%'>"+vFlagName+"</td>"
											+"<td width='20%'>"+appendSelectStart+appendSelectCons+appendSelectEnd+"</td>"
											
					appendStr +="</tr>";	
									
					$("#appendBody").append(appendStr);
				
				if(infoArray.length != 0){
					//$("#export").attr("disabled","");
				}
				
			}else{
				$("#resultContent").hide();
				$("#appendBody").empty();
				//$("#export").attr("disabled","disabled");
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
			var phoneNo = "<%=phoneNo%>";                      //�ͻ��绰
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
			//��ȡ��Ϣ
			$("#appendBody tr:gt(0)").each(function(){
				
					idno           = $(this).find("td:eq(0)").text().trim();
					ocontact_phone = $.trim($("#phoneNo").val());
					ocontact_name  = $.trim($("#custName").val());
				
			});
			
		  cust_info+="�ֻ����룺   "+ocontact_phone+"|";
		  cust_info+="�ͻ�������   "+ocontact_name+"|";
		  
		 	
			opr_info += "����ҵ��С��Ǩ��"+"|";
			opr_info +="���ʷѴ��룺"+idno+"|";
			opr_info += "������ˮ��<%=loginAccept%>"+"|";
			
			
			
			$("#appendBody tr:gt(0)").each(function(){
					var custOldAddr = $(this).find("td:eq(2)").text().trim() + "-->" +$(this).find("td:eq(3)").text().trim();
					var custNewAddr = $(this).find("td:eq(4)").find("select").find("option:selected").text().trim();
					
					opr_info += "�ͻ�ԭС����"+custOldAddr+"|";
					opr_info += "�ͻ���С����"+custNewAddr+"|";
					
			});
			
			
			note_info1 += "��ע��"+"|";
			
			
			retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		 	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
		 	
		  return retInfo;
		  
		}
		
		function doCfm(){
			
			showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
			if(rdShowConfirmDialog("ȷ���ύô?") == 1){
				/*�ύ*/
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm237/fm237Cfm.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = "<%=phoneNo%>";
			var iUserPwd = "";
			var selectCode = $("select[name='selCode']").find("option:selected").val();
			
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("selectCode",selectCode);
			
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
	  		<td width="20%" class="blue">�������</td>
	  		<td width="30%">
	  			<input type="text" id="phoneNo" name="phoneNo" value="<%=phoneNo%>" class="InputGrey" readonly />
	  		</td>
	  		<td width="20%" class="blue">�ͻ�����</td>
	  		<td width="30%">
	  			<input type="text" id="custName" name="custName" value="<%=custName%>" class="InputGrey" readonly />
	  		</td>
	  	</tr>
	  	<tr>
	  		<td width="20%" class="blue">С������</td>
	  		<td width="80%" colspan="3">
	  			<input type="text" id="filedName" name="filedName" value="" />
	  		</td>
	    </tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" name="sure"  type="button" value="��ѯ"  onclick="doQry();">&nbsp;&nbsp;
				<input class="b_foot" name="sure"  type="button" value="����"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=�ر�>
			</td>
		</tr>
		</table>
	</div>
	<div id="OfferAttribute"></div><!--����Ʒ����-->
	<!-- ��ѯ����б� -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">��ѯ����б�</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<tbody id="appendBody">
				
			
			</tbody>
		</table>
		<table>
			<tr>
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="sure"  type="button" value="ȷ��&��ӡ"  onclick="doCfm();">&nbsp;&nbsp;
					<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=�ر�>
				</td>
			</tr>
		</table>
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
