<%
  /*
   * ����: ��վ����
   * �汾: 2.0
   * ����: 2010/11/25
   * ����: weigp
   * ��Ȩ: si-tech
   * update:
   */
%>
            
<%
  //begin huangrong update ��ȡ���� 2011-8-10 
	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String occupId = request.getParameter("occupId"); //ԤռID
  //end huangrong update ��ȡ���� 2011-8-10     
	String loginNo     	= (String)session.getAttribute("workNo");	//��������
	String loginPwd    	= (String)session.getAttribute("password"); //�������� 
	String groupId		= (String)session.getAttribute("groupId");	//���Ź���
	String iOrgCode		= (String)session.getAttribute("orgCode");	
	String regionCode 	= iOrgCode.substring(0,2);
 	String schnType		= "01";//�������� 	 ��������01-BOSS,02-����Ӫҵ�� 
 	String phoneType	= "1";//��ѯҵ������    0-ԤԼѡ��,   	1-���Ͽ���
 	String sIn_PhoneNo	= request.getParameter("phoneNo"); //��ѯ�ֻ����� huangrong update 	֮ǰֱ�Ӵ�"" 2011-8-18 
 	String sIn_PhonePwd = ""; //�û�����Ĭ�ϴ�  ""
 	String sIn_IdIccId	= request.getParameter("idCardNo"); //�û����֤��	huangrong update 	֮ǰֱ�Ӵ�"" 2011-8-18 
 	String loginAccept  = "0";
 	String paramValue_zhaz="N";
 	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
 	
%>              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
 
<HTML><HEAD><TITLE><%=opName%></TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
		<wtc:service name="sb893Qry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="32">
			<wtc:param value="<%=loginAccept%>" />
			<wtc:param value="<%=schnType%>" />
			<wtc:param value="<%=opCode%>" />
			<wtc:param value="<%=loginNo%>" />			
			<wtc:param value="<%=loginPwd%>" />
			<wtc:param value="<%=sIn_PhoneNo%>" />
			<wtc:param value="<%=sIn_PhonePwd%>" />
			<wtc:param value="<%=groupId%>" />
			<wtc:param value="<%=phoneType%>" />
			<wtc:param value="<%=sIn_IdIccId%>" />				
			<wtc:param value="<%=occupId%>" />					
		</wtc:service>
		<wtc:array id="result1" scope="end" />

<%
		
		if(errCode.equals("0")||errCode.equals("000000")){
			System.out.println("���÷���sb893Qry in fb893_login.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
			System.out.println((String)Encrypt.encrypt("123321"));
			if(result1.length <= 0){
%>
			<script language="JavaScript">
				rdShowMessageDialog("����վ������Ϣ��");
				history.go(-1);
			</script>
<%				
			}
		}else{
			System.out.println("���÷�����÷���sb893Qry in fb893_login.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
		<script language="JavaScript">
			rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
			history.go(-1);			
		</script>
<%
		}
%>


	<script type="text/javascript">
		$(document).ready(function(){
			<%
				for(int i=0;i<result1.length;i++){
			%>
					//Ԥռ
					$("#preparedDo<%=i%>").bind("click",function(){
						var packet = new AJAXPacket("preparedDo.jsp","���ڽ���Ԥռ�������Ե�......");
						packet.data.add("phoneNo",$("#phoneNo<%=i%>").val());
						packet.data.add("phoneStatus",$("#phoneStatus<%=i%>").val());
						core.ajax.sendPacket(packet,function(packet){
							var retCode = packet.data.findValueByName("retCode");
							var retMsg = packet.data.findValueByName("retMsg");
							if(retCode == "000000"){
								rdShowMessageDialog("Ԥռ�ɹ���",2);
								//location.reload();
								$("#custOpenBtn<%=i%>").removeAttr("disabled");
								$("#preparedDo<%=i%>").attr("disabled",true);
							}else{
								rdShowMessageDialog("Ԥռʧ�ܣ�",0);
							}
						});
						
					});
					/* liujian ���ڵ�����������ѡ�Ź����Ż�����ĺ� 2012-4-26 10:21:07 begin*/
					
					
					/*�ͻ�����*/
					$("#custOpenBtn<%=i%>").bind("click",function(){
							var name=$("#contactPerson<%=i%>").val();
							var addr=$("#contactAddr<%=i%>").val();
							var phone=$("#contactPhone<%=i%>").val();
							var idAddrss=$("#idAddr<%=i%>").val();
							
							var custName = $("#custName<%=i%>").val();
							var custIdType = $("#custIdType<%=i%>").val();
							var idIccid = $("#idIccid<%=i%>").val();
							var custValiDate = $("#custValiDate<%=i%>").val();
							var custId = $("#custId<%=i%>").val();
							var kaihuphoneno=$("#phoneNo<%=i%>").val().trim();
							
						 	var path="<%=request.getContextPath()%>/npage/sb893/fb893_editCustMsg.jsp?opCode=<%=opCode%>&opName=<%=opName%>&kaihuphoneno="+codeChg(kaihuphoneno)+"&name=" + codeChg(name) + "&addr=" + codeChg(addr) + "&phone=" + codeChg(phone) + "&idAddrss=" + codeChg(idAddrss)+"&statusCode=<%=i%>&custName="+codeChg(custName)+"&custIdType="+codeChg(custIdType)+"&idIccid="+codeChg(idIccid)+"&custValiDate="+codeChg(custValiDate)+"&custId="+codeChg(custId);
						 	/*var path="<%=request.getContextPath()%>/npage/sb893/fb893_editCustMsg.jsp?opCode=<%=opCode%>&opName=<%=opName%>&name=" + name + "&addr=" + addr + "&phone=" + phone + "&statusCode=<%=i%>";*/
							window.open(path,"newwindow","height=450, width=830,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
					});
					/* liujian ���ڵ�����������ѡ�Ź����Ż�����ĺ� 2012-4-26 10:21:07 end*/
					
					/*��ͨ�������servBusiId��������ʶ*/
					$("#ordinaryOpenBtn<%=i%>").bind("click",function(){
						var packet = new AJAXPacket("../portal/shoppingCar/getServBusId.jsp","���Ժ�...");
						packet.data.add("offer_id" ,$("#offerId<%=i%>").val());
						core.ajax.sendPacket(packet,function(packet){
							var servBusId =packet.data.findValueByName("backArrMsg");
							var retMsg=retMsg =packet.data.findValueByName("retMsg");
							if(servBusId==null || servBusId==""){
									backArrMsg="";
								}
							$("#servBusId<%=i%>").val(servBusId);	
						});
						/*alert("custId="+$("#custId<%=i%>").val()+",offerId="+$("#offerId<%=i%>").val()+",servBusId="+$("#servBusId<%=i%>").val());*/
						var sData = "";//��ù��ﳵƴװ����
						var sDataPacket = new AJAXPacket("ajaxGetData.jsp","���Ժ�...");
						sDataPacket.data.add("offerId",$("#offerId<%=i%>").val());
						sDataPacket.data.add("servBusId",$("#servBusId<%=i%>").val());
						core.ajax.sendPacket(sDataPacket,function(packet){
							sData = packet.data.findValueByName("sData");	
						});
						//alert(sData);
						var custOrderId = "";
						var custOrderNo = "";
						//��ÿͻ������ż��ͻ�����Id
						var custOrderPacket = new AJAXPacket("../portal/shoppingCar/sCustOrderC.jsp");
						custOrderPacket.data.add("sData", sData);
				        custOrderPacket.data.add("optorMsg"," , , , , , , , ");
				        custOrderPacket.data.add("custId",$("#custId<%=i%>").val());
				        custOrderPacket.data.add("prtFlagValue", "Y");//Y�ϲ���ӡ
				        core.ajax.sendPacket(custOrderPacket, function(packet){
				        	var retCode = packet.data.findValueByName("retCode");
    						var retMsg = packet.data.findValueByName("retMsg");
    						custOrderId = packet.data.findValueByName("custOrderId");
        					custOrderNo = packet.data.findValueByName("custOrderNo");
				        });
				        //alert(custOrderId+"====="+custOrderNo);
				        var mainPlanPacket = new AJAXPacket("/npage/portal/shoppingCar/sShowMainPlan.jsp");
						mainPlanPacket.data.add("custOrderId" ,custOrderId);
						mainPlanPacket.data.add("custOrderNo" ,custOrderNo);
						mainPlanPacket.data.add("prtFlag" ,"Y");
						core.ajax.sendPacket(mainPlanPacket, function(packet){
							var retCode = packet.data.findValueByName("retCode"); 
						  	var retMsg = packet.data.findValueByName("retMsg"); 
						  	if(retCode=="0"){
							  	var sData = packet.data.findValueByName("sData"); 
							  	parent.parent.$("#carNavigate").html(sData);
							  	var custOrderId = packet.data.findValueByName("custOrderId"); 
							  	var custOrderNo = packet.data.findValueByName("custOrderNo"); 
							  	var orderArrayId = packet.data.findValueByName("orderArrayId"); 
							  	var servOrderId = packet.data.findValueByName("servOrderId"); 
							  	var status = packet.data.findValueByName("status"); 
							  	var funciton_code = packet.data.findValueByName("funciton_code"); 
							  	var funciton_name = packet.data.findValueByName("funciton_name"); 
							  	var pageUrl = packet.data.findValueByName("pageUrl"); 
							  	var offerSrvId = packet.data.findValueByName("offerSrvId"); 
							  	var num = packet.data.findValueByName("num"); 
							  	var offerId = packet.data.findValueByName("offerId"); 
							  	var offerName = packet.data.findValueByName("offerName"); 
							  	var phoneNo = packet.data.findValueByName("phoneNo"); 
							  	//alert("import_phoneNo=========="+phoneNo);
							  	var sitechPhoneNo = packet.data.findValueByName("sitechPhoneNo"); 
							  	var prtFlag = packet.data.findValueByName("prtFlag"); 
							  	var servBusiId = packet.data.findValueByName("servBusiId"); 
							  	var validVal = packet.data.findValueByName("validVal"); 
							  	var openWay = packet.data.findValueByName("openWay"); 
							  	var closeId=orderArrayId+servOrderId;
							  	if("<%=paramValue_zhaz%>" == "Y"){
								  	parent.parent.checkHasBill(funciton_code);
								  	if(parent.parent.hasBill == "N"){
									   		rdShowMessageDialog("������δ��������,���ܽ���ҵ�����!",0);
									   		//parent.parent.addTab(true,"r615","ӪҵԱ����ͳ�Ʊ���","../rpt_new/f1615.jsp");
									   		return false;
									   }
									   if(parent.parent.todayHasBill == "Y"){
									   		rdShowMessageDialog("�������Ѿ��������,���ܽ���ҵ�����!",0);
									   		return false;
									   }
							  	}
							  	if(closeId=="")
							  	{
							  		closeId= funciton_code;
							  	}
							  	//pageUrlд��Ϊ��վ�����ĵ�¼ҳ
							  	var path=   "sb893/basicOpenLogin.jsp?gCustId="+$("#custId<%=i%>").val()
							  							+"&opCode="+funciton_code
							  						  	+"&opName="+funciton_name
							  							+"&offerSrvId="+offerSrvId
							  							+"&num="+num
							  							+"&offerId="+offerId
							  							+"&offerName="+offerName
							  							+"&phoneNo="+phoneNo
							  							+"&sitechPhoneNo="+sitechPhoneNo
							  							+"&orderArrayId="+orderArrayId
							  							+"&custOrderId="+custOrderId
							  							+"&custOrderNo="+custOrderNo
							  							+"&servOrderId="+servOrderId
							  							+"&closeId="+funciton_code
							  							+"&servBusiId="+servBusiId
							  							+"&prtFlag="+prtFlag
							  							+"&work_flow_no="
							  							+"&transJf="
							  							+"&transXyd="
							  							+"&level4100="
							  							+"&custPwd="+$("#custPwd<%=i%>").val()
							  							+"&occupId="+$("#occupId<%=i%>").val()
							  							+"&areaCode="+$("#areaCode<%=i%>").val()
							  							+"&prePay_Fee="+$("#prePay_Fee<%=i%>").val()
							  							+"&simPay_fee="+$("#simPay_fee<%=i%>").val()
							  							+"&phone_no="+$("#phoneNo<%=i%>").val()
							  							/*gaopeng 2014/05/06 10:09:45 ������ʡ������ѡ�š��͡�18Ԫ�׿�ʡ�ڰ桱����SIM������ѡ���ܵ����� ����ͨ�����������  sim������ ����У�� sim����������չʾ */				
							  							+"&outSimName="+$("#outSimName<%=i%>").val()
							  							+"&outSimType="+$("#outSimType<%=i%>").val()
							  							+"&idIccid="+$("#idIccid<%=i%>").val()
							  							+"&ipt_PhoneID="+$("#ipt_PhoneID<%=i%>").val();
										  /*
											  alert(path);
											  alert($("#outSimType<%=i%>").val());
											  alert($("#outSimName<%=i%>").val());
										  */
										  parent.L(1,funciton_code,funciton_name,path,validVal);
										  parent.removeTab('b893');	//��ͨ�����ɹ���ˢ�´�ҳ��
						  	}else{
						  		rdShowMessageDialog("��������ʧ��!");
						  	}	
						});
					});
			<%
				}
			%>
		});	
		
		function timeout(statusCode) {
				setTimeout("changeCustMsg(" +statusCode+ ")",500);
		}
		function changeCustMsg(statusCode){
						var packet = new AJAXPacket("custOpenCfm.jsp","���ڽ��пͻ����������Ժ�......");
						packet.data.add("custName",$("#custName" +��statusCode).val());	
						packet.data.add("custPwd",$("#custPwd"��+��statusCode).val());	
						packet.data.add("custAddr",$("#custAddr"��+��statusCode).val());	
						packet.data.add("idIccid",$("#idIccid"��+��statusCode).val());	
						packet.data.add("idAddr",$("#idAddr"��+��statusCode).val());	
						packet.data.add("contactPerson",$("#contactPerson"��+��statusCode).val());		
						packet.data.add("contactPhone",$("#contactPhone"��+��statusCode).val());	
						packet.data.add("contactAddr",$("#contactAddr"��+��statusCode).val());	
						packet.data.add("contactMAddr",$("#contactMAddr"��+��statusCode).val());	
						packet.data.add("custSex",$("#custSex"��+��statusCode).val());
						packet.data.add("custEmail",$("#custEmail"��+��statusCode).val());
						packet.data.add("phoneNo",$("#phoneNo"��+��statusCode).val());
						
						packet.data.add("gestoresName",$("#gestoresName"��+��statusCode).val());	
						packet.data.add("gestoresAddr",$("#gestoresAddr"��+��statusCode).val());
						packet.data.add("gestoresIdType",$("#gestoresIdType"��+��statusCode).val());
						packet.data.add("gestoresIccId",$("#gestoresIccId"��+��statusCode).val());
						var xsjbrxx="0";
						if($("#gestoresInfo1").css("display")=="none"){
							xsjbrxx="0";
				        }
				        else{
				        	xsjbrxx="1";
				        }
						packet.data.add("xsjbrxx",xsjbrxx);
						core.ajax.sendPacket(packet,function(packet){
							var retCode = packet.data.findValueByName("retCode");
							var retMsg = packet.data.findValueByName("retMsg");
							var cust = packet.data.findValueByName("cust");
							if(retCode == "000000"){
								//alert("custId="+cust);
								$("#custId"��+��statusCode).val(cust);
								$("#custOpenBtn"��+��statusCode).attr("disabled",true);
								$("#ordinaryOpenBtn"��+��statusCode).removeAttr("disabled");
								rdShowMessageDialog("�ͻ����������ɹ���",2);
								return ;
							}else{
								rdShowMessageDialog(retMsg + "[" + retCode + "]");
								return ;	
							}
						});	
						//location.reload();
					}
		
		function foo(){
				
			parent.L("1","1100","�ͻ�����","sq100/sq100_1.jsp","000");
			parent.removeTab('b893');
		}
	</script>
</HEAD>
<BODY >
<FORM  method=post name=frm >
	<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div> 
  <table cellspacing="0">
				<tr>
					<th width="5%">�ֻ����� </th>
					<th width="5%">��վ����ʱ�� </th>
					<th width="5%">����Ӫҵ�� </th>
					<th width="5%">�Ƿ���˳ɹ� </th>
					<th width="5%">SIM������ </th>
					<th width="5%">������Ϣ </th>
					<th width="10%">���� </th>
				</tr>		
<%
				for(int i=0;i<result1.length;i++){
%>
				<tr>
					<td>
						<input type="text" name="phoneNo<%=i%>" id="phoneNo<%=i%>" class="InputGrey" disabled value="<%=result1[i][0]%>"/>
					</td>
					<td>
						<input type="text" name="webOpenTime<%=i%>" id="webOpenTime<%=i%>" class="InputGrey" disabled value="<%=result1[i][3]%>"/>
					</td>
					<td>
						<input type="text" name="handlePlace<%=i%>" id="handlePlace<%=i%>" class="InputGrey" disabled value="<%=result1[i][20]%>"/>
					</td>
					<td>
						<input type="text" name="take<%=i%>" id="take<%=i%>" class="InputGrey" disabled value="<%=result1[i][25]%>"/>
					</td>
					<!-- sim������ ������ʡ������ѡ�š��͡�18Ԫ�׿�ʡ�ڰ桱����SIM������ѡ���ܵ����� 2014/04/29 16:12:36 gaopeng -->
					<td>
						<input type="text" name = "outSimType<%=i%>" id="outSimType<%=i%>" class="InputGrey" disabled value="<%=result1[i][27]%>"/>
					</td>
					
					<td>
						
						<%
						  System.out.println("----------------result1[i][26]="+result1[i][26]);
						  if("01".equals(result1[i][26])){
						%>
						  <input type="text" name="take<%=i%>" id="take<%=i%>" class="InputGrey" disabled value="������"/>
						<%
						}else if("02".equals(result1[i][26])){
						%>
						  <input type="text" name="take<%=i%>" id="take<%=i%>" class="InputGrey" disabled value="������"/>
						<%
					  }else{
					  %>
						  <input type="text" name="take<%=i%>" id="take<%=i%>" class="InputGrey" disabled value=""/>
						<%
					  }
						%>
					</td>
					
					<td>
						<!-- �ͻ�������Ӧ���� begin -->
						<input type="hidden" name="custName<%=i%>" id="custName<%=i%>" value="<%=result1[i][4]%>"/>
						<input type="hidden" name="custPwd<%=i%>" id="custPwd<%=i%>" value="<%=result1[i][10]%>"/>
						<input type="hidden" name="custAddr<%=i%>" id="custAddr<%=i%>" value="<%=result1[i][11]%>"/>
						<input type="hidden" name="idIccid<%=i%>" id="idIccid<%=i%>" value="<%=result1[i][2]%>"/>
						<input type="hidden" name="idAddr<%=i%>" id="idAddr<%=i%>" value="<%=result1[i][9]%>"/>
						<input type="hidden" name="contactPerson<%=i%>" id="contactPerson<%=i%>" value="<%=result1[i][12]%>"/>
						<input type="hidden" name="contactPhone<%=i%>" id="contactPhone<%=i%>" value="<%=result1[i][13]%>"/>
						<input type="hidden" name="contactAddr<%=i%>" id="contactAddr<%=i%>" value="<%=result1[i][14]%>"/>
						<input type="hidden" name="contactMAddr<%=i%>" id="contactMAddr<%=i%>" value="<%=result1[i][15]%>"/>
						<input type="hidden" name="custSex<%=i%>" id="custSex<%=i%>" value="0"/>
						<input type="hidden" name="custEmail<%=i%>" id="custEmail<%=i%>" value=" "/>
						
						<input type="hidden" name="custIdType<%=i%>" id="custIdType<%=i%>" value="<%=result1[i][29]%>"/>
						<input type="hidden" name="custValiDate<%=i%>" id="custValiDate<%=i%>" value="<%=result1[i][30]%>"/>
						<!-- �ͻ�������Ӧ���� begin -->
						
						<input type="button" style="display:none" id="custOpenPageSubmitBtn" />
						<input type="hidden" name="userPwd" value="<%=result1[i][5]%>"/>
						<input type="hidden" name="prePay_Fee" id="prePay_Fee<%=i%>" value="<%=result1[i][7]%>"/>
						<input type="hidden" name="simPay_fee" id="simPay_fee<%=i%>" value="<%=result1[i][8]%>"/>
						<input type="hidden" name="mail_Person<%=i%>" value="<%=result1[i][16]%>"/>
						<input type="hidden" name="mail_ID_ICCID<%=i%>" value="<%=result1[i][17]%>"/>
						<input type="hidden" name="mail_Phone<%=i%>" value="<%=result1[i][18]%>"/>
						<input type="hidden" name="mail_Address<%=i%>" value="<%=result1[i][19]%>"/>
						<!-- �ͻ�����ʱ������custId -->
						<input type="hidden"  name="custId<%=i%>" id="custId<%=i%>" value="<%=result1[i][23]%>"/>
						
						<!-- Ԥռʱ�绰����״̬ -->
						<input type="hidden" id="phoneStatus<%=i%>" name="phoneStatus<%=i%>" value="<%=result1[i][1]%>"/><!-- ����״̬ 1 Ԥռ 2 �ͻ������ɹ� 3 ��ͨ�����ɹ� -->
						<!-- ԤռId -->
						<input type="hidden" name="occupId<%=i%>" id="occupId<%=i%>" value="<%=result1[i][22]%>"/>
						<!-- ��ͨ���� -->
						<input type="hidden" name="servBusId<%=i%>" id="servBusId<%=i%>"/><!-- �������	Id -->
						<input type="hidden" name="offerId<%=i%>" id="offerId<%=i%>" value="<%=result1[i][6]%>"/>
						<input type="hidden" name="offerName<%=i%>" id="offerName<%=i%>"/>
						<input type="hidden" name="areaCode<%=i%>" id="areaCode<%=i%>" value="<%=result1[i][24]%>"/>
						<input type="hidden" name="ipt_PhoneID<%=i%>" id="ipt_PhoneID<%=i%>" value="<%=result1[i][31]%>"/>
						<%
						  System.out.println("----chenlei--b893------------result1[i][31]="+result1[i][31]);						  
						%>
						<!-- ������ -->
						<input type="hidden" name="gestoresName<%=i%>" id="gestoresName<%=i%>" value=""/>
						<input type="hidden" name="gestoresAddr<%=i%>" id="gestoresAddr<%=i%>" value=""/>
						<input type="hidden" name="gestoresIdType<%=i%>" id="gestoresIdType<%=i%>" value=""/>
						<input type="hidden" name="gestoresIccId<%=i%>" id="gestoresIccId<%=i%>" value=""/>
						
						<input type="button" id="preparedDo<%=i%>" class="b_text" value="Ԥռ" <%if(!"0".equals(result1[i][1]))out.print("disabled");%> />
						<input type="button" id="custOpenBtn<%=i%>" class="b_text" value="�ͻ�����" <%if(!"1".equals(result1[i][1]))out.print("disabled");%> />
						<input type="button" id="ordinaryOpenBtn<%=i%>" class="b_text" value="��ͨ����" <%if(!"2".equals(result1[i][1]))out.print("disabled");%>  />
						<!-- sim������ ������ʡ������ѡ�š��͡�18Ԫ�׿�ʡ�ڰ桱����SIM������ѡ���ܵ����� 2014/04/29 16:12:36 gaopeng ������-->
						<input type="hidden" name = "outSimName<%=i%>" id="outSimName<%=i%>" class="InputGrey" disabled value="<%=result1[i][28]%>"/>
					
					</td>
				</tr>
<%
				}
%>											
	</table>
	<table>					
				<tr>
					<td colspan="4" id="footer"> 
						<div align="center">
							<input class="b_foot" type="button" name=qryP value="�ر�" onClick="parent.removeTab('<%=opCode%>');">
							<input class="b_foot" type="button" name=goBack value="����" onClick="history.go(-1)">
							<!-- <input type="button" value='test' onclick='foo();'/> ������ -->
						</div>
			    </td>	
				</tr>
	</table>


</FORM>
		<%@ include file="/npage/include/footer.jsp"%>
</BODY> 	
</HTML>
						
  					
