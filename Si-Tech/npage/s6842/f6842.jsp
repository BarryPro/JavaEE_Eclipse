<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
        String opCode = "6842";
        String opName = "新版促销品统一付奖";

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

        /****得到打印流水****/
        String strLoginAccept = "";

        String retFlag="";
        String f6842RetMsg = "";
        String bp_name = "";
        String IccId = "";
        String cust_address = "";
        String passwordFromSer = "";

        Map map = (Map)session.getAttribute("contactInfoMap");
        ContactInfo contactInfo = (ContactInfo) map.get(phoneNo);
        String con_user_passwd = (contactInfo == null) ? "" : contactInfo.getPasswdVal(2); //2密码|1身份证|0随机密码

        String loginNo = (String)session.getAttribute("workNo");
        String loginNoPass = (String)session.getAttribute("password");
        String strOpCode = request.getParameter("change_code")==null?"6842":request.getParameter("change_code");

        String[] paraAray1 = new String[4];
        paraAray1[0] = activePhone;     /* 手机号码*/
        paraAray1[1] = strOpCode;       /* 操作代码*/
        paraAray1[2] = loginNo;         /* 操作工号*/
        paraAray1[3] = loginNoPass;     /* 工号密码*/
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
          f6842RetMsg = "s6842Sel查询号码基本信息为空!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
        }else if (errCode != 0 && (opt_flag == null || !opt_flag.equals("search"))){
        	System.out.println("---liujian----7516");
          retFlag = "1";
          f6842RetMsg = "s6842Sel查询用户促销品统一付奖信息失败!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
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

			<!-- 2013/07/23 14:12:23 gaopeng 关于BOSS系统查询客户资料相关功能优化的需求  -->
  	<wtc:service name="sUserCustInfo" routerKey="regionCode" routerValue="<%=strRegionCode%>" retcode="errCodeGetCust" retmsg="errMsgGetCust"  outnum="41" >
      <wtc:param value="<%=strLoginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=strOpCode%>"/>
      <wtc:param value="<%=loginNo%>"/>
      <wtc:param value="<%=loginNoPass%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="根据phone_no:[<%=phoneNo%>]进行查询"/>
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
      f6842RetMsg = "用户号码基本信息为空或不存在!<br>";
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
<title>促销品统一付奖</title>
<script language=javascript>
var pwdFlag = "false";

onload = function()
{
    //diling add 
    $("#televisionCardNo").val("");
    $("#televisionCardFlag").val("");
    
    //如果号码为空,则关闭此页面
    if (<%=activePhone%>==null||<%=activePhone%>==""||document.all.phone_no.value.trim().len() == 0) {
        parent.removeTab('<%=opCode%>');
        return false;
    }
    var code = '<%=strOpCode%>';
    if (code==6842)
    {
        document.frm.opFlag[0].checked=true;
        document.getElementById('detailList').style.display = "";   // 付奖明细
        document.all.backList.style.display = "none"; // 冲正
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


//刚加载的时候判断号码是否是白客户
function listtype()
{
    var myPacket = new AJAXPacket("f6842list.jsp", "正在查询客户信息，请稍候......");
    myPacket.data.add("phone_no", document.frm.phone_no.value.trim());
    core.ajax.sendPacket(myPacket);
    myPacket = null;
}

//begin add by huangrong on 2010-11-24 18:31
function changeCardAddr(obj){
	rdShowMessageDialog("操作成功！",2);	
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
            rdShowMessageDialog("没有奖品类别明细数据！");
            triListData = "";

            document.all("detailcode").length = 0;
            document.all("detailcode").options.length = 1;
            document.all("detailcode").options[0].text = "*请选择*";
            document.all("detailcode").options[0].value = "0000";
            return;
        }

        document.all("detailcode").length = 0;
        document.all("detailcode").options.length = triListData.length + 1;
        document.all("detailcode").options[0].text = "*请选择*";
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
            rdShowMessageDialog("没有奖品类别明细数据！");
            triListData = "";

            document.all("rescode").length = 0;
            document.all("rescode").options.length = 1;
            document.all("rescode").options[0].text = "*请选择*";
            document.all("rescode").options[0].value = "0000";
            return;
        }

        document.all("rescode").length = 0;
        document.all("rescode").options.length = triListData.length + 1;
        document.all("rescode").options[0].text = "*请选择*";
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
            rdShowMessageDialog("没有奖品等级信息数据！");
            triListData = "";

            document.all("res_grade_code").length = 0;
            document.all("res_grade_code").options.length = 1;
            document.all("res_grade_code").options[0].text = "*请选择*";
            document.all("res_grade_code").options[0].value = "0000";
            return;
        }

        document.all("res_grade_code").length = 0;
        document.all("res_grade_code").options.length = triListData.length + 1;
        document.all("res_grade_code").options[0].text = "*请选择*";
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
            rdShowMessageDialog("密码输入准确！");
            document.all.confirm.disabled = false;
            return true;
        } else {
            rdShowMessageDialog("密码输入错误，请重新输入！");
            document.all.cus_pass.focus();
            document.all.confirm.disabled = true;
            return false;
        }
    } else if (vRetPage == "loginacceptqry") {
        var vCheckFlag = packet.data.findValueByName("check_flag");
        if (vCheckFlag == "1") {
            rdShowMessageDialog("用户流水号码验证成功");
            document.all.confirm.disabled = false;
            return true;
        } else if (vCheckFlag == "2") {
            rdShowMessageDialog("用户没有可兑奖数据！");
            document.all.loginaccepttext.focus();
            document.all.confirm.disabled = true;
            return false;
        } else {
            rdShowMessageDialog("用户流水号码验证失败");
            document.all.confirm.disabled = true;
            return false;
        }
    } else if(vRetPage == "grade_code"){ //查询
    		var triListData = packet.data.findValueByName("detailcode");
        var triList = new Array(triListData.length);
        triList[0] = "grade_code";

        if (triListData == "") {
            rdShowMessageDialog("没有等级数据!");
            triListData = "";

						//document.all("queryaward").selectedIndex = 0;
						document.all("detailcodeList").selectedIndex = 0;
						document.all("detailcode").length = 0;
            document.all("detailcode").options.length = 1;
            document.all("detailcode").options[0].text = "*请选择*";
            document.all("detailcode").options[0].value = "0000";
            document.all("grade_code").length = 0;
            document.all("grade_code").options.length = 1;
            document.all("grade_code").options[0].text = "*请选择*";
            document.all("grade_code").options[0].value = "0000";
            return;
        }

        document.all("grade_code").length = 0;
        document.all("grade_code").options.length = triListData.length + 1;
        document.all("grade_code").options[0].text = "*请选择*";
        document.all("grade_code").options[0].value = "0000";

        for (i = 0; i < triListData.length; i++) {
            document.all("grade_code").options[i + 1].text = triListData[i][1];
            document.all("grade_code").options[i + 1].value = triListData[i][0];
        }

        document.all("grade_code").options[0].selected = true;
    }
}

function showPrtDlg(printType, DlgMessage, submitCfm, varPrintInfo)
{  //显示打印对话框
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
    /* liujian 2012-3-13 10:11:34 把扫描身份证修改成公共方法 begin */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* liujian 2012-3-13 10:11:34 把扫描身份证修改成公共方法 end */
    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    // liujian 2012-3-13 10:11:34 把扫描身份证修改成公共方法 修改jsp
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
    var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=strOpCode%>&sysAccept="+sysAccept+"&phoneNo=<%=activePhone%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret = window.showModalDialog(path, printStr, prop);

    return ret;
}

function printInfo(varPrintInfo)
{
	//rdShowMessageDialog("printInfo");
    var i = 0;
    var varPhoneNo = "";      //手机号码
    var varLoginName = "";  //操作名称
    var varUserName = "";   //用户名称
    var varUserId = "";       //用户ID
    var varUserAddress = "";//用户地址
    var varOpCode = "";         //操作类型
    var varLoginAccept = "";//操作流水
    var varAwardName = "";  //奖品名称
    var varOpNote = "";     //操作备注
    var vResCodeSum = "";     //领奖数量
    var vPrintCont = "";    //动态打印内容
    var vPrintName = "";    //动态打印项名称
    var vPrintSum = "";     //动态打印项数量

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
    var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//得到执行时间

    cust_info += "手机号码：" + varPhoneNo + "|";
    cust_info += "客户姓名：" + varUserName + "|";
    cust_info += "证件号码：" + varUserId + "|";
    cust_info += "客户地址：" + varUserAddress + "|";


    opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "  " + "用户品牌: " + document.all.smName.value + "|";

	/* liyan 0412*/
	//rdShowMessageDialog("varOpCode="+varOpCode);
    if (varOpCode == "6842") {
        opr_info += "办理业务: " + "促销品统一付奖" + "  操作流水: " + varLoginAccept + " 奖品已经领取" + "|";
    } else if (varOpCode == "7515") {
        opr_info += "办理业务: " + "促销品统一付奖预约登记" + "  操作流水: " + varLoginAccept + " 奖品已经登记" + "|";
    } else if (varOpCode == "7514") {
        opr_info += "办理业务: " + "促销品统一付奖冲正" + "  操作流水: " + varLoginAccept + " 奖品已经冲正" + "|";
    }

    if (0 == vPrintCont.length) {
        opr_info += "奖品名称: " + varAwardName + "+ 奖品数量: " + vResCodeSum + "|";
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
                    opr_info += "奖品名称: " + vPrintName + "+ 奖品数量: " + vPrintSum + "|";
                    opr_info+=vPrintName+"~"+vPrintSum + "个;";
                    i = 0;
                    break;
            }

            vPrintCont = vPrintCont.substring(vPrintCont.indexOf("~") + 1, vPrintCont.length);
        }
        opr_info+="|";
    }
    note_info1 += "备注: " + varOpNote + "|";
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

    //有条件或无条件验证操作流水
    if (op_code=="6842")
    {
        var detailcode = document.all.detailcode[document.all.detailcode.selectedIndex].value;
        if (awardcode == "02" && (detailcode == "0309" || detailcode == "0501"))
        {
            if (document.all.loginaccepttext.value == "")
            {
                rdShowMessageDialog("请输入验证流水号码!");
                return false;
            }
        }

    }

    if (document.frm.phone_no.value.length == 0)
    {
        rdShowMessageDialog("服务号码不能为空，请重新输入 !");
        document.frm.phone_no.focus();
        return false;
    }

    if (document.frm.res_grade_code.value == "00000000")
    {
        rdShowMessageDialog("请选择奖品等级 !");
        document.frm.res_grade_code.focus();
        return false;
    }

    if(parseInt(document.frm.res_grade_code.value)==0)
    {
        rdShowMessageDialog("请选择奖品等级 !");
        document.frm.res_grade_code.focus();
        return false;
    }

    if (document.frm.runName.value != "正常")
    {
        rdShowMessageDialog("此用户非正常状态，无法付奖!");
        document.frm.res_grade_code.focus();
        return false;
    }

    var myPacket = new AJAXPacket("f6842phoneqry.jsp", "正在查询客户信息，请稍候......");
    myPacket.data.add("phone_no", document.frm.phone_no.value.trim());
    myPacket.data.add("award_code", awardcode);
    myPacket.data.add("detail_code", document.all.detailcode[document.all.detailcode.selectedIndex].value.trim());
    myPacket.data.add("grade_code", document.all.res_grade_code.value.trim());
    myPacket.data.add("check_login_accept", document.frm.loginaccepttext.value.trim());

    core.ajax.sendPacket(myPacket);
    myPacket = null;
}


//----------------验证及提交函数-----------------
function doCfm()
{
    var op_code=$("input[@name=opFlag][@checked]").val();
    getAfterPrompt(op_code);
    var vConPhoneNo = document.all.phone_no.value;
    if (vConPhoneNo.len() != 11)
    {
        rdShowMessageDialog("服务号码位数不正确,请重新打开页面!");
        parent.removeTab('<%=opCode%>');
        return false;
    }
    
    /*begin add by diling for 当选择领取有线电视礼品时，判断是否填写电视卡卡号@2012/5/24*/
    var m = 0;
    var projectCodeArr = new Array(); // 营销案编码
    if (document.frm.opFlag[0].checked){  //领奖
      for(j = 0; j < <%=s6842SelArr.length%>; j++)
      {
      if(document.getElementById('checkbox'+j).checked)
      {
      	if(document.getElementById('qRCodeFlag'+j).value == 'Y'){ continue;	}       // 二维码营销案
      	projectCodeArr[m] = document.getElementById('projectCode'+j).value;
      	m++;
      }
      }
      var televisionCardNo = $("#televisionCardNo").val(); //有线电视卡卡号
      var televisionCardStr ="";
      for(var z=0;z<projectCodeArr.length;z++){
        televisionCardStr = projectCodeArr[z];
        if(televisionCardStr=="279652"){
            if(televisionCardNo.length<7){
                rdShowMessageDialog("请输入电视卡卡号，再进行提交!");
                //window.location.href="f6842.jsp?activePhone=<%=activePhone%>&change_code=6842";
                return false;
            }
        }
      }
    }
    /*end add by diling*/

	var type_code  = document.all.queryaward.value;    //类型代码
    var project_code = document.all.detailcode.value;  //营销案代码
    var grade_code = document.all.grade_code.value;    //等级代码

    var rescode = document.all.rescode[document.all.rescode.selectedIndex].value;
    var vResCodeSum = document.all.rescode_sum.value;
    var res_grade_code = document.all.res_grade_code[document.all.res_grade_code.selectedIndex].value;

    if (document.frm.runName.value != "正常")
    {
        rdShowMessageDialog("此用户非正常状态，无法付奖!");
        document.frm.back.focus();
        return false;
    }
    //if (document.frm.opFlag[2].checked||document.frm.opFlag[3].checked){}/*有条件和无条件*/
    if (document.frm.opFlag[0].checked)     //领奖
    {
        if(!checklines()) { return false; }
        //setArrValue();
        document.all.confirm.disabled = true;
        printCommit('0');
    }
    else if (document.frm.opFlag[1].checked)//预约登记
    {
        if(document.frm.queryaward.value=="0000")
        {
            rdShowMessageDialog("请选择奖品类别");
            return false;
        }
        if (project_code == "0000")
        {
            rdShowMessageDialog("请选择营销案");
            return false;
        }
        if (grade_code == "0000")
        {
            rdShowMessageDialog("请选择等级");
            return false;
        }
        /*if(document.frm.queryaward.value=="02"||document.frm.queryaward.value=="03") {}//有条件无条件*/
        frm.action = "f6842_query.jsp?opcode=7514&phone_no=<%=activePhone%>";
        frm.submit();
    }
    else if (document.frm.opFlag[2].checked)  //查询
    {
        document.all.confirm.disabled = true;
        frm.action = "f6842_query_history.jsp?awardcode="+document.all.queryaward.value+"&grade_code="+grade_code;
        frm.submit();
    } else if (document.frm.opFlag[3].checked)//冲正
    {
        var backMain = document.getElementsByName("backMain");
        for(var i=0;i<backMain.length;i++)
        {
            if(backMain[i].checked) { break; }
            if(i==(backMain.length-1))
            {
                rdShowConfirmDialog("请选择一条冲正流水!");
                return false;
            }
        }
        document.all.confirm.disabled = true;
        printCommit('1');
    }
}

//操作类型
function changradio()
{
		if(document.frm.opFlag[0].checked==true) // 领奖
    {
        frm.action = "f6842.jsp?activePhone=<%=activePhone%>&change_code=6842";
        frm.submit();
    }else
    if(document.frm.opFlag[1].checked==true) // 预约登记
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
    if(document.frm.opFlag[2].checked==true) //查询
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
		if(document.frm.opFlag[3].checked == true) // 冲正
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
  var myPacket = new AJAXPacket("f6842DetailName.jsp", "查询奖品类别明细,请稍等...");
  myPacket.data.add("isFlag", "G");
  myPacket.data.add("project_code", project_code);
  myPacket.data.add("regioncode", regioncode);
  core.ajax.sendPacket(myPacket);
  myPacket = null;
}

function changeawardcode()
{
    //if(false && (document.all.queryaward.value=="02"||document.all.queryaward.value=="03")&&document.frm.opFlag[1].checked==true) {}//有条件无条件

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
    var myPacket = new AJAXPacket("f6842DetailName.jsp", "查询奖品类别明细,请稍等...");
    myPacket.data.add("awardcode", queryaward);
    myPacket.data.add("regioncode", regioncode);
    core.ajax.sendPacket(myPacket);
    myPacket = null;
}

/*有条件无条件查询奖品名称*/
function changedetailcode()
{
    /*
    if (awardcode == "02" && detailcode == "0729") //有条件 sawarddetail

        if (awardcode == "02" && (detailcode == "0309" || detailcode == "0501" || detailcode == '0978'))
        {
            document.all.checkloginaccept.style.display = "";
            document.all.confirm.disabled = true;
            var addTextDIV = document.getElementById("add_text");
            if (detailcode == '0978')
            {
                addTextDIV.innerHTML = "刮刮卡号：";
            }
            else
            {
                addTextDIV.innerHTML = "操作流水：";
            }
        }
    */
}


function printCommitCondition1(awardcode)
{

    var varOpNote = "促销品统一付奖预约登记";//操作备注


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

    //打印工单并提交表单
    var ret = showPrtDlg("Detail", "确实要进行电子免填单打印吗？", "Yes", varPrintInfo);

    if (typeof(ret) != "undefined")
    {
        if ((ret == "confirm"))
        {
            if (rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!') == 1)
            {
                document.all.printcount.value = "1";
                frmConCfm();
            }
        }

        if (ret == "continueSub")
        {
            if (rdShowConfirmDialog('确认要提交信息吗？') == 1)
            {
                document.all.printcount.value = "0";
                frmConCfm();
            }
        }
    }
    else
    {
        if (rdShowConfirmDialog('确认要提交信息吗？') == 1)
        {
            document.all.printcount.value = "0";
            frmConCfm();
        }
    }

    return true;
}



function beforePrompt(){
    var op_code=$("input[@name=opFlag][@checked]").val();
    var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","请稍后...");
    packet.data.add("opCode" ,op_code);
    core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//异步
    packet =null;
}
function doGetBeforePrompt(data)
{
    $('#wait').hide();
    $('#beforePrompt').html(data);
}
function getAfterPrompt(op_code)
{
    var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","请稍后...");
    packet.data.add("opCode" ,op_code);
    core.ajax.sendPacket(packet,doGetAfterPrompt,false);//同步
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
    //查询礼品列表
    var ret = window.showModalDialog("./f6842_getItem.jsp?packetCode="+packetCode+"&projectCode="+projectCode+"&phoneno=<%=activePhone%>&num="+num+"&opcode="+opcode+"&gradeCode="+gradeCode,"",prop);
    if(ret!=undefined){
    	//第几条%包名%数量%卡号%包代码
    	var arr = ret.split("%");
    	var lineNum = arr[0];
    	document.getElementById('cardNo'+lineNum).value      = arr[3];
    	document.getElementById('packageCode'+lineNum).value = arr[4];
    	//document.getElementById("ResName"+lineNum).value     = arr[1];
    	document.getElementById("ResName"+lineNum).value     = arr[5];
    	document.getElementById("ResNum"+lineNum).value     = arr[2]; //数量
    	document.getElementById("giftName_all"+lineNum).value=arr[5]; //礼品名称集合
    	document.getElementById("giftName_sum"+lineNum).value=arr[2]; //礼品数量分析
    	/*rdShowMessageDialog("arr[2]="+arr[2]);
    	rdShowMessageDialog("arr[5]="+arr[5]);
    	rdShowMessageDialog("arr[6]="+arr[6]);*/
    	//+",arr[2]="+arr[4]+"+",arr[3]="+arr[3]+",arr[4]="+arr[4]+",arr[5]="+arr[5]+",arr[6]="+arr[6]);
    	//rdShowMessageDialog（document.getElementById("ResNum"+lineNum).value);
    }
    /*** begin update diling for 先从列表中选择产品，如选择领取有线电视产品，则需输入电视卡卡号@2012/5/21 ***/
    if(projectCode=="279652"){
      var prop1="dialogHeight:200px; dialogWidth:750px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
      var retTelevisionCardNo = window.showModalDialog("./f6842_getTelevisionCard.jsp?packetCode="+packetCode+"&projectCode="+projectCode+"&phoneno=<%=activePhone%>&num="+num+"&opcode="+opcode+"&gradeCode="+gradeCode,"",prop1);
      //alert(retTelevisionCardNo);
      if(retTelevisionCardNo!=undefined){
        $("#televisionCardNo").val(retTelevisionCardNo);
        //alert("返回值了："+$("#televisionCardNo").val());
      }else{ //点击叉叉
        $("#televisionCardNo").val("");
        //alert("点叉："+ $("#televisionCardNo").val());
      }
    }
    /*** end update diling @2012/5/21 ***/
}

//检查记录是否已经成功设置
function checklines()
{
	var flag = 0; // 选择礼品的条数
	for(var i=0; i<<%=s6842SelArr.length%>; i++)
	{
	  a=i+1;
		if(document.getElementById("checkbox"+i).checked)
		{
			if(document.getElementById("checkbox"+i).value == 'QRCODE'){
				continue;
			}
			var vFlag = document.getElementById("getFlag"+i).value;
			if(vFlag=="O")                                       // 未领过期
			{
					rdShowMessageDialog("第"+a+"行奖品在规定时间范围内未领取,现已经不能领取！");
					return false;
			}
			if (document.all.opcode.value=="7515" && vFlag=="R") // 已登记  未实现2010-1-28 16:24:45
			{
				rdShowMessageDialog("第"+a+"行促销品已登记过!");
				return false;
			}

			var card_no = document.getElementById("cardNo"+i);
			var typeArr = document.getElementById("cardType"+i).value.split('#');
			for(k = 0; k < typeArr.length; k++){
				if(typeArr[k] != '' && typeArr[k] !='-1' && (card_no==null || card_no.value=="")){//是卡但是没有卡号
					rdShowMessageDialog("第"+a+"行没有输入卡号，请点击该行'查询'按钮!");
					return false;
				}
			}
      flag++;
		}
	}

	if(flag==0)
	{
		rdShowMessageDialog("请选择一条领奖纪录!");
		return false;
	}
	if(flag>20)
	{
    rdShowMessageDialog("共选择了"+flag+"条，领奖操作不能超过20条!");
		return false;
	}
	return true;
}

/*查询手机充值卡*/
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

//冲正 accept为多条领奖流水2010-1-28 10:35:35
function getBackinfo(accept)
{
		//alert("accept"+accept);
    var tab=document.getElementById("backinfo");
    for(var a=1;a<=rownum;a++)
    {
        tab.deleteRow(1);
    }
    document.frm.backaccept.value=accept;
    var myPacket = new AJAXPacket("f6842_back_rpc.jsp", "查询奖品类别明细,请稍等...");
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
    returnArr = packet.data.findValueByName("value");//返回值

    var tab=document.getElementById("backinfo");
    var i;
    var j;

    var ResNameArr = "";
    var ResNameArr111 = "";
 /*
 *    营销案名称
 *		营销案编码
 *    营销按等级名称
 *    营销按等级编码
 *    礼品数量
 *    礼品代码
 *    礼品名称
 *		领取标志 Y 已冲正 N 未冲正
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
       td5.innerHTML=returnArr[i][7]=='Y'?'已冲正':'未冲正';
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
 *@desc 合并原来的function printCommit()和function printCommit1()
 *@parameter   typeM 1 冲正 0 领奖
 *@author wanglei
 *@date   2010-1-21 14:45:59
 */
function printCommit(typeM)
{
	getAfterPrompt();

	document.all.confirm.disabled = true;
  var varOpNote = "";//操作备注
  var resInfo = "";
  var op_code=$("input[@name=opFlag][@checked]").val();

  if (op_code=="6842"){
      varOpNote = "促销品统一付奖";
  } else if (op_code=="7515"){
      varOpNote = "促销品统一付奖预约登记";
  } else if (op_code=="7516"){
      varOpNote = "促销品统一付奖查询";
  }else{
      varOpNote = "促销品统一付奖冲正";
  }
  document.all.opcode.value = op_code;

	 //liyan 打印
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

  //打印工单并提交表单
  var ret = showPrtDlg1("Detail", "确实要进行电子免填单打印吗？", "Yes", varPrintInfo);

  if (typeof(ret) != "undefined")
  {
      if (ret == "confirm")
      {
	      	if (rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!') == 1)
	      	{
		       	req_Cfm_new_jsp("1",typeM);
	        }
      }
      if(ret == "continueSub")
      {
          if (rdShowConfirmDialog('确认要提交信息吗？') == 1)
          {
              req_Cfm_new_jsp("0",typeM);
          }
      }
  }
  else
  {
      if (rdShowConfirmDialog('确认要提交信息吗？') == 1)
      {
          req_Cfm_new_jsp("0",typeM);
      }
  }
}

//请求f6842Cfm_new.jsp add by wanglei on 20100107 18:01
function req_Cfm_new_jsp(printCount,typeM){
	if(typeM == 1){ // 开始为冲正确认服务传值...
		document.all.printcount.value = printCount;
		document.frm.action="f6842_backCfm.jsp?printAccept=<%=sLoginAccept%>&opcode=7514&phone_no=<%=activePhone%>";
    document.frm.submit();
    return;
	}
	var awardSeqArr    = new Array(); // 中奖流水
	var gradeCodeArr   = new Array(); // 等级代码
	var projectCodeArr = new Array(); // 营销案编码
	var packageCodeArr = new Array(); // 包代码
	var cardNoArr      = new Array(); // 卡号
	var awardNoteArr   = new Array(); // 领奖备注
	var m = 0;
	for(j = 0; j < <%=s6842SelArr.length%>; j++)
	{
		if(document.getElementById('checkbox'+j).checked)
		{
			if(document.getElementById('qRCodeFlag'+j).value == 'Y'){ continue;	}       // 二维码营销案
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
    var televisionCardNo = $("#televisionCardNo").val(); //有线电视卡卡号
    var televisionCardStr ="";
    //var projectCodeI = $("#projectCodeI").val().split("%");
    for(var z=0;z<projectCodeArr.length;z++){
        televisionCardStr = projectCodeArr[z];
        if(televisionCardStr=="279652"){
            if(televisionCardNo.length<7){
                rdShowMessageDialog("请输入电视卡卡号，再进行提交!");
                return false;
            }else{
               $("#televisionCardFlag").val("279652");
            }
        }
    }
    //alert("标识"+document.getElementById("televisionCardFlag").value);
    
	document.all.printcount.value = printCount;
	document.frm.action = "f6842Cfm_new.jsp?opcode=6842&phoneNo=<%=activePhone%>&televisionCardFlag="+document.getElementById("televisionCardFlag").value+"&televisionCardNo="+televisionCardNo;
	document.frm.submit();
}



// 全选礼品
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
    <div id="title_zi">用户信息</div>
</div>
<table cellspacing="0">
    <tr>
        <td class="blue">服务号码</td>
        <td>
            <input name="phoneNo" type="text" class="InputGrey" id="phoneNo" value="<%=activePhone%>" readonly>
        <td class="blue">客户名称</td>
        <td>
            <input name="bp_name" type="text" class="InputGrey" id="bp_name" size="60" value="<%=bp_name%>" readonly>
        </td>
    </tr>
    <tr>
        <td class="blue">身份证号</td>
        <td>
            <input name="IccId" type="text" class="InputGrey" id="IccId" value="<%=IccId%>" readonly>
        </td>
        <!--begin add by huangrong on 2010-11-24 18:25-->
        <td colspan=2 align=center>
        	<!-- liujian 2012-3-13 10:11:34 把扫描身份证修改成公共方法 begin  -->
        	<!--
	  			<input type="button" name="read_idCard_one" class="b_text"   value="扫描一代身份证" onClick="RecogNewIDOnly_one()">
					<input type="button" name="read_idCard_two" class="b_text"   value="扫描二代身份证" onClick="RecogNewIDOnly_two()">
					<input type="button" name="scan_idCard_two" class="b_text"   value="读卡" onClick="Idcard()">
					<input type="button" name="get_Photo" class="b_text"   value="显示照片" onClick="getPhoto()">	
					-->
					<!-- liujian 2012-3-13 10:11:34 把扫描身份证修改成公共方法 end  -->
				</td>
				<!--end add by huangrong on 2010-11-24 18:25-->
    </tr>
</table>
<div class="title">
    <div id="title_zi">请选择操作类型</div>
</div>
<table cellspacing="0">
    <tr>
        <TD width="16%" class="blue">操作类型</TD>
        <TD colspan="3">
            <input type="radio" name="opFlag" value="6842" checked onClick="changradio()">领奖
            <input type="radio" name="opFlag" value="7515" onClick="changradio()">预约登记
            <input type="radio" name="opFlag" value="7516" id="typeSearch" onClick="changradio()">查询
            <input type="radio" name="opFlag" value="7514" onClick="changradio()">冲正
            <!--<input type="radio" name="opFlag" value="02" onClick="changradio()">有条件赠送-->
            <!--<input type="radio" name="opFlag" value="03" onClick="changradio()">无条件赠送-->
        </TD>
    </TR>
    <tr id="phonenofiled" style="display:none">
        <td width="16%" class="blue">服务号码</td>
        <td colspan="3">
            <input type="text" value="<%=activePhone%>" class="InputGrey" size="12" name="phone_no" id="phone_no" onchange="listtype()" readonly>&nbsp;&nbsp;
       			<input class="b_text" type="button" name="phoneqry" value="查询" onClick="phonequery()" disabled>
        </td>
    </tr>
    <!--modify by wanglei-->
    <tr  id="queryawardList" style="display:none">
        <td width="16%" class="blue">奖品类别</td>
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
		   		<input type="button" class="b_text" name="button11" value="查询" onclick="changeawardcode()">
        </td>
    </tr>
    <tr id="detailcodeList" style="display:none">
        <td width="16%" class="blue">营销案</td>
        <td>
            <select name="detailcode" onChange="selectGradeCode()">
                <option value="0000" selected>*请选择*</option>
            </select>
        </td>
    </tr>
    <tr id="gradeCodeList" style="display:none">
        <td width="16%" class="blue">等级</td>
        <td colspan="3">
            <select name="grade_code" class="button">
                <option value="0000" selected>*请选择*</option>
            </select>
        </td>
    </tr>
</table>
<!-- 有条件或无条件促销品选择 -->
<table cellspacing="0">
    <tr id="condition_grade_display" style="display:none">
        <td width="16%" class="blue">奖品等级</td>
        <td colspan="3">
            <select name="res_grade_code" class="button" onChange="changegradecode()">
                <option value="00" selected>*请选择*</option>
            </select><font class="orange">*</font>
        </td>
    </tr>
    <tr id="condition_display" style="display:none">
        <td width="16%" class="blue">奖品名称</td>
        <td>
            <select name="rescode" class="button" onchange="changeResCode()">
                <option value="00" selected>*请选择*</option>
            </select><font class="orange">*</font>
        </td>
        <td width="16%" class="blue">奖品数量</td>
        <td>
            <input type="text" size="11" name="rescode_sum" id="rescode_sum" v_minlength=1 v_maxlength=11 v_name="奖品数量" maxlength="5" value="1" index="0" onchange="document.forms[0].card_no.value=''">
        </td>
    </tr>
</table>
<!-- 有条件或无条件付奖需要验证业务流水 -->
<table cellspacing="0">
    <tr id="checkloginaccept" style="display:none">
        <td width="16%" class="blue">
            <div id="add_text">流水号码</div>
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
        <div id="title_zi">付奖明细</div>
    </div>
</div>
    <TABLE cellSpacing="0" name="detailList" id="detailList" style="display:none">
          <tr align="center">
            <th class="Grey">&nbsp;<input type="checkbox"  name="regionCheck" checked=true style="cursor:hand;" onclick="doChange()"></td>
            <th>更换实物礼品</td>
              <th>营销案名称</th>
              <th>营销等级名称</th>
              <th>数量</th>
              <th>领取标志</th>
              <th>中奖日期</th>
              <th>实物礼品</th>
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
				<td class="<%=tbclass%>" ><%=j+1%><input type="checkbox"  name="checkbox<%=j%>" value="QRCODE" disabled title="二维码营销案营业厅不能领取"></td>
				<%}else{%>
				<td class="<%=tbclass%>" ><%=j+1%><input type="checkbox"  name="checkbox<%=j%>" value="<%=j%>" checked=true></td>
				<%}%>
				<%  } else {  %>
                <td class="<%=tbclass%>" ><%=j+1%><input type="checkbox"  name="checkbox<%=j%>" value="<%=j%>"></td>
				<%  }  %>
              <td class="<%=tbclass%>"><input name="awardInfoQuery" type=button class="b_text" onClick="getItem('<%=s6842SelArr[j][3]%>','<%=j%>','<%=s6842SelArr[j][2]%>','<%=s6842SelArr[j][13]%>')" value=查询> </TD>
              <td class="<%=tbclass%>"><%=s6842SelArr[j][7]%></TD>
              <td class="<%=tbclass%>"><%=s6842SelArr[j][8]%></TD>
              <!-- <td class="<%=tbclass%>"><%=s6842SelArr[j][11]%></TD>  liyan 数量 -->
              <td class="<%=tbclass%>"><input size="20" class="InputGrey" name="ResNum<%=j%>" value="<%=s6842SelArr[j][11].trim()%>" readonly> <!--liyan 数量 -->
              <td class="<%=tbclass%>"><font color="red"><%=("O".equals(s6842SelArr[j][4])?"到期未领取":"未领取")%></font></TD>
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
              <!--卡类型，如果此礼品不是有价卡，返回-1 如果不是卡，卡号为“” -->
              <input name="cardType<%=j%>" type="hidden" value="<%=s6842SelArr[j][16]%>" />
              <input name="cardNum<%=j%>" type="hidden" value="">
              <input name="cardNo<%=j%>" type="hidden" value="">

              <input name="payAccept<%=j%>" type="hidden" value="">
              <input name="printPackageCont<%=j%>" type="hidden" value="">
              <input name="awardNote<%=j%>" type="hidden" value="用户<%=activePhone%>领奖">
              </TD>
            </tr>
    <%  } }  %>
    </TABLE>



    <TABLE cellSpacing="0" id="backList" style="display:">
      <tr align="center">
        <th>选择</td>
        <th>流水号</th>
        <th>领奖时间</th>
        <th>领奖工号</th>
      </tr>
        <%
            if("7514".equals(request.getParameter("change_code"))){
                for(int k=0;k<s6842SelArr.length;k++){
                		tbclass = (k%2==0) ? "Grey" : "";
        %>
       <tr align="center">
				<td class="<%=tbclass%>"><input type="radio"  name="backMain" onClick = "getBackinfo('<%=s6842SelArr[k][0]%>')" value="<%=k%>"></td>
				<td class="<%=tbclass%>"><%=s6842SelArr[k][0]%></TD><!--领奖流水-->
				<td class="<%=tbclass%>"><%=s6842SelArr[k][2]%></TD>
				<td class="<%=tbclass%>"><%=s6842SelArr[k][3]%></TD>
            </tr>
        <% } } %>
       </tr>
     </TABLE>


<div  id="backinfodis" style="display:none">
    <div id="Operation_Table">
    <div class="title">
    	<div id="title_zi">冲正明细</div>
    </div>
    <TABLE cellSpacing="0" id="backinfo">
    <TBODY>
    	  <tr align="center">
    		  <th>奖品类别</th>
    		  <th>营销案名称</th>
    		  <th>数量</th>
    		  <th>实物礼品</th>
    		  <th>领取标志</th>
    	  </tr>
    	</TBODY>
    </TABLE>
    </div>
</div>
<!-- liujian 2012-3-13 10:11:34 把扫描身份证修改成公共方法  begin -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=strLoginAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
<!-- liujian 2012-3-13 10:11:34 把扫描身份证修改成公共方法  end -->
<table cellspacing="0">
    <tr>
        <td id="footer">
            <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm()" index="2">
            <input class="b_foot" type=button name=back value="清除" onClick="window.location.href='f6842.jsp?activePhone=<%=activePhone%>'">
            <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
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
<input type="hidden" name="con_user_passwd" value="<%=con_user_passwd%>"><!--20100108 赋值用来提供用户密码-->

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
<input type="hidden" name="gradeCode"><!--20090319 新增-->
<input type="hidden" name="runName" value="<%=runName%>">
<input type="hidden" name="ResNameArr">
<input type="hidden" name="ResNameArr111">
<input type="hidden" name="backaccept"><!--领奖流水，为了冲正，拼串2010-1-28 13:38:01-->
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

<!-- liujian 2012-3-13 10:11:34 把扫描身份证修改成公共方法 begin  -->
<%@ include file="/npage/public/hwObject.jsp" %>
<!-- liujian 2012-3-13 10:11:34 把扫描身份证修改成公共方法 end  -->
</html>
