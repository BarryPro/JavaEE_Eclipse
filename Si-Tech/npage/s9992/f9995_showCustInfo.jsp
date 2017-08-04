<%
    /*************************************
    * 功  能: 手机支付主账户现金充值冲正 9995
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-11-2
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>手机支付主账户现金充值</title>
<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String activePhone1=request.getParameter("activePhone");
    String operateAccept=request.getParameter("operateAccept");
    String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
    
    String sql= "select a.login_no,"
                +" to_char(a.op_time,'yyyy-mm-dd hh24:mm:ss'),"
                +"(select b.group_name"
                +" from dchngroupmsg b, dchngroupinfo c, dloginmsg d"
                +" where b.group_id = c.parent_group_id"
                +" and d.group_id = c.group_id"
                +"  and b.root_distance = '3'"
                +" and d.login_no = a.login_no),"
                +" (select b.group_name"
                +"  from dchngroupmsg b, dchngroupinfo c, dloginmsg d"
                +" where b.group_id = c.parent_group_id"
                +" and d.group_id = c.group_id"
                +" and b.root_distance = '4'"
                +"  and d.login_no = a.login_no)"
                +" from sphonepaymsg a"
                +" where a.login_accept = '"+operateAccept+"'";
                
     System.out.println("-------------9995----------sql="+sql);
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regionCode" routerValue="<%=regionCode%>" id="printAccept"/>

<wtc:pubselect name="sPubSelect"  routerKey="regionCode" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
//----------------验证及提交函数-----------------
function doCfm()
{
	frm.action="f9995Cfm.jsp";
	document.all.opCode.value="9995";
  	frm.submit();
}

function printCommit()
{
	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
	if(typeof(ret)!="undefined")
	{
		if((ret=="confirm"))
		{
			if(rdShowConfirmDialog('确认要提交信息吗？')==1)
			{
				doCfm();
			}
		}
		if(ret=="continueSub")
		{
			if(rdShowConfirmDialog('确认要提交信息吗？')==1)
			{
				doCfm();
			}
		}
	}
	else
	{
		if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		{
			doCfm();
		}
	}
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";  
	var printStr = printInfo(printType);
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept=<%=printAccept%>&phoneNo=<%=activePhone1%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}

function printInfo(printType)
{
     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
  
	 var retInfo = "";
	 
	cust_info+="手机号码：   "+document.all.phoneNo.value+"|";
	cust_info+="客户姓名：   "+document.all.custName.value+"|";
	
	opr_info+="操作流水： <%=printAccept%>"+"|";
	
	var opCode = "<%=opCode%>";
	opr_info+="受理内容： 手机号码"+document.all.phoneNo.value+"营业厅现金充值冲正"+"|";
	note_info1+="备注：营业厅现金充值冲正"+"|";
  	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

function getCustName() {
	var getCustName_Packet = new AJAXPacket("getCustName.jsp","正在获取客户名称，请稍候......");
	getCustName_Packet.data.add("phoneNo","<%=activePhone1%>");
	core.ajax.sendPacket(getCustName_Packet, doGetCustName);
	getCustName_Packet=null;
}

function doGetCustName(packet) {
	document.all.custName.value = packet.data.findValueByName("custName");
	printCommit();
}

function backInfo(){
    window.location="f9995_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone1%>";
}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %> 	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		 <table cellspacing="0">
		<%
		    if("000000".equals(retCode)){
                if(result.length==0){
                    System.out.println("----------9995--------result.length="+result.length);
                %>
                 <script language=javascript>
                      rdShowMessageDialog("没有查询结果！请重新查询！");
                      window.location="f9995_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone1%>";
                 </script>
                <%
            	}else if(result.length>0){
                %>
        <TR>
	          <TD class="blue" >区县</TD>
	          <TD>
				<input type="text" class="InputGrey" name="districtCodeName" id="districtCodeName" value="<%=result[0][2]%>" readonly />
	         </TD>
	         <TD class="blue" >营业厅</TD>
	          <TD>
				<input type="text" class="InputGrey" name="groupName" id="groupName" value="<%=result[0][3]%>" readonly />
	         </TD>
         </TR>
         <TR>
	          <TD class="blue">操作工号</TD>
	          <TD>
				<input type="text" class="InputGrey" name="operateNo" id="operateNo" value="<%=result[0][0]%>" readonly />
	         </TD>
	         <TD class="blue" >操作时间</TD>
	          <TD>
				<input type="text" class="InputGrey"  name="operateTime" id="operateTime" value="<%=result[0][1]%>" readonly />
	         </TD>
         </TR>
         <tr>
            <td colspan="4" align="center" id="footer">
                <input class="b_foot" type="button" name="confirm" value="提交" onClick="getCustName()" />    
                <input class="b_foot" type="button" name="backBtn" value="返回" onClick="backInfo();" />
                <input class="b_foot" type="button" name=qryP value="关闭" onClick="removeCurrentTab();" />
            </td>
        </tr>
		<%
		        }
    	    }else{
		%>
	     <script language=javascript>
	          rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
	          window.location="f9995_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone1%>";
	     </script>
		<%
		    }
		%>
      </table>
<input type="hidden" name="operateAccept" value="<%=operateAccept%>" />
<input type="hidden" name="printAccept" value="<%=printAccept%>" />
<input type="hidden" name="opCode" value="<%=opCode%>" />
<input type="hidden" name="opName" value="<%=opName%>" />
<input type="hidden" name="custName" value="" />
<input type="hidden" name="phoneNo" value="<%=activePhone1%>" />

<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
