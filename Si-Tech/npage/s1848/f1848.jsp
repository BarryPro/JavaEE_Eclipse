<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!-------------------------------------------->
<!---����:  2008-11-14 14:56:27    ---->
<!---����:  jiangqing                       ---->
<!---����:  f1848                         ---->
<!---���ܣ���Ƶ����                       ---->
<!---�޸ģ��������ͨ��ע����ԤԼ��ȡ��ԤԼ         ---->
<!-------------------------------------------->
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>
<!-------------------�������Զ����ò�ѯWTC����------------------------>
<%
String opCode = "1848";
String opName = "��Ƶ����";
String op_name="";
String regionCode = (String)session.getAttribute("regCode");
String phone_no=request.getParameter("phone_no");
String work_no =(String)session.getAttribute("workNo");
String loginName =(String)session.getAttribute("workName");
%>
<wtc:service name="s1848Qry" outnum="9" routerKey="phone" routerValue="<%=phone_no%>">
<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="result"  start="0" length="9"  scope="end" />
<%
String return_code="";
String return_msg="";
String id_no = "";
String cust_name="";
String run_code="";
String run_name="";
String opr_code="";
String cust_address="";
String id_iccid="";

return_code = result[0][0].trim();
return_msg = result[0][1].trim();
id_no = result[0][2].trim();
cust_name = result[0][3].trim();
run_code = result[0][4].trim();
run_name = result[0][5].trim();
opr_code = result[0][6].trim();
cust_address = result[0][7].trim();
id_iccid = result[0][8].trim();
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
%>
<%
String sqlAgentCode = " select  a.conf_id,decode(conf_type,'01','��Ƶ','02','��Ƶ'),to_char(start_time,'yyyymmdd hh24:mi:ss'),to_char(end_time,'yyyymmdd hh24:mi:ss'),Conf_Cont from dtdmeetinfo a,dcustmsg b where a.id_no=b.id_no and b.phone_no = '"+phone_no+"' and  a.opr_code = '21' and a.end_time>sysdate";
System.out.println("sqlAgentCode====="+sqlAgentCode);
System.out.println("phone_no====="+phone_no);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="5">
<wtc:sql><%=sqlAgentCode%></wtc:sql>
</wtc:pubselect>
<wtc:array id="agentCodeStr" scope="end" />
<%
  //���ж�һ���ǲ��Ƿ������ʧ��
          if(retCode1.equals("0")||retCode1.equals("000000")){
          System.out.println("���÷���sPubSelect  �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	      System.out.println("agentCodeStr.lengthagentCodeStr.length="+agentCodeStr.length);
 	        	
 	     	}else{
 			System.out.println("���÷���sPubSelect ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			 
					%>
						<script language="JavaScript">
							rdShowMessageDialog("�������ʧ�ܣ�");
							history.go(-1);
						</script>
					<%
 			
 			}
%>
<html>
<head>
<title><%=opName%></title>
<script type="text/javascript">
onload=function()
{
	var runcode = "<%=run_code%>";
	var opr_code = "<%=opr_code%>"==""?"00":"<%=opr_code%>";
	var return_code="<%=return_code%>";
	var return_msg="<%=return_msg%>";
	if(return_code=="000000")
	{
  		if(runcode != 'A' && runcode != 'K')
  		{
  			document.getElementById("kt").disabled=true;
       		//document.getElementById("yy").disabled=true;
        	document.getElementById("qx").disabled=true;
        	document.getElementById("zx").disabled=true;
        	rdShowMessageDialog("���û�����״̬�����������ܰ���ҵ��");
			parent.removeTab('<%=opCode%>');
     	}
		else
		{
     		if(opr_code=="00")
			{
				document.getElementById("kt").disabled=false;
	        	//document.getElementById("yy").disabled=true;
	        	document.getElementById("qx").disabled=true;
	        	document.getElementById("zx").disabled=true;
			}
			else
			{
				document.getElementById("kt").disabled=true;
				if(opr_code=="01")
				{
		        	//document.getElementById("yy").disabled=false;
		        	document.getElementById("qx").disabled=false;
		        	document.getElementById("zx").disabled=false;
				}
				
				if(opr_code=="21")
				{
		        	//document.getElementById("yy").disabled=true;
		        	document.getElementById("qx").disabled=false;
		        	document.getElementById("zx").disabled=false;
				}
				
				if(opr_code=="02")
				{
		        	//document.getElementById("yy").disabled=true;
		        	document.getElementById("qx").disabled=true;
		        	document.getElementById("zx").disabled=true;
		        	rdShowMessageDialog("�û��Ѿ�ע����ҵ��������һ���ٰ���ҵ��");
		        	parent.removeTab('<%=opCode%>');
				}
			}	
		}
	}else
	{
		rdShowMessageDialog("����:"+return_code+return_msg);
		history.go(-1);
	}
}
var arrcofid =new Array();
var arrbegin =new Array();
var arrend =new Array();
var arrcof =new Array();
var arrtype =new Array();
<%  
  for(int i=0;i<agentCodeStr.length;i++)
  {
	out.println("arrcofid["+i+"]='"+agentCodeStr[i][0]+"';\n");
	out.println("arrtype["+i+"]='"+agentCodeStr[i][1]+"';\n");
	out.println("arrbegin["+i+"]='"+agentCodeStr[i][2]+"';\n");
	out.println("arrend["+i+"]='"+agentCodeStr[i][3]+"';\n");
	out.println("arrcof["+i+"]='"+agentCodeStr[i][4]+"';\n");
  }  
  
%>
function cofidchg()
{
	document.all.query_type.value="";
	document.all.query_begin.value="";
	document.all.query_end.value="";
	document.all.query_cof.value="";
	for ( x1 = 0 ; x1 < arrcofid.length  ; x1++ )
   	{		//alert(arrsaletype[x1]);
   		//alert(document.all.phone_type.value);
      		if ( arrcofid[x1] == document.all.conf_id.value )
      		{
      			document.all.query_type.value=arrtype[x1];
        		document.all.query_begin.value=arrbegin[x1];
        		document.all.query_end.value=arrend[x1];
        		document.all.query_cof.value=arrcof[x1];
      		}
   	}
}
function show()
{
	/*if(document.getElementById("yy").checked)
	{
		document.getElementById("booking_vc").style.display="block";
	}else{
		document.getElementById("booking_vc").style.display="none";
	}
	*/
	if(document.getElementById("qx").checked)
	{
		document.getElementById("booking_vc1").style.display="block";
	}else{
		document.getElementById("booking_vc1").style.display="none";
	}
}

function doCfm()
{
	getAfterPrompt();
	var count = 0;
	var oprcode;
	var conf_type;
	for(var i = 0 ; i < document.frm.opr_code.length ; i ++)
	{
		if(document.all.opr_code[i].checked)
		{
			count += 1;
			oprcode = document.frm.opr_code[i].value;
		} 
	}
	if(count == 0)
	{
		rdShowMessageDialog("������ѡ��һ�������");
		return;	
	}
	for(var i = 0 ; i < document.frm.conf_type.length ; i ++)
	{
		if(document.all.conf_type[i].checked)
		{
			count += 1;
			conf_type = document.frm.conf_type[i].value;
		} 
	}
	if(document.getElementById("qx").checked && document.all.conf_id.value=="" )
	{
		rdShowMessageDialog("��ѡ�����ID!");
			return false;
	}
/*
	if(document.getElementById("yy").checked)
	{
		if(document.frm.max_speaker_num.value - document.frm.max_num.value > 0)
		{
			rdShowMessageDialog("����ͬʱ��෢���������ܴ�������������,����������!");
			return false;
		}
		if(!forDate(document.frm.start_time)){
			rdShowMessageDialog("ԤԼʱ�������ʽ����ȷ,����������!");
			return false;
		}
		if(!forDate(document.frm.end_time)){
			rdShowMessageDialog("����ʱ�������ʽ����ȷ,����������!");
			return false;
		}
		var start_time=document.frm.start_time.value;
		var end_time=document.frm.end_time.value;
		if(start_time >= end_time)
		{
			rdShowMessageDialog("��ʼʱ�����С�ڽ���ʱ�䣡");
			return false;
		}
	}
	*/
	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
  	if(typeof(ret)!="undefined")
  	{
    	if((ret=="confirm"))
    	{
      		if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
      		{
	    		frmCfm();
      		}
		}
		if(ret=="continueSub")
		{
      		if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
      		{
	    		frmCfm();
      		}
		}
  	}
  	else
  	{
     	if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
     	{
	   	frmCfm();
     	}
  	}
  	return true;
	
	
}
function frmCfm(){
	frm.action="f1848_cfm.jsp";
	frm.submit();
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
	
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	//alert("ccccccccccccc");
	var pType="subprint";
	var billType="1";  
	var printStr = printInfo(printType);
 	var sysAccept = document.all.login_accept.value;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phone_no%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;

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
	 var count=0;
	 var oprcode="";
	 var opr_name="";
  
	 var retInfo = "";
	cust_info+="�ֻ����룺   "+"<%=phone_no%>"+"|";
	cust_info+="�ͻ�������   "+"<%=cust_name%>"+"|";
	cust_info+="�ͻ���ַ��   "+"<%=cust_address%>"+"|";
	cust_info+="֤�����룺   "+"<%=id_iccid%>"+"|";
	for(var i = 0 ; i < document.frm.opr_code.length ; i ++)
	{
		if(document.all.opr_code[i].checked)
		{
			count += 1;
			oprcode = document.frm.opr_code[i].value;
		} 
	}
	if(oprcode=="01")
	{
		opr_name="��ͨ";
	}else if(oprcode=="02")
	{	opr_name="ע��";
	}
	opr_info+="ҵ�����ͣ���Ƶ����"+opr_name+"|";
	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;	
}

</script>
</head>
<body>
<form name="frm">
	<%@ include file="/npage/include/header.jsp" %>   
	<div class="title">
	<div id="title_zi">��Ƶ����</div>
	</div>
    <table width="98%"  cellspacing="2">
    	<tr> 
			<td  nowrap><input type="hidden" name="phone_no" value="<%=phone_no%>"></td>
			<td  nowrap><input type="hidden" name="work_no" value="<%=work_no%>"></td>
		</tr>
		<tr > 
			<td width="10%"  nowrap>�ֻ�����</td>
			<td nowrap><%=phone_no%></td>
		</tr>
		<tr> 
			<td width="10%" nowrap>�ͻ�����</td>
			<td  nowrap>
			  <%if(cust_name.trim().equals("unknow")){out.print("<font color=#880000>�ͻ�����δ�Ǽ�</font>");}else{out.print(cust_name);}%>
			</td>
		</tr>
		<tr > 
		      <td width="10%"  >�ͻ���ַ</td>
			  <td  nowrap><%=cust_address%></td>
			 
		   </tr>
		   <tr > 
		      <td width="10%"  >֤������</td>
			  <td  nowrap><%=id_iccid%></td>
		   </tr>
		<tr > 
		    <td width="10%"  nowrap>��ǰ�ֻ�״̬</td>
			<td nowrap>
				<font color="#880000"><%=run_name%></font>
			</td>
		</tr>
		<tr> 
			<td width="10%"  nowrap>��������</td>
			<td  nowrap>
			    <input type="radio" name="opr_code" id="kt" value="01" onclick="show();">����&nbsp;
			    
			    <!--<input type="radio" name="opr_code" id="yy" value="21" onclick="show();">ԤԼ����&nbsp;
			   -->
			    <input type="radio" name="opr_code" id="qx" value="22" onclick="show();">ȡ��ԤԼ&nbsp;
			    
				<input type="radio" name="opr_code" id="zx" value="02" onclick="show();">ע��&nbsp;
			</td>
		</tr>
		<!--
		<tr> 
			<td width="10%"  nowrap> ϣ����Чʱ��</td>
			<td  nowrap>
				<input type="text" name="effeti_time" id="effeti_time" v_type="date" v_format = "yyyyMMdd" v_name="��Чʱ��" size="20" maxlength="8"/>
			</td>
		</tr>
		<tr> 
			<td width="10%"  nowrap> SP��ҵ����</td>
			<td  nowrap>
				<input type="text" name="sp_id" id="sp_id" size="20" maxlength="18"/>
			</td>
		</tr>
		<tr height="26"> 
			<td width="10%"  nowrap> SP�ײʹ���</td>
			<td  nowrap>
				<input type="text" name="pack_numb" id="pack_numb" size="20" maxlength="24"/>
			</td>
		</tr>
		<tr> 
			<td width="10%"  nowrap> SPҵ�����</td>
			<td  nowrap>
				<input type="text" name="biz_code" id="biz_code" size="20" maxlength="10"/>
			</td>
		</tr>
		-->
	<tbody id="booking_vc" style="display:none;">
		<tr> 
			<td width="10%"  nowrap> ��������</td>
			<td  nowrap>
				<input type="radio" name="conf_type" id="yp" value="01" checked>��Ƶ&nbsp;
				<input type="radio" name="conf_type" id="sp" value="02">��Ƶ&nbsp;
			</td>
		</tr>
		<tr> 
			<td width="12%"  nowrap> ����������</td>
			<td nowrap>
				<select size="1" name="max_num" id="max_num">
					<option value="1" selected>1��</option>
					<option value="2">2��</option>
					<option value="3">3��</option>
					<option value="4">4��</option>
					<option value="5">5��</option>
					<option value="6">6��</option>
					<option value="7">7��</option>
					<option value="8">8��</option>
				</select>
			</td>
		</tr>
		<tr> 
			<td width="12%"  nowrap> ͬʱ��෢������</td>
			<td nowrap>
				<select size="1" name="max_speaker_num" id="max_speaker_num">
					<option value="1" selected>1��</option>
					<option value="2">2��</option>
					<option value="3">3��</option>
					<option value="4">4��</option>
					<option value="5">5��</option>
					<option value="6">6��</option>
					<option value="7">7��</option>
					<option value="8">8��</option>
				</select>
			</td>
		</tr>
		<tr > 
			<td width="10%" nowrap> ���鿪ʼʱ��</td>
			<td  nowrap>
				<input type="text" name="start_time" id="start_time" v_type="date_time" v_format = "yyyyMMdd HH:mm:ss" v_name="��ʼʱ��"  size="20"  maxlength="17"/>&nbsp;<font color=red>*</font>
			</td>
		</tr>
		<tr height="26"> 
			<td width="10%"  nowrap> �������ʱ��</td>
			<td nowrap>
				<input type="text" name="end_time" id="end_time" v_type="date_time" v_format = "yyyyMMdd HH:mm:ss" v_name="����ʱ��"  size="20"  maxlength="17"/>&nbsp;<font color=red>*</font>
			</td>
		</tr>
		<!--
		<tr> 
			<td width="10%" nowrap> ��������</td>
			<td nowrap>
				<input type="password" name="conf_pwd" id="conf_pwd" size="21" maxlength="8"/>
			</td>
		</tr>
		<tr> 
			<td width="10%" nowrap> ����������</td>
			<td  nowrap>
				<input type="password" name="compere_pwd" id="compere_pwd" size="21" maxlength="8"/>
			</td>
		</tr>
		-->
		<tr> 
			<td width="10%" nowrap> ��������</td>
			<td  nowrap>
				<input type="text" name="conf_cont" id="conf_cont" size="20" maxlength="256"/>
			</td>
		</tr>
		
		 
		
	</tbody>
	<input type="hidden" name="login_accept" value="<%=printAccept%>">
	<tbody id="booking_vc1" style="display:none;">
		<tr> 
			<td width="10%" nowrap> ����id</td>
			<td  nowrap>
			<!--	<input type="text" name="conf_id" id="conf_id" size="20" maxlength="32"/>-->
			
			<select name="conf_id" id="conf_id" onchange="cofidchg()">
				<option value="">---��ѡ��---</option>
				<%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
                <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][0]%></option>
                <%}%>
            </select>
			</td>
			
		</tr>
		<tr> 
			<td width="10%" nowrap> ��������</td>
			<td  nowrap>
			<input name="query_type"  type="text"  v_must=1  readonly Class="InputGrey"     id="query_type" maxlength="20" > 
			</td>
			
			
		</tr>
		<tr> 
			<td width="10%" nowrap> ��ʼʱ��</td>
			<td  nowrap>
			<input name="query_begin"  type="text"  v_must=1  readonly Class="InputGrey"     id="query_begin" maxlength="20" > 
			</td>
			
			
		</tr>
		<tr> 
			<td width="10%" nowrap> ����ʱ��</td>
			<td  nowrap>
			<input name="query_end"  type="text"  v_must=1  readonly Class="InputGrey"     id="query_end" maxlength="20" > 
			</td>
			
			
		</tr>
		<tr> 
			<td width="10%" nowrap> ��������</td>
			<td  nowrap>
			<input name="query_cof"  type="text"  v_must=1  readonly Class="InputGrey"     id="query_cof" maxlength="20" > 
			</td>
			
		</tr>
	</tbody>
		<tr height="26"> 
			<td width="10%"  nowrap align="center" colspan="2"> 
			    <input type="button" class="b_foot" value="ȷ��&��ӡ" name="confirm" onclick = "doCfm();">&nbsp;&nbsp;&nbsp;
			    <input type="reset" class="b_foot" value="���" name="reset">&nbsp;&nbsp;&nbsp;
				<input type="button" class="b_foot" value="����" name="close" onclick="history.go(-1)">
            </td>
		</tr>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>   
</form>
<br><br>
</body>
</html>
