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
		String gCustId = "";
		String custSql = "";
		String  inParamsMail [] = new String[2];
    inParamsMail[0] = "select trim(t.cust_id) from dcustmsg t where phone_no =:phoneNo";
    inParamsMail[1] = "phoneNo="+phoneNo;
		
%>
 <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_mail" retmsg="retMessage_mail" outnum="1"> 
    <wtc:param value="<%=inParamsMail[0]%>"/>
    <wtc:param value="<%=inParamsMail[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_mail"  scope="end"/>
<%
	if("000000".equals(retCode_mail) && result_mail.length > 0){
		gCustId = result_mail[0][0];
	}else{
		%>
		<script language="javascript">
			rdShowMessageDialog("��ȡ�ͻ���Ϣʧ�ܣ�");
			removeCurrentTab();
		</script>
		<%
	}

String beizhussdese1="����custid=["+gCustId+"]���в�ѯ";
%>  	
	 	
	<wtc:service name="sUserCustInfo" outnum="100" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="<%=opCode%>" />	
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=noPass%>" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrM%>" />
			<wtc:param value="<%=beizhussdese1%>" />
			<wtc:param value="<%=gCustId%>" />
</wtc:service>
<wtc:array id="result_custInfo" scope="end"/>	
	 	
	 	
<%	 	

String custIccid = "";
String custAddr = "";
if(result_custInfo.length>0){
if(result_custInfo[0][0].equals("01")) {
	custAddr = result_custInfo[0][11];
	custIccid = result_custInfo[0][13];
	}
}
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
 	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
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
			getdataPacket.data.add("opCode","<%=opCode%>");
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
					rdShowMessageDialog("û�пɷ�������!",1);
					return false;
				}	
				/*��ֵ���û���*/
				$("#canUseJf").val(canUseJf);
				var optionStr = "<option value='' selected>--��ѡ��--</option>";
				for(var i=0;i<infoArray.length;i++){
					var giftNo = infoArray[i][1];
					var giftName = infoArray[i][2];
					var giftContent = infoArray[i][3];
					var giftJf = infoArray[i][6];
					var kcNum = infoArray[i][7];
					optionStr += "<option value='"+giftNo+"|"+giftName+"|"+giftContent+"|"+giftJf+"|"+kcNum+"'>"+giftNo+"-"+giftName+"-->"+giftJf+"</option>"

				}
				$("select[name='giftSel']").empty();
				$("select[name='giftSel']").append(optionStr);
				$("#qryContent").find("tr").each(function(){
					$(this).show();
				});
				
			}else{
			
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				
			}
		}
		
		function frmCfm(){
			var getdataPacket = new AJAXPacket("/npage/sm286/fm286Cfm.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iOpCode = "<%=opCode%>";
			var iPhoneNo = "<%=phoneNo%>";
			
			getdataPacket.data.add("opCode",iOpCode);
			getdataPacket.data.add("phoneNo",iPhoneNo);
			getdataPacket.data.add("printAccepts","<%=printAccept%>");
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
    }
    
	
		function doCfm(){
		
		
		  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
      if(typeof(ret)!="undefined"){
        if((ret=="confirm")){
          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
            frmCfm();
          }
        }
        if(ret=="continueSub"){
          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
            frmCfm();
          }
        }
      }else{
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
          frmCfm();
        }
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
				return false;
			}
			var giftArray = new Array();
			giftArray = giftSel.split("|");
			var giftNo = giftArray[0];
			var giftName = giftArray[1];
			var giftContent = giftArray[2];
			var giftJf = giftArray[3];
			var kcNum = giftArray[4];
			$("#kcNum").val(kcNum);
			$("#giftContent").text(giftContent);
			$("#giftJf").val(giftJf);
			
			
		}
		
	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div id="Operation_table">
    <div class="title">
		<div id="title_zi">�ͻ���Ϣ</div>
	</div>


	<div id="custInfo">
	<%@ include file="/npage/common/qcommon/bd_0002.jsp" %>
	</div>
	<div>
		<table>
	  	<tr>
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="sure"  type="button" value="ȷ��"  onclick="doCfm();">&nbsp;&nbsp;
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
					<input class="b_foot" name="sure"  type="button" value="ȷ��"  onclick="doCfm();">&nbsp;&nbsp;
					<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=�ر�>
				</td>
			</tr>
		</table>
	</div>
	<input type="hidden" id="printAccepts" name="printAccepts" value="<%=printAccept%>"/>
	
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

   function showPrtDlg(printType,DlgMessage,submitCfm){  //��ʾ��ӡ�Ի��� 
      var h=180;
      var w=350;
      var t=screen.availHeight/2-h/2;
      var l=screen.availWidth/2-w/2;		   	   
      var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
      var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
      var sysAccept =<%=printAccept%>;   
      var printStr = printInfo(printType);
      var mode_code=null;           							  //�ʷѴ���
      var fav_code=null;                				 		//�ط�����
      var area_code=null;             				 		  //С������
      var opCode="<%=opCode%>" ;                   			 	//��������
      var phoneNo="<%=phoneNo%>";                  //�ͻ��绰
      
      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
      path+="&mode_code="+mode_code+
      	"&fav_code="+fav_code+"&area_code="+area_code+
      	"&opCode=<%=opCode%>&sysAccept="+sysAccept+
      	"&phoneNo="+phoneNo+
      	"&submitCfm="+submitCfm+"&pType="+
      	pType+"&billType="+billType+ "&printInfo=" + printStr;
      var ret=window.showModalDialog(path,printStr,prop);
      return ret;
    }
    			
		function printInfo(printType){
    	
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺"+"<%=phoneNo%>"+"|";
      cust_info+="�ͻ�������"+document.all.custNameforsQ046.value.trim()+"|";
      cust_info+="֤�����룺"+"<%=custIccid%>"+"|";
      cust_info+="�ͻ���ַ��"+"<%=custAddr%>"+"|";
      
      opr_info+="����ҵ��<%=opName%>"+"  "+"������ˮ��<%=printAccept%>|";
              
      note_info1+="��ע��"+"|";
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }	
    
</script>
</body>


</html>
