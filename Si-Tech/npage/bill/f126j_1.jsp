<%
/********************
 version v2.0
������ si-tech
update hejw@2009-1-7
********************/
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>



<%
  String opCode = "126j";
  String opName = "���ֻ���";
%>

<head>
<%
/*
  ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
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
  String aftertrim = baseInfoSession[0][5].trim();

  comImpl co1 = new comImpl();
  String paraStr[]=new String[1];
  String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
  paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
  */
  
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");

%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regionCode" routerValue="<%=regionCode%>"  id="req" />
	
	

<script language="JavaScript">
<!--
  onload=function()
  {
  	document.all.phoneNo.focus();
   	self.status="";
   }

//--------1---------doProcess����----------------


  function doProcess(packet)
  {
    var vRetPage=packet.data.findValueByName("rpc_page");
    if(vRetPage == "qryCus_s126jInit")
    {
		
  	var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
		
    var bp_name         = packet.data.findValueByName("bp_name"        );
    //alert(bp_name);
    var sm_code         = packet.data.findValueByName("sm_code"        );
    var family_code     = packet.data.findValueByName("family_code"    );
    var rate_code       = packet.data.findValueByName("rate_code"      );
    var bigCust_flag    = packet.data.findValueByName("bigCust_flag"   );
    var sm_name         = packet.data.findValueByName("sm_name"        );
    var rate_name       = packet.data.findValueByName("rate_name"      );
    var bigCust_name    = packet.data.findValueByName("bigCust_name"   );
    var next_rate_code  = packet.data.findValueByName("next_rate_code" );
    var next_rate_name  = packet.data.findValueByName("next_rate_name" );
    var lack_fee        = packet.data.findValueByName("lack_fee"       );
    var prepay_fee      = packet.data.findValueByName("prepay_fee"     );
    var bp_add          = packet.data.findValueByName("bp_add"         );
    var cardId_type     = packet.data.findValueByName("cardId_type"    );
    var cardId_no       = packet.data.findValueByName("cardId_no"      );
    var cust_id         = packet.data.findValueByName("cust_id"        );
    var cust_belong_code= packet.data.findValueByName("cust_belong_code");
    var group_type_code = packet.data.findValueByName("group_type_code");
    var group_type_name = packet.data.findValueByName("group_type_name");
    var imain_stream    = packet.data.findValueByName("imain_stream"   );
    var next_main_stream= packet.data.findValueByName("next_main_stream");
    var hand_fee        = packet.data.findValueByName("hand_fee"       );
    var favorcode       = packet.data.findValueByName("favorcode"      );
    var card_no         = packet.data.findValueByName("card_no"        );
    var print_note      = packet.data.findValueByName("print_note"     );
    var contract_flag   = packet.data.findValueByName("contract_flag"  );
    var high_flag       = packet.data.findValueByName("high_flag"      );
	  var curpoint        = packet.data.findValueByName("curpoint"      );
		if(retCode == 000000)
		{
		document.all.i2.value = cust_id;
		document.all.i16.value = rate_code;
		document.all.belong_code.value = cust_belong_code;
		document.all.print_note.value = print_note;

		document.all.i4.value = bp_name;
		document.all.i5.value = bp_add;
		document.all.i6.value = cardId_type;
		document.all.i7.value = cardId_no;
		document.all.i8.value = sm_code+"--"+sm_name;
		document.all.i9.value = contract_flag;

		document.all.ipassword.value = "";
		document.all.group_type.value = group_type_code+"--"+group_type_name;
		document.all.ibig_cust.value =  bigCust_flag+"--"+bigCust_name;

		document.all.favorcode.value = favorcode;
		document.all.maincash_no.value = rate_code;
		document.all.imain_stream.value =  imain_stream;
		document.all.next_main_stream.value =  next_main_stream;

		document.all.i18.value = next_rate_code+"--"+next_rate_name;
		document.all.i19.value = hand_fee;
		document.all.i20.value = hand_fee;

		document.all.oCustName.value = bp_name;
		document.all.oSmCode.value = sm_code;
		document.all.oSmName.value = sm_name;
		document.all.oModeCode.value = rate_code;
		document.all.oModeName.value = rate_name;
		document.all.oPrepayFee.value = prepay_fee;
		document.all.oMarkPoint.value = curpoint;
		}
		else
		{
				rdShowMessageDialog("����"+ retCode + "->" + retMsg);
				return;
		}
  	}

    if(vRetPage == "qryPayPrepay")
    {
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");

    var pay_pre        = packet.data.findValueByName("pay_pre"        );

		if(retCode == 000000)
		{
		document.all.oPayPre.value = pay_pre;
		}
		else
		{
				rdShowMessageDialog("����"+ retCode + "->" + retMsg);
				return;
		}
		}

    if(vRetPage == "qryAreaFlag")
    {
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    var area_flag = packet.data.findValueByName("area_flag");

		if(retCode == 000000)
		{
		    if(parseInt(area_flag)>0)
		    {
		       document.all.flagCodeTr.style.display="";
		    }
		}
		else
		{
				rdShowMessageDialog("����"+ retCode + "->" + retMsg);
				return;
		}
	}
 }


  //--------2---------��֤��ťר�ú���-------------
  function chkPass()
  {

  var myPacket = new AJAXPacket("qryCus_s126jInit.jsp","���ڲ�ѯ�ͻ������Ժ�......");
	myPacket.data.add("iPhoneNo",(document.all.phoneNo.value).trim());
	myPacket.data.add("iLoginNo",(document.all.loginNo.value).trim());
	myPacket.data.add("iOrgCode",(document.all.orgCode.value).trim());
	myPacket.data.add("iOpCode",(document.all.iOpCode.value).trim());

	core.ajax.sendPacket(myPacket);
	myPacket = null;
  }

  function qryPayPrepay()
  {
  if(!checkElement(document.frm.oPayAccept)) return;
  var myPacket = new AJAXPacket("qryPayPrepay.jsp","���ڲ�ѯ�ͻ������Ժ�......");
	//alert((document.all.i2.value));
	myPacket.data.add("PayAccept",(document.all.oPayAccept.value).trim());
	myPacket.data.add("IdNo",(document.all.i2.value).trim());
	myPacket.data.add("PhoneNo",(document.all.phoneNo.value).trim());

	core.ajax.sendPacket(myPacket);
	myPacket=null;
  }

  function printCommit()
  {
  	     getAfterPrompt();
         if(!checkElement(document.frm.phoneNo)) return;
         if(!checkElement(document.frm.Gift_Name)) return;
         
         if (document.all.oSmCode.value != "gn" && document.all.oSmCode.value !="zn")
         {
         	rdShowMessageDialog("��ҵ��ֻ��ȫ��ͨ�������пͻ����ţ�");
         	return;
         }
         if (document.all.i9.value == "Y")
         {
         	rdShowMessageDialog("���û��������û�,���ܰ����ҵ��");
         	return;
         }

         if(parseFloat(document.all.oPayPre.value)<parseFloat(document.all.Prepay_Fee.value))
         {
           rdShowMessageDialog("���ν���Ԥ����,���ܰ���!");
           return;
         }

	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");

     if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
        {
	      frm.submit();
        }


	    if(ret=="remark")
	    {
         if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
         {
	       frm.submit();
         }
	   }
	 }
    else
    {
       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
       {
	     frm.submit();
       }
    }

    return true;

}

function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի���
	  /*
	   var h=150;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;

     var printStr = printInfo(printType);

     var prop="dialogHeight"+h+"px; dialogWidth"+w+"px; dialogLeft"+l+"px; dialogTop"+t+"px;toolbarno; menubarno; scrollbarsyes; resizableno;locationno;statusno;helpno";
     var path = "/page/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
     var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
     var ret=window.showModalDialog(path,"",prop);
     return ret;
     */
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2; 
     var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =<%=req%>;                       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                        //�ʷѴ���
     var fav_code=null;                         //�ط�����
     var area_code=null;                    //С������
     var opCode =   "<%=opCode%>";                         //��������
     var phoneNo = <%=activePhone%>;                            //�ͻ��绰
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.frm.phoneNo.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);

  }

 function printInfo(printType)
  {
    var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";

    cust_info+="�ֻ����룺"+document.frm.phoneNo.value+"|";
    cust_info+="�ͻ�������"+document.frm.oCustName.value+"|";
    cust_info+="ҵ��Ʒ�ƣ�"+document.frm.oSmName.value+"|";
    cust_info+="�ʷ����ƣ�"+document.frm.oModeName.value+"|";
    cust_info+="��ǰ���֣�"+document.frm.oMarkPoint.value+"|";

    opr_info+="ҵ�����ͻ��ֻ���"+"|";
    opr_info+="��ˮ�ţ�"+document.frm.loginAccept.value+"|";
	  opr_info+="�һ���Ʒ��λ��"+document.frm.Gift_Grade.value+"        ��Ʒ����"+document.all.Gift_Name.value+"|";
	  opr_info+="Ԥ�滰�ѽ��:"+document.frm.oPayPre.value+"|";
 
	  note_info1+="���������ҵ�񣬽��ۼ�һ����ȵĻ��֣����ɶ�β����������ɵĻ���Ԥ��������ʱ�޵����ƣ��������˻���"+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

    return retInfo;
  }



 function judge_area()
 {
  var myPacket = new AJAXPacket("qryAreaFlag.jsp","���ڲ�ѯ�ͻ������Ժ�......");
	myPacket.data.add("orgCode",(document.all.orgCode.value).trim());
	//myPacket.data.add("modeCode",jtrim(document.all.New_Mode_Code.value));
	core.ajax.sendPacket(myPacket);
	myPacket=null;
 }

 //-------------------
 function getInfo_code()
	{
  	//���ù���js
  	var regionCode = "01";
    var pageTitle = "��Ʒѡ��";
    var fieldName = "��Ʒ��λ|��Ʒ����|��Ʒ����|Ԥ����|�ۼ�����|��������|";//����������ʾ���С�����
    var sqlStr = "select Gift_Grade,Gift_Code,Gift_Name,Prepay_Fee,Mark_Subtract,Consume_Term from sMarkGift a,dMarkMsg b,dCustMsg c "
	              + "where region_code='"+regionCode+"' "
				  + "and b.current_point>=a.mark_subtract "
				  + "and b.id_no=c.id_no "
				  + "and c.phone_no='"+document.frm.phoneNo.value+"' "
				  + "and a.flag='0' "
				  + "order by Gift_Grade";
 // alert(sqlStr);
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "6|0|1|2|3|4|5|";//�����ֶ�
    var retToField = "Gift_Grade|Gift_Code|Gift_Name|Prepay_Fee|Mark_Subtract|Consume_Term|";//���ظ�ֵ����

    if(MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,50));

    document.frm.i1.value=document.frm.phoneNo.value;
  //  document.frm.ip.value=document.frm.New_Mode_Code.value;
	document.all.do_note.value = "�û�"+document.all.phoneNo.value+"���ֻ�����Ʒ����"+document.all.Gift_Code.value;
	document.frm.iAddStr.value=document.frm.Gift_Code.value+"|"+document.frm.Prepay_Fee.value+"|"+
	                            document.frm.Mark_Subtract.value+"|"+document.frm.Consume_Term.value+"|"+
	                            document.frm.Gift_Name.value+"|";

    judge_area();
	}



function MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,dialogWidth)
{
    var path = "/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    retInfo = window.showModalDialog(path,"","dialogWidth"+dialogWidth);
    if(retInfo ==undefined)
    {   return false;   }
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
	return true;
}

//-->
</script>

</head>

<body>
	<form name="frm" method="post" action="f126jCfm.jsp" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>   
		<input name="oSmCode" type="hidden"  id="oSmCode" value="">
		<input name="oModeCode" type="hidden"  id="oModeCode" value="">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=req%>">
		<input type="hidden" name="Gift_Code" value="">
		<input type="hidden" name="Gift_Grade" value="">


	<table cellspacing="0">
		<tr>
			<td class="blue">�ֻ�����</td>
            <td width="39%">
				<!--input   type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" id="phoneNo" v_name="�ֻ�����" onBlur="if(this.value!=''){if(checkElement('phoneNo')==false){return false;}}" maxlength=11 index="3"-->
				<input type="text" name="phoneNo" id="phoneNo" readOnly  v_type="mobphone" v_must=1 name="phoneNo" id="phoneNo" v_name="�ֻ�����" value =<%=activePhone%>  Class="InputGrey" >

				<input type="button" name="qryId_No" value="��ѯ" onClick="chkPass()" class="b_text" /> 
			</td>
			<td class="blue">��������</td>
			<td>
				<input name="oCustName" type="text"  id="oCustName" value="" readOnly class="InputGrey"/>
			</td>
		</tr>
		<tr>
			<td class="blue">ҵ��Ʒ��</td>
            <td>
				<input name="oSmName" type="text"  id="oSmName" value="" readOnly class="InputGrey"/>
			</td>
            <td class="blue">�ʷ�����</td>
            <td>
				<input name="oModeName" type="text"  id="oModeName" value="" readOnly class="InputGrey"/>
			</td>
		</tr>
		<tr>
			<td class="blue">
				�ʺ�Ԥ��
			</td>
            <td>
				<input name="oPrepayFee" type="text"  id="oPrepayFee" value="" readOnly class="InputGrey"/>
			</td>
            <td class="blue">
            	��ǰ����
            </td>
            <td>
				<input name="oMarkPoint" type="text"  id="oMarkPoint" value="" readOnly class="InputGrey"/>
			</td>
		</tr>
		<tr>
			<td class="blue">
				�ɷ���ˮ
			</td>
            <td>
				<input name="oPayAccept" type="text"  id="oPayAccept" v_name="�ɷ���ˮ" v_must=1 v_type="0_9" onKeyPress="if(event.keyCode==13)qryPayPrepay()" />
				<input class="b_text" type="button" name="qryPayPre" value="��ѯ����Ԥ��" onClick="qryPayPrepay()">
			</td>
            <td class="blue">
            	����Ԥ���
            </td>
            <td>
				<input name="oPayPre" type="text"  id="oPayPre" value="0" readOnly />
			</td>
		</tr>
		<tr >
			<td class="blue">
            	��Ʒѡ��>> <input class="b_text" type="button" name="qryId_No" value="ѡ��" onClick="getInfo_code()" readOnly />
            </td>
		</tr>
		<tr >
            <td class="blue">
            	��Ʒ����
            </td>
            <td>
				<input name="Gift_Name" type="text"  id="Gift_Name" v_name="��Ʒ����" v_type="string" v_must=1 value="" readOnly />
			</td>
            <td class="blue">
            	��������
            </td>
            <td>
            	<input name="Consume_Term" type="text"  id="Consume_Term"  readOnly />
			</td>
		</tr>
		<tr >
           <td class="blue">
            	Ԥ����
            </td>
            <td class="blue">
            	<input name="Prepay_Fee" type="text"  id="Prepay_Fee"   readOnly>
			</td>
			<td class="blue">
				�ۼ�����
			</td>
            <td>
				<input name="Mark_Subtract" type="text"  id="Mark_Subtract"   readOnly>
			</td>
		</tr>
		<tr">
			<td colspan="4">
				<div id="footer">
                &nbsp;
				<input name="commit" id="commit" type="button" class="b_foot_long"   value="ȷ��&��ӡ" onClick="printCommit();">
                &nbsp;
                <input name="reset" type="reset" class="b_foot"  value="���" >
                &nbsp;
                <input name="close" onclick="removeCurrentTab();" type="button" class="b_foot"  value="�ر�"/>
                &nbsp;
				</div>
			</td>
		</tr>
	</table>
			<input type="hidden" name="iOpCode" value="126j">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
			<!--���²�����Ϊ��f1270_3.jsp������Ĳ���
			i2�ͻ�ID
			i16��ǰ���ײʹ���
			ip�������ײʹ���
			belong_codebelong_code
			print_note��������
			iAddStr

			i1�ֻ�����
			i4�ͻ�����
			i5�ͻ���ַ
			i6֤������
			i7֤������
			i8ҵ��Ʒ��

			ipassword����
			group_type���ſͻ����
			ibig_cust��ͻ����
			do_note�û���ע
			favorcode�������Ż�Ȩ��
			maincash_no�����ײʹ��루�ϣ�
			imain_stream��ǰ���ʷѿ�ͨ��ˮ
			next_main_streamԤԼ���ʷѿ�ͨ��ˮ

			i18�������ײ�
			i19������
			i20���������
			-->
			<input type="hidden" name="i2" value="">
			<input type="hidden" name="i16" value="">
			<input type="hidden" name="ip" value="">

			<input type="hidden" name="belong_code" value="">
			<input type="hidden" name="print_note" value="">
			<input type="hidden" name="iAddStr" value="">

			<input type="hidden" name="i1" value="">
			<input type="hidden" name="i4" value="">
			<input type="hidden" name="i5" value="">
			<input type="hidden" name="i6" value="">
			<input type="hidden" name="i7" value="">
			<input type="hidden" name="i8" value="">
			<input type="hidden" name="i9" value="">

			<input type="hidden" name="ipassword" value="">
			<input type="hidden" name="group_type" value="">
			<input type="hidden" name="ibig_cust" value="">
			<input type="hidden" name="do_note" value="">
			<input type="hidden" name="favorcode" value="">
			<input type="hidden" name="maincash_no" value="">
			<input type="hidden" name="imain_stream" value="">
			<input type="hidden" name="next_main_stream" value="">

			<input type="hidden" name="i18" value="">
			<input type="hidden" name="i19" value="">
			<input type="hidden" name="i20" value="">

			<input type="hidden" name="mode_type" value="">
			<input type="hidden" name="New_Mode_Name" value="�����ʷ�����">
			<input type="hidden" name="return_page" value="/npage/bill/f126j_1.jsp">
			<%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
