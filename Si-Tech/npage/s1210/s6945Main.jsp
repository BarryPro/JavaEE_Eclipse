<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-08-28 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<title>特服变更</title>
<%
    String opCode = "6945";
    String opName = "预约短信开通";
    String vPayCode = "0";

    String work_no = (String) session.getAttribute("workNo");
    String loginName = (String) session.getAttribute("workName");
    String org_code = (String) session.getAttribute("orgCode");
    String regionCode = org_code.substring(0, 2);
    String op_code = "6945";
    String[] paraIn= new String[2];
    String[] paraIn1= new String[2];

    String[][] temfavStr = (String[][]) session.getAttribute("favInfo");
    String[] favStr = new String[temfavStr.length];
    int favPrePay = 0;
    for (int i = 0; i < favStr.length; i++)
        favStr[i] = temfavStr[i][0].trim();

    //判断是否有国际漫游预存减免权限
    boolean hfrf = false;
    if (WtcUtil.haveStr(favStr, "a281"))
        favPrePay = 1;

    int srvStrIndex = 0;
    activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
    String srv_no = WtcUtil.repNull(request.getParameter("srv_no"));
    System.out.println("#######################################srv_no->" + srv_no);
    String ReqPageName = WtcUtil.repNull(request.getParameter("ReqPageName"));

%>
<wtc:service name="s6945Init" routerKey="phone" retCode="initRetCode" retMsg="initRetMsg" routerValue="<%=srv_no%>" outnum="22">
<wtc:param value="<%=work_no%>"/>
<wtc:param value="<%=srv_no%>"/>
<wtc:param value="<%=op_code%>"/>
<wtc:param value="<%=org_code%>"/>
</wtc:service>
<wtc:array id="initStr_1" start="0" length="18" scope="end"/>
<wtc:array id="initStr_2" start="19" length="2" scope="end"/>
<%	
if (Integer.parseInt(initRetCode) != 0) {
            response.sendRedirect("s6945Login.jsp?ReqPageName=s6945Main&retMsg=101&errCode=" + initRetCode + "&errMsg=" + initRetMsg);
        }
%>        
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=srv_no%>" id="sLoginAccept"/>
<%
    //流水   
    String loginAccept = sLoginAccept;
%>
<%
 	String cardName = "";
    String grpName = "";
    String attrCodeSqlStr = "select trim(attr_code) from dcustMsg where phone_no=:phoneNo1 and substr(run_code,2,1)<'a' and rownum<2";
    paraIn[0] =attrCodeSqlStr;
    paraIn[1] ="phoneNo1="+srv_no;
%>
<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
	<wtc:param value="<%=paraIn[0]%>"/>
	<wtc:param value="<%=paraIn[1]%>"/>
</wtc:service>		
<wtc:array id="attrCodeArr" scope="end"/>
<%
    if (attrCodeArr != null && attrCodeArr.length > 0) {
        String attrCode = attrCodeArr[0][0];
        String bigFlag = "";
        String grpFlag = "";
        if (!"".equals(attrCode)) {
            bigFlag = attrCode.substring(2, 4);
            grpFlag = attrCode.substring(4, 5);
            String cardNameSqlStr = "select trim(card_name) from sBigCardCode where card_type=:card_type";
            String grpNameSqlStr = "select trim(grp_name) from sGrpBigFlag where grp_flag=:grp_flag";
            paraIn[0]=cardNameSqlStr;
            paraIn[1]="card_type="+bigFlag;
            paraIn1[0]=grpNameSqlStr;
            paraIn1[1]="grp_flag="+grpFlag;
%>
<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
	<wtc:param value="<%=paraIn[0]%>"/>
	<wtc:param value="<%=paraIn[1]%>"/>
</wtc:service>
<wtc:array id="cardNameArr" scope="end"/>

<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
	<wtc:param value="<%=paraIn1[0]%>"/>
	<wtc:param value="<%=paraIn1[1]%>"/>	
</wtc:service>		
<wtc:array id="grpNameArr" scope="end"/>
<%
            if ((cardNameArr == null || cardNameArr.length == 0) && (grpNameArr == null || grpNameArr.length == 0)) {
                response.sendRedirect("s6945Login.jsp?ReqPageName=s6945Main&retMsg=2");
            }

            if (cardNameArr != null && cardNameArr.length > 0) {
                cardName = cardNameArr[0][0];
            }

            if (grpNameArr != null && grpNameArr.length > 0) {
                grpName = grpNameArr[0][0];
            }
        }
    }
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
$(function(){
	$("*[classCode]")&&$("*[classValue]").each(function(){
		$(this).tooltip();
	}); 
});

function printCommit()
{
    if(document.all.assuNote.value.length==0)
    {
    	rdShowMessageDialog("请输入用户备注！");
        document.all.assuNote.focus();
        return false;
    }
    frm.action = "s6945Cfm.jsp";
    frm.submit();
    showPrtDlg("Detail", "确实要进行电子免填单打印吗？", "Yes");
}
//--------4---------显示打印对话框----------------
function showPrtDlg(printType, DlgMessage, submitCfm)
{           
   		 
	//显示打印对话框 
	var h=210;
	var w=400;
   	var t = screen.availHeight / 2 - h / 2;
   	var l = screen.availWidth / 2 - w / 2;
		    
	var pType="subprint";              // 打印类型：print 打印 subprint 合并打印
	var billType="1";               //  票价类型：1电子免填单、2发票、3收据
	var sysAccept=document.all.loginAccept.value;               // 流水号
	var printStr = printInfo(printType); //调用printinfo()返回的打印内容
	var mode_code=null;               //资费代码
	var fav_code=null;
	var area_code=null;             //小区代码
   	var opCode="6945";                   //操作代码
   	var phoneNo=document.all.srv_no.value;                  //客户电话
   	
   	var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
   	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage + "&submitCfm=" + submitCfm+
   	           "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+
   	           "&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   	
   	var ret = window.showModalDialog(path, printStr, prop);
   	
   	if (typeof(ret) != "undefined")
   	{
   	    if (ret == "continueSub")
   	    {
   	        if (rdShowConfirmDialog('确认要提交变更信息吗？') == 1)
   	        {
   	            document.all.printcount.value = "0";
   	            conf();
   	        }
   	    }
   	}
   	else
   	{
   	    if (rdShowConfirmDialog('确认要提交变更信息吗？') == 1)
   	    {
   	        document.all.printcount.value = "0";
   	        conf();
   	    }
   	}

}
//--------5----------提交处理函数-------------------
function conf()
{
    frm.action = "s6945Cfm.jsp";
    frm.submit();
}
function printInfo(printType)
{

    var retInfo = "";
    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";

    cust_info += "客户姓名：" + document.all.cust_name.value + "|";
    cust_info += "手机号码：" + document.all.srv_no.value + "|";

    opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "  " + "用户品牌: " + document.all.sm_name.value + "|";
    document.all.strTmp.value = "";
    document.all.strTmp.value = "办理业务: 短信预约恢复  操作流水: " + document.all.loginAccept.value;
    opr_info += document.all.strTmp.value + "|";

    note_info1 = "备注:" + document.all.assuNote.value + "|";

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
</script>
</head>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="activePhone" value="<%=activePhone%>">
<input type="hidden" name="cust_info">
<input type="hidden" name="opr_info">
<input type="hidden" name="note_info1">
<input type="hidden" name="note_info2">
<input type="hidden" name="note_info3">
<input type="hidden" name="note_info4">
<input type="hidden" name="printcount">
<input type="hidden" name="ReqPageName" id="ReqPageName" value="s6945Main">
<input type="hidden" name="cust_id" id="cust_id" value="<%=initStr_1[0][0].trim()%>">
<input type="hidden" name="srv_no" id="srv_no" value="<%=srv_no%>">
<input type="hidden" name="sm_name" id="sm_name" value="<%=initStr_1[0][2].trim()%>">
<input type="hidden" name="cust_name" id="cust_name" value="<%=initStr_1[0][3].trim()%>">
<input type="hidden" name="iccid" id="iccid" value="<%=initStr_1[0][14].trim()%>">
<input type="hidden" name="comm_addr" id="comm_addr" value="<%=initStr_1[0][11].trim()%>">
<input type="hidden" name="userPrepay" id="userPrepay" value="<%=initStr_1[0][16].trim()%>">
<input type="hidden" name="vSmCode" value="<%=initStr_1[0][1].trim()%>">

<input type="hidden" name="loginAccept" value="<%=loginAccept%>">

<div class="title">
    <div id="title_zi">用户信息</div>
</div>
<table cellspacing="0">
<tr>
    <td class="blue">大客户标志</td>
    <td nowrap colspan="2">
        <b><font class="orange"><%=cardName%>
        </font></b>
    </td>
    <td class="blue" nowrap>集团标志</td>
    <td nowrap colspan="2">
        <%=grpName%>
    </td>
</tr>
<tr>
    <td class="blue" nowrap>用户ID</td>
    <td nowrap colspan="2"><%=initStr_1[0][0].trim()%>
    </td>
    <td class="blue" nowrap>客户名称</td>
    <td nowrap colspan="2"><%=initStr_1[0][3].trim()%>
    </td>
</tr>
<tr>
    <td class="blue" nowrap>当前状态</td>
    <td nowrap colspan="2"><%=initStr_1[0][6].trim()%>
    </td>
    <td nowrap class="blue">级别</td>
    <td nowrap colspan="2"><%=initStr_1[0][8].trim()%>
    </td>
</tr>


<tr>
    <td class="blue" nowrap>当前预存</td>
    <td nowrap colspan="2"><%=initStr_1[0][16].trim()%>
    </td>
    <td class="blue" nowrap>当前欠费</td>
    <td nowrap colspan="2"><%=initStr_1[0][15].trim()%>
    </td>
</tr>
</table>
</div>
<div id="Operation_Table">
<div class="title">
    <div id="title_zi">短信关停明细</div>
</div>
<table cellspacing="0" id="tr_iframe">
<tr align="center">
	<th>发送关停时间</th>
    <th>预约开通时间</th>  
</tr>
	<% 
				if(initRetCode.equals("000000"))
				{
				for(int j=0;j < initStr_2.length;j++){
					String tdClass = (j%2==0)?"Grey":"";
			%>
		    <tr>
			  <td class="<%=tdClass%>" align=center><%=initStr_2[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=initStr_2[j][1]%></td>
			</tr>				
			<%}
}
%>

</table>   
</div>    
<div id="Operation_Table">
    <div class="title">
        <div id="title_zi">业务办理</div>
    </div>
    <table cellspacing="0">
    <tr>
        <td class="blue" width=%25 align="center">用户备注</td>
         <td nowrap colspan="3" width=%75>
             <input name=assuNote v_must=0 v_maxlength=60 v_type="string" v_name="用户备注" maxlength="60"
                       size=100
                       index="6" value="">
         </td>
    </tr>
    <tr>
            <td colspan="7" id="footer">
                <input class="b_foot" type="button" name="b_print" value="确认" onClick="printCommit();">
                <input class="b_foot" type="button" name="b_clear" value="清除" onClick="frm.reset();">
            </td>
        </tr>
    </table>
     <input type=hidden name=strTmp size=60 value="">
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>    
    