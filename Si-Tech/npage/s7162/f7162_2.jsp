<%
/********************
version v2.0
������: si-tech
ģ�飺��ֵ����
���ڣ�2008.12.1
���ߣ�leimd
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=GBK"%>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%		
  //ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
  //String[][] baseInfoSession = (String[][])arrSession.get(0);
  //String[][] otherInfoSession = (String[][])arrSession.get(2);
  //String[][] pass = (String[][])arrSession.get(4);
	    
  //String loginNo = baseInfoSession[0][2];
  //String loginName = baseInfoSession[0][3];
  //String powerCode= otherInfoSession[0][4];
  //String orgCode = baseInfoSession[0][16];
  
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  //String ip_Addr = request.getRemoteAddr();  
  //String regionCode = orgCode.substring(0,2);
  //String regionName = otherInfoSession[0][5];
  //String loginNoPass = pass[0][0];  	    
  //String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];	
  //String aftertrim = baseInfoSession[0][5].trim();
%>
<%
  String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
/****************���ƶ�����õ����롢���������� ����Ϣ s126bInit***********************/
  //SPubCallSvrImpl impl = new SPubCallSvrImpl();
  ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String award_type= request.getParameter("award_type");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  paraAray1[1] = loginNo; 	    /* ��������   */
  paraAray1[2] = orgCode;	    /* ��������   */
  paraAray1[3] = "7162";	    /* ��������   */
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
 // retList = impl.callFXService("s1557Init", paraAray1, "29","phone",phoneNo);
  %>
    <wtc:service name="s1557Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="error_code" retmsg="error_msg" outnum="29" >
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/> 
		<wtc:param value="<%=paraAray1[3]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
 <%
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",print_note="",contract_flag="",high_flag="";
  //String[][] tempArr= new String[][]{};
  String errCode = error_code;
  String errMsg = error_msg;
  System.out.println("errCode=========="+errCode);
   System.out.println("errMsg=========="+errMsg);
  if(!errCode.equals("000000")){
    retFlag = "1";
	retMsg = "s1557Init��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		%>
	<script>
	 rdShowMessageDialog("<%=retMsg%>");
	 history.go(-1);
	</script>		
		<%
  }else{
  if(tempArr == null)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s1557Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(tempArr == null))
  {
	System.out.println("errCode = "+errCode +"errMsg = "+ errMsg);
	if (errCode.equals("000000")){
	  //tempArr = (String[][])retList.get(3);
	  if(!(tempArr[0][3].equals(""))){
	    bp_name = tempArr[0][3];//��������
	  }

	  //tempArr = (String[][])retList.get(4);
	  if(!(tempArr[0][4].equals(""))){
	    bp_add = tempArr[0][4];//�ͻ���ַ
	  }

	  //tempArr = (String[][])retList.get(2);
	  if(!(tempArr[0][2].equals(""))){
	    passwordFromSer = tempArr[0][2];//����
	  }

	  //tempArr = (String[][])retList.get(11);
	  if(!(tempArr[0][11].equals(""))){
	    sm_code = tempArr[0][11];//ҵ�����
	  }

	  //tempArr = (String[][])retList.get(12);
	  if(!(tempArr[0][12].equals(""))){
	    sm_name = tempArr[0][12];//ҵ���������
	  }

	  //tempArr = (String[][])retList.get(13);
	  if(!(tempArr[0][13].equals(""))){
	    hand_fee = tempArr[0][13];//������
	  }

	  //tempArr = (String[][])retList.get(14);
	  if(!(tempArr[0][14].equals(""))){
	    favorcode = tempArr[0][14];//�Żݴ���
	  }

	  //tempArr = (String[][])retList.get(5);
	  if(!(tempArr[0][5].equals(""))){
	    rate_code = tempArr[0][5];//�ʷѴ���
	  }

	  //tempArr = (String[][])retList.get(6);
	  if(!(tempArr[0][6].equals(""))){
	    rate_name = tempArr[0][6];//�ʷ�����
	  }

	  //tempArr = (String[][])retList.get(7);
	  if(!(tempArr[0][7].equals(""))){
	    next_rate_code = tempArr[0][7];//�����ʷѴ���
	  }

	  //tempArr = (String[][])retList.get(8);
	  if(!(tempArr[0][8].equals(""))){
	    next_rate_name = tempArr[0][8];//�����ʷ�����
	  }

	  //tempArr = (String[][])retList.get(9);
	  if(!(tempArr[0][9].equals(""))){
	    bigCust_flag = tempArr[0][9];//��ͻ���־
	  }

	  //tempArr = (String[][])retList.get(10);
	  if(!(tempArr[0][10].equals(""))){
	    bigCust_name = tempArr[0][10];//��ͻ�����
	  }

	  //tempArr = (String[][])retList.get(15);
	  if(!(tempArr[0][15].equals(""))){
	    lack_fee = tempArr[0][15];//��Ƿ��
	  }

	  //tempArr = (String[][])retList.get(16);
	  if(!(tempArr[0][16].equals(""))){
	    prepay_fee = tempArr[0][16];//��Ԥ��
	  }

	  //tempArr = (String[][])retList.get(17);
	  if(!(tempArr[0][17].equals(""))){
	    cardId_type = tempArr[0][17];//֤������
	  }

	  //tempArr = (String[][])retList.get(18);
	  if(!(tempArr[0][18].equals(""))){
	    cardId_no = tempArr[0][18];//֤������
	  }

	  //tempArr = (String[][])retList.get(19);
	  if(!(tempArr[0][19].equals(""))){
	    cust_id = tempArr[0][19];//�ͻ�id
	  }

	  //tempArr = (String[][])retList.get(20);
	  if(!(tempArr[0][20].equals(""))){
	    cust_belong_code = tempArr[0][20];//�ͻ�����id
	    System.out.println("aaaaaaaaa="+cust_belong_code);
	  }

	  //tempArr = (String[][])retList.get(21);
	  if(!(tempArr[0][21].equals(""))){
	    group_type_code = tempArr[0][21];//���ſͻ�����
	  }

	  //tempArr = (String[][])retList.get(22);
	  if(!(tempArr[0][22].equals(""))){
	    group_type_name = tempArr[0][22];//���ſͻ���������
	  }

	  //tempArr = (String[][])retList.get(23);
	  if(!(tempArr[0][23].equals(""))){
	    imain_stream = tempArr[0][23];//��ǰ�ʷѿ�ͨ��ˮ
	  }

	  //tempArr = (String[][])retList.get(24);
	  if(!(tempArr[0][24].equals(""))){
	    next_main_stream = tempArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	  }

	  //tempArr = (String[][])retList.get(25);
	  if(!(tempArr[0][25].equals(""))){
	    print_note = tempArr[0][25];//�������
	  }

	  //tempArr = (String[][])retList.get(27);
	  if(!(tempArr[0][27].equals(""))){
	    contract_flag = tempArr[0][27];//�Ƿ������˻�
	  }

	  //tempArr = (String[][])retList.get(28);
	  if(!(tempArr[0][28].equals(""))){
	    high_flag = tempArr[0][28];//�Ƿ��и߶��û�
	  }

	}else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s1557Init��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	}
  }
//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//   
   //�Ż���Ϣ
  //String[][] favInfo = (String[][])arrSession.get(3);   //���ݸ�ʽΪString[0][0]---String[n][0]
  String[][]  favInfo = (String[][])session.getAttribute("favInfo"); //�Żݴ���Ϊ����
  boolean pwrf = true;//a272 ��������֤
  String handFee_Favourable = "readonly";        //a230  ������
  int infoLen = favInfo.length;
  String tempStr = "";
  for(int i=0;i<infoLen;i++)
  {
    tempStr = (favInfo[i][0]).trim();
    if(tempStr.compareTo("a272") == 0)
    {
      pwrf = true;
    }
	if(tempStr.compareTo(favorcode) == 0)
    {
      handFee_Favourable = "";
    }
  }
  String passTrans=WtcUtil.repNull(request.getParameter("cus_pass")); 
  if(!pwrf)
  {
     String passFromPage=Encrypt.encrypt(passTrans);
     if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage))	{
	   if(!retFlag.equals("1"))
	   {
	      retFlag = "1";
          retMsg = "�������!";
	   }
	    
    }       
  }
 
  //******************�õ�����������***************************//

  //Ԥ����
  String sql="select a.prepay_money,a.total_money from dPhoneAwardPrepay a,dCustmsg b  where b.phone_no = '"+phoneNo+"' and a.id_no=b.id_no";
  //ArrayList acceptList = impl.sPubSelect("2",sql);
  %>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" outnum="2" retmsg="ret_msg_1">
 <wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
	<wtc:array id="prepay_money" scope="end"/>
<%

  System.out.println("sql="+sql);
  System.out.println("prepay_money[0][0]"+prepay_money.length);
  //String [][]prepay_money=(String[][])acceptList.get(0);
  if (prepay_money.length != 0)
		{
		System.out.println("aaaa");
		System.out.println("prepay_money[0][0]============="+prepay_money[0][0]);
			if (prepay_money[0][0].equals("")) 
			{
				prepay_money = null;
				
			}
		}	
		
  if(prepay_money.length == 0)
		{
		System.out.println("bbbb");
		%>
	<script>
	 rdShowMessageDialog("���û���ֵ��Ϣ�����ڣ�");
	 history.go(-1);
	</script>		
		<%
	}else
		{
  
  sql="select a.prepay_fee ||','||a.child_code||','||b.res_code||','||a.favour_name,a.favour_name "+
  		"from sPrepayFavCode a,dbgiftrun.rs_code_info b  "+
  		"where region_code='"+cust_belong_code.substring(0,2)+"' "+
  		"and district_code='"+cust_belong_code.substring(2,4)+"' "+
  		"and a.sm_code='"+sm_code+"'  "+
	    "and a.valid_flag='0' "+
  		"and  a.mis_code=b.bak "+
  		"and prepay_fee <="+prepay_money[0][0]+"";
  	
  //System.out.println();
  
	//ArrayList acceptList = impl.sPubSelect("2",sql);
  //String [][]colNameArr=(String[][])acceptList.get(0);
  System.out.println("sql============"+sql);
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" outnum="2" retmsg="ret_msg_2">
 <wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
	<wtc:array id="colNameArr" scope="end"/>
<%
	if (colNameArr != null&&colNameArr.length!=0)
		{
			if (colNameArr[0][0].equals("")) 
			{
				colNameArr = null;
				System.out.println("colNameArr = null;");
			}
		}else{
%>			
		<script>
			 rdShowMessageDialog("���û���ֵ��Ϣ�����ڣ�");
			 history.go(-1);
		</script>	
<%		
	}
		
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();
  
%>
<html>
<head>
<title>��ֵ���� </title>
<%
        String opCode = "7162";
        String opName = "��ֵ����";
        
        String ReqPageName = WtcUtil.repNull(request.getParameter("ReqPageName"));
        activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
        System.out.println("##########################s1219Login.jsp->activePhone->"+activePhone);
%>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">

  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>");
    history.go(-1);
  <%}%>
<!--
  //***
  function frmCfm(){
 		frm.submit();
  }

  function printCommitTwo(subButton)
 {
 	getAfterPrompt();
	//document.frm.commit.disabled=true ;
  	if(document.frm.lines.value=="0")
  	{
  		rdShowMessageDialog("���������Ʒ��"); 
  		return ;
  	}
  	
  	if(countmoney()==false)
  	{
  		return false;
  	}
  	
	if(spendlist()==false)
	{
		return false;
	}
	setOpNote();//Ϊ��ע��ֵ
	frm.action = "f7162Cfm.jsp";
    //��ӡ�������ύ��
    var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
    if(typeof(ret)!="undefined")
    {
      if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
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
		var h=200;
		var w=350;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		
		var pType="subprint";
		var billType="1";
		var sysAccept = <%=printAccept%>;
		var mode_code = null;
		var fav_code = null;
		var area_code = null;
		var printStr = printInfo(printType);
		
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		   
		return ret;    
  }

  function printInfo(printType)
  {
	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	
	    cust_info+="�ͻ�������"+document.frm.bp_name.value+"|";
		cust_info+="�ֻ����룺"+document.frm.phoneNo.value+"|";
		cust_info+="֤�����룺"+"<%=cardId_no%>"+"|";
		cust_info+="�ͻ���ַ��"+"<%=bp_add%>"+"|";	
	  
	  var sum_consum ="";
	  sum_consum = parseFloat(document.frm.prepay_money_lj.value)-parseFloat(document.frm.consum_money.value);
      retInfo+='<%=loginName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 
      opr_info+="ҵ�����ͣ�"+"��ֵ����"+"   �һ���ֵ��" + document.frm.consum_money.value +"|";
      opr_info+="�ۼƳ�ֵ��"+document.frm.prepay_money_lj.value+"  ���ó�ֵ��"+parseFloat(sum_consum)+"|";
	  opr_info+="��ˮ: "+"<%=printAccept%>"+"|";
	  opr_info+="��Ʒ���ƣ�"+document.frm.presentlist.value+"|";
      opr_info+="<%=print_note%>"+"|"; 
		note_info1+= "��ע��"+"|";
	   //retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	   retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  	   retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 	
	  return retInfo;
  }

 /******Ϊ��ע��ֵ********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	   document.frm.opNote.value = "��ֵ����;"+document.frm.phoneNo.value; 
	}
	return true;
}



function putPrice(obj)
{	var shownamelist="";
	var pricevalue = obj.value.substr(0,obj.value.indexOf(","));
	var pricename="price"+obj.name.substr(5,obj.name.length);
	var numbername="number"+obj.name.substr(5,obj.name.length);
	var showname="showname"+obj.name.substr(5,obj.name.length);
	document.frm[eval('pricename')].value=pricevalue;
	document.frm[eval('numbername')].value="0";
	shownamelist+=document.frm[eval('showname')].value=obj.value.substr(obj.value.lastIndexOf(",")+1,obj.value.length)+"|";
}

function countmoney()
{
	var allmoney="0";
	for(var i =0;i<addflag;i++)
	{
		var pricename="price"+i;
		var numbername="number"+i;
		allmoney =parseFloat(allmoney)+parseFloat(document.frm[eval('pricename')].value)*parseFloat(document.frm[eval('numbername')].value);
		if(parseFloat(allmoney)>"<%=prepay_money[0][0]%>")
		{
			rdShowMessageDialog("��ֵ����,ʣ���");    
			document.frm[eval('numbername')].select();
			return false;
		}
		if(document.frm[eval('numbername')].value=="0")
		{
			rdShowMessageDialog("������������");    
			document.frm[eval('numbername')].select();
			return false;
		}
	}
}


function spendlist(){
	var sendlist="";
	var moneylist="";
	var numberlist="";
	var  consum_money="0" ;
	var presentlist = "";
	for(var i =0;i<addflag;i++)
	{
		
		var award="award"+i;
		
		if(document.frm[eval('award')].value=="")
		{
			rdShowMessageDialog("��ѡ����Ʒ��");    
			return false;
		}
		

		for (var j=i+1;j<addflag;j++) 
		{
			
			if (document.frm[eval('award')].value==document.frm['award'+[eval('j')]].value)
		    {	  
				  rdShowMessageDialog("ͬһ�ֽ�Ʒֻ����һ�У�");
      			  document.frm['award'+[eval('j')]].focus();
				  //document.frm.commit.disabled=true;
				  return false; 
			}   
			
		}


		sendlist+=document.frm[eval('award')].value+"|";
		var price="price"+i;
		var number="number"+i;
		moneylist+=parseFloat(document.frm[eval('price')].value)*parseInt(document.frm[eval('number')].value)+"|";
		numberlist+=parseInt(document.frm[eval('number')].value)+"|";
		
		consum_money =parseFloat(consum_money)+parseFloat(parseFloat(document.frm[eval('price')].value)*parseInt(document.frm[eval('number')].value));
		presentlist+=parseInt(document.frm[eval('number')].value)+"��"+document.frm[eval('award')].value.substr(document.frm[eval('award')].value.lastIndexOf(",")+1,document.frm[eval('award')].value.length)+"|";
	}
	document.frm.sendlist.value=sendlist;
	document.frm.moneylist.value=moneylist;
	document.frm.numberlist.value=numberlist;
	document.frm.consum_money.value=consum_money;
	document.frm.presentlist.value = presentlist;
}

function dynDelRow(){
var bb=parseInt(frm.lines.value);

	dyntb.deleteRow(); 
	document.frm.lines.value=bb-1;
	addflag--;
}
<%
if(colNameArr!=null)
{
%>
var addflag="0";
function dynAddRow(){
	
	if(countmoney()==false)
	{
		return;
	}
	
	var award = 'award'+addflag;
	var price = 'price'+addflag;
	var number = 'number'+addflag;
	var showname = 'showname'+addflag;
		
	frm.lines.value=parseInt(frm.lines.value)+1;
	var tr1=dyntb.insertRow();
	tr1.id="tr";
	tr1.insertCell().innerHTML = '<td> <div align=center><input class=b_text type=button name=del_line size=4 value=�� onClick="dynDelRow()"></div></td>';
	tr1.insertCell().innerHTML = '<td> <div align=center><select name='+award+' onchange=putPrice(this)><option></option> <%for(int j = 0;j<colNameArr.length;j++){out.print("<option value="+colNameArr[j][0]+" >" );out.print(colNameArr[j][1].trim());out.print("</option>");}%></select></div></td>';
	tr1.insertCell().innerHTML = '<td> <div align=center><input type=text id='+price+' name='+price+' size=14 class=button  readonly ></div></td>';
	tr1.insertCell().innerHTML = '<td> <div align=center><input type=text name='+number+' size=0 class=button maxlength=20 value=0 onKeyPress="return isKeyNumberdot(0)" onChange="countmoney('+addflag+')" ></div><input type=hidden name='+showname+' size=0 class=button maxlength=20></td>';
	//tr1.insertCell().innerHTML = '<td> <div align=center><input type=hidden name='+showname+' size=0 class=button maxlength=20>&nbsp;</div></td>';
	addflag++;
}
<%}%>
//-->
</script>
</head>
<body>
<form name="frm" method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
  <div id="title_zi">��ֵ����</div>
</div>
<table cellspacing="0">
  <tr>

			<input type="hidden" name="lines" value="0">
			<input type="hidden" name="sendlist">
			<input type="hidden" name="moneylist" >
			<input type="hidden" name="numberlist" >
			<input type="hidden" name="consum_money">
			<input type="hidden" name="presentlist">
			<input type="hidden" name="login_accept" value="<%=printAccept%>">

		<td class="blue">�ֻ�����</td>
    <td>
			 <input name="phoneNo" type="text" id="phoneNo" value="<%=phoneNo%>" Class="InputGrey" readOnly> 
		</td> 
		<td class="blue">��������</td>
    <td>
			 <input name="bp_name" type="text" id="bp_name" value="<%=bp_name%>" Class="InputGrey" readOnly>	
			 <input name="award_type" type="hidden" value=<%=award_type%>> 		  
		</td>           
  </tr>
  <tr> 
		<td class="blue">ҵ��Ʒ��</td>
    <td>
		<input name="sm_name" type="text" id="sm_name" value="<%=sm_code + "--" + sm_name%>" Class="InputGrey" readOnly>
		</td>
    <td class="blue">��ͻ���־</td>
    <td>
			<input name="bigCust_flag" type="text" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" Class="InputGrey" readOnly>
		</td>            
   </tr>
	 <tr> 
	 	<td class="blue">֤������</td>
    <td>
			<input name="cardId_type" type="text" id="cardId_type" value="<%=cardId_type%>" Class="InputGrey" readOnly>
		</td>
    <td class="blue">֤������</td>
    <td>
			<input name="cardId_no" type="text"  id="cardId_no" value="<%=cardId_no%>" Class="InputGrey" readOnly>
		</td>            
   </tr>
   <tr> 
      <td class="blue">��ǰ���ײ�</td>
      <td>
			  	<input name="rate_name" type="text" id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>" Class="InputGrey" readOnly>
			</td>
			<td class="blue">��ǰ���öһ����</td>
      <td>
			    <input name="prepay_money" type="text" id="rate_name" size="30" value="<%=prepay_money[0][0]%>" Class="InputGrey" readOnly>
		  </td>             
   </tr>
	 <tr> 
			<td class="blue">�ۼƳ�ֵ���</td>
      <td colspan="3">
				<input name="prepay_money_lj" type="text"  id="rate_name" size="30" value="<%=prepay_money[0][1]%>" Class="InputGrey" readOnly>
			</td> 

   </tr>
  </table>
  
  <table id="dyntb" cellspacing="0">
<%
if(colNameArr!=null)
{
%>
		<tr> 
      <td nowrap > 
        <input class="b_text"  type="button" name="inp" id="inp" value="���" onClick="dynAddRow()">
        </td>
        <td nowrap class="blue" align="center"> 
          ��Ʒ����
        </td>
        <td nowrap class="blue" align="center"> 
          �һ����
        </td>
        <td nowrap class="blue" align="center"> 
          ����
        </td>
    </tr>
<%}%>
</table>
<table cellspacing="0">
		<tr> 
      <td class="blue">��ע</td>
      <td colspan="3">
      	<input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="" onfocus="setOpNote()" class="InputGrey" readOnly> 
      </td>
		</tr>
	  <tr> 
			<td colspan="4"> <div align="center"> 
		    &nbsp; 
				&nbsp; 
				<input name="commit" id="commit" type="button" class="b_foot_long"   value="ȷ��&��ӡ" onClick="printCommitTwo(this)" >
		    &nbsp; 
		    <input name="reset" type="reset" class="b_foot" value="���" >
		    &nbsp; 
		    <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
		    &nbsp; 
			</td>
    </tr>
      </table>
   <%@ include file="/npage/include/footer.jsp" %>
</form>
</div>
</body>
</html>
<script language="JavaScript">
  <%if((high_flag.trim()).equals("Y")){%>
    rdShowMessageDialog('��ʾ: ��ע��,���û�Ϊ�и߶��û���');
  <%}
  
  	}
	
  }%>
</script>
