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
	String workNo   = (String)session.getAttribute("workNo");                //����
	String nopass  = (String)session.getAttribute("password");                    	//��½����
	String regionCode = (String)session.getAttribute("regCode");
	
	String login_accept = request.getParameter("login_accept");
	String mode_code = request.getParameter("mode_code");
	String detail_code = request.getParameter("detail_code");
	String note = request.getParameter("note");	
	String region_code = request.getParameter("region_code");
 	String typeButtonNum = request.getParameter("typeButtonNum");
 	String apply_flag = request.getParameter("apply_flag");
 	
 	
 	//��ȡ���е��Ż���Ϣ
	String[] paramsIn=new String[6];
	paramsIn[0]=workNo;
	paramsIn[1]=nopass;
	paramsIn[2]="5238";
	paramsIn[3]=login_accept;
	paramsIn[4]=region_code;
	paramsIn[5]=detail_code;
	
	//retArray=callView.callFXService("s5238_RateQry",paramsIn,"5");	
%>

    <wtc:service name="s5238_RateQry" outnum="5" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />			
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />		
		</wtc:service>
		<wtc:array id="result_t" scope="end" />

<%	
	
	String[][]sOut_note= new String[][]{};
			for(int iii=0;iii<result_t.length;iii++){
				for(int jjj=0;jjj<result_t[iii].length;jjj++){
					System.out.println("---------------------result_t["+iii+"]["+jjj+"]=-----------------"+result_t[iii][jjj]);
				}
		}
			String flag_code="",flag_name="";
	if(result_t.length>0&&code.equals("000000"))
	{
	sOut_note = result_t;
	
	flag_code = sOut_note[0][1];
	flag_name = sOut_note[0][2];
	
	if(flag_code==null || flag_code.equals("")) flag_code=detail_code;
	if(flag_name==null || flag_name.equals("")) flag_name=sOut_note[0][0];

}
%>

<html>
<head>
<base target="_self">
<title>���������Ż�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 

//-----�ύ���������Ż�����-----
function doSubmit()
{	
	if (!(check(document.form1))) return ; 

  var flag_codes = new Array();
	var area_codes = new Array();

  var checkbox1Obj = document.getElementsByName("checkbox1");
	var flag_codesObj= document.getElementsByName("flag_codes");
	var area_codesObj= document.getElementsByName("area_codes");
    var j=0;

    for(var i=0;i<checkbox1Obj.length;i++)
    {
			if(checkbox1Obj[i].checked)
			{	
				flag_codes[j]=flag_codesObj[i].value;
				area_codes[j]=area_codesObj[i].value;
				j++;
			}	
	}
	document.form1.flag_codes_list.value=flag_codes;
	document.form1.area_codes_list.value=area_codes;
	
	var opType = "N";
	if(document.all.byFile.checked){
		opType = "Y";
		if(document.all.addFile.value == ""){
			rdShowMessageDialog("���������...����ťѡ���ļ���",0);
			document.form1.addFile.focus();
			return;
		}
		
	}
	document.form1.action="f5238_opRateCode_submit.jsp?opType=" + opType; 
	document.form1.submit();
}


function choiceFilePut()
{
	if(document.all.byFile.checked){
		document.all.addFile.readOnly=false;
	}else{
		document.all.addFile.readOnly=true;
	}
}

//��ϲ�Ʒ��������ʾ����
function addSubArea()
{
	if(document.form1.flag_code.value=="") 
	{
		rdShowMessageDialog("������С�����룡",0);
		document.form1.flag_code.focus();
		return;
	}

	if(document.form1.flag_code.value.length != 6) 
	{
		rdShowMessageDialog("С�����������6λ��",0);
		document.form1.flag_code.focus();
		return;
	}
	
	if(document.form1.area_code.value=="") 
	{
		rdShowMessageDialog("��������С�����룡",0);
		document.form1.area_code.focus();
		return;
	}

	if(document.form1.area_code.value.length != 4) 
	{
		rdShowMessageDialog("��С�����������4λ��",0);
		document.form1.area_code.focus();
		return;
	}
	
	var rows = document.getElementById("mainFour").rows.length;
	var newrow = document.getElementById("mainFour").insertRow(rows);
	newrow.height="20";
	newrow.align="left";
	
	newrow.insertCell(0).innerHTML ='<input type="checkbox" name="checkbox1" checked>';
	newrow.insertCell(1).innerHTML ='<input type="text" name="area_codes" size="6"  readonly  Class=InputGrey value="'+ document.form1.flag_code.value +'">';
  newrow.insertCell(2).innerHTML ='<input type="text" name="flag_codes" size="6"  readonly  Class=InputGrey value="'+ document.form1.area_code.value +'">';
}

</script>
</head>

<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
 
	  <form name="form1"  method="post" ENCTYPE="multipart/form-data">
	  	 <%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">��Ʒ��<%=mode_code%>�����������Ż�����</div>
	</div>
	  <input type="hidden" name="login_accept" value="<%=login_accept%>">
	  <input type="hidden" name="detail_code" value="<%=detail_code%>">
	  <input type="hidden" name="note" value="<%=note%>">
	  <input type="hidden" name="region_code" value="<%=region_code%>">
	  <input type="hidden" name="typeButtonNum" value="<%=typeButtonNum%>">
	  <input type="hidden" name="flag_codes_list" >
	  <input type="hidden" name="area_codes_list" >
	  		  	<TABLE   id="mainOne"  cellspacing="0"  >
	            <TBODY>
	  				<tr >
	  					<TD class="blue" width="20%" height="22">&nbsp;&nbsp;�Żݴ���</TD>
	  					<TD width="80%">
	  						<%=detail_code%>
	  					</TD>
	  				</tr>
	  				<tr  >
	  					<TD height="22" class="blue" >&nbsp;&nbsp;�Ż�����</TD>
	  					<TD>
	  						<%=note%>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue" >&nbsp;&nbsp;�Ż���Ϣ����</TD>
	  					<TD>
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=255 v_name="�Ż���Ϣ����" name=sIn_note maxlength=255 value="<%=sOut_note[0][0]%>" size="60"></input>
	  					</TD>
	  				</tr>
					<tr >
	  					<TD class="blue" >&nbsp;&nbsp;С������</TD>
	  					<TD>
	  						<input type=text  v_type="string" v_must=1 v_minlength=0 v_maxlength=6 v_name="С������" name="flag_code" maxlength=6 value="00<%=flag_code%>" size="10"></input>
	  					</TD>
	  				</tr>
					<tr >
	  					<TD class="blue" >&nbsp;&nbsp;С������</TD>
	  					<TD>
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=255 v_name="С������" name="flag_name" maxlength=255 value="<%=flag_name%>" size="60"></input>
	  					</TD>
	  				</tr>
					<tr >
	  					<TD colspan=2 class="blue" >&nbsp;&nbsp;��С����Ϣ</TD>
	  				</tr>
					<tr >
	  					<TD class="blue" >&nbsp;&nbsp;��С������</TD>
	  					<TD>
	  						<input type=text  v_type="string" v_must=0 v_minlength=0 v_maxlength=4 v_name="��С������" name="area_code" maxlength=4 value="" size="10"></input>
	  						<input type="checkbox" name="byFile" onClick="choiceFilePut()" value="Y">���ļ�</input>
								<input type="file" name="addFile" readonly   > <font class="orange"> (�ļ���ʽС������+�ո�+��С������)</font>
	  					</TD>
	  				</tr>
					<TR >
	  				    <TD height="30" align="center" colspan="2">
	          				<input name="addButt" type="button" class="b_text" value="���" onClick="addSubArea()">
	  					</TD>
	  				</TR>
				</table>
                <table id="mainFour" cellspacing="0"  >
	  				<tr  height="22">
	  					<Th width="4%"> ѡ�� </Th>
	  					<Th width="8%"> С������ </Th>
	  					<Th width="8%"> ��С������ </Th>
	  				</tr>
					<%
	  					for(int i=0;i<sOut_note.length&&sOut_note[i][4]!=null;i++)
						{
					%>
					<tr  height="20"> 
							<td height="20"><input type="checkbox" name="checkbox1" checked></td>
                			<td height="20"> <%=sOut_note[i][4]%></td>                			
                			<td height="20"> <%=sOut_note[i][3]%></td>
			    	</tr>
					<%
						}	
					%>
	  			</table>
				<table cellspacing="0" >
	  				<tr >
	  					<TD height="22" colspan="2">&nbsp;&nbsp;<font class="orange">��ע��Ʒ������ɺ���֪ͨ�Ʒ�ϵͳ�������۹���</font></TD>
	  				</tr>
 
	  			  <TR >
	  				<TD height="30" align="center" id="footer">
	          	 	    <input name="nextButton" type="button"  value="ȷ��" class="b_foot" onClick="doSubmit()" >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button"  value="ȡ������"  class="b_foot_long" onClick="window.opener.form1.typeButton<%=typeButtonNum%>.disabled=false;window.close()" >
	          	 	    &nbsp;
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
 
	  	<%@ include file="/npage/include/footer_pop.jsp" %>
	  </form>
</body>
</html>

