<%
/********************
version v2.0
������: si-tech
ģ�飺��ͥ����ҵ��
���ڣ�2013-4-27 14:37:32
���ߣ�hejwa
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml"> 
<%@ page contentType= "text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="org.apache.log4j.Logger"%>

<%
request.setCharacterEncoding("GBK");
%>
<head>
	<title>��ͥ����ҵ��</title>
	<%
	String opCode       = request.getParameter("opCode");
	String opName       = request.getParameter("opName");
	String phoneNotype  = request.getParameter("phoneNotype");
	
	String hideStr      = "style=\"display:none\"";      //����˳�� ���ô��� ��ϸ���� ���ñ��� �������� �⼸����ʱ���ε��������Ҫֻ��Ҫ hideStr="";
	String loginName    = (String)session.getAttribute("workName");
	String work_no      = (String)session.getAttribute("workNo");
	String org_code     = (String)session.getAttribute("orgCode");
	String wkPassword   = (String)session.getAttribute("password");
	String regionCode   = (String)session.getAttribute("regCode");
	String iRegion_Code = org_code.substring(0,2);
	
	String[][]  temfavStr = (String[][])session.getAttribute("favInfo");
	String[] favStr=new String[temfavStr.length];
	for(int i=0;i<favStr.length;i++)
		favStr[i]=temfavStr[i][0].trim();
	boolean pwrf=false;
	boolean hfrf=false;
	if(WtcUtil.haveStr(favStr,"a272"))
	pwrf=true;
	String [] retStr = null;
	
	String srv_no     = WtcUtil.repNull(request.getParameter("srv_no"));
	String cus_pass   = WtcUtil.repNull(request.getParameter("cus_pass"));
	String[] twoFlag  = new String []{};
	
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone"  routerValue="<%=srv_no%>" id="sLoginAccept"/>
<%
	String sqHf="select hand_fee ,trim(favour_code) from snewFunctionFee where region_code=substr('"+org_code+"',1,2) and FUNCTION_CODE="+opCode;
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="2">
 <wtc:sql><%=sqHf%></wtc:sql>
</wtc:pubselect>
	<wtc:array id="handFeeArr" scope="end"/>
<%
	
	String oriHandFee="0";
	String oriHandFeeFlag="";
	if(handFeeArr.length>0){
		oriHandFee=handFeeArr[0][0];
		oriHandFeeFlag=handFeeArr[0][1];
		if(Double.parseDouble(oriHandFee) < 0.01){
		   hfrf=true;
		}else{
			if(!WtcUtil.haveStr(favStr,oriHandFeeFlag.trim())){
			  hfrf=true;
			}
		}
	}else{
	  hfrf=true;
	}
		String id_no	      = "" ;    // idNo
		String sm_code      = "" ;    // Ʒ�ƴ���
		String sm_name      = "" ;    // Ʒ������
		String cust_name    = "" ;    // �ͻ�����
		String cust_id      = "" ;    // custID
		String owner_grade  = "" ;    // �ȼ�����
		String grade_name   = "" ;    // �ȼ�����
		String owner_type   = "" ;    // �û����ʹ���
		String type_name    = "" ;    // �û���������
		String totalOwe     = "" ;    // ��Ƿ��
		String totalPrepay  = "" ;    // ��Ԥ��
		String accountNo    = "" ;    // Ĭ���ʺ�
		String functionFee  = "" ;    // ������
		String belong_code  = "" ;    // �û�����
		String isoweFee     = "" ;    // ���������ʻ�Ƿ��
		String custAddr     = "" ;    // �ͻ���ַ
		String phoneNo      = "" ;
	%>
		<wtc:service name="sG630Init"  routerKey="region" routerValue="<%=regionCode%>"  retcode="error_code" retmsg="error_msg" outnum="17" >
			<wtc:param value="<%=sLoginAccept%>"/>			
			<wtc:param value="01"/>				
			<wtc:param value="<%=opCode%>"/> 
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=wkPassword%>"/>	
			<wtc:param value="<%=srv_no%>"/>
			<wtc:param value="<%=cus_pass%>"/>	
			<wtc:param value="<%=org_code%>"/>
			<wtc:param value="<%=phoneNotype%>"/>	
		</wtc:service>
		<wtc:array id="result_t"  scope="end"/> 
  <%		
	if(!error_code.equals("000000")){
	%>
	<script language="javascript">
		rdShowMessageDialog('sG630Init����δ�ܳɹ�!<br>�������<%=error_code%><%=error_msg%>',0);
		window.location.href="familyAccountLogin.jsp?activePhone=<%=srv_no%>&opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
	<%
	return;
	}else {
		if(result_t.length>0){
			 id_no	      = result_t[0][0];   // idNo                        
			 sm_code      = result_t[0][1];   // Ʒ�ƴ���                    
			 sm_name      = result_t[0][2];   // Ʒ������                    
			 cust_name    = result_t[0][3];   // �ͻ�����                    
			 cust_id      = result_t[0][4];   // custID                      
			 owner_grade  = result_t[0][5];   // �ȼ�����                    
			 grade_name   = result_t[0][6];   // �ȼ�����                    
			 owner_type   = result_t[0][7];   // �û����ʹ���                
			 type_name    = result_t[0][8];   // �û���������                
			 totalOwe     = result_t[0][9];   // ��Ƿ��                      
			 totalPrepay  = result_t[0][10];  // ��Ԥ��                      
			 accountNo    = result_t[0][11].trim();  // Ĭ���ʺ�                    
			 srv_no       = result_t[0][12];  // ������                      
			 belong_code  = result_t[0][13];  // �û�����                    
			 isoweFee     = result_t[0][14];  // ���������ʻ�Ƿ��      
			 custAddr     = result_t[0][15];  // �ͻ���ַ
			 phoneNo      = srv_no;       
		}
} 

System.out.println("<br>-----------idNo              -------------id_no	    --------------"+id_no	     );
System.out.println("<br>-----------Ʒ�ƴ���          -------------sm_code    --------------"+sm_code     ); 
System.out.println("<br>-----------Ʒ������          -------------sm_name    --------------"+sm_name     ); 
System.out.println("<br>-----------�ͻ�����          -------------cust_name  --------------"+cust_name   ); 
System.out.println("<br>-----------custID            -------------cust_id    --------------"+cust_id     ); 
System.out.println("<br>-----------�ȼ�����          -------------owner_grade--------------"+owner_grade ); 
System.out.println("<br>-----------�ȼ�����          -------------grade_name --------------"+grade_name  ); 
System.out.println("<br>-----------�û����ʹ���      -------------owner_type --------------"+owner_type  ); 
System.out.println("<br>-----------�û���������      -------------type_name  --------------"+type_name   ); 
System.out.println("<br>-----------��Ƿ��            -------------totalOwe   --------------"+totalOwe    ); 
System.out.println("<br>-----------��Ԥ��            -------------totalPrepay--------------"+totalPrepay ); 
System.out.println("<br>-----------Ĭ���ʺ�          -------------accountNo  --------------"+accountNo   ); 
System.out.println("<br>-----------������            -------------srv_no     --------------"+srv_no      ); 
System.out.println("<br>-----------�û�����          -------------belong_code--------------"+belong_code ); 
System.out.println("<br>-----------���������ʻ�Ƿ��  -------------isoweFee   --------------"+isoweFee    ); 
System.out.println("<br>-----------�ͻ���ַ          -------------custAddr   --------------"+custAddr    ); 

	String sq1="select trim(fee_code),trim(detail_code),trim(detail_name) from sFeecodedetail order by fee_code,detail_code";
%>
		<wtc:service name="TlsPubSelBoss" outnum="3" routerKey="phone" routerValue="<%=srv_no%>" outnum="3">
			<wtc:param value="<%=sq1%>" />
		</wtc:service>
		<wtc:array id="feeStr" scope="end"/>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="javascript">

var hideStrJs = "style=\"display:none\""; ////����˳�� ���ô��� ��ϸ���� ���ñ��� �������� �⼸����ʱ���ε��������Ҫֻ��Ҫ hideStr="";

var opFlag = "a";	
var js_fee = new Array();
//---------��ʾ��ӡ�Ի���----------------
function printCommit(){
	//getAfterPrompt();
	showPrtDlg("Detail","ȷ���ύ��","Yes");
}

function showPrtDlg(printType,DlgMessage,submitCfm){
 		
 		var memPhoneArray  = new Array(); //�ֻ�������
 		var defContNoArray = new Array(); //Ĭ�ϸ����˻� 
 		var feeLimitArray  = new Array(); //�޶�
 		var payorderArray  = new Array(); //����˳��
 		var feeFlagArray   = new Array(); //���ô���
 		var detFlagArray   = new Array(); //��ϸ����
 		var rateFlagArray  = new Array(); //�Ƿ���ϸ
 		var stopflagArray  = new Array(); //�Ƿ�����
 		var feeratioArray  = new Array(); //���ñ���
 		var orderNewArray  = new Array(); //����˳�� �̶�ֵ1
 		//У���Ա����
 		
 		var	exiFlag    = 0; //�Ƿ�������
 		var showHit    = ""; //�޶��Ƿ���д
 		
 		$("#memberList tr:gt(0)").each(function(i,bt){
 			exiFlag ++ ;
 			//ȡ�ֻ��� ��� td�ĸ���Ϊ9�����ֻ��ŵ��У�����Ϊƴ��
			var tdSize = $(bt).find("td").size();
			if(tdSize==9){//�����ֻ��ŵ� ����˳�� ���ô��� ��ϸ���� ���ñ���
				var memPhone   = ""; //�ֻ�������
		 		var defContNo  = ""; //Ĭ�ϸ����˻� 
		 		var feeLimit   = ""; //�޶�
		 		var payorder   = ""; //���ñ���
		 		var feeFlag    = ""; //���ô���
		 		var detFlag    = ""; //��ϸ����
	 			var feeratio   = ""; //���ñ���
	 			var limiType   = ""; //�޶�����
				var rowspanNum = parseInt($(bt).find("td:eq(0)").attr("rowspan"));
						memPhone   = $(bt).find("td:eq(0)").text().trim();
						defContNo  = $(bt).find("td:eq(1)").text().trim();
						feeLimit   = $(bt).find("td:eq(2)").find("input").val().trim();
						limiType   = $(bt).find("td:eq(2)").find("select").val();
				
				if(feeLimit == ""){
					showHit = "�����ø��ѷ�ʽ";
					$(bt).find("td:eq(2)").find("input").focus();
					return false;
				}
				
				var t1 = /^\d+$/;
				if(!t1.test(feeLimit)){
					showHit = "�޶����Ϊ������";
					$(bt).find("td:eq(2)").find("input").val("");
					$(bt).find("td:eq(2)").find("input").focus();
					return false;
				}
				
				if(parseInt(feeLimit)>5000){
					showHit = "��ͥΪ��Աÿ��֧���޶�ܳ���5000Ԫ";
					$(bt).find("td:eq(2)").find("input").val("");
					$(bt).find("td:eq(2)").find("input").focus();
					return false;
				}
				
				if(limiType=="0"&&parseInt(feeLimit)==0){
					showHit = "�޶���޶�Ӧ����0������������";
					$(bt).find("td:eq(2)").find("input").val("");
					$(bt).find("td:eq(2)").find("input").focus();
					return false;
				}
				
				payorder += $(bt).find("td:eq(3)").text().trim()+"|";
				feeFlag  += $(bt).find("td:eq(4)").text().trim()+"|";
				detFlag  += $(bt).find("td:eq(5)").text().trim()+"|";
				feeratio += $(bt).find("td:eq(6)").text().trim()+"|";
				
/*				if(payorder == "|"||payorder==""){
					rateFlagArray.push("N");
				}else{
					rateFlagArray.push("Y");
				}*/
				
				//������rowspan-1��
				for(var ii=0; ii<rowspanNum-1 ;ii++){
					bt = $(bt).next();
					payorder += $(bt).find("td:eq(0)").text().trim()+"|";
					feeFlag  += $(bt).find("td:eq(1)").text().trim()+"|";
					detFlag  += $(bt).find("td:eq(2)").text().trim()+"|";
					feeratio += $(bt).find("td:eq(3)").text().trim()+"|";
				}
				
				//ȥ�����һλ������
				payorder  = payorder.substring(0,payorder.length-1);
				feeFlag   = feeFlag.substring(0,feeFlag.length-1);
				detFlag   = detFlag.substring(0,detFlag.length-1);
				feeratio  = feeratio.substring(0,feeratio.length-1);
				
				rateFlagArray.push("N");
				stopflagArray.push("Y");
				orderNewArray.push("1");
				memPhoneArray.push(memPhone);
				defContNoArray.push(defContNo);
				feeLimitArray.push(feeLimit);
				payorderArray.push(payorder);
				feeFlagArray.push(feeFlag);
				detFlagArray.push(detFlag);
				feeratioArray.push(feeratio);
			}
 		});
 		
 		//alert("stopflagArray|"+stopflagArray+"\nmemPhoneArray|"+memPhoneArray+"\ndefContNoArray|"+defContNoArray+"\nfeeLimitArray|"+feeLimitArray+"\npayorderArray|"+payorderArray+"\nfeeFlagArray|"+feeFlagArray+"\ndetFlagArray|"+detFlagArray+"\nrateFlagArray|"+rateFlagArray+"\nfeeratioArray|"+feeratioArray);
 		if(showHit!=""){
 			rdShowMessageDialog(showHit);
 			return;
 		}
 		
 		if(exiFlag<2){//����һ������ȫ��
 			rdShowMessageDialog("��Ա�б�Ϊ�գ������ó�Ա����");
 			return;
 		}
 				
 				$("input[name='memPhoneArray']").val(memPhoneArray);
				$("input[name='defContNoArray']").val(defContNoArray);
				$("input[name='feeLimitArray']").val(feeLimitArray);
				$("input[name='payorderArray']").val(payorderArray);
				$("input[name='feeFlagArray']").val(feeFlagArray);
				$("input[name='detFlagArray']").val(detFlagArray);
				$("input[name='rateFlagArray']").val(rateFlagArray);
				$("input[name='stopflagArray']").val(stopflagArray);
				$("input[name='feeratioArray']").val(feeratioArray);
				$("input[name='orderNewArray']").val(orderNewArray);
				$("input[name='opType']").val(opFlag);
				
			var opStr = "����";
			if(opFlag=="a"){
				 opStr = "����";
			}else if(opFlag=="u"){
				 opStr = "�޸�";
			}else if(opFlag=="d"){
				 opStr = "ɾ��";
			}			
		document.all.t_sys_remark.value="�û�"+"<%=cust_name%>"+"���м�ͥ����ҵ�����-"+opStr;
		if(document.all.t_op_remark.value.trim().length==0){
			document.all.t_op_remark.value="����Ա<%=work_no%>"+"���û�"+"<%=cust_name%>"+"���м�ͥ����ҵ�����-"+opStr;
		}
		if(document.all.assuNote.value.trim().length==0){
			document.all.assuNote.value="����Ա<%=work_no%>"+"���û�"+"<%=cust_name%>"+"���м�ͥ����ҵ�����-"+opStr;
		}
		//��ʾ��ӡ�Ի���
		var h=210;
   	var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
		var pType="subprint";             // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
		var billType="1";               //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
		var sysAccept="<%=sLoginAccept%>";               // ��ˮ��
		var printStr = printInfo(printType); //����printinfo()���صĴ�ӡ����
		var mode_code=null;               //�ʷѴ���
		var fav_code=null;                 //�ط�����
		var area_code=null;             //С������
		var opCode="<%=opCode%>" ;                   //��������
		var phoneNo=<%=phoneNo%>;                  //�ͻ��绰
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;

		var ret=window.showModalDialog(path,printStr,prop);

		if(typeof(ret)!="undefined"){
			if((ret=="confirm")&&(submitCfm == "Yes")){
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ��ͥ����ҵ��')==1){
					conf();
				}
			}
			if(ret=="continueSub"){
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ��ͥ����ҵ��')==1){
					conf();
				}
			}
		}else{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ��ͥ����ҵ��')==1){
				conf();
			}
		}
}


//��ӡ���
function printInfo(printType){
	 var cust_info=""; //�ͻ���Ϣ
	 var opr_info=""; //������Ϣ
	 var note_info1=""; //��ע1
	 var note_info2=""; //��ע2
	 var note_info3=""; //��ע3
	 var note_info4=""; //��ע4
   var retInfo = "";  //��ӡ����
   
 	 cust_info+="�ͻ�������"+document.all.cust_name.value+"|";     
   cust_info+="��ͥ���룺"+document.all.srv_no.value+"|";

	var opStr = "����";
	if(opFlag=="a"){
		 opStr = "����";
	}else if(opFlag=="u"){
		 opStr = "�޸�";
	}else if(opFlag=="d"){
		 opStr = "ɾ��";
	}
	opr_info+="��ͥ����ҵ��"+opStr+"|";
  opr_info+="ҵ����ˮ��"+"<%=sLoginAccept%>|";
  
  var tempOprInfo1 = "";
  
	$("#memberList tr:gt(0)").each(function(i,bt){
 			var tdSize = $(bt).find("td").size();
			if(tdSize==9){//�����ֻ��ŵ� ����˳�� ���ô��� ��ϸ���� ���ñ���
				var memPhone   = ""; //�ֻ�������
		 		var limiType   = ""; //Ĭ�ϸ����˻� 
		 		var feeLimit   = ""; //�޶�
		 		
						memPhone   = $(bt).find("td:eq(0)").text().trim();
						limiType  = $(bt).find("select").val();
						feeLimit   = $(bt).find("td:eq(2)").find("input").val().trim();
						if(limiType==0){
							tempOprInfo1 += memPhone+"     �޶��     "+feeLimit+"|";
						}else{
							tempOprInfo1 += memPhone+"     ȫ���     "+"|";
						}
			}
 		});  
 		
 	opr_info+="��Ա���룺"+"|";
 	opr_info+=tempOprInfo1+"|";
 		
  opr_info+="ϵͳ��ע��"+document.all.t_sys_remark.value+"|";
	opr_info+="�û���ע��"+document.all.t_op_remark.value+"|";
	note_info1+="      ��ע��"+"|";
	
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;
}

//---------�ύ������-------------------
function conf(){
	frm.action="familyAccountCfm.jsp";
	frm.submit();
}
 

//-------3--------ʵ����ר�ú���----------------
function ChkHandFee()
{
	if(document.all.oriHandFee.value.trim().length>=1 && document.all.t_handFee.value.trim().length>=1){
		if(parseFloat(document.all.oriHandFee.value)<parseFloat(document.all.t_handFee.value)){
			rdShowMessageDialog("ʵ�������Ѳ��ܴ���ԭʼ�����ѣ�");
			document.all.t_handFee.value=document.all.oriHandFee.value;
			document.all.t_handFee.select();
			document.all.t_handFee.focus();
			return;
		}
	}
	
	if(document.all.oriHandFee.value.trim().length>=1 && document.all.t_handFee.value.trim().length==0){
		document.all.t_handFee.value="0";
	}
}

function getFew(){
	if(window.event.keyCode==13){
		var fee=document.all.t_handFee;
		var fact=document.all.t_factFee;
		var few=document.all.t_fewFee;
		if(fact.value.trim().length==0){
			rdShowMessageDialog("ʵ�ս���Ϊ�գ�");
			fact.value="";
			fact.focus();
			return;
		}
		if(parseFloat(fact.value)<parseFloat(fee.value)){
			rdShowMessageDialog("ʵ�ս��㣡");
			fact.value="";
			fact.focus();
			return;
		}
		var tem1=((parseFloat(fact.value)-parseFloat(fee.value))*100+0.5).toString();
		var tem2=tem1;
		if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
		few.value=(tem2/100).toString();
		few.focus();
	}
}

//-------4--------����������͵�ѡ��ʱ--------------

function setChangeType(){
	if(opFlag=="a"){
		$("input[vProp='u']").removeAttr("disabled");
		$("#memPhoneIpt").removeAttr("disabled");
	}else if(opFlag=="u"){
		$("#memPhoneIpt").attr("disabled","disabled");
		$("input[vProp='u']").removeAttr("disabled");
	}else if(opFlag=="d"){
		$("input[vProp='u']").attr("disabled","disabled");
		$("#memPhoneIpt").attr("disabled","disabled");
	}
}
function chg_opType(){
	if(document.all.r_acc_opType[0].checked){
		if(opFlag!="a"){
			$("#memberList tr:not(:first):not(:last)").remove();
			$("#memPhoneSel").val("");
			$("#memPhoneIpt").val("");
		}
		opFlag="a";
		
	}else if(document.all.r_acc_opType[1].checked){
		if(parseInt(document.all.ccount.value,10)>0){
			rdShowMessageDialog("���������ʻ����ʻ���Ƿ�Ѳ����޸��ʻ���");
			document.all.r_acc_opType[0].checked=true;
			return;
		}
		if(opFlag!="u"){
			$("#memberList tr:not(:first):not(:last)").remove();
			$("#memPhoneSel").val("");
			$("#memPhoneIpt").val("");
		}
		opFlag="u";
	}else if(document.all.r_acc_opType[2].checked){
		if(parseInt(document.all.ccount.value,10)>0){
			rdShowMessageDialog("���������ʻ�,�ʻ���Ƿ�Ѳ���ɾ���ʻ���");
			document.all.r_acc_opType[0].checked=true;
			return;
		}		
		if(opFlag!="d"){
			$("#memberList tr:not(:first):not(:last)").remove();
			$("#memPhoneSel").val("");
			$("#memPhoneIpt").val("");
		}
		opFlag="d";
	}
	
	setChangeType();
}
 
 
 
//ѡ���ֻ���������
function setMemPhoneIptFuc(bt){
	if($(bt).val()==""){
		$("#memPhoneIpt").val("");
	}else{
		$("#memPhoneIpt").val($(bt).val());
	}
} 
//���У�鰴ť
function addMemPhoneSetFunc(){
	if($("#memPhoneIpt").val()==""){
		rdShowMessageDialog("�������ֻ�����");
		$("#memPhoneSel").val("");
		$("#memPhoneIpt").focus();
		setMemPhoneIptFuc();
		return;
	}
	
	//��ѯ�б����Ƿ��Ѿ������ֻ���
	var retFlag = 0;
	$("#memberList tr:gt(0)").each(function(i,bt){
		if($(bt).find("td:eq(0)").text().trim()==$("#memPhoneIpt").val()){
			retFlag = 1;
			return false;
		}
	});
	
	if(retFlag==1){
		rdShowMessageDialog("�˺����Ѿ�����������");
		$("#memPhoneSel").val("");
		$("#memPhoneIpt").focus();
		setMemPhoneIptFuc();
		return;
	}
	var packet = new AJAXPacket("ajaxChkMemPhone.jsp","���Ժ�...");
	packet.data.add("memPhoneIpt",$("#memPhoneIpt").val());
	packet.data.add("r_acc_opType",opFlag);
	packet.data.add("sLoginAccept","<%=sLoginAccept%>");
	packet.data.add("opCode","<%=opCode%>");
	packet.data.add("famContractNo","<%=accountNo%>");
	packet.data.add("srv_no","<%=srv_no%>");
	core.ajax.sendPacket(packet,doAjaxChkMemPhone);
	packet =null;
}
function doAjaxChkMemPhone(packet){
	var retCode   = packet.data.findValueByName("retCode");
	var retMsg    = packet.data.findValueByName("retMsg");
	var memPhone  = packet.data.findValueByName("memPhone");
	
	if(retCode=="000000"){
		var isMemFlag     = packet.data.findValueByName("isMemFlag");
		var defContractNo = packet.data.findValueByName("defContractNo");
		var retStrs       = packet.data.findValueByName("retStrs");
		var feeLimit      = packet.data.findValueByName("feeLimit");
		var hitMsg        = packet.data.findValueByName("hitMsg");
		//��������ӵ��б��������÷���ҳ��
		if(isMemFlag == "0"){//�ǳ�Ա
			if(opFlag=="a"){//����
				addMemPhListTabFunc(memPhone,defContractNo);
			}else{//�޸ĺ�ɾ��
				addMemPhListByUd(memPhone,defContractNo,retStrs,feeLimit);
			}
		}else{
			rdShowMessageDialog("�˺���Ǵ˼�ͥ��Ա���������");
			toAddMember(memPhone,defContractNo);	//������ӳ�Աҳ��
		}
	}else{
		rdShowMessageDialog(retCode+"��"+retMsg);
		$("#memPhoneSel").val("");
		$("#memPhoneIpt").focus();
		setMemPhoneIptFuc();
		return;
	}
}

//���ò�Ʒ������ӳ�Աҳ��
function toAddMember(memPhone,defContractNo){
	
		var h=300;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
 	  var custId = $("#cust_id").val();
 	  var path = "addMemberPhone.jsp?opCode=<%=opCode%>&opName=<%=opName%>&memPhone="+memPhone+"&custId="+custId;
    var retInfo = window.showModalDialog(path,"",prop);	
    if(typeof(retInfo)!="undefined"){
    	if(retInfo=="1"){//��ӳɹ�
    		ajaxGetMemPhoneList();//ˢ��������
    		addMemPhListTabFunc(memPhone,defContractNo);
    	}
    }
}

//ȡ��Ա�������б�
function ajaxGetMemPhoneList(){
	var packet = new AJAXPacket("ajaxGetMemPhoneList.jsp","���Ժ�...");
	packet.data.add("srv_no","<%=srv_no%>");
	packet.data.add("type","1");
	core.ajax.sendPacketHtml(packet,doAjaxGetMemPhoneList);
	packet =null;
}
function doAjaxGetMemPhoneList(data){
	$("#memPhoneSel").html(data);
}

//�޸�ɾ��ʱ���ӵ��б�
function addMemPhListByUd(memPhone,defContractNo,retStrs,feeLimit){
	var inHtml    = "";               
	var selectObj = ""; 
	var iptText   = "";
	var iptButt1  = "";
	var disaStr   = "";
	var disaStr1  = "";
	
	
	var feeArray  = retStrs.split("|");
	var aLen      = feeArray.length-1;
	for(var i=0;i<aLen;i++){
		var tempArray = feeArray[i].split(",");
		if(opFlag=="d"){//ɾ������ȫ���޶��Ϊ���ɸ�
			if(feeLimit==0){//ȫ���޶�
				selectObj = "<select onchange='setThisTrInpt(this)' style='width:90px' disabled><option value='0'>�޶��</option><option value='1' selected>ȫ���</option></select>&nbsp;&nbsp;";
			}else{
				selectObj = "<select onchange='setThisTrInpt(this)' style='width:90px' disabled><option value='0' selected >�޶��</option><option value='1' >ȫ���</option></select>&nbsp;&nbsp;";
			}
					iptText = "<input type='text' maxlength='4' style='width:30px' value='"+feeLimit+"' disabled />";
				 iptButt1 = "<input type='button' disabled class='b_text'  vProp='u'  "+hideStrJs+"  value='����' onclick='setThisFee(this,\""+memPhone+"\",\""+defContractNo+"\","+aLen+")'  />";
		}else{//�޸ĵ���� ����ȫ���޶��ж�
			if(feeLimit==0){//ȫ���޶�
				selectObj = "<select onchange='setThisTrInpt(this)' style='width:90px' ><option value='0'>�޶��</option><option value='1' selected>ȫ���</option></select>&nbsp;&nbsp;";
					iptText = "<input type='text' maxlength='4' style='width:30px' value='"+feeLimit+"' disabled />";
				 iptButt1 = "<input type='button' disabled class='b_text'  vProp='u'   "+hideStrJs+" value='����' onclick='setThisFee(this,\""+memPhone+"\",\""+defContractNo+"\","+aLen+")'  />";
			}else{
				selectObj = "<select onchange='setThisTrInpt(this)' style='width:90px' ><option value='0' selected >�޶��</option><option value='1' >ȫ���</option></select>&nbsp;&nbsp;";
					iptText = "<input type='text' maxlength='4' style='width:30px' value='"+feeLimit+"'  />";
				 iptButt1 = "<input type='button'  class='b_text'  vProp='u'   "+hideStrJs+" value='����' onclick='setThisFee(this,\""+memPhone+"\",\""+defContractNo+"\","+aLen+")'  />";
			}
		}
			
		inHtml += "<tr>";
		if(i==0){//��һ�����ڲ�ͬ
			inHtml += "<td rowspan='"+aLen+"'>";
			inHtml += memPhone;
			inHtml += "</td>";
			inHtml += "<td rowspan='"+aLen+"'>"+defContractNo+"</td>";
			inHtml += "<td rowspan='"+aLen+"' align='center'>"+selectObj+iptText+"</td>";
			inHtml += "<td "+hideStrJs+">"+tempArray[0]+"</td>";
			inHtml += "<td "+hideStrJs+">"+tempArray[1]+"</td>";
			inHtml += "<td "+hideStrJs+">"+tempArray[2]+"</td>";
			inHtml += "<td "+hideStrJs+">"+tempArray[3]+"</td>";
			inHtml += "<td "+hideStrJs+">"+getFeeLName(tempArray[2])+"</td>";
			inHtml += "<td rowspan='"+aLen+"'>"+iptButt1+"&nbsp;&nbsp;";
			inHtml += "<input type='button' class='b_text' value='ɾ��' onclick='delThisMem(this,"+aLen+")' /></td>";
		}else{
			inHtml += "<td "+hideStrJs+">"+tempArray[0]+"</td>";
			inHtml += "<td "+hideStrJs+">"+tempArray[1]+"</td>";
			inHtml += "<td "+hideStrJs+">"+tempArray[2]+"</td>";
			inHtml += "<td "+hideStrJs+">"+tempArray[3]+"</td>";
			inHtml += "<td "+hideStrJs+">"+getFeeLName(tempArray[2])+"</td>";
		}
		inHtml += "</tr>";
	}
	$("#memberList tr:first").after(inHtml);
	//setChangeType();
}

//���ݷ��ô���ȡ�÷�������
function getFeeLName(feeCode){
	feeCode = feeCode.trim()+"";
	var temFeeName = "";
  for(var i=0; i<js_fee.length;i++){
  	if(js_fee[i][1]==feeCode){
  		temFeeName = js_fee[i][2];
  		break;
  	}
  }
	return temFeeName;
}


//�޶ʽonchange�¼�
function setThisTrInpt(bt){
	if($(bt).val()==0){//�޶�
		$(bt).parent().parent().find("input[type='text']").val("");
		$(bt).parent().parent().find("input[type='text']").removeAttr("disabled");
		$(bt).parent().parent().find("input[value='����']").removeAttr("disabled");
	}else{//ȫ��
		var rowspanNum = parseInt($(bt).parent().parent().find("td:eq(0)").attr("rowspan"));
		var	memPhone   = $(bt).parent().parent().find("td:eq(0)").text().trim();
		var	defContNo  = $(bt).parent().parent().find("td:eq(1)").text().trim();
		
		var inHtml  = "";
				inHtml += "<tr><td>";
				inHtml += memPhone;
				inHtml += "</td>";
				inHtml += "<td>"+defContNo+"</td>";
				inHtml += "<td align='center'>";
				inHtml += "<select onchange='setThisTrInpt(this)' style='width:90px'><option value='0'>�޶��</option><option value='1' selected>ȫ���</option></select>&nbsp;&nbsp;";
				inHtml += "<input type='text'   maxlength='4'  style='width:30px' value='0'  disabled /></td>";
				inHtml += "<td "+hideStrJs+"></td><td "+hideStrJs+"></td><td "+hideStrJs+"></td><td "+hideStrJs+"></td>";
				inHtml += "<td "+hideStrJs+"></td>";
				inHtml += "<td><input type='button' class='b_text'  "+hideStrJs+" value='����' disabled vProp='u' onclick='setThisFee(this,\""+memPhone+"\",\""+defContNo+"\",1)' />&nbsp;&nbsp;";
				inHtml += "    <input type='button' class='b_text' value='ɾ��' onclick='delThisMem(this,1)' /></td></tr>";
		
		var trObj = $(bt).parent().parent();	
		for(var i=0;i<rowspanNum;i++){
			trObj = trObj.next();
		}
		trObj.before(inHtml);//���е�ǰ������ֵ�͸�û���һ��
		delThisMem(bt,rowspanNum);//ɾ��֮ǰ��¼
	}
}


//����ʱ����ֻ��ŵ����÷����б�
function addMemPhListTabFunc(mPhoneNo,defContractNo){
	var inHtml  = "";
			inHtml += "<tr><td>";
			inHtml += mPhoneNo;
			inHtml += "</td>";
			inHtml += "<td>"+defContractNo+"</td>";
			inHtml += "<td align='center'>";
			inHtml += "<select onchange='setThisTrInpt(this)' style='width:90px'><option value='0'>�޶��</option><option value='1'>ȫ���</option></select>&nbsp;&nbsp;";
			inHtml += "<input type='text'   maxlength='4'  style='width:30px' /></td>";
			inHtml += "<td "+hideStrJs+"></td><td "+hideStrJs+"></td><td "+hideStrJs+"></td><td "+hideStrJs+"></td>";
			inHtml += "<td "+hideStrJs+"></td>";
			inHtml += "<td><input type='button' class='b_text'  "+hideStrJs+" value='����' vProp='u' onclick='setThisFee(this,\""+mPhoneNo+"\",\""+defContractNo+"\",1)' />&nbsp;&nbsp;";
			inHtml += "    <input type='button' class='b_text' value='ɾ��' onclick='delThisMem(this,1)' /></td></tr>";
	$("#memberList tr:first").after(inHtml);
	setChangeType();
}

//���ô˴��ֻ�����ĳ�������
function setThisFee(bt,mPhoneNo,defContractNo,oldAlen){
	var feeLimit = $(bt).parent().parent().find("input[type='text']").val().trim();
	var limiType = $(bt).parent().parent().find("td:eq(2)").find("select").val();
	var t1 = /^\d+$/;
	if(feeLimit!=""){// �������ֻ����������
		if(!t1.test(feeLimit)){
			rdShowMessageDialog("�޶�ֻ����������");
			$(bt).parent().parent().find("input[type='text']").val("");
			$(bt).parent().parent().find("input[type='text']").focus();
			return;
		}
		if(parseInt(feeLimit)>5000){
			rdShowMessageDialog("��ͥΪ��Աÿ��֧���޶�ܳ���5000Ԫ");
			$(bt).parent().parent().find("input[type='text']").val("");
			$(bt).parent().parent().find("input[type='text']").focus();
			return false;
		}
		
		if(limiType=="0"&&parseInt(feeLimit)==0){
			rdShowMessageDialog("�޶���޶�Ӧ����0������������");
			$(bt).parent().parent().find("input[type='text']").val("");
			$(bt).parent().parent().find("input[type='text']").focus();
			return false;
		}
	}
	
	var Fees = "";
	var h=600;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var retInfo=window.showModalDialog("Dlg_s1212Add.jsp?opCode=<%=opCode%>&opName=<%=opName%>&Fees="+Fees,"",prop);
	var feeArray  = new Array();
	var tempArray = new Array();
	
	if(typeof(retInfo)!="undefined"&&retInfo!=""){
		feeArray = retInfo.split("|");
		var inHtml  = "";
		var aLen = feeArray.length-1;
			for(var i=0; i<aLen; i++){
				inHtml += "<tr>";
				tempArray = feeArray[i].split("#");
				if(i==0){//��һ�����ڲ�ͬ
					inHtml += "<td rowspan='"+aLen+"'>";
					inHtml += mPhoneNo;
					inHtml += "</td>";
					inHtml += "<td rowspan='"+aLen+"'>"+defContractNo+"</td>";
					inHtml += "<td rowspan='"+aLen+"' align='center'><select onchange='setThisTrInpt(this)' style='width:90px'><option value='0' selected >�޶��</option><option value='1'>ȫ���</option></select>&nbsp;&nbsp;<input type='text'  maxlength='4'  style='width:30px' value='"+feeLimit+"'  /></td>";
					inHtml += "<td>"+tempArray[3]+"</td>";
					inHtml += "<td>"+tempArray[0]+"</td>";
					inHtml += "<td>"+tempArray[1]+"</td>";
					inHtml += "<td>"+tempArray[4]+"</td>";
					inHtml += "<td>"+tempArray[2]+"</td>";
					inHtml += "<td rowspan='"+aLen+"'><input type='button' class='b_text'  vProp='u'  value='����' onclick='setThisFee(this,\""+mPhoneNo+"\",\""+defContractNo+"\","+aLen+")' />&nbsp;&nbsp;";
					inHtml += "<input type='button' class='b_text' value='ɾ��' onclick='delThisMem(this,"+aLen+")' /></td>";
				}else{
					inHtml += "<td>"+tempArray[3]+"</td>";
					inHtml += "<td>"+tempArray[0]+"</td>";
					inHtml += "<td>"+tempArray[1]+"</td>";
					inHtml += "<td>"+tempArray[4]+"</td>";
					inHtml += "<td>"+tempArray[2]+"</td>";
				}
				inHtml += "</tr>";
			}
		//��ɾ�����ڲ���
		
		var trObj = $(bt).parent().parent();	
		for(var h=0;h<oldAlen;h++){
			trObj = trObj.next();
		}
		//alert(trObj.html());
		trObj.before(inHtml);//���е�ǰ������ֵ�͸�û���һ��
		delThisMem(bt,oldAlen);
		//$("#memberList tr:first").after(inHtml); 
		
	}
	setChangeType();
}
//ɾ���˳�Ա len ����ɾ��������
function delThisMem(bt,len){
	var trArr = new Array();
	var trObj = $(bt).parent().parent();
	trArr.push(trObj);
	for(var i=0;i<len-1;i++){
		trObj = trObj.next();
		trArr.push(trObj); //��¼tr
	}
	
	for(var j=0;j<trArr.length;j++){
		trArr[j].remove();
		trArr[j] = ""; //�ͷ��ڴ�
	}
}


function allMemSetOFunc(){
	var h=300;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var retInfo=window.showModalDialog("allMemSetOFunc.jsp?opCode=<%=opCode%>&opName=<%=opName%>","",prop);
	if(typeof(retInfo)!="undefined"&&retInfo!=""){
		var selVal = retInfo.split("|")[0];
		var iptVal = retInfo.split("|")[1];
		$("#memberList tr:gt(0)").each(function(i,bt){
			$(bt).find("select").val(selVal);
			$(bt).find("input[type='text']").val(iptVal);
			if(selVal=="1"){
				$(bt).find("input[type='text']").attr("disabled","disabled");
			}else{
				$(bt).find("input[type='text']").removeAttr("disabled");
			}
		});
	}
} 


//����ȫ����ť
function allMemSet(){
	//ȡ��ǰ��Ա�б��е�ȫ���ֻ��ţ�ѭ����ֵ
	
	var memPhoneArray  = new Array();
	var defContNoArray = new Array();
	var feeLimitArray  = new Array();
	var limiTyprArray  = new Array();
	var showHit        = "";
	
	$("#memberList tr:gt(0)").each(function(i,bt){
		var tdSize = $(bt).find("td").size();
		
		var memPhone  = "";
		var defContNo = "";
		var feeLimit  = "";
		var limiType  = "";//�޶ʽ������
		
		if(tdSize==9){
				memPhone  = $(bt).find("td:eq(0)").text().trim();
				defContNo = $(bt).find("td:eq(1)").text().trim();
				feeLimit  = $(bt).find("td:eq(2)").find("input").val().trim();
				limiType  = $(bt).find("td:eq(2)").find("select").val();
				
				memPhoneArray.push(memPhone);
				defContNoArray.push(defContNo);
				feeLimitArray.push(feeLimit);
				limiTyprArray.push(limiType);
				
			feeLimit  = $(bt).find("td:eq(2)").find("input").val().trim();
			limiType  = $(bt).find("td:eq(2)").find("select").val();
			var t1 = /^\d+$/;
			if(feeLimit!=""){
				if(!t1.test(feeLimit)){
					showHit = "�޶����Ϊ������";
					$(bt).find("td:eq(2)").find("input").val("");
					$(bt).find("td:eq(2)").find("input").focus();
					return false;
				}
				
				if(parseInt(feeLimit)>5000){
					showHit = "��ͥΪ��Աÿ��֧���޶�ܳ���5000Ԫ";
					$(bt).find("td:eq(2)").find("input").val("");
					$(bt).find("td:eq(2)").find("input").focus();
					return false;
				}
				
				if(limiType=="0"&&parseInt(feeLimit)==0){
					showHit = "�޶���޶�Ӧ����0������������";
					$(bt).find("td:eq(2)").find("input").val("");
					$(bt).find("td:eq(2)").find("input").focus();
					return false;
				}
			}
			
		}
	});
	
		if(showHit!=""){
 			rdShowMessageDialog(showHit);
 			return;
 		}
	
	var h=600;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var retInfo=window.showModalDialog("Dlg_s1212Add.jsp?opCode=<%=opCode%>&opName=<%=opName%>","",prop);
	
	var feeArray  = new Array();
	var tempArray = new Array();
	var inHtml    = "";
	
	if(typeof(retInfo)!="undefined"&&retInfo!=""){
		for(var j = 0; j<memPhoneArray.length; j++){
			feeArray = retInfo.split("|");
			var aLen = feeArray.length-1;
			
				if(limiTyprArray[j]==0){
					for(var i=0; i<aLen; i++){
						inHtml += "<tr>";
						tempArray = feeArray[i].split("#");
						if(i==0){//��һ�����ڲ�ͬ
							inHtml += "<td rowspan='"+aLen+"'>";
							inHtml += memPhoneArray[j];
							inHtml += "</td>";
							inHtml += "<td rowspan='"+aLen+"'>"+defContNoArray[j]+"</td>";
							inHtml += "<td rowspan='"+aLen+"' align='center'><select onchange='setThisTrInpt(this)' style='width:90px'><option value='0' selected >�޶��</option><option value='1'>ȫ���</option></select>&nbsp;&nbsp;<input type='text'  maxlength='4'  style='width:30px' value='"+feeLimitArray[j]+"'  /></td>";
							inHtml += "<td>"+tempArray[3]+"</td>";
							inHtml += "<td>"+tempArray[0]+"</td>";
							inHtml += "<td>"+tempArray[1]+"</td>";
							inHtml += "<td>"+tempArray[4]+"</td>";
							inHtml += "<td>"+tempArray[2]+"</td>";
							inHtml += "<td rowspan='"+aLen+"'><input type='button' class='b_text'  vProp='u'  value='����' onclick='setThisFee(this,\""+memPhoneArray[j]+"\",\""+defContNoArray[j]+"\","+aLen+")' />&nbsp;&nbsp;";
							inHtml += "<input type='button' class='b_text' value='ɾ��' onclick='delThisMem(this,"+aLen+")' /></td>";
						}else{
							inHtml += "<td>"+tempArray[3]+"</td>";
							inHtml += "<td>"+tempArray[0]+"</td>";
							inHtml += "<td>"+tempArray[1]+"</td>";
							inHtml += "<td>"+tempArray[4]+"</td>";
							inHtml += "<td>"+tempArray[2]+"</td>";
						}
						inHtml += "</tr>";
					}
			}else{ 
							inHtml += "<tr><td>";
							inHtml += memPhoneArray[j];
							inHtml += "</td>";
							inHtml += "<td>"+defContNoArray[j]+"</td>";
							inHtml += "<td align='center'>";
							inHtml += "<select onchange='setThisTrInpt(this)' style='width:90px'><option value='0'>�޶��</option><option value='1' selected>ȫ���</option></select>&nbsp;&nbsp;";
							inHtml += "<input type='text'   maxlength='4'  style='width:30px' value='0' disabled /></td>";
							inHtml += "<td></td><td></td><td></td><td></td>";
							inHtml += "<td></td>";
							inHtml += "<td><input type='button' class='b_text' disabled  value='����' vProp='u' onclick='setThisFee(this,\""+memPhoneArray[j]+"\",\""+defContNoArray[j]+"\",1)' />&nbsp;&nbsp;";
							inHtml += "    <input type='button' class='b_text' value='ɾ��' onclick='delThisMem(this,1)' /></td></tr>";
			}	
		}
		$("#memberList tr:not(:first):not(:last)").remove();
		$("#memberList tr:first").after(inHtml);
	}	
}

$(document).ready(function(){
	ajaxGetMemPhoneList();
	<%
for(int i=0;i<feeStr.length;i++)
	{
%>
	js_fee[<%=i%>] = new Array();
<%	
		for(int j=0;j<feeStr[i].length;j++)
		{
			%>
			js_fee[<%=i%>][<%=j%>]="<%=feeStr[i][j].trim()%>";
			<%
		}
	}
	%>
});
</script>
</head>
<body>
<form name="frm" method="POST"  ">

<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="cust_name"            id="cust_name"            value="<%=cust_name%>" />
<input type="hidden" name="cust_id"              id="cust_id"              value="<%=cust_id%>" />
<input type="hidden" name="famContractNo"                                  value="<%=accountNo%>" />  
<input type="hidden" name="oriHandFee"           id="oriHandFee"           value="<%=functionFee%>" />
<input type="hidden" name="ccount"               id="ccount"               value="<%=isoweFee%>" />
<input type="hidden" name="sysAccept"            id="sysAccept"            value="<%=sLoginAccept%>" />
<input type="hidden" name="srv_no"               id="srv_no"               value=<%=srv_no%> />
<input type="hidden" name="opCode"                                         value="<%=opCode%>" />
<input type="hidden" name="opName"                                         value="<%=opName%>" />  
<input type="hidden" name="transFeeCode"         id="transFeeCode"         value="" />
<input type="hidden" name="transDetailCode"      id="transDetailCode"      value="" />
<input type="hidden" name="transFeeName"         id="transFeeName"         value="" />
<input type="hidden" name="memPhoneArray"                                  value="" />  
<input type="hidden" name="defContNoArray"                                 value="" />  
<input type="hidden" name="feeLimitArray"                                  value="" />  
<input type="hidden" name="payorderArray"                                  value="" />  
<input type="hidden" name="feeFlagArray"                                   value="" />  
<input type="hidden" name="detFlagArray"                                   value="" />  
<input type="hidden" name="rateFlagArray"                                  value="" />  
<input type="hidden" name="stopflagArray"                                  value="" />  
<input type="hidden" name="feeratioArray"                                  value="" />  
<input type="hidden" name="orderNewArray"                                  value="" />  
<input type="hidden" name="opType"                                         value="" />  




<div class="title">
<div id="title_zi">�ͻ�����</div>
</div>
	<table cellspacing="0">
		<tr>
		
			<td class="blue" nowrap width="18%">��ͻ���־</td>
			<td nowrap  width="33%"><b><font color="#FF0000"><%=grade_name%></font></b></td>
			<td nowrap class="blue"  width="18%">�ͻ�����</td>
			<td nowrap><%=type_name%></td>
		</tr>
		<tr>
			<td class="blue" nowrap>��ǰԤ��</td>
			<td nowrap><%=totalPrepay%></td>
			<td nowrap class="blue">��ǰǷ��</td>
			<td nowrap><%=totalOwe%></td>
		</tr>
		<tr>
			<td class="blue" nowrap>�ͻ�����</td>
			<td nowrap><%=cust_name%></td>
			<td nowrap class="blue">�ͻ���ַ</td>
			<td nowrap><%=custAddr%></td>
		</tr>
	</table>
</div>

<div id="Operation_Table">
	<div class="title">
  <div id="title_zi">������Ϣ</div>
 </div>
  <table cellspacing="0">
	<tr>
		<td class="blue"  width="18%">�ʺŲ�������</td>
		<td   nowrap class="blue">
			<q vType='setNg35Attr'>
			<input type="radio"  id="r_acc_opType"  name="r_acc_opType" checked value="a" onclick="chg_opType()" index="0">
			    ����
			  </q>
			  <q vType='setNg35Attr'>
			<input type="radio" id="r_acc_opType"  name="r_acc_opType" value="u" onclick="chg_opType()"  index="1">
			    �޸�
			    </q>
			    <q vType='setNg35Attr'>
			<input type="radio" id="r_acc_opType"  name="r_acc_opType" value="d" onclick="chg_opType()" index="2">
		      	ɾ��
		      	</q>
		 </td>
	</tr>
	<tr>
		<td nowrap class="blue" >�ֻ�����</td>
		<td nowrap  >
		 	<select id="memPhoneSel" name="memPhoneSel" onchange="setMemPhoneIptFuc(this)">
		 		<option value="">--��ѡ��--</option>
		 	</select>
		 	&nbsp;&nbsp;
		  <input   type="text"  name="memPhoneIpt" id="memPhoneIpt" maxlength="11"    />
		  &nbsp;&nbsp;
		  
			<input type="button" value="���&У��" class="b_text" onclick="addMemPhoneSetFunc()" />
		</td>						
				
	</tr>
	
 
   </table>
 </div>																									

<div id="Operation_Table">
	<div class="title">
  <div id="title_zi">��Ա�б�</div>
 </div>
<table id="memberList"  cellspacing="0">
	<tr>
		<th width="25%">�ֻ�����</th>
		<th width="25%">Ĭ�ϸ����˻�</th>	
		<th>���ѷ�ʽ</th>	
		<th width="8%" <%=hideStr%> >����˳��</th>	
		<th width="8%" <%=hideStr%> >���ô���</th>	
		<th width="8%" <%=hideStr%> >��ϸ����</th>	
		<th width="8%" <%=hideStr%> >���ñ���</th>	
		<th width="15%" <%=hideStr%> >��������</th>	
		<th width="15%">����</th>	
 </tr>
 

 
 <tr>
 		<td id="footer" nowrap align="center" colspan="9">
			<input class="b_foot_long" type="button"  vProp='u'  value="����ȫ��" onclick="allMemSetOFunc()" />
		</td>
 </tr>
 
 
</table>


			<input type="hidden"  name="t_handFee" id="t_handFee"  	value="<%="".equals(functionFee)?"0":functionFee %>" v_type=float <%if(hfrf){%>readonly<%}%>  />
			<input type="hidden"  name="t_factFee" id="t_factFee"    />
			<input type="hidden"  name="t_fewFee" id="t_fewFee"  />
				<input type="hidden"  name="t_sys_remark" id="t_sys_remark" />
				<input type="hidden"  name="t_op_remark" id="t_op_remark" />
			<input  type="hidden"  name="assuNote"  />
			
			
<table>
	<tr>
		<td id="footer" nowrap align="center" colspan="6">
			<input class="b_foot_long" type="button" name="b_print" value="ȷ��&��ӡ" onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()" index="20">
			<input class="b_foot" type="button" name="b_clear" value="���" onClick="frm.reset();" index="21">
			<input class="b_foot" type="button" name="b_back" value="�ر�" onClick="removeCurrentTab()" index="22">
		</td>
	</tr>
 </table>
   </div>
   <input type="hidden" name="cus_pass" value="<%=cus_pass%>" />
	 <%@ include file="/npage/include/footer.jsp" %>
	</form>
</body>
<!-- ningtn 2011-8-3 10:52:18 ���ӻ���������Χ -->
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>

<script language="javascript">
//-------1----------���ú���----------------------
function addSpc(num)
{
	var ret="";
	for(var i=0;i<num;i++)
	ret+=" ";
	return ret;
}

function thinkAdd(str,len)
{
	var existLen=0;
	var one="";
	var ret="";

	for(var i=0;i<str.length;i++)
	{
		existLen++;
		if(str.charCodeAt(i)>127)
		existLen++;
	}

	for(var i=0;i<len-existLen;i++)
	ret+=" ";
	return ret;
}

 
</script>
