<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-19
********************/
%>
              
<%
  String opCode = "5238";
  String opName = "���˲�Ʒ����";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.text.*"%>
<%
	//��ȡ�û�session��Ϣ
	String workName = (String)session.getAttribute("workName");          	//��������
	String workNo   = (String)session.getAttribute("workNo");                //����
	String nopass  = (String)session.getAttribute("password");                    	//��½����
	String regionCode = (String)session.getAttribute("regCode");
	
	//��ȡ����ҳ�õ�����Ϣ
	String login_accept = request.getParameter("login_accept");	
	String mode_code = request.getParameter("mode_code");
	String mode_name = request.getParameter("mode_name");	
	String region_code = request.getParameter("region_code");
	String sm_code = request.getParameter("sm_code");
	String begin_time = request.getParameter("begin_time");								
	String end_time = request.getParameter("end_time");	

	String errCode="";
    String errMsg="";
    String paramsIn[] = new String[6];
    paramsIn[0] = workNo;				//����
    paramsIn[1] = nopass;				//����
    paramsIn[2] = "5238";				//OP_CODE
    paramsIn[3] = login_accept;			//������ˮ
	paramsIn[4] = mode_code;			// 
	paramsIn[5] = region_code;			// 

    	  
	//acceptList = impl.callFXService("s5238_accValid",paramsIn,"2");
	%>
	
	    <wtc:service name="s5238_accValid" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />			
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />
		</wtc:service>
		<wtc:array id="result_t" scope="end" />
	
	<%
	errCode=code;   
	System.out.println("-------------errCode----------------"+errCode);
	errMsg=msg;
	if(!errCode.equals("000000"))
    {

%>
    	    <script language='javascript'>
    	    	rdShowMessageDialog("������Ϣ<%=errCode%>" + "��" + "<%=errMsg%>" + "��" ,0);
		        history.go(-1);
    	    </script>
<%		}
%>
<%
  //�����ʷ�������Ϣ
  String[][] result1 = new String[][]{};
  String sqlStr1 = "select note from tMidBillModeCode where login_accept="+login_accept;
 // retArray1 = impl.sPubSelect("1", sqlStr1);
  %>
  
  		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
  
  <%
  result1 = result_t;
  String vModeNote = result1[0][0];

%>
<html>
<head>
<base target="_self">
<title>���˲�Ʒ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 
onload=function() 
{
	 self.status="";
	 queryRelationFlag();
}	

//��ѯ�������ù����״̬
function queryRelationFlag()
{
	var myPacket = new AJAXPacket("f5238_rpc_queryRelationFlag.jsp","�����ύ�����Ժ�......");
	myPacket.data.add("login_accept","<%=login_accept%>");
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}

//-----RPC����------
function doProcess(packet) 
{
	self.status="";
	var errCode=packet.data.findValueByName("errCode");
	var errMsg=packet.data.findValueByName("errMsg");
	
	var change_flag=packet.data.findValueByName("change_flag");
	var depend_flag=packet.data.findValueByName("depend_flag");
	var limit_flag=packet.data.findValueByName("limit_flag");

	if(parseInt(errCode)!=0)
	{
		rdShowMessageDialog("�������"+errCode+",������Ϣ"+errMsg,0);
		return false;
	}
	else
	{
		if(change_flag=="Y")
		{
			document.form1.change_flag.value="������";
			document.form1.change_flag.style.color="black";
		}
		else
		{
			document.form1.change_flag.value="δ����";
			document.form1.change_flag.style.color="red";
		}
		if(depend_flag=="Y")
		{
			document.form1.depend_flag.value="������";
			document.form1.depend_flag.style.color="black";
		}
		else
		{
			document.form1.depend_flag.value="δ����";
			document.form1.depend_flag.style.color="red";
		}
		if(limit_flag=="Y")
		{
			document.form1.limit_flag.value="������";
			document.form1.limit_flag.style.color="black";
		}
		else
		{
			document.form1.limit_flag.value="δ����";
			document.form1.limit_flag.style.color="red";
		}
	}
}

//���ò�Ʒ�������
function deployChange()
{
	document.form1.changeButton.disabled=true;
	var url = "f5238_deployChange.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=600,width=800,left=30,top=30,scrollbars=yes');
}
 
//���ò�Ʒ��������
function deployDepend()
{
	document.form1.dependButton.disabled=true;
	var url = "f5238_deployDepend.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=600,width=800,left=30,top=30,scrollbars=yes');
}

//���ò�Ʒ�������
function deployLimit()
{
	document.form1.limitButton.disabled=true;
	var url = "f5238_deployLimit.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=600,width=800,left=30,top=30,scrollbars=yes');
}


function frmCfm()
{
	
		document.form1.action="f5238_6.jsp"; 
		document.form1.submit();
	
}

function submitAdd(){
 
    var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
    if(typeof(ret)!="undefined")
    {
      if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('ȷ���ύ�����ʷ�������Ϣ��')==1)
        {
	      frmCfm();
        }
	  }
	  if(ret=="continueSub")
	  {
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ�ʷ�������Ϣ��')==1)
        {
	      frmCfm();
        }
	  }
    }
    else
    {
       if(rdShowConfirmDialog('ȷ��Ҫ�ύ�ʷ�������Ϣ��')==1)
       {
	     frmCfm();
       }
    }	
	return true;
  }
/*********************************************************
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի��� 
     var h=150;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo(printType);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 

     var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =<%=login_accept%>;                       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                        //�ʷѴ���
     var fav_code=null;                         //�ط�����
     var area_code=null;                        //С������
     var opCode =   "<%=opCode%>";                         //��������
     var phoneNo = <%=activePhone%>;                            //�ͻ��绰
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);  
     return ret;    
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

	  opr_info+="�ʷѴ��룺"+"<%=mode_code%>"+"|";
	  opr_info+="�ʷ����ƣ�" +"<%=mode_name%>"+"|";
	  opr_info+="ҵ��Ʒ�ƣ�"+"<%=sm_code%>"+"|";
	  opr_info+="��ʼʱ�䣺"+"<%=begin_time%>"+"|";
	  opr_info+="����ʱ�䣺"+"<%=end_time%>"+"|";
	  opr_info+="������ˮ��"+"<%=login_accept%>"+"|";
	  note_info1+="�Ż�������"+"<%=vModeNote%>"+"|";

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
	  return retInfo;
  }
********************************************************************/
function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի��� 
     var h=150;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo(printType);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     var path = "<%=request.getContextPath()%>/npage/innet/hljGdPrintNew.jsp?DlgMsg=" + DlgMessage;
     var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
     var ret=window.showModalDialog(path,"",prop);
     return ret;    
  }

  function printInfo(printType)
  {
	  var retInfo = "";
	  var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//�õ�ִ��ʱ��

      retInfo+='<%=workNo%>   <%=workName%>'+"|";
	  retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";

	  retInfo+="�ʷѴ��룺"+"<%=mode_code%>"+"|";
	  retInfo+="�ʷ����ƣ�" +"<%=mode_name%>"+"|";
	  retInfo+="ҵ��Ʒ�ƣ�"+"<%=sm_code%>"+"|";
	  retInfo+="��ʼʱ�䣺"+"<%=begin_time%>"+"|";
	  retInfo+="����ʱ�䣺"+"<%=end_time%>"+"|";
	  retInfo+="������ˮ��"+"<%=login_accept%>"+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+="�Ż�������"+"<%=vModeNote%>"+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";

	  return retInfo;
  }
function submitback()
{
	document.form1.action="f5238_3.jsp"; 
	document.form1.submit();
}
</script>
</head>

<body>
 
	  <form name="form1"  method="post">
	  	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">���˲�Ʒ����-��Ʒ��ϵ����</div>
	</div>
	  	<input type="hidden" name="login_accept" value="<%=login_accept%>">
	  	<input type="hidden" name="mode_code" value="<%=mode_code%>">
	  	<input type="hidden" name="mode_name" value="<%=mode_name%>">
	  	<input type="hidden" name="region_code" value="<%=region_code%>">
	  	<input type="hidden" name="sm_code" value="<%=sm_code%>">
	  	<input type="hidden" name="begin_time" value="<%=begin_time%>">
	  	<input type="hidden" name="end_time" value="<%=end_time%>">
	  	<input type="hidden" name="page_flag" value="1" color="red">
	  	<TR >
	  		<TD >
	  		  	<TABLE  id="mainOne" cellspacing="0" >
	            <TBODY>
	  	        	<TR >
	  					<TD width="23%" valign="top">
	  						<table id="mainTwo" cellspacing="0" border="0">
	  							<tr  height="25">
	  								<TD >&nbsp;&nbsp;&nbsp;&nbsp;<b>��Ʒ���ò���</b></TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;1.���ò�Ʒ����</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;2.���ò�Ʒ��ϸ</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;3.�ʷѹ�������</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;4.���ػ�����</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;<font class="orange">5.��Ʒ��ϵ����</font></TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;6.���</TD>
	  							</tr>
	  						</table>
	  					</TD>
	  					<TD width="77%" valign="top">
	  						<table   id="mainThree cellspacing="0" >
	  							<tr  height="22">
	  								<TD width="30%" class="blue">&nbsp;&nbsp;��ǰ������ˮ��</TD>
	  								<TD width="70%"><font class="orange"><%=login_accept%></font></TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD class="blue">&nbsp;&nbsp;��Ʒ����	</TD>
	  								<TD>
	  									<%=mode_code%>
	  								</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD class="blue">&nbsp;&nbsp;״̬&nbsp;&nbsp;<input type="text" name="change_flag" value="δ����"   size="8" ></TD>
	  								<TD>
	  									 <input name="changeButton" type="button"   class="b_text"  value="���ò�Ʒ�������" disabled onClick="deployChange();">
	  								</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD class="blue">&nbsp;&nbsp;״̬&nbsp;&nbsp;<input type="text" name="depend_flag" value="δ����"  size="8"></TD>
	  								<TD>
	  									 <input name="dependButton" type="button"   class="b_text"  value="���ò�Ʒ��������" disabled onClick="deployDepend();">
	  								</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD class="blue">&nbsp;&nbsp;״̬&nbsp;&nbsp;<input type="text" name="limit_flag" value="δ����"  size="8"></TD>
	  								<TD>
	  									 <input name="limitButton" type="button"  class="b_text"  value="���ò�Ʒ�������" disabled onClick="deployLimit();">
	  								</TD>
	  							</tr>
	  						</table>
	  					</TD>
	  	        	</TR> 
	            </TBODY>
	          	</TABLE>
	          	<TABLE cellSpacing="0">
	  			  <TR >
	  				<TD height="30" align="center" id="footer">
	          	 	    <input name="lastButton" type="button" class="b_foot" value="��һ��" onClick="submitback()">
	          	 	    &nbsp;
	          	 	    <input name="nextButton" type="button"   class="b_foot" value="��һ��" onClick="submitAdd()" >
	          	 	    &nbsp;
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  	<%@ include file="/npage/include/footer.jsp" %>
	  </form>
</body>
</html>

