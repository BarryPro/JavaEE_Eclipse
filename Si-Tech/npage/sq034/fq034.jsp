<%
   /*
   * ����: ������װ��ѯ(������װ)
�� * �汾: v1.0
�� * ����: 2009/01/30
�� * ����: jiangxl
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
     20110725      lijy        ��ӿ���������ߵ�����װ����װ�ָ��߼�
 ��*/
  /*
*/

	/*lijy change ��Ϊ�ý��汻�������ܸ���
	String opCode="q034";
	String opName="����";*/
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>

<%@ page contentType="text/html;charset=GB2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.text.*" %>
<%

		String custOrderId=request.getParameter("custOrderId");//�Զ���
		if(custOrderId==null) custOrderId="";
		String retCode ="";
		String retMsg  ="";
		ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
		String[][] temfavStr = (String[][]) arrSession.get(3);//Ȩ��ֵ
		String[] favStr = new String[temfavStr.length];
			for (int i = 0; i < favStr.length; i++) {
				favStr[i] = temfavStr[i][0].trim();
				//System.out.println("**************" + favStr[i]);
			}
		boolean power=false;
		if (WtcUtil.haveStr(favStr, "a999")){
			power = true;
			System.out.println("�ù����в�������ͨ״̬����Ȩ��");
		}
		String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
		String[][] baseInfoSession = (String[][])arrSession.get(0);
		String[][] otherInfoSession = (String[][])arrSession.get(2);
		String workNo = (String)session.getAttribute("workNo");
		  String nopass = (String) session.getAttribute("password");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		//String ipaddr = otherInfoSession[0][2];
    String powerCode= otherInfoSession[0][4];
    String ip_Addr = request.getRemoteAddr();

    String regionCode = orgCode.substring(0,2);

    String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
    String GroupId = baseInfoSession[0][21];
    String ProvinceRun = baseInfoSession[0][22];
    String OrgId = baseInfoSession[0][23];

    int recordNum = 0;
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    int iDate = Integer.parseInt(dateStr);
   	String NowDay = Integer.toString(iDate+1);
		String currentYear=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new Date());

		String orderSelectto = request.getParameter("orderSelectto");
		String serverSelectto = request.getParameter("serverSelectto");

		//����3   opcodestr="1";  
		//��װ6	opcodestr="4";  
		//��װ4		opcodestr="5";  
		//����		opcodestr="2";
		//�ߵ�5		opcodestr="3";  
		//��װ�ָ�9 opcodestr="9";	
    /*lijy chage@20110726*/
		String opcodestr = request.getParameter("opcodestr");
		String sOpType="";
			if("q034".equals(opCode)|| "e083".equals(opCode)||"e150".equals(opCode) ||"m074".equals(opCode) ||"m095".equals(opCode)){
				opcodestr="1";sOpType="3";
			}else if("q037".equals(opCode)){
				opcodestr="2";
			}else if("q038".equals(opCode)||"e084".equals(opCode)){
				opcodestr="3"; sOpType="5";
			}else if("q035".equals(opCode)){
				opcodestr="4"; 
			}else if("q036".equals(opCode) || "e085".equals(opCode)){
				opcodestr="5";sOpType="4";
			}else if("e086".equals(opCode) ){
				opcodestr="9";sOpType="9";
			}
    /*lijy chage@20110726  end */
 		String printAccept="";
%>
<wtc:utype name="sGetSeqNo" id="retSeqNo" scope="end" >
		<wtc:uparam value="5" type="int"/>
		<wtc:uparam value="<%=regionCode%>" type="string"/>
		<wtc:uparam value="" type="string"/>
</wtc:utype>
<%
		if(retSeqNo.getValue(0)!=null&&retSeqNo.getValue(0).equals("0")){
			if(retSeqNo.getSize() > 2 && retSeqNo.getUtype("2").getSize() > 0 ){
				printAccept = retSeqNo.getValue("2.0");
			} 	
		}
%>
	

<html>
<head>
<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../../css/jl.css" rel="stylesheet" type="text/css">

<script language="JavaScript">

var recordPerPage = 5; 			//ÿҳ��¼��50
var pageNumber = 1;					 //��ǰҳ��
var lastNumber = 0;					 //���һҳ�ļ�¼��
var error_code="";
var error_msg="";
var backArrMsg2="";
var verifyType ="";
var result="";
//core.loadUnit("debug");
//core.loadUnit("rpccore");
onload=function()
{
	//core.rpc.onreceive = doProcess;
	document.all.nowPage.value = pageNumber;
	document.all.jump.value = pageNumber;
	//document.frm.reasonType.selectedIndex=2;
	/*lijy add@20110726 for ����������ߵ�ʱ��ʾ�������˷ѽ��棬�ߵ��Ľɷѽ���*/
	if("<%=opCode%>" =="e083"){
		/*�����˷Ѳ�ѯ���񣬳�ʼ���˷Ѳ�*/
		document.getElementById("backPayDiv").display="none";
	}else if ("<%=opCode%>" =="e085"){
		/*���ýɷѲ�ѯ���񣬳�ʼ���ɷѲ�*/
		document.getElementById("payDiv").display="none";
	}
	else if ("<%=opCode%>" =="m074"){
		/*���ýɷѲ�ѯ���񣬳�ʼ���ɷѲ�*/
		document.getElementById("backPayDiv").display="none";
	}
		else if ("<%=opCode%>" =="m095"){
		/*���ýɷѲ�ѯ���񣬳�ʼ���ɷѲ�*/
		document.getElementById("backPayDiv").display="none";
	}
	/*lijy add@20110726 end*/
	auto();
}
/*-----------������÷ǿ���ת�˷�ҳ��------------
lijy ע�͸��߼�����Ϊ�˷ѽ��治����
function reDirect(packet){

	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var result = packet.data.findValueByName("result");
	if(result!="0"){//���÷�0����ת
		window.location="/npage/sq048/fq048.jsp?opCode=q048&opName=һ���Է��ýɷ��˷�&custOrderId="+document.frm._orderID.value.trim()+document.frm._orderArrayID.value.trim()+"|";
	}
}
*/
/*--------------��_orderId��ѡ�е�orderId-------------------*/
var selectCount=0;//selectѡ�еĸ���
function addOrderId(obj){
	if(obj.checked){//ѡ��״̬
		if(obj.v_orderId!=document.frm._orderID.value && selectCount>0){//���ѡ�в�ͬ�Ķ���������ѡ���ָ�ԭ��״̬
			obj.checked=false;
			rdShowMessageDialog("һ��ֻ�ܴ���һ�ֿͻ�����");
			return;
		}
		document.frm._orderID.value=obj.v_orderId;
		window.selectCount+=1;
	}else{//ȡ��״̬
		window.selectCount-=1;
		if(window.selectCount<=0){
			document.frm._orderID.value="";

		}
	}
	var a=document.getElementsByName("retCheckBox");
	document.frm._orderArrayID.value="";
	for(var i=0;i<a.length;i++){//�����Ӷ�����
		if(a[i].checked){
			document.frm._orderArrayID.value+="|"+a[i].value.trim();
		}
	}
}

/*---------����ϸ�ҳ���custOrderId������ִ�в�ѯ����-------*/
function auto(){
	if("<%=custOrderId%>"!=""){
		document.frm.quevalue.value="<%=custOrderId%>";//���ò�ѯ����
		commitJsp();//���ò�ѯ
	}
}
/*---------------�㸴ѡʱ�����ɲ���������ʾ--------------*/
var markCountFlag = "";//�жϺ����Ƿ�����ڴ�ҵ����г�����Ӫ��ҵ��ֻ��ͨ��e150���г���
function checkOperation(obj){
	//lijy add@20110726 ��һ��if�߼��жϵ���ӣ���Ϊ�����opcodeֻ�ܰ�������������Ӧ����
	if(((obj.v_masterservid =="30") && ("<%=opCode%>"=="e083" || "<%=opCode%>"=="e084" || "<%=opCode%>"=="e085" || "<%=opCode%>"=="e086"))||((obj.v_masterservid =="0" || obj.v_masterservid =="10"||obj.v_masterservid =="20") && ("<%=opCode%>"=="q034" || "<%=opCode%>"=="m074" || "<%=opCode%>"=="m095"  )))

	{
		if(obj.v_status!="" && obj.checked==true){
			rdShowMessageDialog("��״̬���ɲ���");
			obj.checked=false;
			selectCount+=1;//�Զ�ȡ������addOrderId�����л�-1������Ϊ��ƽ��������+1
		}
	}else{
		markCountFlag = "1";
		obj.checked=false;
		selectCount+=1;//�Զ�ȡ������addOrderId�����л�-1������Ϊ��ƽ��������+1
		return false;
	}
	//lijy delete @20110726 ��Ϊ����ڷ���ͨʱ������������������������ǿ�ƽ��У��������gsm����Ƕ�������״̬�Ƿ���ͨ�����������������ᵽ��js
	/*else{
		if(obj.checked && obj.v_status2.trim()=="����ͨ"){
			if (rdShowConfirmDialog("ȷ��Ҫǿ�Ƴ�����") == 0){ 
				obj.checked=false;
				selectCount+=1;//�Զ�ȡ������addOrderId�����л�-1������Ϊ��ƽ��������+1
			}
		}
	}*/
	

	var servBuisiId = obj.v_serv_busi_id;
	var Qpacket = new AJAXPacket("checkOperation.jsp","���ڲ�ѯ�����Ժ�......");
			Qpacket.data.add("servBuisiId",servBuisiId);
			core.ajax.sendPacket(Qpacket,doCheckOperation);
			Qpacket=null;
}
function doCheckOperation(packet){
	markCountFlag = packet.data.findValueByName("markCount");
	
}

//---------1------RPC������------------------
function doProcess(packet){
alert("�ص�");
    //ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
    self.status="";
		var retType ="";
        retType=packet.data.findValueByName("retType"); 
           backArrMsg =""; 
           error_code = packet.data.findValueByName("errorCode");
           error_msg =  packet.data.findValueByName("errorMsg");
		   		 backArrMsg = packet.data.findValueByName("backArrMsg");
		   
	 /*  lijy ע��@20110726  ���߼��Ĵ���js��commitJsp2���漰��jsp�ļ�������
   if(retType == "getTotalNum")
   {
				if(error_code == "000000")
				{
					var retInfo = packet.data.findValueByName("retInfo");
					if(retInfo != "")
					{
				   		calPageNum( parseInt(retInfo));
				        
					}
				}           
				else
				{
					error_msg = error_msg + "[errorCode:" + error_code + "]";
					rdShowMessageDialog(error_msg,0);
					return false;
				}
   }*/
   //--------------------------------------------------
   //�����ύ�ķ���
   if(retType == "orderdata")
   {
	alert("�ص�1");
	   if(error_code == "0")
				{
					var retInfo = packet.data.findValueByName("retInfo");
					var loginAccept = packet.data.findValueByName("loginAccept");
					var id_no = packet.data.findValueByName("id_no");
					var contract_no = packet.data.findValueByName("contract_no");
					var smcode = packet.data.findValueByName("smcode");
					var username = packet.data.findValueByName("username");
					
					$("#id_no").val(id_no);
					$("#contract_no").val(contract_no);
					$("#smcode").val(smcode);
					$("#username").val(username);
					
					
					if("<%=opCode%>" == "e083"){
						/* �����������ӡ��Ʊ */
						/*$("#loginAccept").val(loginAccept);*/
						var cashPay = $("#backMoney").val();
						if(cashPay != "" && parseFloat(cashPay) > 0){
							rdShowMessageDialog("�����ɹ��������ӡ��Ʊ");
							if(Number($("#kdZdFee").val()) != 0){
								showBroadKdZdBill("Bill","ȷʵҪ���з�Ʊ��ӡ��","Yes");
							}
							showBroadBill("Bill","ȷʵҪ���з�Ʊ��ӡ��","Yes");
						}else{
							rdShowMessageDialog("�����ɹ�");
						}
						
					}else{
						rdShowMessageDialog("�����ɹ�");
					}
					div_deleteAll();
					alert("�ص�2");
					var myPacket = new AJAXPacket("checkIsTo486.jsp","����У���Ƿ���Ҫ�̻����������Ժ�......");
					myPacket.data.add("phoneNo",$("#broadNo").val());
					myPacket.data.add("regCode","<%=regionCode%>");
					core.ajax.sendPacket(myPacket,doCheckIsTo486);
					myPacket = null;
					/*��ѯ����   lijyע�͵��ö��߼�����Ϊ�˷ѽ��治����
					var Qpacket = new AJAXPacket("fq034_6.jsp","���ڲ�ѯ�����Ժ�......");
				
					Qpacket.data.add("orderId",document.frm._orderID.value.trim());
				
					core.ajax.sendPacket(Qpacket,reDirect);
					Qpacket=null;*/
				}           
				else
				{		
					error_msg = error_msg + "[errorCode:" + error_code + "]";
					rdShowMessageDialog(error_msg,0);
				}
				location = location;
   }
   //--------------------------------------------------
   if(retType == "atte")
   {
       if(error_code == "0")
       {		
					rdShowMessageDialog("�����ɹ�");
			 }           
				else
				{		
					error_msg = error_msg + "[errorCode:" + error_code + "]";
					rdShowMessageDialog(error_msg,0);
					return false;
				}
   }
   
   //--------------------------------------------------

  if(retType=="find")
	{
	  var errorCode= packet.data.findValueByName("errorCode");
	  var errorMsg= packet.data.findValueByName("errorMsg");
		if(errorCode.trim()!="000000"){
			div_deleteAll2(0);
			if(errorMsg!=""){
				rdShowMessageDialog(errorMsg);	
			}
			else{
				rdShowMessageDialog("û�����ݣ���ı��ѯ����");
			}
	   		return false;  
 		}
  	
		var backArrMsg = packet.data.findValueByName("backArrMsg");
		var backArrMsg2 = packet.data.findValueByName("backArrMsg2");
		var custname = packet.data.findValueByName("custname");
		var operater = packet.data.findValueByName("operater");
		var orderstat = packet.data.findValueByName("orderstat");
		var quetype = packet.data.findValueByName("quetype");
		var quetype2 = packet.data.findValueByName("quetype2");
		var quetypes = packet.data.findValueByName("quetypes");
		var orderSelect = packet.data.findValueByName("orderSelect");
		var retInfo = packet.data.findValueByName("retInfo");
		var opc = packet.data.findValueByName("opc");
		
		if(backArrMsg.length >0){
			if(backArrMsg[0].length>0){
				var res_q_type = backArrMsg[0][8];
				//��� 40006
				//�ƻ� 40007
				if("40006"==res_q_type){
					$("#tr_otreson_1").show();					
				}else{
					$("#tr_otreson_1").hide();		
				}
			}
		}

		if(opc==2){									
			//document.frm.starttime.value=custname;
			//document.frm.endtime.value=operater;
			//document.frm.optName.value=orderstat;
		}else{
			document.frm.custName.value=operater;
			document.frm.optName.value=custname;
			document.frm.orderStatus.value=orderstat;
		}		
		/*lijy change @20110823 original is if(quetype=="2"&&quetypes!="21"&&quetype2!="2"){	*/
		if((quetype=="2" || quetype=="4") &&quetypes!="21"&&quetype2!="2"){		
			orderSelectorder(orderSelect);
			//alert("orderselect----"+orderSelect);
		}else if(backArrMsg.length>0&&backArrMsg!="backArrMsg")
		{ //alert("ok12");				
				div_deleteAll2(retInfo);

				var trdiv = document.getElementById("trdiv");
				var trdiv2 = document.getElementById("trdiv2");	
				var opcodestr = document.frm.opcodestr.value;	
				for(var a=0; a<backArrMsg.length ; a++)
				{					
					var info="info"+a;
					info=trdiv.insertRow();
					info.setAttribute("bgcolor","#EEEEEE",0);
					info.setAttribute("height","18",0);
					
					info.attachEvent("onmouseover",ab_m(info));    
					info.attachEvent("onmouseout",out_m(info));   
					
					var stateStr=backArrMsg[a][4];
					var checkval=backArrMsg[a][0];
					var stateStr2="disabled";
					if(opcodestr=="2"){
						stateStr=backArrMsg[a][6];
						checkval=backArrMsg[a][2];
					}
					
					/*if(stateStr=="10" <%if(power){%>|| stateStr=="13"<%}%>){
							stateStr2="";
					}else if(opcodestr=="1"){
						if(stateStr=="11"||stateStr=="12" || stateStr == "20" ){
							stateStr2="";
						}
					}
					
 					var buttonvalue ="";
					var bbt="";
					if(backArrMsg[a][4].trim()=="0"){
						//stateStr = "[������]";					 
						//buttonvalue="��ѯ";
					}
					else if(backArrMsg[a][4].trim()=="1"){
						//stateStr = "<font color='green'>[��ͨ��]</font>";
						//buttonvalue="��ѯ";
					}
					else//2
					{
						//stateStr = "<font color='red'>[���]</font>";
						buttonvalue="����";
					}*/
					//lijy change@20110726
					var masterServId=backArrMsg[a][9];
					var orderType="";
				  if(masterServId == "30")//��ʾ���
					{
						orderType="���";
						if(opcodestr =="1"){//����
							if(stateStr=="11"||stateStr=="12" || stateStr == "13"|| stateStr == "20" || stateStr=="17" ){
								stateStr2="";
							}
						}else if (opcodestr =="3"){//�ߵ�
							if(stateStr=="13" || stateStr=="17" ){
								stateStr2="";
							}
					  }else if (opcodestr =="5"){//��װ
					  	if(stateStr=="13" || stateStr=="17"){
								stateStr2="";
							}
					  }else if (opcodestr =="9"){//��װ�ָ�
					  	if(stateStr=="19" ){
								stateStr2="";
							}
						}
					}else if(masterServId == "20")//��ʾIMS�̻�				
					{
					  stateStr2="";
						orderType="IMS�̻�";
					}else{  //��ʾ����
						orderType="����";
						if(stateStr=="10" <%if(power){%>|| stateStr=="13"<%}%>){
								stateStr2="";
						}else if(opcodestr=="1"){
							if(stateStr=="11"||stateStr=="12" || stateStr == "20" || stateStr == "13"){
								stateStr2="";
							}
						}
					}
					//lijy change@20110726 end
					/*���ù���״̬ʵʱ��ѯ�ӿڣ��鿴�Ƿ��������Ӧҵ��*/
					info.insertCell().innerHTML ="<tr><td nowrap><div align='center'>&nbsp;"+"<input class='text2' type='checkbox' id='retCheckBox' onclick='<%if(!opcodestr.equals("12")){%>checkOperation(this);addOrderId(this);<%}%>showInfo(\""+a+"\",this);' v_orderId='"+<%if(!opcodestr.equals("2")){%>backArrMsg[a][6]<%}else{%>backArrMsg[a][0]<%}%>+"' v_status='"+stateStr2+"'  v_serv_busi_id='"+backArrMsg[a][8]+"'  v_status2='"+<%if(!opcodestr.equals("2")){%>backArrMsg[a][7]<%}else{%>backArrMsg[a][9]<%}%>+"' v_oaId='"+<%if(!opcodestr.equals("2")){%>backArrMsg[a][0]<%}else{%>backArrMsg[a][2]<%}%>+"'  v_masterservid='"+backArrMsg[a][9]+"' name='retCheckBox' value="+checkval+" >"+"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>"+ backArrMsg[a][0] +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg[a][1] +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ orderType +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg[a][2] +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg[a][3] +"</a></div></td>";
					//lijy change @20110726 original is 	if(backArrMsg[a].length>8){
					//if(backArrMsg[a].length>8){
					if(backArrMsg[a].length>8 &&quetype2=="2"){
						info.insertCell().innerHTML ="<td nowrap style='display:none'><div align='center'>&nbsp;"+backArrMsg[a][4]+"</a></div></td>";
					}else{
						info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg[a][7] +"</a></div></td></tr>";	
					}
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg[a][5] +"</a></div></td>";
					if(backArrMsg[a].length>8 &&quetype2=="2"){
						info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg[a][9] +"</a></div></td>";
						info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg[a][7] +"</a></div></td>";
						info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg[a][8] +"</a></div></td>";			
						info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ "<input type='button' name='' value='����' class='b_text' onclick='attemper(\""+backArrMsg[a][2]+"\",this)' ></a></div></td><input type='hidden' name='retCheckBoxb"+a+"' id='retCheckBoxb"+a+"' value='"+ backArrMsg[a][0] +",-"+ backArrMsg[a][1] +",-"+ backArrMsg[a][2] +",-"+ backArrMsg[a][3] +",-"+ backArrMsg[a][4] +",-"+ backArrMsg[a][5] +",-"+ backArrMsg[a][6] +",-"+ backArrMsg[a][7] +",-"+ backArrMsg[a][8]+",-"+ backArrMsg[a][9] +"'></tr>";	
						
					}else{
						info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg[a][6] +"</a></div></td></tr>";
						
						if(stateStr2==""){
							info.insertCell().innerHTML="<td><font color=blue>�ɲ���</font></td>";
						}else{
							info.insertCell().innerHTML="<td><font color=red>���ɲ���</font></td>";
						}
						
					}
					//"+ backArrMsg[a][7] +"</a></div></td></tr>";					
		}
				
		if(backArrMsg2.length>0&&backArrMsg!="backArrMsg2")
		{ //alert("ok12");
				//div_deleteAll();
				//alert(trdiv);
				var trdiv = document.getElementById("trdiv2");
				var ai=0;	
				var a2=0;
				for(var a=0; a<backArrMsg2.length ; a++)
				{					
					if(ai<=backArrMsg2[a][0]){
						a2=0;
					}
					var info="info"+a;
					info=trdiv.insertRow();
					info.setAttribute("bgcolor","#EEEEEE",0);
					info.setAttribute("height","18",0);					
					info.setAttribute("name","aa"+backArrMsg2[a][0]+"aa"+a2);
					info.setAttribute("id","aa"+backArrMsg2[a][0]+"aa"+a2);
					info.attachEvent("onmouseover",ab_m(info));    
					info.attachEvent("onmouseout",out_m(info));	
					var stateStr="";
 					var buttonvalue ="��������";
					var buttonvalue2 ="��������";
					buttonvalue ="";
					buttonvalue2 ="";
					if(backArrMsg2[a][4].trim()=="0"){
						//stateStr = "[������]";					 
						//buttonvalue="��ѯ";
					}
					else if(backArrMsg2[a][4].trim()=="1"){
						//stateStr = "<font color='green'>[��ͨ��]</font>";
						//buttonvalue="��ѯ";
					}
					else//2
					{
						//stateStr = "<font color='red'>[���]</font>";
						buttonvalue="����";
					}
					
				var sopcodestrs ="";
				   if("<%=opCode%>" == "m074" ) {
				   sopcodestrs =	"��è����";
				   }
				   else if("<%=opCode%>" == "m095" ) {
				   sopcodestrs =	"�ƶ��̳ǿ���";
				   }
				   else {
				    sopcodestrs =	backArrMsg2[a][2];
				   }
					
					info.insertCell().innerHTML ="<tr><td nowrap><div align='center'>&nbsp;"+ backArrMsg2[a][1] +"</a></div><input class='text2' type='hidden' value='"+ backArrMsg2[a][1]+"' id='retCheckBox"+ backArrMsg2[a][0]+"aa"+a2+"' onclick='' name='retCheckBox"+ backArrMsg2[a][0]+"aa"+a2+"'>"+"</a></div><input type='hidden' name='retCheckBoxbb"+ backArrMsg2[a][0]+"bb"+a2+"' id='retCheckBoxbb"+ backArrMsg2[a][0]+"bb"+a2+"' value='"+ backArrMsg2[a][0] +",-"+ backArrMsg2[a][1] +",-"+ backArrMsg2[a][2] +",-"+ backArrMsg2[a][3] +",-"+ backArrMsg2[a][4] +",-"+ backArrMsg2[a][5] +",-"+ backArrMsg2[a][6]+",-"+ backArrMsg2[a][7]+",-"+ backArrMsg2[a][8] +"'>"+"</td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ sopcodestrs +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>"+ backArrMsg2[a][3] +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg2[a][4] +"</a></div></td>";
					//info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg2[a][5] +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>"+ backArrMsg2[a][6] +"</a></div></td>";
					if(ai<=backArrMsg2[a][0]){
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg2[a][7] +"</a></div></td>";
					ai=ai+(backArrMsg2[a][0]-ai)+1;
					}else {
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg2[a][7] +"</a></div></td>";
					}
					a2++;					
					//"+ backArrMsg2[a][7] +"</a></div></td></tr>";
				}				
		}			
	}
	else
	{
			 //alert("û�з�������������");
				rdShowMessageDialog("û�з�������������");
				div_deleteAll();
	}

	}

}
//-----------------------------------Ϊtr������������Ƴ��¼�
var out_m = function(info)    
{    
	info.style.color='black'; 	
  return function()    
  {    
    outf(info);//�ú���Ϊ�ⲿ�����һ��ִ�к�����    
  }    
} 

function outf(info)
{
 	info.style.color='black'; 	
}

var ab_m = function(info)    
{    
	info.style.color='red';
  return function()    
  {    
    ab(info);//�ú���Ϊ�ⲿ�����һ��ִ�к�����    
  }    
}    

function ab(info)
{		
 	info.style.color='red';
 	
}
//-----------------------------------
function doCheckIsTo486(){
	var	returnPhone	=packet.data.findValueByName("returnPhone"); 	
	if(returnPhone!=""){
		L("1","m486","IMS�̻�����","sm486/fm486_Main.jsp?myphoneNo="+returnPhone,"0");
		parent.removeTab("e083");
	}
}
function div_deleteAll()
{		//alert(6666);
		//alert("pppp"+document.all.trdiv2.rows.length);
    //������ӱ��е�����
		selectCount=0;
    for(var a = document.all.trdiv.rows.length-1 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ�ڶ���
    {
     	document.all.trdiv.deleteRow(a);
    }
 		for(var a = document.all.trdiv2.rows.length-1 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ�ڶ���
    {
     	document.all.trdiv2.deleteRow(a);
    }
	 document.all.trdiv2.style.display="none";
   
}
function div_deleteAll2(rt)
{		//alert(6666);
		//alert("pppp"+document.all.trdiv2.rows.length);
    //������ӱ��е�����
		selectCount=0;
    for(var a = document.all.trdiv.rows.length-1 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ�ڶ���
    {
     	document.all.trdiv.deleteRow(a);
    }
 		for(var a = document.all.trdiv2.rows.length-1 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ�ڶ���
    {
     	document.all.trdiv2.deleteRow(a);
    }
		document.all.trdiv2.style.display="none";
		calPageNum2(rt);
   
}

function queryAddAllRow()
{		//alert(5555);
		div_deleteAll();
		var tree;
		var trdiv = document.getElementById("trdiv");
		/*	var num=parseInt(recordPerPage);
		if(pageNumber==parseInt(document.frm.tatolPages.value))
		{
			num=parseInt(lastNumber);
		}else{
			num=parseInt(recordPerPage);
		}*/
		var start=(parseInt(pageNumber)-1)*recordPerPage;
		getResult2(start,recordPerPage+start);
}

function queryAddAllRow2()
{
		div_deleteAll();
		var tree;
		var trdiv = document.getElementById("trdiv");
		
		var start=(parseInt(pageNumber)-1)*recordPerPage;		
		getResult2(start,recordPerPage+start);
}

function firstPage() //��ҳ
{
	if(pageNumber-1>0)
	{
		pageNumber = 1;
		document.all.nowPage.value = pageNumber;
		document.all.jump.value = pageNumber;
		queryAddAllRow();

	}
}
function pageUp()
{
	if(pageNumber-1>0)
	{
		pageNumber =	pageNumber - 1;		
		document.all.nowPage.value = pageNumber;
		document.all.jump.value = pageNumber;
		queryAddAllRow(); 
	}
}

function pageDown()
{
	if(pageNumber < document.frm.tatolPages.value*1)
	{
		pageNumber =	pageNumber + 1;
		
		document.all.nowPage.value = pageNumber;
		document.all.jump.value = pageNumber;
		queryAddAllRow(); 
		}
}
function lastPage()
{
	if(pageNumber < document.frm.tatolPages.value*1)
	{
		pageNumber =	document.frm.tatolPages.value;
		
		document.all.nowPage.value = pageNumber;
		document.all.jump.value = pageNumber;
		queryAddAllRow();
	 }
}
function query_jump()
{
	document.all.jump.value = document.all.jump.value.trim();
	if(document.all.jump.value.trim()=="")
	{
		document.all.jump.value = pageNumber;
		return false;
	}
	if(!forPosInt(document.all.jump))
	{
		document.all.jump.value = pageNumber;
		return false;
	}
	if(document.all.jump.value*1<1 || document.all.jump.value*1>document.all.tatolPages.value)
	{
		document.all.jump.value = pageNumber;
		return false;
	}
	if(document.all.jump.value != pageNumber)
	{
	pageNumber = document.all.jump.value;	
	document.all.nowPage.value = pageNumber;
	queryAddAllRow();
	}
}


function judge_valid()
{
		if(document.frm.start.value.trim().len()!=0 || document.frm.end.value.trim().len()!=0)
		{
			if(document.frm.start.value.trim().len()!=0 && document.frm.end.value.trim().len()!=0)
			{
				if((document.frm.start.value-document.frm.end.value)>0)
				{
					rdShowMessageDialog("��ʼʱ�䲻�ܴ��ڽ���ʱ��!!");
					document.frm.end.select();
					return false;
				}
				if((document.frm.start.value-document.frm.currentYear.value)>0)
				{
					rdShowMessageDialog("��ʼʱ�䲻�ܴ��ڵ�ǰʱ��!!");
					document.frm.end.select();
					return false;
				}
				if((document.frm.end.value-document.frm.currentYear.value)>0)
				{
					rdShowMessageDialog("����ʱ�䲻�ܴ��ڵ�ǰʱ��!!");
					document.frm.end.select();
					return false;
				}
			}else{
				rdShowMessageDialog("����дʱ����!!");
				return false;
			}
		}
    return true;
}

 
function resetJsp()
{
		with(document.frm)
		{
			phoneNo.value="";
			phones.value="";
			start.value="";
			end.value="";
			//area.selectedIndex=0;
			//region.selectedIndex=0;
			//stateFlag.selectedIndex=0;
			recodeNum.value="0";
			tatolPages.value="1";
			nowPage.value="1";
			jump.value="1";
		}

		pageNumber = 1; //��ǰҳ��
		lastNumber = 0; //���һҳ�ļ�¼��
		div_deleteAll();
		    
		del_over();
}

/*lijy change@20110726  ��jsû�б�����
function getResult(a,b)
{
	var startTime = document.frm.start.value.trim();
	var endTime = document.frm.end.value.trim();
	//var stateFlag = document.frm.stateFlag[document.frm.stateFlag.selectedIndex].value;		
	var myPacket = new AJAXPacket("fq034_4.jsp?opcodestr=<%=opcodestr %>&opCode=<%=opCode %>&opName=<%=opName %>","���ڲ�ѯ�����Ժ�......");
	myPacket.data.add("retType","find");
	myPacket.data.add("phoneNo",document.frm.phoneNo.value.trim());
	//myPacket.data.add("stateFlag",stateFlag);
	myPacket.data.add("startTime",startTime);
	myPacket.data.add("endTime",endTime);
	myPacket.data.add("startRow",a);
	myPacket.data.add("endRow",b);
  core.ajax.sendPacket(myPacket);
  myPacket=null;
}
*/
function getResult2(a,b)
{
	var startTime = "";
	var endTime = "";
	var optName = "";
	//var stateFlag = document.frm.stateFlag[document.frm.stateFlag.selectedIndex].value;		
	var	quetype = document.frm.quetypeto.value;		
	var	quevalue = document.frm.quevalueto.value;
	var	quetype2 = document.frm.quetype2to.value;	
	startTime = document.frm.starttimeto.value.trim();
	endTime = document.frm.endtimeto.value.trim();
	optName = document.frm.optNameto.value.trim();			

 	var myPacket = new AJAXPacket("fq034_4.jsp?opcodestr=<%=opcodestr %>&opCode=<%=opCode %>&opName=<%=opName %>","���ڲ�ѯ�����Ժ�......");
	myPacket.data.add("retType","find");
	myPacket.data.add("phoneNo",document.frm.phoneNo.value.trim());
	
	
	myPacket.data.add("startTime",startTime);
	myPacket.data.add("endTime",endTime);
	myPacket.data.add("optName",optName);
	myPacket.data.add("quetype",quetype);
	myPacket.data.add("quetype2",quetype2);
	myPacket.data.add("quevalue",quevalue);
	myPacket.data.add("startRow",a);
	myPacket.data.add("endRow",b);  
	myPacket.data.add("recordPerPage",recordPerPage); 
	
   core.ajax.sendPacket(myPacket);  
   myPacket=null; 
}

function document_onkeydown()
{//alert(555);

    if (window.event.srcElement.type!="button" && window.event.srcElement.type!="textarea")
    {

        if (window.event.keyCode == 13)
        {
            window.event.keyCode = 9;
        }
    }
}
 
 
//-------------------------------
function commitJsp()
{
	
	document.frm._orderID.value="";//���
	document.frm._orderArrayID.value="";
	window.selectCount=0;
		with(document.frm)
	{
		recodeNum.value="0";
		tatolPages.value="1";
		nowPage.value="1";
		jump.value="1";
	}
	pageNumber = 1; //��ǰҳ��
	lastNumber = 0; //���һҳ�ļ�¼��
  div_deleteAll();
  if( judge_valid()==false )
  {
      return false;
  } 		
	document.frm.quetypeto.value = document.frm.quetype.value;	
	document.frm.quevalueto.value = document.frm.quevalue.value;
	document.frm.quetype2to.value = ret_value3("quetype2");			
	if(document.frm.quetype2to.value=="2"){			 		 
		document.frm.starttimeto.value = document.frm.starttime.value.trim();
		document.frm.endtimeto.value = document.frm.endtime.value.trim();
		document.frm.optNameto.value = document.frm.optName.value.trim();
	}
	//var stateFlag = document.frm.stateFlag[document.frm.stateFlag.selectedIndex].value;		
	queryAddAllRow2();
	
	over();
}

/*
lijy ע�� @20110726 ��Ϊ��jsû�б�����
function commitJsp2()
{
	with(document.frm)
	{
		recodeNum.value="0";
		tatolPages.value="1";
		nowPage.value="1";
		jump.value="1";
	}
	pageNumber = 1; //��ǰҳ��
	lastNumber = 0; //���һҳ�ļ�¼��
  div_deleteAll();

  if( judge_valid()==false )
  {
      return false;
  } 

	var quetype=document.frm.quetype.value.trim();
	var quevalue=document.frm.quevalue.value.trim();
	
	var startTime = document.frm.start.value.trim();
	var endTime = document.frm.end.value.trim();
	//var stateFlag = document.frm.stateFlag[document.frm.stateFlag.selectedIndex].value;		
	
	var myPacket = new AJAXPacket("selectOrderNo7.jsp","���ڻ�ü�¼���������Ժ�......");
	myPacket.data.add("retType","getTotalNum");
	myPacket.data.add("quetype",quetype);
	myPacket.data.add("quevalue",quevalue);
	
	myPacket.data.add("phoneNo",document.frm.phoneNo.value.trim());
	//myPacket.data.add("stateFlag",stateFlag);
	myPacket.data.add("startTime",startTime);
	myPacket.data.add("endTime",endTime);
	core.ajax.sendPacket(myPacket);
	myPacket=null; 
	over();
 }
*/

//-------------------------------

function setBusInfo(packet)
{
	var	retCode	=packet.data.findValueByName("retCode"); 	
	var	retMsg	=packet.data.findValueByName("retMsg"); 	

	if (!( retCode=="000000" ) )
	{
		document.all.bFCode.value=retCode;
		document.all.bFMsg.value=retMsg;
	}
	else
	{
		document.all.bFCode.value="000000";
		document.all.bFMsg.value="У��ɹ�";
	}
}

function commitJsp3(a,b)
{
	
	


	var reasonDescription = "";
	if("e083"!="<%=opCode%>"){
			reasonDescription = "��������";
	}
	
	if($("#tr_otreson_1").is(":visible")){
		if($("#sel_reasonDescription").val()=="6"){
			if($("#textarea_otreson").text().trim()==""){
				rdShowMessageDialog("����������ԭ��");
				return;
			}
			
			if($("#textarea_otreson").text().trim().length>30||$("#textarea_otreson").text().trim().length<1){
				rdShowMessageDialog("����ԭ��ֻ������1-30���ַ�");
				return;
			}
			
			reasonDescription = $("#sel_reasonDescription").val()+"��"+$("#sel_reasonDescription option:selected").text()+"��"+$("#textarea_otreson").text().trim();
			
		}else{
				if($("#sel_reasonDescription").val()==""){
						rdShowMessageDialog("��ѡ�񳷵�ԭ��");
						return;
				}	
				
				reasonDescription = $("#sel_reasonDescription").val()+"��"+$("#sel_reasonDescription option:selected").text();
		}
	}else{
			reasonDescription = "��������";
	}
	
	showBroadKdZdBill("Bill","ȷʵҪ���з�Ʊ��ӡ��","Yes");//����д��
	showBroadBill("Bill","ȷʵҪ���з�Ʊ��ӡ��","Yes");//����д��
	
	
	/* �����������ӡ��� */
	with(document.frm)
	{
		recodeNum.value="0";
		tatolPages.value="1";
		nowPage.value="1";
		jump.value="1";
	}
	pageNumber = 1; //��ǰҳ��
	lastNumber = 0; //���һҳ�ļ�¼�� 		
  if( judge_valid()==false )
  {
        return false;
  } 

	var quetype=document.frm.quetype.value.trim();
	var quevalue=document.frm.quevalue.value.trim();
	var reasonType = document.frm.reasonType.value.trim();
	
	/*
	var reasonDescription = document.frm.reasonDescription.value.trim();		
	if(reasonDescription=="")
	{
			reasonDescription="��������";
	}
	*/
	
	
	var startTime = "";
	
	var endTime = "";
	var osr="<%=opcodestr %>";
	if(osr=="4"){
		 startTime =document.frm.reasonstart.value.trim();
		 endTime =document.frm.reasonend.value.trim();
	}		
	//var stateFlag = document.frm.stateFlag[document.frm.stateFlag.selectedIndex].value;		
	var aa=ret_value();
	if(aa==""){ 
		rdShowMessageDialog("��ѡ��ͻ���������ͷ��񶨵�");
		return;
	}
	if(a!=null){
		quetype=a;//���˵�����
	}
	if(b!=null){
		quevalue=b;//���˵�����
	}
	//div_deleteAll();
	var phoneNo = $("#trdiv2 tr:eq(1) td:eq(2)").text();
	
	/*zhangyan add*/
	if("<%=opCode%>" == "e083" )
	{
		var orderNum = $.trim($("#orderNum").val());
		//alert(orderNum);
		if(orderNum == "2"){
		
			/*ָ��Ajax����ҳ*/
			var packet = new AJAXPacket("../public/pubBUSAPIAjax.jsp"
				,"���Ժ�...");
			
			/*��ajaxҳ�洫�ݲ���*/
			packet.data.add("orderArrayID"
				,document.frm._orderArrayID.value.trim() );
			packet.data.add("opCode","<%=opCode%>" );
			
			/*����ҳ��,��ָ���ص�����*/
			core.ajax.sendPacket(packet,setBusInfo,false);
			packet=null;		
		}else{
			document.all.bFCode.value="000000";
			document.all.bFMsg.value="У��ɹ�";	
		}
	}
	
	if("<%=opCode%>" == "e083")
	{
		if (!(  document.all.bFCode.value=="000000") )
		{
			rdShowMessageDialog(document.all.bFMsg.value , 0);
			return false;
		}
	}		
	
	if("<%=opCode%>" == "e083" || "<%=opCode%>" == "e084" || "<%=opCode%>" == "m074" || "<%=opCode%>" == "m095"){
		
		getBroadMsg(phoneNo);
		getPubSmCode($("#broadNo").val());
	}
	
	
	/* �����������ӡ��� */
	if("<%=opCode%>" == "e083"){
		if(!printCfm()){
			return false;
		}
	}
	
	var myPacket = new AJAXPacket("fq034_3.jsp?opcodestr=<%=opcodestr %>&opCode=<%=opCode %>&opName=<%=opName %>","���ڻ�ü�¼���������Ժ�......");
	myPacket.data.add("retType","orderdata");
	myPacket.data.add("quetype",quetype);
	myPacket.data.add("quevalue",quevalue);
	myPacket.data.add("reasonType",reasonType); 
	myPacket.data.add("reasonDescription",reasonDescription);
	myPacket.data.add("quevalue",aa);
	myPacket.data.add("phoneNo",document.frm.phoneNo.value.trim());	
	myPacket.data.add("startTime",startTime);
	myPacket.data.add("endTime",endTime);
	myPacket.data.add("_orderID",document.frm._orderID.value.trim()+"->"+document.frm._orderArrayID.value.trim());
	myPacket.data.add("workName","<%=workName%>");
	myPacket.data.add("loginAccept","<%=printAccept%>");
	myPacket.data.add("functionCode",$("#functionCode").val());
	myPacket.data.add("sphoness",phoneNo);
	
	if(!check(document.frm)) return false ;
	core.ajax.sendPacket(myPacket);		 
	myPacket=null; 
	over();
 }
function printCfm(){
	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
	if(typeof(ret)!="undefined"){
		if((ret=="confirm")){
			if(rdShowConfirmDialog('ȷ�ϵ��������')==1){
				return true;
			}else{
				return false;
			}
		}
		if(ret=="continueSub"){
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��1��')==1){
				return true;
			}else{
				return false;
			}
		}else{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��2��')==1){
				return true;
			}else{
				return false;
			}
		}
	}
	else{
		if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��3��')==1){
			return true;
		}else{
			return false;
		}
	}
}
function showPrtDlg(printType,DlgMessage,submitCfm){
		var h=198;
		var w=350;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var pType="subprint";
		var billType="1";
		var sysAccept = "<%=printAccept%>";
		
		
		var tmp_tdeq2 = "";
		if($("#trdiv2 tr").size()>1){
			tmp_tdeq2 = $("#trdiv2 tr:eq(1)").find("td:eq(2)").text().trim();
		}
		
		
		var phone_no = tmp_tdeq2;
		var mode_code = "";
		
		
		var fav_code = "";
		var area_code = "";
		var printStr = printInfo(printType);
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage; 
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		return path;
}
function printInfo(printType){
	var retInfo = "";
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	
	var functionCode = $("#functionCode").val();
	cust_info+="����ʺţ�"+$("#broadNo").val()+"|";
	cust_info+="�ͻ�������"+$("#custName").val()+"|";
	
	var cTime = "<%=cccTime%>";
	opr_info += "ҵ������ʱ�䣺"+cTime +"|";
	if(functionCode == "4977"){
		opr_info += "����ҵ�����ƣ�����      ������ˮ:"+"<%=printAccept%>"+"|";
		
		note_info1 += "��ע��"+"|";
		note_info1 +="1�������������ԭ�����ͨ��������ȡ����ԭǩ���Э���������ϣ���Ҫ�����»ָ����ҵ�񣬽��������û�������ҵ�����̰���" + "|";
		getPubSmCode($("#broadNo").val());
		var pubSmCode = $("#pubSmCode").val();
		/* 
     * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
     * ����ʡ���kg������Ʒ��kh
     */
		if(pubSmCode == "kf" || pubSmCode == "kg" || pubSmCode == "kh" || pubSmCode == "ki"){
			note_info1 += "2������������벦��������ߣ�10086"+"|";
		}
		
	}else if(functionCode == "b542"){
		opr_info += "����ҵ�����ƣ�Ԥ���ָ�      ������ˮ:"+"<%=printAccept%>"+"|";
		opr_info += "ҵ����Чʱ��:24Сʱ����Ч" + "|";
		note_info1 += "��ע��Ԥ���ָ���ָ�������ȡ" + "|";
	}
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}
/*
lijyע��@20110726 ,��jspû�б����ã�
function commitJsp5(op,op2)
{	
		with(document.frm)
		{
			recodeNum.value="0";
			tatolPages.value="1";
			nowPage.value="1";
			jump.value="1";
		}
		pageNumber = 1; //��ǰҳ��
		lastNumber = 0; //���һҳ�ļ�¼�� 		
		if( judge_valid()==false )
		{
		        return false;
		}
	
		var quetype=document.frm.quetype.value.trim();
		var quevalue=document.frm.quevalue.value.trim();
		var startTime = document.frm.start.value.trim();
		var endTime = document.frm.end.value.trim();
		//var stateFlag = document.frm.stateFlag[document.frm.stateFlag.selectedIndex].value;		
		var aa=ret_value();
		if(aa==""){ 
			//rdShowMessageDialog("��ѡ��ͻ���������ͷ��񶨵�");
			//return;
		}
		var bb=ret_value6();		
		document.frm.orderSelectto.value=ret_value5();
		document.frm.serverSelectto.value=bb;	
		document.frm.action="fq034.jsp?opCode="+op+"&opName="+op2;
		document.frm.submit();
}
*/
function orderSelectorder(orderSelect)
{
		if(!(orderSelect.trim().length>0&&orderSelect!="orderSelect")){
			rdShowMessageDialog("û�����ݣ���ı��ѯ����");
			return false;
		}
		var quevalue=document.frm.quevalue.value.trim();
		var quetype=document.frm.quetypeto.value.trim();
		var h=400;
		var w=500;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
		/*lijy change @20110823 original is var ret=window.showModalDialog("fq034_2.jsp?quevalue="+quevalue,"",prop);*/
		var ret=window.showModalDialog("fq034_2.jsp?quevalue="+quevalue+"&quetype="+quetype+"&opCode=<%=opCode %>&opName=<%=opName %>","",prop);
		
		if(typeof(ret)!="undefined"&&ret!="")
		{
			/*lijy add@2010823*/
			var startTime = document.frm.starttimeto.value.trim();
	    var endTime = document.frm.endtimeto.value.trim();
	    /*lijy add@2010823 end */
			 //document.all.newPhone.value=ret;
			 //document.all.confirm.disabled=false;//����ȷ�ϰ�ť����ʹ��
			var myPacket = new AJAXPacket("fq034_4.jsp?opcodestr=<%=opcodestr %>&opCode=<%=opCode %>&opName=<%=opName %>","���ڲ�ѯ�����Ժ�......");
			myPacket.data.add("retType","find");
			/*lijy change@20110823 original is myPacket.data.add("quetype","21");*/
			myPacket.data.add("quetypes","21");			
			myPacket.data.add("quetype",quetype);
			myPacket.data.add("quevalue",quevalue);
			myPacket.data.add("orderSelectId",ret);
			myPacket.data.add("startRow",1);
			myPacket.data.add("endRow",30);
			/*lijy add@20110823 */
			myPacket.data.add("startTime",startTime);
			myPacket.data.add("endTime",endTime);
			/*lijy add@2010823 end */
			core.ajax.sendPacket(myPacket);
			myPacket=null;
		}
		
		else
		{
			rdShowMessageDialog("��ѡ��ͻ�������!");
			//document.all.newPhone.value = "";
			//document.all.newPhone.select();
		}
}

function calPageNum(totalNum)
{   //alert(444);
	  ////alert(totalNum);
	  ////alert(recordPerPage);

		document.all.recodeNum.value = totalNum;
		document.all.nowPage.value= 1;
		
		pageNumber=1;
		if(totalNum%recordPerPage==0){
			////alert(totalNum/recordPerPage);
			document.frm.tatolPages.value=totalNum/recordPerPage;
			lastNumber=recordPerPage;
		}else{
			////alert(totalNum/recordPerPage);
			document.frm.tatolPages.value=parseInt(totalNum/recordPerPage)+1;
			lastNumber=totalNum%recordPerPage;
		  /*	if(document.frm.tatolPages.value=="1")
			{
				recordPerPage=lastNumber;
			}else{
				recordPerPage=recordPerPage;
			}*/
		}
		queryAddAllRow();
}

function calPageNum2(tot)
{ 
		var totalNum=parseInt(tot);
		document.all.recodeNum.value = totalNum;				
		//pageNumber=1;
		if(totalNum%recordPerPage==0){
			////alert(totalNum/recordPerPage);
			document.frm.tatolPages.value=totalNum/recordPerPage;	
			//lastNumber=recordPerPage;
		}else{
			////alert(totalNum/recordPerPage);
			document.frm.tatolPages.value=parseInt(totalNum/recordPerPage)+1;
			//lastNumber=totalNum%recordPerPage;
			/*	if(document.frm.tatolPages.value=="1")
			{
				recordPerPage=lastNumber;
			}else{
				recordPerPage=recordPerPage;
			}*/
		}				
}

function over()
{//alert(333);
//del_over();
//var div = document.createElement("<div name='on_f' class='trans' oncontextmenu='return false;'>");
//var iframe = document.createElement("<iframe  name='on_f' class='trans' style='z-index:98;'>");
//document.getElementById("hiddenTable").appendChild(iframe);
//document.getElementById("hiddenTable").appendChild(div);  
 
}

function del_over()
{
	//var hiddentable=document.getElementById("hiddenTable");
	//var oChild=hiddentable.children;

	// for(var i=oChild.length;i>0;i--)
	// {
	// 	if(oChild[i-1].name=="on_f")
	//	hiddentable.removeChild(oChild[i-1]);
	//	}

}
/*
lijy ע��@20110726 ��jsû����
function detailInfo(useId)
{   //alert(222);
		var path = "f1123_check_detail2.jsp";
		path = path + "?useId=" + useId;
		//var retInfo = window.showModalDialog(path,"","dialogWidth:1000px;dialogHeight:800px;status:no;help:no");
		window.open (path ,"","height=650, width=850,left=50, top=0,toolbar=no,menubar=no, scrollbars=yes, resizable=no, location=no, status=yes"); 
}*/
//����
function attemper(useId,att)
{
		var myPacket = new AJAXPacket("fq034_5.jsp","���ڵ��ȣ����Ժ�......");
		myPacket.data.add("retType","atte");
		myPacket.data.add("orderSelectId",useId);
		att.disabled=true;
		core.ajax.sendPacket(myPacket);
		myPacket=null;
}

//��ȡ�ͻ���������ҵ����Ϣ�б��е��Ӷ������","�ָ�
function ret_value(){	
		var retValue="";  
		if(typeof(document.getElementsByName("retCheckBox")) == "undefined")
		{
			rdShowMessageDialog("û�����ݣ���ı��ѯ����");
			return false;
		}
		else if(typeof(document.getElementsByName("retCheckBox").length) == "undefined")
		{
			if(document.getElementsByName("retCheckBox").checked == true)
			{
				retValue = document.getElementsByName("retCheckBox").value;
			}
		}
		else
		{				
			for(i=0;i<document.getElementsByName("retCheckBox").length;i++)
		  		{  
				   if (document.getElementsByName("retCheckBox")[i].checked==true)
				   { 		
					   retValue=retValue+document.getElementsByName("retCheckBox")[i].value+",";
					   //retValue=retValue+ret_value2(i);
					   //sel=true;
					 }                                                      
							     
		      }							 
		}
		if(retValue.length>0) retValue=retValue.substring(0,retValue.length-1);
			return retValue;
}

function ret_value2(ch){
		var n=100000;	
		var rt="";
		for(var i=0;i<n;i++){
				if(document.getElementById("retCheckBox"+ch+"aa"+i)==null||document.getElementById("retCheckBox"+ch+"aa"+i)=="undefined"){
					return rt;
				}else{
					//if (document.getElementById("retCheckBox"+ch+"aa"+i).checked==true){					
						rt=rt+document.getElementById("retCheckBox"+ch+"aa"+i).value+",";
					//}
				}
		}
		return rt;	
}
function ret_value3(ch){	
		var retValue="";  
		if(typeof(document.getElementsByName(ch)) == "undefined")
		{					
			return "";
		}
		else if(typeof(document.getElementsByName(ch).length) == "undefined")
		{
			if(document.getElementsByName(ch).checked == true)
			{
				retValue = document.getElementsByName(ch).value;
			}
		}
		else
		{				
			for(i=0;i<document.getElementsByName(ch).length;i++)
		  		{  
				   if (document.getElementsByName(ch)[i].checked==true)
				   { 					  
					   retValue=document.getElementsByName(ch)[i].value;
					   return retValue;
					   //sel=true;
					 }                                                      
							     
		      }							 
		}
		return retValue;
}
function ret_value31(ch,ah){	
		var retValue="";  
		if(typeof(document.getElementsByName(ch)) == "undefined")
		{					
			return "";
		}
		else if(typeof(document.getElementsByName(ch).length) == "undefined")
		{
			if(document.getElementsByName(ch).checked == true)
			{
				retValue = document.getElementsByName(ch).value;
			}
		}
		else
		{  				  
				  document.getElementsByName(ch)[ah].checked=true;
		}
		return retValue;
}
function ret_value4(ch){
		var n=100000;	
		var rt="";
		for(var i=0;i<n;i++){
				if(document.getElementById("retCheckBox"+ch+"aa"+i)==null||document.getElementById("retCheckBox"+ch+"aa"+i)=="undefined"){
					return rt;
				}else{									
						rt=rt+"retCheckBoxbb"+ch+"bb"+i+",";				
				}
		}
		return rt;	
}
function ret_value5(){
		var retValue="";  
		if(typeof(document.getElementsByName("retCheckBox")) == "undefined")
		{
			rdShowMessageDialog("û�����ݣ���ı��ѯ����");
			return false;
		}
		else if(typeof(document.getElementsByName("retCheckBox").length) == "undefined")
		{
			if(document.getElementsByName("retCheckBox").checked == true)
			{
				retValue = document.getElementsByName("retCheckBox").value;
			}
		}
		else
		{				
			for(i=0;i<document.getElementsByName("retCheckBox").length;i++)
		  		{  
				   if (document.getElementsByName("retCheckBox")[i].checked==true)
				   { 					  
				   		retValue=retValue+"retCheckBoxb"+i+",";
					    //sel=true;
					 }                                                      
							     
		      }							 
		}
		if(retValue.length>0) retValue=retValue.substring(0,retValue.length-1);
		return retValue;
	
}

function ret_value6(){	
		var retValue="";  
		if(typeof(document.getElementsByName("retCheckBox")) == "undefined")
		{
			rdShowMessageDialog("û�����ݣ���ı��ѯ����");
			return false;
		}
		else if(typeof(document.getElementsByName("retCheckBox").length) == "undefined")
		{
			if(document.getElementsByName("retCheckBox").checked == true)
			{
				retValue = document.getElementsByName("retCheckBox").value;
			}
		}
		else
		{				
			for(i=0;i<document.getElementsByName("retCheckBox").length;i++)
		  		{  
				   if (document.getElementsByName("retCheckBox")[i].checked==true)
				   { 					  
				  		 retValue=retValue+ret_value4(i);
					       //sel=true;
					  }                                                      
							     
		       }							 
		}
		if(retValue.length>0) retValue=retValue.substring(0,retValue.length-1);
		return retValue;		
}

function showInfo2(ch,sh){ 
		var n=100000;
		if(sh==1){
			document.getElementById("trdiv2").style.display="";
			for(var i=0;i<n;i++){		
					if(document.getElementById("aa"+ch+"aa"+i)==null||document.getElementById("aa"+ch+"aa"+i)=="undefined"){
						return;
					}
					document.getElementById("aa"+ch+"aa"+i).style.display="";
					
			}
		}else{
			document.getElementById("trdiv2").style.display="";
			for(var i=0;i<n;i++){	
					if(document.getElementById("aa"+ch+"aa"+i)==null||document.getElementById("aa"+ch+"aa"+i)=="undefined"){
						return;
					}
					document.getElementById("aa"+ch+"aa"+i).style.display="none";	
					document.getElementById("retCheckBox"+ch+"aa"+i).checked=false;
			}
		}
}
function showInfo3(){
	var retValue="";  
		if(typeof(document.getElementsByName("retCheckBox")) == "undefined")
		{
			return false;
		}
		else if(typeof(document.getElementsByName("retCheckBox").length) == "undefined")
		{
			if(document.getElementsByName("retCheckBox").checked == true)
			{
				retValue = document.getElementsByName("retCheckBox").value;
			}
		}
		else
		{				
			var sel=false;
				for(i=0;i<document.getElementsByName("retCheckBox").length;i++)
			  {  
					   if (document.getElementsByName("retCheckBox")[i].checked==true)
					   {      
						 		showInfo2(i,1);
						 }else{
						 		showInfo2(i,0);
				   }                                                      
								     
			  }
			 if(sel==false){
				document.getElementById("trdiv2").style.display = "none";
			 }else{
				document.getElementById("trdiv2").style.display = "";	
			 }
     }  	
}
function showInfo(ch,bt){
	if(markCountFlag!="0"){
		rdShowMessageDialog("���ݶ����������Ӧ��ģ�����");
		$(bt).attr("checked","");
		return;
	}
	var retValue="";  
		if(typeof(document.getElementsByName("retCheckBox")) == "undefined")
		{
			rdShowMessageDialog("û�����ݣ���ı��ѯ����");
			return false;
		}
		else if(typeof(document.getElementsByName("retCheckBox").length) == "undefined")
		{
			if(document.getElementsByName("retCheckBox").checked == true)
			{
				retValue = document.getElementsByName("retCheckBox").value;
			}
		}
		else
		{	
			var sel=false;
			for(i=0;i<document.getElementsByName("retCheckBox").length;i++)
			{
					if (document.getElementsByName("retCheckBox")[i].checked==true)
					{ 
							sel=true;
						  showInfo2(i,1);
							if("<%=opCode%>"=="e083") {
						      getBroadMsg($("#trdiv2 tr:eq(1) td:eq(2)").text());
						  		var getdataPacket = new AJAXPacket("getTerminaleFeeFlag.jsp","���ڻ�����ݣ����Ժ�......");
									getdataPacket.data.add("cfmLogin",$("#broadNo").val());
									core.ajax.sendPacket(getdataPacket,doBroadMsgBack3333);
									getdataPacket = null;
						  }
					}else{
						  showInfo2(i,0);
				  }
			}  				
			 if(sel==false){
				document.getElementById("trdiv2").style.display = "none";
			 }else{
				document.getElementById("trdiv2").style.display = "";	
			 }
    }
    if("<%=opCode%>"=="e083" || "<%=opCode%>" == "m074" || "<%=opCode%>" == "m095"){
    	if($($("#retCheckBox")[ch]).attr("checked")){   	
		    getBroadMoney($("#trdiv tr:eq("+(ch+1)+") td:eq(1)").text().trim());
		  }else{
				$("#backMoney").val("");
		  }
	  }
}

function doBroadMsgBack3333(packet){
var	result = packet.data.findValueByName("result");
	if(result != ""){
		rdShowMessageDialog("�������û����п���ն��豸Ѻ�𷵻���Ѻ�𷵻�����Ϊ��m355-����豸Ѻ�𷵻�����");
	}
}

function getBroadMoney(orderArrayId){
	/* Ϊ�����ӣ���ȡ�˷ѽ�� */
	var myPacket = new AJAXPacket("getBroadMsg.jsp","���ڲ�ѯ�����Ժ�......");
	myPacket.data.add("orderArrayId",orderArrayId);
	myPacket.data.add("opCode","<%=opCode%>");
	core.ajax.sendPacket(myPacket,doBroadMoneyBack);  
	myPacket=null; 
}
function doBroadMoneyBack(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var cash = packet.data.findValueByName("cash");
	/*2014/09/16 10:47:51 gaopeng ����ʷ�չ�ּ��ն˹��������ϵͳ֧���Ż����� ��ȡ����ն˷���*/
	var kdZdFee = packet.data.findValueByName("kdZdFee");
	var kdZd = packet.data.findValueByName("kdZd");
	var functionCode = packet.data.findValueByName("functionCode");
	/*2015/3/31 16:41:48 gaopeng �������*/
	var orderNum = packet.data.findValueByName("orderNum");
	var createAccept = packet.data.findValueByName("createAccept");
	//alert("1622---"+orderNum);
	if(retCode == "0"){
		$("#backMoney").val(cash);
		$("#functionCode").val(functionCode);
		$("#kdZdFee").val(kdZdFee);
		$("#kdZd").val(kdZd);
		$("#orderNum").val(orderNum);
		$("#createAccept").val(createAccept);
	}else{
		rdShowMessageDialog(retCode + " : " + retMsg);
		window.location="/npage/sq034/fq034.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
}
/*lijy add@20110726 for �����װ���õļ���*/
function getDelayFee(){
	document.all.delayFee.value=document.all.useFee.value*document.all.delayMonth.value;
}

function showBroadKdZdBill(printType,DlgMessage,submitCfm){
			
	var pubSmCode = $("#pubSmCode").val();
	var  billArgsObj = new Object();
	var shuilv = 0.17;
	var danjia = 0;
	var shuie = 0;
	var prtLoginAccept = $("#loginAccept").val();
	var custName = $("#custName").val();
	
	var kdZdFee = $("#kdZdFee").val();
	var kdZd = $("#kdZd").val();
	var phoneNo = $("#trdiv2 tr:eq(1) td:eq(2)").text();
	var functionCodeVal = $("#functionCode").val();
	var feeName = "����ն˷���";
	
	
		danjia = Number(kdZdFee) - Number(kdZdFee)*shuilv;
		
		shuie = Number(kdZdFee)*shuilv;
		
 		
			$(billArgsObj).attr("10001","<%=workNo%>");     //����
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005",custName);   //�ͻ�����
			$(billArgsObj).attr("10006","<%=opName%>");    //ҵ�����
			$(billArgsObj).attr("10008",phoneNo);    //�û�����
			$(billArgsObj).attr("10015", "-"+kdZdFee);   //���η�Ʊ���
			$(billArgsObj).attr("10016", "-"+kdZdFee);   //��д���ϼ�
			$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
			/*10028 10029 ����ӡ*/
		  $(billArgsObj).attr("10028","");   //�����Ӫ������ƣ�
			$(billArgsObj).attr("10029","");	 //Ӫ������	
			$(billArgsObj).attr("10030",$("#createAccept").val());   //��ˮ�ţ�--ҵ����ˮ
			$(billArgsObj).attr("10036","<%=opCode%>"); //��������	
			/*2015/04/20 14:48:24 gaopeng ����Э����������û���������������ն˷�Ʊ���ݵĺ� kdZd ��Ϊͳһ���� ����ն˷���*/
			$(billArgsObj).attr("10041", "����ն˷���");           //Ʒ�����
			$(billArgsObj).attr("10042","̨");                   //��λ
			$(billArgsObj).attr("10043","1");	                   //����
			$(billArgsObj).attr("10044",kdZdFee+"");	                //����
			/*10045����ӡ*/
			$(billArgsObj).attr("10045","");	       //IMEI
			$(billArgsObj).attr("10072","2");	//����
			/*�ͺŲ���*/
			$(billArgsObj).attr("10061","");	       //�ͺ�
			$(billArgsObj).attr("10062",shuilv+"");	//˰��
			$(billArgsObj).attr("10063","-"+shuie+"");	//˰��	   
	    $(billArgsObj).attr("10071","6");	//˰��	
	 		$(billArgsObj).attr("10076","-"+danjia);
	 		$(billArgsObj).attr("10074","0"); 
	 		$(billArgsObj).attr("10075","0"); 
	 		$(billArgsObj).attr("10077", "-"+kdZdFee+""); //����ն˽��
 			$(billArgsObj).attr("10078", "kf"); //���Ʒ��
 			$(billArgsObj).attr("10007",pubSmCode);
 			

 			
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;
			
			//��Ʊ��Ŀ�޸�Ϊ��·��
			$(billArgsObj).attr("11215",$("#createAccept").val());   //��ˮ�ţ�--ҵ����ˮ
 			var old_op_date = $("#trdiv2 tr:eq(1) td:eq(4)").text();
 					old_op_date = old_op_date.replace(new RegExp(/(-)/g),'');
					
					old_op_date = jQuery.trim(old_op_date);
 			if(old_op_date.length>6){
 				old_op_date = old_op_date.substring(0,6);
 			}
 			$(billArgsObj).attr("11216",old_op_date); //ԭҵ������			
 			
 			
			$(billArgsObj).attr("11214","HID_PR");	 //�����վݰ�ť== ��ӡ���ӷ�Ʊ  ��ӡֽ�ʷ�Ʊ
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;
			
			
			var loginAccept = prtLoginAccept;
			var path = path +"&loginAccept="+loginAccept+"&opCode="+functionCodeVal+"&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);		

}

function showBroadBill(printType,DlgMessage,submitCfm){
	var printInfo = "";
	var prtLoginAccept = $("#createAccept").val();
	var custName = $("#custName").val();
	var cashPay = $("#backMoney").val();
	var kdZdFee = $("#kdZdFee").val();
	var phoneNo = $("#trdiv2 tr:eq(1) td:eq(2)").text();
	var functionCodeVal = $("#functionCode").val();
	
	var pubSmCode = $("#pubSmCode").val();
	
	printInfo += "<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>" + "|";
	printInfo += "<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>" + "|";
	printInfo += "<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>" + "|";
	printInfo += prtLoginAccept + "|";
	printInfo += custName + "|";
	printInfo += " " + "|";
	printInfo += " " + "|";
	printInfo += $("#broadNo").val() + "|";
	printInfo += " " + "|";
	printInfo += cashPay + "|";
	printInfo += cashPay + "|";
	if(functionCodeVal == "e916"){
		printInfo += "����ƻ�����" + "|";
		printInfo += "�ƶ������ѳ�����" + cashPay + "Ԫ" + "~";
	}else{
		printInfo += "<%=opName%>" + "|";
		printInfo += "����������" + cashPay + "Ԫ" + "~";
	}
	if(pubSmCode == "kf" || pubSmCode == "ki"){
		printInfo += "�ͷ����ߣ�10086" + "|";
	}else{
		printInfo += "�ͷ����ߣ�10050" + "~";
		printInfo += "��ַ��http://www.10050.net" + "|";
	}
	var  billArgsObj = new Object();
	$(billArgsObj).attr("10001","<%=workNo%>");       //����
	$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10005",custName); //�ͻ�����
	$(billArgsObj).attr("10006","<%=opName%>"); //ҵ�����
	$(billArgsObj).attr("10008",phoneNo); //�û�����
	$(billArgsObj).attr("10015", "-"+(Number(cashPay)-Number(kdZdFee))); //���η�Ʊ���(Сд)��
	$(billArgsObj).attr("10016", "-"+(Number(cashPay)-Number(kdZdFee))); //��д���ϼ�

	$(billArgsObj).attr("10036","<%=opCode%>"); //��������	
	$(billArgsObj).attr("10030",prtLoginAccept); //��ˮ��--ҵ����ˮ
	$(billArgsObj).attr("10065", $("#broadNo").val()); //����˺�
	$(billArgsObj).attr("10068", "10086"); 
	$(billArgsObj).attr("10017","*"); //���νɷ��ֽ�
	$(billArgsObj).attr("10072","2");	//����
	$(billArgsObj).attr("11215",prtLoginAccept);   //��ˮ�ţ�--ҵ����ˮ
	$(billArgsObj).attr("10074",$("#id_no").val()); 
	$(billArgsObj).attr("10075",$("#contract_no").val()); 
	$(billArgsObj).attr("10007",$("#smcode").val());  
	/*2014/09/16 11:45:52 gaopeng R_CMI_HLJ_xueyz_2014_1760025@����ʷ�չ�ּ��ն˹��������ϵͳ֧���Ż����� */
	$(billArgsObj).attr("10077",kdZdFee);
	$(billArgsObj).attr("10078",pubSmCode);		
     var path ="";
  /* 
   * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
   * ����ʡ���kg������Ʒ��kh
   */
	if(pubSmCode == "kf" || pubSmCode == "kg" || pubSmCode == "kh" || pubSmCode == "ki"){ //�ƶ����kf
		//path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "��Ʊ��ӡ";
					//��Ʊ��Ŀ�޸�Ϊ��·��
	
		$(billArgsObj).attr("11215",$("#createAccept").val());   //��ˮ�ţ�--ҵ����ˮ
		var old_op_date = $("#trdiv2 tr:eq(1) td:eq(4)").text();
				old_op_date = old_op_date.replace(new RegExp(/(-)/g),'');
		old_op_date = old_op_date.trim();
		if(old_op_date.length>6){
			old_op_date = old_op_date.substring(0,6);
		}
		$(billArgsObj).attr("11216",old_op_date); //ԭҵ������			
 		
		path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "��Ʊ��ӡ";
	}else{ //��ͨ���
		path = "/npage/public/pubBillPrintBroad.jsp?dlgMsg=" + "��Ʊ��ӡ";
	}
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var loginAccept = prtLoginAccept;
	var path = path + "&infoStr="+printInfo+"&loginAccept="+loginAccept+"&opCode=<%=opCode%>&submitCfm=submitCfm&phoneNo=" + phoneNo;
	var ret = window.showModalDialog(path,billArgsObj,prop);
}
function getBroadMsg(phoneNo){
		var getdataPacket = new AJAXPacket("../sq046/fq046_getBroadmsg.jsp","���ڻ�����ݣ����Ժ�......");
		getdataPacket.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(getdataPacket,doBroadMsgBack);
		getdataPacket = null;
}
function doBroadMsgBack(packet){
	
	retCode = packet.data.findValueByName("retcode");
	retMsg = packet.data.findValueByName("retmsg");
	result = packet.data.findValueByName("result");
	if(retCode == "000000"){
		$("#broadNo").val(result);
		getPubSmCode(result);
	}
}

/*2014/04/04 11:02:20 gaopeng ���ù�����ѯ����Ʒ��sm_code*/
function getPubSmCode(kdNo){
		var getdataPacket = new AJAXPacket("/npage/public/pubGetSmCode.jsp","���ڻ�����ݣ����Ժ�......");
		getdataPacket.data.add("phoneNo","");
		getdataPacket.data.add("kdNo",kdNo);
		core.ajax.sendPacket(getdataPacket,doPubSmCodeBack);
		getdataPacket = null;
}
function doPubSmCodeBack(packet){
	retCode = packet.data.findValueByName("retcode");
	retMsg = packet.data.findValueByName("retmsg");
	smCode = packet.data.findValueByName("smCode");
	if(retCode == "000000"){
		$("#pubSmCode").val(smCode);
	}
}


function set_otreson(){
	var sel_val = $("#sel_reasonDescription").val();
	if(sel_val=="6"){
		$("#tr_otreson").show();
	}else{
		$("#tr_otreson").hide();
	}
	$("#textarea_otreson").text("");	
}
</script>
<!--
<style>
*{margin:0; padding:0;}
body{height:100%;} .trans{width:100%;background:ccc;position:absolute;left:0right:0;top:0;bottom:0;-moz-opacity:0.5;filter:alpha(opacity=50);z-index:99;height:100%;}if(!checksubmit(document.frm)) return false ;
</style>  <input class="yyyyMMdd" type="text" id=reasonstart name="reasonstart"  value="" >
-->
</head>
<body onMouseDown="return  hideEvent()" onKeyDown="return hideEvent()">
<div id="operation">
<form name="frm" method="post" action="" onKeyDown="document_onkeydown()">
<!--BUSУ�鷵�ش���-->
<input type="hidden" name="bFCode" value="1">
<input type="hidden" name="bFMsg" value="1">

<%@ include file="/npage/include/header.jsp" %>
	<div id="input">
		<TABLE id="hiddenTable1" style="position:relative">
			<div class="title"><div id="title_zi">��ѯ����</div></div>
			<tr>
	
	    	<td class="blue">����ѡ��</td>
	      <td>
					<select name="quetype" id="quetype" onChange="">
					    		 <option value="1" selected>�ͻ�������</option>
					    		 <option value="2" >ҵ�����</option>
					    		 <option value="3" >���񶩵�</option>
					    		 <!--lijy add@20110726����ǿ��ҵ����Ӳ�ѯ����-->
					         <%if(opCode.equals("e083") ||opCode.equals("e084") ||opCode.equals("e085") || opCode.equals("e086")){%>
					    		 <option value="4" >����˺�</option>
					    		 <%}%>
					 </select>
				</td>	
				<% if(opcodestr.equals("2")){%>
				<td class="blue">����ֵ</td>
				<td>
					<input class="cccccc" type="text" id="quevalue" name="quevalue"  value=""  onkeydown="if(event.keyCode==13){ret_value31('quetype2',0);commitJsp();}">
				</td>
				<td class="blue">��ѯ��ʽ</td>
				<td>
					<input class="" type="radio" id=quetype2 name="quetype2"  value="1" checked >
					������ֵ��ѯ
					<input class="" type="radio" id=quetype2 name="quetype2"  value="2" >
					��ʱ���ѯ
				</td>
				<%			
				}else{
				%>
				<td class="blue">����ֵ</td>
				<td colspan=3>
					<input class="" type="text" id="quevalue" name="quevalue"  value=""  onkeydown="if(event.keyCode==13){commitJsp();}">
				</td>
				<%			
				}
				%>
			</tr>		
			<% if(opcodestr.equals("2")){
			%>
			<tr>			
				<td class="blue">��ʼʱ��</td>
				<td>
					<input class="yyyyMMdd" type="text" id=starttime name="starttime"  value="" onfocus="setday(this)" >										
				</td>
				<td class="blue">����ʱ��</td>
				<td>
					<input class="yyyyMMdd" type="text" id=endtime name="endtime"  value="" onkeydown="if(event.keyCode==13){ret_value31('quetype2',1);commitJsp();}" onfocus="setday(this)">
				</td>
				<td class="blue">����Ա��</td>
				<td>
					<input class="" type="text" id=optName name="optName"  value="" onkeydown="if(event.keyCode==13){ret_value31('quetype2',1);commitJsp();}">
				</td>
			</tr>   
			<%			
		  }
			%>
		</TABLE>
	</div>


	<table><!--��ѯ��ť-->
			<input name="start" type="hidden" class="yyyyMMdd1" id="start" size=15 maxlength="10" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) docheck();"   v_name="��ʼʱ��" style="ime-mode:disabled">
			<input name="end" type="hidden" class="yyyyMMdd1" id="end" size=15 maxlength="10" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) docheck();" v_name="����ʱ��"  style="ime-mode:disabled">
			<input name="phoneNo" type="hidden" class="" id="phoneNo" maxlength="11"    size=15 v_name="�������">
			
			<tr>	
				<td id="footer">
					        <input name="confirm" type="button" class="b_foot" value="��ѯ" onClick="commitJsp()">
	                &nbsp;
	                <input name="reset" type="button" class="b_foot" value="���²�ѯ" onClick="resetJsp()">
	                &nbsp;
	                <input name="back" onClick="window.close()" type="button" class="b_foot" value="�ر�">
				</td>
			</tr>
	</table>

               
		<div id="input">
			<% if(opcodestr.equals("2")){
			%>
			<%			
			}else{	
			%>
			<TABLE>
			<div class="title"><div id="title_zi">������Ϣ</div></div>			 
				<tr>			
					<td class="blue">�ͻ�����</td>
					<td>
						<input class="" type="text" id=custName name="custName"  value="" readonly>
					</td>
					<td class="blue">����Ա��</td>
					<td>
						<input class="" type="text" id=optName name="optName"  value="" readonly>
					</td>
					<td class="blue">����״̬</td>
					<td>
						<input class="" type="text" id=orderStatus name="orderStatus"  value="" readonly>
					</td>
				</tr>		
			</TABLE>
	    <%			
			}	
			%>
		</div>
	
	
			<div id="list">
				<table id="trdiv">
				<div class="title"><div id="title_zi">�ͻ���������ҵ����Ϣ�б�</div></div>
					<tr class="selectBar">				 
			    	<th style="width:5%">ѡ��</td>
						<%  if(opcodestr.equals("2")){  %>
		        <th style="width:10%">�ͻ��������</td>
			      <th style="width:10%">�ͻ�����</td>	
						<th style="width:10%">�ͻ�����������</td>
			      <th style="width:10%">������������</td>
			      <th style="width:10%">ҵ���������</td>
			      <th style="width:5%">����Ʒ</td>
			      <th style="width:10%">��������״̬</td>
			      <th style="width:15%">����ʱ��</td>
			      <th style="width:10%">����Ա��</td>	 
						<th style="width:5%">����</td>
						<%  }else{  %>		
			      <td class="blue">�ͻ�����������</td>
			      <td class="blue">������������</td>
			      <td class="blue">ҵ������</td><!--lijy add@20110726-->
			      <td class="blue">ҵ���������</td>
			      <td class="blue">����Ʒ</td>
			      <td class="blue">��������״̬</td>
			      <td class="blue">����ʱ��</td>
			      <td class="blue">�ͻ��������</td>
						<td class="blue">��ע</td>
						<%  }  %>
					</tr>
					<%  if(orderSelectto!=null&&!orderSelectto.equals("")){ 
							 String aa[]=orderSelectto.split(",");
							 for(int i=0;i<aa.length;i++){
									String aa1=request.getParameter(aa[i]);
									String aa2[]=aa1.split(",-");
		
									String stateStr=aa[6];
									String checkval=aa[2];
									String stateStr2="disabled";
								
									if(stateStr=="13" || stateStr=="20"){
											stateStr2="";
									}else if(opcodestr.equals("1")){
										if(stateStr.equals("11")||stateStr.equals("12")){
											stateStr2="";
										}
									}
		
							 %>					 
							<tr bgcolor="#EEEEEE" height="28" onmouseover="ab_m(this);" onmouseout="out_m(this);" >
							<input class='text2' type='checkbox' id='retCheckBox' onclick='showInfo(\""+a+"\",this)' name='retCheckBox' value="+checkval+" "+stateStr2+">
							<td nowrap><div align='center'>&nbsp;<input class='text2' type='checkbox' id='retCheckBox' onclick='showInfo(<%=i %>,this)' name='retCheckBox' value='<%=checkval %>' <%=stateStr2 %>></a></div></td>
							<td nowrap><div align='center'>&nbsp;<%=aa2[2] %>
							<td nowrap><div align='center'>&nbsp;<%=aa2[3] %></a></div></td>
							<td nowrap><div align='center'>&nbsp;<%=aa2[4] %></a></div></td>
							<td nowrap><div align='center'>&nbsp;<%=aa2[5] %></a></div></td>
							<td nowrap><div align='center'>&nbsp;<%=aa2[9] %></a></div></td>
							<td nowrap><div align='center'>&nbsp;<%=aa2[7] %></a></div></td>
							<td nowrap><div align='center'>&nbsp;<%=aa2[0] %></a></div></td></tr>
						 <%  }}  %>
				</table>
		
				<div  id="operation_pagination">
		     	[<a href="#" onclick="firstPage()"> ��ҳ</a>]
					[<a href="#" onclick="pageUp()" > ��һҳ</a>]
					[<a href="#" onclick="pageDown()"> ��һҳ</a>]
					[<a href="#" onclick="lastPage()" > βҳ</a>]
					&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;<input readonly type="text" size="4" class="likebutton2" name="tatolPages" value="1">ҳ
					&nbsp; ��ǰ��&nbsp;<input  readonly type="text" size="4" class="likebutton2" name="nowPage" value="1">ҳ 
					&nbsp;&nbsp;ת����&nbsp;<input type="text" size="4" name="jump" value="1" onkeydown="if(event.keyCode==13)query_jump()">ҳ
					&nbsp<input type="button"class="b_text" name="jump_button" value="��ת" onclick="query_jump();"/>
					&nbsp;&nbsp;��&nbsp;<input type="text" readonly size="4" class="likebutton2" name="recodeNum" value="0">����¼
				</div>	
		
				<table id="trdiv2" style="display:none">
				<div class="title"><div id="title_zi">���񶨵���Ϣ�б�</div></div>
		     <tr class="selectBar">				 
					 <th style="width:15%">���񶨵�</td>
					 <th style="width:20%">ҵ���ʶ</td>
					 <th style="width:15%">ҵ������</td>
					 <th style="width:10%">�ɷ�״̬</td>
					 <th style="width:10%" style="display:none">��ַ</td>
					 <th style="width:15%">����ʱ��</td>
					 <th style="width:15%">�ͻ���������</td>                 	  
		     </tr>
						 <% 
						 if(serverSelectto!=null&&!serverSelectto.equals("")){  
							  String aa[]=serverSelectto.split(",");
							  int k=-1,j=-1;
							  String sk="";					 
								for(int i=0;i<aa.length;i++){
									if(aa[i]!=null){
										 j++;
										 String aa3[]=aa[i].split("bb");
										 if(!sk.equals(aa3[1])){
											k++;
											j=0;
											sk=aa3[1];
										 }								 							
										 String aa1=request.getParameter(aa[i]);
										 String aa2[]=aa1.split(",-");
							 System.out.println("kkkkkkkkkkkkkkkk----------------"+k+"jjjjjjjjjjjjjjjjjjjjjj-----------"+j);
							 %>
							 <tr bgcolor="#EEEEEE" height="28" onmouseover="ab_m(this);" onmouseout="out_m(this);" id='aa<%=k%>aa<%=j%>' name='aa<%=k%>aa<%=j%>' >
							<td nowrap><input class='text2' type='hidden' value='<%=aa2[1] %>' id='retCheckBox<%=k%>aa<%=j%>' onclick='' name='retCheckBox<%=k%>aa<%=j%>'><div align='center'>&nbsp;<%=aa2[1] %></a></div></td>
							<td nowrap><div align='center'>&nbsp;<%=aa2[2] %></a></div></td>
							<td nowrap><div align='center'><%=aa2[3] %></a></div></td>
							<td nowrap><div align='center'>&nbsp;<%=aa2[4] %></a></div></td>
							<td nowrap style="display:none"><div align='center'>&nbsp;<%=aa2[5] %></a></div></td>
							<td nowrap><div align='center'>&nbsp;<%=aa2[6] %></a></div></td>					
							<td nowrap><div align='center'>&nbsp;<%=aa2[7] %></a></div></td>
							</tr>
						 <%  }
						 		}
						 	}  
						 %>
				</table>
		
		<!--lijy add@20110726 for �������ʱ���˷���Ϣ����ʾ-->
		<%if(opCode.equals("e083") || opCode.equals("m074") || opCode.equals("m095")){%>
		<div class="title" <%if(opCode.equals("m074") || opCode.equals("m095")){%>style="display:none"<%}%>><div id="title_zi"><%=opName %>�˷���Ϣ</div></div>
		<div id="backPayDiv" <%if(opCode.equals("m074") || opCode.equals("m095")){%>style="display:none"<%}%>>
			<table>
				<tr>
					<td width="25%" class="blue">���˽��</td>
					<td><input class="" type="text" id=backMoney name="backMoney"  value="" readonly></td>
				</tr>
			</table>	
		</div>
	  <%}%>
	  
		<!--lijy add@20110726 for �������ʱ���ɷ���Ϣ����ʾ-->
		<%if(opCode.equals("e085")){%>
		<div class="title"><div id="title_zi"><%=opName %>�ɷ���Ϣ</div></div>
		<div id="payDiv">
			<table>
				<td>����ռ�÷�</td>
				<td><input class="" type="text" id="useFee" name="useFee"  value="100" >/��</td>
				<td>��װʱ��</td>
				<td><input class="" type="text" id=delayMonth name="delayMonth"  onblur="getDelayFee()" >��</td>
				<td>��װ����</td>
				<td><input class="" type="text" id=delayFee name="delayFee"  readonly></td>
			</table>
		</div>
		 <%}%>
		<% 
		//if(!opcodestr.equals("2")){		
		%>
		<div class="input">
				<table>
					<tr style="display:none">			
						<td class="blue"><%=opName %>ԭ�����</td>
						<td>				
							<select name="reasonType">
						          <wtc:qoption name="sPubSelect" outnum="2">
						          	<!--lijy change the sql@20110819 ��Ϊԭ�ȵ�sqlֻ�ܲ�ѯ������ԭ�����ԭ�ȵ�sql�� select change_reason,reason_name from sServOrderChangeReason where change_reason >= 0 and CHANGE_REASON = '3'-->
						            <wtc:sql>select change_reason,reason_name from sServOrderChangeReason where change_reason >= 0 and CHANGE_REASON = <%=sOpType%> </wtc:sql>
						          </wtc:qoption>
						  </select>	
							<!--<select name="reasonType2">
						          <wtc:qoption name="sPubSelect" outnum="2">
						            <wtc:sql>select change_type,change_name from sOrderArrayChangeType where change_type > 2 Order By change_type</wtc:sql>
						          </wtc:qoption>    
						   </select>-->	
						</td>
						<td class="blue">&nbsp;</td>
						<td>
							&nbsp;
						</td>
				  </tr>  
				  
				  <tr  id="tr_otreson_1" style="display:none" >
				  	<td class="blue"><span  class="red">*ԭ����ϸ����</span></td>
				  <td colspan="3">
								<select id="sel_reasonDescription" style="width:300px;" name="sel_reasonDescription" onchange="set_otreson()">
										<option value="">--��ѡ��--</option>
								    <option value="1">ѡ���ʷ�/��ַ/��װ��/èѺ��/����</option>
								    <option value="2">�ͻ����ڲ���װ</option>
								    <option value="3">�ͻ���������������ʷ��ײͻ��û���װ����ַ�ȣ�</option>
								    <option value="4">ϵͳ�쳣</option>
								    <option value="5">�ʹ�������ʵ��С���˿����ݲ���</option>
								    <option value="6">����ԭ��</option>
								</select>
						</td>
				  </tr>
				  
				  <tr id="tr_otreson" style="display:none">
				  	<td colspan="4" >
				  			<textarea id="textarea_otreson" name="textarea_otreson"  cols="140" rows="3" ></textarea>
				  			<font class="orange">ע����ѡ����ԭ������ȷд������ԭ��</font>
				  	</td>
				  </tr>
					<% 
					if(opcodestr.equals("4")){		
					%>
					<tr>			
							<td class="blue"><span  class="red">*Ԥ�ƿ�װʱ��</span></td>
							<td>
								<input class="yyyyMMdd" type="text" id=reasonstart name="reasonstart"  value="<%=dateStr %>" >
							</td>
							<td class="blue"><span  class="red">*��װ����ʱ��</span></td>
							<td>
								<input class="yyyyMMdd" type="text" id=reasonend name="reasonend"  value="<%=dateStr %>" >
							</td>
				  </tr>
					<% 
					}	
					%>
				</table>
			</div>
				<% 
					//}	
					%>
		</div>	
	
	
		<table>
			<tr>
				<td id="footer">
					<%  if(opcodestr.equals("2")){  %>
					<input class="b_foot" name=confirm  type=button index="8" value="����" onclick="commitJsp3('q034','����')" onkeydown="if(event.keyCode==13){}">
					<input class="b_foot" name=confirm  type=button index="8" value="�˳�" onclick="window.close()" onkeydown="if(event.keyCode==13){}">
				
					 <%  }else{  %>
				  <input class="b_foot" name=confirm  type=button index="8" value="<%=opName %>" onClick="commitJsp3()"  onkeydown="if(event.keyCode==13){}">
		
				  <%  }  %>
				</td>
			</tr>
		</table>
			 
		<input type="hidden" name="workNo" id="workNo" value="<%=workNo%>">
		<input type="hidden" name="workName" id="workName" value="">
		<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
		<!--lijy add @20110726-->
		<input type="hidden" name="opName" id="opName" value="<%=opName%>">
		<!--lijy add @20110726 end-->
		<input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
		<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
		<input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">
		<input type="hidden" name="phones" id="phones" value="">
		<input type="hidden" name="backFlag_type" id="backFlag_type" value="0">
		<input type="hidden" name="funtype" id="funtype" value="0">
		<input type="hidden" name="opcodestr" id="opcodestr" value="<%=opcodestr%>">
		<input type="hidden" name="orderSelectto" id="orderSelectto" value="">
		<input type="hidden" name="serverSelectto" id="serverSelectto" value="">
		<input type="hidden" name="quevalueto" id="quevalueto" value="">
		<input type="hidden" name="quetypeto" id="quetypeto" value="">
		<input type="hidden" name="quetype2to" id="quetype2to" value="">
		<input type="hidden" name="starttimeto" id="starttimeto" value="">
		<input type="hidden" name="endtimeto" id="endtimeto" value="">
		<input type="hidden" name="optNameto" id="optNameto" value="">
		<input type="hidden" name="hiddenTable" id="hiddenTable" value="">
		<input type="hidden" name="_orderID"  value="">
		<input type="hidden" name="_orderArrayID" value="">
		<input type="hidden" name="currentYear" class="yyyyMMdd" id="currentYear" value="<%=currentYear%>"  v_name="��ǰʱ��">
		<input type="hidden" name="loginAccept" id="loginAccept" value="<%=printAccept%>">
		<input type="hidden" name="broadNo" id="broadNo" value="">
		<input type="hidden" name="functionCode" id="functionCode" value="" />
		<!-- 2014/04/04 11:15:23 gaopeng Ʒ��sm_code -->
		<input type="hidden" name="pubSmCode" id="pubSmCode" value="" />
		<input type="hidden" name="kdZdFee" id="kdZdFee" value="" />
		<input type="hidden" name="kdZd" id="kdZd" value="" />
		
		<input type="hidden" name="id_no" id="id_no" value="" />
		<input type="hidden" name="contract_no" id="contract_no" value="" />
		<input type="hidden" name="smcode" id="smcode" value="" />
		<input type="hidden" name="username" id="username" value="" />
		<input type="hidden" name="orderNum" id="orderNum" value="" />
		<input type="hidden" name="createAccept" id="createAccept" value="" /><!-- ��ҵ����ˮ -->
		

	</div>
</div>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</div>
</body>
</html>
