   
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
<%@ page import="java.util.*"%>
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
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String oldaccept=request.getParameter("backaccept");
  String passwordFromSer="";
  String dept=request.getParameter("dept");
 
 
  paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  paraAray1[1] = opcode; 	    /* ��������   */
  paraAray1[2] = loginNo;	    /* ��������   */
  paraAray1[3] = oldaccept;

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

  //retList = impl.callFXService("s2295Init", paraAray1, "30","phone",phoneNo);
  %>
  
     <wtc:service name="s2295Init" outnum="30" retmsg="msg" retcode="code" routerKey="phone" routerValue="<%=phoneNo%>">
			<wtc:param value="<%=paraAray1[0]%>" />
			<wtc:param value="<%=paraAray1[1]%>" />	
			<wtc:param value="<%=paraAray1[2]%>" />	
			<wtc:param value="<%=paraAray1[3]%>" />	
		</wtc:service>
		<wtc:array id="result_t" scope="end"  /> 
  
  <%
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="",
  vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="";
  String zhanbi_name="",product_name="",phone_type="",sale_name="",imei_no="",cash_pay="",prepay_money="";
  String[][] tempArr= new String[][]{};
  String errCode = code;
  String errMsg = msg;
  System.out.println("pppppppppppppppppppppp1111111111111111");
  if(result_t == null)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s8041Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(result_t == null))
  {System.out.println("errCode="+errCode);
  System.out.println("errMsg="+errMsg);
  if(!errCode.equals("000000")){%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("�������<%=errCode%>������Ϣ<%=errMsg%>",0);
  	 history.go(-1);
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
	    sale_name = result_t[0][12];//Ӫ������
	    cash_pay = result_t[0][13];//Ӫ������
	    prepay_money = result_t[0][16];//Ӫ������
	    phone_type = result_t[0][19];//�ֻ�Ʒ��
	    vUnitId = result_t[0][20];//����ID
	    vUnitName = result_t[0][21];//��������
	    vUnitAddr = result_t[0][22];//��λ��ַ
	    vUnitZip = result_t[0][23];//��λ�ʱ�
	    vServiceName = result_t[0][25];//���Ź�������
	    vContactPhone = result_t[0][26];//��ϵ�绰
	    vContactPost = result_t[0][27];//�����ʱ�
	    zhanbi_name = result_t[0][28];//�������
	    product_name = result_t[0][29];//���Ų�Ʒ
	  
	} 
  }

%>
 <%  //�Ż���Ϣ//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//   

   boolean pwrf = false;//a272 ��������֤
   String handFee_Favourable = "readonly";        //a230  ������
   
	  //2011/9/2  diling ��� ������Ȩ������ start
	  	String pubOpCode = opcode;
	  %>
	  	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
	  <%
	  	System.out.println("==�ڶ���======f2295_1.jsp==== pwrf = " + pwrf);
	  //2011/9/2  diling ��� ������Ȩ������ end
	  
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

 
 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>���ſͻ���������</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

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
		
		ret_code =  parseInt(errorCode);
		//alert("111111111111111111111111" +errorCode ); 
		//alert("111111111111111111111111" +errorMsg ); 
		//alert("111111111111111111111111----------"            +   verifyType ); 
		//	alert("111111111111111111111111" +backArrMsg );
		
		if(retType=="getcard"){
			if( ret_code == 0 ){
				  tmpObj = "sale_code" 
				  document.all(tmpObj).options.length=0;
				  document.all(tmpObj).options.length=backArrMsg.length;	
		        for(i=0;i<backArrMsg.length;i++)
			    {
				    document.all(tmpObj).options[i].text=backArrMsg[i][1];
				    document.all(tmpObj).options[i].value=backArrMsg[i][0];
		 	        document.all(tmpObj).options[i].nv2=backArrMsg[i][2];
			        document.all(tmpObj).options[i].nv3=backArrMsg[i][3];
			       
			
			    }
			}else{
				rdShowMessageDialog("ȡ��Ϣ����:"+errorMsg+"!",0);
				return;			
			}
			change();
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
					document.frm.IMEINo.readonly=true;
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
		//var i=price.value;
		//var j=pay_money.value;
		sum_money.value=price.value;
	}
}

 </script>
<script language="JavaScript">

<!--
  //����Ӧ��ȫ�ֵı���
  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�


  


 
<%  
 
%>
 function frmCfm(){
 	frm.submit();
	return true;
  }
 function printCommit()
 { 
  //У��
  //if(!check(frm)) return false;
 
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
   
   var printStr = printInfo(printType);
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =document.frm.login_accept.value                       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                        //�ʷѴ���
     var fav_code=null;                         //�ط�����
     var area_code=null;                        //С������
     var opCode =   "<%=opCode%>";                         //��������
     var phoneNo = "<%=phoneNo%>";                            //�ͻ��绰
	var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
	var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" 
	+$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm +"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;

		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
		
   return ret;    
}

function printInfo(printType)
{
  vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="";
	
  
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
	opr_info+="ҵ�����༯�ſͻ�Ԥ�����������"+"|";
	opr_info+="�ͻ�Ԥ��"+parseInt(document.all.prepay_money.value)+"Ԫ"+"|";
  opr_info+="������Ʒ��"+document.all.gift_name.value+"|";
	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";

		note_info1+="��ע��|";
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
    return retInfo;
}
//-->
</script>
</head>
<body>
<form name="frm" method="post" action="f2295_2.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">���ſͻ���������</div>
	</div>
 
        <table cellspacing="0">
		  <tr> 
            <td class="blue">��������</td>
            <td class="blue">���ſͻ���������--����</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>        
		  <tr> 
            <td class="blue">����ID</td>
            <td>
			  <input name="vUnitId" value="<%=vUnitId%>" type="text"  v_must=1 readonly class="InputGrey" id="vUnitId" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">��������</td>
            <td>
			  <input name="vUnitName" value="<%=vUnitName%>" type="text"  v_must=1 readonly  class="InputGrey" id="vUnitName" maxlength="60" > 
			  <font class="orange">*</font>
            </td>
            </tr>

			
		  
		  
		  <tr> 
            <td class="blue">�ͻ�����</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1 readonly  class="InputGrey" id="cust_name" maxlength="20" v_name="����"> 
			  <font class="orange">*</font>
            </td>
            <td class="blue">�ͻ���ַ</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text"  v_must=1 readonly  class="InputGrey" id="cust_addr" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">֤������</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1 readonly  class="InputGrey" id="cardId_type" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">֤������</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1 readonly  class="InputGrey" id="cardId_no" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">ҵ��Ʒ��</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1 readonly  class="InputGrey" id="sm_code" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">����״̬</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text"  v_must=1 readonly  class="InputGrey" id="run_type" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">VIP����</td>
            <td>
			  <input name="vip" value="<%=vip%>" type="text"  v_must=1 readonly  class="InputGrey" id="vip" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">����Ԥ��</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1 readonly  class="InputGrey" id="prepay_fee" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            
            <tr> 
            <td class="blue">���Ź���</td>
            <td>
			  <input name="group_type" value="<%=zhanbi_name%>" type="text"  v_must=1 readonly  class="InputGrey" id="group_type" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
           <td>&nbsp;</td>
           <td>&nbsp;</td>
            </tr>
			
			
			
			
			<tr> 
            <td class="blue">������Ʒ</td>
            <td>
			<input type="text" readonly  class="InputGrey" name="gift_name"   value="<%=sale_name%>">
			    
			  <font class="orange">*</font>	
			</td>
	 <td class="blue">Ӧ��Ԥ��</td>
            <td>
			  <input type="text" readonly  class="InputGrey" name="prepay_money" id="prepay_money" v_must=1 v_name="Ӧ��Ԥ��"  value="<%=prepay_money%>">	
			  	  
              </select>
			  <font class="orange">*</font>
			</td>
          </tr>
          
         
		 
		  <tr> 
            <td height="32"   class="blue">��ע</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text"   readonly  class="InputGrey" id="opNote" size="60" maxlength="60" value="���ſͻ�Ԥ���������" > 
            </td>
          </tr>
          </table>
          <jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>

          <table>
          <tr> 
            <td colspan="4" id="footer"> <div align="center"> 
                <input name="confirm" type="button" class="b_foot_long" index="2" value="ȷ��&��ӡ" onClick="printCommit()">
                &nbsp; 
                <input name="reset" type="reset"  value="���" class="b_foot">
                &nbsp; 
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
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
	
	<input type="hidden" name="oldaccept" value="<%=oldaccept%>">
	<%@ include file="/npage/include/footer.jsp" %>
	<%@ include file="/npage/public/hwObject.jsp" %> 

</form>
</body>
</html>
