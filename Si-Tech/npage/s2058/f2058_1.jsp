<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<head>
<title>��e��������/�ֻ����Ӱ�����</title>
<%
	String workNoFromSession=(String)session.getAttribute("workNo");
	String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	session.removeAttribute("userPhoneNo");
	String op_code = "2058";
    String opCode = "2058";
    String op_name="��e��������/�ֻ����Ӱ�����";
    String opName="��e��������/�ֻ����Ӱ�����";
    
    String work_no =(String)session.getAttribute("workNo");
    String loginName =(String)session.getAttribute("workName");
    String orgCode =(String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    activePhone = request.getParameter("activePhone");
    String printAccept="";
	printAccept = getMaxAccept();
	
	StringBuffer  insql = new StringBuffer();
	insql.append("select product_code,product_desc from dTDPRODREL ");
	insql.append("  where pack_numb='ADD_PACKAGE' and region_code = '"+regionCode+"' ");
	System.out.println("insql====="+insql);
	
	StringBuffer  sql = new StringBuffer();
	sql.append("select add_months(to_date(to_char(sysdate,'yyyymm')||'01','yyyy-mm-dd'),1)-1 ");
	sql.append("  from dual  ");
	System.out.println("sql====="+sql);

%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="3">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="rateResult" scope="end" />

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end" />


<script language=javascript>

onload=function()
{
	self.status="";
	init();
}

function init()
{
	with(document.frm)
	{
		var myPacket = new AJAXPacket("../s1873/f1874Init.jsp","���ڻ����Ϣ�����Ժ�......");
		myPacket.data.add("phone_no",phone_no.value);
		myPacket.data.add("opType","init");
		core.ajax.sendPacket(myPacket);	
		myPacket=null;
	}
}

function doProcess(packet)
{
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var opType = packet.data.findValueByName("opType");
	var result = packet.data.findValueByName("result");
	if(retCode == "000000"){
		if(opType == "init")
		{
			with(document.frm)
			{
				cust_name.value = result[2];
				sm_code.value = result[5];
			}
		}else
		{
			window.location.replace("f2058_1.jsp?activePhone=<%=activePhone%>");
		}
	}
}

function printCommit()
{
	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
	if(typeof(ret)!="undefined")
	{
		if((ret=="confirm"))
		{
			if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
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

function doCfm()
{
	frm.submit();
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
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept=<%=printAccept%>&phoneNo=<%=activePhone%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
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
	 
	cust_info+="�ֻ����룺   "+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������   "+document.all.cust_name.value+"|";

	opr_info+="�û�Ʒ�ƣ�"+document.all.sm_code.value+"           ҵ�����ͣ���E��G3�����ʼǱ�/�ֻ����������Ӱ�����"+"|";
	opr_info+="������ˮ: <%=printAccept%>"+"|";
	opr_info+="���ΰ����ײ�: "+document.all.rateCode.value+"-->"+document.all.rateName.value+"|";
	opr_info+="�ʷ���Чʱ�䣺<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%> "+"|";
 	opr_info+="�ʷ�ʧЧʱ�䣺"+document.all.lastDay.value+"|";
	
	note_info1+="��ע��"+"|";
  	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;	
}

</script>
</head>
<body>
<form name="frm" method="POST" action="f2058Cfm.jsp">
	<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
	<div id="title_zi">��e��������/�ֻ����Ӱ�����</div>
  	</div>
  	<input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
  	<input type="hidden" name="org_code" id="org_code" value="<%=orgCode%>">
  	<input type="hidden" name="work_no" id="work_no" value="<%=work_no%>">
  	<input type="hidden" name="rateCode" id="rateCode" value="<%=rateResult[0][0]%>">
  	<input type="hidden" name="rateName" id="rateName" value="<%=rateResult[0][1]%>">
  	<input type="hidden" name="cust_name" id="cust_name" class="InputGrey">
  	<input type="hidden" name="sm_code" id="sm_code" class="InputGrey">
  	<input type="hidden" name="printAccept" id="printAccept" value="<%=printAccept%>">
  	<input type="hidden" name="lastDay" id="lastDay" value="<%=(result1[0][0]).substring(0,8)%>">
    <table width="98%" border="0" cellspacing="1" align="center" bgcolor="#FFFFFF">
    	<tr bgcolor="e8e8e8">
           	<td width="20%" nowrap class="blue"> 
           		<div align="left" >�������</div>
           	</td>
           	<td>
           		<div align="left">
               	<input type="text" size="12" name="phone_no" id="phone_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   maxlength="11" index="0"  Class="InputGrey" readOnly  value ="<%=activePhone%>">
				</div>
           	</td>
    	</tr>
    	<tr>
        	<td colspan="5" class="blue"> 
            <div align="center"> 
            	<input class="b_foot" type=button name=confirm value="ȷ��" onClick="printCommit()">    
		  		<input class="b_foot" type=button name=close value="�ر�" onClick="parent.removeTab('<%=opCode%>');">
        	</div>
      		</td>
    	</tr>
	</table>	
   	<%@ include file="/npage/include/footer.jsp"%>
</form>
</body>
</html>