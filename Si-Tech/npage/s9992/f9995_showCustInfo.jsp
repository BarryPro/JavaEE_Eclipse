<%
    /*************************************
    * ��  ��: �ֻ�֧�����˻��ֽ��ֵ���� 9995
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2011-11-2
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
<title>�ֻ�֧�����˻��ֽ��ֵ</title>
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
//----------------��֤���ύ����-----------------
function doCfm()
{
	frm.action="f9995Cfm.jsp";
	document.all.opCode.value="9995";
  	frm.submit();
}

function printCommit()
{
	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
	if(typeof(ret)!="undefined")
	{
		if((ret=="confirm"))
		{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
			{
				doCfm();
			}
		}
		if(ret=="continueSub")
		{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
			{
				doCfm();
			}
		}
	}
	else
	{
		if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		{
			doCfm();
		}
	}
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
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
	 
	cust_info+="�ֻ����룺   "+document.all.phoneNo.value+"|";
	cust_info+="�ͻ�������   "+document.all.custName.value+"|";
	
	opr_info+="������ˮ�� <%=printAccept%>"+"|";
	
	var opCode = "<%=opCode%>";
	opr_info+="�������ݣ� �ֻ�����"+document.all.phoneNo.value+"Ӫҵ���ֽ��ֵ����"+"|";
	note_info1+="��ע��Ӫҵ���ֽ��ֵ����"+"|";
  	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

function getCustName() {
	var getCustName_Packet = new AJAXPacket("getCustName.jsp","���ڻ�ȡ�ͻ����ƣ����Ժ�......");
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
                      rdShowMessageDialog("û�в�ѯ����������²�ѯ��");
                      window.location="f9995_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone1%>";
                 </script>
                <%
            	}else if(result.length>0){
                %>
        <TR>
	          <TD class="blue" >����</TD>
	          <TD>
				<input type="text" class="InputGrey" name="districtCodeName" id="districtCodeName" value="<%=result[0][2]%>" readonly />
	         </TD>
	         <TD class="blue" >Ӫҵ��</TD>
	          <TD>
				<input type="text" class="InputGrey" name="groupName" id="groupName" value="<%=result[0][3]%>" readonly />
	         </TD>
         </TR>
         <TR>
	          <TD class="blue">��������</TD>
	          <TD>
				<input type="text" class="InputGrey" name="operateNo" id="operateNo" value="<%=result[0][0]%>" readonly />
	         </TD>
	         <TD class="blue" >����ʱ��</TD>
	          <TD>
				<input type="text" class="InputGrey"  name="operateTime" id="operateTime" value="<%=result[0][1]%>" readonly />
	         </TD>
         </TR>
         <tr>
            <td colspan="4" align="center" id="footer">
                <input class="b_foot" type="button" name="confirm" value="�ύ" onClick="getCustName()" />    
                <input class="b_foot" type="button" name="backBtn" value="����" onClick="backInfo();" />
                <input class="b_foot" type="button" name=qryP value="�ر�" onClick="removeCurrentTab();" />
            </td>
        </tr>
		<%
		        }
    	    }else{
		%>
	     <script language=javascript>
	          rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
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
