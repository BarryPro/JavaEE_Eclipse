<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- baixf 20080613 modify �����������������������Ƹ���Ϊ�����ſͻ���ҵӦ��������  -->
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.06
 ģ��:���ſͻ���ҵӦ������
********************/
%>


	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>


<%		
  String opCode = request.getParameter("opcode");
  String opName = request.getParameter("opname");
	    
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String regionCode = (String)session.getAttribute("regCode");
    
%>
<%
  String retFlag="",retMsg="";
  String[] paraAray1 = new String[3];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String dept=request.getParameter("dept");
  String s_type="C";
 
  String passwordFromSer="";
  
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
 /* ��������� �����룬������Ϣ���ͻ��������ͻ���ַ��֤�����ͣ�֤�����룬ҵ��Ʒ�ƣ�
 			�����أ���ǰ״̬��VIP���𣬵�ǰ����,����Ԥ��
 */

  //retList = impl.callFXService("s8032Init", paraAray1, "21","phone",phoneNo);
%>
	<wtc:service name="s8032Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="21" >
	<wtc:param value="<%=paraAray1[0]%>"/>
    <wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="",
  vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="",vZw="",vTargetCode="";
  //String[][] tempArr= new String[][]{};
  String errCode = retCode1;
  String errMsg = retMsg1;
  if(tempArr.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s8032Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }
  else
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
	if(!errCode.equals("000000")){%>
		<script language="JavaScript">
			rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
			history.go(-1);
		</script>
	<%}
	else
	{
	  
	    bp_name = tempArr[0][2];//��������
	  
	    bp_add = tempArr[0][3];//�ͻ���ַ
	  
	    cardId_type = tempArr[0][4];//֤������
	 
	    cardId_no = tempArr[0][5];//֤������
	 
	    sm_code = tempArr[0][6];//ҵ��Ʒ��
	 
	    region_name = tempArr[0][7];//������
	
	    run_name = tempArr[0][8];//��ǰ״̬
	 
	    vip = tempArr[0][9];//�֣ɣм���
	 
	    posint = tempArr[0][10];//��ǰ����
	 
	    prepay_fee = tempArr[0][11];//����Ԥ��
	
	    vUnitId = tempArr[0][12];//����ID
	 
	    vUnitName = tempArr[0][13];//��������
	  
	    vUnitAddr = tempArr[0][14];//��λ��ַ
	 
	    vUnitZip = tempArr[0][15];//��λ�ʱ�
	 
	    vServiceNo = tempArr[0][16];//���Ź���
	 
	    vServiceName = tempArr[0][17];//���Ź�������
	 
	    vContactPhone = tempArr[0][18];//��ϵ�绰
	  
	    vContactPost = tempArr[0][19];//�����ʱ�
	 
	    passwordFromSer = tempArr[0][20];  //����
	}
  }

%>

<%
//******************�õ�����������***************************//
String printAccept="";
String[] inParams = new String[2];
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=phoneNo%>"  id="seq"/>
<%
	printAccept = seq;
	System.out.println(printAccept);

	//�ֻ�Ʒ��
	String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='4' and a.brand_code=b.brand_code and valid_flag='Y'   and b.is_valid='1' and substr(spec_type,1,1)='"+s_type+"'";
	System.out.println("sqlAgentCode====="+sqlAgentCode);
	inParams[0] = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code=:regionCode and a.sale_type='4' and a.brand_code=b.brand_code and valid_flag='Y'   and b.is_valid='1' and substr(spec_type,1,1)=:s_type";
	inParams[1] = "regionCode="+regionCode+",s_type="+s_type;
	//ArrayList agentCodeArr = co.spubqry32("2",sqlAgentCode);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="2">			
	<wtc:param value="<%=inParams[0]%>"/>	
	<wtc:param value="<%=inParams[1]%>"/>
	</wtc:service>	
	<wtc:array id="agentCodeStrTemp"  scope="end"/>
<%
  	String[][] agentCodeStr = agentCodeStrTemp;
 
                
	//�ֻ�����
	String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where  a.region_code='" + regionCode + "' and  a.type_code=b.res_code and sale_type='4' and a.brand_code=b.brand_code and valid_flag='Y'  and b.is_valid='1' and substr(spec_type,1,1)='"+s_type+"'";
	System.out.println("sqlPhoneType====="+sqlPhoneType);
	inParams[0] = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where  a.region_code=:regionCode and  a.type_code=b.res_code and sale_type='4' and a.brand_code=b.brand_code and valid_flag='Y'  and b.is_valid='1' and substr(spec_type,1,1)=:s_type";
	inParams[1] = "regionCode="+regionCode+",s_type="+s_type;
	//ArrayList phoneTypeArr = co.spubqry32("3",sqlPhoneType);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode3" retmsg="retMsg3" outnum="3">			
	<wtc:param value="<%=inParams[0]%>"/>	
	<wtc:param value="<%=inParams[1]%>"/>
	</wtc:service>	
	<wtc:array id="phoneTypeStrTemp"  scope="end"/>
<%
	String[][] phoneTypeStr = phoneTypeStrTemp;
	//Ӫ������
	String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.sale_price,a.prepay_limit from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='4' and valid_flag='Y' and  substr(spec_type,1,1)='"+s_type+"'";
	System.out.println("sqlsaleType====="+sqlsaleType);
	inParams[0] = "select unique a.sale_code,trim(a.sale_name), a.sale_price,a.prepay_limit from sPhoneSalCfg a where a.region_code=:regionCode and a.sale_type='4' and valid_flag='Y' and  substr(spec_type,1,1)=:s_type";
	inParams[1] = "regionCode="+regionCode+",s_type="+s_type;
	//ArrayList saleTypeArr = co.spubqry32("4",sqlsaleType);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode4" retmsg="retMsg4" outnum="4">			
	<wtc:param value="<%=inParams[0]%>"/>	
	<wtc:param value="<%=inParams[1]%>"/>
	</wtc:service>	
	<wtc:array id="saleTypeStrTemp"  scope="end"/>
<%
	String[][] saleTypeStr = saleTypeStrTemp;
	//��Ʒ����
	String sqlprodType = "select unique a.operation_code,a.product_code,a.operation_name,a.product_name from dbcustadm.ssaleproductcode  a where a.active_flag='1' ";
	System.out.println("sqlprodType====="+sqlprodType);
	//ArrayList prodTypeArr = co.spubqry32("4",sqlprodType);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode5" retmsg="retMsg5" outnum="4">			
	<wtc:param value="<%=sqlprodType%>"/>	
	</wtc:service>	
	<wtc:array id="prodTypeStrTemp"  scope="end"/>
<%
	String[][] prodTypeStr = prodTypeStrTemp;
	//ְ��
	String sqlzwType = "select unique item_code,item_name   from dbcustadm.sSaleZwCODE a ";
	System.out.println("sqlzwType====="+sqlzwType);
	//ArrayList zwTypeArr = co.spubqry32("2",sqlzwType);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode6" retmsg="retMsg6" outnum="2">			
	<wtc:param value="<%=sqlzwType%>"/>	
	</wtc:service>	
	<wtc:array id="zwTypeStrTemp"  scope="end"/>
<%
	String[][] zwTypeStr = zwTypeStrTemp;
	//�ն���;
	String sqltermType = "select unique item_code,item_name   from dbcustadm.sSaletermCODE a ";
	System.out.println("sqltermType====="+sqltermType);
	//ArrayList termTypeArr = co.spubqry32("2",sqltermType);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode7" retmsg="retMsg7" outnum="2">			
	<wtc:param value="<%=sqltermType%>"/>	
	</wtc:service>	
	<wtc:array id="termTypeStrTemp"  scope="end"/>
<%
  	String[][] termTypeStr = termTypeStrTemp;
  
   
   
  
%>
<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>���ſͻ���ҵӦ������</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

 <script language=javascript>
 
  onload=function()
  {	
  	
  }  
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
		
		ret_code =  parseInt(errorCode);
		
		
		if(retType=="getcard"){
			if( ret_code == 0 ){
				  tmpObj = "sale_code" 
				  document.all(tmpObj).options.length=0;
				  document.all(tmpObj).options.length=backArrMsg.length+1;	
	
				document.all(tmpObj).options[0].text="--��ѡ��--";
				document.all(tmpObj).options[0].value="";
				document.all(tmpObj).options[0].nv2="";
			    document.all(tmpObj).options[0].nv3="";

		        for(i=1;i<backArrMsg.length+1;i++)
			    {
				    document.all(tmpObj).options[i].text=backArrMsg[i-1][1];
				    document.all(tmpObj).options[i].value=backArrMsg[i-1][0];
		 	        document.all(tmpObj).options[i].nv2=backArrMsg[i-1][2];
			        document.all(tmpObj).options[i].nv3=backArrMsg[i-1][3];
			    }
			}else{
				rdShowMessageDialog("ȡ��Ϣ����:"+errorMsg+"!",0);
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
    			return ;
    		}
    		document.all.award_flag.value = 1;
    	}else{
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
function checkimeino()
{
	 if (document.frm.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
      document.frm.IMEINo.focus();
      document.frm.confirm.disabled = true;
	  return false;
     } 
     
	var myPacket = new AJAXPacket("queryimei.jsp","����У��IMEI��Ϣ�����Ժ�......");
	myPacket.data.add("imei_no",(document.all.IMEINo.value));
	myPacket.data.add("brand_code",(document.all.agent_code.options[document.all.agent_code.selectedIndex].value));
	myPacket.data.add("style_code",(document.all.phone_type.options[document.all.phone_type.selectedIndex].value));
	myPacket.data.add("opcode",(document.all.opcode.value));
	myPacket.data.add("retType","0");
	core.ajax.sendPacket(myPacket);
	myPacket=null;  
    
}
function viewConfirm()
{
	if(document.frm.IMEINo.value=="")
	{
		document.frm.confirm.disabled=true;
	}

}
 function change(){

	with(document.frm){

		price.value=0;
		pay_money.value=0;
		var i=price.value;
		var j=pay_money.value;
		sum_money.value=(parseFloat(i)+parseFloat(j)).toFixed(2);
		
		var getInstal_Packet = new AJAXPacket("f8030_getprepay.jsp","����У�����Ժ�......");
		getInstal_Packet.data.add("salecode",sale_code.options[sale_code.selectedIndex].value);
		getInstal_Packet.data.add("ajaxType","grp_cfg");
		core.ajax.sendPacket(getInstal_Packet,doGrpCfg);
		getInstal_Packet = null;		
	}
}


function doGrpCfg(packet)
{
	var retcode = packet.data.findValueByName("errorCode");
	var retMsg = packet.data.findValueByName("errorMsg");
	if (retcode!="000000")
	{		
		rdShowMessageDialog(retcode+":"+retMsg);
   		document.getElementById("sale_code").selectedIndex=0;
		return false;
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
	//System.out.println("arrsaleName["+l+"]='"+saleTypeStr[l][1]+"';\n");
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
 function printCommit()
 { 
 	getAfterPrompt();
  //У��
  //if(!check(frm)) return false;
  with(document.frm){
    if(cust_name.value==""){
	  rdShowMessageDialog("����������!");
      cust_name.focus();
	  return false;
	}
	if(agent_code.value==""){
	  rdShowMessageDialog("�������ֻ�Ʒ��!");
      agent_code.focus();
	  return false;
	}
	if(phone_type.value==""){
	  rdShowMessageDialog("�������ֻ��ͺ�!");
      phone_type.focus();
	  return false;
	}
	if(sale_code.value==""){
	  rdShowMessageDialog("������Ӫ������!");
      sale_code.focus();
	  return false;
	}
	if(vProductId.value==""){
	  rdShowMessageDialog("���Ų�ƷID����Ϊ��!");
      vProductId.focus();
	  return false;
	}
	if(vZw.value==""){
	  rdShowMessageDialog("ְλ����Ϊ��!");
      vZw.focus();
	  return false;
	}
	if(vTargetCode.value==""){
	  rdShowMessageDialog("�ն���;���ܲ���!");
      vTargetCode.focus();
	  return false;
	}
	if(vProductCode.value==""){
	  rdShowMessageDialog("���Ų�Ʒ����Ϊ��!");
      vProductCode.focus();
	  return false;
	}
	if (IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
      IMEINo.focus();
      confirm.disabled = true;
	  return false;
     } 
	
	document.all.phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
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
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var pType="subprint";                                      // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
   var billType="1";                                          //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
   var sysAccept="<%=printAccept%>";                          // ��ˮ��
   var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
   var mode_code=null;                                        //�ʷѴ���
   var fav_code=null;                                         //�ط�����
   var area_code=null;                                        //С������
   var opCode="<%=opCode%>";                                  //��������
   var phoneNo=document.all.phone_no.value;                   //�ͻ��绰
            /* ningtn */
    var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
    /* ningtn */

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
   path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;
}

function printInfo(printType)
{
  	vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="";
	var pay = document.all.pay_money.value;
  
  	var cust_info=""; //�ͻ���Ϣ
	var opr_info=""; //������Ϣ
	var note_info1=""; //��ע1
	var note_info2=""; //��ע2
	var note_info3=""; //��ע3
	var note_info4=""; //��ע4
    var retInfo = "";  //��ӡ����
	
	cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	
	opr_info+="��ϵ�绰��"+'<%=vContactPhone%>'+"|";
	opr_info+="סլ��ַ��"+'<%=bp_add%>'+"|";
	opr_info+="�������룺"+'<%=vContactPost%>'+"|";
	opr_info+="��λ��ַ��"+'<%=vUnitAddr%>'+"|";
	opr_info+="�������룺"+'<%=vUnitZip%>'+"|";
	opr_info+="�ͻ�����"+'<%=vServiceName%>'+"|";
	
	opr_info+="ҵ�����ࣺ���ſͻ����������ֻ�"+"|";
  	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
  	opr_info+="�ֻ��ͺţ�"+document.all.phone_typename.value+"|";
 	opr_info+="Ԥ�滰�ѣ�"+document.all.pay_money.value+"Ԫ"+"|";
	opr_info+="ҵ��ִ��ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd ", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	opr_info+="IMEI�룺"+document.all.IMEINo.value+"|";
	
	note_info1+="��ע��"+"�ֻ��ն˻��Զ��������϶�Ķ��Ž��в�֣���ͬ�ͺ��ֻ��ն˲��ԭ��ͬ���ҹ�˾�����ֻ��Զ���ֵ������շѡ�"+"|";
	if(document.all.award_flag.value == "1")
	{
		note_info1+= "�Ѳ���������Ʒ�"+"|";
	}
	else
	{
		note_info1+= " "+"|";
	}
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
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
	salechage();
	document.all.need_award.checked = false;   
	document.all.award_flag.value = 0;

 }
 
  function checkAward()
 {
 	 if(document.all.phone_type.value == "")
 	 {
 	 	 rdShowMessageDialog("����ѡ�����");
 	 	 document.all.need_award.checked = false;
 	 	 document.all.award_flag.value = 0;
 	 	 return;
 	 }
 	 if(document.all.need_award.checked )
 	 {
 	 	 var packet = new AJAXPacket("phone_getAwardRpc.jsp","���ڻ�ý�Ʒ��ϸ�����Ժ�......");
 	 	 packet.data.add("retType","checkAward");
 	 	 packet.data.add("op_code","8032");
 	 	 packet.data.add("style_code",document.all.phone_type.value );
 	 	 
 	 	 core.ajax.sendPacket(packet);
 	 	 packet=null;
 	 	 
 	 }
 	 document.all.award_flag.value = 0;
 	 
 }

 function salechage(){
   
	var getNote_Packet = new AJAXPacket("f8032_getprepay.jsp","���ڻ��Ӫ����ϸ�����Ժ�......");
    getNote_Packet.data.add("retType","getcard");
	getNote_Packet.data.add("agentCode",document.all.agent_code.value);
	getNote_Packet.data.add("phoneType",document.all.phone_type.value);
	getNote_Packet.data.add("saletype","1");
	getNote_Packet.data.add("regionCode","<%=regionCode%>");
	getNote_Packet.data.add("salecode",document.all.sale_code.value);
	core.ajax.sendPacket(getNote_Packet);
	getNote_Packet=null;
 }


//-->
</script>
</head>


<body>
<form name="frm" method="post" action="f8032Cfm.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
        <table cellspacing="0">
		  <tr> 
            <td class="blue">��������</td>
            <td colspan="3">���ſͻ���ҵӦ������--����</td>
          </tr>        
		  <tr> 
            <td class="blue">����ID</td>
            <td>
			  <input name="vUnitId" value="<%=vUnitId%>" type="text" class="InputGrey" v_must=1 readonly id="vUnitId"> 
            </td>
            <td class="blue" nowrap>��������</td>
            <td>
			  <input name="vUnitName" value="<%=vUnitName%>" type="text" class="InputGrey" v_must=1 readonly id="vUnitName"> 
            </td>
            </tr>
			<tr> 
            <td class="blue">���Ų�Ʒ����</td>
            <td colspan="3">
			  <select name="vProductCode">
                <option value ="">--��ѡ��--</option>
                
                <%for(int i = 0 ; i < prodTypeStr.length ; i ++){%>
                <option value="<%=prodTypeStr[i][1]%>"><%=prodTypeStr[i][3]%>
                	</option>
                <%}%>
               </select><font color="orange">*</font>
            </td>
            </tr>
			<tr> 
            <td class="blue">���Ų�ƷID</td>
            <td>
			  <input name="vProductId" value="" type="text" id="vProductId"> 
			  <font color="orange">*</font>
            </td>
            <td class="blue">�ͻ�����</td>
            <td>  
            	<input name="vServiceName" value="<%=vServiceName%>" type="text" id="vServiceName"> 
			</td>
            </tr>
		  <tr> 
            <td class="blue">�ͻ�����</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name"> 
            </td>
            <td class="blue">ְλ</td>
            <td>
			  <select name="vZw">
                <option value ="">--��ѡ��--</option>
                <%for(int i = 0 ; i < zwTypeStr.length ; i ++){%>
                <option value="<%=zwTypeStr[i][0]%>"><%=zwTypeStr[i][1]%>
                	</option>
                <%}%>
               </select>
			  <font color="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">֤������</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_type"> 
            </td>
            <td class="blue">֤������</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_no"> 
            </td>
            </tr>
            <tr> 
            <td class="blue">�ն���;</td>
            <td>
			  <select name="vTargetCode"  >
                <option value ="">--��ѡ��--</option>
                <%for(int i = 0 ; i < termTypeStr.length ; i ++){%>
                <option value="<%=termTypeStr[i][0]%>"><%=termTypeStr[i][1]%>
                	</option>
                <%}%>
               </select>
			  <font color="orange">*</font>
            </td>
            <td class="blue">����״̬</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text" class="InputGrey" v_must=1 readonly id="run_type" > 
            </td>
            </tr>
            <tr> 
            <td class="blue">VIP����</td>
            <td>
			  <input name="vip" value="<%=vip%>" type="text" class="InputGrey" v_must=1 readonly id="vip"> 
            </td>
            <td class="blue">����Ԥ��</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text" class="InputGrey" v_must=1 readonly id="prepay_fee"> 
            </td>
            </tr>
			<tr> 
            <td class="blue">�ֻ�Ʒ��</td>
            <td>
			  <SELECT id="agent_code" name="agent_code" v_must=1  onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);">  
			    <option value ="">--��ѡ��--</option>
			     <%System.out.println(agentCodeStr.length);%>
                <%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
                <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
                <%}%>
              </select>
			  <font color="orange">*</font>	
			</td>
	 		<td class="blue">�ֻ��ͺ�</td>
            <td>
			  <select size=1 name="phone_type" id="phone_type" v_must=1 onchange="typechange()">	
			  	  
              </select>
			  <font color="orange">*</font>
			</td>
          </tr>
          <tr> 
         
            <td class="blue">Ӫ������</td>
            <td>
			  <select size=1 name="sale_code" id="sale_code" v_must=1 onchange="change()">			  
              </select>
			  <font color="orange">*</font>
			</td>
      		<td colspan="2" class="blue">�Ƿ��������<input type="checkbox" name="need_award" onclick="checkAward()" />
				<input type="hidden" name="award_flag" value="0" />
			</td>
          </tr>
          <TR> 
			<TD class="blue"> 
				<div align="left">IMEI��</div>
            </TD>
            <TD colspan="3"> 
				<input name="IMEINo" type="text" v_type="0_9" value="" onblur="viewConfirm()">
				<input name="checkimei" class="b_text" type="button" value="У��" onclick="checkimeino()">
                <font color="orange">*</font>
            </TD>
          </TR>
		  <TR id=showHideTr> 
			<TD  class="blue" nowrap> 
				<div align="left">����ʱ��</div>
            </TD>
			<TD > 
				<input name="payTime" type="text" value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
				(������)<font color="orange">*</font>                  
			</TD>
			<TD class="blue"> 
				<div align="left">����ʱ��</div>
			</TD>
			<TD > 
				<input name="repairLimit" v_type="date.month" type="text" v_name="����ʱ��" value="12" onblur="viewConfirm()">
				(����)<font color="orange">*</font>
			</TD>
          </TR>
          <input type="hidden" name="price" value=0 >
          <input type="hidden" name="pay_money" value=0 >
          <input type="hidden" name="sum_money" value=0 >
          
          
          <tr> 
            <td class="blue">��ע</td>
            <td colspan="3">
             <input name="opNote" type="text" class="InputGrey" readOnly id="opNote" value="���ſͻ���ҵӦ������" > 
            </td>
          </tr>
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
          <tr> 
            <td colspan="4" id="footer"> <div align="center"> 
                <input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()">
                <input name="reset" type="reset" class="b_foot" value="���" >
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
                </div>
            </td>
          </tr>
        </table>

    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="4" >
    <input type="hidden" name="used_point" value="0" >  
	<input type="hidden" name="point_money" value="0" > 
	<input type="hidden" name="phone_typename" value="" >
	<%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>