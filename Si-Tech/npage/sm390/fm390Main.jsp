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
<%@ page import="java.text.SimpleDateFormat"%>
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
		String nowMonth =new SimpleDateFormat("yyyyMM").format(new java.util.Date()).toString();
		
    
		/*
	  String[][] temfavStr = (String[][])session.getAttribute("favInfo");
		String[] favStr = new String[temfavStr.length];
		boolean operFlag = false;
		for(int i = 0; i < favStr.length; i ++) {
			favStr[i] = temfavStr[i][0].trim();
		}
		if (WtcUtil.haveStr(favStr, "a996")) {
			operFlag = true;
		}*/
		
		
	
	 
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
			
			
			var batOpCode = $.trim($("select[name='batOpCode']").find("option:selected").val());
			var opAccept = $.trim($("#opAccept").val());
			if(opAccept.length == 0){
				rdShowMessageDialog("�����������ˮ��");
				return false;
			}
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm390/fm390Qry.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = batOpCode;
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = "";
			var iUserPwd = "";
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("opAccept",opAccept);
			
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
		}
	var phoneIdNo = "";
	function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			
			var phoneMsg = packet.data.findValueByName("phoneMsg");
			var phoneIdNo1 = packet.data.findValueByName("phoneIdNo");
			phoneIdNo = phoneIdNo1;
			
		if(retCode == "000000"){
			
				$("#phoneMsg").val(phoneMsg);
				$("#resultContent").show();
				$("#appendBody").empty();
				var batOpCode = $.trim($("select[name='batOpCode']").find("option:selected").val());
				var batOpName = $.trim($("select[name='batOpCode']").find("option:selected").text());
				var showOpCode = "";
				var showOpName = "";
				if(batOpCode == "m389"){
					showOpCode = "m058";
					showOpName = "ʵ���Ǽ�";
				}
				var appendTh = 
					"<tr>"
					+"<th style='display:none' width='10%'><input type='checkbox' style='display:none' name='checkall' onclick='checkAllCG();'/> ȫѡ</th>"
					+"<th width='10%'>�ֻ�����</th>"
					+"<th width='12%'>��������</th>"
					+"<th width='12%'>����ʱ��</th>"
					+"<th width='12%'>����ҵ���������</th>"
					+"<th width='12%'>����ҵ���������</th>"
					+"<th width='12%'>�������</th>"
					+"<th width='12%'>ʧ��ԭ��</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);	
			for(var i=0;i<infoArray.length;i++){
			
					var arr0 = infoArray[i][0];
					var arr1 = infoArray[i][1];
					var arr2 = infoArray[i][2];
					var arr3 = infoArray[i][3];
					var arr4 = infoArray[i][4];
					var arr5 = infoArray[i][5];
					
					var appendStr = "<tr>";
					
					appendStr +=
											"<td style='display:none' width='10%' align='center' >"+"<input type='checkbox' style='display:none' name='checkOne'/>"+"</td>" 
											+"<td width='12%' align='center' >"+arr0+"</td>"
											+"<td width='12%' align='center' >"+arr2+"</td>"
											+"<td width='12%' align='center' >"+arr1+"</td>"
											+"<td width='12%' align='center' >"+batOpCode+"</td>"
											+"<td width='12%' align='center' >"+batOpName+"</td>"
											+"<td width='12%' align='center' >"+arr5+"</td>"
											+"<td width='12%' align='center' >"+arr4+"</td>"
					appendStr +="</tr>";	
					
					
									
					$("#appendBody").append(appendStr);
					$("input[name='checkall']").attr("checked","checked")
					checkAllCG();
				}
				
				
			}else{
				$("#resultContent").hide();
				$("#appendBody").empty();
				//$("#export").attr("disabled","disabled");
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				
			}
		}
		
		/*�����гɹ��Ķ�ѡ��*/
		function checkAllCG(){
			var checkall = $("input[name='checkall']").attr("checked");
			$("#appendBody").find("tr").each(function(){
				var cgFlag = $(this).find("td").eq(6).html();
				if(cgFlag == "�ɹ�"){
					if(checkall){
						$(this).find("td").eq(0).find("input").attr("checked","checked");
					}else{
						$(this).find("td").eq(0).find("input").attr("checked",false);
					}
				}
				
			});
			
		}
		/*��ӡ���*/
		var banliNum = 0;
		function doprintM(){
			
			doChkPrint();
			if(!chkFlag){
				return false;
			}
			
			var phoneMsg = $("#phoneMsg").val();
			var msgArr = new Array();
			msgArr = phoneMsg.split("\\|");
			//�ֻ�����|�Ͽͻ�����|�¿ͻ�����|��֤������|�¿ͻ���ַ|24�������Ʊ�ʶ
			var phoneNo = msgArr[0];
			
			/*��ȡ�ɹ��Ĳ���ӡ���*/
			var i=0;
			var phoneNo = "";
			$("#appendBody").find("tr").each(function(){
				var checkOne = $(this).find("td").eq(0).find("input").attr("checked");
				var cgFlag = $(this).find("td").eq(6).html();
				if(cgFlag == "�ɹ�"){
					if(checkOne){
						i++;
					}else{
						
					}
				}
				
			});
			
			if(i==0){
				rdShowMessageDialog("û�в����ɹ�����Ϣ��");
				return false;
			}
			banliNum = i;
			phoneNo = phoneNo+"��"+i+"��";
			
			var  ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes",phoneNo);
			
			var pactket2 = new AJAXPacket("/npage/sm390/fm390UpDserv.jsp","���ڽ��е��ӹ���״̬�޸ģ����Ժ�......");
			//alert(phoneIdNo);
			pactket2.data.add("id_no",phoneIdNo);
			pactket2.data.add("paySeq",$.trim($("#opAccept").val()));
			core.ajax.sendPacket(pactket2,doserv);
			pactket2=null;
			
		}
		
		function doserv(packet)
		{
			var s_ret_code = packet.data.findValueByName("s_ret_code");
			var s_ret_msg = packet.data.findValueByName("s_ret_msg");
		//	alert("s_ret_code is "+s_ret_code);
			if(s_ret_code!="000000")
			{
				//rdShowMessageDialog("���µ��ӹ���״̬ʧ��!�������:"+s_ret_code+",����ԭ��:"+s_ret_msg);
			}
		}
		
		function showPrtDlg(printType,DlgMessage,submitCfm){  //��ʾ��ӡ�Ի��� 
			
			var phoneMsg = $("#phoneMsg").val();
			var msgArr = new Array();
			msgArr = phoneMsg.split("|");
			//�ֻ�����|�Ͽͻ�����|�¿ͻ�����|��֤������|�¿ͻ���ַ|24�������Ʊ�ʶ
			var phoneNo = msgArr[0];
      var h=180;
      var w=350;
      var t=screen.availHeight/2-h/2;
      var l=screen.availWidth/2-w/2;		   	   
      var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
      var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
      var sysAccept =$.trim($("input[name='opAccept']").val());             	//��ˮ��
        var printStr = printInfo(printType);
      
	 		                      //����printinfo()���صĴ�ӡ����
      var mode_code=null;           							  //�ʷѴ���
      var fav_code=null;                				 		//�ط�����
      var area_code=null;             				 		  //С������
      var opCode="m389" ;                   			 	//��������
      
      
      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
      path+="&mode_code="+mode_code+
      	"&fav_code="+fav_code+"&area_code="+area_code+
      	"&opCode="+opCode+"&sysAccept="+$.trim($("input[name='opAccept']").val())+
      	"&phoneNo="+phoneNo+
      	"&submitCfm="+submitCfm+"&pType="+
      	pType+"&billType="+billType+ "&printInfo=" + printStr;
      var ret=window.showModalDialog(path,printStr,prop);
      return ret;
    }				
			
    function printInfo(printType){
    	
    	var phoneMsg = $("#phoneMsg").val();
			var msgArr = new Array();
			msgArr = phoneMsg.split("|");
			//�ֻ�����|�Ͽͻ�����|�¿ͻ�����|��֤������|�¿ͻ���ַ|24�������Ʊ�ʶ
			var phoneNo = msgArr[0];
			var custNameOld = msgArr[1];
			var custNameNew = msgArr[2];
			var custIdIccId = msgArr[3];
			var addr = msgArr[4];
			var flag24 = msgArr[5];
			
			var flag24Show = "";
			if(flag24 == "N"){
				flag24Show = "���ܹ�����ʵ���Ǽ�(ʱ��Ϊ2050��)";
			}
			else if(flag24 == "Y"){
				flag24Show = "�����ƹ�����ʵ���Ǽ�";
			}
			else if(flag24 == "K"){
				flag24Show = "24���²��ܹ�����ʵ���Ǽ�";
			}
			
			
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
			cust_info += "�ֻ����룺   "+phoneNo+"��"+banliNum+"��|";
			cust_info += "�ͻ�������   "+custNameOld+"|";
      opr_info += "����ҵ��   "+"��λ����ʵ���Ǽ�" +"|";
      opr_info += "������ˮ��   "+$.trim($("input[name='opAccept']").val())+"|";
      opr_info +="����������"+banliNum+"���û����� �� "+custNameOld+" ʵ���Ǽǵ� "+custNameNew+"|";
      opr_info +="�¿ͻ����ϣ�"+" �ͻ����ƣ�"+custNameNew+"  ֤�����룺"+custIdIccId+"|";
      opr_info +="�ͻ���ַ��"+addr+"|";     
      opr_info +="����ʵ���ǼǺ�����ϸ��|";
      var kkk=0;
 			$("#appendBody").find("tr").each(function(){
				var checkOne = $(this).find("td").eq(0).find("input").attr("checked");
				var cgFlag = $(this).find("td").eq(6).html();
				if(cgFlag == "�ɹ�"){
					if(checkOne){
						kkk++;
						var	phoneNo2 = $(this).find("td").eq(1).html();
						if(kkk%4==0 && kkk!=0){
							opr_info +=phoneNo2+"|";
						}else{
							opr_info +=phoneNo2+"  ";
						}
						
						
					}else{
						
					}
					
				}
			});
 			/*���Ҳ��һ������*/
					opr_info += "|";
 			note_info1+="��ע������Ա<%=loginNo%>���û�"+banliNum+"���ֻ��������ʵ���Ǽǣ�������������ҵ��ʵ���ǼǺ��������|";
 			note_info1+=flag24Show+"|";
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    } 
    
    var chkFlag = false;
    function doChkPrint(){
			
			var opAccept = $.trim($("#opAccept").val());
			if(opAccept.length == 0){
				rdShowMessageDialog("�����������ˮ��");
				return false;
			}
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm390/fm390ChkPrint.jsp","���ڻ�����ݣ����Ժ�......");
			
			
			getdataPacket.data.add("iLoginAccept",opAccept);
			
			core.ajax.sendPacket(getdataPacket,doRetRegion2);
			getdataPacket = null;
			
			
		}
		
		function doRetRegion2(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var miguFlag = packet.data.findValueByName("miguFlag");
			if(retCode =="000000"){
				if(miguFlag == "Y"){
					rdShowMessageDialog("����Ѵ�ӡ�����������ظ���ӡ��");
					chkFlag = false;
					return false;
				}else{
					chkFlag = true;
				}
			}else{
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
		<table>
	    <tr>
	  		<td width="20%" class="blue">����ҵ���������</td>
	  		<td width="30%">
	  			<select name="batOpCode">
	  				<option value="m389" selected>��λ����ʵ���Ǽ�</option>
	  			</select>
	  		</td>
	  		<td width="20%" class="blue">������ˮ</td>
	  		<td width="30%">
	  			<input type="text" id="opAccept"  name="opAccept" value="" />
	  		</td>
	    </tr>
	  </table>
	 <div>
	
	 <table>
	   <tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" id="configBtn" name="configBtn"  type="button" value="��ѯ"   onclick="doQry();">&nbsp;&nbsp;
				<input class="b_foot" id="resetBtn" name="resetBtn"  type="button" value="����"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=�ر�>
			</td>
		</tr>
		
		</table>
		
		<!-- ��ѯ����б� -->
		<div id="resultContent" style="display:none">
			<div class="title">
				<div id="title_zi">��Ϣ��ѯ���</div>
			</div>
			<table id="exportExcel" name="exportExcel">
				<tbody id="appendBody">
					
				
				</tbody>
			</table>
			<table>
			   <tr>
					<td align=center colspan="4" id="footer">
						<input class="b_foot" id="configBtn1" name="configBtn1"  type="button" value="��ӡ���"   onclick="doprintM();">&nbsp;&nbsp;
						<input class="b_foot" id="configBtn2" name="configBtn2"  type="button" value="����Excel���"   onclick="printTable();">&nbsp;&nbsp;
					</td>
				</tr>
				
				</table>
		</div>
		
		
	
	</div>
	<input type="hidden" name="iLoginAcceptnew" id="iLoginAcceptnew" />
	<input type="hidden" name="oCustName" id="oCustName" value=""/>
	<input type="hidden" name="oIccidNo" id="oIccidNo" value=""/>
	<input type="hidden" name="oCustId" id="oCustId" value=""/>
	<input type="hidden" name="phoneMsg" id="phoneMsg" value=""/>
	
	 

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
			    for(j=1;j<cells;j++)
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
