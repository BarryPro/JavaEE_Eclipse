<%
    /********************
     * @ OpCode    :  7893
     * @ OpName    :  ���Ӫ�����ų�Աɾ��
     * @ CopyRight :  si-tech
     * @ Author    :  wangzn
     * @ Date      :  2010-4-28 15:32:00
     * @ Update    :
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.GregorianCalendar" %>
<%
    String opCode = "7483";
    String opName = "���Ӫ�����ų�Աɾ��";

    String workNo =(String)session.getAttribute("workNo");
		String workName =(String)session.getAttribute("workName");
		String powerRight =(String)session.getAttribute("powerRight");
		String Role =(String)session.getAttribute("Role");
		String orgCode =(String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String groupId =(String)session.getAttribute("groupId");
		String ip_Addr =(String)session.getAttribute("ip_Addr");
		String belongCode =orgCode.substring(0,7);
		String districtCode =orgCode.substring(2,4);

		String action = WtcUtil.repNull((String)request.getParameter("action"));
		String packetCode = WtcUtil.repNull((String)request.getParameter("packet_code"));
		String unitId = WtcUtil.repNull((String)request.getParameter("unit_id"));
		String unitName = WtcUtil.repNull((String)request.getParameter("unit_name"));
		String productName = WtcUtil.repNull((String)request.getParameter("product_name"));
		String iccid = WtcUtil.repNull((String)request.getParameter("iccid"));
    /* ȡ������ˮ */
    String sysAccept = "";
    %>
        <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
    <%
    sysAccept = seq;
    System.out.println("#           - ��ˮ��"+sysAccept);

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title>���Ӫ�����ų�Աɾ��</title>
 <script type=text/javascript>
 	   var dynTbIndex=1;				//���ڶ�̬�����ݵ�����λ��,��ʼֵΪ1.���Ǳ�ͷ
     var oprType_Add = "a";
 	   function oneTokSelf(str,tok,loc)
    {
        var temStr=str;

        var temLoc;
        var temLen;
        for(ii=0;ii<loc-1;ii++)
        {
            temLen=temStr.length;
            temLoc=temStr.indexOf(tok);
            temStr=temStr.substring(temLoc+1,temLen);
        }
        if(temStr.indexOf(tok)==-1)
            return temStr;
        else
            return temStr.substring(0,temStr.indexOf(tok));
    }
 	   function doProcess(packet)
    {
        var retType = packet.data.findValueByName("retType");
        var retCode = packet.data.findValueByName("retCode");
        var retMessage=packet.data.findValueByName("retMessage");

		    var backArrMsg = packet.data.findValueByName("backArrMsg");
		    var backArrMsg1 = packet.data.findValueByName("backArrMsg1");
		    var backArrMsg2=packet.data.findValueByName("backArrMsg2");

        self.status="";

        if(retType =="phonenoMobile"){
        	if( parseInt(retCode) == 0 ){
        		document.all.mobile_phone.value=backArrMsg;
        	}
        	else{

                $("#ISDNNO").val("");
                $("#USERNAME").val("");
                $("#IDCARD").val("");

                rdShowMessageDialog("������룺"+retCode+"</br>������Ϣ��"+retMessage+"!",0);
                return false;
            }
        }else if(retType == "phoneno"){
            if( parseInt(retCode) == 0 ){
                var num = backArrMsg[0][0];
                if( parseInt(num) < 2){

                    $("#ISDNNO").val("");
                    $("#USERNAME").val("");
                    $("#IDCARD").val("");

                    rdShowMessageDialog("Ƿ���û�(�������û�)��������VPMNҵ��!",0);
                    document.frm.ISDNNO.focus();
                    return false;
                }
                else{
                    dynAddRow();
                }
            }else{

                $("#ISDNNO").val("");
                $("#USERNAME").val("");
                $("#IDCARD").val("");

                rdShowMessageDialog("������룺"+retCode+"</br>������Ϣ��"+retMessage+"!",0);
                return false;
            }
        }else if(retType == "phonenoB"){
            if( parseInt(retCode) == 0 ){
                var num = backArrMsg[0][0];

                if( parseInt(num) < 1){

                    $("#ISDNNO").val("");
                    $("#USERNAME").val("");
                    $("#IDCARD").val("");

                    rdShowMessageDialog("���û�����Ӫ������Ա�������ڴ�ģ����ɾ��!",0);
                    document.frm.ISDNNO.focus();
                    return false;
                }
                else{
                    dynAddRow();
                }
            }else{

                $("#ISDNNO").val("");
                $("#USERNAME").val("");
                $("#IDCARD").val("");

                rdShowMessageDialog("������룺"+retCode+"</br>������Ϣ��"+retMessage+"!",0);
                return false;
            }
        }
        else{
            rdShowMessageDialog("������룺"+retCode+"������Ϣ��"+retMessage+"",0);
            return false;
        }
    }
 	   function check_phone()
     {
        var sqlBuf="90000228";
		var params_=document.frm.ISDNNO.value+"|";
		var outNum = "1";
        var myPacket = new AJAXPacket("../s7983/CallCommONESQL.jsp","������֤�û����룬���Ժ�......");
        if(!checkElement(document.all.ISDNNO)) return false;
        myPacket.data.add("verifyType","phoneno");
        myPacket.data.add("sqlBuf",sqlBuf);
		myPacket.data.add("recv_number",outNum);
		myPacket.data.add("params",params_);
        core.ajax.sendPacket(myPacket);
        myPacket=null;
     }
     function check_phoneB()
     {
        var sqlBuf="90000229";
		var params_=document.frm.unit_id.value+"|"+document.frm.ISDNNO.value+"|";
		var outNum = "1";
        var myPacket = new AJAXPacket("../s7983/CallCommONESQL.jsp","������֤�û����룬���Ժ�......");
        if(!checkElement(document.all.ISDNNO)) return false;
        myPacket.data.add("verifyType","phonenoB");
        myPacket.data.add("sqlBuf",sqlBuf);
		myPacket.data.add("recv_number",outNum);
		myPacket.data.add("params",params_);
        core.ajax.sendPacket(myPacket);
        myPacket=null;
     }
 	   function dynAddRow()
    {

        var isdn_no="";
        var user_name="";
        var id_card="";
        var note="";
        var add_no="";
        var tmpStr="";
        var flag=false;

        var op_type = oprType_Add;

        if( op_type == oprType_Add)
        {
            isdn_no = document.all.ISDNNO.value;
            if(!checkElement(document.all.ISDNNO)) return false;
        }

        user_name = document.all.USERNAME.value;
        id_card = document.all.IDCARD.value;
        queryAddAllRow(0,isdn_no,user_name,id_card);
    }
    function queryAddAllRow(add_type,isdn_no,user_name,id_card)
    {
        var tr1="";
        var i=0;
        var tmp_flag=false;

        if ( parseInt(document.all.addRecordNum.value) > 9 )
        {
            rdShowMessageDialog("���ֻ�ܲ���10������ !!");
            return false;
        }
        tmp_flag = verifyUnique(isdn_no);
        if(tmp_flag == false)
        {
            rdShowMessageDialog("�Ѿ���һ��'�ֻ�����'��ͬ������!!");
            return false;
        }
        tr1=dyntb.insertRow();    //ע�⣺����ı������������һ��,������ɿ���.yl.
        tr1.id="tr"+dynTbIndex;
        tr1.insertCell().innerHTML = '<div align="center"><input id=R0    type=checkBox    size=4 value="ɾ��" onClick="dynDelRow()" ></input></div>';
        tr1.insertCell().innerHTML = '<div align="center"><input id=R1    type=text   value="'+ isdn_no+'"  class="InputGrey" readonly></input></div>';
        tr1.insertCell().innerHTML = '<div align="center"><input id=R2    type=text   value="'+ user_name+'" maxlength=10 class="InputGrey"  readonly ></input></div>';
        tr1.insertCell().innerHTML = '<div align="center"><input id=R3    type=text   value="'+ id_card+'" class="InputGrey"  readonly></input></div>';

        dynTbIndex++;
        document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
    }
    function dynDelRow()
    {
        for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ������
        {
            if(document.all.R0[a].checked == true)
            {
                document.all.dyntb.deleteRow(a+1);
                break;
            }
        }
        document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
    }
    function verifyUnique(isdn_no)
    {
        var tmp_isdnNo="";
        var op_type = oprType_Add;

        for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ������
        {
            tmp_isdnNo = document.all.R1[a].value;

            if( op_type == oprType_Add)
            {
                if(  (isdn_no.trim()== tmp_isdnNo.trim())){
                    return false;
                }
            }else{
                if( (isdn_no.trim() == tmp_isdnNo.trim())){
                    return false;
                }
            }
        }
        return true;
    }


 	   function call_ISDNNOINFO()
     {

        var mobile_flag=document.all.mobile_phone.value;

        var path = "f7483_no_infor.jsp";
        path = path + "?loginNo=" + document.frm.work_no.value + "&phoneNo=" + document.frm.ISDNNO.value;
        path = path + "&opCode=" + document.frm.op_code.value + "&orgCode=" + document.frm.org_code.value;
        var retInfo = window.showModalDialog(path);

        if(typeof(retInfo) == "undefined")
        {
            document.frm.USERNAME.value = "";
            document.frm.IDCARD.value = "";
        }else{
            document.frm.USERNAME.value = oneTokSelf(retInfo,"|",1);
            document.frm.IDCARD.value = oneTokSelf(retInfo,"|",2);
            var sSmCode = oneTokSelf(retInfo,"|",3);
            if( sSmCode == "cb" )
            {
                rdShowConfirmDialog("�������û���������VPMNҵ��!",0);
                document.all.ISDNNO.focus();
                return false;
            }
            var run_code = oneTokSelf(retInfo,"|",6);
			/*haoyy 20120215 ȡ�����ſͻ���Ա�����з�����״̬��Աɾ������
            if( run_code != "A" && run_code != "B" && run_code != "C" &&
                run_code != "D" && run_code != "E" && run_code != "F" &&
                run_code != "G" && run_code != "H" && run_code != "I" &&
                run_code != "K" && run_code != "L" && run_code != "M")
            {
                rdShowConfirmDialog("������״̬�û�[" + run_code + "]�����ܰ���VPMNҵ��!",0);
                document.all.ISDNNO.focus();
                return false;
            }*/
            var sTotalFee = oneTokSelf(retInfo,"|",4);
           	if ( parseInt(sTotalFee) > 0 )
            {
                check_phone();

            }else{
            	  check_phoneB();
            }

        }
     }



 	   function resetJsp(){
      window.location='f7483_1.jsp';
     }

 	   function doNext(){
    	$("#product_name").val($('#packet_code option:selected').text());
    	document.frm.action="f7483_1.jsp?action=step1";
    	document.frm.submit();

     }


 	   function getUnitInfo(){
    	var unitId = $("#unit_id_q").val().trim();

    	if(unitId==""){
    		rdShowMessageDialog('����д��ѯ������',0);
    		return;
    	}

      var sqlStr = "90000214";
	  var params_=unitId + "|";
	  var outNum = "3";
	  
	  var selType = "S";    //'S'��ѡ��'M'��ѡ
	  var retQuence = "0|1|2|";//�����ֶ�
	  var fieldName = "���ű��|��������|֤������|";//����������ʾ���С�����
      var pageTitle = "����ѡ��";
      var retToField="unit_id|unit_name|iccid|";

      var path = "../s7482/fPubSimpSel.jsp";
      path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
      path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
      path = path + "&selType=" + selType;
	  path = path + "&params=" + params_ + "&outNum="+outNum;

      var retInfo = window.showModalDialog(path,"","dialogWidth:70;dialogHeight:35;");
      if(retInfo ==undefined){
      	return;
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



       $("#next").attr("disabled",false);

    }

    function doSubmit(){

        var ind1Str ="";
        var ind2Str ="";
        var ind3Str ="";
        var ind4Str ="";
        var ind5Str ="";

        if( dyntb.rows.length == 2){
            rdShowMessageDialog("û��ָ����Ա���룬����������!",0);
            return false;
        }else{
            for(var a=1; a<document.all.R0.length ;a++)
            {
                ind1Str =ind1Str +document.all.R1[a].value+"|";
                ind2Str =ind2Str +document.all.R2[a].value+"|";
                ind3Str =ind3Str +document.all.R3[a].value+"|";
            }
        }

        //2.��form�������ֶθ�ֵ

        document.all.tmpR1.value = ind1Str;
        document.all.tmpR2.value = ind2Str;
        document.all.tmpR3.value = ind3Str;



        $("#op_note").val("����Ա<%=workNo%>�������Ӫ�����ų�Աɾ��������");
        showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");


        var confirmFlag=0;
		    confirmFlag = rdShowConfirmDialog("�Ƿ��ύ���β�����");
		    if (confirmFlag==1) {
           document.frm.action="f7483_2.jsp";
           document.frm.submit();
        }

    }
    function showPrtDlg(printType,DlgMessage,submitCfm){
         var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
			var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
			var sysAccept =document.frm.sysAccept.value;       //��ˮ��
			var mode_code=null;           							  //�ʷѴ���
			var fav_code=null;                				 		//�ط�����
			var area_code=null;             				 		  //С������
			var opCode = "<%=opCode%>";
			
			printStr = printInfo(printType);
			
		  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+
				"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
			var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_dz.jsp?DlgMsg=" + DlgMessage ;
			path += "&mode_code="+mode_code+
				"&fav_code="+fav_code+"&area_code="+area_code+
				"&opCode="+opCode+"&sysAccept="+sysAccept+
				"&submitCfm="+submitCfm+"&pType="+
				pType+"&billType="+billType+ "&printInfo=" + printStr;
				
			var ret=window.showModalDialog(path,printStr,prop);
			return ret;
    }
    function printInfo(printType)
	  {
	  	
	  	/*2014/08/25 15:36:34 gaopeng ����ֹ�˾���ڵ��ӹ���Ӧ��������⼰����ķ��� 
			�����ϰ�������ӡ����Ϊ�������
			*/
			/*��󷵻ص��ַ���*/
			var retInfo = "";
			/*�û���Ϣ��*/
			var cust_info="";
			/*����ҵ����Ϣ��*/
			var opr_info="";
			/*��ע��Ϣ��*/
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			
			cust_info += "�ͻ�������   "+document.frm.unit_name.value+"|";
			cust_info += "֤�����룺   "+document.frm.iccid.value+"|";
			cust_info += "���ſͻ����룺   "+""+"|";
			
	   
	    
	    opr_info += "���Ų�Ʒ���ƣ�   "+document.frm.product_name.value+"|";
	    opr_info += "ҵ�����ͣ�   ���Ӫ�����ų�Աɾ��"+"|";
	    opr_info += "��ˮ��   "+document.frm.sysAccept.value+"|";
			
			note_info1 += document.frm.op_note.value+"|";
			
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;	

	  }
 </script>
</head>
<body>
<form name="frm" action="" method="post">
<%@ include file="/npage/include/header.jsp" %>

<table cellspacing=0>
    <tr>
      <td class='blue' nowrap width='18%'>���ű��</td>
      <%if(!"step1".equals(action)){%>
      <td>
      	<input type='text' name='unit_id_q' id='unit_id_q' v_must='0' v_name='unit_id_q' v_type='0_9'/>
    		  <font class='orange'>*</font>
    		  <input type='button' class='b_text' name='unit_id_qry' id='unit_id_qry' value='��ѯ' onClick="getUnitInfo();" />
      </td>
      <%}%>
      <td><input type='text' name='unit_id' id='unit_id' Class="InputGrey" v_must='1'  value='<%=unitId%>' readOnly /></td>
      <td class='blue' nowrap width='18%' >��������</td>
    	<td><input type='text' name='unit_name' id='unit_name' Class="InputGrey" v_must='1' value='<%=unitName%>' readOnly /></td>
   </tr>
</table>
<br/>

<%if("step1".equals(action)){%>
<div class="title">
	<div id="title_zi">��Ա�б�</div>
</div>
<table  cellspacing="0">
    <tr id="SHOWADD1" >

        <td  class="blue"  width='18%'>��ʵ����</td>
        <td >
            <input name="ISDNNO" type="text"  id="ISDNNO" maxlength='11' style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)' v_must=1 v_type=0_9 v_minlength=1 v_maxlength=12  onblur="checkElement(this)">
            <font class="orange">*</font>
        </td>
         <td  class="blue">�û�����</td>
        <td>
            <input name="USERNAME" type="text"  id="USERNAME" maxlength="18">
        </td>
    </tr>
    <tr id="UserId">

        <td  class="blue">֤������</td>
        <td>
            <input name="IDCARD" type="text"  id="IDCARD" maxlength="36">
        </td>
        <td >
            <input name="addCondConfirm" type="button" class="b_text" id="addCondConfirm" value="����" onClick="call_ISDNNOINFO();">
        </td>
        <td  class="blue">�����Ӽ�¼��
            <input name="addRecordNum" type="text"  class="InputGrey" id="addRecordNum" value="" size=7 readonly>
        </td>
    </tr>
</table>
<table cellspacing="0" id="dyntb">
    <tr>
        <th>ɾ������</th>
        <th>��ʵ����</th>
        <th>�û�����</th>
        <th>֤������</th>
    </tr>
    <tr id="tr0" style="display:none">
        <td>
            <input type="checkBox" id="R0" value="">
        </td>
        <td>
            <input type="text" id="R1" value="">
        </td>
        <td>
            <input type="text" id="R2" value="">
        </td>
        <td>
            <input type="text" id="R3" value="">
        </td>
    </tr>
</table>

<%}%>
<br/>
<TABLE cellSpacing=0>
    <TR id="footer">
        <TD align=center>

        	  <%if("step1".equals(action)){%>
            <input class="b_foot" name="sure" id="sure" type=button value="ȷ��" onclick="doSubmit();"/>
            <%}else{%>
            <input name="next" id="next" class="b_foot"  type=button value="��һ��" onclick="doNext();"  disabled />
            <%}%>
            <input class="b_foot" name='clear2' id='clear2' type='button' value="���" onClick="resetJsp()" />
            <input class="b_foot" name="close2"  onClick="removeCurrentTab()" type=button value="�ر�" />
        </TD>
    </TR>
</TABLE>

<input type='hidden' id='mobile_phone' name='mobile_phone' value='' />
<input type='hidden' id='work_no' name='work_no' value='<%=workNo%>' />
<input type='hidden' id='op_code' name='op_code' value='<%=opCode%>' />
<input type='hidden' id='org_code' name='org_code' value='<%=orgCode%>' />
<input name="ZHWW" type="hidden" id="ZHWW" value="0">
<input name="phone_type" type="hidden" id="phone_type" value="0">
<input type="hidden" name="tmpR1" id="tmpR1" value="">
<input type="hidden" name="tmpR2" id="tmpR2" value="">
<input type="hidden" name="tmpR3" id="tmpR3" value="">
<input type='hidden' id='op_note' name='op_note' />
<input type='hidden' id='iccid' name='iccid' value='<%=iccid%>'/>
<input type='hidden' id='product_name' name='product_name' value='<%=productName%>'/>
<input type='hidden' id='grp_name' name='grp_name' />
<input type='hidden' id='sysAccept' name='sysAccept' value='<%=sysAccept%>' />
<jsp:include page="/npage/common/pwd_comm.jsp"/>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>