<%
    /********************
     version v2.0
     ������: si-tech
     * 
     *update:zhanghonga@2008-09-03 ҳ�����,�޸���ʽ
     *update:wanglma 20110427 ʦ��У԰һ��ͨӪ�������ʾ����
     *update:ningtn ����ҵ�������������� ����
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
        String opCode = "2266";
        String opName = "����Ʒͳһ����";

        String orgCode = (String) session.getAttribute("orgCode");
        String strRegionCode = orgCode.substring(0, 2);
        String loginName = (String)session.getAttribute("workName");
        String phoneNo = activePhone;
        System.out.println("strRegionCode=" + strRegionCode);
				
				String opt_flag = request.getParameter("opt_flag");
				
        String strConAwardCode = "";
        String strConAwardDetailCode = "";
        String strConAwardName = "";
        String strConDetailName = "";
        String ConprintAccept = "";
        String con_user_passwd = "";

        /****�õ���ӡ��ˮ****/
        String strLoginAccept = "";

        String retFlag="";
        String f2266RetMsg = "";
        String bp_name = "";
        String IccId = "";
        String cust_address = "";
        String passwordFromSer = "";
        String uBelongCode = "";
				String id_noss="";
				String istuoshouuser="no";
				String tuoshouzonghe="";
        String loginNo = (String)session.getAttribute("workNo");
        String loginNoPass = (String)session.getAttribute("password");
        String ipAddrss = (String)session.getAttribute("ipAddr");
        String strOpCode = request.getParameter("change_code")==null?"2266":request.getParameter("change_code");
        System.out.println("~~~~~~~~~~~~~~~~"+strOpCode);
        String[] paraAray1 = new String[5];
        paraAray1[0] = activePhone;     /* �ֻ�����*/
        paraAray1[1] = strOpCode;       /* ��������*/
        paraAray1[2] = loginNo;         /* ��������*/
        paraAray1[3] = loginNoPass;     /* ��������*/
%>
            <wtc:service name="s2266InitNew" routerKey="phone" routerValue="<%=activePhone%>" outnum="19" >
                <wtc:param value="<%=paraAray1[0]%>"/>
                <wtc:param value="<%=paraAray1[1]%>"/>
                <wtc:param value="<%=paraAray1[2]%>"/>
                <wtc:param value="<%=paraAray1[3]%>"/>
            </wtc:service>
            <wtc:array id="s2266InitNewArr" scope="end"/>

<%
          int errCode = retCode==""?999999:Integer.parseInt(retCode);
          String errMsg = retMsg;

          if(s2266InitNewArr == null)
          {
                retFlag = "1";
              f2266RetMsg = "s2266InitNew��ѯ���������ϢΪ��!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
          }else if (errCode != 0){
            retFlag = "1";
            f2266RetMsg = "s2266InitNew��ѯ�û�����Ʒͳһ������Ϣʧ��!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
            }
%>
          <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="sLoginAccept"/>
<%
      strLoginAccept = sLoginAccept;
      System.out.println("#################################f2266LoginAccept->"+strLoginAccept);
%>
<%
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
      String sqlStrNote1 = "select  run_name from dcustmsg a ,sruncode b where substr(a.run_code,2,1)=b.run_code and substr(a.belong_code,1,2)=b.region_code and a.phone_no='"+phoneNo+"'";
%>
            <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=activePhone%>" outnum="1">
        <wtc:sql><%=sqlStrNote1%></wtc:sql>
            </wtc:pubselect>
            <wtc:array id="resultNote1" scope="end"/>
<%
      for(int i=0;i<resultNote1.length;i++){
         runName = (resultNote1[i][0]).trim();
      }
  String beizhussdese="����phoneNo=["+activePhone+"]���в�ѯ";
%>

        
<wtc:service name="sUserCustInfo" outnum="100"  routerKey="region" routerValue="<%=strRegionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="2266" />	
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=loginNoPass%>" />
			<wtc:param value="<%=activePhone%>" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrss%>" />
			<wtc:param value="<%=beizhussdese%>" />
</wtc:service>
<wtc:array id="baseArr" scope="end"/>
<%
    if(baseArr!=null&&baseArr.length>0){
    
    	if(baseArr[0][0].equals("00")) {
          bp_name = (baseArr[0][5]).trim();
          IccId = (baseArr[0][13]).trim();
          cust_address = (baseArr[0][11]).trim();
          passwordFromSer = (baseArr[0][40]).trim();
          uBelongCode = (baseArr[0][36].substring(0,2)).trim();
          id_noss = (baseArr[0][30]).trim();
          
          System.out.println("2266-------------------bp_name="+bp_name);
          System.out.println("2266-------------------IccId="+IccId);
          System.out.println("2266-------------------cust_address="+cust_address);
          System.out.println("2266-------------------passwordFromSer="+passwordFromSer);
          System.out.println("2266-------------------uBelongCode="+uBelongCode);
          }
    }

  if (bp_name.equals(""))
  {
        retFlag = "1";
      f2266RetMsg = "�û����������ϢΪ�ջ򲻴���!<br>";
    }
 /*20130916���ڿ����������տͻ�����Ӫ�����ҵ�������ѯ�û��Ƿ�Ϊ�����û�*/   
	String inParams [] = new String[2];
	String inParams22 [] = new String[2];
  inParams[0] = "select value1 from cfuncconddetail where function_code='8027' and serial='4' ";  

    
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=strRegionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
    <wtc:param value="<%=inParams[0]%>"/>
  </wtc:service>  
  <wtc:array id="ret1111"  scope="end"/>
<%
if(ret1111.length>0) {
inParams22[0]=ret1111[0][0].substring(0, ret1111[0][0].length()-1);
inParams22[1]="v1="+id_noss;
//out.println("---"+id_noss+"---");
}
%>  	
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=strRegionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1"> 
<wtc:param value="<%=inParams22[0]%>"/>
<wtc:param value="<%=inParams22[1]%>"/>
</wtc:service>  
<wtc:array id="ret2222"  scope="end"/>
<%
 if(ret2222.length>0) {
 		if(!ret2222[0][0].trim().equals("0")) {
 		istuoshouuser="yes";
 		}
 }
  //out.println(istuoshouuser+"---");
 if(istuoshouuser.equals("yes")) {
	%>
	  	  	
	<wtc:service name="sChk_TS_ConOwe" routerKey="region" retCode="retcodebill" retMsg="retmsgbill" routerValue="<%=strRegionCode%>" outnum="2">
	<wtc:param value="<%=id_noss%>"/>
	</wtc:service>
	<wtc:array id="tuoshoubillarray" scope="end"/>
	<%
	if(retcodebill.equals("000000")) {		 
				 tuoshouzonghe=tuoshoubillarray[0][1];
				 //out.println("---"+tuoshoubillarray[0][0]+"---");	
				 //out.println("---"+tuoshouzonghe+"---");	
	}else {
		%>
	<script language="JavaScript">
	    rdShowMessageDialog("���÷���sChk_TS_ConOweʧ�ܣ��������<%=retcodebill%>������ԭ��<%=retmsgbill%>");
	</script>
	<%	
	}
}

    String  inParamsStatus [] = new String[2];
    inParamsStatus[0] = "select count(*) from dcustmsg a,sactivtrans b where a.phone_no=:phoneNo and a.contract_no=b.contract_no and substr(a.belong_code,1,2)=b.region_code";
    inParamsStatus[1] = "phoneNo="+activePhone;
%>        
   	
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=strRegionCode%>" retcode="retCode_status" retmsg="retMessage_status" outnum="1"> 
    <wtc:param value="<%=inParamsStatus[0]%>"/>
    <wtc:param value="<%=inParamsStatus[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_status"  scope="end"/>            	
<script language="JavaScript">
    var rownum=0;
  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=f2266RetMsg%>");
  <%}%>
</script>

<head>
<%@ include file="../../npage/s1555/head_2266_javascript_new.htm" %>
<title>����Ʒͳһ����</title>
<script language=javascript>

onload = function()
{
    //�������Ϊ��,��رմ�ҳ��
    if (<%=activePhone%>==null||<%=activePhone%>==""||document.all.phone_no.value.trim().len() == 0) {
        parent.removeTab('<%=opCode%>');
        return false;
    }
    var code = '<%=strOpCode%>';
    if (code==2266)
    {
        document.frm.opFlag[0].checked=true;
        document.all.detailList.style.display = "";
        document.all.backList.style.display = "none";
    }
    else if(code==2249)
    {
        document.frm.opFlag[1].checked=true;
        document.all.detailList.style.display = "";
        document.all.backList.style.display = "none";
    }
    else if(code==2279)
    {
        document.frm.opFlag[5].checked=true;
        document.all.detailList.style.display = "none";
        document.all.backList.style.display = "";
    }
    self.status = "";
    listtype();
    beforePrompt();
    
    	//begin huangrong add ����������һ��ͨ��������ڴ��б��һ����״
		if(code==2266)
		{
				var j="";
				var n=0;
				for(i=0;i<<%=s2266InitNewArr.length%>;i++)
				{
					
				  if(document.getElementById("checkbox"+i).checked==true)
					{		
						
						if(document.getElementById("chDetailCode"+i).value=="5064" || document.getElementById("chDetailCode"+i).value=="5906")
						{		
								n=n+1;
							 	if(n==1)
							 	{
							 		j+=i+1; 
							 	}else
						 		{
						 			j+=","+(i+1); 
						 		}
								document.getElementById("chDetailCode"+i).parentNode.parentNode.style.cursor="hand";
						}	
							 				      
					}
						
				 } 
				 if(j!=""){
				 rdShowMessageDialog("������ϸ����Ԥ�滰��������ͨ��!<br>����"+j+"�н��п�������!</br>");		
				}
		}
						 //end huangrong add ����������һ��ͨ��������ڴ��б��һ����״ 
						 
		var opt_flag = '<%=opt_flag%>';
		if(opt_flag == 'search' ) {
				$('#typeSearch').click();
		}
}

//yuanqs add 2010/10/29 10:35:38 �ֲ�����
function showMsg11() {
		var msgStr = "";				
				msgStr = "�û��������������˵��ܶ�Ϊ��<%=tuoshouzonghe%>" ;

		$("#msgDiv").children("span").html(msgStr);
		
			var msgNode = $("#msgDiv").css("border","1px solid #999").width("260px")
                            .css("position","absolute").css("z-index","99")
                            .css("background-color","#dff6b3").css("padding","8");
    	var pt = $("#detailcode");
    	msgNode.css("left",pt.offset().left + 300 + "px").css("top",pt.offset().top + 0 + "px");
    	msgNode.show();
}
function hideMessage() {
		$("#msgDiv").hide();
}

//�ռ��ص�ʱ���жϺ����Ƿ��ǰ׿ͻ�
function listtype()
{
    var myPacket = new AJAXPacket("f2266list.jsp", "���ڲ�ѯ�ͻ���Ϣ�����Ժ�......");
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

var pwdFlag = "false";
var detailQueryFlag = "N";
//����ajax����
function doProcess(packet)
{
    var vRetPage = packet.data.findValueByName("rpc_page");
    if (vRetPage == "awarddetailname") {
        var triListData = packet.data.findValueByName("detailcode");
        var triListType = packet.data.findValueByName("detailType");//yuanqs add 2010/10/28 9:25:42 �ֲ�����
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
        //yuanqs add 2010/10/28 9:31:19 �ֲ����� begin
        if (triListType == "") {
            rdShowMessageDialog("û�н�Ʒ������ݣ�");
            triListType = "";

            document.all("changeDetailType").length = 0;
            document.all("changeDetailType").options.length = 1;
            document.all("changeDetailType").options[0].text = "*��ѡ��*";
            document.all("changeDetailType").options[0].value = "0000";
            return;
        }
        var selectLength = document.all("changeDetailType").length;
        if(selectLength == 1) {
						document.all("changeDetailType").length = 0;
		        document.all("changeDetailType").options.length = triListType.length + 1;
		        document.all("changeDetailType").options[0].text = "*��ѡ��*";
		        document.all("changeDetailType").options[0].value = "0000";
		        for (i = 0; i < triListType.length; i++) {
		            document.all("changeDetailType").options[i + 1].text = triListType[i][1];
		            document.all("changeDetailType").options[i + 1].title = triListType[i][1];
		            document.all("changeDetailType").options[i + 1].value = triListType[i][0];
		        }
	        	document.all("detailcode").options[0].selected = true;
        }
        //yuanqs add 2010/10/28 9:32:25 �ֲ����� end
        
        document.all("detailcode").length = 0;
        document.all("detailcode").options.length = triListData.length + 1;
        document.all("detailcode").options[0].text = "*��ѡ��*";
        document.all("detailcode").options[0].value = "0000";

        for (i = 0; i < triListData.length; i++) {
            document.all("detailcode").options[i + 1].text = triListData[i][1];
            document.all("detailcode").options[i + 1].title = triListData[i][1];
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
            document.all("rescode").options[0].value = "00";
            return;
        }

        document.all("rescode").length = 0;
        document.all("rescode").options.length = triListData.length + 1;
        document.all("rescode").options[0].text = "*��ѡ��*";
        document.all("rescode").options[0].value = "00";

        for (i = 0; i < triListData.length; i++) {
            document.all("rescode").options[i + 1].text = triListData[i][1];
            document.all("rescode").options[i + 1].title = triListData[i][1];
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
            
            /*DILING ADD */
            detailQueryFlag = "Y";
            document.all("res_grade_code").length = 0;
            document.all("res_grade_code").options.length = 1;
            document.all("res_grade_code").options[0].text = "*��ѡ��*";
            document.all("res_grade_code").options[0].value = "00";
            return;
        }

        document.all("res_grade_code").length = 0;
        document.all("res_grade_code").options.length = triListData.length + 1;
        document.all("res_grade_code").options[0].text = "*��ѡ��*";
        document.all("res_grade_code").options[0].value = "00";

        for (i = 0; i < triListData.length; i++) {
            document.all("res_grade_code").options[i + 1].text = triListData[i][1];
            document.all("res_grade_code").options[i + 1].value = triListData[i][0];
        }

        document.all("rescode").options[0].selected = true;
        /*diling add ���� ��ϸ��ʶ*/
        detailQueryFlag = "Y";
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
    }
}

function showPrtDlg(printType, DlgMessage, submitCfm, varPrintInfo)
{ 	
	//��ʾ��ӡ�Ի���
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
    /* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* ningtn */
    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
    var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=activePhone%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret = window.showModalDialog(path, printStr, prop);

    return ret;
}

function printInfo(varPrintInfo)
{
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

    if (varOpCode == "2266") {
        opr_info += "����ҵ��: " + "����Ʒͳһ����" + "  ������ˮ: " + varLoginAccept + " ��Ʒ�Ѿ���ȡ" + "|";              
    } else if (varOpCode == "2249") {
        opr_info += "����ҵ��: " + "����Ʒͳһ����ԤԼ�Ǽ�" + "  ������ˮ: " + varLoginAccept + " ��Ʒ�Ѿ��Ǽ�" + "|";
    } else if (varOpCode == "2279") {
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
        awardcode = document.frm.queryaward.value;
    }

    //����������������֤������ˮ
    if (document.all.changeopcode.value=="2266")
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
		if("<%=result_status[0][0]%>"=="0"){

	    if (document.frm.runName.value != "����")
	    {
	        rdShowMessageDialog("���û�������״̬���޷�����!");
	        document.frm.res_grade_code.focus();
	        return false;
	    }
  	}

    var myPacket = new AJAXPacket("f2266phoneqry.jsp", "���ڲ�ѯ�ͻ���Ϣ�����Ժ�......");
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
	/*
		20121028 gaopeng ���� ȡ���ߵ��ӿ���ƴ������ start
	*/
	var tCardAll="";
	for(var k=0;k<<%=s2266InitNewArr.length%>;k++)
	{
		var istr = $("#tCard"+k).val();
		if($("input[name='checkbox"+k+"']").attr("checked")==true)
		{
			tCardAll=tCardAll+istr+"#";
		}
		
	}
		$("input[name='iTelevCard']").val(tCardAll);
	/*
		20121028 gaopeng ���� ȡ���ߵ��ӿ���ƴ������ end
	*/
    var op_code=$("input[@name=opFlag][@checked]").val();
    getAfterPrompt(op_code);
    var vConPhoneNo = document.all.phone_no.value;
    if (vConPhoneNo.len() != 11)
    {
        rdShowMessageDialog("�������λ������ȷ,�����´�ҳ��!");
        parent.removeTab('<%=opCode%>');
        return false;
    }
    var detailcode = document.all.detailcode[document.all.detailcode.selectedIndex].value;
    var detailname = document.all.detailcode[document.all.detailcode.selectedIndex].text;
    var rescode = document.all.rescode[document.all.rescode.selectedIndex].value;
    var vResCodeSum = document.all.rescode_sum.value;
    var res_grade_code = document.all.res_grade_code[document.all.res_grade_code.selectedIndex].value;
		if("<%=result_status[0][0]%>"=="0"){

	    if (document.frm.runName.value != "����")
	    {
	        rdShowMessageDialog("���û�������״̬���޷�����!");
	        document.frm.back.focus();
	        return false;
	    }
  	}
    if (document.frm.opFlag[2].checked||document.frm.opFlag[3].checked) /*��������������*/
    {
    	
        for(var i =0;i<document.frm.opFlag.length;i++)
        {
            if (document.frm.opFlag[i].checked== true )
            {
                var awardcode = document.frm.opFlag[i].value;
                break;
            }
        }

        if (document.all.changeopcode.value=="2253")
        {
        //alert("----");
            frm.action = "f2266_query_history.jsp?awardcode="+awardcode+"&phone_no=<%=activePhone%>";
            frm.submit();
        }
        else if (document.all.changeopcode.value=="2279")
        {
            frm.action = "f2266_query.jsp?detail_name=" + detailname+"&awardcode="+awardcode+"&opFlag=2279";
            frm.submit();
        }
        else
        {
            if (detailcode == "0000")
            {
                rdShowMessageDialog("��ѡ��Ʒ�����ϸ");
                return false;
            }
            if (res_grade_code == "00")
            {
                rdShowMessageDialog("��ѡ��Ʒ�ȼ�");
                return false;
            }
            if (rescode == "00")
            {
                rdShowMessageDialog("��ѡ��Ʒ����");
                return false;
            }

            if (vResCodeSum == "")
            {
                rdShowConfirmDialog("�����뽱Ʒ����");
                document.all.rescode_sum.focus();
                return false;
            }

            if (vResCodeSum <= 0)
            {
                rdShowConfirmDialog("��Ʒ��������С��1");
                document.all.rescode_sum.focus();
                return false;
            }
            if(document.all.checkCardNo.style.display == "block" &&document.all.card_no.value=="")
          	{
          	  /*begin ����Э������WLANʵ�忨BOSS���ۺ���������������ĺ� 22013/6/10 */
          	  var packet = new AJAXPacket("f2266_ajax_showCardName.jsp","���ڻ�����ݣ����Ժ�......");
            	packet.data.add("rescode",rescode);
            	core.ajax.sendPacket(packet,doShowCardName);
            	packet = null;
            	/*end ����Э������WLANʵ�忨BOSS���ۺ���������������ĺ� 22013/6/10 */
            	return false;
          	}
            printCommitCondition(awardcode);

        }
    }
    else if (document.frm.opFlag[0].checked)//�콱
    {
        if(!checklines()){
    		return false;
    	}
    	  /*begin huangrong add ��ȡ����һ��ͨ����*/
				if(!cfmCardCode()){
					return false;
				}
				/*end huangrong add ��ȡ����һ��ͨ����*/
        if(!setArrValue()){
        	return false;
        }

        document.all.confirm.disabled = true;
        printCommit();

    }
    else if (document.frm.opFlag[1].checked)//ԤԼ�Ǽ�
    {
        if(document.frm.queryaward.value=="00")
        {
            rdShowMessageDialog("��ѡ��Ʒ���");
            return false;
        }
        if (detailcode == "0000")
        {
            rdShowMessageDialog("��ѡ��Ʒ�����ϸ");
            return false;
        }
        if(document.frm.queryaward.value=="02"||document.frm.queryaward.value=="03")
        {
            if (res_grade_code == "00")
            {
                rdShowMessageDialog("��ѡ��Ʒ�ȼ�");
                return false;
            }
            if (rescode == "00")
            {
                rdShowMessageDialog("��ѡ��Ʒ����");
                return false;
            }

            if (vResCodeSum == "")
            {
                rdShowConfirmDialog("�����뽱Ʒ����");
                document.all.rescode_sum.focus();
                return false;
            }

            if (vResCodeSum <= 0)
            {
                rdShowConfirmDialog("��Ʒ��������С��1");
                document.all.rescode_sum.focus();
                return false;
            }
            printCommitCondition1(document.frm.queryaward.value);
        }
        else
        {
            frm.action = "f2266_query.jsp?opcode=2279&phone_no=<%=activePhone%>&awardcode=" + document.all.queryaward.value + "&detail_name=" + detailname;
            frm.submit();
        }

    }
    else if (document.frm.opFlag[4].checked)//��ѯ
    {
        document.all.confirm.disabled = true;
        frm.action = "f2266_query_history.jsp?awardcode="+document.all.queryaward.value;
        frm.submit();
    } else if (document.frm.opFlag[5].checked)//����
    {
        var backMain = document.getElementsByName("backMain");
        for(var i=0;i<backMain.length;i++)
        {
            if(backMain[i].checked)
            {
                break;
            }
            if(i==(backMain.length-1))
            {
                rdShowConfirmDialog("��ѡ��һ��������ˮ��");
                return false;
            }
        }
        document.all.confirm.disabled = true;
        printCommit1();
    }
}
/*begin ����Э������WLANʵ�忨BOSS���ۺ���������������ĺ� 22013/6/10 */
function doShowCardName(packet){
  var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");
  var showName = packet.data.findValueByName("showName");
  if(retCode!="000000"){
    rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
    return false;
  }else{
    if(showName!=""){
      rdShowMessageDialog(showName+"����Ϊ��!<br>��㡰��ѯ����ť���в�ѯ!</br>");
      return false;
    }else{
      rdShowMessageDialog("�ֻ���ֵ�����Ų���Ϊ��!<br>��㡰��ѯ����ť���в�ѯ!</br>");
      return false;
    }
  }
}
/*end ����Э������WLANʵ�忨BOSS���ۺ���������������ĺ� 22013/6/10 */

//yuanqs add 2010/10/28 13:56:04 �ֲ�����
function changeType() {
			var yuyuestr="";
			if(document.frm.opFlag[1].checked==true) {
						yuyuestr="yes";
			}else if(document.frm.opFlag[4].checked==true) {
						yuyuestr="chaxun";
			}
			else {
			}
			var regioncode = "<%=strRegionCode%>";
			var changeDetailTypeValue = document.frm.changeDetailType.value; //yuanqs add 2010/10/28 9:40:46 �ֲ�����
			var myPacket = new AJAXPacket("f2266DetailName.jsp", "��ѯ��Ʒ�����ϸ,���Ե�...");
			myPacket.data.add("awardcode", '02');
			myPacket.data.add("changeDetailTypeValue", changeDetailTypeValue); 
			myPacket.data.add("id_sno", "<%=id_noss%>");
			myPacket.data.add("regioncode", regioncode);
			myPacket.data.add("yuyuestr", yuyuestr);
			core.ajax.sendPacket(myPacket);
			myPacket = null;
}

function changradio()
{				
				document.frm.queryaward[0].selected = true; //yuanqs add 2010/11/12 17:19:24
				document.all.detailcodeType.style.display = "none";//yuanqs add 2010/11/12 16:50:57
        if(document.frm.opFlag[2].checked==true||document.frm.opFlag[3].checked==true)
        {
        		//yuanqs add 2010/11/11 15:47:18 begin
        		var opFlagValue;
        		if(document.frm.opFlag[2].checked==true) {
        				opFlagValue = "02";
        				document.all.detailcodeType.style.display = ""; //yuanqs add 2010/11/11 16:13:47 �ֲ�����
        		} else {
        				opFlagValue = "03";
        		}
        		//yuanqs add 2010/11/11 16:14:04 end
        		
            document.all.res_grade_code.options.length = 1;
            document.all.rescode.options.length = 1;

            for(var i =0;i<document.frm.opFlag.length;i++)
            {
                if (document.frm.opFlag[i].checked== true )
                {
                    var awardcode = document.frm.opFlag[i].value;
                    break;
                }
            }
            
            			var yuyuestr="";
									if(document.frm.opFlag[1].checked==true) {
									yuyuestr="yes";
									}
									else if(document.frm.opFlag[4].checked==true) {
												yuyuestr="chaxun";
									}
									else {
									}
			
            var regioncode = "<%=strRegionCode%>";
            var changeDetailTypeValue = document.frm.changeDetailType.value; //yuanqs add 2010/10/28 9:40:46 �ֲ�����
            var myPacket = new AJAXPacket("f2266DetailName.jsp", "��ѯ��Ʒ�����ϸ,���Ե�...");
            myPacket.data.add("awardcode", awardcode);
            myPacket.data.add("changeDetailTypeValue", changeDetailTypeValue); 
            myPacket.data.add("id_sno", "<%=id_noss%>");
            myPacket.data.add("regioncode", regioncode);
            myPacket.data.add("yuyuestr", yuyuestr);
            myPacket.data.add("opFlagValue", opFlagValue);//yuanqs add 2010/11/11 15:59:09
            
            core.ajax.sendPacket(myPacket);
            myPacket = null;
            document.all.condition_display.style.display = "";
            document.all.condition_grade_display.style.display = "";
            document.all.checkCardNo.style.display = "none";
            document.all.detailcodeList.style.display = "";
            
            document.all.workList.style.display = "";
            document.all.detailList.style.display = "none";
            document.all.detailList_title.style.display = "none";
            document.all.backList.style.display = "none";
            document.all.confirm.disabled = true;
            document.all.phonenofiled.style.display = "";
            document.all.phoneqry.disabled = false;
            document.all.queryawardList.style.display="none";
            document.getElementById("backinfodis").style.display="none";
        }
        else
        {
            if(document.frm.opFlag[0].checked==true)
            {
                frm.action = "f2266.jsp?activePhone=<%=activePhone%>&change_code=2266";
                frm.submit();
            }
            else if(document.frm.opFlag[1].checked==true)
            {
                document.all.queryaward.selectedIndex=0;
                document.all.detailcode.selectedIndex = 0;
                document.all.rescode.selectedIndex = 0;
                document.all.condition_display.style.display = "none";
                document.all.condition_grade_display.style.display = "none";
                document.all.detailcodeList.style.display = "";
                document.all.workList.style.display = "none";
                document.all.detailList.style.display = "none";
                document.all.detailList_title.style.display = "none";
                document.all.checkloginaccept.style.display = "none";
                document.all.backList.style.display = "none";
                document.all.phonenofiled.style.display = "none";
                document.all.queryawardList.style.display="";
                document.getElementById("backinfodis").style.display="none";
            }
            else if(document.frm.opFlag[4].checked==true)
            {
                document.all.detailcode.selectedIndex = 0;
                document.all.rescode.selectedIndex = 0;
                document.all.condition_display.style.display = "none";
                document.all.condition_grade_display.style.display = "none";
                document.all.detailcodeList.style.display = "";
                document.all.workList.style.display = "none";
                document.all.detailList.style.display = "none";
                document.all.detailList_title.style.display = "none";
                document.all.checkloginaccept.style.display = "none";
                document.all.backList.style.display = "none";
                document.all.phonenofiled.style.display = "none";
                document.all.queryawardList.style.display="";
                document.getElementById("backinfodis").style.display="none";
            }else if(document.frm.opFlag[5].checked == true)
            {
                frm.action = "f2266.jsp?activePhone=<%=activePhone%>&change_code=2279";
                frm.submit();
            }
            beforePrompt();
        }
}


function changeawardcode()
{
		document.all.detailcodeType.style.display = "none";
		//yuanqs modify 2010/11/11 17:11:59 if((document.all.queryaward.value=="02"||document.all.queryaward.value=="03")&&document.frm.opFlag[1].checked==true)
    if((document.all.queryaward.value=="02"||document.all.queryaward.value=="03"))
    {
        document.all.res_grade_code.options.length = 1;
        document.all.rescode.options.length = 1;
				//yuanqs add 2010/11/11 15:47:18 begin
    		var opFlagValue;
    		if(document.all.queryaward.value=="02") {
    				opFlagValue = "02";
    				document.all.detailcodeType.style.display = ""; //yuanqs add 2010/11/11 16:13:47 �ֲ�����
    		} else {
    				opFlagValue = "03";
    		}
    		//yuanqs add 2010/11/11 16:14:04 end
    		
    		      			var yuyuestr="";
									if(document.frm.opFlag[1].checked==true) {
									yuyuestr="yes";
									}else if(document.frm.opFlag[4].checked==true) {
												yuyuestr="chaxun";
									}
									else {
									}
									
									
        var queryaward = document.all.queryaward[document.all.queryaward.selectedIndex].value;
        var regioncode = "<%=strRegionCode%>";
        var myPacket = new AJAXPacket("f2266DetailName.jsp", "��ѯ��Ʒ�����ϸ,���Ե�...");
        myPacket.data.add("awardcode", queryaward);
        myPacket.data.add("regioncode", regioncode);
        myPacket.data.add("id_sno", "<%=id_noss%>");
        myPacket.data.add("yuyuestr", yuyuestr);
        myPacket.data.add("opFlagValue", opFlagValue);//yuanqs add 2010/11/11 15:59:09
        core.ajax.sendPacket(myPacket);
        myPacket = null;
        document.all.condition_display.style.display = "";
        document.all.condition_grade_display.style.display = "";
        document.all.checkCardNo.style.display = "none";
        document.all.detailcodeList.style.display = "";
        //document.all.workList.style.display = "";
        document.all.detailList.style.display = "none";
        document.all.detailList_title.style.display = "none";
        document.all.backList.style.display = "none";
        document.all.confirm.disabled = true;
        document.all.phonenofiled.style.display = "";
        document.all.phoneqry.disabled = false;
        //document.all.queryawardList.style.display="none";
        document.getElementById("backinfodis").style.display="none";
    }
    else
    {
        document.all.confirm.disabled = false;
        document.all.detailcode.selectedIndex = 0;
        document.all.rescode.selectedIndex = 0;
        document.all.condition_display.style.display = "none";
        document.all.condition_grade_display.style.display = "none";
        document.all.detailcodeList.style.display = "";
        document.all.workList.style.display = "none";
        document.all.detailList.style.display = "none";
        document.all.detailList_title.style.display = "none";
        document.all.checkloginaccept.style.display = "none";
        document.all.backList.style.display = "none";
        document.all.phonenofiled.style.display = "none";
        document.all.queryawardList.style.display="";
        document.getElementById("backinfodis").style.display="none";
             			var yuyuestr="";
									if(document.frm.opFlag[1].checked==true) {
									yuyuestr="yes";
									}
									else if(document.frm.opFlag[4].checked==true) {
												yuyuestr="chaxun";
									}
									else {
									}
        var queryaward = document.all.queryaward[document.all.queryaward.selectedIndex].value;
        var regioncode = "<%=strRegionCode%>";
        var myPacket = new AJAXPacket("f2266DetailName.jsp", "��ѯ��Ʒ�����ϸ,���Ե�...");
        myPacket.data.add("awardcode", queryaward);
        myPacket.data.add("regioncode", regioncode);
        myPacket.data.add("id_sno", "<%=id_noss%>");
        myPacket.data.add("yuyuestr", yuyuestr);
        core.ajax.sendPacket(myPacket);
        myPacket = null;
    }

}

/*��ѯ��Ʒ����*/
function changedetailcode()
{

    var awardcode = "";
    var queryaward = ""; //yuanqs add 2010/11/26 10:28:34 �ֲ���ʾ
    if(document.frm.opFlag[2].checked||document.frm.opFlag[3].checked)
    {
    if(document.all.changeopcode.value=="2266") {
		    if(document.frm.opFlag[2].checked) {
		    		if(document.all("detailcode").value=="9813") {
		    			<%if(istuoshouuser.equals("no")) {%>
		    				rdShowConfirmDialog("�˻ֻ�������û��ſ��԰���");
		    				
		    				  $("#detailcode option").each(function(){
						      if($(this).val()=="0000"){
						        $(this).attr("selected","true");
						      }
						    });
		            return false;
		            <%}%>
		            <%if(istuoshouuser.equals("yes")) {%>
								showMsg11();
								<%}%>
		         }
		         else{
		            <%if(istuoshouuser.equals("yes")) {%>
								hideMessage();
								<%}%>
		         }
		    }
    }
    
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
        awardcode = document.frm.queryaward.value;
    }
    //var awardcode = document.all.awardcode[document.all.awardcode.selectedIndex].value;
    var detailcode = document.all.detailcode[document.all.detailcode.selectedIndex].value;
    var vConPhoneNo = document.all.phone_no.value;

//yuanqs add 2010/11/26 9:47:54 add  ������ѯѡ��Ʒ�����ϸ��Ʒ�ȼ������� begin
		if(document.frm.opFlag[4].checked) {
				queryaward = document.frm.queryaward.value;
				if(queryaward == "02" || queryaward == "03") {
							awardcode = queryaward;
				}
		} 
//yuanqs add 2010/11/26 9:47:54 add  ������ѯѡ��Ʒ�����ϸ��Ʒ�ȼ������� begin
    if (awardcode == "03" || awardcode == "02")
    {
        var myPacket = new AJAXPacket("f2266ResGradeName.jsp", "��ѯ��Ʒ�����ϸ,���Ե�...");
        myPacket.data.add("awardcode", awardcode);
        myPacket.data.add("detailcode", detailcode);
        myPacket.data.add("phone_no", vConPhoneNo);
        core.ajax.sendPacket(myPacket);
        myPacket = null;
    }

    if (awardcode == "02" && detailcode == "0729")
    {
        document.all.rescode_sum.disabled = true;
        document.all.rescode_sum.value = "1";
    } else {
        document.all.rescode_sum.disabled = false;
    }
    /*����������������Ҫ��֤������ˮ*/
    //if (document.frm.opFlag[0].checked)
    //{
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
        } else
        {
            document.all.checkloginaccept.style.display = "none";
        }
    //}
            document.all.checkCardNo.style.display = "none";
}

function cardInfo(packet)
{
    var result = packet.data.findValueByName("result");
    if(result == "true")
    {
      document.forms[0].cardType.value = packet.data.findValueByName("card_type");
      document.forms[0].cardNum.value = packet.data.findValueByName("card_num");
      document.all.checkCardNo.style.display = "block";
      var rescode = document.all.rescode[document.all.rescode.selectedIndex].value;
      /*begin ����Э������WLANʵ�忨BOSS���ۺ���������������ĺ� 22013/6/10 */
  	  var packet = new AJAXPacket("f2266_ajax_showCardName.jsp","���ڻ�����ݣ����Ժ�......");
    	packet.data.add("rescode",rescode);
    	core.ajax.sendPacket(packet,doChangeCardName);
    	packet = null;
    	/*end ����Э������WLANʵ�忨BOSS���ۺ���������������ĺ� 22013/6/10 */
    }
}

/*begin ����Э������WLANʵ�忨BOSS���ۺ���������������ĺ� 22013/6/10 */
function doChangeCardName(packet){
  var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");
  var showName = packet.data.findValueByName("showName");
  if(retCode!="000000"){
    rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
    return false;
  }else{
    if(showName!=""){
      $("#phoneCardShowName").html(showName);
    }
  }
}
/*end ����Э������WLANʵ�忨BOSS���ۺ���������������ĺ� 22013/6/10 */

/*diling add չʾ�û��˻�������콱��¼@2012/6/25 */
function showQueryInfo(){
<%if(istuoshouuser.equals("yes")) {%>
//hideMessage();
<%}%>

  var detailcode = document.all.detailcode[document.all.detailcode.selectedIndex].value;
   if (document.frm.opFlag[2].checked){ //����������
    if (document.all.changeopcode.value=="2266"){
      if(detailQueryFlag == "Y"){//����ϸ��Ʒ��ǰ����
        for(var i =0;i<document.frm.opFlag.length;i++)
        {
          if (document.frm.opFlag[i].checked== true )
          {
            var v_awardcode = document.frm.opFlag[i].value;
            break;
          }
        }
        var myPacket = new AJAXPacket("f2266_ajax_queryHistory.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
	    	myPacket.data.add("v_awardcode",v_awardcode);
	    	myPacket.data.add("detailcode",detailcode);
	    	myPacket.data.add("phone_no","<%=activePhone%>");
	    	core.ajax.sendPacketHtml(myPacket,doQueryHistory);
	    	myPacket=null; 
      }
    }
   }
}

function doQueryHistory(data){
  //�ҵ���ӱ���div
	var markDiv=$("#intablediv"); 
	markDiv.empty();
	markDiv.append(data);
  var retCode = $("#retCodeQueryHistory").val();
  var retMsg = $("#retMsgQueryHistory").val();
  var queryHistoryPhoneNo = $("#queryHistoryPhoneNo").val();
  if("000000"!=retCode){
    rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
    window.location.href="f2266.jsp?activePhone="+queryHistoryPhoneNo;
  }
}

function checkResName(res_code)
{
    //���ݳ�ʼ��
    document.forms[0].cardType.value = "";
    document.forms[0].cardNum.value = "";
    document.forms[0].card_no.value = "";
    document.all.checkCardNo.style.display = "none";

    if(res_code != "00000000")
    {
        //һ��Ҫ��ͬ������.
        var myPacket = new AJAXPacket("fGetCardInfo.jsp", "��ѯ��Ʒ�����ϸ,���Ե�...");
        myPacket.data.add("res_code",res_code);
        core.ajax.sendPacket(myPacket,cardInfo);
        myPacket = null;
    }
}

/*��Ʒ���Ʊ仯��������*/
function changeResCode()
{
    /*if (document.frm.opFlag[0].checked)*/
    if (document.frm.opFlag[2].checked||document.frm.opFlag[3].checked)
    {
        var res_code = document.forms[0].rescode.value;
        var res_name = document.forms[0].rescode.options[document.forms[0].rescode.selectedIndex].text;
        checkResName(res_code);
    }
}

function beforeCheckCard(){
  var resCode = document.all.rescode[document.all.rescode.selectedIndex].value;
  var num = 0;
  var vResName = document.all("rescode").options[document.all("rescode").selectedIndex].text
  vResName = vResName.substring(vResName.indexOf("->") + 2, vResName.length);
  var operFlag = "conditions";
  if(document.all.changeopcode.value=="2266"){
    //alert("��������--�콱");
    getQryCountInfo(resCode,num,vResName,operFlag,"");
  }else{
    //alert("�������");
    checkCard();
  }
  
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
    var libaodaima = document.all.rescode[document.all.rescode.selectedIndex].value;
    var ret = window.showModalDialog("./f2266_query_card.jsp?card_num="+card_num+"&card_type="+card_type+"&libaodaima="+libaodaima,"",prop);
    if(ret)
    {
        document.all.card_no.value = ret;
    }
    else
    {
        //do Nothing
        ;
    }
}


/*��ѯ��Ʒ����*/
function changegradecode()
{
    var awardcode = "";

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
        awardcode = document.frm.queryaward.value;
    }
    
    //yuanqs add 2010/11/26 9:47:54 add  ������ѯѡ��Ʒ�����ϸ��Ʒ�ȼ������� begin
		if(document.frm.opFlag[4].checked) {
				queryaward = document.frm.queryaward.value;
				if(queryaward == "02" || queryaward == "03") {
							awardcode = queryaward;
				}
		} 
		//yuanqs add 2010/11/26 9:47:54 add  ������ѯѡ��Ʒ�����ϸ��Ʒ�ȼ������� begin
    
    var vGradeCode = document.all.res_grade_code[document.all.res_grade_code.selectedIndex].value;
    //var awardcode = document.all.awardcode[document.all.awardcode.selectedIndex].value;
    var detailcode = document.all.detailcode[document.all.detailcode.selectedIndex].value;

    var detailcode = document.all.detailcode[document.all.detailcode.selectedIndex].value;
    var myPacket = new AJAXPacket("f2266ResName.jsp", "��ѯ��Ʒ�����ϸ,���Ե�...");
    myPacket.data.add("gradecode", vGradeCode);
    myPacket.data.add("awardcode", awardcode);
    myPacket.data.add("detailcode", detailcode);
    core.ajax.sendPacket(myPacket);
    myPacket = null;

    document.all.confirm.disabled = true;
}


function printCommitCondition(awardcode)
{
    with (document.frm) {
        if (awardcode == "")
        {
            rdShowConfirmDialog("�����뽱Ʒ���");
            return false;
        }
    }

    var varOpNote = "";//������ע

    if (document.frm.changeopcode.value=="2266") {
        document.all.opcode.value = "2266";
        varOpNote = "����Ʒͳһ����";
    } else if (document.frm.changeopcode.value=="2249") {
        document.all.opcode.value = "2249";
        varOpNote = "����Ʒͳһ����ԤԼ�Ǽ�";
    } else if (document.frm.changeopcode.value=="2253") {
        document.all.opcode.value = "2253";
        varOpNote = "����Ʒͳһ������ѯ";
    } else {
        document.all.opcode.value = "2279";
        varOpNote = "����Ʒͳһ��������";
    }

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
/*
 * ����:������������������ȷ��
 *
 */

function frmConCfm()
{
    var varOpNote = "";
    var awardcode = "";
    if(document.frm.opFlag[2].checked)
    {
        awardcode="02";
    }
    else if(document.frm.opFlag[3].checked)
    {
        awardcode="03";
    }
    else if(document.frm.opFlag[1].checked)
    {
        awardcode=document.frm.queryaward.value;
    }
    if (document.frm.changeopcode.value=="2266")
    {
        varOpNote = "����Ʒͳһ����";
    }
    else if (document.frm.changeopcode.value=="2249")
    {
        varOpNote = "����Ʒͳһ����ԤԼ�Ǽ�";
    }
    else if (document.frm.changeopcode.value=="2253")
    {
        varOpNote = "����Ʒͳһ������ѯ";
    }
    else
    {
        varOpNote = "����Ʒͳһ��������";
    }

    /*У��Ĳ�����ˮ��*/
    var varCheckLoginAccept = "";
    if (document.all.loginaccepttext.value == "") {
        varCheckLoginAccept = "0";
    } else {
        varCheckLoginAccept = document.all.loginaccepttext.value;
    }

    var vResCodeSum = "";
    vResCodeSum = document.all.rescode_sum.value;

    document.all.opNote.value = varOpNote;
    document.all.checkLoginAcceptnew.value = varCheckLoginAccept;
    document.all.rescode_sum_new.value = vResCodeSum;
    document.all.awarddetailcode.value = document.all.detailcode[document.all.detailcode.selectedIndex].value;

    document.all.awardId.value = document.all.rescode[document.all.rescode.selectedIndex].value;
    /*  20090319 liyan add */
    document.all.gradeCode.value = document.all.res_grade_code[document.all.res_grade_code.selectedIndex].value;

    document.all.payAccept.value = document.all.LoginAccept.value.trim();
    document.all.printAccept.value = document.all.LoginAccept.value.trim();
    document.frm.action = "f2266Cfm.jsp?awardcode="+awardcode;
    document.frm.submit();
    return true;
}


//***
function frmCfm()
{
    document.frm.action = "f2266Cfm.jsp";
    document.frm.submit();
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

//20121022 gaopeng ������������û��ڡ�Ӫ��ִ��(e177)���콱��Ҫ�е����� �����д˲�ѯajax����
function doE177Qry(upLoginAcc,num)
{
	
	var MydataPacketE177 = new AJAXPacket("f2266_e177Qry.jsp","���ڻ���콱��Ϣ�����Ժ�......");
			MydataPacketE177.data.add("upLoginAcc",upLoginAcc);
			MydataPacketE177.data.add("num",num);
			MydataPacketE177.data.add("phoneNo","<%=activePhone%>");
			core.ajax.sendPacket(MydataPacketE177,retE177);
			MydataPacketE177 = null;
	
}
function retE177(packet)
{
	var filedLen = packet.data.findValueByName("filedLen");
	var num = packet.data.findValueByName("num");
	//var errCode = packet.data.findValueByName("errCode");
	//var errMsg = packet.data.findValueByName("errMsg");
	if(filedLen.length>0)
	{
		 var prop1="dialogHeight:200px; dialogWidth:750px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
     var retTelevisionCardNo = window.showModalDialog("f2266_getTelevisionCard.jsp?filedLen="+filedLen+"&opCode=<%=opCode%>&opName=<%=opName%>","",prop1);
     $("#tCard"+num).val(retTelevisionCardNo);
		
	}

	
}

function doGetQryCountNew(packet){
//alert("doGetQryCountNew");
  var qryCountRetCode = packet.data.findValueByName("qryCountRetCode");
  var qryCountRetMsg = packet.data.findValueByName("qryCountRetMsg");
  var qryCountNum = packet.data.findValueByName("qryCountNum");
  var packetCode = packet.data.findValueByName("packetCode");
  var tmpresCode = packet.data.findValueByName("tmpresCode");/*��ȡ���rescode*/
  var resname = packet.data.findValueByName("resname");
  var operFlag = packet.data.findValueByName("operFlag");
  var upLoginAcc = packet.data.findValueByName("upLoginAcc");
  var num = packet.data.findValueByName("num");
  var isCard = packet.data.findValueByName("isCard");
  var isPackage = packet.data.findValueByName("isPackage");
  var ressum = "";
  //var ressum = document.getElementById("ressum"+num).value;
  //card_num = parseInt(document.forms[0].cardNum.value);
  var cardNoFormat = "";
  if(qryCountRetCode != "000000"){
     rdShowMessageDialog("������룺"+qryCountRetCode+"<br>������Ϣ��"+qryCountRetMsg,0);
     window.location.href="f2266.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>&opt_flag=<%=opt_flag%>&num="+num+"&change_code=<%=request.getParameter("change_code")%>";
  }else{
    //alert("qryCountNum="+qryCountNum);
    if(qryCountNum >1){  
      var prop="dialogHeight:600px; dialogWidth:750px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
      var opcode=$("input[@name=opFlag][@checked]").val();
      //��ѯ��Ʒ�б�
    	//alert("f2266_getItemNew2.jsp");
      var ret = window.showModalDialog("f2266_getItemNew2.jsp?packetCode="+packetCode+"&num="+num+"&tmpresCode="+tmpresCode+"&phoneno=<%=activePhone%>&opcode="+opcode+"&operFlag="+operFlag,"",prop);
      //alert("doGetQryCount"+ret);
      if(ret!=undefined){
        //�ڼ���%����%����%����%������%��ע%������
        var arr = ret.split("%");
        var lineNum = num;
        /*arr[3]:��1��ʼ����-��1��������|��2��ʼ����-��2��������*/
        if(arr[3].indexOf("|")!=-1){
          var v_cardNoFormat = arr[3].split("|");
      	  for(var cardcount=0;cardcount<v_cardNoFormat.length;cardcount++){
			if(v_cardNoFormat[cardcount]!=""&&v_cardNoFormat[cardcount].length>0){
      	  		cardNoFormat += v_cardNoFormat[cardcount]+",";
      	  	}
      	  }
          cardNoFormat = cardNoFormat.substring(0,(cardNoFormat.length-1));
        }else{  //������|���ţ�չʾ��ʽΪ����1������2 ��������
          cardNoFormat = arr[3];
        }
        if(operFlag=="getAward"){/*�콱*/
          document.getElementById("resCode"+lineNum).value = packetCode;//������
          document.getElementById("opNote"+lineNum).value = arr[7];//��ע
          document.getElementById("card_no"+lineNum).value = cardNoFormat; //���Ž��
          document.getElementById("cardNum"+lineNum).value= arr[6];//����
          document.getElementById("cardType"+lineNum).value= arr[8];//������
          document.getElementById("ResName"+lineNum).value=arr[5];//��Ʒ���Ƽ���
          $("#moreKindsOfCard").val("moreKindsOfCard");
          //alert(document.all.moreKindsOfCard.value);
        }else{/*������������������*/
           document.all.card_no.value = cardNoFormat ;
           $("#moreKindsOfCard").val("moreKindsOfCard");
           //alert(document.all.moreKindsOfCard.value);
        }
      }
      
    }else{
      if(operFlag=="getAward"){/*�콱*/
        //20121022 gaopeng ��������:up��ˮ�����ڲ�ѯ�Ƿ���Ӫ��ִ��(e177)������ǣ������������뿨�ţ�ϵͳУ�鿨���Ƿ���ȷ����ȷ�ͼ�¼������
    		//������������ gaopeng 20121022
        doE177Qry(upLoginAcc,num);
        ressum = document.getElementById("ressum"+num).value;
        card_num = parseInt(document.forms[0].cardNum.value);
        getAwardCardInfoNew(packetCode,resname,num,ressum,card_num,isCard,isPackage);
      }else{/*������/����������*/
        checkCard();
      }
    }
  }
}

/*begin diling add for �жϲ������ֽ�Ʒ�б���ʽ@2012/10/25 */
function doGetQryCount(packet){
//alert("doGetQryCount");
  var qryCountRetCode = packet.data.findValueByName("qryCountRetCode");
  var qryCountRetMsg = packet.data.findValueByName("qryCountRetMsg");
  var qryCountNum = packet.data.findValueByName("qryCountNum");
  var packetCode = packet.data.findValueByName("packetCode");
  var tmpresCode = packet.data.findValueByName("tmpresCode");/*��ȡ���rescode*/
  var resname = packet.data.findValueByName("resname");
  var operFlag = packet.data.findValueByName("operFlag");
  var upLoginAcc = packet.data.findValueByName("upLoginAcc");
  var num = packet.data.findValueByName("num");
  var ressum = "";
  //var ressum = document.getElementById("ressum"+num).value;
  //card_num = parseInt(document.forms[0].cardNum.value);
  var cardNoFormat = "";
  if(qryCountRetCode != "000000"){
     rdShowMessageDialog("������룺"+qryCountRetCode+"<br>������Ϣ��"+qryCountRetMsg,0);
     window.location.href="f2266.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>&opt_flag=<%=opt_flag%>&num="+num+"&change_code=<%=request.getParameter("change_code")%>";
  }else{
    //alert("qryCountNum="+qryCountNum);
    if(qryCountNum >1){  
      var prop="dialogHeight:600px; dialogWidth:750px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
      var opcode=$("input[@name=opFlag][@checked]").val();
      //��ѯ��Ʒ�б�
      var ret = window.showModalDialog("f2266_getItemNew.jsp?packetCode="+packetCode+"&num="+num+"&tmpresCode="+tmpresCode+"&phoneno=<%=activePhone%>&opcode="+opcode+"&operFlag="+operFlag,"",prop);
      //alert("doGetQryCount"+ret);
      if(ret!=undefined){
        //�ڼ���%����%����%����%������%��ע%������
        var arr = ret.split("%");
        var lineNum = num;
        /*arr[3]:��1��ʼ����-��1��������|��2��ʼ����-��2��������*/
        if(arr[3].indexOf("|")!=-1){
          var v_cardNoFormat = arr[3].split("|");
      	  for(var cardcount=0;cardcount<v_cardNoFormat.length;cardcount++){
			if(v_cardNoFormat[cardcount]!=""&&v_cardNoFormat[cardcount].length>0){
      	  		cardNoFormat += v_cardNoFormat[cardcount]+",";
      	  	}
      	  }
          cardNoFormat = cardNoFormat.substring(0,(cardNoFormat.length-1));
        }else{  //������|���ţ�չʾ��ʽΪ����1������2 ��������
          cardNoFormat = arr[3];
        }
        if(operFlag=="getAward"){/*�콱*/
          document.getElementById("resCode"+lineNum).value = packetCode;//������
          document.getElementById("opNote"+lineNum).value = arr[7];//��ע
          document.getElementById("card_no"+lineNum).value = cardNoFormat; //���Ž��
          document.getElementById("cardNum"+lineNum).value= arr[6];//����
          document.getElementById("cardType"+lineNum).value= arr[8];//������
          document.getElementById("ResName"+lineNum).value=arr[5];//��Ʒ���Ƽ���
          $("#moreKindsOfCard").val("moreKindsOfCard");
          //alert(document.all.moreKindsOfCard.value);
        }else{/*������������������*/
           document.all.card_no.value = cardNoFormat ;
           $("#moreKindsOfCard").val("moreKindsOfCard");
           //alert(document.all.moreKindsOfCard.value);
        }
      }
      
    }else{
      if(operFlag=="getAward"){/*�콱*/
        //20121022 gaopeng ��������:up��ˮ�����ڲ�ѯ�Ƿ���Ӫ��ִ��(e177)������ǣ������������뿨�ţ�ϵͳУ�鿨���Ƿ���ȷ����ȷ�ͼ�¼������
    		//������������ gaopeng 20121022
        doE177Qry(upLoginAcc,num);
        ressum = document.getElementById("ressum"+num).value;
        card_num = parseInt(document.forms[0].cardNum.value);
        getAwardCardInfo(packetCode,resname,num,ressum,card_num);
      }else{/*������/����������*/
        checkCard();
      }
    }
  }
}

function getAwardCardInfoNew(packetCode,resname,num,ressum,card_num,isCard,isPackage){
//alert("getAwardCardInfoNew");
  prop="dialogHeight:400px; dialogWidth:650px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
  //��ȡopcode
  for(var i =0;i<document.frm.opFlag.length;i++)
  {
      if (document.frm.opFlag[i].checked== true )
      {
          var opcode = document.frm.opFlag[i].value;
          break;
      }
  }
  if(card_num == -1)
  {
      card_num = document.forms[0].ressum.value;
  }
  card_type = document.forms[0].cardType.value;  

  	var path = "<%=request.getContextPath()%>/npage/s1555/f2266_getPackage.jsp";
	path += "?phoneNo=<%=activePhone%>";
	path += "&packageCode=" + packetCode;
	path += "&num=" + num;
	path += "&isCard=" + isCard;
	path += "&isPackage=" + isPackage;
	path += "&resname=" + resname;
	path += "&ressum=" + ressum;
	var ret = window.showModalDialog(path,"",prop);
	
  if(ret!=undefined){
		var pos = ret.indexOf("%");
    var subReturn;
    var flag = 0;
    var lineNum ;
    while(pos!=-1){
    	subReturn = ret.substring(0,pos);
    	if(flag == 0){
    		/* num */
    		lineNum=subReturn;
    	}else if(flag == 1){
    		/* awardNo */
    		$("#resCode" + lineNum).val(subReturn);
    	}else if(flag == 2){
    		/* awardInfo */
    		$("#ResName" + lineNum).val(subReturn);
    	}else if(flag == 3){
    		/* opNote */
    		$("#opNote" + lineNum).val(subReturn);
    	}else if(flag == 4){
    		/* card_no */
    		$("#card_no" + lineNum).val(subReturn);
    		//alert(lineNum);
    			//alert(subReturn);
    	}else if(flag == 5){
    		/* cardType */
    		$("#cardType" + lineNum).val(subReturn);
    	}else if(flag == 6){
    		/* cardNum */
    		$("#cardNum" + lineNum).val(subReturn);
    	}
    	ret = ret.substring(pos+1);
      pos = ret.indexOf("%");
      flag=flag+1;
    }
	}
  else
  {
      //do Nothing
      ;
  }
}

function getAwardCardInfo(packetCode,resname,num,ressum,card_num){
//alert("getAwardCardInfo");
  prop="dialogHeight:400px; dialogWidth:650px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
  //��ȡopcode
  for(var i =0;i<document.frm.opFlag.length;i++)
  {
      if (document.frm.opFlag[i].checked== true )
      {
          var opcode = document.frm.opFlag[i].value;
          break;
      }
  }
  if(card_num == -1)
  {
      card_num = document.forms[0].ressum.value;
  }
  card_type = document.forms[0].cardType.value;
  var ret = window.showModalDialog("./f2266_getItem.jsp?card_num="+card_num+"&card_type="+card_type+"&resCode="+packetCode+"&phoneno=<%=activePhone%>&ressum="+ressum+"&num="+num+"&opcode="+opcode+"&resname="+resname,"",prop);
  if(ret!=undefined)
  {
      var pos = ret.indexOf("%");
      var sub_ret;
      var flag = 0;
      var lineNum ;
      while(pos!=-1)
      {
          sub_ret = ret.substring(0,pos);
          if(sub_ret == "no_card")
          {
              break;
          }
          if(flag==0)
          {
              lineNum=sub_ret;
          }
          else if(flag==1)
          {
              document.getElementById("resCode"+lineNum).value=sub_ret;
          }
          else if(flag==2)
          {
              document.getElementById("opNote"+lineNum).value=sub_ret;
          }
          else if(flag==3)
          {   
              document.getElementById("card_no"+lineNum).value=sub_ret;
          }
          else if(flag==4)
          {
              document.getElementById("cardType"+lineNum).value=sub_ret;
          }
          else if(flag==5)
          {
              document.getElementById("cardNum"+lineNum).value=sub_ret;
          }
          else if(flag==6)
          {
              document.getElementById("ResName"+lineNum).value="";
              document.getElementById("ResName"+lineNum).value=sub_ret;
              //alert(document.getElementById("ResName"+lineNum).value);
          }
          ret = ret.substring(pos+1);
          var pos = ret.indexOf("%");
          flag=flag+1;
      }
  }
  else
  {
      //do Nothing
      ;
  }
}
/*end diling add @2012/10/25 */

function getQryCountInfo(resCode,num,resname,operFlag,upLoginAcc){
  //alert("operFlag="+operFlag);
  //alert("resCode="+resCode);
  //alert("num="+num);
  //alert("resname="+resname);
  //resCode = "PTT10000497";
  var v_resCode = "";
  var reg =/[A-Za-z]/;
  if(reg.test(resCode) == true){
    //alert("������ĸ");
    //v_resCode = resCode.substr(1, resCode.length);
    if(resCode.substr(0,1)=="G"){ //����һ����ĸΪGʱ��resCode��ʽΪ��G����1|P����2�����ȡ����2
      var v_resCodeArr = resCode.split("|");
      v_resCode = v_resCodeArr[1].substr(1, v_resCodeArr[1].length);
    }else{  //���������resCode��ʽΪ����ĸ���֣����ȡ����
      v_resCode = resCode.substr(1, resCode.length);
    }
  }else{
    //alert("��������ĸ");
  }
  //alert("111");
  var myPacket = new AJAXPacket("f2266_ajax_getQryCount.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
    	myPacket.data.add("resCode",resCode);
    	myPacket.data.add("tmpresCode",v_resCode);
    	myPacket.data.add("num",num);
    	myPacket.data.add("resname",resname);
    	myPacket.data.add("operFlag",operFlag);
    	myPacket.data.add("upLoginAcc",upLoginAcc);
    	core.ajax.sendPacket(myPacket,doGetQryCount);
    	myPacket=null; 
}

function getQryCountInfoNew(resCode,num,resname,operFlag,upLoginAcc,isCard,isPackage){
  //alert("operFlag="+operFlag);
  //alert("resCode="+resCode);
  //alert("num="+num);
  //alert("resname="+resname);
  //alert("isCard="+isCard);
  //alert("isPackage="+isPackage);
  //resCode = "PTT10000497";
  var v_resCode = "";
  var reg =/[A-Za-z]/;
  //alert(reg.test(resCode));
  if(reg.test(resCode) == true){
    //alert("������ĸ");
    //v_resCode = resCode.substr(1, resCode.length);
    if(resCode.substr(0,1)=="G"){ //����һ����ĸΪGʱ��resCode��ʽΪ��G����1|P����2�����ȡ����2
      var v_resCodeArr = resCode.split("|");
      v_resCode = v_resCodeArr[1].substr(1, v_resCodeArr[1].length);
      //alert("v_resCode1111==="+v_resCode);
    }else{  //���������resCode��ʽΪ����ĸ���֣����ȡ����
      v_resCode = resCode.substr(1, resCode.length);
      //alert("v_resCode2222==="+v_resCode);
    }
  }else{
    //alert("��������ĸ");
    v_resCode = resCode;
  }
  //alert("111111");
  //alert(v_resCode);
  var myPacket = new AJAXPacket("f2266_ajax_getQryCountNew.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
    	myPacket.data.add("resCode",resCode);
    	myPacket.data.add("tmpresCode",v_resCode);
    	myPacket.data.add("num",num);
    	myPacket.data.add("resname",resname);
    	myPacket.data.add("operFlag",operFlag);
    	myPacket.data.add("upLoginAcc",upLoginAcc);
    	myPacket.data.add("isCard",isCard);
    	myPacket.data.add("isPackage",isPackage);
    	core.ajax.sendPacket(myPacket,doGetQryCountNew);
    	myPacket=null; 
}


//20121022 gaopeng ��������:up��ˮ�����ڲ�ѯ�Ƿ���Ӫ��ִ��(e177)������ǣ������������뿨�ţ�ϵͳУ�鿨���Ƿ���ȷ����ȷ�ͼ�¼������
function getItem(resCode,num,resname,upLoginAcc)
{
//alert(resCode);
    //alert("upLoginAcc="+upLoginAcc);
    /*begin diling add for �����ж�@2012/10/24 */
      var operFlag = "getAward";
    	getQryCountInfo(resCode,num,resname,operFlag,upLoginAcc);
    /*
		//������������ gaopeng 20121022
		doE177Qry(upLoginAcc,num);
    var prop="dialogHeight:400px; dialogWidth:650px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
    var ressum = document.getElementById("ressum"+num).value;
    card_num = parseInt(document.forms[0].cardNum.value);

    //��ȡopcode
    for(var i =0;i<document.frm.opFlag.length;i++)
    {
        if (document.frm.opFlag[i].checked== true )
        {
            var opcode = document.frm.opFlag[i].value;
            break;
        }
    }
    if(card_num == -1)
    {
        card_num = document.forms[0].ressum.value;
    }
    card_type = document.forms[0].cardType.value;
    //alert("-----");
    var ret = window.showModalDialog("./f2266_getItem.jsp?card_num="+card_num+"&card_type="+card_type+"&resCode="+resCode+"&phoneno=<%=activePhone%>&ressum="+ressum+"&num="+num+"&opcode="+opcode+"&resname="+resname,"",prop);
    //alert("getItem"+ret);
    if(ret!=undefined)
    {
        var pos = ret.indexOf("%");
        var sub_ret;
        var flag = 0;
        var lineNum ;
        while(pos!=-1)
        {
            sub_ret = ret.substring(0,pos);
            if(sub_ret == "no_card")
            {
                break;
            }
            if(flag==0)
            {
                lineNum=sub_ret;
            }
            else if(flag==1)
            {
                document.getElementById("resCode"+lineNum).value=sub_ret;
            }
            else if(flag==2)
            {
                document.getElementById("opNote"+lineNum).value=sub_ret;
            }
            else if(flag==3)
            {
                document.getElementById("card_no"+lineNum).value=sub_ret;
            }
            else if(flag==4)
            {
                document.getElementById("cardType"+lineNum).value=sub_ret;
            }
            else if(flag==5)
            {
                document.getElementById("cardNum"+lineNum).value=sub_ret;
            }
            else if(flag==6)
            {
                document.getElementById("ResName"+lineNum).value="";
                document.getElementById("ResName"+lineNum).value=sub_ret;
                //alert(document.getElementById("ResName"+lineNum).value);
            }
            ret = ret.substring(pos+1);
            var pos = ret.indexOf("%");
            flag=flag+1;
        }
    }
    else
    {
        //do Nothing
        ;
    }
    */
    /*end diling add */ 
}
function old_page()
{
    document.frm.action="./f2266_1.jsp?op_code=2266&opCode=2266&opName=����Ʒͳһ����&activePhone=<%=activePhone%>";
    document.frm.submit();
}
function checklines()//����¼�Ƿ��Ѿ��ɹ�����
{
	var flag = 0;
	for(var i=0; i<<%=s2266InitNewArr.length%>; i++)
	{
	    a=i+1
		if(document.getElementById("checkbox"+i).checked==true)
		{
			var vFlag = document.getElementById("flag"+i).value.substring(0,4);
			if(vFlag=="δ�����" )
			{
					rdShowMessageDialog("��"+a+"�н�Ʒ�ڹ涨ʱ�䷶Χ��δ��ȡ,���Ѿ�������ȡ��");
					return false;
			}

			if(document.all.opcode.value=="2266" && vFlag=="����ȡ" )
			{
					rdShowMessageDialog("��"+a+"�д���Ʒ�Ѿ���ȡ��");
					return false;
			}

			if (document.all.opcode.value=="2249" && vFlag=="�ѵǼ�")
			{
				rdShowMessageDialog("��"+a+"�д���Ʒ�ѵǼǣ�");
				return false;
			}
            if (document.getElementById("card_no"+i).value == 'Y')
            {
                rdShowMessageDialog("��"+a+"��û�����뿨�ţ���������'��ѯ'��ť��");
				return false;
            }
            flag++;
		}
	}
	if(flag==0)
	{
		rdShowMessageDialog("��ѡ��һ���콱��¼��");

		return false;
	}
	if(flag>20)
	{
        rdShowMessageDialog("��ѡ����"+flag+"�����콱�������ܳ���20����");
		return false;
	}
	return true;
}
/*begin huangrong add ��ȡ����һ��ͨ���� 2010-11-29*/
var sflag = "0"; //add by wanglma 20110602 Ϊ��ӡ������ ��ʾ 0����ͨ��ӡ 1��Ϊʦ��һ��ͨ��ӡ
function setCardCount(num)
{  
	sflag = "0";
	var j=num-1;
	for(i=0;i<<%=s2266InitNewArr.length%>;i++)
	{
    if(document.getElementById("checkbox"+i).checked==true)
		{
			if(document.getElementById("chDetailCode"+i).value=="5064")
			{
				    sflag = "0";
					if(i==j)
					{
						document.frm.flag_card.value="1";
						var prop="dialogHeight:400px; dialogWidth:650px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
								if(document.getElementById("cardCode"+i).value=="0")
								{						
												var ret = window.showModalDialog("./f2266_getCardCount.jsp?showName=���ӻ�������ͨ����&code="+document.getElementById("cardCode"+i).value+"&num="+(i+1),"",prop);					
								}else
								{		
												var ret = window.showModalDialog("./f2266_getCardCount.jsp?showName=�޸Ļ�������ͨ����&code="+document.getElementById("cardCode"+i).value+"&num="+(i+1),"",prop);			
								}
										if(ret)
									  {
									      document.getElementById("cardCode"+i).value = ret;
									  }			
					}
			}
			// add by wanglma 20110527 ʦ��У԰һ��ͨӪ�������ʾ����
			if(document.getElementById("chDetailCode"+i).value=="5906")
	        {
	        	sflag = "1";
	        	if(i==j)
				{  
				   var ret = "";
	        	   var prop="dialogHeight:400px; dialogWidth:650px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	        	   var cardCode = document.getElementById("cardCode"+i).value ;
	        	   if(cardCode == null){
	        	   	  cardCode = "0";
	        	   }
	        	   if(document.getElementById("cardCode"+i).value=="0"){
	        	   	
	        	      ret = window.showModalDialog("./f2266_stuCard.jsp?showName=һ��ͨ�˺ż�����ͨ��������&studentNo="+$("#studentNo").val()+"&cardNo="+cardCode,"",prop);					
	        	   }else{
	        	      ret = window.showModalDialog("./f2266_stuCard.jsp?showName=һ��ͨ�˺ż�����ͨ�����޸�&studentNo="+$("#studentNo").val()+"&cardNo="+cardCode,"",prop);						
	        	   }
	        	   if(ret)
				    {
				    	 var retArr = ret.split("~");
				        document.getElementById("cardCode"+i).value = retArr[0];
				        document.getElementById("studentNo").value = retArr[1];
				    }
				}
	        }
			// add by wanglma 20110527 ʦ��У԰һ��ͨӪ�������ʾ����
		}
   }
}

function cfmCardCode()
{
	  for(i=0;i<<%=s2266InitNewArr.length%>;i++)
		{
			if(document.getElementById("checkbox"+i).checked==true)
			{	
				if(document.getElementById("chDetailCode"+i).value=="5064" || document.getElementById("chDetailCode"+i).value=="5906" )
				{
					if(document.getElementById("cardCode"+i).value=="0")
					{
						 rdShowMessageDialog("��"+(i+1)+"������������ͨ����Ϊ�գ�����������ϸ�µĵ�"+(i+1)+"����¼���ڵ����������룡");
						 return false;	   
					}
				}
				
			}
		}
		return true;
}
/*end huangrong add ��ȡ����һ��ͨ����*/
function setArrValue()
{
    var i=0;
    var AwardCodeArr = "";
    var DetailCodeArr = "";
    var ResCodeArr = "";
    var OldAcceptArr = "";
    var OpNoteArr = "";
    var ResCodeSumArr = "";
    var CardNoArr = "";
    var ResNameArr = "";
    var ResNameArr1 = "";
    var TmpResNameArr = "";
    var count=0;
    var vPrintName = "";
    var vPrintSum = ""; 
    var CardNam="";/*huangrong add ��ǳ���һ��ͨ�������ַ���*/
    var studentNo = "";
    /* �¾ɱ�ʶ */
    var oldnewFlagArr = "";
    /* ��Ʒ����ʶ */
    var packageFlagArr = "";
    /* ���ر�ʾ */
    var returnFlag = true;
    for(i=0;i<<%=s2266InitNewArr.length%>;i++)
    {
        if(document.getElementById("checkbox"+i).checked==true){
					AwardCodeArr = AwardCodeArr+document.getElementById("chAwardCode"+i).value+"#";
					DetailCodeArr = DetailCodeArr+document.getElementById("chDetailCode"+i).value+"#";
					/* resCode ��ֿ����������жϻ��õ� */
					var resCodeVal = document.getElementById("resCode"+i).value;
					ResCodeArr = ResCodeArr+resCodeVal+"#";
					OldAcceptArr = OldAcceptArr+document.getElementById("payAccept"+i).value+"#";
					OpNoteArr = OpNoteArr+document.getElementById("opNote"+i).value+"#";
					ResCodeSumArr = ResCodeSumArr+document.getElementById("ressum"+i).value+"#";
					CardNoArr = CardNoArr+document.getElementById("card_no"+i).value+"#";   
					//alert(ResCodeArr); 
					//alert(document.getElementById("card_no"+i).value);  
					//alert(i);                
					//alert(document.getElementById("resCode"+i).value); 
					/* �¾ɱ�ʶ */
					var oldnewFlagVal = $("#oldnewFlag" + i).val();
			    oldnewFlagArr += oldnewFlagVal + "#";
			    /* ��Ʒ����ʶ */
			    var packageFlagVal = $("#packageFlag" + i).val();
			    packageFlagArr += packageFlagVal + "#";
			    /* �����°��콱����Ʒ���������ѡ������� ningtn */
			    //alert(oldnewFlagVal);
			    //alert(packageFlagVal);
			    if(oldnewFlagVal == "1" && packageFlagVal == "1"){
			    	var pos = resCodeVal.indexOf("|");
			    	/*if(pos == "-1"){
			    		returnFlag = false;
			    		marketingName = $("#detailList tr:eq(" + (i+1) + ") td:eq(3)").html();
				    	rdShowMessageDialog("�û���" + marketingName + "������Ʒ��û��ѡ�������Ʒ");
				    	break;
				    }*/
			    }
					if("D" != document.getElementById("resCode"+i).value.substring(0,1))
					{
						ResNameArr = ResNameArr+document.getElementById("resname"+i).value+"~"+document.getElementById("ressum"+i).value+"~";
					}
					else
					{		
						ResNameArr = document.getElementById("printPackageCont"+i).value;		
					}	  
					CardNam=  CardNam+document.getElementById("cardCode"+i).value+"#";  	  /*huangrong add ��ǳ���һ��ͨ�������ַ���*/   
					studentNo = document.getElementById("studentNo").value+"#";
					count=count+1;
				}
            
    }
    document.frm.AwardCodeArr.value=AwardCodeArr;
    document.frm.DetailCodeArr.value=DetailCodeArr;
    document.frm.ResCodeArr.value=ResCodeArr;
    document.frm.OldAcceptArr.value=OldAcceptArr;
    document.frm.OpNoteArr.value=OpNoteArr;
    document.frm.ResCodeSumArr.value=ResCodeSumArr;
    document.frm.CardNoArr.value=CardNoArr;
    document.frm.TotallineNum.value=count;
    document.frm.ResNameArr.value=ResNameArr;
    document.frm.CardNam.value=CardNam;/*huangrong add ��ǳ���һ��ͨ�������ַ���*/
    document.frm.studentNo.value=studentNo;/*wanglma add һ��ͨ�˺�*/
    $("#oldnewFlagArr").val(oldnewFlagArr);
    $("#packageFlagArr").val(packageFlagArr);
    //alert(document.frm.ResNameArr.value);
    return returnFlag;
}
function getBackinfo(accept)
{
    var tab=document.getElementById("backinfo");
    for(var a=1;a<=rownum;a++)
    {
        tab.deleteRow(1);
    }
    document.frm.backaccept.value=accept;
    var myPacket = new AJAXPacket("f2266_back_rpc.jsp", "��ѯ��Ʒ�����ϸ,���Ե�...");
    myPacket.data.add("accept", accept);
    myPacket.data.add("activePhone", "<%=activePhone%>");
    core.ajax.sendPacket(myPacket,showBackInfo);
    myPacket = null;
}
function workType()
{
    document.all.detailcode.selectedIndex = 0;
    document.all.rescode.selectedIndex = 0;
    document.all.condition_display.style.display = "none";
    document.all.condition_grade_display.style.display = "none";
    /*��֤������ˮ*/
    document.all.checkloginaccept.style.display = "none";

    if(document.all.changeopcode.value=='2253'||document.all.changeopcode.value=='2279')
    {
		document.all.phoneqry.disabled = true;
		document.all.confirm.disabled = false;
    }
    else
    {
        document.all.condition_display.style.display = "";
        document.all.condition_grade_display.style.display = "";
        document.all.phoneqry.disabled = false;
        document.all.confirm.disabled = true;
    }
	beforePrompt();
}
function showBackInfo(packet)
{
    document.getElementById("backinfodis").style.display="";
    var errorflag = packet.data.findValueByName("errorflag");
    var errorMsg = packet.data.findValueByName("errorMsg");
    if(errorflag == "false")
    {
        rdShowMessageDialog(errorMsg,1);
				frm.action = "f2266.jsp?activePhone=<%=activePhone%>&change_code=2279";
				frm.submit();
    }
    rownum = packet.data.findValueByName("rownum");
    var returnArr = new Array();
    returnArr = packet.data.findValueByName("value");

    var tab=document.getElementById("backinfo");
    var i;
    var j;

    var ResNameArr = "";
      
   for(i=0;i<rownum;i++)
   {
       var tr=tab.insertRow();
          		
       var td1=document.createElement("td");
       td1.innerHTML=returnArr[i][1];
       td1.style.textAlign="center";
   
       var td2=document.createElement("td");
       td2.innerHTML=returnArr[i][2];
       td2.style.textAlign="center";
   
       var td3=document.createElement("td");
       td3.innerHTML=returnArr[i][3];
       td3.style.textAlign="center";
   
       var td4=document.createElement("td");
       td4.innerHTML=returnArr[i][4];
       td4.style.textAlign="center";
   
       var td5=document.createElement("td");
       td5.innerHTML=returnArr[i][5];
       td5.style.textAlign="center";
		/*  	
       var td6=document.createElement("td");
       td6.innerHTML=returnArr[i][6];
       td6.style.textAlign="center";
   
       var td7=document.createElement("td");
       td7.innerHTML=returnArr[i][7];
       td7.style.textAlign="center";
   
       var td8=document.createElement("td");
       td8.innerHTML=returnArr[i][8];
       td8.style.textAlign="center";
   
       var td9=document.createElement("td");
       td9.innerHTML=returnArr[i][9];
    	td9.style.textAlign="center";*/
    	
    	tr.appendChild(td1);
    	tr.appendChild(td2);
    	tr.appendChild(td3);
    	tr.appendChild(td4);
    	tr.appendChild(td5);
    	/*
    	tr.appendChild(td6);
    	tr.appendChild(td7);
    	tr.appendChild(td8);
    	tr.appendChild(td9);*/
   		var ResCode = returnArr[i][0].substring(0,1);
   		//alert(ResCode);   		
    	if(ResCode=="D")
    	{
    		ResNameArr = returnArr[i][11];
    	}
    	else
    	{	
    		ResNameArr = ResNameArr+returnArr[i][4]+"~"+returnArr[i][3]+"~";
    	}
    }	
    document.frm.ResNameArr.value=ResNameArr;
}

function printCommit1()
{
	getAfterPrompt();
	document.all.confirm.disabled = true;

    var varOpNote = "";//������ע
    var resInfo = "";

    if (document.frm.changeopcode.value=="2266")
    {
        document.all.opcode.value = "2266";
        varOpNote = "����Ʒͳһ����";
    } else if (document.frm.changeopcode.value=="2249")
    {
        document.all.opcode.value = "2249";
        varOpNote = "����Ʒͳһ����ԤԼ�Ǽ�";
    } else if (document.frm.changeopcode.value=="2253")
    {
        document.all.opcode.value = "2253";
        varOpNote = "����Ʒͳһ������ѯ";
    }
    else
    {
        document.all.opcode.value = "2279";
        varOpNote = "����Ʒͳһ��������";
    }

      var varPrintInfo = '<%=loginName%>'+"|"
        +document.frm.phone_no.value.trim()+"|"
        +document.frm.cust_name.value.trim()+"|"
      	+document.frm.id_iccid.value.trim()+"|"
      	+document.frm.id_address.value.trim()+"|"
      	+'<%=strOpCode%>'+"|"
      	+document.frm.LoginAccept.value.trim()+"|"
      	+"test1"+"|"
      	+varOpNote+"|"
      	+"test2"+"|"
      	+document.frm.ResNameArr.value.trim()+"|";

    //��ӡ�������ύ��
    var ret = showPrtDlg1("Detail", "ȷʵҪ���е��������ӡ��", "Yes", varPrintInfo);

    if (typeof(ret) != "undefined")
    {
        if ((ret == "confirm"))
        {
            if (rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!') == 1)
            {
                document.all.printcount.value = "1";
                document.frm.action="f2266_backCfm.jsp?printAccept=<%=sLoginAccept%>&opcode=2279&phone_no=<%=activePhone%>";
                document.frm.submit();
            }
        }

        if (ret == "continueSub")
        {
            if (rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��') == 1)
            {
                document.all.printcount.value = "0";
                document.frm.action="f2266_backCfm.jsp?printAccept=<%=sLoginAccept%>&opcode=2279&phone_no=<%=activePhone%>";
                document.frm.submit();
            }
        }
    }
    else
    {
        if (rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��') == 1)
        {
            document.all.printcount.value = "0";
            document.frm.action="f2266_backCfm.jsp?printAccept=<%=sLoginAccept%>&opcode=2279&phone_no=<%=activePhone%>";
            document.frm.submit();
        }
    }
}
function printCommit()
{
	getAfterPrompt();
	document.all.confirm.disabled = true;

    var varOpNote = "";//������ע
    var resInfo = "";

    if (document.frm.changeopcode.value=="2266")
    {
        document.all.opcode.value = "2266";
        if(sflag == "1"){
    		varOpNote = "��л�ͻ����롰Ԥ����ʦ��У԰һ��ͨ��Ӫ��������ÿλ�ͻ����ɲ���1�Σ��ͻ�������У԰�ƶ�����ͨ����ͻ��ֻ�����󶨣�����ֻ�����Ϊ������״̬��������ͣ�����ƶ�����ͨ�����ڽ����ɼ���ʹ�ã����ÿ����Զ�ֹͣ����ͨ�˻���ֵ���ܡ�";
    	}else{
    	    varOpNote = "����Ʒͳһ����";
    	}
        
    } else if (document.frm.changeopcode.value=="2249")
    {
        document.all.opcode.value = "2249";
        varOpNote = "����Ʒͳһ����ԤԼ�Ǽ�";
    } else if (document.frm.changeopcode.value=="2253")
    {
        document.all.opcode.value = "2253";
        varOpNote = "����Ʒͳһ������ѯ";
    }
    else
    {
        document.all.opcode.value = "2279";
        varOpNote = "����Ʒͳһ��������";
    }

      var varPrintInfo = '<%=loginName%>'+"|"
        +document.frm.phone_no.value.trim()+"|"
        +document.frm.cust_name.value.trim()+"|"
      	+document.frm.id_iccid.value.trim()+"|"
      	+document.frm.id_address.value.trim()+"|"
      	+'<%=strOpCode%>'+"|"
      	+document.frm.LoginAccept.value.trim()+"|"
      	+"test1"+"|"
      	+varOpNote+"|"
      	+"test2"+"|"
      	+document.frm.ResNameArr.value.trim()+"|";
    //��ӡ�������ύ��
    var ret = showPrtDlg1("Detail", "ȷʵҪ���е��������ӡ��", "Yes", varPrintInfo);

    if (typeof(ret) != "undefined")
    {
        if ((ret == "confirm"))
        {
            if (rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!') == 1)
            {
                document.all.printcount.value = "1";
                document.frm.action = "f2266Cfm_new.jsp?opcode=2266&phoneNo=<%=activePhone%>";
                document.frm.submit();
            }
        }

        if (ret == "continueSub")
        {
            if (rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��') == 1)
            {
                document.all.printcount.value = "0";
                document.frm.action = "f2266Cfm_new.jsp?opcode=2266&phoneNo=<%=activePhone%>";
                document.frm.submit();
            }
        }
    }
    else
    {
        if (rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��') == 1)
        {
            document.all.printcount.value = "0";
            document.frm.action = "f2266Cfm_new.jsp?opcode=2266&phoneNo=<%=activePhone%>";
            document.frm.submit();
        }
    }
}

function doChange(){
				var j;
				//alert(document.getElementById("regionCheck").checked);
				for(j=0;j<<%=s2266InitNewArr.length%>;j++){
					if(document.getElementById("regionCheck").checked==true &&j<20)
					{
						if(document.getElementById("checkbox"+j).disabled == false){
							document.getElementById("checkbox"+j).checked=true;
						}
						
						//alert(document.getElementById("checkbox"+j).checked);
					}
					else if(document.getElementById("regionCheck").checked==false)
					{
						if(document.getElementById("checkbox"+j).disabled == false){
							document.getElementById("checkbox"+j).checked=false;
						}
						//alert(document.getElementById("checkbox"+j).checked);
					}
			}
		}

function getPackage(resCode,num,resname,isCard,isPackage,upLoginAcc){
	//alert("���콱 getPackage -> " + resCode + " @ " + num + " @ " + resname+" @ "+isCard+" @"+isPackage+"@"+upLoginAcc);
	    /*begin diling add for �����ж�@2012/10/24 */
      var operFlag = "getAward";
    	getQryCountInfoNew(resCode,num,resname,operFlag,upLoginAcc,isCard,isPackage);
    
		//������������ gaopeng 20121022
		//doE177Qry(upLoginAcc,num);

	
}
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">�û���Ϣ</div>
    <!--input type="button" value="�ɰ�ҳ��" onClick="old_page()"-->
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
            <input type="radio" name="opFlag" value="2266" checked onClick="changradio()">�콱
            <input type="radio" name="opFlag" value="2249" onClick="changradio()">ԤԼ�Ǽ�
            <input type="radio" name="opFlag" value="02" onClick="changradio()">����������
            <input type="radio" name="opFlag" value="03" onClick="changradio()">����������
            <input type="radio" name="opFlag" id="typeSearch" value="2253" onClick="changradio()">��ѯ
            <input type="radio" name="opFlag" value="2279" onClick="changradio()">����
        </TD>
    </TR>
    <tr id="phonenofiled" style="display:none">
        <td width="16%" class="blue">�������</td>
        <td colspan="3">
            <input type="text" value="<%=activePhone%>" class="InputGrey" size="12" name="phone_no" id="phone_no" onchange="listtype()" readonly>&nbsp;&nbsp;
       			<input class="b_text" type="button" name="phoneqry" value="��ѯ" onClick="phonequery()" disabled>
        </td>
    </tr>
    <tr  id="queryawardList" style="display:none">
        <td width="16%" class="blue">��Ʒ���</td>
        <td>
            <select name="queryaward" id="queryaward" class="button" onChange="changeawardcode()" style="width:300px">
                <option value="00" selected>*��ѡ��*</option>
                <option value="01">01 --> Ӫ��������</option>
                <option value="02">02 --> ����������</option>
                <option value="03">03 --> ����������</option>
                <option value="04">04 --> ���ֶһ�</option>
        </td>
    </tr>
    <tr id="workList" style="display:none">
        <td width="16%" class="blue">����ѡ��</td>
        <td>
            <select name="changeopcode" class="button" onChange="workType()" style="width:300px">
                <option value="2266">2266 --> �콱</option>
                <option value="2249">2249 --> ԤԼ�Ǽ�</option>
                <option value="2253">2253 --> ��ѯ</option>
                <option value="2279">2279 --> ����</option>
            </select>
        </td>
    </tr>
    <!-- yuanqs add 2010/10/28 8:59:15 �ֲ����� begin -->
    <tr id="detailcodeType" style="display:none">
        <td width="16%" class="blue">��Ʒ����</td>
        <td>
            <select name="changeDetailType" class="button" onChange="changeType()" style="width:300px">
                <option value="0000" selected>*��ѡ��*</option>
            </select>
        </td>
    </tr>
    <!-- yuanqs add 2010/10/28 8:59:15 �ֲ����� end -->
    <tr id="detailcodeList" style="display:none">
        <td width="16%" class="blue">��Ʒ�����ϸ</td>
        <td>
            <select name="detailcode" id="detailcode" onChange="changedetailcode()" style="width:300px" onblur="showQueryInfo()">
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
            <select name="res_grade_code" class="button" onChange="changegradecode()" style="width:300px">
                <option value="00" selected>*��ѡ��*</option>
            </select><font class="orange">*</font>
        </td>
    </tr>
    <tr id="condition_display" style="display:none">
        <td width="16%" class="blue">��Ʒ����</td>
        <td>
            <select name="rescode" class="button" onchange="changeResCode()" style="width:300px">
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
<!-- �ֻ���ֵ�����뿨���� -->
<table  cellspacing="0" >
<tr  id="checkCardNo" style="display:none">
    <td id="phoneCardShowName" width="16%" class="blue">�ֻ���ֵ������</td>
    <td nowrap  width="83%">
    <input id="card_no" class="button" type="text" name="card_no" size="40" readonly="readonly">
    <font class="orange">*</font>
    <input class="b_text" type="button" name="card_no_qry" value="��ѯ" onClick="beforeCheckCard()">
        </td>
    </tr>
</table>
</div>
<div id="Operation_Table">
<div id = "detailList_title" style="display:">
    <div class="title">
        <div id="title_zi">������ϸ </div>
    </div>
</div>
    <TABLE cellSpacing="0" id="detailList" style="display:none">
          <tr align="center">
            <th class="Grey">&nbsp;<input type="checkbox"  name="regionCheck" checked=true style="cursor:hand;" onclick="doChange()"></td>
            <th>����ʵ����Ʒ</td>
              <th>��Ʒ���</th>
              <th>Ӫ��������</th>
              <th>����</th>
              <th>��ȡ��־</th>
              <th>�н�����</th>
              <th>ʵ����Ʒ</th>
          </tr>
<%
        String tbclass="";
        /*wangdana add for ȡУѶͨ�콱����*/
        String Goodsql = "select award_code, award_detailcode from Sactivecode where project_type = '0062' and region_code = '"+strRegionCode+"'";
	  	System.out.println("Goodsql==="+Goodsql);
%>
		<wtc:pubselect name="sPubSelect" outnum="2">
				<wtc:sql><%=Goodsql%></wtc:sql>
				</wtc:pubselect>
		<wtc:array id="retArray" scope="end"/>
<%
	    int countFlag=0;
	    int countFlag1=0;
	    /*wangdana add for ȡУѶͨ�콱����*/
        if(!"2279".equals(request.getParameter("change_code")))
        {
        System.out.println("----------�콱---------------"+s2266InitNewArr.length);
					for(int j=0;j<s2266InitNewArr.length;j++){
						if("0".equals(s2266InitNewArr[j][16])){
						System.out.println("----------���콱---------------");
						System.out.println("----------���콱------s2266InitNewArr["+j+"][0]---------"+s2266InitNewArr[j][0]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][1]---------"+s2266InitNewArr[j][1]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][2]---------"+s2266InitNewArr[j][2]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][3]---------"+s2266InitNewArr[j][3]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][4]---------"+s2266InitNewArr[j][4]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][5]---------"+s2266InitNewArr[j][5]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][6]---------"+s2266InitNewArr[j][6]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][7]---------"+s2266InitNewArr[j][7]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][8]---------"+s2266InitNewArr[j][8]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][9]---------"+s2266InitNewArr[j][9]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][10]---------"+s2266InitNewArr[j][10]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][11]---------"+s2266InitNewArr[j][11]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][12]---------"+s2266InitNewArr[j][12]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][13]---------"+s2266InitNewArr[j][13]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][14]---------"+s2266InitNewArr[j][14]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][15]---------"+s2266InitNewArr[j][15]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][16]---------"+s2266InitNewArr[j][16]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][17]---------"+s2266InitNewArr[j][17]);
						
							/*wangdana add for УѶͨ�콱�������ƣ��������н����31�����콱*/
							countFlag=0;
							countFlag1=0;
							for(int i=0;i<retArray.length;i++){
								if((retArray[i][0].equals(s2266InitNewArr[j][13]))&&(retArray[i][1].equals(s2266InitNewArr[j][14])))
								{
									countFlag=1;
								}	
							}
							
							/*(countFlag ��="0") && (��ǰʱ��  >�н�ʱ��  + 31)  ���*/
							
							String award_flag = s2266InitNewArr[j][5];
							int flag = 0;     /*0��ť�����  1��ʱ��ť���*/
							Date today = new Date();
							DateFormat fmt = new SimpleDateFormat("yyyyMMdd hh:mm:ss");
							Date oldDay = fmt.parse(s2266InitNewArr[j][6]);	   		
							int dNum = oldDay.getDate() + 32;
							oldDay.setDate(dNum);
							int cNum = today.compareTo(oldDay);
							if(countFlag!=0){
								if(cNum == -1)
								{
									flag = 0;
								}
								else
								{
									flag = 1;
									award_flag=s2266InitNewArr[j][5]+"(��������)";
								}
							}
							/*wangdana add for УѶͨ�콱�������ƣ��������н����31�����콱*/
							
							/*fusk add for �绯����Ԥ��60Ԫ���� 7��֮���콱*/
							if("11".equals(uBelongCode) && "01".equals(s2266InitNewArr[j][13]) && "0041".equals(s2266InitNewArr[j][14]))
							{
								countFlag1=1;
							}
							Date oldDay1 = fmt.parse(s2266InitNewArr[j][6]);
							int dNum1 = oldDay1.getDate() + 6;
							oldDay1.setDate(dNum1);
							int cNum1 = today.compareTo(oldDay1);
							if(countFlag1!=0){
								if(cNum1 == -1)
								{
									flag = 0;
								}
								else
								{
									flag = 1;
									award_flag="δ�����";
								}	   					
							}/*fusk add end*/
							if(j%2==0)
							{
								tbclass="Grey";
							}
							else
							{
								tbclass="";
							}
							%>
							<tr align="center" onClick="setCardCount(<%=j+1%>);">
								<%
								if(j<=19)
								{
									if(flag == 0){
									%>
										<td class="<%=tbclass%>" ><%=j+1%><input type="checkbox"  name="checkbox<%=j%>" value="<%=j%>" checked=true></td>
									<%					}else{
									%>	
										<td class="<%=tbclass%>" ><%=j+1%><input type="checkbox"  name="checkbox<%=j%>" value="<%=j%>" disabled></td>
									<%	              	}
								}
								else
								{	
									if(flag == 0){
									%>
										<td class="<%=tbclass%>" ><%=j+1%><input type="checkbox"  name="checkbox<%=j%>" value="<%=j%>"></td>
									<%					}else{
									%>
										<td class="<%=tbclass%>" ><%=j+1%><input type="checkbox"  name="checkbox<%=j%>" value="<%=j%>" disabled></td>
									<%                		}
								}
								%>
								<td class="<%=tbclass%>">
								<%					if(flag == 0){%>
									<input name=awardInfoQuery type=button class="b_text"  style="cursor:hand" onClick="getItem('<%=s2266InitNewArr[j][0]%>','<%=j%>','<%=s2266InitNewArr[j][4]%>','<%=s2266InitNewArr[j][7]%>')" value=��ѯ> 
								<%					}else{%>
									<input name=awardInfoQuery type=button class="b_text"  style="cursor:hand" onClick="getItem('<%=s2266InitNewArr[j][0]%>','<%=j%>','<%=s2266InitNewArr[j][4]%>','<%=s2266InitNewArr[j][7]%>')" value=��ѯ disabled> 
								<%					}%>
								</TD>
								<td class="<%=tbclass%>"><%=s2266InitNewArr[j][1]%></TD>
								<td class="<%=tbclass%>"><%=s2266InitNewArr[j][2]%></TD>
								<td class="<%=tbclass%>"><%=s2266InitNewArr[j][3]%></TD>
								<td class="<%=tbclass%>"><%=award_flag%></TD>
								<td class="<%=tbclass%>"><%=s2266InitNewArr[j][6]%></TD>
								<td class="<%=tbclass%>" >
									<input size="60" class="InputGrey" name="ResName<%=j%>" value="<%=s2266InitNewArr[j][4]%>" readonly />
									<input name="resCode<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][0]%>">
									<input id="ressum<%=j%>" name="ressum<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][3]%>">
									<input name="resname<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][4]%>">
									<input name="flag<%=j%>" type="hidden" value="<%=award_flag%>">
									<input name="payAccept<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][7]%>">
									<input name="printPackageCont<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][11]%>">
									<input name="card_no<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][15]%>">
									<input name="opNote<%=j%>" type="hidden" value="�û�<%=activePhone%>�콱">
									<input name="cardType<%=j%>" type="hidden">
									<input name="cardNum<%=j%>" type="hidden">
									<input name="chAwardCode<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][13]%>">
									<input name="chDetailCode<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][14]%>">
									<input name="cardCode<%=j%>" type="hidden" value="0"> <!-- huangrong add ��ǳ���һ��ͨ���� -->
									<!-- ��ʶ�¾ɰ� -->
									<input name="oldnewFlag<%=j%>" id="oldnewFlag<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][16]%>" />
									<!-- ��ʶ�Ƿ�Ϊ��Ʒ�� -->
									<input name="packageFlag<%=j%>" id="packageFlag<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][17]%>" />
									<!--20121028 gaopeng �������ߵ��ӿ���������-->
									<input name="tCard<%=j%>" id="tCard<%=j%>" type="hidden" value="">
								</TD>
							</tr>
	<%
						}else{
							
							System.out.println("----------���콱---------------");
						System.out.println("----------���콱------s2266InitNewArr["+j+"][0]---------"+s2266InitNewArr[j][0]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][1]---------"+s2266InitNewArr[j][1]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][2]---------"+s2266InitNewArr[j][2]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][3]---------"+s2266InitNewArr[j][3]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][4]---------"+s2266InitNewArr[j][4]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][5]---------"+s2266InitNewArr[j][5]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][6]---------"+s2266InitNewArr[j][6]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][7]---------"+s2266InitNewArr[j][7]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][8]---------"+s2266InitNewArr[j][8]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][9]---------"+s2266InitNewArr[j][9]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][10]---------"+s2266InitNewArr[j][10]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][11]---------"+s2266InitNewArr[j][11]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][12]---------"+s2266InitNewArr[j][12]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][13]---------"+s2266InitNewArr[j][13]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][14]---------"+s2266InitNewArr[j][14]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][15]---------"+s2266InitNewArr[j][15]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][16]---------"+s2266InitNewArr[j][16]);
						System.out.println("----------���콱------s2266InitNewArr["+j+"][17]---------"+s2266InitNewArr[j][17]);
							/* ���콱 ningtn */
							String award_flag = s2266InitNewArr[j][5];
							/* �°��콱���Ƿ�Ϊ��Ʒ����PΪ��Ʒ�� */
							String isPackage = s2266InitNewArr[j][17];
							String isCardVal = s2266InitNewArr[j][15];
							System.out.println("isPackage : ---------> " + isPackage);
							String btnClass = "";
							if(!"1".equals(isPackage) && "N".equals(isCardVal)){
								/*���������Ʒ�� ���� û���мۿ���Ϣ�����ɵ�*/
								btnClass = "disabled";
							}
%>
							<tr align="center" onClick="setCardCount(<%=j+1%>);">
								<%
								if(j<=19)
								{
									%>
										<td class="<%=tbclass%>" ><%=j+1%><input type="checkbox"  name="checkbox<%=j%>" value="<%=j%>" checked=true></td>
									<%
								}
								else
								{	
									%>
										<td class="<%=tbclass%>" ><%=j+1%><input type="checkbox"  name="checkbox<%=j%>" value="<%=j%>"></td>
									<%
								}
								%>
								<td class="<%=tbclass%>">
									<input name=awardInfoQuery type="button" class="b_text" 
									 style="cursor:hand" value="��ѯ" <%=btnClass%>
									 onclick="getPackage('<%=s2266InitNewArr[j][0]%>','<%=j%>','<%=s2266InitNewArr[j][4]%>','<%=s2266InitNewArr[j][15]%>','<%=s2266InitNewArr[j][17]%>','<%=s2266InitNewArr[j][7]%>')" /> 
								</td>
								<td class="<%=tbclass%>"><%=s2266InitNewArr[j][1]%></TD>
								<td class="<%=tbclass%>"><%=s2266InitNewArr[j][2]%></TD>
								<td class="<%=tbclass%>"><%=s2266InitNewArr[j][3]%></TD>
								<td class="<%=tbclass%>"><%=award_flag%></TD>
								<td class="<%=tbclass%>"><%=s2266InitNewArr[j][6]%></TD>
								<td class="<%=tbclass%>" >
								<input size="60" class="InputGrey" name="ResName<%=j%>" id="ResName<%=j%>" value="<%=s2266InitNewArr[j][4]%>" readonly>
								<input name="resCode<%=j%>" id="resCode<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][0]%>">
								<input id="ressum<%=j%>" name="ressum<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][3]%>">
								<input name="resname<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][4]%>">
								<input name="flag<%=j%>" type="hidden" value="<%=award_flag%>">
								<input name="payAccept<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][7]%>">
								<input name="printPackageCont<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][11]%>">
								<input name="card_no<%=j%>" id="card_no<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][15]%>">
								<input name="opNote<%=j%>" id="opNote<%=j%>" type="hidden" value="�û�<%=activePhone%>�콱">
								<input name="cardType<%=j%>" id="cardType<%=j%>" type="hidden">
								<input name="cardNum<%=j%>" id="cardNum<%=j%>" type="hidden">
								<input name="chAwardCode<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][13]%>">
								<input name="chDetailCode<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][14]%>">
								<input name="cardCode<%=j%>" type="hidden" value="0"> <!-- huangrong add ��ǳ���һ��ͨ���� -->
								<!-- ��ʶ�¾ɰ� -->
								<input name="oldnewFlag<%=j%>" id="oldnewFlag<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][16]%>" />
								<!-- ��ʶ�Ƿ�Ϊ��Ʒ�� -->
								<input name="packageFlag<%=j%>" id="packageFlag<%=j%>" type="hidden" value="<%=s2266InitNewArr[j][17]%>" />
								<input name="tCard<%=j%>" id="tCard<%=j%>" type="hidden" value="">
								</TD>
							</tr>
<%
						}
					}
				}
%>
    </TABLE>
    <TABLE cellSpacing="0" id="backList" style="display:">
      <tr align="center">
        <th>ѡ��</td>
        <th>��ˮ��</th>
        <th>�콱ʱ��</th>
        <th>�콱����</th>
      </tr>
        <%
            if("2279".equals(request.getParameter("change_code")))
            {
            	/* Ϊ�°�Ӫ�����������ӣ���ֹ�¾�ͬʱ�����������ظ���¼ */
            	String recordStr = "";
                for(int k=0;k<s2266InitNewArr.length;k++)
                {
                		if(0 == (recordStr.indexOf(s2266InitNewArr[k][0]))){
                			/* �����ظ��� */
                			continue;
                		}
                		
                		recordStr += s2266InitNewArr[k][0] + "|";
                    if(k%2==0)
                    {
                        tbclass="Grey";
                    }
                    else
                    {
                        tbclass="";
                    }

        %>
            <tr align="center">
							<td class="<%=tbclass%>">
								<input type="radio"  name="backMain" 
								 onClick = "getBackinfo(<%=s2266InitNewArr[k][0]%>)" value="<%=k%>">
							</td>
							<td class="<%=tbclass%>"><%=s2266InitNewArr[k][0]%></TD>
							<td class="<%=tbclass%>"><%=s2266InitNewArr[k][1]%></TD>
							<td class="<%=tbclass%>"><%=s2266InitNewArr[k][2]%></TD>
            </tr>
        <%
            }
           }
        %>
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
<!-- ningtn 2011-7-12 08:33:59 ������ӹ��� -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=strLoginAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
<table cellspacing="0">
    <tr>
        <td id="footer">
            <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm()" index="2">
            <input class="b_foot" type=button name=back value="���" onClick="window.location.href='f2266.jsp?activePhone=<%=activePhone%>'">
            <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
        </td>
    </tr>
</table>
<div id="relationArea" style="display:none"></div>
            <div id="wait" style="display:none">
            <img  src="/nresources/default/images/blue-loading.gif" />
        </div>
        <div id="beforePrompt"></div>
<div id="intablediv"></div>
<%@ include file="/npage/include/footer.jsp" %>
<input type="hidden" name="LoginAccept" value="<%=strLoginAccept%>">
<input type="hidden" name="cust_name" value="<%=bp_name%>">
<input type="hidden" name="id_iccid" value="<%=IccId%>">
<input type="hidden" name="id_address" value="<%=cust_address%>">
<input type="hidden" name="con_user_passwd" value="">
<input type="hidden" name="check_loginaccept" value="">
<input type="hidden" name="opcode" value="2249">
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
<input type="hidden" name="AwardCodeArr">
<input type="hidden" name="DetailCodeArr">
<input type="hidden" name="ResCodeArr">
<input type="hidden" name="OldAcceptArr">
<input type="hidden" name="OpNoteArr">
<input type="hidden" name="ResCodeSumArr">
<input type="hidden" name="CardNoArr">
<input type="hidden" name="ResNameArr">
<input type="hidden" name="TotallineNum">
<input type="hidden" name="backaccept">
<!--begin huangrong add ��ǳ���һ��ͨ���� -->
<input type="hidden" name="CardNam">
<input type="hidden" name="flag_card" value="0">
<!--end huangrong add ��ǳ���һ��ͨ���� -->

<!--begin add by huangrong on 2010-11-24 18:25-->
<input type="hidden" name="studentNo" id="studentNo"/>
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
<input type="hidden" name="oldnewFlagArr" id="oldnewFlagArr" value="" />
<input type="hidden" name="packageFlagArr" id="packageFlagArr" value="" />
<!--20121022 gaopeng ���� ���ߵ��ӿ����ŵ�������  ����û��ڡ�Ӫ��ִ��(e177)���콱��Ҫ�е�����-->
<input type="hidden" name="iTelevCard" value=""/>
<input type="hidden" name="moreKindsOfCard" id="moreKindsOfCard" value="" /><!-- diling add for һ������ж��ֿ���ʶ@2012/11/1 -->
	<div id="msgDiv">
	    <span></span>
	</div>
</form>
<!--begin add by huangrong on 2010-11-24 18:25-->
<!--end add by huangrong on 2010-11-24 18:25-->
</body>
<%@ include file="/npage/public/hwObject.jsp" %>
</html>
