<%
/********************
 version v2.0
 ������: si-tech
 ģ��: ��ͥ����ƻ�����
 update zhaohaitao at 2009.1.6
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%		

	/**�����������Ǹ�ҳ�����,��ǰ�º���ʾ�õ�**/
	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
 
 	/**������������ר�Ÿ�ͳһ�Ӵ��õ�**/   
    String cnttOpCode = request.getParameter("opCode");
    String cnttOpName = request.getParameter("opName");
    
  String loginName = (String)session.getAttribute("workName");
  String regCode = (String)session.getAttribute("regCode");
%>
<%
  String retFlag="",retMsg="";//����Ƿ�У��ʧ�ܵı�־����Ϣ
/****************���ƶ�����õ����롢������������ܰ��ͥ�������Ϣ s1251Init***********************/
  String[] paraAray1 = new String[3];
  String main_card = request.getParameter("chief_srv_no");/* �ҳ�����*/
  String phoneNo = request.getParameter("srv_no"); 
  String openType = request.getParameter("open_type");/* ��������*/
  
   /*****************
  	*add by zhanghonga@2009-02-06,
  	*����openType������opCode��opName,
  	*����ͳһ�Ӵ���opcode,opname��¼����
  	*������ǰ��ʾ�Ļ����벻��ʾ
  	****************/
	  switch(Integer.parseInt(openType)){
	  	case 0 : 
	  					opCode = "7129";
	  					opName = "��ͥ����ƻ����ѹ�ϵ����";
	  					break;
	  	case 1 :
	  					opCode = "7133";
	  					opName = "��ͥ����ƻ��޸ĵ���";
	  					break;
	  	case 2 :
	  					opCode = "7134";
	  					opName = "��ͥ����ƻ����ѹ�ϵȡ��";
	  					break;
	  	default:
	  					opCode = "7129";
	  					opName = "��ͥ����ƻ����ѹ�ϵ����";
	  					break;
	  }
	  System.out.println("########################################f7124_2.jsp->opCode->"+opCode+"&opName->"+opName);
  /**************add end here******************/
  
  /**�����op_code�Ǹ������õ�**/
  String op_code ="";
  if(openType.equals("0")){
	op_code="7129";
  }else if(openType.equals("1")){
	op_code="7133";
  }else{
	op_code="7134";
  }
  
  String passwordFromSer="";
  
  paraAray1[0] = main_card; /* �ҳ�����   */ 
  paraAray1[1] = phoneNo;	/*��Ա����*/
  paraAray1[2] = op_code;	/* ��������  op_code */


  String op_type ="";
  String readtype="";

  if(openType.equals("0")){
	op_type="���ѹ�ϵ����";
  }else if(openType.equals("1")){
	op_type="�޸ĵ���";
  }else{
	op_type="���ѹ�ϵ���";
	readtype="readonly";
  }

  
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  System.out.println("main_card= "+main_card);
  System.out.println("phoneNo= "+phoneNo);
  System.out.println("op_code= "+op_code);
  
  //retList = impl.callFXService("s7129Valid", paraAray1, "38");
%>
	<wtc:service name="s7129Valid" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="36">			
	<wtc:param value="<%=paraAray1[0]%>"/>	
	<wtc:param value="<%=paraAray1[1]%>"/>	
	<wtc:param value="<%=paraAray1[2]%>"/>	
	</wtc:service>	
	<wtc:array id="result1"  start="0" length="29" scope="end"/>
	<wtc:array id="result2"  start="29" length="1" scope="end"/>
	<wtc:array id="result3"  start="30" length="1" scope="end"/>
	<wtc:array id="result4"  start="31" length="1" scope="end"/>

	<wtc:array id="result7"  start="32" length="1" scope="end"/>
	<wtc:array id="result8"  start="33" length="1" scope="end"/>
	<wtc:array id="result9"  start="34" length="1" scope="end"/>
	<wtc:array id="result10"  start="35" length="1" scope="end"/>
<%
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",print_note="";
  String otherCardFlag = "",mainDisabledFlag="";
  String[][] tempArr= new String[][]{};
  String[][] familyCodeArr= new String[][]{};
  String[][] otherCodeArr= new String[][]{};
  String[][] cardTypeArr= new String[][]{};
  String[][] beginTimeArr= new String[][]{};
  String[][] endTimeArr= new String[][]{};
  String[][] opTimeArr= new String[][]{};
  String[][] newRateCodeArr= new String[][]{};
  String[][] pay_name = new String[][]{};
  String[][] allow_pay = new String[][]{};
  
  tempArr = result1;
  String errCode = retCode1;
  String errMsg = retMsg1;
  if(result1.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag="1";
	   retMsg="s7129Valid���ú��������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg ;
    }  
  }else if(errCode.equals("000000") && result1.length>0)
  {
	
	    bp_name = tempArr[0][3];//��������
	 
	    passwordFromSer = tempArr[0][2];//����
	
	    sm_code = tempArr[0][11];//ҵ�����
	 
	    sm_name = tempArr[0][12];//ҵ���������
	 
	    rate_code = tempArr[0][5];//�ʷѴ���
	
	    rate_name = tempArr[0][6];//�ʷ�����
	 
	    next_rate_code = tempArr[0][7];//�����ʷѴ���
	 
	    next_rate_name = tempArr[0][8];//�����ʷ�����
	 
	    bigCust_flag = tempArr[0][9];//��ͻ���־
	 
	    bigCust_name = tempArr[0][10];//��ͻ�����
	 
	    lack_fee = tempArr[0][15];//��Ƿ��
	
	    prepay_fee = tempArr[0][16];//��Ԥ��
	
	    print_note = tempArr[0][27];//��������
	
	  familyCodeArr = result2;//��ͥ���� 
	  otherCodeArr = result3;//��������--��Ա����
      cardTypeArr = result4;//������--����ʱ��

     opTimeArr = result7;//����ʱ��--����
	  newRateCodeArr = result8;//��ܰ��ͥ�ʷѴ���--����
	  pay_name = result9;
	  allow_pay = result10;
	  //�ж��Ƿ���������¼
	  if(familyCodeArr==null || familyCodeArr.length==0 || familyCodeArr[0][0].equals("")){
		if(!retFlag.equals("1"))
	    {
	       retFlag="1";
	       retMsg="�ú���û�ж�Ӧ��������Ϣ!";
        }  
	  }else if(familyCodeArr.length>1){
	    otherCardFlag = "1";//�ж��Ƿ���ڸ���
	  }
	}else{
		if(!retFlag.equals("1"))
	    {
	       retFlag="1";
	       retMsg="s7129Valid���ú��������Ϣʧ��!"+errMsg;
        }
	}
 
//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//   
   //�Ż���Ϣ
  String[][] favInfo = (String[][])session.getAttribute("favInfo");   //���ݸ�ʽΪString[0][0]---String[n][0]
  boolean pwrf = false;//a272 ��������֤
  int infoLen = favInfo.length;
  String tempStr = "";
  for(int i=0;i<infoLen;i++)
  {
    tempStr = (favInfo[i][0]).trim();
    if(tempStr.compareTo("a272") == 0)
    {
      pwrf = true;
    }
  }
  String passTrans=WtcUtil.repNull(request.getParameter("cus_pass")); 	  
 // if(!pwrf)
 // {
	   String passFromPage=Encrypt.encrypt(passTrans);
       if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage)){
		  if(!retFlag.equals("1"))
	      {
	         retFlag="1";
	         retMsg="�������!";
          }
	   }	       
		 
 // }
  
  //******************�õ�����������***************************//
  /**
  comImpl co=new comImpl();
  //�ʷѴ��� 
  String sqlNewRateCode2  = "";  
  sqlNewRateCode2  = "select a.mode_code, a.mode_code||'--'||b.mode_name from sRegionNormal a, sBillModeCode b where a.region_code=b.region_code and a.mode_code=b.mode_code and a.region_code='" + orgCode.substring(0,2) + "'";
  ArrayList newRateCodeArr2  = co.spubqry32("2",sqlNewRateCode2 );
  String[][] newRateCodeStr2  = (String[][])newRateCodeArr2.get(0);
  **/	
	
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();
%>
<head>
<title>��ͥ����ƻ�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
 
<script language="JavaScript">
    //���У��ʧ�ܣ��򷵻���һ����
	<%if(retFlag.equals("1")){%>
	 rdShowMessageDialog("<%= retMsg %>",0);
	 window.location="f7124.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	<%}%>
<!--
  //����Ӧ��ȫ�ֵı���
  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";
 
  onload=function()
  {		
  }
  
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
  //***//У��one
  function checkOne(){    
	var flag = 0;
	var card_type,phoneNo ;
	var radio1 = document.getElementsByName("phoneNo");
	for(var i=0;i<radio1.length;i++){
	  if(radio1[i].checked){
	    flag = 1;
		phoneNo = oneTokSelf(radio1[i].value,"~",1);//������
		card_type = oneTokSelf(radio1[i].value,"~",2);//������
		document.frm.phoneNoForPrt.value=phoneNo;
		document.frm.cardTypeForPrt.value=card_type;
	  }
	}
	if(flag==0){
	  rdShowMessageDialog("��ѡ��Ҫȡ���ĺ���!");
	  return false;
	}else
	{
	  if(card_type=="1")
	  {
	    if(document.frm.new_rate_code2.value=="")
		{
		  rdShowMessageDialog("��ѡ�����ײʹ���!");
		  document.frm.new_rate_code2.focus();
	      return false;
		}
	  }
	}
	return true;
  }
  //
 
  /*���ݿ����Ͷ�̬�ı��еĿɼ���*/
  function controlByCardType(str)
  {
    var card_type = oneTokSelf(str,"~",2);//������
	var phoneNo = oneTokSelf(str,"~",1);//������
	document.frm.phoneNoForPrt.value=phoneNo;
    document.frm.cardTypeForPrt.value=card_type;
	if(card_type=="1")
	{
		document.all.newRateCode2Tr.style.display="";
	}else
	{
	    document.all.newRateCode2Tr.style.display="none";
	}
	return true;
  }

   function frmPrint(subButton){
   	getAfterPrompt();
	//controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	subButton.disabled = true;
	if(document.frm.limit_pay.value.length==0 && document.frm.op_code.value !="7134")
	{
	  rdShowMessageDialog("��������߽��!");
	  document.frm.limit_pay.focus();
      return false;
	}
	setOpNote();//Ϊ��ע��ֵ
	frm.action = "f7124_3_Cfm.jsp";
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
   var phoneNo="<%=main_card%>";                             //�ͻ��绰
		/* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* ningtn */
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
   path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;
  }

  function printInfo(printType)
  {
	var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//�õ�ִ��ʱ��
	
	var cust_info=""; //�ͻ���Ϣ
	var opr_info=""; //������Ϣ
	var note_info1=""; //��ע1
	var note_info2=""; //��ע2
	var note_info3=""; //��ע3
	var note_info4=""; //��ע4
	var retInfo = "";  //��ӡ����
	
	cust_info+="�ֻ����룺"+"<%=main_card%>"+"|";
	cust_info+="�ͻ�������"+document.frm.bp_name.value+"|";
	
	opr_info+="ҵ�����ͣ���ͥ����ƻ�����"+"<%=op_type%>"+"|";
	opr_info+="��ˮ��"+"<%=printAccept%>"+"|";
	opr_info+="��ͨ���룺"+"<%=main_card%>"+"|";
	opr_info+="��ʼʱ�䣺"+exeDate+"|";
	opr_info+="�������ʣ�"+"<%=print_note%>"+"|"; 
	
	note_info1+="��ע��"+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	
	return retInfo;
  }
  //�ύ���� 
  /*function printCommit(subButton){
	controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	//У��
	setOpNote();//Ϊ��ע��ֵ
    //�ύ��
    frmCfm();	
	return true;
  }*/
  function setOpNote(){
	if(document.frm.opNote.value.length==0)
	  document.frm.opNote.value = "��ͥ����ƻ����--<%=op_type%>����:"+"<%=phoneNo%>"; 
	return true;
}

function goBack(){
	window.location="f7124.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
}
	
//-->
</script>

</head>

<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

      <table cellspacing="0">
		  <tr> 
            <td class="blue">��������</td>
            <td colspan="3">
			  <input name="op_name" type="text" class="InputGrey" id="op_name" size="30" value="<%=op_type%>" readonly>
			</td>
          </tr>
          <tr> 
		    <td class="blue">�ҳ�����</td>
            <td>
			  <input name="main_card" type="text" class="InputGrey" id="main_card" value="<%=main_card%>" readonly >
			</td>
            <td class="blue">ҵ������</td>
            <td>
			  <input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_code + "--" + sm_name%>" readonly>
			</td>
          </tr>
          <tr> 
            <td class="blue">��ǰ���ײ�</td>
            <td>
			  <input name="rate_name" type="text" class="InputGrey" id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>" readonly>
			</td>
			<td class="blue">�������ײ�</td>
            <td>
			  <input name="next_rate_name" type="text" class="InputGrey" id="next_rate_name" size="30"  value="<%=next_rate_code+"--"+next_rate_name%>" readonly>
			</td>             
          </tr>
		  <tr>
		    <td class="blue">��������</td>
            <td>
			  <input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>
			</td>
            <td class="blue">��ͻ���־</td>
            <td>
			<input name="bigCust_flag" type="text" class="InputGrey" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" readonly>
			</td>
          </tr>
		  <tr >
		  <td class="blue">���޽��</td>
		  <td colspan="3">
			  <input name="limit_pay" type="text" id="limit_papy" value=""  <%=readtype%> >
		  </td>
		  </tr>
		</table>
		</div>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">ҵ����ϸ</div>
</div>
		<TABLE border=0 align="center" cellSpacing="0">
          <TBODY> 
		  <tr>
			<tr align="middle">
		      <th align=center>��ͥ����</th>
			  <th align=center>��ͥ���</th>
			  <th align=center>��ͥ��Ա</th>
			  <th align=center>��ʼʱ��</th>
		
			  <th align=center>�ҳ�����</th>
			  <th align=center>���޽��</th>
			</tr>
			<% 
			 for(int j=0;j<otherCodeArr.length;j++){
			 	String tdClass = (j%2==0)?"Grey":"";
                if(cardTypeArr[j][0].equals("0") && otherCardFlag.equals("1")){
				  mainDisabledFlag = "disabled";
				}else{
				  mainDisabledFlag = "";
				}
			%>
		    <tr> 
			  <td class="<%=tdClass%>" align=center><%=familyCodeArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=newRateCodeArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=otherCodeArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=cardTypeArr[j][0]%></td>

			  <td class="<%=tdClass%>" align=center><%=pay_name[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=allow_pay[j][0]%></td>
			</tr>				
			<%
}
%>
		</table>
	<!-- ningtn 2011-8-3 09:58:25 ������ӹ��� -->
	<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
	</jsp:include>
	    <TABLE cellSpacing="0">
          <TBODY> 
		  <tr> 
            <td colspan="4" id="footer"> <div align="center"> 
                &nbsp; 
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="ȷ��&��ӡ" onClick="frmPrint(this)" >
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="���" >
                &nbsp; 
                <input name="back" onClick="goBack()" type="button" class="b_foot" value="����">
                &nbsp; 
				</div>
			</td>
          </tr>
       </table>
  
  <input type="hidden" name="phoneNoForPrt" ><!--Ҫȡ�����ֻ�����,���ڴ�ӡ-->
  <input type="hidden" name="cardTypeForPrt" ><!--Ҫȡ���Ŀ�����,���ڴ�ӡ-->
  <input type="hidden" name="printAccept" value="<%=printAccept%>"><!--��ӡ��ˮ-->
  <input type="hidden" name="op_code" value="<%=op_code%>" >
  <input type="hidden" name="op_note" value="<%=openType%>" >
  <input type="hidden" name="home_no" value="<%=phoneNo%>" >
  <input type="hidden" name="opName" value="<%=opName%>" >
  <input type="hidden" name= "opNote" value="">
  <!--����������������ר�Ÿ�ͳһ�Ӵ��õ�-->
   <input type="hidden" name= "cnttOpCode" value="<%=cnttOpCode%>">
    <input type="hidden" name= "cnttOpName" value="<%=cnttOpName%>">
   <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
<!-- ningtn 2011-8-3 09:59:10 ���ӻ���������Χ -->
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>

