<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-5
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<%		
	String opCode = "8030";
	String opName = "�����û�Ԥ�滰������";    
	String loginNo = (String)session.getAttribute("workNo");					//��������
	String regionCode = (String)session.getAttribute("regCode");				//����
	String phoneNo =(String) request.getParameter("phoneNo");				//�ֻ�����
	String opcode = request.getParameter("opcode");								//op_code
%>

<%
	String retFlag="",retMsg="";
	String[] paraAray1 = new String[3];
	
	String passwordFromSer="";
	String dept=request.getParameter("dept");
	String s_type="C";
 
	paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
	paraAray1[1] = opcode; 	    /* ��������   */
	paraAray1[2] = loginNo;	    /* ��������   */

  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	  
	}
  }
 /* ������� �����룬������Ϣ���ͻ��������ͻ���ַ��֤�����ͣ�֤�����룬ҵ��Ʒ�ƣ�
 			�����أ���ǰ״̬��VIP���𣬵�ǰ����,����Ԥ��
 */

  //retList = impl.callFXService("s8030Init", paraAray1, "21","phone",phoneNo);
  
%>

    <wtc:service name="s8030Init" outnum="21" retmsg="msg1" retcode="code1" routerKey="phoneNo" routerValue="<%=phoneNo%>">
			<wtc:param value="<%=paraAray1[0]%>" />
			<wtc:param value="<%=paraAray1[1]%>" />	
			<wtc:param value="<%=paraAray1[2]%>" />	
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />

<%  
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="",
  vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="";
  String errCode = code1;
  String errMsg = msg1;
  if(result_t == null)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s8030Init��ѯ���������ϢΪ��!<br>errCode " + errCode + "<br>errMsg+" + errMsg;
    }    
  }
  else
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
	if(!errCode.equals("000000")){%>
		<script language="JavaScript">
			rdShowMessageDialog("�������<%=errCode%>��������Ϣ<%=errMsg%>",0);
			history.go(-1);
		</script>
	<%}
	else
	{
	    bp_name = result_t[0][2];//��������
	    bp_add = result_t[0][3];//�ͻ���ַ
	    cardId_type = result_t[0][4];//֤������
	    cardId_no = result_t[0][5];//֤������
	    sm_code = result_t[0][6];//ҵ��Ʒ��
	    region_name = result_t[0][7];//������
	    run_name = result_t[0][8];//��ǰ״̬
	    vip = result_t[0][9];//�֣ɣм���
	    posint = result_t[0][10];//��ǰ����
	    prepay_fee = result_t[0][11];//����Ԥ��
	    vUnitId = result_t[0][12];//����ID
	    vUnitName = result_t[0][13];//��������
	    vUnitAddr = result_t[0][14];//��λ��ַ
	    vUnitZip = result_t[0][15];//��λ�ʱ�
	    vServiceNo = result_t[0][16];//���Ź���
	    vServiceName = result_t[0][17];//���Ź�������
	    vContactPhone = result_t[0][18];//��ϵ�绰
	    vContactPost = result_t[0][19];//�����ʱ�
	    passwordFromSer = result_t[0][20];  //����
	}
  }

%>
 <%  //�Ż���Ϣ//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//   

  String[][] favInfo = (String[][])session.getAttribute("favInfo"); //���ݸ�ʽΪString[0][0]---String[n][0]
  String handFee_Favourable = "readOnly";        //a230  ������
  int infoLen = favInfo.length;
  String tempStr = "";
 %>
<%
//******************�õ�����������***************************//
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>
<%
	String exeDate="";
	exeDate = getExeDate("1","1141");

 	// comImpl co=new comImpl();
  //�ֻ�Ʒ��
  String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='5' and a.brand_code=b.brand_code and valid_flag='Y' and b.is_valid='1' and substr(spec_type,1,1)='"+s_type+"'";
  //�ֻ�����
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and sale_type='5' and a.brand_code=b.brand_code and valid_flag='Y' and b.is_valid='1' and substr(spec_type,1,1)='"+s_type+"'";
  //Ӫ������
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.sale_price,a.prepay_limit from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='5' and valid_flag='Y' and substr(spec_type,1,1)='"+s_type+"'";
  //�ն���;
  String sqltermType = "select unique item_code,item_name   from sSaletermCODE a ";
   //��Ʒ����
  String sqlprodType = "select unique a.operation_code,a.product_code,a.operation_name,a.product_name from dbcustadm.ssaleproductcode  a where a.active_flag='1' ";
 
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlAgentCode%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

		<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlPhoneType%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>
	 	

		<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlsaleType%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>	 	
	 	
	 	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg4" retcode="code4" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqltermType%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t4" scope="end"/>	 		 		 
	 		 		 	 
	 	<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg5" retcode="code5" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlprodType%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t5" scope="end"/>	 		 		 	 
	 	
<%
	String[][] agentCodeStr = result_t1;
	String[][] phoneTypeStr = result_t2;
	String[][] saleTypeStr = result_t3;
	String[][] termTypeStr = result_t4;
	String[][] prodTypeStr = result_t5;

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>�����û�Ԥ�滰���Żݹ���</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
 <script language=javascript>

 function doProcess(packet){
 
 		errorCode = packet.data.findValueByName("errorCode");
		errorMsg =  packet.data.findValueByName("errorMsg");
		retType = packet.data.findValueByName("retType");
		backArrMsg = packet.data.findValueByName("backArrMsg");
		retResult = packet.data.findValueByName("retResult");
	
		self.status="";
		
		var tmpObj="";
		var i=0;
		var j=0;
		var ret_code=0;
		var tmpstr="";
		//alert(ret_code);
		ret_code =  parseInt(errorCode);
		//alert(ret_code);
		//alert("111111111111111111111111" +errorCode ); 
		//alert("111111111111111111111111" +errorMsg ); 
		
		if(retType=="getcard"){
			if( ret_code == 0 ){
				  tmpObj = "sale_code" 
				  document.all(tmpObj).options.length=0;
				  document.all(tmpObj).options.length=backArrMsg.length/4;	
		        for(i=0;i<backArrMsg.length/4;i++)
			    {
				    document.all(tmpObj).options[i].text=backArrMsg[i][1];
				    document.all(tmpObj).options[i].value=backArrMsg[i][0];
		 	        document.all(tmpObj).options[i].nv2=backArrMsg[i][2];
			        document.all(tmpObj).options[i].nv3=backArrMsg[i][3];
			    }
			}else{
				rdShowMessageDialog("ȡ��Ϣ����"+errorMsg+"!",0);
				return;			
			}
			change();
		}
		else if(retType == "checkAward")
		{
				var retCode = packet.data.findValueByName("retCode"); 
				var retMessage = packet.data.findValueByName("retMessage");
    		window.status = "";
    		if(retCode!=0){
    			rdShowMessageDialog(retMessage,0);
    			document.all.need_award.checked = false;
    			document.all.award_flag.value = 0;
    		}
    		document.all.award_flag.value = 1;
    	}else{
			//alert(retResult);
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI��У��ɹ�1��",2);
					document.frm.confirm.disabled=false;
					document.frm.IMEINo.readOnly=true;
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI��У��ɹ�2��",2);
					document.frm.confirm.disabled=false;
					document.frm.IMEINo.readOnly=true;
					return ;

			}else if(retResult == "000003"){
					rdShowMessageDialog("IMEI�Ų���ӪҵԱ����Ӫҵ����IMEI����ҵ�������Ͳ�����",0);
					document.frm.confirm.disabled=true;
					return false;
			}else{
					rdShowMessageDialog("IMEI�Ų����ڻ����Ѿ�ʹ�ã�",0);
					document.frm.confirm.disabled=true;
					return false;
			}
		}
 }
 function change(){
	with(document.frm){

		price.value=sale_code.options[sale_code.selectedIndex].nv2;
		pay_money.value=sale_code.options[sale_code.selectedIndex].nv3;
		var i=price.value;
		var j=pay_money.value;
		sum_money.value=(parseFloat(i)+parseFloat(j)).toFixed(2);
	}
}
 </script>
<script language="JavaScript">

<!--
  //����Ӧ��ȫ�ֵı���
  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

  var arrPhoneType = new Array();//�ֻ��ͺŴ���
  var arrPhoneName = new Array();//�ֻ��ͺ�����
  var arrAgentCode = new Array();//�����̴���
  var selectStatus = 0;
  
  var arrsalecode =new Array();
  var arrsaleName=new Array();
  var arrsalePrice=new Array();
  var arrsaleLimit=new Array();
  var arrsaletype=new Array();
  


 
<%  
  for(int i=0;i<phoneTypeStr.length;i++)
  {
	out.println("arrPhoneType["+i+"]='"+phoneTypeStr[i][0]+"';\n");
	out.println("arrPhoneName["+i+"]='"+phoneTypeStr[i][1]+"';\n");
	out.println("arrAgentCode["+i+"]='"+phoneTypeStr[i][2]+"';\n");
  }  
  for(int l=0;l<saleTypeStr.length;l++)
  {
	out.println("arrsalecode["+l+"]='"+saleTypeStr[l][0]+"';\n");
	out.println("arrsaleName["+l+"]='"+saleTypeStr[l][1]+"';\n");
	out.println("arrsalePrice["+l+"]='"+saleTypeStr[l][2]+"';\n");
	out.println("arrsaleLimit["+l+"]='"+saleTypeStr[l][3]+"';\n");
	
  }  
%>
	
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
 //***
 function checkimeino()
{
	 if (document.frm.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!",0);
      document.frm.IMEINo.focus();
      document.frm.confirm.disabled = true;
	  return false;
     } 
     
	//alert(document.all.agent_code.options[document.all.agent_code.selectedIndex].value);
	//alert(document.all.phone_type.options[document.all.phone_type.selectedIndex].value);
	//alert(document.all.IMEINo.value);
	var myPacket = new AJAXPacket("queryimei.jsp","����У��IMEI��Ϣ�����Ժ�......");
	myPacket.data.add("imei_no",(document.all.IMEINo.value).trim());
	myPacket.data.add("brand_code",(document.all.agent_code.options[document.all.agent_code.selectedIndex].value).trim());
	myPacket.data.add("style_code",(document.all.phone_type.options[document.all.phone_type.selectedIndex].value).trim());
	myPacket.data.add("retType","0");
	myPacket.data.add("opcode",(document.all.opcode.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket = null;  
    
}

 function viewConfirm()
{
	if(document.frm.IMEINo.value=="")
	{
		document.frm.confirm.disabled=true;
	}

}

 
 function printCommit()
 { 
 	getAfterPrompt();
  //У��
  //if(!check(frm)) return false;
  with(document.frm){
    if(cust_name.value==""){
	  rdShowMessageDialog("����������!",0);
      cust_name.focus();
	  return false;
	}
	if(vTargetCode.value==""){
	  rdShowMessageDialog("�ն���;���ܲ���!",0);
      phone_type.focus();
	  return false;
	}
	if(vProductCode.value==""){
	  rdShowMessageDialog("���Ų�Ʒ����Ϊ��!",0);
      vProductCode.focus();
	  return false;
	}
	
	if(agent_code.value==""){
	  rdShowMessageDialog("�������ֻ�Ʒ��!",0);
      agent_code.focus();
	  return false;
	}
	if(phone_type.value==""){
	  rdShowMessageDialog("�������ֻ��ͺ�!",0);
      phone_type.focus();
	  return false;
	}
	if(sale_code.value==""){
	  rdShowMessageDialog("������Ӫ������!",0);
      sale_code.focus();
	  return false;
	}
	if(vProductId.value==""){
	  rdShowMessageDialog("���Ų�ƷID����Ϊ��!",0);
      vProductId.focus();
	  return false;
	}
	if (IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!",0);
      IMEINo.focus();
      confirm.disabled = true;
	  return false;
     } 
	 if (sale_month.value == "") {
      rdShowMessageDialog("Ӫ��������ʱ�䲻��Ϊ�գ����������� !!",0);
      sale_month.focus();
      confirm.disabled = true;
	  return false;
     } 
	document.all.phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
	
	document.all.consum_note.value = document.all.sale_month.options[document.all.sale_month.selectedIndex].text;
  }
 //��ӡ�������ύ��
  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
      {
	    frmCfm();
      }
	}
	if(ret=="continueSub")
	{
      if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
      {
	    frmCfm();
      }
	}
  }
  else
  {
     if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
     {
	   frmCfm();
     }
  }
  return true;
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
    var h=180;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo();
	 //alert(printStr);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     
     var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =document.all.login_accept.value;                       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                        //�ʷѴ���
     var fav_code=null;                         //�ط�����
     var area_code=null;                        //С������
     var opCode =   "<%=opCode%>";                           //��������
     var phoneNo = "<%=phoneNo%>";                             //�ͻ��绰
     
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
		
}

function printInfo(printType)
{
  vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="";
	var month_fee ;
	var pay = document.all.pay_money.value;
	month_fee= Math.round(pay/12);

  	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		  
	var retInfo = "";
	cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	cust_info+="��ϵ�˵绰��"+'<%=vContactPhone%>'+"|";
	cust_info+="�ͻ���ַ��"+document.all.cust_addr.value+"|";
	opr_info+="�������룺"+'<%=vContactPost%>'+"|";
	opr_info+="��λ��ַ��"+'<%=vUnitAddr%>'+"|";
	opr_info+="�������룺"+'<%=vUnitZip%>'+"|";
	opr_info+="�ͻ�����"+'<%=vServiceName%>'+"|";
	
	opr_info+="ҵ�����༯�ſͻ��ֻ���"+"|";
  	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
  	opr_info+="�ֻ��ͺţ�"+document.all.phone_typename.value+"      IMEI����"+document.all.IMEINo.value+"|";
 	opr_info+="Ԥ�滰�ѣ�"+document.all.pay_money.value+"Ԫ"+"|";
	opr_info+="ҵ��ִ��ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd ", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	note_info1+="��ע���ֻ��ն˻��Զ��������϶�Ķ��Ž��в�֣���ͬ�ͺ��ֻ��ն˲��ԭ��ͬ���ҹ�˾�����ֻ��Զ���ֵ������շѡ�"+"|";


		
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

	if(document.all.award_flag.value == "1")
	{
		retInfo+= "�Ѳ���������Ʒ�"+"|";
	}
	else
	{
		retInfo+= " "+"|";
	}
    return retInfo;	
}



//-->
</script>

<script language="JavaScript">
<!--
/****************����agent_code��̬����phone_type������************************/
 function selectChange(control, controlToPopulate, ItemArray, GroupArray)
 {
   var myEle ;
   var x ;
   // Empty the second drop down box of any choices
   for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
   // ADD Default Choice - in case there are no values
    
   myEle = document.createElement("option") ;
    myEle.value = "";
        myEle.text ="--��ѡ��--";
        controlToPopulate.add(myEle) ;
   for ( x = 0 ; x < ItemArray.length  ; x++ )
   {
      if ( GroupArray[x] == control.value )
      {
        myEle = document.createElement("option") ;
        myEle.value = arrPhoneType[x] ;
        myEle.text = ItemArray[x] ;
        controlToPopulate.add(myEle) ;
      }
   }
   
   document.all.need_award.checked = false;   
   document.all.award_flag.value = 0;

 } 
 function typechange(){
 
 	var myEle1 ;
   	var x1 ;
   	for (var q1=document.all.sale_code.options.length;q1>=0;q1--) document.all.sale_code.options[q1]=null;
   	myEle1 = document.createElement("option") ;
    	myEle1.value = "";
        myEle1.text ="--��ѡ��--";
        document.all.sale_code.add(myEle1) ;
           	
   	for ( x1 = 0 ; x1 < arrsaletype.length  ; x1++ )
   	{
      		if ( arrsaletype[x1] == document.all.phone_type.value  && arrsalebarnd[x1] == document.all.agent_code.value)
      		{
        		myEle1 = document.createElement("option") ;
        		myEle1.value = arrsalecode[x1];
        		myEle1.text = arrsaleName[x1];
        		document.all.sale_code.add(myEle1) ;
      		}
   	}
   	document.all.need_award.checked = false;   
   	document.all.award_flag.value = 0;

	salechage();

 }
 
 function checkAward()
 {
 	 if(document.all.phone_type.value == "")
 	 {
 	 	 rdShowMessageDialog("����ѡ�����",0);
 	 	 document.all.need_award.checked = false;
 	 	 document.all.award_flag.value = 0;
 	 	 return;
 	 }
 	 if(document.all.need_award.checked )
 	 {
 	 	 var packet = new AJAXPacket("phone_getAwardRpc.jsp","���ڻ�ý�Ʒ��ϸ�����Ժ�......");
 	 	 packet.data.add("retType","checkAward");
 	 	 packet.data.add("op_code","8030");
 	 	 packet.data.add("style_code",document.all.phone_type.value );
 	 	 
 	 	 core.ajax.sendPacket(packet);
 	 	 packet = null;
 	 	 
 	 }
 	 document.all.award_flag.value = 0;
 	 
 }

 function salechage(){
   
	var getNote_Packet = new AJAXPacket("f8030_getprepay.jsp","���ڻ��Ӫ����ϸ�����Ժ�......");
  getNote_Packet.data.add("retType","getcard");
	getNote_Packet.data.add("agentCode",document.all.agent_code.value);
	getNote_Packet.data.add("phoneType",document.all.phone_type.value);
	getNote_Packet.data.add("saletype","5");
	getNote_Packet.data.add("regionCode","<%=regionCode%>");
	getNote_Packet.data.add("salecode",document.all.sale_code.value);
	core.ajax.sendPacket(getNote_Packet);
	getNote_Packet = null;
	
 }


//-->
</script>


</head>


<body>
<form name="frm" method="post" action="f8030Cfm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">�����û�Ԥ�滰���Żݹ���</div>
	</div>

        <table cellspacing="0">
		  <tr bgcolor="E8E8E8"> 
            <td class="blue" class="blue">��������</td>
            <td class="blue">�����û�Ԥ�滰���Żݹ���--����</td>
            <td class="blue">&nbsp;</td>
            <td class="blue">&nbsp;</td>
          </tr>        
		  <tr> 
            <td class="blue">����ID</td>
            <td class="blue">
			  <input name="vUnitId" value="<%=vUnitId%>" type="text" v_must=1 Class="InputGrey" readOnly id="vUnitId" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">��������</td>
            <td class="blue">
			  <input name="vUnitName" value="<%=vUnitName%>" type="text"  v_must=1  Class="InputGrey" readOnly id="vUnitName"  > 
			  <font class="orange">*</font>
            </td>
            </tr>

			<tr> 
            <td class="blue">�ն���;</td>
            <td class="blue">
			  <select   name="vTargetCode"  >
                <option value ="">--��ѡ��--</option>
                <%for(int i = 0 ; i < termTypeStr.length ; i ++){%>
                <option value="<%=termTypeStr[i][0]%>"><%=termTypeStr[i][1]%>
                </option>
                <%}%>
               </select>
			  <font class="orange">*</font>
            </td>
            <td class="blue">���Ų�Ʒ����</td>
            <td class="blue">
			  <select   name="vProductCode"  >
                <option value ="">--��ѡ��--</option>
                
                <%for(int i = 0 ; i < prodTypeStr.length ; i ++){%>
                <option value="<%=prodTypeStr[i][1]%>"><%=prodTypeStr[i][3]%>
                	</option>
                <%}%>
               </select>
			  <font class="orange">*</font>
            </td>
            </tr>
			<tr> 
            <td class="blue">���Ų�ƷID</td>
            <td class="blue">
			  <input name="vProductId" value="" type="text"  id="vProductId" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">&nbsp;</td>
            <td class="blue">&nbsp;</td>
            </tr>
		  
		  
		  <tr> 
            <td class="blue">�ͻ�����</td>
            <td class="blue">
			  <input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1  Class="InputGrey" readOnly id="cust_name" maxlength="20" v_name="����"> 
			  <font class="orange">*</font>
            </td>
            <td class="blue">�ͻ���ַ</td>
            <td class="blue">
			  <input name="cust_addr" value="<%=bp_add%>" type="text"  v_must=1  Class="InputGrey" readOnly id="cust_addr" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">֤������</td>
            <td class="blue">
			  <input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1  Class="InputGrey" readOnly id="cardId_type" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">֤������</td>
            <td class="blue">
			  <input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1  Class="InputGrey" readOnly id="cardId_no" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">ҵ��Ʒ��</td>
            <td class="blue">
			  <input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1  Class="InputGrey" readOnly id="sm_code" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">����״̬</td>
            <td class="blue">
			  <input name="run_type" value="<%=run_name%>" type="text"  v_must=1  Class="InputGrey" readOnly id="run_type" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">VIP����</td>
            <td class="blue">
			  <input name="vip" value="<%=vip%>" type="text"  v_must=1  Class="InputGrey" readOnly id="vip" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">����Ԥ��</td>
            <td class="blue">
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1  Class="InputGrey" readOnly id="prepay_fee" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            
			
			
			
			
			<tr> 
            <td class="blue">�ֻ�Ʒ��</td>
            <td class="blue">
			  <SELECT id="agent_code" name="agent_code" v_must=1  onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);" v_name="�ֻ�������">  
			    <option value ="">--��ѡ��--</option>
                <%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
                <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
                <%}%>
              </select>
			  <font class="orange">*</font>	
			</td>
	 <td class="blue">�ֻ��ͺ�</td>
            <td class="blue">
			  <select size=1 name="phone_type" id="phone_type" v_must=1 v_name="�ֻ��ͺ�" onchange="typechange()">	
			  	  
              </select>
			  <font class="orange">*</font>
			</td>
          </tr>
          <tr> 
         
            <td class="blue">Ӫ������</td>
            <td class="blue" >
			  <select size=1 name="sale_code" id="sale_code" v_must=1 v_name="Ӫ������" onchange="change()">			  
              </select>
			  <font class="orange">*</font>
			</td>
			<td class="blue">Ӫ��������ʱ��</td>
            <td class="blue" colspan="3">
			  <select size=1 name="sale_month" id="sale_month" v_must=1 v_name="Ӫ��������ʱ��" >
			  <option value ="">--��ѡ��--</option>
			  <option value ="12w">12����������</option>
			  <option value ="18w">18����������</option>
			  <option value ="24w">24����������</option>
			  <option value ="36w">36����������</option>
			  <option value ="12f">��12��������</option>
			  <option value ="24f">��24��������</option>
			  <option value ="36f">��36��������</option>
              </select>
			  <font class="orange">*</font>
			</td>
            
          </tr>
          <tr> 
            <td class="blue" >������</td>
            <td class="blue" >
			  <input name="price" type="text"  id="price" v_type="money" v_must=1    Class="InputGrey" readOnly v_name="�ֻ��۸�" >
			  <font class="orange">*</font>	
			</td>
            <td class="blue">Ԥ�滰��</td>
            <td class="blue">
			  <input name="pay_money" type="text"   id="pay_money" v_type="0_9" v_must=1   v_name="Ԥ�滰��"  Class="InputGrey" readOnly>
			  <font class="orange">*</font>
			</td>
          </tr>
          <tr> 
            <td class="blue" >Ӧ�����</td>
            <td class="blue" >
			  <input name="sum_money" type="text"  id="sum_money"  Class="InputGrey" readOnly>
			  <font class="orange">*</font>
			</td>
            <td class="blue" colspan="2">�Ƿ��������<input type="checkbox" name="need_award" onclick="checkAward()" />
				<input type="hidden" name="award_flag" value="0" />
			</td>
          </tr> 
          <TR bgcolor="#EEEEEE"> 
			<td class="blue"  nowrap> 
				<div align="left">IMEI��</div>
            </TD>
            <td class="blue" > 
				<input name="IMEINo"  type="text" v_type="0_9" v_name="IMEI��"  maxlength=15 value="" onblur="viewConfirm()">
				<input name="checkimei"  type="button" value="У��" onclick="checkimeino()" class="b_text">
                <font class="orange">*</font>
            </TD>
			<td class="blue">&nbsp;
			</td>
			<td class="blue">&nbsp;
			</td>
          </TR>
		  <TR bgcolor="#EEEEEE" id=showHideTr > 
			<td class="blue"  nowrap> 
				<div align="left">����ʱ��</div>
            </TD>
			<td class="blue" > 
				<input name="payTime"  type="text" v_name="����ʱ��"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
				(������)<font class="orange">*</font>                  
			</TD>
			<td class="blue"  nowrap> 
				<div align="left">����ʱ�� </div>
			</TD>
			<td class="blue" > 
				<input name="repairLimit" v_type="date.month"  size="10" type="text" v_name="����ʱ��" value="12" onblur="viewConfirm()">
				(����)<font class="orange">*</font>
			</TD>
          </TR>
		  <tr bgcolor="E8E8E8"> 
            <td class="blue" height="32">��ע</td>
            <td class="blue" colspan="3" height="32">
             <input name="opNote" type="text" id="opNote" size="60" maxlength="60" value="�����û�Ԥ�滰���Żݹ���" class="InputGrey" readOnly> 
            </td>
          </tr>
          <tr> 
            <td class="blue" colspan="4"> <div align="center"> 
                <input name="confirm" type="button"  index="2" value="ȷ��&��ӡ" onClick="printCommit()" class="b_foot_long">
                &nbsp; 
                <input name="reset" type="reset"  value="���" class="b_foot">
                &nbsp; 
                <input name="back" onClick="history.go(-1);" type="button"  value="����" class="b_foot"s>
                &nbsp; </div></td>
          </tr>
        </table>

    <input type="hidden" name="consum_note" value="">
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="5" >
    <input type="hidden" name="used_point" value="0" >  
	<input type="hidden" name="point_money" value="0" > 
	<input type="hidden" name="phone_typename" value="" >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>