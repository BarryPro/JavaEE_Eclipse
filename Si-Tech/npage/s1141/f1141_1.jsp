<%
/********************
 version v2.0
������: si-tech
update:liutong@20080905
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
  /**ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
  String[][] baseInfoSession = (String[][])arrSession.get(0);
  String[][] otherInfoSession = (String[][])arrSession.get(2);
  String[][] pass = (String[][])arrSession.get(4);

  String loginNo = baseInfoSession[0][2];
  String loginName = baseInfoSession[0][3];
  String powerCode= otherInfoSession[0][4];
  String orgCode = baseInfoSession[0][16];
  String ip_Addr = request.getRemoteAddr();
  String regionCode = orgCode.substring(0,2);
  String regionName = otherInfoSession[0][5];
  String loginNoPass = pass[0][0];
  String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
  **/

	String opCode = "1141";
	String opName = "Ԥ�滰���Żݹ���";
	String loginNo =(String)session.getAttribute("workNo");
	String loginName =(String)session.getAttribute("workName");
	String powerCode =(String)session.getAttribute("powerCode");
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String ip_Addr =(String)session.getAttribute("ip_Addr");
	String op_code=request.getParameter("opCode");
  String loginPwd    = (String)session.getAttribute("password");
	String groupId = (String)session.getAttribute("groupId");
%>
<%
	String retFlag="",retMsg="";
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//ArrayList retList = new ArrayList();
	String[] paraAray1 = new String[3];
	String phoneNo = request.getParameter("srv_no");
	String opcode = request.getParameter("opcode");
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

/** retList = impl.callFXService("s1141Qry", paraAray1, "14","phone",phoneNo);


  int errCode = impl.getErrCode();
  String errMsg = impl.getErrMsg();
  **/


  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String[][] tempArr= new String[][]{};
%>
			<wtc:service name="s1141Qry" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="14" >
					
		<wtc:param value=" "/>
		<wtc:param value="01"/>		
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=loginPwd%>"/>										
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value=""/>	
				
			</wtc:service>
			<wtc:array id="result" scope="end" />
<%
System.out.println("1141!~~~s1141Qry~~~errCode="+errCode);

if(errCode.equals("0")||errCode.equals("000000")){
System.out.println("���÷���s1141Qry in f1141_1.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");

 if(result == null)
  {
				if(!retFlag.equals("1"))
				{
					System.out.println("retFlag=   "+retFlag);
				   retFlag = "1";
				   retMsg = "s1141Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
			    }
  }
  else
  {
							  	System.out.println("errCode=  "+errCode);
							  	System.out.println("errMsg=   "+errMsg);
							  	System.out.println("________________________-- result.length  "+  result.length);
		System.out.println("_________________________________________________________________________");
	    for(int i=0;i<result.length;i++){
	      for(int j=0;j<result[i].length;j++){
	      System.out.println("result["+i+"]["+j+"]"+"   "+result[i][j]);

	      }


	    }
System.out.println("_________________________________________________________________________");



							  tempArr = result;
							  if(!(tempArr==null)){
							    bp_name = result[0][2];//��������
							    System.out.println(bp_name);
							  }
							 // tempArr = (String[][])retList.get(3);
							  if(!(tempArr==null)){
							    bp_add = result[0][3];//�ͻ���ַ
							  }
							 // tempArr = (String[][])retList.get(4);
							  if(!(tempArr==null)){
							    cardId_type =result[0][4];//֤������
							  }
							 /// tempArr = (String[][])retList.get(5);
							  if(!(tempArr==null)){
							    cardId_no = result[0][5];//֤������
							  }
							//  tempArr = (String[][])retList.get(6);
							  if(!(tempArr==null)){
							    sm_code =result[0][6];//ҵ��Ʒ��
							  }
							 // tempArr = (String[][])retList.get(7);
							  if(!(tempArr==null)){
							    region_name = result[0][7];//������
							  }
							//  tempArr = (String[][])retList.get(8);
							  if(!(tempArr==null)){
							    run_name = result[0][8];//��ǰ״̬
							  }
							//  tempArr = (String[][])retList.get(9);
							  if(!(tempArr==null)){
							    vip = result[0][9];//�֣ɣм���
							  }
							//  tempArr = (String[][])retList.get(10);
							  if(!(tempArr==null)){
							    posint = result[0][10];//��ǰ����
							  }
							//  tempArr = (String[][])retList.get(11);
							  if(!(tempArr==null)){
							    prepay_fee = result[0][11];//����Ԥ��
							  }
						//	  tempArr = (String[][])retList.get(13);
							  if(!(tempArr==null)){
							    passwordFromSer = result[0][13];  //����
							  }

  }



}else{
System.out.println("���÷���s1141Qry in f1141_1.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
			<script language="JavaScript">
				rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
				history.go(-1);
			</script>
<%
}

//******************�õ�����������***************************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
String exeDate="";
exeDate = getExeDate("1","1141");

 // comImpl co=new comImpl();
  //�ֻ�Ʒ��
  String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='1' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'P%' and is_valid='1'";
  System.out.println("*******************************************************************");
  System.out.println("sqlAgentCode====="+sqlAgentCode);
  System.out.println("*******************************************************************");
 // ArrayList agentCodeArr = co.spubqry32("2",sqlAgentCode);
  //String[][] agentCodeStr = (String[][])agentCodeArr.get(0);

%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="3">
<wtc:sql><%=sqlAgentCode%></wtc:sql>
</wtc:pubselect>
<wtc:array id="agentCodeStr" scope="end" />

<%
  //���ж�һ���ǲ��Ƿ������ʧ��
          if(retCode1.equals("0")||retCode1.equals("000000")){
          System.out.println("���÷���sPubSelect in f1141_1.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");


 	     	}else{
 			System.out.println("���÷���sPubSelect in f1141_1.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");

					%>
						<script language="JavaScript">
							rdShowMessageDialog("�������ʧ�ܣ�");
							history.go(-1);
						</script>
					<%

 			}


  //�ֻ�����
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and sale_type='1' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'P%' and is_valid='1'";
  System.out.println("sqlPhoneType====="+sqlPhoneType);
  //ArrayList phoneTypeArr = co.spubqry32("3",sqlPhoneType);
  //String[][] phoneTypeStr = (String[][])phoneTypeArr.get(0);

%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="4">
<wtc:sql><%=sqlPhoneType%></wtc:sql>
</wtc:pubselect>
<wtc:array id="phoneTypeStr" scope="end" />

<%

          if(retCode2.equals("0")||retCode2.equals("000000")){
          System.out.println("���÷���sPubSelect in f1141_1.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");


 	     	}else{
 			System.out.println("���÷���sPubSelect in f1141_1.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");

					%>
						<script language="JavaScript">
							rdShowMessageDialog("�������ʧ�ܣ�");
							history.go(-1);
						</script>
					<%

 			}



  //Ӫ������
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.sale_price,a.prepay_limit from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='1' and valid_flag='Y' and a.spec_type like 'P%'";
  System.out.println("sqlsaleType====="+sqlsaleType);
 // ArrayList saleTypeArr = co.spubqry32("4",sqlsaleType);
 // String[][] saleTypeStr = (String[][])saleTypeArr.get(0);

%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="5">
<wtc:sql><%=sqlsaleType%></wtc:sql>
</wtc:pubselect>
<wtc:array id="saleTypeStr" scope="end" />

<%

          if(retCode2.equals("0")||retCode2.equals("000000")){
          System.out.println("���÷���sPubSelect in f1141_1.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");


 	     	}else{
 			System.out.println("���÷���sPubSelect in f1141_1.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");

					%>
						<script language="JavaScript">
							rdShowMessageDialog("�������ʧ�ܣ�");
							history.go(-1);
						</script>
					<%

 			}


%>
<%
	/* ningtn �Ų��ܼ����� */
	String password = (String)session.getAttribute("password");
	String[] paraAray4 = new String[7];
	paraAray4[0] = printAccept;
	paraAray4[1] = "01";
	paraAray4[2] = opCode;
	paraAray4[3] = loginNo;
	paraAray4[4] = password;
	paraAray4[5] = phoneNo;
	paraAray4[6] = "";
	String showText = "";
%>
	<wtc:service name="sAdTermQry" routerKey="regionCode" routerValue="<%=regionCode%>"  
				 retcode="retCode4" retmsg="retMsg4"  outnum="3" >
		<wtc:param value="<%=paraAray4[0]%>"/>
		<wtc:param value="<%=paraAray4[1]%>"/>
		<wtc:param value="<%=paraAray4[2]%>"/>
		<wtc:param value="<%=paraAray4[3]%>"/>
		<wtc:param value="<%=paraAray4[4]%>"/>
		<wtc:param value="<%=paraAray4[5]%>"/>
		<wtc:param value="<%=paraAray4[6]%>"/>
	</wtc:service>
	<wtc:array id="result4" scope="end" />
<%
	if("000000".equals(retCode4)){
		System.out.println("~~~~����sAdTermQry�ɹ�~~~~");
		if(result4 != null && result4.length > 0){
			showText = result4[0][2];
		}
	}else{
		System.out.println("~~~~����sAdTermQryʧ��~~~~");
%>
			<script language="JavaScript">
				rdShowMessageDialog("������룺<%=retCode4%>��������Ϣ��<%=retMsg4%>");
				history.go(-1);
			</script>
<%
	}
%>
<html>
<head>
<title>Ԥ�滰���Żݹ���</title>


 <script language=javascript>

  onload=function()
  {

  }
  
  /*zhangyan add*/
function getUsedPoint()
{
	/*У��*/
	if(document.all.agent_code.value=="")
	{
		rdShowMessageDialog("��ѡ���ֻ�Ʒ��!");
		document.all.agent_code.focus();
		return false;
	}
	
	if(document.all.phone_type.value=="")
	{
		rdShowMessageDialog("��ѡ���ֻ��ͺ�!");
		document.all.phone_type.focus();
		return false;
	}
	
	if(document.all.sale_code.value=="")
	{
		rdShowMessageDialog("��ѡ��Ӫ������!");
		document.all.sale_code.focus();
		return false;
	}	
	
	/*ָ��Ajax����ҳ*/
	var packet = new AJAXPacket("f1141Ajax.jsp","���Ժ�...");
		
	/*��ajaxҳ�洫�ݲ���*/
	packet.data.add("opCode","<%=opCode%>" );
	packet.data.add("ajaxType","getM" );
	packet.data.add("phoneNo","<%=phoneNo%>" );
	/*������*/
	packet.data.add("machPrice",document.all.price.value );
	/*���ѻ���*/
	packet.data.add("markPoint",  parseInt(document.all.used_point.value ,10));
	
	/*����ҳ��,��ָ���ص�����*/
	core.ajax.sendPacket(packet,setMarkPoint,true);
	packet=null;
}

/*zhangyan add*/
function setMarkPoint(packet)
{
	/*��������change()���� , ����Ӧ�����ĳ�ʼֵ*/
	document.all.price.value
		=document.all.sale_code.options[document.all.sale_code.selectedIndex].nv2;
	document.all.pay_money.value
		=document.all.sale_code.options[document.all.sale_code.selectedIndex].nv3;

	//wangdana add for  �ֻ�����
	document.all.TVprice.value
		=document.all.sale_code.options[document.all.sale_code.selectedIndex].nv4;
	document.all.TVtime.value
		=document.all.sale_code.options[document.all.sale_code.selectedIndex].nv5;		
	
		var i=document.all.price.value;
		var j=document.all.pay_money.value;
		var y=document.all.TVprice.value;
		var z=document.all.TVtime.value;
		document.all.sum_money.value=(parseFloat(i)+parseFloat(j)+parseFloat(y)).toFixed(2);//wangdana update for �ֻ����ӷ�
		
	
	var rtCode=packet.data.findValueByName("rtCode"); 	
	var rtMsg=packet.data.findValueByName("rtMsg"); 	
	
	if ( rtCode=="000000" )
	{
		//document.all.used_point.disabled=true;
		/*���ֶ�Ӧ��Ǯ��*/
		var	rstMarkQry	=packet.data.findValueByName("rstMarkQry"); 
		/*����ֵ*/
		document.all.point_money.value	= rstMarkQry;		
		
		var sum_money=document.all.sum_money.value ;
		
		/*Ӧ�ս��-���ֶһ���Ǯ��*/
		sum_money=parseFloat(sum_money-rstMarkQry).toFixed(2);
		document.all.sum_money.value=sum_money;
	}
	else
	{
		document.all.used_point.value="0";
		rdShowMessageDialog(rtCode+":"+rtMsg);
		return false;
	}
}

 function doProcess(packet){

 		errorCode = packet.data.findValueByName("errorCode");
		errorMsg =  packet.data.findValueByName("errorMsg");
		retType = packet.data.findValueByName("retType");
		retResult= packet.data.findValueByName("retResult");
		self.status="";
		var tmpObj="";
		var i=0;
		var j=0;
		var ret_code=0;
		var tmpstr="";

		ret_code =  parseInt(errorCode);
		//alert("111111111111111111111111" +errorCode );
		//alert("111111111111111111111111" +errorMsg );
		//alert("111111111111111111111111----------"            +   verifyType );
		//	alert("111111111111111111111111" +backArrMsg );
		if(retType=="getcard"){
			if( ret_code == "000000"){
				  tmpObj = "sale_code"
				  backArrMsg = packet.data.findValueByName("backArrMsg");
					retResult = packet.data.findValueByName("retResult");
				  document.all(tmpObj).options.length=0;
				  document.all(tmpObj).options.length=backArrMsg.length;
		        for(i=0;i<backArrMsg.length;i++)
			      {
				      document.all(tmpObj).options[i].text=backArrMsg[i][1];
				      document.all(tmpObj).options[i].value=backArrMsg[i][0];
		 	        document.all(tmpObj).options[i].nv2=backArrMsg[i][2];
			        document.all(tmpObj).options[i].nv3=backArrMsg[i][3];
					
					//wangdana add for �ֻ�����
					document.all(tmpObj).options[i].nv4=backArrMsg[i][4];
					document.all(tmpObj).options[i].nv5=backArrMsg[i][5];			        
			        
			        
			      }
			}
			else{
				rdShowMessageDialog("ȡ��Ϣ����:"+errorMsg+"!");
				return;
			}
			change();
		}else if(retType == "checkAward")
		{
				var retCode = packet.data.findValueByName("retCode");
				var retMessage = packet.data.findValueByName("retMessage");
    		window.status = "";
    		if(retCode!=0){
    			rdShowMessageDialog(retMessage);
    			document.all.need_award.checked = false;
    			document.all.award_flag.value = 0;
    			return ;
    		}
    		document.all.award_flag.value = 1;
    	}
    	else{
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI��У��ɹ�1��");
					document.frm.IMEINo.readOnly=true;
					document.frm.confirm.disabled=false;
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI��У��ɹ�2��");
					document.frm.IMEINo.readOnly=true;
					document.frm.confirm.disabled=false;
					return  ;

			}else if(retResult == "000003"){
					rdShowMessageDialog("IMEI�Ų���ӪҵԱ����Ӫҵ����IMEI����ҵ�������Ͳ�����");
					document.frm.confirm.disabled=true;
					return false;
			}else{
					rdShowMessageDialog("IMEI�Ų����ڻ����Ѿ�ʹ�ã�");
					document.frm.confirm.disabled=true;
					return false;
			}
		}
 }

function viewConfirm()
{
	if(document.frm.IMEINo.value=="")
	{
		document.frm.confirm.disabled=true;
	}

}


 function change(){
 	
  	/*zhangyan add �ֻ�Ʒ�Ʊ仯ʱ���ѻ�������*/
 	document.all.used_point.value="0";
 	document.all.sum_money.value="0.00";
 		
	with(document.frm){

		price.value=sale_code.options[sale_code.selectedIndex].nv2;
		pay_money.value=sale_code.options[sale_code.selectedIndex].nv3;

		//wangdana add for  �ֻ�����
		TVprice.value=sale_code.options[sale_code.selectedIndex].nv4;
		TVtime.value=sale_code.options[sale_code.selectedIndex].nv5;		
		
		var i=price.value;
		var j=pay_money.value;
		var y=TVprice.value;
		var z=TVtime.value;
		sum_money.value=(parseFloat(i)+parseFloat(j)+parseFloat(y)).toFixed(2);//wangdana update for �ֻ����ӷ�
	}
}


function addmonth(now_yyyymmdd,num){
		var num_int = Number(num);
		var year_str = now_yyyymmdd.substr(0,4);
		var month_str = now_yyyymmdd.substr(4,2);
		var day_str = now_yyyymmdd.substr(6,2);
		var month_nu = Number(month_str);
		
		var year_add = (month_nu+num_int)/12;
		var month_new = (month_nu+num_int)%12;
	
	  var year_new = Number(year_str)+Number((year_add+'').substr(0,(year_add+'').indexOf('.')));
	  var month_new_str = month_new+'';
	  if(month_new_str.length==1)
	  {
	  	month_new_str ='0'+month_new_str; 
	  }
	  return (year_new+"") + (month_new_str+"");
		
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
		///////<!-- ningtn add for pos start @ 20100408 -->
		document.all.payType.value = document.all.payTypeSelect.value;
		//document.all.used_point.disabled=false;
		if(document.all.payType.value=="BX")
  	{
    		/*set �������*/
				var transerial    = "000000000000";  	                    //����Ψһ�� ������ȡ��
				var trantype      = "00";         //��������
				var bMoney        = document.all.sum_money.value; 				//�ɷѽ��
				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
				var tranoper      = "<%=loginNo%>";                       //���ײ���Ա
				var orgid         = "<%=groupId%>";                       //ӪҵԱ��������
				var trannum       = "<%=phoneNo%>";                       //�绰����
				getSysDate();       /*ȡbossϵͳʱ��*/
				var respstamp     = document.all.Request_time.value;      //�ύʱ��
				var transerialold = "";																		//ԭ����Ψһ��,�ڽɷ�ʱ�����
				var org_code      = "<%=orgCode%>";                       //ӪҵԱ����						
				CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
				if(ccbTran=="succ") posSubmitForm();
  	}
		else if(document.all.payType.value=="BY")
		{
				var transType     = "05";					/*�������� */         
				var bMoney        = document.all.sum_money.value;         /*���׽�� */
				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";         
				var response_time = "";                								 		/*ԭ�������� */				
				var rrn           = "";                           				/*ԭ����ϵͳ������ */ 
				var instNum       = "";                                   /*���ڸ������� */     
				var terminalId    = "";                    								/*ԭ�����ն˺� */			
				getSysDate();       																			//ȡbossϵͳʱ��                                            
				var request_time  = document.all.Request_time.value;      /*�����ύ���� */     
				var workno        = "<%=loginNo%>";                        /*���ײ���Ա */       
				var orgCode       = "<%=orgCode%>";                       /*ӪҵԱ���� */       
				var groupId       = "<%=groupId%>";                       /*ӪҵԱ�������� */   
				var phoneNo       = "<%=phoneNo%>";                       /*���׽ɷѺ� */       
				var toBeUpdate    = "";						                        /*Ԥ���ֶ� */         
				var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
				if(icbcTran=="succ") posSubmitForm();
		}else{
				posSubmitForm();
		}
		
		//////<!-- ningtn add for pos end @ 20100408 -->

  }
  
	/* ningtn add for pos start @ 20100408 */
	function posSubmitForm(){
		frm.submit();
		return true;
	}
	function getSysDate()
	{
		var myPacket = new AJAXPacket("../s1300/s1300_getSysDate.jsp","���ڻ��ϵͳʱ�䣬���Ժ�......");
		myPacket.data.add("verifyType","getSysDate");
		core.ajax.sendPacket(myPacket,doSetStsDate);
		myPacket = null;
	}
	function doSetStsDate(packet){
		var verifyType = packet.data.findValueByName("verifyType");
		var sysDate = packet.data.findValueByName("sysDate");
		if(verifyType=="getSysDate"){
			document.all.Request_time.value = sysDate;
			return false;
		}
	}
	function padLeft(str, pad, count)
	{
			while(str.length<count)
			str=pad+str;
			return str;
	}
	function getCardNoPingBi(cardno)
	{
			var cardnopingbi = cardno.substr(0,6);
			for(i=0;i<cardno.length-10;i++)
			{
				cardnopingbi=cardnopingbi+"*";
			}
			cardnopingbi=cardnopingbi+cardno.substr(cardno.length-4,4);
			return cardnopingbi;
	}
	/* ningtn add for pos start @ 20100408 */
 //***IMEI ����У��
 function checkimeino()
{
	if(document.frm.phone_type.value==""){
		rdShowMessageDialog("����ѡ���ֻ�Ʒ�Ƽ��ͺţ�");
		return false;
		}
	 if (document.frm.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
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
	myPacket.data.add("style_code", (document.all.phone_type.options[document.all.phone_type.selectedIndex].value).trim());
	myPacket.data.add("retType","0");
	myPacket.data.add("opcode",(document.all.opcode.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket=null;

}
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
	var pType="subprint";
	var billType="1";
	var printStr = printInfo(printType);

	var mode_code=null;
	var fav_code=null;
	var area_code=null;

	var sysAccept = document.all.login_accept.value;
	/* ningtn */
	var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
	var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
	/* ningtn */
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}

function printInfo(printType)
{

	var month_fee ;
	var pay = document.all.pay_money.value;
	month_fee= Math.round(pay*100/12)/100;

     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";

	 var retInfo = "";

	cust_info+="�ֻ����룺   "+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������   "+document.all.cust_name.value+"|";
	cust_info+="�ͻ���ַ��   "+document.all.cust_addr.value+"|";
	cust_info+="֤�����룺   "+document.all.cardId_no.value+"|";

	opr_info+="ҵ�����ͣ�Ԥ�滰���Żݹ���"+"|";
	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
	opr_info+="�ֻ��ͺ�: "+document.all.phone_typename.value+"      IMEI�룺"+document.frm.IMEINo.value+"|";
 	opr_info+="�ɿ�ϼƣ�"+document.all.sum_money.value+"Ԫ����Ԥ�滰��"+document.all.pay_money.value+"Ԫ��ÿ�·������"+month_fee+"Ԫ"+"������ֹ��"+"<%=exeDate%>"+"��|";
 	opr_info+="�ֻ����ӹ��ܷ�"+document.all.TVprice.value+"Ԫ��ÿ�·������"+document.all.TVprice.value/document.all.TVtime.value+"Ԫ"+"������ֹ��"+addmonth("<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>",document.all.TVtime.value)+"|";


  
	note_info1+="��ע��"+document.all.opNote.value+"|";

  	if(document.all.award_flag.value == "1")
	{
		//retInfo+= "�Ѳ���������Ʒ�"+"|";
		note_info1+= "�Ѳ���������Ʒ�"+"|";
	}
	else
	{
		//retInfo+= " "+"|";
		note_info1+= " "+"|";
	}
		//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
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
  	/*zhangyan add �ֻ�Ʒ�Ʊ仯ʱ���ѻ�������*/
 	document.all.used_point.value="0";
 	document.all.sum_money.value="0.00";	
 	 document.frm.confirm.disabled=true;
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
 	
  	/*zhangyan add �ֻ�Ʒ�Ʊ仯ʱ���ѻ�������*/
 	document.all.used_point.value="0";
 	document.all.sum_money.value="0.00";
 		
  document.frm.confirm.disabled=true;
 	var myEle1 ;
   	var x1 ;
   	for (var q1=document.all.sale_code.options.length;q1>=0;q1--) document.all.sale_code.options[q1]=null;
   	myEle1 = document.createElement("option") ;
    	myEle1.value = "";
        myEle1.text ="--��ѡ��--";
        document.all.sale_code.add(myEle1) ;
      //  alert("sssssssssss");
   	for ( x1 = 0 ; x1 < arrsaletype.length  ; x1++ )
   	{		//alert(arrsaletype[x1]);
   		//alert(document.all.phone_type.value);
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
 function salechage(){

	var getNote_Packet = new AJAXPacket("f1141_getprepay.jsp","���ڻ��Ӫ����ϸ�����Ժ�......");
    getNote_Packet.data.add("retType","getcard");
	getNote_Packet.data.add("agentCode",document.all.agent_code.value);
	getNote_Packet.data.add("phoneType",document.all.phone_type.value);
	getNote_Packet.data.add("saletype","1");
	getNote_Packet.data.add("regionCode","<%=regionCode%>");
	getNote_Packet.data.add("salecode",document.all.sale_code.value);
	core.ajax.sendPacket(getNote_Packet);
	getNote_Packet=null;
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
 	 	 packet.data.add("op_code","1141");
 	 	 packet.data.add("style_code",document.all.phone_type.value );

 	 	 core.ajax.sendPacket(packet);
 	 	 packet=null;

 	 }
 	 //document.all.award_flag.value = 0;
 }

//-->
/* ningtn �Ų��ܼ����� */
	$(document).ready(function(){
		var showtext = "<%=showText%>";
		var showMsgObj = $("#showMsg");
		showMsgObj.hide();
		if(showtext.length > 0){
			showMsgObj.children("div").text(showtext);
			showMsgObj.show();
		}
	});
</script>


</head>


<body>
<form name="frm" method="post" action="f1141Cfm.jsp" onKeyUp="chgFocus(frm)">

   <%@ include file="/npage/include/header.jsp" %>
   <!-- /* ningtn �Ų��ܼ����� */  -->
<div class="title" id="showMsg">
	<div id="title_zi">
	
	</div>
</div>
		<div class="title">
			<div id="title_zi">Ԥ�滰���Żݹ���</div>
		</div>
        <table  cellspacing="0">
		  <tr>
            <td class="blue">��������</td>
            <td colspan="3">Ԥ�滰���Żݹ���--����</td>
          </tr>
          <tr >
            <td  class="blue">�ͻ�����</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1 readonly Class="InputGrey"     id="cust_name" maxlength="20" v_name="����">

            </td>
            <td class="blue">�ͻ���ַ</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text"  v_must=1  readonly Class="InputGrey"     id="cust_addr" size="40">

            </td>
            </tr>
            <tr>
            <td class="blue">֤������</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1  readonly Class="InputGrey"     id="cardId_type" maxlength="20" >

            </td>
            <td class="blue">֤������</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1  readonly Class="InputGrey"     id="cardId_no" maxlength="20" >

            </td>
            </tr>
            <tr>
            <td class="blue">ҵ��Ʒ��</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1  readonly Class="InputGrey"     id="sm_code" maxlength="20" >

            </td>
            <td class="blue">����״̬</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text"  v_must=1  readonly Class="InputGrey"     id="run_type" maxlength="20" >

            </td>
            </tr>
            <tr>
            <td class="blue">VIP����</td>
            <td>
			  <input name="vip" value="<%=vip%>" type="text"  v_must=1  readonly Class="InputGrey"     id="vip" maxlength="20" >

            </td>
            <td class="blue">����Ԥ��</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1  readonly Class="InputGrey"     id="prepay_fee" maxlength="20" >

            </td>
            </tr>
             <tr>
            <td class="blue">�ֻ�Ʒ��</td>
            <td>
			  <SELECT id="agent_code" name="agent_code" v_must=1
			  	onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);" v_name="�ֻ�������">
			    <option value ="">--��ѡ��--</option>
                <%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
                <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
                <%}%>
              </select>
			  <font color="red">*</font>
			</td>
	 <td class="blue">�ֻ��ͺ�</td>
            <td>
			  <select size=1 name="phone_type" id="phone_type" v_must=1  onchange="typechange()">

              </select>
			  <font color="red">*</font>
			</td>
          </tr>
          <tr>

            <td class="blue">Ӫ������
            </td>
            <td>
			  <select size=1 name="sale_code" id="sale_code" v_must=1 v_name="Ӫ������" onchange="change()">
              </select>
			  <font color="red">*</font>
			</td>
			<td colspan="2" class="blue">�Ƿ��������<input type="checkbox" name="need_award" onclick="checkAward()" />
				<input type="hidden" name="award_flag" value="0" />
			</td>

          </tr> 
          <tr>
            <td  class="blue">������</td>
            <td >
			  <input name="price" type="text"  id="price" v_type="money" v_must=1    readonly Class="InputGrey"     v_name="�ֻ��۸�" >

			</td>
            <td class="blue">Ԥ�滰��</td>
            <td>
			  <input name="pay_money" type="text"  Class="InputGrey" id="pay_money" v_type="0_9" v_must=1   v_name="Ԥ�滰��" readonly>

			</td>
          </tr>
		<!--�ֻ������������� wangdana-->
		<tr>
			<td  class="blue">�ֻ����ӹ��ܷ�</td>
			<td >
				<input name="TVprice" type="text"  id="TVprice" v_type="money" v_must=1    readonly Class="InputGrey"     v_name="�ֻ����ӹ��ܷ�" >
			</td>
			<td class="blue">�ֻ�������������</td>
			<td>
				<input name="TVtime" type="text"  Class="InputGrey" id="TVtime" v_type="0_9" v_must=1   v_name="����ʱ��" readonly>
			</td>
		</tr>
          
          <tr>
 			<!--zhangyan -->
			<td class="blue">���ѻ���</td>
      		<td> 
				<input name="used_point" type="text"  id="used_point" value='0'
					v_must='1' v_type='0_9' onchange='getUsedPoint()'  >
			</td>
            <td  class="blue">Ӧ�����</td>
            <td  >
			  	<input name="sum_money" type="text"  id="sum_money" readonly Class="InputGrey">
			</td>
          </tr>
					<!-- ningtn add for pos start @ 20100408 -->
					<TR>
						<!--zhangyan add-->
						<td class="blue">��ǰ����</td>			
			            <td>
						  	<input name="posint" type="text"  
						  	id="posint" readonly Class="InputGrey" value="<%=posint%>"/>
						</td>
						<TD class="blue">�ɷѷ�ʽ</TD>
						<TD >
							<select name="payTypeSelect" >
								<option value="0">�ֽ�ɷ�</option>
								<option value="BX">��������POS���ɷ�</option>
								<option value="BY">��������POS���ɷ�</option>
							</select>
						</TD>
					</TR>
					<!-- ningtn add for pos end @ 20100408 -->
         <TR>
			<TD  nowrap class="blue">
				<div align="left">IMEI��</div>
            </TD>
            <TD colspan="3">
				<input name="IMEINo" class="button" type="text" v_type="0_9"   maxlength=15 value="" onblur="viewConfirm()">
				<input name="checkimei" class="b_text" type="button" value="У��" onclick="checkimeino()">
                <font color="red">*</font>
            </TD>

          </TR>
		  <TR id=showHideTr >
			<TD  nowrap class="blue">
				<div align="left">����ʱ��</div>
            </TD>
			<TD >
				<input name="payTime" class="button" v_must=1 type="text" v_type="date" v_format="yyyyMMdd"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>" onblur="checkElement(document.all.payTime)">
				(������)<font color="red">*</font>
			</TD>
			<TD  nowrap class="blue">
				<div align="left">����ʱ�� </div>
			</TD>
			<TD >
				<input name="repairLimit" v_type="date.month" class="button" size="10" v_must=1 type="text"  value="12" onblur="if(checkElement(this)){viewConfirm()}">
				(����)<font color="red">*</font>
			</TD>
          </TR>
		  <tr>
            <td height="32"   class="blue">�û���ע</td>
            <td colspan="3">
             <input name="opNote" type="text" class="button" id="opNote" size="60" maxlength="60" value="Ԥ�滰���Żݹ���" >
            </td>
          </tr>
        </table>
        <!-- ningtn 2011-7-12 08:33:59 ������ӹ��� -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
        <table>
          <tr>
            <td colspan="4" id="footer"> <div align="center">
                <input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()" disabled >
                &nbsp;
                <input name="reset" type="reset" class="b_foot" value="���" >
                &nbsp;
                <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
                &nbsp; </div></td>
          </tr>
        </table>
 			
  
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="1" >
   
	<input type="hidden" name="point_money" value="0" >
	<input type="hidden" name="phone_typename" value="" >
	<input type="hidden" name="op_code" value="<%=op_code%>" >
	
	<!-- ningtn add for pos start @ 20100408 -->		
	<input type="hidden" name="payType"  value=""><!-- �ɷ����� payType=BX �ǽ��� payType=BY �ǹ��� -->			
	<input type="hidden" name="MerchantNameChs"  value=""><!-- �Ӵ˿�ʼ����Ϊ���в��� -->
	<input type="hidden" name="MerchantId"  value="">
	<input type="hidden" name="TerminalId"  value="">
	<input type="hidden" name="IssCode"  value="">
	<input type="hidden" name="AcqCode"  value="">
	<input type="hidden" name="CardNo"  value="">
	<input type="hidden" name="BatchNo"  value="">
	<input type="hidden" name="Response_time"  value="">
	<input type="hidden" name="Rrn"  value="">
	<input type="hidden" name="AuthNo"  value="">
	<input type="hidden" name="TraceNo"  value="">
	<input type="hidden" name="Request_time"  value="">
	<input type="hidden" name="CardNoPingBi"  value="">
	<input type="hidden" name="ExpDate"  value="">
	<input type="hidden" name="Remak"  value="">
	<input type="hidden" name="TC"  value="">
	<!-- ningtn add for pos end @ 20100408 -->
     <%@ include file="/npage/include/footer.jsp" %>
</form>
<!-- **** ningtn add for pos @ 20100408 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100408 ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
</body>
<%@ include file="/npage/public/hwObject.jsp" %>
</html>
