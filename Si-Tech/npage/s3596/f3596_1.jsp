<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-1-13
********************/
%>
<%
//huangrong update for ������ְͨҵ��֧�ŵĺ�  2011-8-1
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
//��ȡSESSION��Ϣ
String phoneNo = (String)request.getParameter("activePhone");
System.out.println("phoneNo="+phoneNo);
String ipAddress = (String)session.getAttribute("ipAddr");
String loginNo = (String)session.getAttribute("workNo");
String workname = (String)session.getAttribute("workName");
String orgCode = (String)session.getAttribute("orgCode");
String loginPwd  = (String)session.getAttribute("password");
String regionCode = (String)session.getAttribute("regCode");

String strDate=new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
%>
<%  
  //��ȡ����ҳ�õ�����Ϣ
	String loginAccept = request.getParameter("login_accept");
	if(loginAccept == null)
	{			
	//��ȡϵͳ��ˮ
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regionCode" routerValue="<%=regionCode%>"  id="req" />
<%		
		loginAccept=req;	
	}
%>
<HTML>
<HEAD>
	<TITLE><%=opName%></TITLE>
	<META content=no-cache http-equiv=Pragma>
  <META content=no-cache http-equiv=Cache-Control>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

<link href="s2002.css" rel="stylesheet" type="text/css">		
	<script type="text/javascript" src="/njs/extend/jquery/portalet/interface_pack.js"></script>
</HEAD>
<SCRIPT type=text/javascript>




//���ù������棬���и����ײ�ѡ��
function getInfo_Mode()
{
	if ( '0' == document.all.bizcode.value  )
	{
		rdShowMessageDialog("����ѡ��ҵ������" , 0);
		return false;
	}
	
	var retToField = "extraOption|mode_name|";
	/* zhangyan */
	if ( document.all.opFlag.value == '05' )
	{
		retToField = "d0_new_ofrId|mode_name|";
	}
	
	else if  ( document.all.opFlag.value == '03' )
	{
		retToField = "d1_new_ofrId|mode_name|";
	}
    var pageTitle = "�����ײ�ѡ��";
    var fieldName = "��Ʒ����|��Ʒ����|";
		var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";

    
   //�ж��Ƿ�ѡ��SIҵ����Ϣ 
	 if(document.frm.bizcode.value == "")
   {
    rdShowMessageDialog("��ѡ��SIҵ����Ϣ��",0);
    return false;
   }
    if(PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "/npage/s3596/fqrymodecode.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;

	if ( document.all.opFlag.value == '03' )
	{
		path = path + "&opCode=i044" ;
	}
	else 
	{
		path = path + "&opCode=3596" ;
	}    
      
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	  path = path + "&regionCode=<%=regionCode%>";
	  path = path + "&selType=" + selType;
	  path = path + "&bizcode=" + document.all.bizcode.value;  	       
    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;
}

function getmebProdCode(retInfo)
{
	var retToField = "extraOption|mode_name|";

	/* zhangyan */
	if ( document.all.opFlag.value == '05' )
	{
		retToField = "d0_new_ofrId|mode_name|";
	}
	else if  ( document.all.opFlag.value == '03' )
	{
		retToField = "d1_new_ofrId|mode_name|";
	}
	
	if(retInfo ==undefined)      
	{
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
	//document.frm.payType1.value=document.frm.payType.value;
	document.frm.modeQuery.disabled=true;
	document.frm.newModeQuery.disabled=true;
	//document.frm.confirm.disabled=false;
}



//���ù������棬����SI��Ϣ��ѯ
function getInfo_Si()
{
	var pageTitle = "SI��Ϣ��ѯ";
	var fieldName = "�ӣɱ���|ҵ�����|ҵ������|ҵ������|���������|";
	var sqlStr = "";
	var selType = "S";    //'S'��ѡ��'M'��ѡ
	var retQuence = "5|0|1|2|3|4|";
	var retToField = "ecsiid|bizcode|bizname|servcode|baseservcodeprop|";
	var ecsiId = document.frm.ecsiId.value;
	
	if(document.frm.ecsiId.value == "")
	{
		rdShowMessageDialog("������ӣɱ�����в�ѯ��",0);
		document.frm.ecsiId.focus();
		return false;
	}

	//if(document.frm.ecsiId.value != "" && forNonNegInt(frm.ecsiId) == false)
	//{
	//	frm.ecsiId.value = "";
	//	rdShowMessageDialog("���������֣�",0);
//	return false;
	//}

	

	PubSimpSelSi(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}

function PubSimpSelSi(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var path = "/npage/s3596/fqrybizcode.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType+"&ecsiId=" + document.all.ecsiId.value;
	
	retInfo = window.open(path,"newwindow","height=450, width=830,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvalueSi(retInfo)
{
	var retToField = "ecsiid|bizcode|bizname|servcode|baseservcodeprop|";
	//ChgCurrStep("custQuery");
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
	  document.all(obj).readOnly=true;
		retToField = retToField.substring(chPos_field + 1);
		retInfo = retInfo.substring(chPos_retInfo + 1);
		chPos_field = retToField.indexOf("|");
	}
	//alert("mebMonthFlag"+document.frm.mebMonthFlag.value);
	//document.frm.mebMonthFlag1.value=document.frm.mebMonthFlag.value;
	//document.frm.ecsiIdQuery.disabled=true;	
	//document.frm.confirm.disabled=false;
	document.frm.baseservcodeprop.disabled=true;
	//tochange();
	//tomaturechange();
}


function printInfo(printType)
{
    var tmpLoc="";
	  var tmpLen="";
    var phoneNo=document.frm.phoneNo.value;
    var tmpstr=phoneNo;
    var j=phoneNo.length;
	  var w=Math.round(j/11);
	  var tmpstraft="";
	  for(i=0;i<w;i++){
      tmpLoc=tmpstr.indexOf("~");
      tmpLen=tmpstr.length;
      if(tmpLoc==-1){
      	tmpstraft=tmpstr;
      }
      else{
      	tmpstraft+=tmpstr.substring(0,tmpLoc-1)+",";
      }
	    tmpstr=tmpstr.substring(tmpLoc+1,tmpLen);
	    if(tmpLoc==-1) break;
	 	}
	 	var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
    cust_info+="�ֻ����룺"+document.frm.phoneNo.value+"|";
    cust_info+="�ͻ�������" +document.frm.custName.value+"|";
    cust_info+="֤�����룺"+document.frm.vIdIccid.value+"|";
    cust_info+="�ͻ���ַ��"+document.frm.vCustAddresee.value+"|";
    opr_info="�û�Ʒ��: "+document.frm.vSmName.value+" ����ҵ��:<%=opName%>--"+document.all.bizcode.options[document.all.bizcode.selectedIndex].text+"ҵ��|";
    opr_info+="������ˮ: "+document.frm.printAccept.value+"|";
    opr_info+="��ע: "+document.frm.systemNote.value+"|";
   
    if("<%=opCode%>"=="3596")
	  {
	  	note_info1="��ע:ÿ��ҵ���ʷ�Ϊ1Ԫ/�£��������ظ�����ͬһҵ�񣬵��ǿ��Ե��Ӷ��������ͬ��ҵ��ҵ���¶���������ȡ������ȡ��Ӧ���á�|";
	  }
	    
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;

    
}


function showPrtdlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
	��var h=210;
	��var w=400;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
    
    // //var printStr = printInfo(printType);
    
     var pType="subprint";             
	   var billType="1";     
	   var sysAccept="<%=loginAccept%>";  
	   //alert(  sysAccept);
	   var printStr = printInfo(printType);            
	   var mode_code=null;              
	   var fav_code=null;                 
	   var area_code=null;            
     var opCode="<%=opCode%>"; 
     var phoneNo=document.frm.phoneNo.value;
     
      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	   path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
 
 
	 return ret;
}




function refMain()
{	
	getAfterPrompt();
	  
	  var nowDate= "<%=strDate%>";
		
		
			if(  document.frm.bizcode.value == "0" )
			{
				rdShowMessageDialog("��ѡ��ҵ����Ϣ!",0);
				document.frm.ecsiId.focus();
				return false;
			}	 
			if(  document.frm.phoneNo.value == "" )
			{
				rdShowMessageDialog("�ֻ����벻��Ϊ��!",0);
				document.frm.phoneNo.focus();
				return false;
			}
			document.frm.phoneNo1.value=document.frm.phoneNo.value;
			//alert(document.frm.phoneNo1.value);
			if(  document.frm.custName.value == "" )
			{
				rdShowMessageDialog("�ͻ����Ʋ���Ϊ��!",0);
				return false;
			}
			if(  document.frm.runState.value == "" )
			{
				rdShowMessageDialog("����״̬����Ϊ��!",0);
				return false;
			}
			if(document.all.opFlag.value=="01")
			{
				 
				// if(  document.frm.explog.value == "" )
				// {
				//	rdShowMessageDialog("�������ڲ���Ϊ��!",0);
				//	document.frm.explog.focus();
				//	return false;
				// }
				// if(parseInt(document.frm.explog.value)<parseInt(nowDate))
				// {
				//	rdShowMessageDialog("�������ڲ���С�ڵ�ǰ���ڣ�");
				//	return;
				// }
			 if(document.frm.extraOption.value=="")
			 {
				rdShowMessageDialog("�����ײͲ���Ϊ��!");
				return;
			 }
			 
		   }	 
			
		

	document.frm.systemNote.value = "����[<%=loginNo%>]"+"����"+document.all.opFlag.options[document.all.opFlag.selectedIndex].text+document.all.bizcode.options[document.all.bizcode.selectedIndex].text;
	
	//alert("www-----------");
	//��ӡ�������ύ��
  var ret = showPrtdlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
  //alert("ddd");
  
  if(typeof(ret)!="undefined")
     {
        if((ret=="confirm"))
        {
          if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
          {
          	document.all.printcount.value="1";
	          frmCfm();
          }
	      }
	      if(ret=="continueSub")
	      {
          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
          {
          	document.all.printcount.value="0";
	          frmCfm();
          }
	      }
   }
   else
   {
       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
       {
       	   document.all.printcount.value="0";
	       frmCfm();
       }
    }
	
	  
	
}

// ����:ȫ��ȡ����
// ����:��ָ�����ı�����ߺ��ұߵĿո�ȫ����ȡ
// ����:�Ѿ���ȡ���ı�
// ����:text ָ�����ı�
function trimAll(text)
{
        return leftTrim(rightTrim(text));//���ҽ�ȡ,�����ȡ,����
}


// ����:���ȡ����
// ����:��ָ�����ı�����ߵĿո�ȫ����ȡ
// ����:�Ѿ���ȡ���ı�
// ����:text ָ�����ı�
function leftTrim(text)
{
        if(text==null || text=="") return text;//���text������,����text
        var leftIndex=0;//��������ǿո��ַ��������±�(�ո��ַ���)
        while(text.substring(leftIndex,leftIndex+1)==" ")//ֱ���ҵ�����ķǿո���ַ�,Ҫô����
                leftIndex++;//���ҷǿո��ַ��������±����
        return text.substring(leftIndex,text.length);//����
}

// ����:�ҽ�ȡ����
// ����:��ָ�����ı����ұߵĿո�ȫ����ȡ
// ����:�Ѿ���ȡ���ı�
// ����:text ָ�����ı�
function rightTrim(text)
{
        if(text==null || text=="") return text;//���text������,����text
        var rightIndex=text.length;//�������ҷǿո��ַ��������±�
        while(text.substring(rightIndex-1,rightIndex)==" ")//ֱ���ҵ����ҵķǿո���ַ�,Ҫô����
                rightIndex--;//���ҷǿո��ַ��������±�ǰ��
        return text.substring(0,rightIndex);//����
} 



function changeOpFlag()
{	
	/*zhangyan ������������ũ����ҵ����ꡢ�������ѡ�ʷѵĺ�*/
	document.all.d0_old_ofrId.value = "";	
	document.all.d0_old_ofrNm.value = "";
	document.all.d1_ofrId.value = "";	
	document.all.d1_ofrNm.value = "";		
	document.all.d2_old_Id.value = "";
	
	document.all.d2_old_nm.value = "";
	document.all.d2_new_id.value =  "";
	document.all.d2_new_nm.value = "";
	document.all.d2_login.value = "";
	document.all.d2_time.value = "";
	
	/*zhangyan ������������ũ����ҵ����ꡢ�������ѡ�ʷѵĺ�*/
	if(document.all.opFlag.value=="02")
	{
		//alert("ww");
	 	row1.style.display="none";
	 	$("#d0").hide();
	 	$("#d1").hide();
	 	$("#d2").hide();	
	}
	else if (document.all.opFlag.value=="01")
	{
		row1.style.display="";
	 	$("#d0").hide();
	 	$("#d1").hide();
	 	$("#d2").hide();		
	}
	else if (document.all.opFlag.value=="05")
	{
		row1.style.display="none";
	 	$("#d0").show(1000);
	 	$("#d1").hide();
	 	$("#d2").hide();		
	}	
	else if (document.all.opFlag.value=="03")
	{
		row1.style.display="none";
	 	$("#d0").hide();
	 	$("#d1").show(1000);
	 	$("#d2").hide();		
	}		
	else if (document.all.opFlag.value=="04")
	{
		row1.style.display="none";
	 	$("#d0").hide();
	 	$("#d1").hide();
	 	$("#d2").show(1000);		
	}		
	
	$("#bizcode").val("0");
	
}

function QryPhoneInfo()
{
	if (!checkElement(document.all.phoneNo))
	{
		document.frm.phoneNo.focus();
		return false;
	}
	
	var checkPwd_Packet = new AJAXPacket("/npage/s3596/getPhoneInfo.jsp","���ڻ�ȡ�û����ϣ����Ժ�......");
	checkPwd_Packet.data.add("retType","QryPhoneInfo");
	checkPwd_Packet.data.add("loginNo","<%=loginNo%>");
	checkPwd_Packet.data.add("phoneNo",document.frm.phoneNo.value);
	checkPwd_Packet.data.add("opCode",document.frm.opCode.value);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;
}


function tochange()
{  
	var bizcodeadd=document.frm.bizcode.value;
	var regionCode=document.frm.vregionCode.value;
	document.frm.extraOption.value="";
	//alert(bizcodeadd);
	
	if(bizcodeadd=="0") return false;  
	
	if(document.frm.vregionCode.value=="")
	{
			rdShowMessageDialog("���Ȳ�ѯ�û�����",1);
			document.frm.bizcode.value="0";
			return false;
	}
	
	//alert(bizcodeadd);   
	//huangrong update for ������ְͨҵ��֧�ŵĺ�  2011-8-1
	var sqlStr = " select a.id_no from dgrpusermsg a,dgrpusermsgadd b,dcustdoc c  , dbvipadm.sCommonCode d where a.id_no=b.id_no and b.field_code='YWDM0' "+
	               " and b.field_value='"+bizcodeadd+"' "+
		             "  and a.region_code='" + regionCode + "' and a.cust_id=c.cust_id and c.id_iccid=d.field_code4 and d.op_code = '<%=opCode%>'  and d.common_code = '1004'  ";
	//alert(sqlStr);
	var myPacket = new AJAXPacket("select_rpcNew.jsp","���ڻ��ҵ����Ϣ�����Ժ�......");
	myPacket.data.add("retType","selectIdNo");
	myPacket.data.add("bizcodeadd",bizcodeadd);
	myPacket.data.add("region_code",regionCode);
	myPacket.data.add("opCode","<%=opCode%>");
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}

/*zhangyan ������������ũ����ҵ����ꡢ�������ѡ�ʷѵĺ�*/
function frmCfm(){
	if ( document.all.opFlag.value == "03" /*������ǩ*/
		|| document.all.opFlag.value == "04" /*����*/
		|| document.all.opFlag.value == "05" /*�ʷѱ��*/ )
	{
		
		var inPrs = new Array();
		var svcName = "";
		/*���ݲ�ͬ���,ƴ�������*/
		if ( document.all.opFlag.value == "03"  )/*������ǩ*/
		{
			if ( document.all.d1_new_ofrId.value == '' )
			{
				rdShowMessageDialog("�¸����ʷѲ���Ϊ��" , 0);
				return false;
			}
			
			inPrs[0] = document.all.loginAccept.value ;
			inPrs[1] = "01";
			inPrs[2] = "i044";
			inPrs[3] = "<%=loginNo%>";
			inPrs[4] = "<%=loginPwd%>";
			
			inPrs[5] = document.all.phoneNo.value ;
			inPrs[6] = "";
			inPrs[7] = document.all.d1_new_ofrId.value ; 
			inPrs[8] = document.all.vidNo.value;
			inPrs[9] = "AD";
			
			inPrs[10] = "<%=regionCode%>";
			inPrs[11] = "<%=ipAddress%>";
			svcName = "s221Cfm" ;
		}
		else if ( document.all.opFlag.value == "04"  )/*����*/
		{	
			if ( document.all.old_acc.value == '' )
			{
				rdShowMessageDialog("������ˮ����Ϊ��" , 0);
				return false;
			}					
			if ( document.all.d2_old_Id.value == '' )
			{
				rdShowMessageDialog("���ǰ��ƷID����Ϊ��" , 0);
				return false;
			}							
			inPrs[0] = document.all.loginAccept.value ;
			inPrs[1] = "01";
			inPrs[2] = "i045";
			inPrs[3] = "<%=loginNo%>";
			inPrs[4] = "<%=loginPwd%>";		
			
			inPrs[5] = document.all.phoneNo.value ;
			inPrs[6] = "" ;
			inPrs[7] = document.all.old_acc.value ;	
			inPrs[8] = "<%=ipAddress%>";
			inPrs[9] = document.all.mebId.value;
			inPrs[10] = document.all.vidNo.value;
			
			svcName = "s222Cfm";	
		}
		else if ( document.all.opFlag.value == "05"  )/*�ʷѱ��*/
		{
			svcName = "s7897Cfm";
			if ( document.all.d0_new_ofrId.value == '' )
			{
				rdShowMessageDialog("�¸����ʷѲ���Ϊ��" , 0);
				return false;
			}				
			inPrs[0] = document.all.loginAccept.value ;
			inPrs[1] = "i043" ;
			inPrs[2] = "<%=loginNo%>" ;
			inPrs[3] = "<%=loginPwd%>" ;
			inPrs[4] = "<%=orgCode%>" ;
			
			inPrs[5] = document.all.systemNote.value ;
			inPrs[6] = document.all.systemNote.value ;
			inPrs[7] = "<%=ipAddress%>";
			inPrs[8] = document.all.phoneNo.value ;
			inPrs[9] = document.all.vidNo.value;
			
			inPrs[10] = "";
			inPrs[11] = document.all.d0_new_ofrId.value;
			inPrs[12] = "0~0~0~0.00~0.00~0~0~";
			inPrs[13] = "";
			inPrs[14] = "m03";
			
			inPrs[15] = "05";
		}		

		/* zhangyan: ���ڷ���ĳλ�������������,������.
		 * ����ajaxҳ�����:
		 * ajaxType : ��������
		 * svcName : ������,�ַ���
		 * inPrs : �������,����
		 * ajaxҳ�淵��
		 * oRetCode : ���ش���
		 * oRetMsg : ������Ϣ
		 */
		var packet = new AJAXPacket("f3596_chgCfm.jsp","���ڻ�ȡ�û����ϣ����Ժ�......");
		packet.data.add("ajaxType","getCfmIfo");
		packet.data.add("svcName",svcName);
		packet.data.add("inPrs",inPrs);
		core.ajax.sendPacket( packet , setCfmIfo);
		checkPwd_Packet = null;
	}
	else 
	{
		frm.action="f3596Cfm.jsp";
		frm.method="post";
		frm.submit();
		$("#confirm").attr("disabled",true);
		loading();
	}
	return true;
}

function setCfmIfo( packet )
{
	var oRetCode = packet.data.findValueByName ( "oRetCode" );
	var oRetMsg = packet.data.findValueByName ( "oRetMsg" );
	
	if (oRetCode != '000000')
	{
		rdShowMessageDialog(oRetCode+":"+oRetMsg , 0);
	}
	else
	{
		rdShowMessageDialog( oRetMsg , 2 );

	}
	
	
	window.location.replace("f3596_1.jsp?activePhone=<%=phoneNo%>&activePhone=<%=phoneNo%>"
		+"&opCode=<%=opCode%>&opName=<%=opName%>");
}


function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMessage = packet.data.findValueByName("retMessage");
	//alert(retMessage);
	self.status="";
	if(retType == "QryPhoneInfo")
	{
		if(retCode == "000000")
		{
			var custName = packet.data.findValueByName("custName");
			var runState= packet.data.findValueByName("runState");
			var vregionCode=packet.data.findValueByName("vregionCode");
			var vCustAddresee=packet.data.findValueByName("vCustAddresee");
			var vIdIccid=packet.data.findValueByName("vIdIccid");
			var vSmName=packet.data.findValueByName("vSmName");
			document.frm.custName.value=custName;
			document.frm.runState.value=runState;
			document.frm.vregionCode.value=vregionCode;
			document.frm.vCustAddresee.value=vCustAddresee;
			document.frm.vIdIccid.value=vIdIccid;
			document.frm.vSmName.value=vSmName;
			if(document.frm.opFlag.value=="02")
			{
				//document.frm.confirm.disabled=false;
			}
			
			//alert(document.frm.vregionCode.value);
			
		}
		else
		{
			rdShowMessageDialog(retMessage,1);
			return false;
		}
		
		
	}
	if(retType == "selectIdNo")
	{
		var retResult=packet.data.findValueByName("retResult");
		if(retCode == "000000"&&retResult=="true")
		{
			var vidNo = packet.data.findValueByName("vidNo");
			
			document.frm.vidNo.value=vidNo;
			document.frm.modeQuery.disabled = false;
			document.frm.newModeQuery.disabled = false;
			//alert(document.frm.vidNo.value);
			
			//�������Ϣ
			if ( document.all.opFlag.value == '02' 
				|| document.all.opFlag.value == '03' 
				|| document.all.opFlag.value == '05' )
			{
				var myPacket = new AJAXPacket("f3596_ajax.jsp","���ڻ��ҵ����Ϣ�����Ժ�......");
	
				myPacket.data.add("ajaxType","getIfo");
				myPacket.data.add("logacc",document.all.loginAccept.value);
				myPacket.data.add("chnSrc","01");
				myPacket.data.add("opCode","<%=opCode%>");
				myPacket.data.add("workNo","<%=loginNo%>");
				myPacket.data.add("passwd","<%=loginPwd%>");
				
				myPacket.data.add("phoneNo","<%=phoneNo%>");
				myPacket.data.add("usrpwd","");
				myPacket.data.add("iGrpId",vidNo);
				myPacket.data.add("iOpType",document.all.opFlag.value);
				
				core.ajax.sendPacket(myPacket , setIfo);
				myPacket=null;				
			}

			
		}
		else
		{
			rdShowMessageDialog("ҵ������û����������������ϵҵ�����ˣ�",0);
			return false;
		}
	}
	
	
	
}

function setIfo( packet )
{
	var oRetCode = packet.data.findValueByName("oRetCode");
	var oRetMsg = packet.data.findValueByName("oRetMsg");
	if ( oRetCode!="000000" )
	{
		rdShowMessageDialog( oRetCode+":"+oRetMsg ,0 );
		return false;
	}
	else
	{	
		if ( document.all.opFlag.value=="02" )
		{
			var oYearFlag = packet.data.findValueByName("oYearFlag");
			if ( 'Y' == oYearFlag )
			{
				rdShowMessageDialog("���û������ʷ�δ���ڣ���ǰ�������۳�ȫ��ʣ��ר����ΪΥԼ�𣬼��������밴ȷ�ϼ���");
				return false;
			}
		}
		else if (document.all.opFlag.value=="05")
		{
			document.all.d0_old_ofrId.value = packet.data.findValueByName( "oOldOfferId" );	
			document.all.d0_old_ofrNm.value = packet.data.findValueByName( "oOldOfferName" );
		}	
		else if (document.all.opFlag.value=="03")
		{
			document.all.d1_ofrId.value = packet.data.findValueByName( "oOldYearId" );	
			document.all.d1_ofrNm.value = packet.data.findValueByName( "oOldYearName" );		
		}		
		else if (document.all.opFlag.value=="04")
		{
			row1.style.display="none";
		 	$("#d0").hide();
		 	$("#d1").hide();
		 	$("#d2").show(1000);		
		}
	}
	
}

function clearWindow()
{
	location.reload();//huangrong add ˢ��ҳ�� 2011-8-9 
	//document.frm.reset();
	//document.frm.ecsiIdQuery.disabled=false;
	//document.frm.modeQuery.disabled=false;
	
}



var _jspPage =
{"div1_switch":["mydiv1","f3596_list.jsp?opCode=<%=opCode%>","f"]

};
$("#divold").hide() ;
function hiddenSpider()
{
	document.getElementById("mydiv1").style.display='none';
  
}

$(document).ready(function () {
	//���ؽ�����
	hiddenSpider();
	$('img.closeEl').bind('click', toggleContent); 	
  	$("div.itemContent").slideUp(30);
	$("img.closeEl").attr({ src: "../../../nresources/default/images/jia.gif"});
 

  }
);

var toggleContent = function(e)
{
	var targetContent = $( 'DIV.itemContent',this.parentNode.parentNode.parentNode);
	if (targetContent.css('display') == 'none') {	  
		   targetContent.slideDown(300);
		   $(this).attr({ src: "../../../nresources/default/images/jian.gif"});
		   //���÷���
		   try{
		   	var tmp = $(this).attr('id');
		   	var tmp2 = eval("_jspPage."+tmp);
		   	if(tmp2[2]=="f"&&tmp2[1]!=''&&tmp2[1]!=undefined)
		   	{
		   		$("#"+tmp2[0]).load(tmp2[1],{sPhoneNo:$("#phoneNo").val()
		   			                          
		   			                          });
		   		//tmp2[2]="t";
		   	}
		   }catch(e)
		   {		   	
		   }

	} else {
		targetContent.slideUp(300);
		$(this).attr({ src: "../../../nresources/default/images/jia.gif"});
	}
	return false;
};

function getOldIfo()
{	
	if ( '0' == document.all.bizcode.value  )
	{
		rdShowMessageDialog("����ѡ��ҵ������" , 0);
		return false;
	}
	
	var myPacket = new AJAXPacket("f3596_ajax.jsp","���ڻ��ҵ����Ϣ�����Ժ�......");

	myPacket.data.add("ajaxType","getOldIfo");
	myPacket.data.add("logacc",document.all.loginAccept.value);
	myPacket.data.add("chnSrc","01");
	myPacket.data.add("opCode","<%=opCode%>");
	myPacket.data.add("workNo","<%=loginNo%>");
	myPacket.data.add("passwd","<%=loginPwd%>");
	
	myPacket.data.add("phoneNo","<%=phoneNo%>");
	myPacket.data.add("usrpwd","");
	myPacket.data.add("oldAcc" , document.all.old_acc.value);
	myPacket.data.add("vidNo" , document.all.vidNo.value);
	
	core.ajax.sendPacket(myPacket , setOldIfo);
	myPacket=null;	
}

function setOldIfo( packet )
{	
	var oRetCode = packet.data.findValueByName("oRetCode");
	var oRetMsg = packet.data.findValueByName("oRetMsg");
	if ( oRetCode!="000000" )
	{
		rdShowMessageDialog( oRetCode+":"+oRetMsg ,0 );
		return false;
	}
	else
	{
		document.all.d2_old_Id.value = packet.data.findValueByName("oOldOfferID");
		document.all.d2_old_nm.value = packet.data.findValueByName("oOldOfferName");
		document.all.d2_new_id.value = packet.data.findValueByName("oNewOfferID");
		document.all.d2_new_nm.value = packet.data.findValueByName("oNewOfferName");
		document.all.d2_login.value = packet.data.findValueByName("oLoginNo");
		document.all.d2_time.value = packet.data.findValueByName("oOpTime");
		document.all.mebId.value = packet.data.findValueByName("oMebId");

		document.all.old_acc.disabled = true;		
	}
}




</script>
<BODY>
	<FORM action="" method="post" name="frm" >
			<%@ include file="/npage/include/header.jsp" %>  
		<input type="hidden" name="loginAccept"  value="<%=loginAccept%>"> <!-- ������ˮ�� -->
		<input type="hidden" name="loginNo"  value="<%=loginNo%>">
		<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">
		<input type="hidden" name="opCode"  value="<%=opCode%>">	<!--huangrong update for ������ְͨҵ��֧�ŵĺ�  2011-8-1 -->
		<input type="hidden" name="opName"  value="<%=opName%>">	<!-- huangrong add for ������ְͨҵ��֧�ŵĺ�  2011-8-1 -->
	  <input type="hidden" name="regionCode"  value="<%=regionCode%>">
		<input type="hidden" name="orgCode"  value="<%=orgCode%>">
		<input type="hidden" name="ipAddress"  value="<%=ipAddress%>">
	  <input type="hidden" name="bizname"  value="">
	  <input type="hidden" name="mode_name"  value="">
	  <input type="hidden" name="servcode1"  value="">
	  <input type="hidden" name="phoneNo1"  value="">
	  <input type="hidden" name="vregionCode"  value="">
	  <input type="hidden" name="vidNo"  value="">
	  <input type="hidden" name="vCustAddresee"  value="">
	  <input type="hidden" name="vIdIccid"  value="">
	  <input type="hidden" name="mebId"  value="">
	  <input type="hidden" name="vSmName"  value="">
	  <input type="hidden" name="printcount">
	  <input name="printAccept" type="hidden" value="<%=loginAccept%>">
	  
	 <div class="title">
		 <div id="title_zi"><%=opName%></div>
	  </div>

	<TABLE  cellSpacing=0>
		<TR>
			<td class="blue" WIDTH = '25%'>�ֻ�����</TD>
			<TD colspan="3">
			<input class="InputGrey"  type="text" id="phoneNo" value="<%=phoneNo%>" maxlength=11 v_must="1" v_type="mobphone2"  readOnly >
			<input class="b_text" type="button" name="query" value="��ѯ"  onClick="QryPhoneInfo()" >   
			</TD>
		  </tr>
		<TR>
		<TR >
			<td class="blue" WIDTH = '25%' >�ͻ�����</TD>
			<TD >
			<input class="InputGrey"  type="text" name="custName" value="" maxlength=20 v_must="1" v_type="string"  readOnly>
			</TD>
			<td class="blue" WIDTH = '25%' >����״̬</TD>
			<TD >
			<input class="InputGrey"  type="text" name="runState" value="" maxlength=11 v_must="1" v_type="string"  readOnly>
			</TD>
		  </tr>				  
		<TR>
			<td class="blue">
				��������
			</TD>
			<TD class="blue">
				<SELECT name="opFlag"  id="opFlag" onChange="changeOpFlag()">
					<wtc:qoption name="sPubSelect" outnum="2">
						<wtc:sql>
						  SELECT FIELD_CODE3, FIELD_CODE3||'-->'|| FIELD_CODE4
						    FROM DBVIPADM.SCOMMONCODE
						   WHERE COMMON_CODE IN ('1012', '1013', '1014', '1015', '1016')
						     AND OP_CODE = '<%=opCode%>' order by FIELD_CODE3 asc
						</wtc:sql>
					</wtc:qoption>
				</SELECT>
				<font class="orange">*</font>
			</TD>
			<TD class="blue">
			ҵ������
			</TD>
			<TD>
				<select name="bizcode" id = 'bizcode' v_must="1" onChange="tochange()" >
			  <option value="0" >��ѡ��</option>  <!--huangrong update for ������ְͨҵ��֧�ŵĺ�  2011-8-1-->
		<wtc:qoption name="sPubSelect" outnum="2">
				<wtc:sql>
					select a.bizcodeadd,a.product_note from sbillspcode a ,dbvipadm.scommoncode b 
				where a.enterprice_code=rpad(trim(b.field_code1),20) AND b.common_code = '1004'
				AND a.srv_code =b.field_code2 and b.op_code = '<%=opCode%>'
				</wtc:sql>
				</wtc:qoption>
		</select>
			   <!--<input name="bizcode" class="InputGrey" id="bizcode" size="24" maxlength="18" v_type="string"v_must=1v_name="ҵ�����" index="1" value="">-->
				<font class="orange">*</font>
			</TD>
		</TR>
		
		<!--<TR>
			<td class="blue">
			ҵ������
			</TD>
			<TD>
				<input name="servcode" class="InputGrey" id="servcode" size="24" maxlength="10" v_type="0_9" v_must=1 v_name="ҵ������" index="3" value="">
				<font class="orange">*</font>
			</TD>
			<td class="blue">ҵ����������</TD>
			<TD>
				<SELECT name="baseservcodeprop"  id="baseservcodeprop"  onclick="">
					<option value="01" >����</option>
					<option value="02" >���� </option>
				</SELECT>
				<font class="orange">*</font>
			</TD>
		</TR>		-->						
		
		  	<TR id="row1">
		
			<TD class="blue" >
			  �����ײ�
			</TD>
			<TD colspan="3">    
				<input name="extraOption"  id="extraOption" size="24" maxlength="18" v_type="string"  v_name="�����ײ�" index="1" value="" readonly >
				<input name=modeQuery type=button id="modeQuery" class="b_text" onClick="getInfo_Mode();" onClick="if(event.keyCode==13)getInfo_Mode();" style="cursorhand" value=ѡ�� disabled>
			</TD>
		</TR>
	</table>
	
	<DIV ID = "d0" NAME = "d0" STYLE = "display:none" ch_name = '�ʷѱ��' >
		<TABLE>
			<TR>
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >���ǰ�ʷѴ���:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'd0_old_ofrId' NAME= 'd0_old_ofrId' ch_name = '���ǰ�ʷѴ���' MAXLENGTH = '15' 
					value = '' class = 'InputGrey' readOnly />    
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >���ǰ�ʷ�����:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'TEXT' ID = 'd0_old_ofrNm' NAME= 'd0_old_ofrNm' ch_name = '���ǰ�ʷ�����' MAXLENGTH = '15' 
						VALUE = '' class = 'InputGrey' readOnly />    
				</TD>    
			</TR>  
			<TR>
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >�¸����ʷ�:</TD>
				<TD colspan = '3'>
					<INPUT TYPE = 'text' ID = 'd0_new_ofrId' NAME= 'd0_new_ofrId' ch_name = '�¸����ʷ�' MAXLENGTH = '15' 
					value = '' class = 'InputGrey' readOnly />  
				<input name=newModeQuery type=button id="newModeQuery" class="b_text" 
					onClick="getInfo_Mode();" 
					onClick="if(event.keyCode==13)getInfo_Mode();" style="cursorhand" value=ѡ��>					  
				</TD>    
			</TR>   			   
		</TABLE>
	</DIV>	
	
	<DIV ID = "d1" NAME = "d1" STYLE = "display:none" ch_name = '��ǩ' >
		<TABLE>
			<TR>
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >��Ա�ʷѴ���:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'd1_ofrId' NAME= 'd1_ofrId' ch_name = '��Ա�ʷѴ���' MAXLENGTH = '15' 
					value = '' class = 'InputGrey' readOnly />    
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >��Ա�ʷ�����:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'TEXT' ID = 'd1_ofrNm' NAME= 'd1_ofrNm' ch_name = '��Ա�ʷ�����' MAXLENGTH = '15' 
						VALUE = '' class = 'InputGrey' readOnly />    
				</TD>    
			</TR>  
			<TR>
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >�¸����ʷ�:</TD>
				<TD colspan = '3'>
					<INPUT TYPE = 'text' ID = 'd1_new_ofrId' NAME= 'd1_new_ofrId' ch_name = '�¸����ʷ�' MAXLENGTH = '15' 
					value = '' class = 'InputGrey' readOnly />  
				<input name=newModeQuery03 type=button id="newModeQuery03" class="b_text" 
					onClick="getInfo_Mode();" 
					onClick="if(event.keyCode==13)getInfo_Mode();" style="cursorhand" value=ѡ��>					  
				</TD>    
			</TR> 			
		</TABLE>
	</DIV>		
	
	<DIV ID = "d2" NAME = "d2" STYLE = "display:none" ch_name = '��ǩ����' >
		<TABLE>
			<TR>
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >������ˮ:</TD>
				<TD WIDTH = '25%' colspan = '3' >
					<INPUT TYPE = 'text' ID = 'old_acc' NAME= 'old_acc' ch_name = '������ˮ' MAXLENGTH = '15' 
					value = '' />
					<input type = 'button' id = '' name = '' value = '��ѯ' class = 'b_text' onclick = 'getOldIfo()' >    
				</TD>      
			</TR> 			
			<TR>
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >���ǰ�Ĳ�ƷID:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'd2_old_Id' NAME= 'd2_old_Id' ch_name = '���ǰ�Ĳ�ƷID' MAXLENGTH = '15' 
					value = '' class = 'InputGrey' readOnly />    
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >���ǰ�Ĳ�Ʒ����:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'TEXT' ID = 'd2_old_nm' NAME= 'd2_old_nm' ch_name = '���ǰ�Ĳ�Ʒ����' MAXLENGTH = '15' 
						VALUE = '' class = 'InputGrey' readOnly />    
				</TD>    
			</TR>  
			<TR>
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >�����Ĳ�ƷID:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'd2_new_id' NAME= 'd2_new_id' ch_name = '�����Ĳ�ƷID' MAXLENGTH = '15' 
					value = '' class = 'InputGrey' readOnly />    
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >�����Ĳ�Ʒ����:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'TEXT' ID = 'd2_new_nm' NAME= 'd2_new_nm' ch_name = '�����Ĳ�Ʒ����' MAXLENGTH = '15' 
						VALUE = '' class = 'InputGrey' readOnly />    
				</TD>   
			</TR>  
			<TR> 				
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >ӪҵԱ:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'd2_login' NAME= 'd2_login' ch_name = 'ӪҵԱ' MAXLENGTH = '15' 
					value = '' class = 'InputGrey' readOnly />    
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >����ʱ��:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'TEXT' ID = 'd2_time' NAME= 'd2_time' ch_name = '����ʱ��' MAXLENGTH = '15' 
						VALUE = '' class = 'InputGrey' readOnly />    
				</TD>    				
			</TR>  
		</TABLE>
	</DIV>		
		
	<table   cellSpacing=0>
		<TR>
			<td class="blue"  WIDTH = '25%'>ϵͳ��ע</TD> 
			<TD>
				<input  name="systemNote" size="60" value="" class="InputGrey">
			</TD>
		</TR>
	</TABLE>
						

<DIV id="div1_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div1_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">ҵ�񶩹��б�</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv1">
	 	  <DIV id="wait1"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>						

				<table id="tc" cellSpacing=0>
							<TR>
								<TD align=center id="footer" colspan=4>
									<input class="b_foot" name="confirm" id="confirm" type=button value="ȷ��" onclick="refMain()">
									<input class="b_foot" name="clear"  onClick="clearWindow()" type=button value="���" >
									<input class="b_foot" name="colse"  onClick="removeCurrentTab()" type=button value="�ر�" >
								</TD>
							</TR>
							
						</TABLE>
	
    <%@include file="/npage/include/footer.jsp" %>
	</FORM>
</BODY>
</HTML>
