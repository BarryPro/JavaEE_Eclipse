   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-24
********************/
%>
              
<%
  String opCode = "2294";
  String opName = "���ſͻ�Ԥ������";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%		
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String regionCode = (String)session.getAttribute("regCode");
  
%>
<%
String retFlag="",retMsg="";
  String[] paraAray1 = new String[3];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String passwordFromSer="";
  String dept=request.getParameter("dept");
 
 
  
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

//  retList = impl.callFXService("s2294Init", paraAray1, "22","phone",phoneNo);
  %>
  
    <wtc:service name="s2294Init" outnum="22" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray1[0]%>" />
			<wtc:param value="<%=paraAray1[1]%>" />
			<wtc:param value="<%=paraAray1[2]%>" />		
		</wtc:service>
		<wtc:array id="result_t" scope="end" />  
  
  <%
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="",
  vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="";
  String zhanbi_name="",product_name="";
  String[][] tempArr= new String[][]{};
  String errCode = code;
  String errMsg = msg;
  if(result_t == null)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s8030Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(result_t == null))
  {System.out.println("errCode="+errCode);
  System.out.println("errMsg="+errMsg);
  if(!errCode.equals("000000")){%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("�������<%=errCode%>������Ϣ<%=errMsg%>",0);
 	 window.location="f2294_login.jsp?activePhone=<%=phoneNo%>";
  	//-->
  </script>
  <%}
	if (errCode.equals("000000")){
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
	    zhanbi_name = result_t[0][20];//�������
	    product_name = result_t[0][21];//���Ų�Ʒ
  }
}
%>
 <%  //�Ż���Ϣ//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//   
  boolean pwrf = false;//a272 ��������֤
  String handFee_Favourable = "readonly";        //a230  ������
  
  //2011/9/2  diling��� ������Ȩ������ start
  	String pubOpCode = opCode;  
  %>
  	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
  <%
  	System.out.println("==�ڶ���======s2287.jsp==== pwrf = " + pwrf);
  //2011/9/2  diling��� ������Ȩ������ end
  
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
 %>
<%
//******************�õ�����������***************************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
String exeDate="";
exeDate = getExeDate("1","1141");

  //������Ʒ
  String sqlAgentCode = " select  unique gift_code,trim(gift_name) from sGrpGiftCfg where region_code=:regionCode1 and valid_flag='Y'";
  System.out.println("sqlAgentCode====="+sqlAgentCode);
  //ArrayList agentCodeArr = co.spubqry32("2",sqlAgentCode);
  String [] paraIn = new String[2];
  paraIn[0] = sqlAgentCode;    
  paraIn[1]="regionCode1="+regionCode;

  %>
  
 	<wtc:service name="TlsPubSelCrm" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraIn[0]%>"/>
        <wtc:param value="<%=paraIn[1]%>"/> 
    </wtc:service>
	 <wtc:array id="result_t1" scope="end"/> 
  
  <%
  String[][] agentCodeStr =result_t1;
  //Ӧ��Ԥ��
  String sqlPhoneType = "select gift_code,pay_money from sGrpGiftCfg where region_code=:regionCode2 and valid_flag='Y'";
  System.out.println("sqlPhoneType====="+sqlPhoneType);
  //ArrayList phoneTypeArr = co.spubqry32("2",sqlPhoneType);
	paraIn[0] = sqlPhoneType;    
	paraIn[1]="regionCode2="+regionCode;
  %>
  
	<wtc:service name="TlsPubSelCrm" outnum="2" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraIn[0]%>"/>
        <wtc:param value="<%=paraIn[1]%>"/> 
    </wtc:service>
	 <wtc:array id="result_t2" scope="end"/>  
  
  <%
  String[][] phoneTypeStr = result_t2;
 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>���ſͻ�Ԥ����</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
 
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
	  rdShowMessageDialog("����������!",0);
      cust_name.focus();
	  return false;
	}
	
	
	
	if(agent_code.value==""){
	  rdShowMessageDialog("������������Ʒ!",0);
      agent_code.focus();
	  return false;
	}
	if(prepay_fee.value==""){
	  rdShowMessageDialog("������Ӧ��Ԥ��!",0);
      phone_type.focus();
	  return false;
	}
	
	
	document.all.phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text;
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
   
   var printStr = printInfo(printType);
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =document.frm.login_accept.value;                       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                        //�ʷѴ���
     var fav_code=null;                         //�ط�����
     var area_code=null;                        //С������
     var opCode =   "<%=opCode%>";                         //��������
     var phoneNo = "<%=phoneNo%>";                            //�ͻ��绰
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
		
		
   return ret;    
}

function printInfo(printType)
{
  vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="";
	var month_fee ;
	
   	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		
	cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.cust_addr.value+"|";
	cust_info+="֤�����룺"+'<%=cardId_no%>'+"|";
	
	opr_info+="��λ��ַ��"+'<%=vUnitAddr%>'+"|";
	opr_info+="��ϵ�绰��"+'<%=vContactPhone%>'+"|";
	opr_info+="����ID��"+'<%=vUnitId%>'+"|";
	opr_info+="�������ƣ�"+'<%=vUnitName%>'+"|";
	opr_info+="ҵ�����༯�ſͻ�Ԥ������"+"|";
	opr_info+="�ͻ�Ԥ��"+parseInt(document.all.prepay_money.value)+"Ԫ"+"|";
    opr_info+="������Ʒ��"+document.all.phone_typename.value+"|";
	opr_info+="����ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd ", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
	note_info1+="��ע����ӭ���μ��й��ƶ���Ԥ�����񡱻����л�����й��ƶ���֧�֣�����ʹ���������κ��������ѯ�����ڼ��ŵĿͻ�����"+"|";

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
    return retInfo;
}



//-->
</script>

<script language="JavaScript">
<!--
/****************����agent_code��̬����phone_type������************************/

 function selectChange(){
 
 	
   	var x1 ;
   	for ( x1 = 0 ; x1 < arrPhoneType.length  ; x1++ )
   	{ //alert(arrPhoneType[x1] );
   	  //alert(document.all.agent_code.value);
      		if ( arrPhoneType[x1] == document.all.agent_code.value)
      		{
        		
        		document.all.prepay_money.value=arrPhoneName[x1] ;
        		
      		}
   	}

 }



//-->
</script>


</head>


<body>
<form name="frm" method="post" action="f2294_2.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">���ſͻ�Ԥ������</div>
	</div>
 

        <table  cellspacing="0">
		  <tr> 
            <td class="blue">��������</td>
            <td class="blue">���ſͻ�Ԥ������--����</td>
            <td class="blue">&nbsp;</td>
            <td class="blue">&nbsp;</td>
          </tr>        
		  <tr> 
            <td class="blue">����ID</td>
            <td class="blue">
			  <input name="vUnitId" value="<%=vUnitId%>" type="text"  v_must=1 readonly  class="InputGrey" id="vUnitId" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">��������</td>
            <td class="blue">
			  <input name="vUnitName" value="<%=vUnitName%>" type="text"  v_must=1 readonly  class="InputGrey" id="vUnitName" maxlength="60" > 
			  <font class="orange">*</font>
            </td>
            </tr>

			
		  
		  
		  <tr> 
            <td class="blue">�ͻ�����</td>
            <td class="blue">
			  <input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1 readonly  class="InputGrey" id="cust_name" maxlength="20" v_name="����"> 
			  <font class="orange">*</font>
            </td>
            <td class="blue">�ͻ���ַ</td>
            <td class="blue">
			  <input name="cust_addr" value="<%=bp_add%>" type="text"  v_must=1 readonly  class="InputGrey" id="cust_addr" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">֤������</td>
            <td class="blue">
			  <input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1 readonly  class="InputGrey" id="cardId_type" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">֤������</td>
            <td class="blue">
			  <input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1 readonly  class="InputGrey" id="cardId_no" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">ҵ��Ʒ��</td>
            <td class="blue">
			  <input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1 readonly  class="InputGrey" id="sm_code" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">����״̬</td>
            <td class="blue">
			  <input name="run_type" value="<%=run_name%>" type="text"  v_must=1 readonly  class="InputGrey" id="run_type" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">VIP����</td>
            <td class="blue">
			  <input name="vip" value="<%=vip%>" type="text"  v_must=1 readonly  class="InputGrey" id="vip" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">����Ԥ��</td>
            <td class="blue">
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1 readonly  class="InputGrey" id="prepay_fee" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            
            <tr> 
            <td class="blue">���Ź���</td>
            <td class="blue">
			  <input name="group_type" value="<%=zhanbi_name%>" type="text"  v_must=1 readonly class="InputGrey" id="group_type" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">&nbsp;</td>
             <td class="blue">&nbsp;</td>
            </tr>
			
			
			
			
			<tr> 
            <td class="blue">������Ʒ</td>
            <td class="blue">
			  <SELECT id="agent_code" name="agent_code" v_must=1  onchange="selectChange();" v_name="�ֻ�������">  
			    <option value ="">--��ѡ��--</option>
                <%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
                <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
                <%}%>
              </select>
			  <font class="orange">*</font>	
			</td>
	 <td class="blue">Ӧ��Ԥ��</td>
            <td class="blue">
			  <input type="text" name="prepay_money" id="prepay_money" v_must=1 v_name="Ӧ��Ԥ��"  readonly class="InputGrey"  >	
			  	  
             
			  <font class="orange">*</font>
			</td>
          </tr>
          
       
		  <tr> 
            <td height="32"   class="blue">��ע</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text"  readonly class="InputGrey"  id="opNote" size="60" maxlength="60" value="���ſͻ�Ԥ������" > 
            </td>
          </tr>
          <tr> 
            <td colspan="4" id="footer"> <div align="center"> 
                <input name="confirm" type="button" class="b_foot_long"  index="2" value="ȷ��&��ӡ" onClick="printCommit()">
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="���" >
                &nbsp; 
                <input name="back" onClick="window.location='f2294_login.jsp?activePhone=<%=phoneNo%>'" class="b_foot"  type="button"  value="����">
                &nbsp; </div></td>
          </tr>
        </table>
 
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="9" >
    <input type="hidden" name="used_point" value="0" >  
	<input type="hidden" name="point_money" value="0" > 
	<input type="hidden" name="phone_typename" value="" >
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>
