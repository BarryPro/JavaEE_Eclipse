<%
    /********************
     version v2.0
     ������: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%
	//String payType = request.getParameter("payType");/**�ɷ����� payType=BX �ǽ��� payType=BY �ǹ���**/
	//System.out.println("-----------------payType----------------------------->"+payType);
	S1100View callView = new S1100View();
	String xx_money = "";
	String opCode = "4130";
	String opName = "��ؽɷ�";
	String regionCode1 = (String)session.getAttribute("regCode");
	String work_name = (String)session.getAttribute("workName");
	System.out.println("regionCode1----------------------->"+regionCode1);
	
			
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String[][] otherInfoSession = (String[][])arrSession.get(2);
	String[][] pass = (String[][])arrSession.get(4);
	
	String loginNo = baseInfoSession[0][2];
	String loginName = baseInfoSession[0][3];
	String powerCode= otherInfoSession[0][4];
	String orgCode = baseInfoSession[0][16];
	String ip_Addr = request.getRemoteAddr();
	
	//boolean isDz = ("11".equals(regionCode1)||"08".equals(regionCode1))?true:false;
	boolean isDz=true;
	
	String regionCode = orgCode.substring(0,2);
	String regionName = otherInfoSession[0][5];
	String loginNoPass = pass[0][0];
	
	String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];

	List al = null;
	String[][] idCodeData = new String[][]{};
	String curDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

	int		isGetDataFlag = 1;	//0:��ȷ,��������. add by yl.
	String errorMsg ="";
	String tmpStr="";

	
	StringBuffer  insql = new StringBuffer();
	
dataLabel:
	while(1==1){	
		insql.delete(0,insql.length());
		insql.append("select trim(TYPE_CODE),trim(TYPE_COdE)||'-->'||TYPE_NAME from oneboss.sObCustIdType ");
		insql.append(" order by TYPE_CODE ");
		String sql = insql.toString();
		%>
		<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode1%>" outnum="4" retcode="retCode" retmsg="retMsg">
			<wtc:param value="<%=sql%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
		<%
		System.out.println("�������� ------------------------------>"+result.length);
		if( result == null ){
			isGetDataFlag = 2;
			break dataLabel;
		}		
		idCodeData = result;
	
		
		isGetDataFlag = 0;
		break;
 	}	

	 errorMsg = "ȡ���ݴ���:"+Integer.toString(isGetDataFlag);	    
	 System.out.println(errorMsg);
%>

<%if( isGetDataFlag != 0 ){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<%=errorMsg%>");
	window.close();
	window.opener.focus();
//-->
</script>
<%}%>

<html>
	<head>
		<title>��ؽɷ�</title>
	</head>

	<body>
		<script language="JavaScript">
			//����Ӧ��ȫ�ֵı���
			var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
			var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
			var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�
			var dynTbIndex=1;				//���ڶ�̬�����ݵ�����λ��,��ʼֵΪ1.���Ǳ�ͷ
			var TIMEOUTNUM = 35;
			
			var oprType_Add = "a";
	    var oprType_Upd = "u";
	    var oprType_Del = "d";
	    var oprType_Qry = "q";

    	core.loadUnit("debug");
			core.loadUnit("rpccore");
			onload=function()
			{	
				init();	
				//core.rpc.onreceive = doProcess;	
		
			}

	
			function init()
			{
			
				document.form4130.confirm.disabled = true;
				document.form4130.handFee.value = "0.00";
				
				document.form4130.IDItemRange.focus();
			}
			function doProcess(packet){
				//ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
				error_code = packet.data.findValueByName("errorCode");
				error_msg =  packet.data.findValueByName("errorMsg");
				verifyType = packet.data.findValueByName("verifyType");
				backArrMsg = packet.data.findValueByName("backArrMsg");
				backArrMsg1 = packet.data.findValueByName("backArrMsg1");
				xx_money = packet.data.findValueByName("xx_money");
				chinaFee = packet.data.findValueByName("chinaFee");
				//alert(chinaFee)
				//rdShowMessageDialog("errorCode="+error_code+"<---");
				//rdShowMessageDialog("errorMsg="+error_msg+"<---");
				//rdShowMessageDialog("backArrMsg="+backArrMsg+"<---");
				//rdShowMessageDialog("backArrMsg1="+backArrMsg1+"<---");
				self.status="";
				if(verifyType=="phoneno"){
					if( parseInt(error_code) == 0 ){
						if( backArrMsg!=null&&backArrMsg.length > 0 ){
						document.form4130.busyAccept.value = backArrMsg[0][0];
						var CustNameTem = backArrMsg[0][1].trim();
						
						if(CustNameTem.length>0){
								document.form4130.CustName.value= CustNameTem.substr(0,1);
								for(var cNum = 1;cNum<CustNameTem.length;cNum++){
									document.form4130.CustName.value+="*";
								}
						}
						document.form4130.CustNameFP.value=backArrMsg[0][1].trim();
						document.form4130.PayAmount.value = parseInt(backArrMsg[0][2])/1000; //��-->Ԫ
						document.form4130.Balance.value = parseInt(backArrMsg[0][3])/1000;   //��-->Ԫ 
					  }
					  var accountNo="";
					  if( backArrMsg1!=null&&backArrMsg1.length > 0  ){
					  	//����̬���
					  	dyn_deleteAll();
					  	for(var i=0; i< backArrMsg1.length; i++){
					  		var R2Tem = backArrMsg1[i][1].trim();
					  		var R2Tem1 = "";
					  		if(R2Tem.length>0){
									R2Tem1= R2Tem.substr(0,1);
									for(var cNum = 1;cNum<R2Tem.length;cNum++){
										R2Tem1+="*";
									}
								}
					  		queryAddAllRow(backArrMsg1[i][0],R2Tem1,parseInt(backArrMsg1[i][2])/1000,parseInt(backArrMsg1[i][3])/1000);
					  		if(accountNo==""){
									accountNo=backArrMsg1[i][0];
									//rdShowMessageDialog("accountNo="+accountNo);
								}
					    }
					  }
						document.form4130.accountNo.value=accountNo; 
					  var tem1 = (parseFloat(1*document.form4130.PayAmount.value - 1*document.form4130.Balance.value - 1*document.form4130.handFee.value)*100 + 0.5).toString();
					  var tem2=tem1;
					  if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
		        	document.form4130.mustPayFee.value=(tem2/100).toString();
		
					  
					  if( document.form4130.mustPayFee.value < 0.00 ){
					  	document.form4130.mustPayFee.value = 0.00;
					  }
					  document.form4130.IDType.disabled = true;
					  document.form4130.IDItemRange.disabled = true;
					  document.form4130.confirm.disabled = false;
											
					}
					else{
						rdShowMessageDialog("<br>�������:["+error_code+"]</br>������Ϣ:["+error_msg+"]");
						document.form4130.IDItemRange.focus();
						return false;
					}
				}
				else if(verifyType=="confirm"){
					error_code = packet.data.findValueByName("errorCode");
					error_msg = packet.data.findValueByName("errorMsg");
					if( parseInt(error_code) == 0 ){ 
					  //rdShowMessageDialog(error_msg+",���ʵ��("+error_code+")");
					  if( backArrMsg.length > 0 ){
						document.form4130.busyAccept.value = backArrMsg[0][0];
						document.form4130.tmpSendAccept.value = backArrMsg[0][1];
						document.form4130.tmpBackAccept.value = backArrMsg[0][2];
					  }
					 rdShowMessageDialog("���״���ɹ�,����ҵ����ˮ:"+backArrMsg[0][0]+"�����𷽽�����ˮ��"+backArrMsg[0][1]+","+backArrMsg[0][2]+"��ӡƾ����");
					 var ret=rdShowConfirmDialog("�ɷѳɹ����Ƿ��ӡ��Ʊ��");
					 if(typeof(ret)!="undefined")
					 {
					 		if(ret==1)                      //����Ͽ�
					 		{
					 			 //���ô�ӡ
					 			printBill7672(xx_money);                          
					 		}
					 		//else{  ȡ�� ��ʡ�����ڵ��üƷѷ���
					 			//printCancleDZ(xx_money);       
					 		//}
					 }
					}else{
						rdShowMessageDialog("<br>�������:["+error_code+"]</br>������Ϣ:["+error_msg+"]");			
						return false;
					}
		
				}
			}
			
			//��ӡ��Ʊ
			function printBill7672(xx_money)
			{
				 var phoneNo = document.form4130.IDItemRange.value; 				//�ֻ���
				 var cust_name = document.form4130.CustNameFP.value;					//�û�����
				 var pay_money = document.form4130.payMoney.value;					//���ѽ��		
				 var prepay_money = document.form4130.Balance.value;				//�ɷѽ��	
				 var accept_no = document.form4130.busyAccept.value;				//����ҵ����ˮ
				 var work_no = document.form4130.loginNo.value;						//��½����
				 var busi_type = '��ؽɷ�';
				 var send_accept = document.form4130.tmpBackAccept.value;			//���𷽽�����ˮ
				 var back_accept = document.form4130.tmpBackAccept.value;
				 var cur_date = document.form4130.totalDate.value;
				 var infoStr = '';
				 var base_fee=parseFloat(prepay_money)+parseFloat(pay_money);  	                                           
				 var opNote=document.form4130.opNote.value;
				 infoStr+=work_no+"  "+send_accept+"      "+busi_type+"|";//����                                                 
			  	 infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
				 infoStr+= '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
				 infoStr+= '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
				 infoStr+= cust_name+"|";//�û�����                                                     
				 infoStr+= " "+"|";//��ͬ����                                                          
				 infoStr+= phoneNo+"|";//�ƶ�����                                              
				 infoStr+=" "+"|";//�û���ַ
				 infoStr+=" "+"|";
				 //alert(xx_money)
				 infoStr+=chinaFee+"|";//�ϼƽ��(��д)
				 infoStr+=xx_money+"|";//Сд 
				 infoStr+=" "+"|"; 
				 infoStr+="<%=work_name%>"+"|";//��Ʊ��
				 
				 infoStr+=" "+"|";//�տ���				 
				 infoStr+=opNote+"|";//��ע			 
				 var dirtPage="";          
				 dirtPate = "/npage/s4000/s4130.jsp?activePhone="+phoneNo+"&opCode=4130&opName=��ؽɷ�"; 
				 
				 <%if(isDz){ %>
				 
				 var ret2=rdShowConfirmDialog("ѡ���ӡ��Ʊ��ʽ(ѡ��ȷ������ӡ���ӷ�Ʊ����ȡ������ӡֽ�ʷ�Ʊ)");
				 if(typeof(ret2)!="undefined")
					 {
					 		if(ret2==1)                      //����Ͽ�
					 		{
					 			 //���ô�ӡ
					 			location="/npage/s4000/hljCrmPDPrintPublicDZ.jsp?retInfo="+infoStr+"&op_code=4130&loginAccept="+send_accept+"&dirtPage="+codeChg(dirtPate);
					 		}else{
					 			location="/npage/s4000/hljCrmPDPrintPublic.jsp?retInfo="+infoStr+"&op_code=4130&loginAccept="+send_accept+"&dirtPage="+codeChg(dirtPate);	
					 		}
					 }
				<%}else{%>
								location="/npage/s4000/hljCrmPDPrintPublic.jsp?retInfo="+infoStr+"&op_code=4130&loginAccept="+send_accept+"&dirtPage="+codeChg(dirtPate);	
				<%}%>
				 
			}
			//��ӡ��Ʊ
			function printCancleDZ(xx_money)
			{
				 var phoneNo = document.form4130.IDItemRange.value; 				//�ֻ���
				 var cust_name = document.form4130.CustNameFP.value;					//�û�����
				 var pay_money = document.form4130.payMoney.value;					//���ѽ��		
				 var prepay_money = document.form4130.Balance.value;				//�ɷѽ��	
				 var accept_no = document.form4130.busyAccept.value;				//����ҵ����ˮ
				 var work_no = document.form4130.loginNo.value;						//��½����
				 var busi_type = '��ؽɷ�';
				 var send_accept = document.form4130.tmpBackAccept.value;			//���𷽽�����ˮ
				 var back_accept = document.form4130.tmpBackAccept.value;
				 var cur_date = document.form4130.totalDate.value;
				 var infoStr = '';
				 var base_fee=parseFloat(prepay_money)+parseFloat(pay_money);  	                                           
				 var opNote=document.form4130.opNote.value;
				 infoStr+=work_no+"  "+send_accept+"      "+busi_type+"|";//����                                                 
			  	 infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
				 infoStr+= '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
				 infoStr+= '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
				 infoStr+= cust_name+"|";//�û�����                                                     
				 infoStr+= " "+"|";//��ͬ����                                                          
				 infoStr+= phoneNo+"|";//�ƶ�����                                              
				 infoStr+=" "+"|";//�û���ַ
				 infoStr+=" "+"|";
				 //alert(xx_money)
				 infoStr+=chinaFee+"|";//�ϼƽ��(��д)
				 infoStr+=xx_money+"|";//Сд 
				 infoStr+=" "+"|"; 
				 infoStr+="<%=work_name%>"+"|";//��Ʊ��
				 
				 infoStr+=" "+"|";//�տ���				 
				 infoStr+=opNote+"|";//��ע			 
				 var dirtPage="";          
				 dirtPate = "/npage/s4000/s4130.jsp?activePhone="+phoneNo+"&opCode=4130&opName=��ؽɷ�"; 
				 
				 
					//����ȡ�����߽ӿ�bs_sEInvCancel
				 location="/npage/s4000/hljCrmPDCancleDZ.jsp?retInfo="+infoStr+"&op_code=4130&loginAccept="+send_accept+"&dirtPage="+codeChg(dirtPate);
					 		
					 
				 
			}
					
			function codeChg(s)
			{
			  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
			  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
			  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
			  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
			  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
			  return str;
			}

			function dyn_deleteAll()
			{
				//������ӱ��е�����
				for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ������
				{
			  	document.all.dyntb.deleteRow(a+1);
				}
			 	
			}	
			
			function queryAddAllRow(no,name,should,prepay)
			{
				var tr1="";
				var i=0;
				var tmp_flag=false;
				var exec_status="";
		
			  
				tr1=dyntb.insertRow();	//ע��:����ı������������һ��,������ɿ���.yl.
				tr1.id="tr"+dynTbIndex;
				  	             
				tr1.insertCell().innerHTML = '<div align="center"><input id=R1    type=text   align="center"  value="'+ no+'"  readonly></input></div>';
				tr1.insertCell().innerHTML = '<div align="center"><input id=R2    type=text     value="'+ name+'"  readonly></input></div>';      
				tr1.insertCell().innerHTML = '<div align="center"><input id=R3    type=text     value="'+ should+'"  readonly></input></div>';
				tr1.insertCell().innerHTML = '<div align="center"><input id=R4    type=text     value="'+ prepay+'"  readonly></input></div>';

				dynTbIndex++;
			}
			
			function call_IDQRY()
			{
				
				var sqlBuf="";
				//var myPacket = new RPCPacket("s4130_rpc_id.jsp","������֤�ͻ���ʶ�����Ժ�......");
				
				with(document.form4130)
		     	{
					if ( IDType.value == "01" )
					{
						
					}
					if ( IDType.value == "04" )
					{
						if ( IDItemRange.value.length > 20 )
						{
							rdShowMessageDialog("VIP����ֻ����20λ֮�ڣ�");
			 	          	IDItemRange.focus();
			 	          	return false;
						}
					}
				}
				var myPacket = new AJAXPacket("s4130_rpc_id.jsp","����ȷ�ϣ����Ժ�......");
				myPacket.data.add("verifyType","phoneno");
				myPacket.data.add("loginNo",document.form4130.loginNo.value);
				myPacket.data.add("orgCode",document.form4130.orgCode.value);
				myPacket.data.add("opCode","4133");
				myPacket.data.add("totalDate",document.form4130.totalDate.value);
				myPacket.data.add("IDType",document.form4130.IDType.value);
				myPacket.data.add("IDItemRange",document.form4130.IDItemRange.value);
				core.ajax.sendPacket(myPacket);
        		myPacket = null;
			}
			
			
			function commitJsp()
			{
				if(!checkPayMoney(document.form4130.payMoney))
				{  
				   return false;
				}
		
				if(document.form4130.payMoney.value > 10000)
				{
				    if(rdShowConfirmDialog('�ɷѳ���10000Ԫ��ȷ��Ҫ�ύ��Ϣ��')==1)
		            {
		            }
		            else
		            {
		                return false
		            }
				}
		//rdShowMessageDialog("OK3");
				if( !judge_valid() )
				{
					return false;
				}
		 		tmpStr = "��ؽɷ� " + ",�ͻ���ʶ:"+document.all.IDItemRange.value+"";
			 	
		 		document.form4130.opCode.value="4130";	
				document.form4130.opNote.value =  tmpStr; 
		
		
				var myPacket = new AJAXPacket("s4130_rpc_confirm.jsp?op_note="+document.form4130.opNote.value+"&prepay_money="+document.form4130.payMoney.value,"����ȷ�ϣ����Ժ�......");
				myPacket.data.add("verifyType","confirm");
				myPacket.data.add("loginNo",document.form4130.loginNo.value);
				myPacket.data.add("orgCode",document.form4130.orgCode.value);
				myPacket.data.add("opCode","4130");
				myPacket.data.add("totalDate",document.form4130.totalDate.value);
				myPacket.data.add("IDType",document.form4130.IDType.value);
				myPacket.data.add("IDItemRange",document.form4130.IDItemRange.value);
				myPacket.data.add("payMoney",parseFloat(document.form4130.payMoney.value)*1000 );
				myPacket.data.add("handFee",parseFloat(document.form4130.handFee.value)*1000 );
				myPacket.data.add("busyAccept",document.form4130.busyAccept.value);
				myPacket.data.add("accountNo",document.form4130.accountNo.value);
				core.ajax.sendPacket(myPacket);
		    	myPacket = null; 		
			}
	
	
	function checkPayMoney(obj)
	{
		var re = /^(\d)+$/;
		
		 var m = re.exec(obj.value);
	 if (m == null) {
			rdShowMessageDialog("����������Ǹ�����ֵ,��λ��Ԫ��");
			obj.value="";
			obj.focus();
			return false;
		} 
		return true;
	}
	
	function resetJsp()
	{

	 with(document.form4130)
	 {
		IDItemRange.value	= "";
		
		busyAccept.value	= "";
		CustName.value	= "";
		CustNameFP.value="";
		PayAmount.value	= "";
		Balance.value	= "";
		
		handFee.value	= "0.00";
		mustPayFee.value	= "";
		PayAmount.value	= "";
		payMoney.value  = "";
		opNote.value = "";


	 }
	
		dyn_deleteAll();
		reset_globalVar();	

	  document.form4130.IDType.disabled = false;
	  document.form4130.IDItemRange.disabled = false;
	  document.form4130.confirm.disabled = true;
	  
	  document.form4130.IDItemRange.focus();		
	}
	
	function reset_globalVar()
	{
	  dynTbIndex=1;							
	}
	
	function doValid()
	{

		with(document.form4130)
		{
						
		}
		
		return true;
	}
	
	function judge_valid()
	{
		//1.��鵥������
	 	if( !doValid() ) return false;
	 	/*
	 	if(!checkElement("handFee")) return false;
	 	if(!checkElement("payMoney")) return false;
	 	*/
		if( document.form4130.payMoney.value <= 0 ){
			rdShowMessageDialog("������>0");
			document.form4130.payMoney.focus();
			return false;
		}
		return true;
	}
		</script>
		<FORM method=post name="form4130">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">��ؽɷ�</div>
			</div>
			<TABLE cellSpacing="0">
        		<TR>
        			<td  class="blue">���д���</td>
					<td > 
						<input name="regionName" type="text" id="regionName" value="<%=regionName%>" maxlength="2" disabled> 
            		</td>
        			<td  class="blue">��������</td>
					<TD>
						<input name="opType" type="text" id="opType" value="�ɷ�" disabled>
					</TD>
        		</TR>
        		<TR>
        			<td  class="blue">�ͻ���ʶ����</td>
					<TD>
						<select name="IDType" id="IDType">
		                <%
		        		for(int i=0;i<idCodeData.length; i++){
							out.println("<option class='button' value='"+idCodeData[i][0]+"'>"+idCodeData[i][1]+"</option>");
						}
				  		%>            
		              	</select>
         			</TD>
        			<td  class="blue">�ͻ���ʶ</td>
					<TD>
        				<input name="IDItemRange" type="text"   class="button" id="IDItemRange" index="1" maxlength="20" value="" v_must=1 v_type="mobphone" v_minlength=11  v_name="�ͻ���ʶ">
        				<input name="IDQRY"       type="button" class="b_text" index="2" id="IDQRY" value="��֤" onClick="call_IDQRY()">
          			</TD>
				</TR>
          
				<TR>
					<td  class="blue">�ͻ�����</td>
					<TD colspan="3">
						<input name="CustName" type="text" id="CustName" disabled>
						<input name="CustNameFP" type="hidden" id="CustNameFP" disabled>
					</TD>
				</TR>
				<TR>
					<td  class="blue">Ӧ���ܽ��</td>
					<TD>
						<input name="PayAmount" type="text" id="PayAmount" disabled>
					</TD>
					<td  class="blue">Ԥ�������</td>
					<TD>
						<input name="Balance" type="text" id="Balance" disabled>
					</TD>
				</TR>
		        <TR>
		        	<td  colspan="4" class="blue">
	        			<table width="98%" border="1" id="dyntb" >
			        		<tr> 
				              <td class=orange align="center"> �ʺ�</td>
				              <td class=orange align="center"> �ʻ�����</td>
				              <td class=orange align="center"> �ʻ�Ӧ�ɽ��</td>
				              <td class="orange" > �ʻ�Ԥ�����</td>
			            	</tr>
							<tr id="tr0" style="display:none"> 
			                  <td><div align="center"> 
			                      <input type="text" align="left" id="R1" value="">
			                    </div></td>
			                  <td><div align="center"> 
			                      <input type="text" align="left" id="R2" value="">
			                    </div></td>
			                  <td><div align="center"> 
			                      <input type="text" align="right" id="R3" value="">
			                    </div></td>
			                  <td><div align="center"> 
			                      <input type="text" align="right" id="R4" value="">
			                    </div></td>                                        
	            			</tr>
	            		</table>
         			</td>
        		</TR>
     
				<TR>
					<td  class="blue">������</td>
					<TD colspan="3">
				  		<input name="handFee" type="text" id="handFee" maxlength="9" disabled>
				  	</TD>
				</TR>
		        <tr>
		        	<td  class="blue">����Ӧ����</td>
					<TD colspan="3">
		          		<input name="mustPayFee" type="text" id="mustPayFee" maxlength="9" disabled>
		         	</TD>
		        </tr>
					<TR>
						<td  class="blue">�ɿ���</td>
					<TD colspan="3">
						<input name="payMoney" type="text" id="payMoney" maxlength="9" v_type=cfloat v_maxlength=9 v_name="�ɿ���" >
						<font class="blue">*</font>
					</TD>
				</TR>
          
				<TR>
					<td  class="blue">������ע</td>
					<TD colspan="3">
						<input name="opNote" type="text" id="opNote" size="60" maxlength="60"> 
					</TD>
				</TR>
        <tr> 
            <td align=center id="footer" colspan="4"> 
                <input name="confirm" type="button" class="b_foot" value="ȷ��" onClick="commitJsp()">
                &nbsp; 
                <input name="reset" type="button" class="b_foot"  value="���" onClick="resetJsp()">
                &nbsp; 
                <input name="back" onClick="window.close()" class="b_foot" type="button" value="����">
                &nbsp;</td>
        </tr>
       
  </table>
  
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  
  </td>
  </tr>
  </table>
  
  	<input type="hidden" name="loginNoPass" id="loginNoPass" value="<%=loginNoPass%>">
  	<input type="hidden" name="loginName" id="loginName" value="">
  	<input type="hidden" name="opCode" id="opCode" value="">
  	<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
  	<input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">

		<input type="hidden" name="busyAccept" id="busyAccept" value=""> 
		<input type="hidden" name="tmpSendAccept" id="tmpSendAccept" value=""> 	
		<input type="hidden" name="tmpBackAccept" id="tmpBackAccept" value=""> 	
		<input type="hidden" name="accountNo" id="accountNo" value="">
		<input type="hidden" name="tmpPayMoney" id=""tmpPayMoney"" value="">
		
		<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
		<input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
		<input type="hidden" name="totalDate" id="totalDate" value="<%=curDate%>"> 	
	
</FORM>
</body>
</html>
