<%
  /*
   * ����:
   * �汾: 1.0
   * ����: 
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
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		String newTime=sdf1.format(new Date());
		
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
			var opType = $("input[name='opType'][checked]").val();
			
			var opLogin = $.trim($("input[name='opLogin']").val());
			if(opLogin.length == 0){
				rdShowMessageDialog("������������ţ�",1);
				return false;
			}
			var startTime = $("#startCust").val();
			var endTime = $("#endCust").val();
			
			if(startTime.length ==0 ){
				rdShowMessageDialog("��ѡ��ʼʱ�䣡",1);
				return false;
			}
			if(endTime.length ==0 ){
				rdShowMessageDialog("��ѡ�����ʱ�䣡",1);
				return false;
			}
			
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm110/fm110Qry_1.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = opType;
			var iLoginNo = opLogin;
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo ="";
			var iUserPwd = "";
			var iOpNote = "����Ա["+iLoginNo+"]����"+iOpCode+"����";
			var iBeginTime = startTime;
			var iEndTime = endTime;
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("iOpNote",iOpNote);
			getdataPacket.data.add("iBeginTime",iBeginTime);
			getdataPacket.data.add("iEndTime",iEndTime);
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
		}
		
	function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var retArray = packet.data.findValueByName("retArray");
			if(retCode == "000000"){
				$("#resultContent").show();
				$("#appendBody").empty();
				$("#resultContent2").hide();
				$("#appendBody2").empty();
				$("#excelExp2").attr("disabled","disabled");
				var appendTh = 
					"<tr>"
					+"<th width='8%'>����</th>"
					+"<th width='23%'>��������</th>"
					+"<th width='23%'>����ʱ��</th>"
					+"<th width='23%'>��������</th>"
					+"<th width='23%'>���κ�</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);	
				for(var i=0;i<retArray.length;i++){
					var appendStr = "<tr>";
					appendStr += "<td width='8%'>"+"<input type='radio' name='batNoR' value='' onclick='doBatQry(\""+retArray[i][3]+"\",\""+retArray[i][1]+"\");'/>"+"</td>"
											+"<td width='23%'>"+retArray[i][0]+"</td>"
											+"<td width='23%'>"+retArray[i][1]+"</td>"
											+"<td width='23%'>"+retArray[i][2]+"</td>"
											+"<td width='23%'>"+retArray[i][3]+"</td>"

					appendStr +="</tr>";						
					$("#appendBody").append(appendStr);
				}
				$("#excelExp").attr("disabled","");
				
			}else{
				$("#resultContent").hide();
				$("#appendBody").empty();
				$("#excelExp").attr("disabled","disabled");
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				
			}
		}
		var caozuoLiushui="";
		var biaoTime="";
		function doBatQry(batNo,batTime){
			caozuoLiushui=batNo;
			biaoTime=batTime;
			if(biaoTime!=""){
				biaoTime=biaoTime.substring(0,4)+"/"+biaoTime.substring(4,6)+"/"+biaoTime.substring(6);
				biaoTime=biaoTime.trim();
			}
			else{
				biaoTime="<%=newTime%>";
			}
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm110/fm110Qry_2.jsp","���ڻ�����ݣ����Ժ�......");
			var opType = $("input[name='opType'][checked]").val();
			var iLoginAccept = batNo;
			var iChnSource = "01";
			var iOpCode = opType;
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo ="";
			var iUserPwd = "";
			var iOpNote = "����Ա["+iLoginNo+"]����"+"<%=opCode%>"+"����";
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("iOpNote",iOpNote);
			
			
			core.ajax.sendPacket(getdataPacket,doRetOneRegion);
			getdataPacket = null;
			
		}
		
		function doRetOneRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var retArray = packet.data.findValueByName("retArray");
			
			if(retCode == "000000"){
				$("#resultContent2").show();
				$("#appendBody2").empty();
				var appendTh = 
					"<tr>"
					+"<th width='12%'>��������</th>"
					+"<th width='12%'>�ֻ�����</th>"
					+"<th width='12%'>SIM����</th>"
					+"<th width='12%'>�ͻ�����</th>"
					+"<th width='12%'>����ʱ��</th>"
					+"<th width='12%'>��������</th>"
					+"<th width='12%'>�������</th>"
					+"<th width='16%'>ʧ��ԭ��</th>"
					+"</tr>";
				$("#appendBody2").append(appendTh);	
				var dyPhone="";
				var geshu=0;
				for(var i=0;i<retArray.length;i++){
					var opResult = retArray[i][6] == "000000"?"�ɹ�":"ʧ��";
					var opResMsg = retArray[i][6] == "000000"?"":retArray[i][7];
					if( retArray[i][6] == "000000"){
						dyPhone+=retArray[i][1]+",";
						geshu++;
					}
					
					var appendStr = "<tr>";
					appendStr += "<td width='12%'>"+retArray[i][0]+"</td>"
											+"<td width='12%'>"+retArray[i][1]+"</td>"
											+"<td width='12%'>"+retArray[i][2]+"</td>"
											+"<td width='12%'>"+retArray[i][3]+"</td>"
											+"<td width='12%'>"+retArray[i][4]+"</td>"
											+"<td width='12%'>"+retArray[i][5]+"</td>"
											+"<td width='12%'>"+ opResult +"</td>"
											+"<td width='16%'>"+ opResMsg +"</td>";
					appendStr +="</tr>";
					$("#appendBody2").append(appendStr);
				}
				if(dyPhone!=""){
					dyPhone=dyPhone.substring(0,dyPhone.length-1);
				}
				var appendStr2 = "<tr>";
				appendStr2 += "<td  align=\"center\" colspan=\"8\"><input type='hidden' id='phoneNums' name='phoneNums' value='"+dyPhone+"'><input type='hidden' id='geshu' name='geshu' value='"+geshu+"'><input type=\"button\" class=\"b_foot_long\" value=\"��ӡ���\" onclick=\"daYin()\"/></td>";
				appendStr2 +="</tr>";
				$("#appendBody2").append(appendStr2);
				
				$("#excelExp2").attr("disabled","");
				
			}else{
				$("#resultContent2").hide();
				$("#appendBody2").empty();
				$("#excelExp2").attr("disabled","disabled");
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				
			}
		}
		var dayinFlag="N";
		function go_check110Print(){
			dayinFlag="N";
			var pactket2 = new AJAXPacket("fm110ChkPrint.jsp","���ڽ��е��ӹ���״̬�޸ģ����Ժ�......");
			pactket2.data.add("iLoginAccept",caozuoLiushui);
			core.ajax.sendPacket(pactket2,do_checkPrint);
			pactket2=null;
		}
		function do_checkPrint(packet){
			
			var s_ret_code = packet.data.findValueByName("retCode");
			var s_ret_msg = packet.data.findValueByName("retMsg");
			if(s_ret_code=="000000")
			{
				dayinFlag=packet.data.findValueByName("dayinFlag");
			}
			else{
				rdShowMessageDialog("������룺"+s_ret_code+",������Ϣ��"+s_ret_msg,1);
				return false;
			}
		}
		
		function go_getUserInfo(){
			var getdataPacket = new AJAXPacket("fm110getUserInfo.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = caozuoLiushui;
			var iChnSource = "01";
			var iOpCode = "m349";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo ="";
			var iUserPwd = "";
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			
			core.ajax.sendPacket(getdataPacket,do_getUserInfo);
			getdataPacket = null;
		}
		var printUserName="";
		var printIdCard="";
		var printCardType="";
		var printJbrName="";
		var printJbrIdCard="";
		var printZfName="";
		var printZfNote="";
		function do_getUserInfo(packet){
			var s_ret_code = packet.data.findValueByName("retCode");
			var s_ret_msg = packet.data.findValueByName("retMsg");
			if(s_ret_code=="000000")
			{
				var retArray = packet.data.findValueByName("retArray");
				printUserName=retArray[0][0];
				printIdCard=retArray[0][1];
				printCardType=retArray[0][2];
				printJbrName=retArray[0][3];
				printJbrIdCard=retArray[0][4];
				printZfName=retArray[0][5];
				printZfNote=retArray[0][6];
				
				
			}
		}
		
		function daYin(){
			go_check110Print();
			if("N"==dayinFlag){
				go_getUserInfo();
				if($.trim($("#phoneNums").val())!=""){
					var returnflag=showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
					if(returnflag!=undefined){
						var pactket2 = new AJAXPacket("/npage/sm407/fm407UpDserv.jsp","���ڽ��е��ӹ���״̬�޸ģ����Ժ�......");
						pactket2.data.add("id_no","0");
						pactket2.data.add("paySeq",caozuoLiushui);
						core.ajax.sendPacket(pactket2,doserv);
						pactket2=null;
					}
				}
				else{
					rdShowMessageDialog("��ǰִ�н�����ɴ�ӡ!ֻ��ȫ��ִ����ɲſɴ�ӡ,��ֻ��ӡ�ɹ�����!");
				}
			}
			else{
				rdShowMessageDialog("�������ظ���ӡ���!");
			}
		}	

		function doserv(packet)
		{
			var s_ret_code = packet.data.findValueByName("s_ret_code");
			var s_ret_msg = packet.data.findValueByName("s_ret_msg");
			if(s_ret_code!="000000")
			{
				rdShowMessageDialog("���µ��ӹ���״̬ʧ��!�������:"+s_ret_code+",����ԭ��:"+s_ret_msg);
			}else{
				//location = location;
			}
		}
				  
				  function showPrtDlg(printType,DlgMessage,submitCfm){  //��ʾ��ӡ�Ի��� 
				      var h=180;
				      var w=350;
				      var t=screen.availHeight/2-h/2;
				      var l=screen.availWidth/2-w/2;		   	   
				      var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
				      var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
				      var sysAccept =caozuoLiushui;             	//��ˮ��
				      var printStr = printInfo(printType);
					 	//����printinfo()���صĴ�ӡ����
				      var mode_code=null;           							  //�ʷѴ���
				      var fav_code=null;                				 		//�ط�����
				      var area_code=null;             				 		  //С������
				      var opCode="m110";                   			 	//��������
				      var phoneNo="";                  //�ͻ��绰
				      
				      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
				      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
				      path+="&mode_code="+mode_code+
				      	"&fav_code="+fav_code+"&area_code="+area_code+
				      	"&opCode=m110&sysAccept="+sysAccept+
				      	"&phoneNo="+phoneNo+
				      	"&submitCfm="+submitCfm+"&pType="+
				      	pType+"&billType="+billType+ "&printInfo=" + printStr;
				      var ret=window.showModalDialog(path,printStr,prop);
				      return ret;
				    }				
				    
				    var print_info_arr = new Array();
				    /*
				     ���������
								�ͻ�����
								֤������
								֤������
								����������
								������֤������
								���ʷ�����
								���ʷ�����
				���Ρ��±��0��ʼ
				*/

						//��ӡģ��idΪ��93
				    function printInfo(printType){
				      var cust_info="";
				      var opr_info="";
				      var note_info1="";
				      var note_info2="";
				      var note_info3="";
				      var note_info4="";
				      var retInfo = "";
				      var array = new Array();
				      array["8"]="Ӫҵִ��";
				      array["A"]="��֯��������";
				      array["B"]="��λ����֤��";
				      array["C"]="��λ֤��";
				      
				      cust_info+="�ͻ�������"+printUserName+"|";
				      cust_info+="֤�����룺"+printIdCard+"|";
				      cust_info+="֤�����ͣ�"+printCardType+"|";
				      cust_info+="������������"+printJbrName+"|";
						cust_info+="������֤�����룺"+printJbrIdCard+"|";
				      
						opr_info+="����ҵ��������ͨ����      ";
						opr_info+="���������"+$("#geshu").val()+"      ";
						opr_info+="������ˮ��"+caozuoLiushui+"|";
						opr_info+="ҵ������ʱ�䣺"+biaoTime+"|";
						opr_info+="���ʷѣ�"+printZfName+"|";
						opr_info+="���ʷ�������"+printZfNote+"|";
						var phoneNums=$("#phoneNums").val().split(",");
						var showPhones="";
						for(var i=0;i<phoneNums.length;i++){
							showPhones+=phoneNums[i]+",";
							if((i+1)%5==0){
								showPhones+="|";
							}
						}
						
						opr_info+=showPhones.substring(0,showPhones.lastIndexOf(","))+"|";
				      
				      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
				      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
				      return retInfo;
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
	  		<td width=16% class="blue">��������</td>
	  		<td width=84% colspan="3">
	  			<input type="radio" name="opType"	value="m108" checked/>m108-����У԰Ԥ���� &nbsp;&nbsp;
	  			<input type="radio" name="opType"	value="m109" />m109-��������Ԥ���� &nbsp;&nbsp;
	  			<input type="radio" name="opType"	value="m349" />m349-������ͨ���� &nbsp;&nbsp;
	  		</td>
	    </tr>
	    <tr>
	  		<td width=16% class="blue">��������</td>
	  		<td width=84% colspan="3">
	  			<input type="text" name="opLogin" value=""/>&nbsp;<font color="red">*</font>
	  		</td>
	    </tr>
	    <tr>
	  		<td width="20%" class="blue">��ʼʱ��</td>
					<td width="30%">
							<input type="text"  id="startCust"  name="startCust" readOnly onclick="WdatePicker({el:'startCust',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd 00:00:00',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y-%M-%d\'}',minDate:'%y-#{%M-1}-d%'})" value=""/>
								<img id = "imgCustStart" 
									onclick="WdatePicker({el:'startCust',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd 00:00:00',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y-%M-%d\'}',minDate:'%y-#{%M-1}-d%'})" 
				 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">&nbsp;<font color="red">*</font>
					</td>
				<td width="20%" class="blue">����ʱ��</td>
				<td width="30%">
					<input type="text"  id="endCust"  name="endCust" readOnly onclick="WdatePicker({el:'endCust',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd 23:59:59',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}',maxDate:'%y-%M-%d'})" value=""/>
								<img id = "imgCustEnd" 
									onclick="WdatePicker({el:'endCust',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd 23:59:59',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}',maxDate:'%y-%M-%d'})" 
				 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">&nbsp;<font color="red">*</font>
				</td>
	
	    </tr>
	    <tr> 
			<td align=center colspan="4" id="footer">
				<input class="b_foot" name="sure"  type="button" value="��ѯ"  onclick="doQry();">
				<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=�ر�>
				<input  name="back1"  class="b_foot" type="button" value="����excel" id="excelExp" onclick="printTable(exportExcel)" disabled="disabled">
			</td>
		</tr>
		</table>
	</div>
	<!-- ��ѯ����б� -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">��ѯ����б�</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<tbody id="appendBody">
				
			
			</tbody>
		</table>
	</div>
	
	<!-- ��ѯ����б� -->
	<div id="resultContent2" style="display:none">
		<div class="title">
			<div id="title_zi">��ϸ��Ϣ</div>
		</div>
		<table id="exportExcel2" name="exportExcel2">
			<tbody id="appendBody2">
				
			
			</tbody>
		</table>
	</div>
	
	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel2;
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
