
<%
/********************
 version v2.0
������: si-tech
update:anln@2009-02-16 ҳ�����,�޸���ʽ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
   
	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");	
	String phoneNo = (String)request.getParameter("activePhone");	
%>

<%        
	
		//ArrayList retArray = new ArrayList();
        	String[][] result = new String[][]{};
 		//S1100View callView = new S1100View();   
		String smCode = "";
		String arrContent = "";
		
		String note = "";
		String cardNo = "";
		String yuan = "";
		String personalLike = "";
		String email = "";
		String phoneType = "";
		String fPostalcode = "";
		String familyAddr = "";
		String uPostalcode = "";
		String unitAddr = "";
		String contactPhone = "";
		String businessType = "";
		String businessTypeName="";
		String occupation = "";
		String occupationName="";
		String IDNo = "";
		String registerTime = "";
		String custName = "";
		String vipNo = "";
		String readOnlyAll="";
		//String opeType="";
		
		
%>
<%
		//ArrayList arr = (ArrayList)session.getAttribute("allArr");
		
		String workNo = (String)session.getAttribute("workNo");
		String Department = (String)session.getAttribute("orgCode");		
		String regionCode = (String)session.getAttribute("regCode");
		String belongCode = Department.substring(0,7);
        	String rowNum = "16";
        	String sys_Date = "";
		/****�õ���ӡ��ˮ****/
  		String printAccept="";
  		printAccept = getMaxAccept();
%>


<HTML>
	<HEAD><TITLE>Vip������</TITLE>
<SCRIPT type=text/javascript>

onload=function()
{

}
//---------1------RPC������------------------
function doProcess(packet)
{	
    	//RPC������findValueByName
	var retType = packet.data.findValueByName("retType");
    	var retCode = packet.data.findValueByName("retCode"); 
   	 var retMessage = packet.data.findValueByName("retMessage");	
    self.status="";
	if(retCode.trim()=="")
	{
       rdShowMessageDialog("����"+retType+"����ʱʧ�ܣ�");
       return false;
	}
	if(retType == "query")
	{
	    if(retCode == "000000")
	    {
			frm1249.smCode.value = packet.data.findValueByName("smCode");
			frm1249.note.value = packet.data.findValueByName("note");
			frm1249.cardNo.value = packet.data.findValueByName("cardNo");
			frm1249.yuan.value = packet.data.findValueByName("yuan");
			var cluster;
			cluster= packet.data.findValueByName("arrContent");
			//frm1249.sex.value=cluster.substr(0,1);
			for(i=0; i<document.frm1249.sex.length; i++)
			{
			 	if(document.frm1249.sex.options[i].value==cluster.substr(0,1))
				{
					document.frm1249.sex.options.selectedIndex = i;
			 	}
			 }
			//frm1249.monthSal.value=cluster.substr(1,1);
			for(i=0; i<document.frm1249.monthSal.length; i++)
			{
			 	if(document.frm1249.monthSal.options[i].value==cluster.substr(1,1))
				{
					document.frm1249.monthSal.options.selectedIndex = i;
			 	}
			 }
			//frm1249.smType.value=cluster.substr(2,1);
			for(i=0; i<document.frm1249.smType.length; i++)
			{
			 	if(document.frm1249.smType.options[i].value==cluster.substr(2,1))
				{
					document.frm1249.smType.options.selectedIndex = i;
			 	}
			 }
			//frm1249.phonePayType.value=cluster.substr(3,1);
			for(i=0; i<document.frm1249.phonePayType.length; i++)
			{
			 	if(document.frm1249.phonePayType.options[i].value==cluster.substr(3,1))
				{
					document.frm1249.phonePayType.options.selectedIndex = i;
			 	}
			 }
			//frm1249.sendBill.value=cluster.substr(4,1);
			for(i=0; i<document.frm1249.sendBill.length; i++)
			{
			 	if(document.frm1249.sendBill.options[i].value==cluster.substr(4,1))
				{
					document.frm1249.sendBill.options.selectedIndex = i;
			 	}
			 }
			//frm1249.favourPro.value=cluster.substr(5,1);
			for(i=0; i<document.frm1249.favourPro.length; i++)
			{
			 	if(document.frm1249.favourPro.options[i].value==cluster.substr(5,1))
				{
					document.frm1249.favourPro.options.selectedIndex = i;
			 	}
			 }
			//frm1249.fetchType.value=cluster.substr(6,1);
			for(i=0; i<document.frm1249.fetchType.length; i++)
			{
			 	if(document.frm1249.fetchType.options[i].value==cluster.substr(6,1))
				{
					document.frm1249.fetchType.options.selectedIndex = i;
			 	}
			 }
			//frm1249.changeSTK.value=cluster.substr(7,1);
			for(i=0; i<document.frm1249.changeSTK.length; i++)
			{
			 	if(document.frm1249.changeSTK.options[i].value==cluster.substr(7,1))
				{
					document.frm1249.changeSTK.options.selectedIndex = i;
			 	}
			 }
			//frm1249.giveTJK.value=cluster.substr(8,1);
			for(i=0; i<document.frm1249.giveTJK.length; i++)
			{
			 	if(document.frm1249.giveTJK.options[i].value==cluster.substr(8,1))
				{
					document.frm1249.giveTJK.options.selectedIndex = i;
			 	}
			 }
			
			frm1249.personalLike.value = packet.data.findValueByName("personalLike");
			frm1249.email.value = packet.data.findValueByName("email");
			frm1249.phoneType.value = packet.data.findValueByName("phoneType");
			frm1249.fPostalcode.value = packet.data.findValueByName("fPostalcode");
			frm1249.familyAddr.value = packet.data.findValueByName("familyAddr");
			frm1249.uPostalcode.value = packet.data.findValueByName("uPostalcode");
			frm1249.unitAddr.value = packet.data.findValueByName("unitAddr");
			frm1249.contactPhone.value = packet.data.findValueByName("contactPhone");
			for(i=0; i<document.frm1249.businessType.length; i++)
			{
			 	if(document.frm1249.businessType.options[i].value==packet.data.findValueByName("businessType"))
				{
					document.frm1249.businessType.options.selectedIndex = i;
			 	}
			 }
			 for(i=0; i<document.frm1249.occupation.length; i++)
			 {
			 	if(document.frm1249.occupation.options[i].value==packet.data.findValueByName("occupation"))
				{
					document.frm1249.occupation.options.selectedIndex = i;
			 	}
			 }
			//frm1249.occupation1.value = packet.data.findValueByName("occupation");
			//frm1249.occupationName.value = packet.data.findValueByName("occupationName");
			frm1249.IDNo.value = packet.data.findValueByName("IDNo");
			frm1249.registerTime.value = packet.data.findValueByName("registerTime");
			frm1249.custName.value = packet.data.findValueByName("custName");
			frm1249.vipNo.value = packet.data.findValueByName("vipNo");
	    }	        
	    else
	    {
	       	rdShowMessageDialog("�����ֻ��Ż�û��VIP��Ϣ�����������룡",0);
            //history.go(-1);
			return false;
	    }
	}
	if(retType == "queryRegister")
	{
	    if(retCode == "000000")
	    {
			frm1249.smCode.value = packet.data.findValueByName("smCode");
		}else{
	        retMessage = retMessage + "[errorCode2:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);
			return false;
	    }
	}
  	//------------------------------------
	if(retType=="chkX")
	{
        var retObj = packet.data.findValueByName("retObj");

		if(retCode == "000000")
        {
          document.all.print.disabled=false;
		}
        else
        {
             retMessage = "����" + retCode + "��"+retMessage;			 
             rdShowMessageDialog(retMessage,0);
			 document.all.print.disabled=true;
			 document.all(retObj).focus();
			 return false;
        }
	}
}
//-----------------------------------------------------
/*
    ����1(pageTitle)����ѯҳ�����
    ����2(fieldName)�����������ƣ���'|'�ָ��Ĵ�
    ����3(sqlStr)��sql���
    ����4(selType)������1 rediobutton 2 checkbox
    ����5(retQuence)����������Ϣ������������� �������ʶ����'|'�ָ�����"3|0|2|3"��ʾ����3����0��2��3
    ����6(retToField))������ֵ����������,��'|'�ָ�
*/

//-------------------------------------------------

//-------------------------------------------------
function checkOne()
{
    if(!checkElement(document.frm1249.phoneNo)) return false;
	if(!checkElement(document.frm1249.IDNo)) return false;
	if(!checkElement(document.frm1249.contactPhone)) return false;
    if(!checkElement(document.frm1249.uPostalcode)) return false;
	if(!checkElement(document.frm1249.fPostalcode)) return false;
	if(!checkElement(document.frm1249.yuan)) return false;
    with(document.frm1249)
	{
	  if(vipNo.value=="")
	  {
	    rdShowMessageDialog("������VIP����ţ�");
        return false;
	  }
	  if(custName.value=="")
	  {
	    rdShowMessageDialog("������ͻ�������");
        return false;
	  }
	  if(unitAddr.value=="")
	  {
	    rdShowMessageDialog("�����뵥λ��ַ��");
        return false;
	  }
	  if(familyAddr.value=="")
	  {
	    rdShowMessageDialog("�������ͥ��ַ��");
        return false;
	  }
	  if(phoneType.value=="")
	  {
	    rdShowMessageDialog("�������ֻ��ͺţ�");
        return false;
	  }
	}
	return true;
}
function printCommit()
{   
	getAfterPrompt();
	if(document.frm1249.note.value=="")
	{
		var note = "�ͻ�:" + document.frm1249.custName.value +"�ֻ�����:" + document.frm1249.phoneNo.value;
    	document.frm1249.note.value = note;
	}

	if(document.frm1249.opeType.value!=2)
	{
		if(document.frm1249.cardNo.value=="")
		{
			document.frm1249.cardNo.value="stkcard";
		}
		if(checkOne())
		{
    		if(document.frm1249.opeType.value==0)
			{
				queryRegister();
			}
		
    		showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");    	    
    	}    
	}else if(rdShowConfirmDialog("ȷ��Ҫɾ��Vip��������Ϣ��")==1)
	{
		   	var sexSign;
			var fetchTypeSign;
			var changeSTKSign;
			var giveTJKSign;
		   	if(document.frm1249.sex.value=="��"){sexSign=0;}else{sexSign=1;}
		   	if(document.frm1249.fetchType.value=="��ͻ������Ϳ�"){fetchTypeSign=0;}else if(document.frm1249.fetchType.value=="������λ"){fetchTypeSign=1;}else{fetchTypeSign=2;}
			if(document.frm1249.changeSTK.value=="��"){changeSTKSign=1;}else{changeSTKSign=0;}
			if(document.frm1249.giveTJK.value=="��"){giveTJKSign=1;}else{giveTJKSign=0;}
		   	document.frm1249.arrContent.value=sexSign+document.frm1249.monthSal.value
			+document.frm1249.smType.value+document.frm1249.phonePayType.value+document.frm1249.sendBill.value
			+document.frm1249.favourPro.value+fetchTypeSign+changeSTKSign+giveTJKSign;
		    frm1249.action="f1249_2.jsp";
		    frm1249.submit();
	}
}
//---------------------------------------------------
function jspReset()
{
        var obj = null;
        var t = null;
    	var i;   	
        for (i=0;i<document.frm1249.length;i++)
        {    
    		obj = document.frm1249.elements[i];		 		 		 
    		packUp(obj); 
    	    obj.disabled = false;
         }        
        document.frm1249.commit.disabled = "none"; 
}
//---------------------------------------------------
function printInfo(printType)
{
	
	var cust_info=""; //�ͻ���Ϣ
	var opr_info=""; //������Ϣ
	var retInfo = "";  //��ӡ����
	var note_info1=""; //��ע1
	var note_info2=""; //��ע2
	var note_info3=""; //��ע3
	var note_info4=""; //��ע4 
	
	cust_info+="�ͻ�������"+document.frm1249.custName.value+"|";
	cust_info+="�ֻ����룺"+document.frm1249.phoneNo.value+"|";	
	cust_info+="֤�����룺"+document.frm1249.IDNo.value+"|";
	
	opr_info+="ҵ�����ͣ�VIP������"+"|";
	opr_info+="VIP���ţ�"+document.frm1249.vipNo.value+"|";
	opr_info+="��ˮ��"+"<%=printAccept%>"+"|";
	
	note_info1+="��ע��"+"|";
	
	retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
	return retInfo;	
	
}
//-----------------------------------------------------
function showPrtDlg(printType,DlgMessage,submitCfm)
{  	
	//��ʾ��ӡ�Ի��� 		
	var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
	var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
	var sysAccept ="<%=printAccept%>";                       // ��ˮ��
	var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
	var mode_code=null;                        //�ʷѴ���
	var fav_code=null;                         //�ط�����
	var area_code=null;                    //С������
	var opCode =   "<%=opCode%>";                         //��������
	var phoneNo = <%=activePhone%>;                           //�ͻ��绰		
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop); 
	  
    //if(typeof(ret)!="undefined")
   {
       //if((ret=="confirm")&&(submitCfm == "Yes"))
       {
	       if(rdShowConfirmDialog("ȷ��Ҫ�ύVip��������Ϣ��")==1)
	       {
		   	
		   	var sexSign;
			var fetchTypeSign;
			var changeSTKSign;
			var giveTJKSign;
		   	if(document.frm1249.sex.value=="��"){sexSign=0;}else{sexSign=1;}
		   	if(document.frm1249.fetchType.value=="��ͻ������Ϳ�"){fetchTypeSign=0;}else if(document.frm1249.fetchType.value=="������λ"){fetchTypeSign=1;}else{fetchTypeSign=2;}
			if(document.frm1249.changeSTK.value=="��"){changeSTKSign=1;}else{changeSTKSign=0;}
			if(document.frm1249.giveTJK.value=="��"){giveTJKSign=1;}else{giveTJKSign=0;}
		   	document.frm1249.arrContent.value=sexSign+document.frm1249.monthSal.value
			+document.frm1249.smType.value+document.frm1249.phonePayType.value+document.frm1249.sendBill.value
			+document.frm1249.favourPro.value+fetchTypeSign+changeSTKSign+giveTJKSign;
		       frm1249.action="f1249_2.jsp";
		       frm1249.submit();
		   }
		}		        
   }
}


function query()
{
	if(document.frm1249.phoneNo.value!="")
	{
		if(document.frm1249.opeType.value==1)
		{
			var opFlag = "1";
		}
		if(document.frm1249.opeType.value==2)
		{
			var opFlag = "2";
		}
		if(document.frm1249.opeType.value==3)
		{
			var opFlag = "3";
		}
		if(document.frm1249.opeType.value==2 || document.frm1249.opeType.value==3)
		{
			document.frm1249.vipNo.readOnly=true;
			document.frm1249.custName.readOnly=true;
			document.frm1249.registerTime.readOnly=true;
			document.frm1249.IDNo.readOnly=true;
			document.frm1249.occupation.readOnly=true;
			document.frm1249.businessType.readOnly=true;
			document.frm1249.contactPhone.readOnly=true;
			document.frm1249.unitAddr.readOnly=true;
			document.frm1249.uPostalcode.readOnly=true;
			document.frm1249.familyAddr.readOnly=true;
			document.frm1249.fPostalcode.readOnly=true;
			document.frm1249.phoneType.readOnly=true;
			document.frm1249.email.readOnly=true;
			document.frm1249.personalLike.readOnly=true;
			document.frm1249.monthSal.readOnly=true;
			document.frm1249.smType.readOnly=true;
			document.frm1249.phonePayType.readOnly=true;
			document.frm1249.sendBill.readOnly=true;
			document.frm1249.favourPro.readOnly=true;
			document.frm1249.yuan.readOnly=true;
			document.frm1249.fetchType.readOnly=true;
			document.frm1249.changeSTK.readOnly=true;
			document.frm1249.cardNo.readOnly=true;
			document.frm1249.giveTJK.readOnly=true;
			//document.frm1249.managePay.readOnly=true;
			document.frm1249.note.readOnly=true;
		}else{
			document.frm1249.vipNo.readOnly=false;
			document.frm1249.custName.readOnly=false;
			document.frm1249.registerTime.readOnly=false;
			document.frm1249.IDNo.readOnly=false;
			document.frm1249.occupation.readOnly=false;
			document.frm1249.businessType.readOnly=false;
			document.frm1249.contactPhone.readOnly=false;
			document.frm1249.unitAddr.readOnly=false;
			document.frm1249.uPostalcode.readOnly=false;
			document.frm1249.familyAddr.readOnly=false;
			document.frm1249.fPostalcode.readOnly=false;
			document.frm1249.phoneType.readOnly=false;
			document.frm1249.email.readOnly=false;
			document.frm1249.personalLike.readOnly=false;
			document.frm1249.monthSal.readOnly=false;
			document.frm1249.smType.readOnly=false;
			document.frm1249.phonePayType.readOnly=false;
			document.frm1249.sendBill.readOnly=false;
			document.frm1249.favourPro.readOnly=false;
			document.frm1249.yuan.readOnly=false;
			document.frm1249.fetchType.readOnly=false;
			document.frm1249.changeSTK.readOnly=false;
			document.frm1249.cardNo.readOnly=false;
			document.frm1249.giveTJK.readOnly=false;
			//document.frm1249.managePay.readOnly=false;
			document.frm1249.note.readOnly=false;
		}
		var phoneNo = document.frm1249.phoneNo.value;
		var org_code = document.frm1249.unitCode.value;
		var opCode = "1249";
		var loginNo = document.frm1249.workno.value;
		var query_Packet = new AJAXPacket("f1249_query.jsp","���ڲ�ѯ�����Ժ�......");
		query_Packet.data.add("retType","query");
		query_Packet.data.add("phoneNo",phoneNo);
		query_Packet.data.add("org_code",org_code);
		query_Packet.data.add("opCode",opCode);
		query_Packet.data.add("loginNo",loginNo);
		query_Packet.data.add("opFlag",opFlag);
		core.ajax.sendPacket(query_Packet);
		query_Packet=null;
		
	}else{
		rdShowMessageDialog("�������ֻ����룡",0);
		frm1249.phoneNo.focus();
		return false;		
	}
}
function queryRegister()
{
	if(document.frm1249.phoneNo.value!="")
	{
			var phoneNo = document.frm1249.phoneNo.value;
			var org_code = document.frm1249.unitCode.value;
			var opCode = "1249";
			var opFlag = "0";
			var loginNo = document.frm1249.workno.value;
			var query_Packet = new AJAXPacket("f1249_queryRegister.jsp","���ڲ�ѯ�����Ժ�......");
			query_Packet.data.add("retType","queryRegister");
			query_Packet.data.add("phoneNo",phoneNo);
			query_Packet.data.add("org_code",org_code);
			query_Packet.data.add("opCode",opCode);
			query_Packet.data.add("loginNo",loginNo);
			query_Packet.data.add("opFlag",opFlag);
			core.ajax.sendPacket(query_Packet);
			query_Packet=null;
		
	}else{
		rdShowMessageDialog("�������ֻ����룡",0);
		frm1249.phoneNo.focus();
		return false;		
	}
}
function judgeOpeType()
{
	if(document.frm1249.opeType.value==0)
	{
		document.frm1249.queryAll.disabled=true;
		
	}else{
		document.frm1249.queryAll.disabled=false;
	}
	if(document.frm1249.opeType.value==3)
	{
		document.frm1249.print.disabled=true;
	}else{
		document.frm1249.print.disabled=false;
	}
}
function clearAll()
{
		
		document.frm1249.vipNo.value="";
		document.frm1249.custName.value="";
		document.frm1249.registerTime.value="";
		document.frm1249.IDNo.value="";
		document.frm1249.contactPhone.value="";
		document.frm1249.unitAddr.value="";
		document.frm1249.uPostalcode.value="";
		document.frm1249.familyAddr.value="";
		document.frm1249.fPostalcode.value="";
		document.frm1249.phoneType.value="";
		document.frm1249.email.value="";
		document.frm1249.personalLike.value="";
		document.frm1249.yuan.value="";
		document.frm1249.cardNo.value="";
		document.frm1249.note.value="";
}


</SCRIPT>
</HEAD>
<!--**************************************************************************************--> 
<body>
<FORM method=post name="frm1249" action="/npage/innet/f1249_2.jsp" onKeyUp="chgFocus(frm1249)">
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>	
	<table cellspacing="0" >
		<tr>
		        <td class="blue">��������</td>                  
			<td width="84%">
				<select name="opeType" onChange="judgeOpeType()">
					  <option value="0">�Ǽ�</option>
					  <option value="1">�޸�</option>
					  <option value="3">��ѯ</option>
					  <option value="2">ɾ��</option>
					  </select>
			</td>
		</tr>
	</table>
	<table cellspacing="0" >
		<tr>
			<TD width=16% class="blue">�ƶ�����</TD>                  
                  	<TD width="23%"> 
                    		<input name=phoneNo v_type="mobphone"  v_must=1  v_name="�ƶ�����"  maxlength=11  index="2" value =<%=phoneNo%>  readonly class="InputGrey">
                 	 </TD>
			<td width="11%">
				  <input name="queryAll"  type="button" class="b_text" value="��ѯ" onClick="query()" disabled>
			</td>
			<TD width=16% class="blue"> VIP����� </TD>                 
                  	<TD width="34%"> 
                    		<input  type="text" name="vipNo" v_must=1  v_name="VIP�����" index="3" value="" >
                  			<font class="orange">*</font>
                  	</TD>
		</TR>
	</TABLE>
	<table cellspacing="0" >
		<TR > 
                  	<TD width="16%" nowrap class="blue"> �ͻ����� </TD>
                  	<TD width="34%"> 
                    		<input name=custName  type="text" v_must=1  maxlength="60" value="" >
                  			<font class="orange">*</font>
                  	</TD>
                  	<TD width="16%" nowrap class="blue"> �Ǽ�ʱ��</TD>                  
                  	<TD width="34%"> 
                    		<input name="registerTime"  type="text" v_type="date" v_must=1  maxlength="15"  index="17" value="<%=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new Date())%>" readonly class="InputGrey">
                  	</TD>
                </TR>
		<TR> 
                  <TD width="16%" nowrap class="blue"> 
                   	���֤��
                  </TD>
                  <TD width="34%">                                   											
                    	<input name=IDNo  type="text" v_type="idcard" v_must=1  maxlength="18" onBlur="if(this.value!=''){if(checkElement(document.frm1249.IDNo)==false){return false;}}" value="" >
                    	<font class="orange">*</font>
                  </TD>
                  <TD width="16%" nowrap class="blue"> 
                   	ְҵ
                  </TD>
                  <TD width="34%"> 
				  <select name="occupation">
				  <%try{
				  	String sqlStr = "select owner_attr,attr_name from sOwnerAttrCode where owner_group='2'";
				 	//retArray = callView.view_spubqry32("2",sqlStr);
				 	
				 %>
				 	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
						<wtc:sql><%=sqlStr%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="result1" scope="end" />

				 <%
					//result = (String[][])retArray.get(0);
					result=result1;
                    			int recordNum = result.length;
					for( int i=0;i<recordNum;i++){
				  %>
				  		<option value="<%=result[i][0]%>"><%=result[i][1]%></option>
				  <%				
				  							 }
        				}catch(Exception e){
                        
                    		}              
				  %>
				  </select>
                  </TD>
                </TR>
		<TR> 
                  <TD width="16%" nowrap class="blue"> 
                   	ְ�����
                  </TD>
                  <TD width="34%"> 
				   <select id="businessType" name="businessType">
				  <%try{
				  	String sqlStr = "select ad_type,type_name from sAdverCode where code_type='7' ";
				 	//retArray = callView.view_spubqry32("2",sqlStr);
				 	%>
				 		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
							<wtc:sql><%=sqlStr%></wtc:sql>
						</wtc:pubselect>
						<wtc:array id="result2" scope="end" />
				 	<%
					//result = (String[][])retArray.get(0);
					result=result2;
                    			int recordNum = result.length;
					for( int i=0;i<recordNum;i++){ 
					%>
					 	<option value="<%=result[i][0]%>"><%=result[i][1]%></option>
					<%
					}
        			}catch(Exception e){
                        
                    		}              
				  %>
				  </select>
                  </TD>
                  <TD width="16%" nowrap class="blue"> 
                   	��ϵ�绰
                  </TD>
                  <TD width="34%"> 
                    	<input name=contactPhone  type="text" v_type="phone49.contactPhone)==false){return false;}}" value="" >
                  		<font class="orange">*</font>
                  </TD>
                </TR>
	</TABLE>
	<TABLE  cellSpacing=0>
		<TR> 
                  <TD width="16%" nowrap class="blue"> 
                   	��λ��ַ
                  </TD>
                  <TD width="34%"> 
                    	<input name=unitAddr  type="text" v_must=1  maxlength="60" value="">
                  		<font class="orange">*</font>
                  </TD>
                  <TD width="16%" nowrap class="blue"> 
                   	��  ��
                  </TD>
                  <TD width="34%"> 
                    	<input name=uPostalcode  type="text" v_type="zip" size=11 v_must=1  maxlength="15"  index="17" onblur="if(this.value!=''){if(checkElement(document.frm1249.uPostalcode)==false){return false;}}" value="">
                 		<font class="orange">*</font>
                  </TD>
                </TR>
		<TR> 
                  <TD width="16%" nowrap class="blue"> 
                   	��ͥסַ
                   </td>
                   <td>
      			<input name=familyAddr  type="text" v_must=1  maxlength="60" value="">
                  <font class="orange">*</font>
                  </TD>
                  <TD width="16%" nowrap class="blue"> 
                   	��  ��
                  </TD>
                  <TD width="34%"> 
                    	<input name=fPostalcode  type="text" v_type="zip" size=11 v_must=1  maxlength="15"  index="17" onBlur="if(this.value!=''){if(checkElement(document.frm1249.fPostalcode)==false){return false;}}" value="">
                 		<font class="orange">*</font>
                  </TD>
                </TR>
	</TABLE>
	<TABLE  cellSpacing=0>
		<TR > 
                  <TD width="16%" nowrap class="blue"> 
                   	�ֻ��ͺ�
                  </TD>
                  <TD width="34%"> 
                    	<input name=phoneType  type="text" v_must=1  maxlength="15" value="">
                  		<font class="orange">*</font>
                  </TD>
                  <TD width="16%" nowrap class="blue"> 
                   	E_mail��ַ
                  </TD>
                  <TD width="34%"> 
                    	<input name=email  v_type= "email" type="text" v_must=1  maxlength="30"  index="17" value="" >
                  		<font class="orange">*</font>
                  </TD>
                </TR>
	</TABLE>
	<TABLE  cellSpacing=0>
		<TR > 
                  <TD width="16%" nowrap class="blue"> 
                   	���˰���
                  </TD>
                  <TD width="34%"> 
                    	<input name="personalLike"  type="text" v_must=1  maxlength="60" value="">
                    	<font class="orange">*</font>
                  </TD>
                  <TD width="16%" nowrap class="blue"> 
                   	�Ա�
                  </TD>
                  <TD width="34%">
				  <select name="sex">
					  <option value="��">��</option>
					  <option value="Ů">Ů</option>
				  </select> 
                  </TD>
                </TR>
	</TABLE>
	<TABLE  cellSpacing=0>
		<TR > 
                  <TD width="16%" nowrap class="blue"> 
                   	��нˮƽ
                  </TD>
                  <TD width="34%"> 
                      <select name="monthSal">
				  <%try{
				  	String sqlStr = "select owner_attr,attr_name from sOwnerAttrCode where owner_group='a' ";
				 	//retArray = callView.view_spubqry32("2",sqlStr);
				 %>
				 	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="2">
							<wtc:sql><%=sqlStr%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="result3" scope="end" />
				 <%
					//result = (String[][])retArray.get(0);
					result=result3;
                    			int recordNum = result.length;
					for( int i=0;i<recordNum;i++){
				  %>
				  	<option value="<%=result[i][0]%>"><%=result[i][1]%></option>
				  <%				
				  							 }
        			}catch(Exception e){                       
                    		}              
				  %>
				  </select>
                  </TD>
                  <TD width="16%" nowrap class="blue"> 
                   	ҵ������
                  </TD>
                  <TD width="34%"> 
                       <select name="smType">
				  <%try{
				  	String sqlStr = "select owner_attr,attr_name from sOwnerAttrCode where owner_group='b'";
				 	//retArray = callView.view_spubqry32("2",sqlStr);
				 %>
				 	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode4" retmsg="retMsg4" outnum="2">
							<wtc:sql><%=sqlStr%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="result4" scope="end" />
				 <%
					//result = (String[][])retArray.get(0);
					result=result4;
                    			int recordNum = result.length;
					for( int i=0;i<recordNum;i++){
				  %>
				  <option value="<%=result[i][0]%>"><%=result[i][1]%></option>
				  <%				
				  							 }
        			}catch(Exception e){
                       
                    		}              
				  %>
				  </select>
                  </TD>
                </TR>
		<TR> 
                  <TD width="16%" nowrap class="blue"> 
                   	����֧����ʽ
                  </TD>
                  <TD width="34%"> 
                      <select name="phonePayType">
				  <%try{
				  	String sqlStr = "select owner_attr,attr_name from sOwnerAttrCode where owner_group='c'";
				 	//retArray = callView.view_spubqry32("2",sqlStr);
				 	%>
				 	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode5" retmsg="retMsg5" outnum="2">
						<wtc:sql><%=sqlStr%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="result5" scope="end" />
				 	<%
					//result = (String[][])retArray.get(0);
					result=result5;
                    			int recordNum = result.length;
					for( int i=0;i<recordNum;i++){
				  %>
				  	<option value="<%=result[i][0]%>"><%=result[i][1]%></option>
				  <%				
				  							 }
        			}catch(Exception e){
                       
                    }              
				  %>
				  </select>
                  </TD>
                  <TD width="16%" nowrap class="blue"> 
                   	�����ʵ�
                  </TD>
                  <TD width="34%"> 
                       <select name="sendBill">
				  <%try{
				  	String sqlStr = "select owner_attr,attr_name from sOwnerAttrCode where owner_group='d'";
				 	//retArray = callView.view_spubqry32("2",sqlStr);
				 %>
				 	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode6" retmsg="retMsg6" outnum="2">
						<wtc:sql><%=sqlStr%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="result6" scope="end" />
				 <%
					//result = (String[][])retArray.get(0);
					result=result6;
                    			int recordNum = result.length;
					for( int i=0;i<recordNum;i++){
				  %>
				  	<option value="<%=result[i][0]%>"><%=result[i][1]%></option>
				  <%				
				  							 }
        			}catch(Exception e){
                       
                    		}              
				  %>
				  </select>
                  </TD>
                </TR>
		</TABLE>
		<TABLE  cellSpacing=0>	
		<TR> 
                  <TD width="16%" nowrap class="blue"> 
                   	�Ż���Ŀ
                  </TD>
                  <TD width="13%"> 
                    <select name="favourPro">
				  <%try{
				  	String sqlStr = "select owner_attr,attr_name from sOwnerAttrCode where owner_group='e'";
				 	//retArray = callView.view_spubqry32("2",sqlStr);
				 %>
				 	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode7" retmsg="retMsg7" outnum="2">
						<wtc:sql><%=sqlStr%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="result7" scope="end" />
				 <%
					//result = (String[][])retArray.get(0);
					result=result7;
                    			int recordNum = result.length;
					for( int i=0;i<recordNum;i++){
				  %>
				  <option value="<%=result[i][0]%>"><%=result[i][1]%></option>
				  <%				
				  							 }
        			}catch(Exception e){
                       
                    }              
				  %>
				  </select>
                  </TD>
                  <TD width="10%"> 
                    	<input name=yuan  type="text" v_type="money" size=10 v_must=1  maxlength="12"  index="17" onBlur="if(this.value!=''){if(checkElement(document.frm1249.yuan)==false){return false;}}" value="">
                  </TD>
		   <TD width="61%" nowrap class="blue"> 
                   	Ԫ
                   	<font class="orange">*</font>
                  </TD>
                </TR>
	</TABLE>
	<TABLE  cellSpacing=0>
			  <TR >
				  <td width="16%" class="blue">����ȡ��ʽ</td>
				  <td width="84%">
					  <select name="fetchType">
						  <option value="������λ">������λ</option>
						  <option value="����סլ">����סլ</option>
						  <option value="��ͻ������Ϳ�">��ͻ������Ϳ�</option>
					  </select>
				  </td>
			  </TR>
	</TABLE>
	<TABLE  cellSpacing=0>
			  <tr>
				  <td width="16%" class="blue">����STK��</td>
				  <td width="34%">
					  <select name="changeSTK">
						  <option value="��">��</option>
						  <option value="��">��</option>
					  </select>
				  </td>
				  <td width="16%" class="blue">����</td>
				  <td width="34%">
				  	<input name="cardNo" type="text"   maxlength="15" value="">
				  	<font class="orange">*</font>
				  </td>
			  </tr>
	</TABLE>
	<TABLE  cellSpacing=0>
			  <tr>
				  <td width="16%" class="blue">������쿨</td>
				  <td width="84%">
					  <select name="giveTJK">
						  <option value="��">��</option>
						  <option value="��">��</option>
					  </select>
				  </td>
			  </tr>
	</TABLE>
	<TABLE  cellSpacing=0>
                <tr> 
                  <td width=16% class="blue"> 
                   ��ע
                  </td>
                  <td> 
                    	<input  name="note" size=60 readonly class="InputGrey" maxlength="60" value="">
                  </td>
                </tr>
       </TABLE>                
       <TABLE  cellSpacing=0>
            <TR> 
              <TD id="footer" >
                <input  name=print  class="b_foot_long" onMouseUp="printCommit()" onKeyUp="if(event.keyCode==13)printCommit()" type=button value="ȷ��&��ӡ" index="16" >
                <input  name=reset1   class="b_foot"  type=button onClick="clearAll();" value=��� index="17">
		<input  name=back   class="b_foot"  onclick="removeCurrentTab()" type=button value=�ر� index="18">			  </TD>
            </TR>
        </TABLE>

  
	  <!------------------------> 
	  <input type="hidden" id=in1 name="hidPwd" v_name="ԭʼ����">
	  <input type="hidden" name="hidCustPwd">  <!--�ͻ����ܺ������-->
	  <input type="hidden" name="inParaStr" >
	  <input type="hidden" name="checkPwd_Flag" value="false">		<!--����У���־-->
	  <input type="hidden" name="unitCode" value=<%=Department%>>
	  <input type="hidden" name="workno" value=<%=workNo%>>
	  <input type="hidden" name="opCode" value="1249">
	  <input type="hidden" name="belongCode" value=<%=belongCode%>>
	  <input type="hidden" name="smCode" value=<%=smCode%>>
	  <input type="hidden" name="arrContent" value=<%=arrContent%>>
	  <input type="hidden" name="businessType1" value=<%=businessType%>>
	  <input type="hidden" name="businessTypeName" value=<%=businessTypeName%>>
	  <input type="hidden" name="occupation1" value=<%=occupation%>>
	  <input type="hidden" name="occupationName" value=<%=occupationName%>>
  	  <input type="hidden" name="readOnlyAll" value=<%=readOnlyAll%>>
  	  
  	   <input type="hidden" name="printAccept" value=<%=printAccept%>>
	    <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>                                                                                                                                                                                                                                                               