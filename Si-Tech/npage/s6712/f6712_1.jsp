<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% 
  /*
   * ����: ���˲����Ʒ���6712
�� * �汾: v1.00
�� * ����: 2007/09/13
�� * ����: liubo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����2008-01-08      �޸���leimd      �޸�Ŀ��
   *  
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../include/remark1.htm" %>

<%
    String opCode="6712";
	String opName="���˲����Ʒ���";
	String phone_no = (String)request.getParameter("activePhone");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String power_right=(String)session.getAttribute("powerRight");
    String org_code = (String)session.getAttribute("orgCode");
    String nopass  = (String)session.getAttribute("password");
    String regionCode = (String)session.getAttribute("regCode");  
    String sInOpNote  ="������Ϣ��ʼ��";
    int    nextFlag=1;
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept"/>
<%	  
	Map map = (Map)session.getAttribute("contactInfoMap");
	ContactInfo contactInfo = (ContactInfo) map.get(phone_no);
	System.out.println("xxxxx================="+contactInfo);
	String password = contactInfo.getPasswdVal(2);  
	
	String sOutCustId         ="";             //�ͻ�ID_NO          
	String sOutCustName       ="";             //�ͻ�����           
	String sOutSmCode         ="";             //����Ʒ�ƴ���       
	String sOutSmName         ="";             //����Ʒ������       
	String sOutProductCode    ="";             //����Ʒ����         
	String sOutProductName    ="";             //����Ʒ����         
	String sOutPrePay         ="";             //����Ԥ��           
	String sOutRunCode        ="";             //����״̬����       
	String sOutRunName        ="";             //����״̬����       
	String sOutUsingCRProdCode="";             //�Ѷ��������Ʒ     
	String sOutUsingCRProdName="";             //�Ѷ��������Ʒ���� 
	String sOutCRColorType    ="";             //��������           
	String sOutCRColorTypeName="";             //������������       
	String sOutCRRunCode      ="";             //��������״̬����   
	String sOutCRRunName      ="";             //��������״̬����   
	String sOutCRBellBeginTime="";             //���忪ͨʱ��       
	String sOutCRBellEndTime  ="";             //�������ʱ�� 
	String sOutCustAddress ="";     //�û���ַ
	String sOutIdIccid     ="";     //֤������      
	
	String action=request.getParameter("action");     
	
	if (action!=null&&action.equals("select")){
		phone_no = request.getParameter("phone_no");
		System.out.println("phone_nophone_nophone_nophone_nophone_nophone_nophone_no"+phone_no);
		String Pwd1 = Encrypt.encrypt(password);     
//		SPubCallSvrImpl callView = new SPubCallSvrImpl();
		String paramsIn[] = new String[6];
		paramsIn[0]=workno;                                 //��������         
		paramsIn[1]=nopass;                                 //������������     
		paramsIn[2]=opCode;                                 //��������         
		paramsIn[3]=sInOpNote;                              //��������         
		paramsIn[4]=phone_no;                               //�û��ֻ�����     
		paramsIn[5]=Pwd1;                                   //�û�����         
		
//			ArrayList acceptList = new ArrayList();
//			acceptList = callView.callFXService("s6714Init", paramsIn, "19");
//			callView.printRetValue();
%>
	<wtc:service name="s6714Init" routerKey="region" routerValue="<%=regionCode%>" outnum="19" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>
		<wtc:param value="<%=paramsIn[2]%>"/>
		<wtc:param value="<%=paramsIn[3]%>"/>
		<wtc:param value="<%=paramsIn[4]%>"/>
		<wtc:param value="<%=paramsIn[5]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%			
	String errCode = retCode;
	String errMsg = retMsg;     
	
	if(!errCode.equals("000000"))
	{
		%>        
	    <script language='jscript'>
	       rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	       history.go(-1);
	  </script> 
	     
		<%  
	}					
	if(errCode.equals("000000")&&result.length>0)
	{
		nextFlag = 2;
/*						
		String result2  [][]	= (String[][])acceptList.get(0);
		String result3  [][]  = (String[][])acceptList.get(1);
		String result4  [][]	= (String[][])acceptList.get(2);
		String result5  [][]	= (String[][])acceptList.get(3);
		String result6  [][]	= (String[][])acceptList.get(4);
		String result7  [][]	= (String[][])acceptList.get(5);
		String result8  [][]	= (String[][])acceptList.get(6);
		String result9  [][]	= (String[][])acceptList.get(7);
		String result10 [][]	= (String[][])acceptList.get(8);
		String result11 [][]  = (String[][])acceptList.get(9);
		String result12 [][]	= (String[][])acceptList.get(10);
		String result13  [][] = (String[][])acceptList.get(11);
		String result14  [][]	= (String[][])acceptList.get(12);
		String result15  [][]	= (String[][])acceptList.get(13);
		String result16  [][]	= (String[][])acceptList.get(14);
		String result17  [][]	= (String[][])acceptList.get(15);
		String result18  [][]	= (String[][])acceptList.get(16);
		String result19 [][]  = (String[][])acceptList.get(17);
		String result20 [][]	= (String[][])acceptList.get(18);
*/
		sOutCustId          =result  [0][0];           
		sOutCustName        =result  [0][1];           
		sOutSmCode          =result  [0][2];           
		sOutSmName          =result  [0][3];           
		sOutProductCode     =result  [0][4];           
		sOutProductName     =result  [0][5];           
		sOutPrePay          =result  [0][6].trim();           
		sOutRunCode         =result  [0][7];           
		sOutRunName         =result [0][8];           
		sOutUsingCRProdCode =result [0][9];           
		sOutUsingCRProdName =result [0][10]; 
		sOutCRColorType     =result [0][11]; 
		sOutCRColorTypeName =result [0][12]; 
		sOutCRRunCode       =result [0][13]; 
		sOutCRRunName       =result [0][14]; 
		sOutCRBellBeginTime =result [0][15]; 
		sOutCRBellEndTime   =result [0][16]; 			
		sOutCustAddress  	=result [0][17];            // �û���ַ
		sOutIdIccid      	=result [0][18];            // ֤������	          				       
}
	   	 if(!sOutCRColorType.equals("00"))
		 {		   
			%>        
		    <script language='jscript'>
		       rdShowMessageDialog("ֻ��������û������" ,0);
		       history.go(-1);
	      </script> 	         
			<%  			
		 } 
	 }    
%>      
        
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>������BOSS-���˲����Ʒ���</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>

<script language="JavaScript">

onload=function()
{
	
}

function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMessage = packet.data.findValueByName("retMessage");
	self.status="";
	//�����Ʒ
  if(retType == "changProd"){  	
	  var triListData = packet.data.findValueByName("tri_list"); 	  
	 	var triList=new Array(triListData.length);
	  triList[0]="mebProdCode";
	  document.all("mebProdCode").length=0;
	  document.all("mebProdCode").options.length=triListData.length;
	  for(j=0;j<triListData.length;j++)
	  {
		document.all("mebProdCode").options[j].text=triListData[j][1];
		document.all("mebProdCode").options[j].value=triListData[j][0];
	  }
	  document.all("mebProdCode").options[0].selected=true; 
  }  
}
		
//ȷ���ύ
function refain()
{ 
	if(document.form.mebProdCode.value=="" )
	{   
		rdShowMessageDialog("��ѡ���Ʒ���룡");
		document.form.phoneNo.focus();
		return false;
	}
	
 document.all.sysNote.value = "�ֻ�["+<%=phone_no%>+"]�������ҵ��,�����Ʒ["+document.all.mebProdCode.value+"]";
	if((document.all.opNote.value).trim().length==0)
	{
         document.all.opNote.value="<%=workno%>[<%=workname%>]"+"���ֻ�["+<%=phone_no%>+"]���в���ҵ����";
	} 
	    
	document.form.action="f6712_2.jsp";
	document.form.submit();
	return true;
  
}
//�����ֻ��ź����룬��ѯ������Ϣ
function doQuery()
	{		
		if(!check(form)) return false; 
		document.form.action = "f6712_1.jsp?action=select&activePhone=<%=phone_no%>";
		document.form.submit(); 
	}
	
//���ù������棬���в�Ʒ��Ϣѡ��
function getInfo_Prod()
{
    var pageTitle = "���Ų�Ʒѡ��";
    var fieldName = "��Ʒ����|��Ʒ����|";
	  var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "product_code|";

    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.form.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ������Ϣ����Ʒ��",0);
        return false;
    }
    //�����ж��Ƿ��Ѿ�ѡ���˲�Ʒ����
    if(document.form.product_attr_hidden.value == "")
    {
        rdShowMessageDialog("������ѡ���Ʒ���ԣ�",0);
        return false;
    }

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s6712/fpubprod_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	  path = path + "&op_code=" + document.all.op_code.value;
	  path = path + "&sm_code=" + document.all.sm_code.value; 
	  path = path + "&cust_id=" + document.all.cust_id.value; 
    path = path + "&product_attr=" + document.all.product_attr.value; 

    retInfo = window.open(path,"newwindow","height=450, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
    
	return true;
}

function getvalue(retInfo)
{
  var retToField = "product_code|";
  if(retInfo ==undefined)      
    {   return false;   }    
  document.form.product_code.value = retInfo ;
}

function changeOthers(){
	var mebMonthFlag=document.form.mebMonthFlag.value;

	if(mebMonthFlag=="1"){
		document.form.matureProdCode.value="";
		document.form.matureFlag.value="";
		tbs2.style.display="none";
	}
	else
	{
		document.form.matureFlag.value="N";								
		tbs2.style.display="";
	}	
}

//���ù������棬���в�Ʒѡ��
function getmebProdCodeQuery()
{
    var pageTitle = "�����Ʒѡ��";
    var fieldName = "��Ʒ����|��Ʒ����|";
		var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "mebProdCode|mebProdName|";

    if(PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
    //getMidPrompt('10442',codeChg(document.all.mebProdCode.value),'ipTd');

}

function PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{   
	var mebMonthFlag = document.form.mebMonthFlag.value;
	var mode_type="";
	var month_num=1;
	if(mebMonthFlag=="1")
	{
		mode_type="CR01";
		month_num=1;
	}else if(mebMonthFlag=="2"){
		mode_type= "CR02";
		month_num=12;
	}
	else if(mebMonthFlag=="3"){
		mode_type= "CR02";
		month_num=6;
	}
	else if(mebMonthFlag=="4"){
		mode_type= "CR02";
		month_num=3;
	}
	
    var path = "<%=request.getContextPath()%>/npage/s6712/fpubmebProdCode_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&groupFlag=Y";
	path = path + "&op_code=" + document.all.opCode.value;
	path = path + "&mode_type=" + mode_type; 
	path = path + "&month_num=" + month_num;
	path = path + "&UsingCRProdCode=" + document.all.UsingCRProdCode.value;
	path = path + "&power_right=" +document.all.power_right.value;
	path = path + "&regionCode=<%=regionCode%>"
	path = path + "&mebMonthFlag=" + document.all.mebMonthFlag.value;  	       
    retInfo = window.open(path,"newwindow","height=450, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getmebProdCode(retInfo)
{
	var retToField = "mebProdCode|mebProdName|";
	if(retInfo ==undefined)      
	{
		ChgCurrStep("custQuery");
		return false;
	}
	
	var chPos_field = retToField.indexOf("|");
	var chPos_retStr;
	var valueStr;
	var obj;
	while(chPos_field > -1)
	{
		obj = retToField.substring(0,chPos_field);
		chPos_retInfo = retInfo.indexOf("|");
		valueStr = retInfo.substring(0,chPos_retInfo);
		document.all(obj).value = valueStr;
		retToField = retToField.substring(chPos_field + 1);
		retInfo = retInfo.substring(chPos_retInfo + 1);
		chPos_field = retToField.indexOf("|");
	}			                                                                 
	document.form.mebMonthFlag1.value=document.form.mebMonthFlag.value;
	document.form.mebMonthFlag.disabled=true;
	getMidPrompt('10442',codeChg(document.all.mebProdCode.value),'ipTd');
}

//����ת��Ʒѡ��
function getmatureProdCodeQuery()
 {  
 	  var pageTitle = "���굽��ת���²�Ʒѡ��";
    var fieldName = "��Ʒ���Դ���|��Ʒ����|";    
		var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "matureProdCode|matureProdName|";
	if(PubSimpSelmatureProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
 }
 
function PubSimpSelmatureProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{   
    var path = "<%=request.getContextPath()%>/npage/s6712/fpubmatureProdCode_sel.jsp"; 
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&groupFlag=Y";
	  path = path + "&op_code=" + document.all.opCode.value;
	  path = path + "&UsingCRProdCode=" + document.all.UsingCRProdCode.value;
	  path = path + "&power_right=" +document.all.power_right.value;
	  path = path + "&regionCode=<%=regionCode%>"
	  path = path + "&mebMonthFlag=" + document.all.mebMonthFlag.value;  	
    retInfo = window.open(path,"newwindow","height=450, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;	
}
function getmatureProd(retInfo)
{ 
	var retToField = "matureProdCode|matureName|";
	if(retInfo ==undefined)      
	{
		ChgCurrStep("custQuery");
		return false;
	}
	
	var chPos_field = retToField.indexOf("|");
	var chPos_retStr;
	var valueStr;
	var obj;
	while(chPos_field > -1)
	{
		obj = retToField.substring(0,chPos_field);
		chPos_retInfo = retInfo.indexOf("|");
		valueStr = retInfo.substring(0,chPos_retInfo);
		document.all(obj).value = valueStr;
		retToField = retToField.substring(chPos_field + 1);
		retInfo = retInfo.substring(chPos_retInfo + 1);
		chPos_field = retToField.indexOf("|");
	}		
}
//���ݲ�Ʒ���ͽ��в�Ʒ���
function tochange()
{  
		var mebMonthFlag = document.form.mebMonthFlag.value;
		var mode_type="";
		var month_num=1;
		if(mebMonthFlag=="1")
		{
			mode_type="CR01";
			month_num=1;
		}else if(mebMonthFlag=="2"){
			mode_type= "CR02";
			month_num=12;
		}
		else if(mebMonthFlag=="3"){
			mode_type= "CR02";
			month_num=6;
		}
		else if(mebMonthFlag=="4"){
			mode_type= "CR02";
			month_num=3;
		}
		//var sqlStr = "select mode_code,mode_code||'->'||mode_name from sbillmodecode where  mode_code like 'CR%' and mode_type='"+mode_type+"' and start_time<sysdate  and stop_time>sysdate  and power_right<=" + "<%=power_right%>" + " and mode_status='Y' and region_code='" + "<%=regionCode%>" + "' and mode_code !='<%=sOutUsingCRProdCode%>'";	
		/**
		**var sqlStr = "select a.mode_code,a.mode_code||'->'||mode_name from sbillmodecode a,scolormode b "+
		**		" where a.mode_code like 'CR%' and a.start_time<sysdate  and a.stop_time>sysdate "+
		**		" and a.power_right<=" + "<%=power_right%>" + " and a.mode_status='Y' "+
		**		" and a.region_code='" + "<%=regionCode%>" + "' and a.mode_type='"+mode_type+"'"+
		**		" and a.region_code = b.region_code and a.MODE_CODE = b.PRODUCT_CODE"+
		**		" and a.mode_code !='<%=sOutUsingCRProdCode%>'"+
		**		" and b.mode_bind='0'"+
		**		" and b.month_num = "+month_num;
		**var myPacket = new RPCPacket("select_rpc.jsp","���ڻ��ҵ��ģʽ��Ϣ�����Ժ�......");
		**myPacket.data.add("retType","changProd");
		**myPacket.data.add("sqlStr",sqlStr);
		**core.rpc.sendPacket(myPacket);
		**delete(myPacket);
		**/
}

function changeMatureFlag(){
	var matureFlag=document.form.matureFlag.value;
	if(matureFlag=="Y"){
	 document.form.matureProdCode.value="";
	 document.form.matureName.value="";	 
	 document.form.matureProdCode.readonly=true;
	 document.form.matureProdCodeQuery.disabled=false;
   }else{
   document.form.matureProdCode.value=""; 
   document.form.matureName.value="";	 
   document.form.matureProdCode.readonly=false;
   document.form.matureProdCodeQuery.disabled=true;
   }	
}

function refain1() {
	getAfterPrompt();
	showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
		if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")==1){
			refain();
		}
}
function showPrtDlg(printType,DlgMessage,submitCfm) {  //��ʾ��ӡ�Ի���
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =<%=loginAccept%>;             			//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=document.all.mebProdCode.value+"~";           							//�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		//С������
	var opCode="6712" ;                   			 		//��������
	var phoneNo="<%=phone_no%>";                  	 		//�ͻ��绰
   if(printStr == "failed")
   {    return false;   }

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.form.phoneNo.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
}

function printInfo(printType) { 
	var cust_info="";  				//�ͻ���Ϣ
	var opr_info="";   				//������Ϣ
	var note_info1=""; 				//��ע1
	var note_info2=""; 				//��ע2
	var note_info3=""; 				//��ע3
	var note_info4=""; 				//��ע4
	var retInfo = "";  				//��ӡ����
	
	opr_info+='<%=workname%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	cust_info+="֤�����룺"+document.all.sOutIdIccid.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.sOutCustAddress.value+"|";
	opr_info+="ҵ��Ʒ��:"+document.all.sm_name.value+"|";
	opr_info+="����ҵ��:"+"����ҵ����"+"|";
	opr_info+="������ˮ:"+'<%=loginAccept%>'+"|";
	opr_info+="����ʱ��:"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	opr_info+="���ǰ��Ʒ:"+document.all.UsingCRProdCode.value+"->"+document.all.UsingCRProdName.value+"|";
	opr_info+="������Ʒ:"+document.all.mebProdName.value+"|";
	opr_info+="��Чʱ��:"+"����"+"|";

	retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;
}	


</script>
</HEAD>
<BODY>
<FORM action="" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">���˲����Ʒ���</div>
	</div>
 <table cellspacing="0">
    <input type="hidden" name="opCode" value="<%=opCode%>"> 
    <input type="hidden" name="loginAccept" value="<%=loginAccept%>">
    <input type="hidden" name="loginNo" value="<%=workno%>">
    <input type="hidden" name="loginPwd" value="<%=nopass%>">
    <input type="hidden" name="orgCode" value="<%=org_code%>">
    <input type="hidden" name="ip_Addr" value="<%=ip_Addr%>">  
    <input type="hidden" name="power_right" value="<%=power_right%>">  
    <input type="hidden" name="mebMonthFlag1" value="">  
    <input type="hidden" name="mebProdCode" value="">               		          
    <input type="hidden" name="matureProdCode" value="">          		          
	<%
	if(nextFlag==1)
	{
%>
	<TR>   
		<td class="blue">�������</td>                                 
		<td >                     
			<input class="InputGrey" readOnly type="text" v_type="mobphone" v_must=1 v_minlength=1 v_maxlength=11 value="<%=phone_no%>" name="phone_no"  maxlength="11"  onkeydown="if(event.keyCode==13)doQuery()" <%if(nextFlag==2){out.print("readonly");}%>>
			<font color="orange">*</font>
		</td>
	</TR>

	<tr>
		<td colspan="2" align="center" id="footer">
			<input class="b_foot" name=sure22 type=button value="ȷ��" onClick="doQuery();" style="cursor:hand">
			<input class="b_foot" name=close22 type=button value="�ر�" onclick="removeCurrentTab()">
		</td>
	</tr>
<%
	}
%>
    <%
     if(nextFlag==2)//��ѯ����
     {
    %> 
	<tr style=display="none"> 
		<td  class="blue" width="15%"> �������</td>
		<td width="35%">
			<input class="InputGrey" readOnly type="text" name="phoneNo" maxlength="11" class="button"  value="<%=phone_no%>">
		</td>
		<td class="blue" width="15%">�ͻ�ID</td>
		<td width="35%"> 
			<input type="text" name="cust_id" maxlength="6" class="InputGrey" readOnly value="<%=sOutCustId%>">
			<input type="hidden" readonly name="sOutCustAddress" class="InputGrey" value="<%=sOutCustAddress%>">
			<input type="hidden" readonly name="sOutIdIccid" class="InputGrey" value="<%=sOutIdIccid%>">
		</td>
	</tr>
	
	<tr> 
		<td class="blue">�ͻ�����</td>
		<td> 
			<input type="text" name="cust_name" class="InputGrey" readOnly value="<%=sOutCustName%>" >
		</td>
		<td class="blue">ҵ��Ʒ�� </td>
		<td> 
			<input type="hidden" readonly name="sm_code" class="InputGrey" value="<%=sOutSmCode%>">
			<input type="text" readonly name="sm_name" class="InputGrey" value="<%=sOutSmName%>">
		</td>
	</tr>
	
	<tr> 
		<td class="blue">����Ʒ</td>
		<td> 
			<input type="hidden" readonly name="ProductCode" maxlength="5" class="InputGrey" value="<%=sOutProductCode%>">
			<input type="text"   readonly name="ProductName" maxlength="5" class="InputGrey" value="<%=sOutProductName%>" size="30">
		</td>
		<td class="blue">����״̬</td>
		<td> 
			<input type="hidden" readonly name="RunCode" class="InputGrey" value="<%=sOutRunCode%>">
			<input type="text" readonly name="RunName" class="InputGrey" value="<%=sOutRunName%>">
		</td>
	</tr>
	
	<tr> 
		<td class="blue">ҵ������</td>
		<td> 
			<input type="hidden" readonly name="CRColorType" maxlength="5" class="InputGrey" value="<%=sOutCRColorType%>">
			<input type="text"   readonly name="CRColorTypeName" maxlength="5" class="InputGrey" value="<%=sOutCRColorTypeName%>">
		</td>
		<td class="blue">����ʱ�� </td>
		<td> 
			<input type="text" readonly  name="CRBellBeginTime" class="InputGrey" maxlength="20" value="<%=sOutCRBellBeginTime%>">
		</td>
	</tr>
	
	<tr> 
		<td class="blue">�Ѷ��������Ʒ</td>
		<td> 
			<input type="hidden" readonly name="UsingCRProdCode" maxlength="5" class="InputGrey" value="<%=sOutUsingCRProdCode%>">
			<input type="text"   readonly name="UsingCRProdName" maxlength="5" class="InputGrey" value="<%=sOutUsingCRProdName%>">
		</td>
		<td class="blue">��������״̬ </td>
		<td> 
			<input type="text" readonly  name="CRRunName" class="InputGrey" maxlength="20" value="<%=sOutCRRunName%>">
		</td>
	</tr>
	
	<TR>
		<TD class="blue">ҵ������</TD>
		<TD class="blue">
			<SELECT name="mebMonthFlag" class="button" id="mebMonthFlag" onclick="changeOthers()">
				<option value="2" >������</option>
				<option value="3" >��������</option>
				<option value="4" >������</option>
				<option value="1" selected>������</option>
			</SELECT>
			<font color="orange">*</font>									
		</TD>
		<TD class="blue">�����Ʒ</TD>
		<TD id="ipTd">
			<input type="text" id="mebProdName"  name="mebProdName" size="20" value=""  readonly>
			<input name="mebProdCodeQuery" type="button" id="mebProdCodeQuery" class="b_text" onMouseUp="getmebProdCodeQuery(); " onKeyUp="if(event.keyCode==13)getmebProdCodeQuery();" value="ѡ��">
			<font color="orange">*</font>
		</TD>				
	</TR>
	
   <tbody id=tbs2 style="display:none">
	   <TR span=1>
		<TD class="blue">���굽��ת����</TD>
		<TD class="blue">
			<SELECT name="matureFlag" class="button" id="change_year" onChange="changeMatureFlag()" >
				<option value="Y" >��</option>
				<option value="N" selected>�� </option>
			</SELECT>
				<input type="text" id="matureName"  name="matureName" size="30" value="" readonly>
				<input name="matureProdCodeQuery" type="button" id="matureProdCodeQuery"  class="b_text" onMouseUp="getmatureProdCodeQuery();" onKeyUp="if(event.keyCode==13)getmatureProdCodeQuery();" value="ѡ��" disabled> 		
				<font color="orange">*</font>
		<TD>&nbsp;</TD>
		<TD>&nbsp;</TD>                
	</TR>
</tbody>
        
	<tr style="display:none"> 
		<td class="blue">ϵͳ��ע</td>
		<td>
			<input class="button" readonly name=sysNote value="" size=60 maxlength="60">
		</td>
	</tr>
	<tr  style="display:none"> 
		<td class="blue">��ע</td>
		<td colspan="3"> 
			<input class="button" name=opNote size=60 value="" maxlength="60">
		</td>
	</tr>
                
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input class="b_foot" name=sure type="button" value=ȷ�� onclick="refain1()">
			&nbsp;
			<input class="b_foot" name=clear type=reset value=���� onClick="history.go(-1);">
			&nbsp;
			<input class="b_foot" name=reset type=button value=�ر� onClick="removeCurrentTab()">
		</td>
	</tr>                
	    <%
	    }//end   if(nextFlag==2)    
	   %>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

