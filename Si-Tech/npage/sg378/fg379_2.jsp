<%
/*************************************
* ��  ��: g378������V���û����� 
* ��  ��: version v1.0
* ������: si-tech
* ������: liujian @ 2012-12-31 13:52:45
**************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	
	String opCode     =  request.getParameter("opCode");
    String opName     =  request.getParameter("opName");
    String workNo     = (String)session.getAttribute("workNo");
     String workName     = (String)session.getAttribute("workName");
    String password = (String) session.getAttribute("password");
    String regionCode = (String)session.getAttribute("regCode");
    String phoneNo = request.getParameter("phoneNo");
    String powerRight = WtcUtil.repNull((String)session.getAttribute("powerRight"));
	boolean qryFlag = false;
	StringBuffer offerSb = new StringBuffer("");
	String sql_select1 = "select trim(a.offer_id),trim(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region d,DBCUSTADM.sregioncode e where a.offer_attr_type='VpG0' and a.offer_id=d.offer_id and d.group_id=e.group_id and e.region_code=:region_code and a.exp_date>=sysdate and a.eff_date<=sysdate and d.right_limit <= :right_limit order by a.offer_id";
	String srv_params1 = "region_code=" + regionCode + ",right_limit=" + powerRight ;
	String userPhoneNo = "", groupNo = "", groupName = "", userName = "", currOffer = "",nextOffer = "";

%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
	<wtc:service name="sg381Qry"  routerKey="regioncode" 
			routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>	
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="qryArr"  scope="end"/>
<%
	if(retCode.equals("000000") && qryArr.length > 0) {
		qryFlag = true;
		groupNo = qryArr[0][0]; 
		groupName = qryArr[0][1];
		userPhoneNo = qryArr[0][2];
		userName = qryArr[0][3]; 
		currOffer = qryArr[0][4];
		nextOffer = qryArr[0][5];
		if(opCode.equals("g379")) {
%>
			<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
				routerValue="<%=regionCode%>"  id="loginAccept" />
			<wtc:service name="sPkgCodeQry" routerKey="region" routerValue="<%=regionCode%>" retcode="rstCode2" retmsg="rstMsg2" outnum="3">
				<wtc:param value="<%=loginAccept%>"/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>	
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=regionCode%>"/>
				<wtc:param value="<%=powerRight%>"/>
			</wtc:service>
			<wtc:array id="result_offer" scope="end"/>
	<%
			if(rstCode2.equals("000000") && result_offer.length > 0) {
				for(int i=0; i<result_offer.length; i++) {
					  offerSb.append("<option value ='").append(result_offer[i][0]).append("'>")
							 .append(result_offer[i][1])
							 .append("</option>");
				}
			}
		}
	}
%>		        	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>

<script type=text/javascript>
  $(function() {
  		$(window.parent.document).find("iframe[@id='groupIframe']").css('height','0px');
	
  		$('#offerSelect').css('width','300px');
  		if(<%=qryFlag%>) {
  			$('#currOffer').css('width','300px');
  			if('<%=opCode%>' == 'g379') {
  				$('#offerSelect').css('display','block');
  				$('#offerSelect').append("<%=offerSb.toString()%>");
  				var nextOffer = '<%=nextOffer%>';
  				$("#offerSelect option[value='" + nextOffer.substring(0,nextOffer.indexOf('-')) + "']").attr("disabled", true);
  				$("#offerSelect").val(nextOffer.substring(0,nextOffer.indexOf('-')));
  			}else if('<%=opCode%>' == 'g380') {
  				$('#nextOfferTd').append('<input type="text" name="currOffer" id="nextOffer" value="<%=nextOffer%>" class="InputGrey" readonly style="width:40%"/>');
  			}
			showTable();
		}else {
			clearTable();
			rdShowMessageDialog("������룺<%=retCode%>��������Ϣ��<%=retMsg%>",0);
		}
		
		$('#submitBtn').click(function() {
			
			//window.parent.showBox();
			if('<%=opCode%>' == 'g379') {
				
				 var  ret = showPrtDlg379("Detail","ȷʵҪ���е��������ӡ��","Yes");
		    
		     if(typeof(ret)!="undefined"){
		        if((ret=="confirm")){
		          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
		            		nextStepCfmG379();
		          }
		        }
		        if(ret=="continueSub"){
		          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
										nextStepCfmG379();
		          }
		        }
		      }else{
		        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
										nextStepCfmG379();
		        }
		      }
			}else if('<%=opCode%>' == 'g380') {
				
				var  ret = showPrtDlg380("Detail","ȷʵҪ���е��������ӡ��","Yes");
		    
		     if(typeof(ret)!="undefined"){
		        if((ret=="confirm")){
		          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
		            		nextStepCfmG380();
		          }
		        }
		        if(ret=="continueSub"){
		          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
										nextStepCfmG380();
		          }
		        }
		      }else{
		        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
										nextStepCfmG380();
		        }
		      }
			}	
		});
		//���ظ�ҳ�������
		window.parent.hideBox();
  });
  
  function nextStepCfmG380(){
  	var packet = new AJAXPacket("fg378_3.jsp","���ڻ�������Ϣ�����Ժ�......");
		var _data = packet.data;
		_data.add("loginAccept","<%=loginAccept%>");
		_data.add("opCode","<%=opCode%>");
		_data.add("userPhoneNo","<%=userPhoneNo%>");
		_data.add("groupNo",'<%=groupNo%>');
		_data.add("method","g380cfm");
		core.ajax.sendPacket(packet,g380cfmProcess);
		packet = null;
  }
  
  function nextStepCfmG379(){
  	var nextOffer = '<%=nextOffer%>';
  				nextOffer = nextOffer.substring(0,nextOffer.indexOf('-'));
  				
  				if($('#offerSelect').val() == nextOffer) {
  					window.parent.hideBox();
  					rdShowMessageDialog("��ѡ�������ʷѣ�");
  					return false;
  				}
  					
				var packet = new AJAXPacket("fg378_3.jsp","���ڻ�������Ϣ�����Ժ�......");
				var _data = packet.data;
				
				_data.add("loginAccept","<%=loginAccept%>");
				_data.add("opCode","<%=opCode%>");
				_data.add("userPhoneNo","<%=userPhoneNo%>");
				_data.add("groupNo",'<%=groupNo%>');
				_data.add("offerId",$('#offerSelect').val());
				_data.add("method","g379cfm");
				core.ajax.sendPacket(packet,g379cfmProcess);
				packet = null;	
  	
  }
  
  function showTable() {
  	$('#userTable').css('display','block');
  	$(window.parent.document).find("iframe[@id='groupIframe']").css('height',$("body").height()+20 + 'px');		
  }
  function clearTable() {
  		$('#tabList2').empty();
  		$('#userTable').css('display','none');
  }
  
	function g380cfmProcess(package) {
		var g380cfmCode = package.data.findValueByName("g380cfmCode");
		var g380cfmMsg = package.data.findValueByName("g380cfmMsg");	
		var loginAccept = package.data.findValueByName("loginAccept");	
		$('#loginAccept').val(loginAccept);
  
		if(g380cfmCode == '000000' || g380cfmCode == '0') {
			rdShowMessageDialog("����V���û��ʷ��˳��ɹ���");
			clearTable();
			$(window.parent.document).find("input[@id='phoneNo']").val('');
			$(window.parent.document).find("iframe[@id='groupIframe']").css('height','0px');
		}else {
			rdShowMessageDialog("������룺" + g380cfmCode +  "��������Ϣ��" + g380cfmMsg,0);	
		}
		window.parent.hideBox();
	}
	
	function g379cfmProcess(package) {
		var g379cfmCode = package.data.findValueByName("g379cfmCode");
		var g379cfmMsg = package.data.findValueByName("g379cfmMsg");	
		var loginAccept = package.data.findValueByName("loginAccept");	
		$('#loginAccept').val(loginAccept);
		
		if(g379cfmCode == '000000' || g379cfmCode == '0') {
			rdShowMessageDialog("����V���û��ʷѱ���ɹ���");
			clearTable();
			$(window.parent.document).find("input[@id='phoneNo']").val('');
			$(window.parent.document).find("iframe[@id='groupIframe']").css('height','0px');
			
		}else {
			rdShowMessageDialog("������룺" + g379cfmCode +  "��������Ϣ��" + g379cfmMsg,0);	
		}
		window.parent.hideBox();
	}
	
	 function showPrtDlg379(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

  var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept ="<%=loginAccept%>";             	//��ˮ��
	var printStr = printInfo379(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							  //�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		  //С������
	var opCode="g379" ;                   			 	//��������
	var phoneNo=document.all.userPhoneNo.value;                  //�ͻ��绰

    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_dz.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
    path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+phoneNo+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
}

function printInfo379(printType)
{

	var cust_info="";  				//�ͻ���Ϣ
	var opr_info="";   				//������Ϣ
	var note_info1=""; 				//��ע1
	var note_info2=""; 				//��ע2
	var note_info3=""; 				//��ע3
	var note_info4=""; 				//��ע4
	var retInfo = "";  				//��ӡ����
	//var _consumeTerm = parseInt(document.getElementById("Consume_Term").value,10);/* diling add �������ޱ����������� 2011/8/30 11:17:17 */

	opr_info+='<%=workNo%>'+' '+'<%=workName%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="�ֻ����룺"+document.all.userPhoneNo.value+"|";
	cust_info+="�ͻ�������"+document.all.userName.value+"|";	
	cust_info+="�ͻ���ַ��"+"|";
	cust_info+="���ű�ţ�<%=groupNo%>"+"|";
	cust_info+="�������ƣ�<%=groupName%>"+"|";



	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	opr_info+="ҵ����ˮ��"+document.all.loginAccept.value+"|";
	opr_info+="ҵ�����ͣ����ų�Ա�ʷѱ��"+"|";
  opr_info+="���Ų�Ʒ���ƣ�BOSS������V��"+"|";
  opr_info+="����BOSS������V���ʷ��ײ����ƣ�<%=currOffer%>"+"|";
   opr_info+="����BOSS������V���ʷ��ײ����ƣ�"+$("#offerSelect").find("option:selected").text()+"|";
 // opr_info+="BOSS������V���ʷ��ײ�������"+offersid+"--"+offerscoments+"|";
	opr_info+="���ų�Ա�ʷѱ������Чʱ��Ϊ���¡�"+"|"; /*diling add  ����ҵ����Ч�� 2011/8/30 11:17:17 */

	note_info1+="��ע��"+"|";


	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

 function showPrtDlg380(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

  var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept ="<%=loginAccept%>";             	//��ˮ��
	var printStr = printInfo380(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							  //�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		  //С������
	var opCode="g380" ;                   			 	//��������
	var phoneNo=document.all.userPhoneNo.value;                  //�ͻ��绰

    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_dz.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
    path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+phoneNo+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
}

function printInfo380(printType)
{

	var cust_info="";  				//�ͻ���Ϣ
	var opr_info="";   				//������Ϣ
	var note_info1=""; 				//��ע1
	var note_info2=""; 				//��ע2
	var note_info3=""; 				//��ע3
	var note_info4=""; 				//��ע4
	var retInfo = "";  				//��ӡ����
	//var _consumeTerm = parseInt(document.getElementById("Consume_Term").value,10);/* diling add �������ޱ����������� 2011/8/30 11:17:17 */

	opr_info+='<%=workNo%>'+' '+'<%=workName%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="�ֻ����룺"+document.all.userPhoneNo.value+"|";
	cust_info+="�ͻ�������"+document.all.userName.value+"|";	
	cust_info+="�ͻ���ַ��"+"|";
	cust_info+="���ű�ţ�<%=groupNo%>"+"|";
	cust_info+="�������ƣ�<%=groupName%>"+"|";



	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	opr_info+="ҵ����ˮ��"+document.all.loginAccept.value+"|";
	opr_info+="ҵ�����ͣ����ų�Աɾ��"+"|";
  opr_info+="���Ų�Ʒ���ƣ�BOSS������V��"+"|";
  opr_info+="����BOSS������V���ʷ��ײ����ƣ�<%=currOffer%>"+"|";
   opr_info+="����BOSS������V���ʷ��ײ����ƣ�<%=nextOffer%>"+"|";
 // opr_info+="BOSS������V���ʷ��ײ�������"+offersid+"--"+offerscoments+"|";
	opr_info+="���ų�Աɾ������Чʱ��Ϊ24Сʱ��"+"|"; 

	note_info1+="��ע��"+"|";


	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
</script>

<body>
<form name="frm2" action="" method="post" >
		<div id="userTable">
			<div class="title">
				<div id="title_zi">�û���Ϣ</div>
			</div>
			
			<div id="Operation_Table" style="padding:0px">
				<table cellspacing=0 >
					<tr>
						<td class='blue'>���ź�</td>
						<td>
							<input type="text" name="groupNo" id="groupNo" value="<%=groupNo%>" class="InputGrey" readonly />
						</td>
						<td class='blue'>��������</td>
						<td>
							<input type="text" name="groupName" id="groupName" value="<%=groupName%>" class="InputGrey" style="width:50%" readonly />
						</td>
				    </tr>
				    <tr>
						<td class='blue'>�û��ֻ�����</td>
						<td>
							<input type="text" name="userPhoneNo" id="userPhoneNo" value="<%=userPhoneNo%>" class="InputGrey" readonly />
						</td>
						<td class='blue'>�û�����</td>
						<td>
							<input type="text" name="userName" id="userName" value="<%=userName%>" class="InputGrey" readonly />
						</td>
				    </tr>
				    <tr>
						<td class='blue'>�����ʷ�</td>
						<td colspan="3">
							<input type="text" name="currOffer" id="currOffer" value="<%=currOffer%>" class="InputGrey" readonly />
						</td>
						
				    </tr>
				    <tr>
				    	<td class='blue'>�����ʷ�</td>
						<td id="nextOfferTd" colspan="3"><select id="offerSelect" style="display:none"></select></td>	
				    </tr>
				    <tr id='footer'>
				        <td colspan='4'>
				            <input type="button"  id="submitBtn" class='b_foot' value="ȷ��" name="submitBtn" />
				        </td>
				    </tr>
				</table>
			</div>
		</div>
		<input type="hidden" name="loginAccept" id="loginAccept" value="" />
</form>
</body>
</html>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    