<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
        String opCode = "6842";
        String opName = "�°����Ʒͳһ����";

				String opt_flag = request.getParameter("opt_flag");

        String orgCode = (String) session.getAttribute("orgCode");
        String strRegionCode = orgCode.substring(0, 2);
        String loginName = (String)session.getAttribute("workName");
        String phoneNo = activePhone;

        String strConAwardCode = "";
        String strConAwardDetailCode = "";
        String strConAwardName = "";
        String strConDetailName = "";
        String ConprintAccept = "";

        /****�õ���ӡ��ˮ****/
        String strLoginAccept = "";

        String retFlag="";
        String f6842RetMsg = "";
        String bp_name = "";
        String IccId = "";
        String cust_address = "";
        String passwordFromSer = "";

        Map map = (Map)session.getAttribute("contactInfoMap");
        ContactInfo contactInfo = (ContactInfo) map.get(phoneNo);
        String con_user_passwd = (contactInfo == null) ? "" : contactInfo.getPasswdVal(2); //2����|1���֤|0�������

        String loginNo = (String)session.getAttribute("workNo");
        String loginNoPass = (String)session.getAttribute("password");
        String strOpCode = request.getParameter("change_code")==null?"6842":request.getParameter("change_code");

        String[] paraAray1 = new String[4];
        paraAray1[0] = activePhone;     /* �ֻ�����*/
        paraAray1[1] = strOpCode;       /* ��������*/
        paraAray1[2] = loginNo;         /* ��������*/
        paraAray1[3] = loginNoPass;     /* ��������*/
        for(int i=0;i<paraAray1.length;i++){
        	System.out.println("paraAray1["+i+"]="+paraAray1[i]);
        }
%>
        <wtc:service name="s6842Sel" routerKey="phone" routerValue="<%=activePhone%>" outnum="19" >
            <wtc:param value="<%=paraAray1[0]%>"/>
            <wtc:param value="<%=paraAray1[1]%>"/>
            <wtc:param value="<%=paraAray1[2]%>"/>
            <wtc:param value="<%=paraAray1[3]%>"/>
        </wtc:service>
        <wtc:array id="s6842SelArr" scope="end"/>
<%
        
        int errCode = retCode==""?999999:Integer.parseInt(retCode);
        String errMsg = retMsg;
        if(s6842SelArr == null){
          retFlag = "1";
          f6842RetMsg = "s6842Sel��ѯ���������ϢΪ��!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
        }else if (errCode != 0 && (opt_flag == null || !opt_flag.equals("search"))){
        	System.out.println("---liujian----7516");
          retFlag = "1";
          f6842RetMsg = "s6842Sel��ѯ�û�����Ʒͳһ������Ϣʧ��!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
        }
%>
        <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="sLoginAccept"/>
<%
      strLoginAccept = sLoginAccept;
      String loginNote="";
      String sqlStrNote = "select back_char1 from snotecode where region_code='"+strRegionCode+"' and op_code='XXXX'";
%>
      <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=activePhone%>" outnum="1">
      <wtc:sql><%=sqlStrNote%></wtc:sql>
      </wtc:pubselect>
      <wtc:array id="resultNote" scope="end"/>
<%

      for(int i=0;i<resultNote.length;i++){
         loginNote = (resultNote[i][0]).trim();
      }
      loginNote = loginNote.replaceAll("\"","");
      loginNote = loginNote.replaceAll("\'","");
      loginNote = loginNote.replaceAll("\r\n","   ");
      loginNote = loginNote.replaceAll("\r","   ");
      loginNote = loginNote.replaceAll("\n","   ");
      System.out.println("@@@@@@@@@loginNote="+loginNote);

      String runName="";
      //String sqlStrNote1 = "select  run_name from dcustmsg a ,sruncode b where substr(a.run_code,2,1)=b.run_code and substr(a.belong_code,1,2)=b.region_code and a.phone_no='"+phoneNo+"'";
%>
            
            	
        <wtc:service name="sQryRunName" routerKey="regionCode" routerValue="<%=strRegionCode%>" retcode="errCodeGetCust" retmsg="errMsgGetCust"  outnum="2" >
		      <wtc:param value="<%=strLoginAccept%>"/>
		      <wtc:param value="01"/>
		      <wtc:param value="<%=strOpCode%>"/>
		      <wtc:param value="<%=loginNo%>"/>
		      <wtc:param value="<%=loginNoPass%>"/>
		      <wtc:param value="<%=phoneNo%>"/>
		      <wtc:param value=""/>
		      <wtc:param value=""/>
		      <wtc:param value=""/>
		      <wtc:param value="<%=strRegionCode%>"/>
  			</wtc:service>
    
				<wtc:array id="resultGetRun" scope="end" >
				</wtc:array>
<%
      for(int i=0;i<resultGetRun.length;i++){
         runName = (resultGetRun[i][0]).trim();
      }
			System.out.println("gaopeng@@@@@@@@@runName="+runName);
%>

			<!-- 2013/07/23 14:12:23 gaopeng ����BOSSϵͳ��ѯ�ͻ�������ع����Ż�������  -->
  	<wtc:service name="sUserCustInfo" routerKey="regionCode" routerValue="<%=strRegionCode%>" retcode="errCodeGetCust" retmsg="errMsgGetCust"  outnum="41" >
      <wtc:param value="<%=strLoginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=strOpCode%>"/>
      <wtc:param value="<%=loginNo%>"/>
      <wtc:param value="<%=loginNoPass%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="����phone_no:[<%=phoneNo%>]���в�ѯ"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  	</wtc:service>
    
		<wtc:array id="resultGetCust" scope="end" >
		</wtc:array>

<%
    
    if(resultGetCust!=null&&resultGetCust.length>0){
          bp_name = (resultGetCust[0][5]).trim();
          IccId = (resultGetCust[0][13]).trim();
          cust_address = (resultGetCust[0][11]).trim();
          passwordFromSer = (resultGetCust[0][40]).trim();
          System.out.println("gaopeng@@@@@@@@@bp_name="+bp_name);
          System.out.println("gaopeng@@@@@@@@@IccId="+IccId);
          System.out.println("gaopeng@@@@@@@@@cust_address="+cust_address);
          System.out.println("gaopeng@@@@@@@@@passwordFromSer="+passwordFromSer);
    }

 	 if (bp_name.equals(""))
  	{
        retFlag = "1";
      f6842RetMsg = "�û����������ϢΪ�ջ򲻴���!<br>";
    }
%>
<script language="JavaScript">
    var rownum=0;
  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=f6842RetMsg%>");
  <%}%>
</script>











<head>
<%@ include file="../../npage/s6842/head_2266_javascript_new.htm" %>
<title>����Ʒͳһ����</title>
<script language=javascript>
var pwdFlag = "false";

onload = function()
{
    //diling add 
    $("#televisionCardNo").val("");
    $("#televisionCardFlag").val("");
    
    //�������Ϊ��,��رմ�ҳ��
    if (<%=activePhone%>==null||<%=activePhone%>==""||document.all.phone_no.value.trim().len() == 0) {
        parent.removeTab('<%=opCode%>');
        return false;
    }
    var code = '<%=strOpCode%>';
    if (code==6842)
    {
        document.frm.opFlag[0].checked=true;
        document.getElementById('detailList').style.display = "";   // ������ϸ
        document.all.backList.style.display = "none"; // ����
    }
    else if(code==7515)
    {
        document.frm.opFlag[1].checked=true;
        document.getElementById('detailList').style.display = "";
        document.all.backList.style.display = "none";
    }
    else if(code==7514)
    {
        document.frm.opFlag[3].checked=true;
        document.getElementById('detailList').style.display = "none";
        document.all.backList.style.display = "";
    }
    self.status = "";
    listtype();
    beforePrompt();
    
    var opt_flag = '<%=opt_flag%>';
		if(opt_flag == 'search' ) {
				$('#typeSearch').click();
		}
		
}


//�ռ��ص�ʱ���жϺ����Ƿ��ǰ׿ͻ�
function listtype()
{
    var myPacket = new AJAXPacket("f6842list.jsp", "���ڲ�ѯ�ͻ���Ϣ�����Ժ�......");
    myPacket.data.add("phone_no", document.frm.phone_no.value.trim());
    core.ajax.sendPacket(myPacket);
    myPacket = null;
}

//begin add by huangrong on 2010-11-24 18:31
function changeCardAddr(obj){
	rdShowMessageDialog("�����ɹ���",2);	
}
function getPhoto()
{
	window.open("../innet/fgetIccIdPhoto.jsp?idIccid="+document.all.IccId.value,"","width="+(screen.availWidth*1-900)+",height="+(screen.availHeight*1-500) +",left=450,top=240,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
}
//end add by huangrong on 2010-11-24 18:31

function doProcess(packet)
{
    var vRetPage = packet.data.findValueByName("rpc_page");

    if (vRetPage == "awarddetailname") {
        var triListData = packet.data.findValueByName("detailcode");
        var triList = new Array(triListData.length);
        triList[0] = "detailcode";

        if (triListData == "") {
            rdShowMessageDialog("û�н�Ʒ�����ϸ���ݣ�");
            triListData = "";

            document.all("detailcode").length = 0;
            document.all("detailcode").options.length = 1;
            document.all("detailcode").options[0].text = "*��ѡ��*";
            document.all("detailcode").options[0].value = "0000";
            return;
        }

        document.all("detailcode").length = 0;
        document.all("detailcode").options.length = triListData.length + 1;
        document.all("detailcode").options[0].text = "*��ѡ��*";
        document.all("detailcode").options[0].value = "0000";

        for (i = 0; i < triListData.length; i++) {
            document.all("detailcode").options[i + 1].text = triListData[i][1];
            document.all("detailcode").options[i + 1].value = triListData[i][0];
        }

        document.all("detailcode").options[0].selected = true;
    } else if (vRetPage == "awardresname") {
        var triListData = packet.data.findValueByName("res_name");

        var triList = new Array(triListData.length);
        triList[0] = "res_name";

        if (triListData == "") {
            rdShowMessageDialog("û�н�Ʒ�����ϸ���ݣ�");
            triListData = "";

            document.all("rescode").length = 0;
            document.all("rescode").options.length = 1;
            document.all("rescode").options[0].text = "*��ѡ��*";
            document.all("rescode").options[0].value = "0000";
            return;
        }

        document.all("rescode").length = 0;
        document.all("rescode").options.length = triListData.length + 1;
        document.all("rescode").options[0].text = "*��ѡ��*";
        document.all("rescode").options[0].value = "0000";

        for (i = 0; i < triListData.length; i++) {
            document.all("rescode").options[i + 1].text = triListData[i][1];
            document.all("rescode").options[i + 1].value = triListData[i][0];
        }

        document.all("rescode").options[0].selected = true;
    } else if (vRetPage == "awardresgradename") {
        var triListData = packet.data.findValueByName("res_grade_name");

        var triList = new Array(triListData.length);
        triList[0] = "res_grade_name";

        if (triListData == "") {
            rdShowMessageDialog("û�н�Ʒ�ȼ���Ϣ���ݣ�");
            triListData = "";

            document.all("res_grade_code").length = 0;
            document.all("res_grade_code").options.length = 1;
            document.all("res_grade_code").options[0].text = "*��ѡ��*";
            document.all("res_grade_code").options[0].value = "0000";
            return;
        }

        document.all("res_grade_code").length = 0;
        document.all("res_grade_code").options.length = triListData.length + 1;
        document.all("res_grade_code").options[0].text = "*��ѡ��*";
        document.all("res_grade_code").options[0].value = "0000";

        for (i = 0; i < triListData.length; i++) {
            document.all("res_grade_code").options[i + 1].text = triListData[i][1];
            document.all("res_grade_code").options[i + 1].value = triListData[i][0];
        }

        document.all("rescode").options[0].selected = true;
    }
     else if (vRetPage == "phoneqry") {
        var vCustName = packet.data.findValueByName("cust_name");
        var vIdiccid = packet.data.findValueByName("id_iccid");
        var vIdAddress = packet.data.findValueByName("id_address");
        var vReturnCode = "999999";
        vReturnCode = packet.data.findValueByName("return_code");
        var vReturnMsg = packet.data.findValueByName("return_msg");
        var smName = packet.data.findValueByName("smName");


        if (vReturnCode == "000000") {
            document.all.cust_name.value = vCustName;
            document.all.id_iccid.value = vIdiccid;
            document.all.id_address.value = vIdAddress;
            document.all.smName.value = smName;
            document.frm.confirm.disabled = false;
                        rdShowMessageDialog(vReturnMsg,2);
            return true;
        } else {
            rdShowMessageDialog(vReturnMsg);
            document.all.phone_no.focus();
            document.all.confirm.disabled = true;
            return false;
        }
    }
    else if (vRetPage == "listqry") {
        var vReturnCode = "999999";
        vReturnCode = packet.data.findValueByName("return_code");
        var vReturnMsg = packet.data.findValueByName("return_msg");
        if (vReturnCode == "000000") {
            var liststr = packet.data.findValueByName("liststr");
            if (liststr != "a"&&'<%=request.getParameter("change_code")==null?"1":"2"%>'=='1') {
                rdShowMessageDialog(liststr);
            }

            return true;
        } else {
            rdShowMessageDialog(vReturnMsg);
            return false;
        }
    }else  if (vRetPage == "phonepasswd") {
        var vRetResult = packet.data.findValueByName("retResult");
        if (retResult == "000000") {
            rdShowMessageDialog("��������׼ȷ��");
            document.all.confirm.disabled = false;
            return true;
        } else {
            rdShowMessageDialog("��������������������룡");
            document.all.cus_pass.focus();
            document.all.confirm.disabled = true;
            return false;
        }
    } else if (vRetPage == "loginacceptqry") {
        var vCheckFlag = packet.data.findValueByName("check_flag");
        if (vCheckFlag == "1") {
            rdShowMessageDialog("�û���ˮ������֤�ɹ�");
            document.all.confirm.disabled = false;
            return true;
        } else if (vCheckFlag == "2") {
            rdShowMessageDialog("�û�û�пɶҽ����ݣ�");
            document.all.loginaccepttext.focus();
            document.all.confirm.disabled = true;
            return false;
        } else {
            rdShowMessageDialog("�û���ˮ������֤ʧ��");
            document.all.confirm.disabled = true;
            return false;
        }
    } else if(vRetPage == "grade_code"){ //��ѯ
    		var triListData = packet.data.findValueByName("detailcode");
        var triList = new Array(triListData.length);
        triList[0] = "grade_code";

        if (triListData == "") {
            rdShowMessageDialog("û�еȼ�����!");
            triListData = "";

						//document.all("queryaward").selectedIndex = 0;
						document.all("detailcodeList").selectedIndex = 0;
						document.all("detailcode").length = 0;
            document.all("detailcode").options.length = 1;
            document.all("detailcode").options[0].text = "*��ѡ��*";
            document.all("detailcode").options[0].value = "0000";
            document.all("grade_code").length = 0;
            document.all("grade_code").options.length = 1;
            document.all("grade_code").options[0].text = "*��ѡ��*";
            document.all("grade_code").options[0].value = "0000";
            return;
        }

        document.all("grade_code").length = 0;
        document.all("grade_code").options.length = triListData.length + 1;
        document.all("grade_code").options[0].text = "*��ѡ��*";
        document.all("grade_code").options[0].value = "0000";

        for (i = 0; i < triListData.length; i++) {
            document.all("grade_code").options[i + 1].text = triListData[i][1];
            document.all("grade_code").options[i + 1].value = triListData[i][0];
        }

        document.all("grade_code").options[0].selected = true;
    }
}

function showPrtDlg(printType, DlgMessage, submitCfm, varPrintInfo)
{  //��ʾ��ӡ�Ի���
    var h = 210;
    var w = 400;
    var t = screen.availHeight / 2 - h / 2;
    var l = screen.availWidth / 2 - w / 2;

    var pType="subprint";
    var billType="1";
    var sysAccept = "<%=strLoginAccept%>";
    var printStr = printInfo(varPrintInfo);

    var mode_code=null;
    var fav_code=null;
    var area_code=null
  	/*alert("<%=strOpCode%>");*/
    /* liujian 2012-3-13 10:11:34 ��ɨ�����֤�޸ĳɹ������� begin */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* liujian 2012-3-13 10:11:34 ��ɨ�����֤�޸ĳɹ������� end */
    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    // liujian 2012-3-13 10:11:34 ��ɨ�����֤�޸ĳɹ������� �޸�jsp
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
    var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=strOpCode%>&sysAccept="+sysAccept+"&phoneNo=<%=activePhone%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret = window.showModalDialog(path, printStr, prop);

    return ret;
}

function printInfo(varPrintInfo)
{
	//rdShowMessageDialog("printInfo");
    var i = 0;
    var varPhoneNo = "";      //�ֻ�����
    var varLoginName = "";  //��������
    var varUserName = "";   //�û�����
    var varUserId = "";       //�û�ID
    var varUserAddress = "";//�û���ַ
    var varOpCode = "";         //��������
    var varLoginAccept = "";//������ˮ
    var varAwardName = "";  //��Ʒ����
    var varOpNote = "";     //������ע
    var vResCodeSum = "";     //�콱����
    var vPrintCont = "";    //��̬��ӡ����
    var vPrintName = "";    //��̬��ӡ������
    var vPrintSum = "";     //��̬��ӡ������

    for (; varPrintInfo.indexOf("|") > 0;)
    {
        varString = varPrintInfo.substring(0, varPrintInfo.indexOf("|"));
        i++;
        switch (i)
                {
            case 1:
                varLoginName = varString;
                break;
            case 2:
                varPhoneNo = varString;
                break;
            case 3:
                varUserName = varString;
                break;
            case 4:
                varUserId = varString;
                break;
            case 5:
                varUserAddress = varString;
                break;
            case 6:
                varOpCode = varString;
                break;
            case 7:
                varLoginAccept = varString;
                break;
            case 8:
                varAwardName = varString;
                break;
            case 9:
                varOpNote = varString;
                break;
            case 10:
                vResCodeSum = varString;
                break;
            case 11:
                vPrintCont = varString;
                break;
        }
        varPrintInfo = varPrintInfo.substring(varPrintInfo.indexOf("|") + 1, varPrintInfo.length);
    }

    var retInfo = "";
    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";
    var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//�õ�ִ��ʱ��

    cust_info += "�ֻ����룺" + varPhoneNo + "|";
    cust_info += "�ͻ�������" + varUserName + "|";
    cust_info += "֤�����룺" + varUserId + "|";
    cust_info += "�ͻ���ַ��" + varUserAddress + "|";


    opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "  " + "�û�Ʒ��: " + document.all.smName.value + "|";

	/* liyan 0412*/
	//rdShowMessageDialog("varOpCode="+varOpCode);
    if (varOpCode == "6842") {
        opr_info += "����ҵ��: " + "����Ʒͳһ����" + "  ������ˮ: " + varLoginAccept + " ��Ʒ�Ѿ���ȡ" + "|";
    } else if (varOpCode == "7515") {
        opr_info += "����ҵ��: " + "����Ʒͳһ����ԤԼ�Ǽ�" + "  ������ˮ: " + varLoginAccept + " ��Ʒ�Ѿ��Ǽ�" + "|";
    } else if (varOpCode == "7514") {
        opr_info += "����ҵ��: " + "����Ʒͳһ��������" + "  ������ˮ: " + varLoginAccept + " ��Ʒ�Ѿ�����" + "|";
    }

    if (0 == vPrintCont.length) {
        opr_info += "��Ʒ����: " + varAwardName + "+ ��Ʒ����: " + vResCodeSum + "|";
    } else {
        i = 0;
        for (; vPrintCont.indexOf("~") > 0;)
        {
            varString = vPrintCont.substring(0, vPrintCont.indexOf("~"));
            i++;
            switch (i)
                    {
                case 1:
                    vPrintName = varString;
                    break;
                case 2:
                    vPrintSum = varString;
                    opr_info += "��Ʒ����: " + vPrintName + "+ ��Ʒ����: " + vPrintSum + "|";
                    opr_info+=vPrintName+"~"+vPrintSum + "��;";
                    i = 0;
                    break;
            }

            vPrintCont = vPrintCont.substring(vPrintCont.indexOf("~") + 1, vPrintCont.length);
        }
        opr_info+="|";
    }
    note_info1 += "��ע: " + varOpNote + "|";
    document.all.cust_info.value = cust_info + "#";
    document.all.opr_info.value = opr_info + "#";
    document.all.note_info1.value = note_info1 + "#";
    document.all.note_info2.value = note_info2 + "#";
    document.all.note_info3.value = note_info3 + "#";
    document.all.note_info4.value = note_info4 + "#";
    //retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");


    return retInfo;
}

function phonequery()
{
    var awardcode = "";
    var op_code=$("input[@name=opFlag][@checked]").val();
    if(document.frm.opFlag[2].checked||document.frm.opFlag[3].checked)
    {
        for(var i =0;i<document.frm.opFlag.length;i++)
        {
            if (document.frm.opFlag[i].checked== true )
            {
                awardcode = document.frm.opFlag[i].value;
                break;
            }
        }
    }
    else if(document.frm.opFlag[1].checked)
    {
        //awardcode = document.frm.queryaward.value;
    }

    //����������������֤������ˮ
    if (op_code=="6842")
    {
        var detailcode = document.all.detailcode[document.all.detailcode.selectedIndex].value;
        if (awardcode == "02" && (detailcode == "0309" || detailcode == "0501"))
        {
            if (document.all.loginaccepttext.value == "")
            {
                rdShowMessageDialog("��������֤��ˮ����!");
                return false;
            }
        }

    }

    if (document.frm.phone_no.value.length == 0)
    {
        rdShowMessageDialog("������벻��Ϊ�գ����������� !");
        document.frm.phone_no.focus();
        return false;
    }

    if (document.frm.res_grade_code.value == "00000000")
    {
        rdShowMessageDialog("��ѡ��Ʒ�ȼ� !");
        document.frm.res_grade_code.focus();
        return false;
    }

    if(parseInt(document.frm.res_grade_code.value)==0)
    {
        rdShowMessageDialog("��ѡ��Ʒ�ȼ� !");
        document.frm.res_grade_code.focus();
        return false;
    }

    if (document.frm.runName.value != "����")
    {
        rdShowMessageDialog("���û�������״̬���޷�����!");
        document.frm.res_grade_code.focus();
        return false;
    }

    var myPacket = new AJAXPacket("f6842phoneqry.jsp", "���ڲ�ѯ�ͻ���Ϣ�����Ժ�......");
    myPacket.data.add("phone_no", document.frm.phone_no.value.trim());
    myPacket.data.add("award_code", awardcode);
    myPacket.data.add("detail_code", document.all.detailcode[document.all.detailcode.selectedIndex].value.trim());
    myPacket.data.add("grade_code", document.all.res_grade_code.value.trim());
    myPacket.data.add("check_login_accept", document.frm.loginaccepttext.value.trim());

    core.ajax.sendPacket(myPacket);
    myPacket = null;
}


//----------------��֤���ύ����-----------------
function doCfm()
{
    var op_code=$("input[@name=opFlag][@checked]").val();
    getAfterPrompt(op_code);
    var vConPhoneNo = document.all.phone_no.value;
    if (vConPhoneNo.len() != 11)
    {
        rdShowMessageDialog("�������λ������ȷ,�����´�ҳ��!");
        parent.removeTab('<%=opCode%>');
        return false;
    }
    
    /*begin add by diling for ��ѡ����ȡ���ߵ�����Ʒʱ���ж��Ƿ���д���ӿ�����@2012/5/24*/
    var m = 0;
    var projectCodeArr = new Array(); // Ӫ��������
    if (document.frm.opFlag[0].checked){  //�콱
      for(j = 0; j < <%=s6842SelArr.length%>; j++)
      {
      if(document.getElementById('checkbox'+j).checked)
      {
      	if(document.getElementById('qRCodeFlag'+j).value == 'Y'){ continue;	}       // ��ά��Ӫ����
      	projectCodeArr[m] = document.getElementById('projectCode'+j).value;
      	m++;
      }
      }
      var televisionCardNo = $("#televisionCardNo").val(); //���ߵ��ӿ�����
      var televisionCardStr ="";
      for(var z=0;z<projectCodeArr.length;z++){
        televisionCardStr = projectCodeArr[z];
        if(televisionCardStr=="279652"){
            if(televisionCardNo.length<7){
                rdShowMessageDialog("��������ӿ����ţ��ٽ����ύ!");
                //window.location.href="f6842.jsp?activePhone=<%=activePhone%>&change_code=6842";
                return false;
            }
        }
      }
    }
    /*end add by diling*/

	var type_code  = document.all.queryaward.value;    //���ʹ���
    var project_code = document.all.detailcode.value;  //Ӫ��������
    var grade_code = document.all.grade_code.value;    //�ȼ�����

    var rescode = document.all.rescode[document.all.rescode.selectedIndex].value;
    var vResCodeSum = document.all.rescode_sum.value;
    var res_grade_code = document.all.res_grade_code[document.all.res_grade_code.selectedIndex].value;

    if (document.frm.runName.value != "����")
    {
        rdShowMessageDialog("���û�������״̬���޷�����!");
        document.frm.back.focus();
        return false;
    }
    //if (document.frm.opFlag[2].checked||document.frm.opFlag[3].checked){}/*��������������*/
    if (document.frm.opFlag[0].checked)     //�콱
    {
        if(!checklines()) { return false; }
        //setArrValue();
        document.all.confirm.disabled = true;
        printCommit('0');
    }
    else if (document.frm.opFlag[1].checked)//ԤԼ�Ǽ�
    {
        if(document.frm.queryaward.value=="0000")
        {
            rdShowMessageDialog("��ѡ��Ʒ���");
            return false;
        }
        if (project_code == "0000")
        {
            rdShowMessageDialog("��ѡ��Ӫ����");
            return false;
        }
        if (grade_code == "0000")
        {
            rdShowMessageDialog("��ѡ��ȼ�");
            return false;
        }
        /*if(document.frm.queryaward.value=="02"||document.frm.queryaward.value=="03") {}//������������*/
        frm.action = "f6842_query.jsp?opcode=7514&phone_no=<%=activePhone%>";
        frm.submit();
    }
    else if (document.frm.opFlag[2].checked)  //��ѯ
    {
        document.all.confirm.disabled = true;
        frm.action = "f6842_query_history.jsp?awardcode="+document.all.queryaward.value+"&grade_code="+grade_code;
        frm.submit();
    } else if (document.frm.opFlag[3].checked)//����
    {
        var backMain = document.getElementsByName("backMain");
        for(var i=0;i<backMain.length;i++)
        {
            if(backMain[i].checked) { break; }
            if(i==(backMain.length-1))
            {
                rdShowConfirmDialog("��ѡ��һ��������ˮ!");
                return false;
            }
        }
        document.all.confirm.disabled = true;
        printCommit('1');
    }
}

//��������
function changradio()
{
		if(document.frm.opFlag[0].checked==true) // �콱
    {
        frm.action = "f6842.jsp?activePhone=<%=activePhone%>&change_code=6842";
        frm.submit();
    }else
    if(document.frm.opFlag[1].checked==true) // ԤԼ�Ǽ�
    {
        //document.all.queryaward.selectedIndex=0;
        document.all.detailcode.selectedIndex = 0;
        document.all.rescode.selectedIndex = 0;
        document.all.condition_display.style.display = "none";
        document.all.condition_grade_display.style.display = "none";
        document.all.detailcodeList.style.display = "";
        //document.all.workList.style.display = "none";
        document.all.detailList.style.display = "none";
        document.all.detailList_title.style.display = "none";
        document.all.checkloginaccept.style.display = "none";
        document.all.backList.style.display = "none";
        document.all.phonenofiled.style.display = "none";
        document.all.queryawardList.style.display="";
        document.all.gradeCodeList.style.display="";
        document.getElementById("backinfodis").style.display="none";
    }else
    if(document.frm.opFlag[2].checked==true) //��ѯ
		{
		    document.all.detailcode.selectedIndex = 0;
		    document.all.rescode.selectedIndex = 0;
		    document.all.detailcodeList.style.display = "";
		    document.all.queryawardList.style.display="";
		    document.all.gradeCodeList.style.display="";

		    document.all.condition_display.style.display = "none";
		    document.all.condition_grade_display.style.display = "none";
		    //document.all.workList.style.display = "none";
		    document.all.detailList.style.display = "none";
		    document.all.detailList_title.style.display = "none";
		    document.all.checkloginaccept.style.display = "none";
		    document.all.backList.style.display = "none";
		    document.all.phonenofiled.style.display = "none";
		    document.getElementById("backinfodis").style.display="none";
		}else
		if(document.frm.opFlag[3].checked == true) // ����
    {
        frm.action = "f6842.jsp?activePhone=<%=activePhone%>&change_code=7514";
        frm.submit();
    }
    beforePrompt();
}

function selectGradeCode(){
	document.all.confirm.disabled = false;
  document.all.grade_code.selectedIndex = 0;
  //document.all.rescode.selectedIndex = 0;
  document.all.condition_display.style.display = "none";
  document.all.condition_grade_display.style.display = "none";
  document.all.detailcodeList.style.display = "";
  //document.all.workList.style.display = "none";
  document.all.detailList.style.display = "none";
  document.all.detailList_title.style.display = "none";
  document.all.checkloginaccept.style.display = "none";
  document.all.backList.style.display = "none";
  document.all.phonenofiled.style.display = "none";
  document.all.queryawardList.style.display="";
  document.getElementById("backinfodis").style.display="none";
  var project_code = document.all.detailcode[document.all.detailcode.selectedIndex].value;
  var regioncode = "<%=strRegionCode%>";
  var myPacket = new AJAXPacket("f6842DetailName.jsp", "��ѯ��Ʒ�����ϸ,���Ե�...");
  myPacket.data.add("isFlag", "G");
  myPacket.data.add("project_code", project_code);
  myPacket.data.add("regioncode", regioncode);
  core.ajax.sendPacket(myPacket);
  myPacket = null;
}

function changeawardcode()
{
    //if(false && (document.all.queryaward.value=="02"||document.all.queryaward.value=="03")&&document.frm.opFlag[1].checked==true) {}//������������

    document.all.confirm.disabled = false;
    document.all.detailcode.selectedIndex = 0;
    document.all.rescode.selectedIndex = 0;
    document.all.condition_display.style.display = "none";
    document.all.condition_grade_display.style.display = "none";
    document.all.detailcodeList.style.display = "";
    //document.all.workList.style.display = "none";
    document.all.detailList.style.display = "none";
    document.all.detailList_title.style.display = "none";
    document.all.checkloginaccept.style.display = "none";
    document.all.backList.style.display = "none";
    document.all.phonenofiled.style.display = "none";
    document.all.queryawardList.style.display="";
    document.getElementById("backinfodis").style.display="none";
    //var queryaward = document.all.queryaward[document.all.queryaward.selectedIndex].value;
    var type_code_arr = document.getElementsByName('project_type');
    var queryaward = "";
    for(var i=0;i<type_code_arr.length;i++){
    	if(type_code_arr[i].checked){
    		queryaward += type_code_arr[i].value + "%";
    	}
		}
		document.getElementById('queryaward').value=queryaward;

    var regioncode = "<%=strRegionCode%>";
    var myPacket = new AJAXPacket("f6842DetailName.jsp", "��ѯ��Ʒ�����ϸ,���Ե�...");
    myPacket.data.add("awardcode", queryaward);
    myPacket.data.add("regioncode", regioncode);
    core.ajax.sendPacket(myPacket);
    myPacket = null;
}

/*��������������ѯ��Ʒ����*/
function changedetailcode()
{
    /*
    if (awardcode == "02" && detailcode == "0729") //������ sawarddetail

        if (awardcode == "02" && (detailcode == "0309" || detailcode == "0501" || detailcode == '0978'))
        {
            document.all.checkloginaccept.style.display = "";
            document.all.confirm.disabled = true;
            var addTextDIV = document.getElementById("add_text");
            if (detailcode == '0978')
            {
                addTextDIV.innerHTML = "�ιο��ţ�";
            }
            else
            {
                addTextDIV.innerHTML = "������ˮ��";
            }
        }
    */
}


function printCommitCondition1(awardcode)
{

    var varOpNote = "����Ʒͳһ����ԤԼ�Ǽ�";//������ע


    var vResName = document.all("rescode").options[document.all("rescode").selectedIndex].text
    vResName = vResName.substring(vResName.indexOf("->") + 2, vResName.length);

    var varPrintInfo = '<%=loginName%>' + "|"
            + document.all.phone_no.value.trim() + "|"
            + document.all.cust_name.value.trim() + "|"
            + document.all.id_iccid.value.trim() + "|"
            + document.all.id_address.value.trim() + "|"
            + document.all.opcode.value + "|"
            + document.all.LoginAccept.value.trim() + "|"
            + vResName + "|"
            + varOpNote + "|"
            + document.all.rescode_sum.value.trim() + "|";

    //��ӡ�������ύ��
    var ret = showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��", "Yes", varPrintInfo);

    if (typeof(ret) != "undefined")
    {
        if ((ret == "confirm"))
        {
            if (rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!') == 1)
            {
                document.all.printcount.value = "1";
                frmConCfm();
            }
        }

        if (ret == "continueSub")
        {
            if (rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��') == 1)
            {
                document.all.printcount.value = "0";
                frmConCfm();
            }
        }
    }
    else
    {
        if (rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��') == 1)
        {
            document.all.printcount.value = "0";
            frmConCfm();
        }
    }

    return true;
}



function beforePrompt(){
    var op_code=$("input[@name=opFlag][@checked]").val();
    var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","���Ժ�...");
    packet.data.add("opCode" ,op_code);
    core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//�첽
    packet =null;
}
function doGetBeforePrompt(data)
{
    $('#wait').hide();
    $('#beforePrompt').html(data);
}
function getAfterPrompt(op_code)
{
    var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","���Ժ�...");
    packet.data.add("opCode" ,op_code);
    core.ajax.sendPacket(packet,doGetAfterPrompt,false);//ͬ��
    packet =null;
}

function doGetAfterPrompt(packet)
{
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    if(retCode=="000000"){
        promtFrame(retMsg);
    }
}

//liyan getItem
function getItem(projectCode,num,gradeCode,packetCode)
{
    var prop="dialogHeight:600px; dialogWidth:750px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
    var opcode=$("input[@name=opFlag][@checked]").val();
    //��ѯ��Ʒ�б�
    var ret = window.showModalDialog("./f6842_getItem.jsp?packetCode="+packetCode+"&projectCode="+projectCode+"&phoneno=<%=activePhone%>&num="+num+"&opcode="+opcode+"&gradeCode="+gradeCode,"",prop);
    if(ret!=undefined){
    	//�ڼ���%����%����%����%������
    	var arr = ret.split("%");
    	var lineNum = arr[0];
    	document.getElementById('cardNo'+lineNum).value      = arr[3];
    	document.getElementById('packageCode'+lineNum).value = arr[4];
    	//document.getElementById("ResName"+lineNum).value     = arr[1];
    	document.getElementById("ResName"+lineNum).value     = arr[5];
    	document.getElementById("ResNum"+lineNum).value     = arr[2]; //����
    	document.getElementById("giftName_all"+lineNum).value=arr[5]; //��Ʒ���Ƽ���
    	document.getElementById("giftName_sum"+lineNum).value=arr[2]; //��Ʒ��������
    	/*rdShowMessageDialog("arr[2]="+arr[2]);
    	rdShowMessageDialog("arr[5]="+arr[5]);
    	rdShowMessageDialog("arr[6]="+arr[6]);*/
    	//+",arr[2]="+arr[4]+"+",arr[3]="+arr[3]+",arr[4]="+arr[4]+",arr[5]="+arr[5]+",arr[6]="+arr[6]);
    	//rdShowMessageDialog��document.getElementById("ResNum"+lineNum).value);
    }
    /*** begin update diling for �ȴ��б���ѡ���Ʒ����ѡ����ȡ���ߵ��Ӳ�Ʒ������������ӿ�����@2012/5/21 ***/
    if(projectCode=="279652"){
      var prop1="dialogHeight:200px; dialogWidth:750px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
      var retTelevisionCardNo = window.showModalDialog("./f6842_getTelevisionCard.jsp?packetCode="+packetCode+"&projectCode="+projectCode+"&phoneno=<%=activePhone%>&num="+num+"&opcode="+opcode+"&gradeCode="+gradeCode,"",prop1);
      //alert(retTelevisionCardNo);
      if(retTelevisionCardNo!=undefined){
        $("#televisionCardNo").val(retTelevisionCardNo);
        //alert("����ֵ�ˣ�"+$("#televisionCardNo").val());
      }else{ //������
        $("#televisionCardNo").val("");
        //alert("��棺"+ $("#televisionCardNo").val());
      }
    }
    /*** end update diling @2012/5/21 ***/
}

//����¼�Ƿ��Ѿ��ɹ�����
function checklines()
{
	var flag = 0; // ѡ����Ʒ������
	for(var i=0; i<<%=s6842SelArr.length%>; i++)
	{
	  a=i+1;
		if(document.getElementById("checkbox"+i).checked)
		{
			if(document.getElementById("checkbox"+i).value == 'QRCODE'){
				continue;
			}
			var vFlag = document.getElementById("getFlag"+i).value;
			if(vFlag=="O")                                       // δ�����
			{
					rdShowMessageDialog("��"+a+"�н�Ʒ�ڹ涨ʱ�䷶Χ��δ��ȡ,���Ѿ�������ȡ��");
					return false;
			}
			if (document.all.opcode.value=="7515" && vFlag=="R") // �ѵǼ�  δʵ��2010-1-28 16:24:45
			{
				rdShowMessageDialog("��"+a+"�д���Ʒ�ѵǼǹ�!");
				return false;
			}

			var card_no = document.getElementById("cardNo"+i);
			var typeArr = document.getElementById("cardType"+i).value.split('#');
			for(k = 0; k < typeArr.length; k++){
				if(typeArr[k] != '' && typeArr[k] !='-1' && (card_no==null || card_no.value=="")){//�ǿ�����û�п���
					rdShowMessageDialog("��"+a+"��û�����뿨�ţ���������'��ѯ'��ť!");
					return false;
				}
			}
      flag++;
		}
	}

	if(flag==0)
	{
		rdShowMessageDialog("��ѡ��һ���콱��¼!");
		return false;
	}
	if(flag>20)
	{
    rdShowMessageDialog("��ѡ����"+flag+"�����콱�������ܳ���20��!");
		return false;
	}
	return true;
}

/*��ѯ�ֻ���ֵ��*/
function checkCard()
{
    var prop="dialogHeight:300px; dialogWidth:550px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
    card_num = parseInt(document.forms[0].cardNum.value);
    if(card_num == -1)
    {
        card_num = document.forms[0].rescode_sum.value;
    }
    card_type = document.forms[0].cardType.value;
    var ret = window.showModalDialog("./f6842_query_card.jsp?card_num="+card_num+"&card_type="+card_type,"",prop);
    if(ret)
    {
        document.all.card_no.value = ret;
    }
}

//���� acceptΪ�����콱��ˮ2010-1-28 10:35:35
function getBackinfo(accept)
{
		//alert("accept"+accept);
    var tab=document.getElementById("backinfo");
    for(var a=1;a<=rownum;a++)
    {
        tab.deleteRow(1);
    }
    document.frm.backaccept.value=accept;
    var myPacket = new AJAXPacket("f6842_back_rpc.jsp", "��ѯ��Ʒ�����ϸ,���Ե�...");
    myPacket.data.add("accept", accept);
    myPacket.data.add("activePhone", "<%=activePhone%>");
    core.ajax.sendPacket(myPacket,showBackInfo);
    myPacket = null;
}


function showBackInfo(packet)
{
    document.getElementById("backinfodis").style.display="";
    var errorflag = packet.data.findValueByName("errorflag");
    var errorMsg = packet.data.findValueByName("errorMsg");
    if(errorflag == false)
    {
        rdShowConfirmDialog(errorMsg);
		return false;
    }
    rownum = packet.data.findValueByName("rownum");
    var returnArr = new Array();
    returnArr = packet.data.findValueByName("value");//����ֵ

    var tab=document.getElementById("backinfo");
    var i;
    var j;

    var ResNameArr = "";
    var ResNameArr111 = "";
 /*
 *    Ӫ��������
 *		Ӫ��������
 *    Ӫ�����ȼ�����
 *    Ӫ�����ȼ�����
 *    ��Ʒ����
 *    ��Ʒ����
 *    ��Ʒ����
 *		��ȡ��־ Y �ѳ��� N δ����
 */
   for(i=0;i<rownum;i++)
   {
       var tr=tab.insertRow();

       var td1=document.createElement("td");
       td1.innerHTML=returnArr[i][0];
       td1.style.textAlign="center";

       var td2=document.createElement("td");
       td2.innerHTML=returnArr[i][2];
       td2.style.textAlign="center";

       var td3=document.createElement("td");
       td3.innerHTML=returnArr[i][4];
       td3.style.textAlign="center";

       var td4=document.createElement("td");
       td4.innerHTML=returnArr[i][6];
       td4.style.textAlign="center";

       var td5=document.createElement("td");
       td5.innerHTML=returnArr[i][7]=='Y'?'�ѳ���':'δ����';
       td5.style.textAlign="center";

	    	tr.appendChild(td1);
	    	tr.appendChild(td2);
	    	tr.appendChild(td3);
	    	tr.appendChild(td4);
	    	tr.appendChild(td5);
    		ResNameArr += returnArr[i][6];//???
    		ResNameArr111 += returnArr[i][4];//
    }

    document.frm.ResNameArr.value=ResNameArr;
    document.frm.ResNameArr111.value=ResNameArr111;


}

/*
 *@desc �ϲ�ԭ����function printCommit()��function printCommit1()
 *@parameter   typeM 1 ���� 0 �콱
 *@author wanglei
 *@date   2010-1-21 14:45:59
 */
function printCommit(typeM)
{
	getAfterPrompt();

	document.all.confirm.disabled = true;
  var varOpNote = "";//������ע
  var resInfo = "";
  var op_code=$("input[@name=opFlag][@checked]").val();

  if (op_code=="6842"){
      varOpNote = "����Ʒͳһ����";
  } else if (op_code=="7515"){
      varOpNote = "����Ʒͳһ����ԤԼ�Ǽ�";
  } else if (op_code=="7516"){
      varOpNote = "����Ʒͳһ������ѯ";
  }else{
      varOpNote = "����Ʒͳһ��������";
  }
  document.all.opcode.value = op_code;

	 //liyan ��ӡ
	//document.frm.giftNameAll.value = document.all.giftName_all[document.all.giftName_all.selectedIndex].value;
    //document.frm.giftNameSum.value = document.all.giftName_sum[document.all.giftName_sum.selectedIndex].value;

if (op_code=="6842"){
 	for(j = 0; j < <%=s6842SelArr.length%>; j++)
	{
		if(document.getElementById('checkbox'+j).checked)
		{
 			document.frm.giftNameAll.value = document.getElementById('giftName_all'+j).value;
 			document.frm.giftNameSum.value = document.getElementById('giftName_sum'+j).value;
 		}
 	}
}

//	rdShowMessageDialog(document.frm.giftNameAll.value);
	//rdShowMessageDialog(document.frm.giftNameSum.value);

	var varPrintInfo = '<%=loginName%>'+"|"
	  +document.frm.phone_no.value.trim()+"|"
	  +document.frm.cust_name.value.trim()+"|"
		+document.frm.id_iccid.value.trim()+"|"
		+document.frm.id_address.value.trim()+"|"
		+'<%=strOpCode%>'+"|"
		+document.frm.LoginAccept.value.trim()+"|";

		if(op_code!="7514") {
		varPrintInfo+=""
		+document.frm.giftNameAll.value.trim()+"|"
		+varOpNote+"|"
		+document.frm.giftNameSum.value.trim()+"|"
		+document.frm.ResNameArr.value.trim()+"|";
		}else {
		varPrintInfo+=""

		+document.frm.ResNameArr.value.trim()+"|"
		+varOpNote+"|"
		+document.frm.ResNameArr111.value.trim()+"|"
		+"|";
		
		}
			//alert(varPrintInfo);

  //��ӡ�������ύ��
  var ret = showPrtDlg1("Detail", "ȷʵҪ���е��������ӡ��", "Yes", varPrintInfo);

  if (typeof(ret) != "undefined")
  {
      if (ret == "confirm")
      {
	      	if (rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!') == 1)
	      	{
		       	req_Cfm_new_jsp("1",typeM);
	        }
      }
      if(ret == "continueSub")
      {
          if (rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��') == 1)
          {
              req_Cfm_new_jsp("0",typeM);
          }
      }
  }
  else
  {
      if (rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��') == 1)
      {
          req_Cfm_new_jsp("0",typeM);
      }
  }
}

//����f6842Cfm_new.jsp add by wanglei on 20100107 18:01
function req_Cfm_new_jsp(printCount,typeM){
	if(typeM == 1){ // ��ʼΪ����ȷ�Ϸ���ֵ...
		document.all.printcount.value = printCount;
		document.frm.action="f6842_backCfm.jsp?printAccept=<%=sLoginAccept%>&opcode=7514&phone_no=<%=activePhone%>";
    document.frm.submit();
    return;
	}
	var awardSeqArr    = new Array(); // �н���ˮ
	var gradeCodeArr   = new Array(); // �ȼ�����
	var projectCodeArr = new Array(); // Ӫ��������
	var packageCodeArr = new Array(); // ������
	var cardNoArr      = new Array(); // ����
	var awardNoteArr   = new Array(); // �콱��ע
	var m = 0;
	for(j = 0; j < <%=s6842SelArr.length%>; j++)
	{
		if(document.getElementById('checkbox'+j).checked)
		{
			if(document.getElementById('qRCodeFlag'+j).value == 'Y'){ continue;	}       // ��ά��Ӫ����
			awardSeqArr[m]    = document.getElementById('awardSeq'+j).value;
			gradeCodeArr[m]   = document.getElementById('gradeCode'+j).value;
			projectCodeArr[m] = document.getElementById('projectCode'+j).value;
			packageCodeArr[m] = document.getElementById('packageCode'+j).value;
			cardNoArr[m]      = document.getElementById('cardNo'+j).value;
			awardNoteArr[m]   = document.getElementById('awardNote'+j).value;
			m++;
		}
	}
	document.getElementById('awardSeqI').value    = awardSeqArr.join('%');
	document.getElementById('gradeCodeI').value   = gradeCodeArr.join('%');
	document.getElementById('projectCodeI').value = projectCodeArr.join('%');
	document.getElementById('packageCodeI').value = packageCodeArr.join('%');
	document.getElementById('cardNoI').value = cardNoArr.join('%');
	document.getElementById('awardNoteI').value   = awardNoteArr.join('%');

    //diling
    var televisionCardNo = $("#televisionCardNo").val(); //���ߵ��ӿ�����
    var televisionCardStr ="";
    //var projectCodeI = $("#projectCodeI").val().split("%");
    for(var z=0;z<projectCodeArr.length;z++){
        televisionCardStr = projectCodeArr[z];
        if(televisionCardStr=="279652"){
            if(televisionCardNo.length<7){
                rdShowMessageDialog("��������ӿ����ţ��ٽ����ύ!");
                return false;
            }else{
               $("#televisionCardFlag").val("279652");
            }
        }
    }
    //alert("��ʶ"+document.getElementById("televisionCardFlag").value);
    
	document.all.printcount.value = printCount;
	document.frm.action = "f6842Cfm_new.jsp?opcode=6842&phoneNo=<%=activePhone%>&televisionCardFlag="+document.getElementById("televisionCardFlag").value+"&televisionCardNo="+televisionCardNo;
	document.frm.submit();
}



// ȫѡ��Ʒ
function doChange(){
	var j;
	for(j=0;j<<%=s6842SelArr.length%>;j++){
		if(document.getElementById("regionCheck").checked && j<20){
			if(document.getElementById('qRCodeFlag'+j).value == 'Y'){continue;}
			document.getElementById("checkbox"+j).checked=true;
		}else if(document.getElementById("regionCheck").checked==false){
			document.getElementById("checkbox"+j).checked=false;
		}
	}
}
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">�û���Ϣ</div>
</div>
<table cellspacing="0">
    <tr>
        <td class="blue">�������</td>
        <td>
            <input name="phoneNo" type="text" class="InputGrey" id="phoneNo" value="<%=activePhone%>" readonly>
        <td class="blue">�ͻ�����</td>
        <td>
            <input name="bp_name" type="text" class="InputGrey" id="bp_name" size="60" value="<%=bp_name%>" readonly>
        </td>
    </tr>
    <tr>
        <td class="blue">���֤��</td>
        <td>
            <input name="IccId" type="text" class="InputGrey" id="IccId" value="<%=IccId%>" readonly>
        </td>
        <!--begin add by huangrong on 2010-11-24 18:25-->
        <td colspan=2 align=center>
        	<!-- liujian 2012-3-13 10:11:34 ��ɨ�����֤�޸ĳɹ������� begin  -->
        	<!--
	  			<input type="button" name="read_idCard_one" class="b_text"   value="ɨ��һ�����֤" onClick="RecogNewIDOnly_one()">
					<input type="button" name="read_idCard_two" class="b_text"   value="ɨ��������֤" onClick="RecogNewIDOnly_two()">
					<input type="button" name="scan_idCard_two" class="b_text"   value="����" onClick="Idcard()">
					<input type="button" name="get_Photo" class="b_text"   value="��ʾ��Ƭ" onClick="getPhoto()">	
					-->
					<!-- liujian 2012-3-13 10:11:34 ��ɨ�����֤�޸ĳɹ������� end  -->
				</td>
				<!--end add by huangrong on 2010-11-24 18:25-->
    </tr>
</table>
<div class="title">
    <div id="title_zi">��ѡ���������</div>
</div>
<table cellspacing="0">
    <tr>
        <TD width="16%" class="blue">��������</TD>
        <TD colspan="3">
            <input type="radio" name="opFlag" value="6842" checked onClick="changradio()">�콱
            <input type="radio" name="opFlag" value="7515" onClick="changradio()">ԤԼ�Ǽ�
            <input type="radio" name="opFlag" value="7516" id="typeSearch" onClick="changradio()">��ѯ
            <input type="radio" name="opFlag" value="7514" onClick="changradio()">����
            <!--<input type="radio" name="opFlag" value="02" onClick="changradio()">����������-->
            <!--<input type="radio" name="opFlag" value="03" onClick="changradio()">����������-->
        </TD>
    </TR>
    <tr id="phonenofiled" style="display:none">
        <td width="16%" class="blue">�������</td>
        <td colspan="3">
            <input type="text" value="<%=activePhone%>" class="InputGrey" size="12" name="phone_no" id="phone_no" onchange="listtype()" readonly>&nbsp;&nbsp;
       			<input class="b_text" type="button" name="phoneqry" value="��ѯ" onClick="phonequery()" disabled>
        </td>
    </tr>
    <!--modify by wanglei-->
    <tr  id="queryawardList" style="display:none">
        <td width="16%" class="blue">��Ʒ���</td>
        <td>
            	<%
            		String[] inParas = new String[2];
            		inParas[0] = "SELECT type_code,type_name FROM ssaleprojecttype";
            	%>
            	<wtc:service name="TlsPubSelCrm"  outnum="2" retcode="retCode1" retmsg="regMsg1">
							<wtc:param value="<%=inParas[0]%>"/>
							</wtc:service>
							<wtc:array id="projectType" scope="end"/>
		  	 	<%
							for(int i=0;i<projectType.length;i++)
							{
								out.println("<input type='checkbox' name='project_type' value='" + projectType[i][0] + "'>" + projectType[i][0]+"-->"+projectType[i][1] + "</input>");
							}
		   		%>
		   		<input type="button" class="b_text" name="button11" value="��ѯ" onclick="changeawardcode()">
        </td>
    </tr>
    <tr id="detailcodeList" style="display:none">
        <td width="16%" class="blue">Ӫ����</td>
        <td>
            <select name="detailcode" onChange="selectGradeCode()">
                <option value="0000" selected>*��ѡ��*</option>
            </select>
        </td>
    </tr>
    <tr id="gradeCodeList" style="display:none">
        <td width="16%" class="blue">�ȼ�</td>
        <td colspan="3">
            <select name="grade_code" class="button">
                <option value="0000" selected>*��ѡ��*</option>
            </select>
        </td>
    </tr>
</table>
<!-- ������������������Ʒѡ�� -->
<table cellspacing="0">
    <tr id="condition_grade_display" style="display:none">
        <td width="16%" class="blue">��Ʒ�ȼ�</td>
        <td colspan="3">
            <select name="res_grade_code" class="button" onChange="changegradecode()">
                <option value="00" selected>*��ѡ��*</option>
            </select><font class="orange">*</font>
        </td>
    </tr>
    <tr id="condition_display" style="display:none">
        <td width="16%" class="blue">��Ʒ����</td>
        <td>
            <select name="rescode" class="button" onchange="changeResCode()">
                <option value="00" selected>*��ѡ��*</option>
            </select><font class="orange">*</font>
        </td>
        <td width="16%" class="blue">��Ʒ����</td>
        <td>
            <input type="text" size="11" name="rescode_sum" id="rescode_sum" v_minlength=1 v_maxlength=11 v_name="��Ʒ����" maxlength="5" value="1" index="0" onchange="document.forms[0].card_no.value=''">
        </td>
    </tr>
</table>
<!-- ��������������������Ҫ��֤ҵ����ˮ -->
<table cellspacing="0">
    <tr id="checkloginaccept" style="display:none">
        <td width="16%" class="blue">
            <div id="add_text">��ˮ����</div>
        </td>
        <td>
            <input id="loginaccepttext" type="text" name="oldloginaccept">
            <font class="orange">*</font>
        </td>
    </tr>
</table>
</div>


<div id="Operation_Table">
<div id = "detailList_title" style="display:">
    <div class="title">
        <div id="title_zi">������ϸ</div>
    </div>
</div>
    <TABLE cellSpacing="0" name="detailList" id="detailList" style="display:none">
          <tr align="center">
            <th class="Grey">&nbsp;<input type="checkbox"  name="regionCheck" checked=true style="cursor:hand;" onclick="doChange()"></td>
            <th>����ʵ����Ʒ</td>
              <th>Ӫ��������</th>
              <th>Ӫ���ȼ�����</th>
              <th>����</th>
              <th>��ȡ��־</th>
              <th>�н�����</th>
              <th>ʵ����Ʒ</th>
          </tr>
  <%
        String tbclass="";
        if(!"7514".equals(request.getParameter("change_code")))
        {
          for(int j=0;j<s6842SelArr.length;j++){
           for(int i=0;i<s6842SelArr[0].length;i++){
           	System.out.println("s6842SelArr["+j+"]["+i+"]"+s6842SelArr[j][i]);
           }
          	tbclass = j%2==0 ? "Grey" : "";
   %>
            <tr align="center">
				<%  if(j<=19) {  %>
				<%if("Y".equals(s6842SelArr[j][9])){%>
				<td class="<%=tbclass%>" ><%=j+1%><input type="checkbox"  name="checkbox<%=j%>" value="QRCODE" disabled title="��ά��Ӫ����Ӫҵ��������ȡ"></td>
				<%}else{%>
				<td class="<%=tbclass%>" ><%=j+1%><input type="checkbox"  name="checkbox<%=j%>" value="<%=j%>" checked=true></td>
				<%}%>
				<%  } else {  %>
                <td class="<%=tbclass%>" ><%=j+1%><input type="checkbox"  name="checkbox<%=j%>" value="<%=j%>"></td>
				<%  }  %>
              <td class="<%=tbclass%>"><input name="awardInfoQuery" type=button class="b_text" onClick="getItem('<%=s6842SelArr[j][3]%>','<%=j%>','<%=s6842SelArr[j][2]%>','<%=s6842SelArr[j][13]%>')" value=��ѯ> </TD>
              <td class="<%=tbclass%>"><%=s6842SelArr[j][7]%></TD>
              <td class="<%=tbclass%>"><%=s6842SelArr[j][8]%></TD>
              <!-- <td class="<%=tbclass%>"><%=s6842SelArr[j][11]%></TD>  liyan ���� -->
              <td class="<%=tbclass%>"><input size="20" class="InputGrey" name="ResNum<%=j%>" value="<%=s6842SelArr[j][11].trim()%>" readonly> <!--liyan ���� -->
              <td class="<%=tbclass%>"><font color="red"><%=("O".equals(s6842SelArr[j][4])?"����δ��ȡ":"δ��ȡ")%></font></TD>
              <td class="<%=tbclass%>"><%=s6842SelArr[j][5]%></TD>
              <td class="<%=tbclass%>" ><input size="60" class="InputGrey" name="ResName<%=j%>" value="<%=s6842SelArr[j][12]%>" readonly>
			  <!--liyan 20100410 begin-->
			<!--  <input name="giftName_all<%=j%>" type="hidden" value="giftName_all<%=j%>"  />
              <input name="giftName_sum<%=j%>" type="hidden" value="giftName_sum<%=j%>" />-->
			<input name="giftName_all<%=j%>" type="hidden" value="<%=s6842SelArr[j][12].trim()%>" />
              <input name="giftName_sum<%=j%>" type="hidden" value="<%=s6842SelArr[j][11].trim()%>" />
			  <!--liyan 20100410 end-->


              <input name="qRCodeFlag<%=j%>" type="hidden" value="<%=s6842SelArr[j][9] %>" />
              <input name="getFlag<%=j%>" type="hidden" value="<%=s6842SelArr[j][4] %>" />
              <input name="awardSeq<%=j%>" type="hidden" value="<%=s6842SelArr[j][6]%>">
              <input name="gradeCode<%=j%>" type="hidden" value="<%=s6842SelArr[j][2]%>">
              <input name="projectCode<%=j%>" type="hidden" value="<%=s6842SelArr[j][3]%>">
              <input name="packageCode<%=j%>" type="hidden" value="<%=s6842SelArr[j][13]%>">
              <input name="awardCode<%=j%>" type="hidden" value="<%=s6842SelArr[j][14]%>">
              <input name="awardNum<%=j%>" type="hidden" value="<%=s6842SelArr[j][15]%>">
              <!--�����ͣ��������Ʒ�����мۿ�������-1 ������ǿ�������Ϊ���� -->
              <input name="cardType<%=j%>" type="hidden" value="<%=s6842SelArr[j][16]%>" />
              <input name="cardNum<%=j%>" type="hidden" value="">
              <input name="cardNo<%=j%>" type="hidden" value="">

              <input name="payAccept<%=j%>" type="hidden" value="">
              <input name="printPackageCont<%=j%>" type="hidden" value="">
              <input name="awardNote<%=j%>" type="hidden" value="�û�<%=activePhone%>�콱">
              </TD>
            </tr>
    <%  } }  %>
    </TABLE>



    <TABLE cellSpacing="0" id="backList" style="display:">
      <tr align="center">
        <th>ѡ��</td>
        <th>��ˮ��</th>
        <th>�콱ʱ��</th>
        <th>�콱����</th>
      </tr>
        <%
            if("7514".equals(request.getParameter("change_code"))){
                for(int k=0;k<s6842SelArr.length;k++){
                		tbclass = (k%2==0) ? "Grey" : "";
        %>
       <tr align="center">
				<td class="<%=tbclass%>"><input type="radio"  name="backMain" onClick = "getBackinfo('<%=s6842SelArr[k][0]%>')" value="<%=k%>"></td>
				<td class="<%=tbclass%>"><%=s6842SelArr[k][0]%></TD><!--�콱��ˮ-->
				<td class="<%=tbclass%>"><%=s6842SelArr[k][2]%></TD>
				<td class="<%=tbclass%>"><%=s6842SelArr[k][3]%></TD>
            </tr>
        <% } } %>
       </tr>
     </TABLE>


<div  id="backinfodis" style="display:none">
    <div id="Operation_Table">
    <div class="title">
    	<div id="title_zi">������ϸ</div>
    </div>
    <TABLE cellSpacing="0" id="backinfo">
    <TBODY>
    	  <tr align="center">
    		  <th>��Ʒ���</th>
    		  <th>Ӫ��������</th>
    		  <th>����</th>
    		  <th>ʵ����Ʒ</th>
    		  <th>��ȡ��־</th>
    	  </tr>
    	</TBODY>
    </TABLE>
    </div>
</div>
<!-- liujian 2012-3-13 10:11:34 ��ɨ�����֤�޸ĳɹ�������  begin -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=strLoginAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
<!-- liujian 2012-3-13 10:11:34 ��ɨ�����֤�޸ĳɹ�������  end -->
<table cellspacing="0">
    <tr>
        <td id="footer">
            <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm()" index="2">
            <input class="b_foot" type=button name=back value="���" onClick="window.location.href='f6842.jsp?activePhone=<%=activePhone%>'">
            <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
        </td>
    </tr>
</table>
<div id="relationArea" style="display:none"></div>
<div id="wait" style="display:none"><img  src="/nresources/default/images/blue-loading.gif" /></div>
<div id="beforePrompt"></div>
<%@ include file="/npage/include/footer.jsp" %>
<input type="hidden" name="LoginAccept" value="<%=strLoginAccept%>">
<input type="hidden" name="cust_name" value="<%=bp_name%>">
<input type="hidden" name="id_iccid" value="<%=IccId%>">
<input type="hidden" name="id_address" value="<%=cust_address%>">
<input type="hidden" name="con_user_passwd" value="<%=con_user_passwd%>"><!--20100108 ��ֵ�����ṩ�û�����-->

<input type="hidden" name="check_loginaccept" value="">
<input type="hidden" name="opcode">
<input type="hidden" name="cust_info">
<input type="hidden" name="opr_info">
<input type="hidden" name="note_info1">
<input type="hidden" name="note_info2">
<input type="hidden" name="note_info3">
<input type="hidden" name="note_info4">
<input type="hidden" name="printcount">
<input type="hidden" name="smName">
<input type="hidden" name="opNote">
<input type="hidden" name="checkLoginAcceptnew">
<input type="hidden" name="rescode_sum_new">
<input type="hidden" name="awarddetailcode">
<input type="hidden" name="awardId">
<input type="hidden" name="payAccept">
<input type="hidden" name="printAccept">
<input type="hidden" name="cardType">
<input type="hidden" name="cardNum">
<input type="hidden" name="gradeCode"><!--20090319 ����-->
<input type="hidden" name="runName" value="<%=runName%>">
<input type="hidden" name="ResNameArr">
<input type="hidden" name="ResNameArr111">
<input type="hidden" name="backaccept"><!--�콱��ˮ��Ϊ�˳�����ƴ��2010-1-28 13:38:01-->
<input type="hidden" name="queryaward"/><!--2010-3-1 16:15:28-->

<!--add by wanglei on 20100107 19:44-->
<input type="hidden" name="awardSeqI" value="">
<input type="hidden" name="gradeCodeI" value="">
<input type="hidden" name="projectCodeI" value="">
<input type="hidden" name="packageCodeI" value="">
<input type="hidden" name="cardNoI" value="NO">
<input type="hidden" name="awardNoteI" value="">

<!--liyan 20100410 begin-->
<input name="giftNameAll" type="hidden" value="" />
<input name="giftNameSum" type="hidden" value="" />
<!--liyan 20100410 end-->
<!--begin add by huangrong on 2010-11-24 18:25-->
<input type="hidden" name="card_flag" value="">
<input type="hidden" name="custId" value="">
<input type="hidden" name="custName" value="">
<input type="hidden" name="idIccid" value="">
<input type="hidden" name="idAddr" value="">
<input type="hidden" name="birthDay" value="">
<input type="hidden" name="custSex" value="">
<input type="hidden" name="idSexH" value="">
<input type="hidden" name="birthDayH" value="">
<input type="hidden" name="idAddrH" value="">
<input type="hidden" name="idValidDate" value="">
<input type="hidden" name="pic_name" value="">
<input type="hidden" name="but_flag" value="">
<input type="hidden" name="card_flag" value="">
<input type="hidden" name="card_flag" value="">
<input type="hidden" name="card_flag" value="">
<input type="hidden" name="card_flag" value="">
<input type="hidden" name="sf_flag" value="">
<!--end add by huangrong on 2010-11-24 18:25-->

<!--begin add by diling@2011/10/16 -->
<input type="hidden" name="televisionCardNo" id="televisionCardNo" value=" ">
<input type="hidden" name="televisionCardFlag" id="televisionCardFlag" value=" ">


</form>
</body>
<!--begin add by huangrong on 2010-11-24 18:25-->
<!-- <%@ include file="../innet/interface_provider.jsp" %> -->
<!--end add by huangrong on 2010-11-24 18:25-->

<!-- liujian 2012-3-13 10:11:34 ��ɨ�����֤�޸ĳɹ������� begin  -->
<%@ include file="/npage/public/hwObject.jsp" %>
<!-- liujian 2012-3-13 10:11:34 ��ɨ�����֤�޸ĳɹ������� end  -->
</html>
