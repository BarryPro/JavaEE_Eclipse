<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-18
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
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<%
	//��ȡ�û�session��Ϣ
	Logger logger = Logger.getLogger("f5238.jsp");
  String[][] result = new String[][]{};
  
	String workNo   = (String)session.getAttribute("workNo");                //����
	String nopass  = (String)session.getAttribute("password");                    	//��½����
	String regionCode = (String)session.getAttribute("regCode");

	DateFormat df = new SimpleDateFormat("yyyyMMdd");
	Date d1=new Date();
	String sysdate=df.format(d1);
	
	String errCode="";
    String errMsg="";
    
    String region_code="";
    String region_name="";
    String sm_code    ="";
    String sm_name    ="";
    String mode_code  ="";
    String mode_name  ="";
    String mode_flag  ="";
    String begin_time ="";
    String end_time   ="";
    String note       ="";
    String mode_use   ="";
    String use_name   ="";
	String year_flag ="";
	String next_mode = "";
	String next_mode_name="";
	String mode_type="";
	String mode_type_name="";
	String power_right="";
      
	//��ȡ����ҳ�õ�����Ϣ
	String login_accept = request.getParameter("login_accept");
	String op_code = request.getParameter("op_code")==null?"":request.getParameter("op_code");
	if(op_code.equals(""))  op_code="5238";
	
	if(login_accept == null)
	{
		
		//��ȡϵͳ��ˮ
 	//sqlStr1 ="SELECT sMaxSysAccept.nextval FROM dual";
 	%>
 	
 	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
 	
 	<%
		login_accept=sysAcceptl;
		
	}
	else
	{
		ArrayList acceptList = new ArrayList();
    	String paramsIn[] = new String[4];
    	paramsIn[0] = workNo;				//����
    	paramsIn[1] = nopass;				//����
    	paramsIn[2] = "5238";				//OP_CODE
    	paramsIn[3] = login_accept;			//������ˮ

    	  
	 //	acceptList = impl.callFXService("s5238_1Int",paramsIn,"18");
%>

    <wtc:service name="s5238_1Int" outnum="18" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />	
			<wtc:param value="<%=paramsIn[2]%>" />	
			<wtc:param value="<%=paramsIn[3]%>" />	
		</wtc:service>
		<wtc:array id="result_t1" scope="end" />

<%	 	
		errCode=code;   
		errMsg=msg;
		
		if(!errCode.equals("000000"))
    	{
%>  	
    	    <script language='javascript'>
    	    	rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
		        history.go(-1);
    	    </script>
<%		}
		else
		{
			if(result_t1.length>0){
			region_code =result_t1[0][0].trim();
			region_name =result_t1[0][1].trim();
			sm_code     =result_t1[0][2].trim();
			sm_name     =result_t1[0][3].trim();
			mode_code   =result_t1[0][4].trim();
			mode_name   =result_t1[0][5].trim();
			mode_flag   =result_t1[0][6].trim();
			begin_time  =result_t1[0][7].trim();
			end_time    =result_t1[0][8].trim();
			note        =result_t1[0][9].trim();
			mode_use    =result_t1[0][10].trim();
	   		use_name  =result_t1[0][11].trim();
			year_flag   =result_t1[0][12].trim();
			next_mode   =result_t1[0][13].trim();
			next_mode_name  =result_t1[0][14].trim();
			mode_type       =result_t1[0][15].trim();
			mode_type_name  =result_t1[0][16].trim();
			power_right     =result_t1[0][17].trim();
			}
	    }
	}
%>

<html>
<head>
<base target="_self">
<title>���˲�Ʒ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">
onload=function()
{
	self.status="";

    <%if(year_flag.equals("0")){%>
      document.all.yearInfoButt.style.display="";
	  document.all.yearInfoButt.value="������Ϣ������";
	<%}%>
	<%if(!(end_time.equals("20500101")) && next_mode.length()>7){%>
      document.all.nextModeTr.style.display="";
	<%}%>
}

//����rpc���ؽ��
	function doProcess(packet) {
		self.status="";
		var qryType=packet.data.findValueByName("rpcType");
		var errCode=packet.data.findValueByName("errCode");
		var errMsg=packet.data.findValueByName("errMsg");
		if(parseInt(errCode)!=0){
			rdShowMessageDialog("������Ϣ"+errMsg + "<br>�������"+errCode, 0);
			return false;
		}
		
		if(qryType=="getProCode")
		{
				var proCode = packet.data.findValueByName("proCode");
				document.form1.mode_code.value=StrAdd(1,proCode,1);
				document.form1.getprocodebutton.disabled=true;
				return;
		}
		
	}	
function StrAdd(AddType, SrcStr, Value)
{
	//AddType 0ֵ��1�� 1:ģ��1
	var BaseStr ="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	//var BaseStr ="0123456789";
	var S = "";
	var CurPos = 0, PrePos = 0, SrcLen=0,BaseLen=0, Index=0;
	var isCarry = 0;
	
	SrcLen= SrcStr.length;
	BaseLen=BaseStr.length;
	isCarry = Value % BaseLen;
	for(  CurPos = SrcLen - 1; CurPos >= 0; CurPos --)
	{
		if (isCarry != 0)
		{
			Index = BaseStr.indexOf(SrcStr.charAt(CurPos)) + isCarry;
			if (Index < -1)
			{
				return "";
			}
			if (Index > BaseLen - 1)
			{
				isCarry = 1;
				S = BaseStr.charAt(Index - BaseLen) + S;
			}
			else
			{
				isCarry = 0;
				S = SrcStr.substring(0, CurPos) + BaseStr.charAt(Index) + S;
				break;
			}
			if (CurPos == 0 && AddType == 0) S = BaseStr.charAt(0) + S;
		}
		else
		{
			break;
		}
		
	}
	return S;
}

//�ж�������Ƿ�Ϊ����	
function ischinese()
{
 	var ret=false;
 	var s=document.all.mode_code.value;
 	for(var i=0;i<s.length;i++)
 	{
 	 	ret=(s.charCodeAt(i)>=10000);
 	 	if(ret==true)
 	 	{
 	 		rdShowMessageDialog("�����ڲ�Ʒ��������������ģ�");
 	 		document.all.mode_code.focus();
 	 		return;
 	 	}
 	}
}    


//ѡ���������
function queryRegionCode()
{
	window.open("f5238_queryRegionCode.jsp?clear_sm_code=1&clear_mode_use=1","","height=600,width=400,scrollbars=yes");
}

//ѡ��Ʒ�ƴ���
function querySmCode()
{
	if(document.form1.region_code.value!="")
	{
	    var url = "f5238_querySmCode.jsp?clear_mode_use=1&region_code="+document.form1.region_code.value;
		window.open(url,'','height=600,width=400,scrollbars=yes');
	}
	else
	{
		rdShowMessageDialog("����ѡ��������룡");
		document.form1.query_regioncode.focus();
	}
}

//ѡ���ʷ����ʹ���
function queryModeType()
{
	if(!checkElement(document.form1.region_code)) return ;
	if(!checkElement(document.form1.sm_code)) return ;

    var retToField = "mode_type|mode_type_name|";
    var url = "f5238_queryModeType.jsp?clear_mode_use=1&region_code="+document.form1.region_code.value+"&smCodeCond="+document.form1.sm_code.value+"&retToField="+retToField;
	window.open(url,'','height=600,width=550,scrollbars=yes');
}


//ѡ��ģ�����
function queryModeUse()
{
	if(document.form1.region_code.value=="")
	{
	    rdShowMessageDialog("����ѡ��������룡");
		document.form1.query_regioncode.focus();
	}
	else if(document.form1.sm_code.value=="")
	{
		rdShowMessageDialog("����ѡ��Ʒ�ƴ��룡");
		document.form1.query_smcode.focus();
	}
	else
	{
		
		var mode_flag="";
	  for(var i=0;i<document.form1.mode_flag.length;i++)
	  {
		  if(document.form1.mode_flag[i].checked==true)
		  {
			  mode_flag=document.form1.mode_flag[i].value;
		  }
	  }
		var url = "f5238_queryModeUse.jsp?mode_use="+document.all.mode_use.value+"&region_code="+document.form1.region_code.value+"&sm_code="+document.form1.sm_code.value+"&mode_flag="+mode_flag+"&mode_type="+document.form1.mode_type.value;
		window.open(url,'','height=600,width=400,scrollbars=yes');
	}
}

//ѡ�����ʷ�
function queryNextMode()
{
	var url = "f5238_queryModeCode.jsp?region_code="+document.form1.region_code.value;
    var retMsg = window.open(url,'','height=600,width=500,scrollbars=yes');
}

/*--------- �ύҳ��ת����һҳ -------------*/
function submitAdd()
{
	if(document.form1.region_code.value==""){
	rdShowMessageDialog("��������Ϊ������,�������д",0);
	return;
}

	if(document.form1.sm_code.value==""){
	rdShowMessageDialog("Ʒ�ƴ���Ϊ������,�������д",0);
	return;
}


	if(document.form1.mode_type.value==""){
	rdShowMessageDialog("��Ʒ����Ϊ������,�������д",0);
	return;
}
		if(!check(form1)) return;
	
	if(!forDate(document.form1.begin_time)) 
	{
		document.all.begin_time.focus();
		return;
	}
	if(!forDate(document.form1.end_time)) 
	{
		document.all.end_time.focus();
		return;
	}
	if(document.all.end_time.value<document.all.begin_time.value)
	{
		rdShowMessageDialog("����ʱ��Ӧ���ڿ�ʼʱ�䣡");
		document.form1.end_time.focus();
		return;
	}
	if(document.all.power_right.value == ""){
		 rdShowMessageDialog("��ѡ������Ȩ�ޣ�");
	   document.form1.power_right.focus();
	   return;
	}
	if(document.all.year_flag[0].checked==true && document.all.yearInfoButt.value=="������Ϣδ����")
	{
	   rdShowMessageDialog("�����ð�����Ϣ��");
	   document.form1.yearInfoButt.focus();
	   return;
	}
	document.form1.action="f5238_2.jsp"; 
	document.form1.submit();	
}

//���ư��갴ť�Ŀɼ���
function ctrlYear(flag)
{
    if(flag==0)
    {
	    document.all.yearInfoButt.style.display="";
	}else
    {
	    document.all.yearInfoButt.style.display="none";
	}
}

//�����������ð�����Ϣ
function opYearInfo()
{
  if(!checkElement(document.all.region_code)) 
  {
    document.all.region_code.focus();
	return;
  }
  if(!checkElement(document.all.mode_code)) 
  {
    document.all.mode_code.focus();
	return;
  }
  if(!checkElement(document.all.begin_time)) 
  {
    document.all.begin_time.focus();
	return;
  }
  if(!checkElement(document.all.end_time)) 
  {
     document.all.end_time.focus();
	 return;
  }
  var url = "f5238_opYearInfo.jsp?login_accept=<%=login_accept%>"+"&mode_code="+document.all.mode_code.value+"&region_code="+document.all.region_code.value+"&begin_time="+document.all.begin_time.value+"&end_time="+document.all.end_time.value;
  escape(url);
  window.open(url,'','height=600,width=900,left=20,scrollbars=yes');
}

function endTimeChg()
{
    var end_time=document.all.end_time.value;
	if(end_time<"20500101")
	{
	    document.all.nextModeTr.style.display="";
	}else
	{
	    document.all.nextModeTr.style.display="none";
	}
}

function getProCode()
{
	if(document.form1.region_code.value=="")
	{
		rdShowMessageDialog("����ѡ��������룡");
		document.form1.query_regioncode.focus();
		return;
	}
	if(document.form1.sm_code.value=="")
	{
		rdShowMessageDialog("����ѡ��Ʒ�ƴ��룡");
		document.form1.query_smcode.focus();
		return;
	}

	if(document.form1.mode_type.value=="")
	{
		rdShowMessageDialog("����ѡ���Ʒ���");
		document.form1.query_modetype.focus();
		return;
	}	
	
	var mode_flag="";
	for(var i=0;i<document.form1.mode_flag.length;i++)
	{
		if(document.form1.mode_flag[i].checked==true)
		{
			mode_flag=document.form1.mode_flag[i].value;
		}
	}
	  //alert(sm_code+mode_flag + mode_type);
		var myPacket = new AJAXPacket("f5238_getProCode_rpc.jsp","�����ύ�����Ժ�......");
		myPacket.data.add("sm_code",document.form1.sm_code.value);
		myPacket.data.add("mode_flag",mode_flag);
		myPacket.data.add("mode_type",document.form1.mode_type.value);
		myPacket.data.add("region_code",document.form1.region_code.value);
		myPacket.data.add("rpcType","getProCode");
		core.ajax.sendPacket(myPacket);
		myPacket = null;
}


</script>
 
</head>

<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">

	  <form name="form1"  method="post">
	  		<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">���˲�Ʒ����-���ò�Ʒ����</div>
	</div>

	  <input type="hidden" name="login_accept" value="<%=login_accept%>">
	  <input type="hidden" name="page_flag" value="0">
	  <input type="hidden" name="op_code" value="<%=op_code%>">
	  		  	<TABLE id="mainOne" cellspacing="0" >
	            <TBODY>

	  	        	<TR >
	  					<TD width="23%" valign="top">
	  						<table  id="mainTwo"  cellspacing="0" >
	  							<tr  height="25">
	  								<TD >&nbsp;&nbsp;&nbsp;&nbsp;<b>��Ʒ���ò���</b></TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;<font class="orange">1.���ò�Ʒ����</font></TD>
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
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;5.��Ʒ��ϵ����</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;6.���</TD>
	  							</tr>
	  						</table>
	  					</TD>
	  					<TD width="77%">
	  						<table   id="mainThree" cellspacing="0">
	  							<tr  height="22">
	  								<TD width="33%" class="blue">&nbsp;&nbsp;��ǰ������ˮ��</TD>
	  								<TD width="67%"><font class="orange"><%=login_accept%></font></TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;��������</TD>
	  								<TD>
	  									<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=2   name=region_code value="<%=region_code%>" maxlength=10 size="10" readonly  Class="InputGrey" >
	  									<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=10    name=region_name value="<%=region_name%>" maxlength=10 readonly  Class="InputGrey" >
										<input  type="button" class="b_text" name="query_regioncode" onclick="queryRegionCode()" value="ѡ��">
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;Ʒ�ƴ���</TD>
	  								<TD>
	  									<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=2 v_name="Ʒ�ƴ���"  name=sm_code value="<%=sm_code%>" maxlength=10 size="10" readonly  Class="InputGrey" >
	  									<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=20 v_name="Ʒ�ƴ���"  name=sm_name value="<%=sm_name%>" maxlength=20 readonly  Class="InputGrey" >
										<input  type="button" class="b_text"  name="query_smcode" onclick="querySmCode()" value="ѡ��">
	  								</TD>
	  							</tr>
								<tr >
	  								<TD class="blue">&nbsp;&nbsp;��Ʒ����</TD>
	  								<TD>
	  									<input type=text  v_type="string"  v_must=1 v_minlength=4 v_maxlength=4 v_name="�ʷ�����"  name=mode_type value="<%=mode_type%>" maxlength=10 size="10" readonly  Class="InputGrey" >
	  									<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=20 v_name="�ʷ�����"  name=mode_type_name value="<%=mode_type_name%>" maxlength=20 readonly  Class="InputGrey" >
										<input  type="button" class="b_text"  name="query_modetype" onclick="queryModeType()" value="ѡ��">
	  								</TD>
	  							</tr>
								<tr >
	  								<TD class="blue">&nbsp;&nbsp;��Ʒ���</TD>
	  								<TD>
	  									<input type="radio" name="mode_flag" value="0" <%=mode_flag.equals("0")==true?"checked":""%><%=mode_flag.equals("")==true?"checked":""%>>����Ʒ
	  									<input type="radio" name="mode_flag" value="2" <%=mode_flag.equals("2")==true?"checked":""%>>��ѡ��Ʒ
	  									<input type="radio" name="mode_flag" value="1" <%=mode_flag.equals("1")==true?"checked":""%>>���Ӳ�Ʒ
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;��Ʒ����</TD>
	  								<TD>
	  									<input type=text  v_type="string"  v_must=1 v_minlength=8 v_maxlength=8 v_name="��Ʒ����"  name=mode_code value="<%=mode_code%>" maxlength=8 onblur="ischinese()"></input>
										<input type="button" class="b_text"  name="getprocodebutton" onClick="getProCode()" value="��ȡ" />
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;��Ʒ����</TD>
	  								<TD>
	  									<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=30 v_name="��Ʒ����"  name=mode_name value="<%=mode_name%>" maxlength=30 ></input>
	  								  	<font class="orange">*</font>
	  								</TD>
	  							</tr>	  							
								<tr >
	  								<TD class="blue">&nbsp;&nbsp;�Ƿ����</TD>
	  								<TD>
	  									<input type="radio" name="year_flag" onClick="ctrlYear(0)" value="0" <%=year_flag.equals("0")==true?"checked":""%>>��
	  									<input type="radio" name="year_flag" value="1" onClick="ctrlYear(1)" <%=year_flag.equals("1")==true?"checked":""%><%=year_flag.equals("")==true?"checked":""%>>��										
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;��ʼʱ��</TD>
	  								<TD>
	  									<input type=text  v_type="date" v_must=1 v_minlength=1 v_maxlength=8 v_name="��ʼʱ��" name=begin_time v_format="yyMMdd" value="<%=begin_time.equals("")?sysdate:begin_time%>" maxlength=8 ></input>&nbsp;<font class="orange">*(YYYYMMDD)</font>
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;����ʱ��</TD>
	  								<TD>
	  									<input type=text  v_type="date" v_must=1 v_minlength=1 v_maxlength=8 v_name="����ʱ��" name=end_time v_format="yyMMdd" value="<%=end_time.equals("")?sysdate:end_time%>" maxlength=8 onChange="endTimeChg()" ></input>&nbsp;<font class="orange">*(YYYYMMDD)</font>
	  								</TD>
	  							</tr>
								<tr >
	  								<TD class="blue">&nbsp;&nbsp;����Ȩ��</TD>
	  								<TD>
	  								<select name="power_right" value="<%=power_right%>" >
										<option value="" > ---- ��ѡ�� ---- </option>
<%
        //�õ��������
        try
        {
                String sqlStr ="select right_code, right_code||'->'||right_name from sPowerValueCode order by right_code";                     
                //retArray = callView.sPubSelect("2",sqlStr);   
      %>
      
   <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>
      
      <%                  
                result = result_t3;
                int recordNum = result.length;
                for(int i=0;i < recordNum;i++){
                		out.println("<option   value='" + result[i][0] + "' >" + result[i][1] + "</option>");
                }
        }catch(Exception e){
                logger.error("Call sunView is Failed!");
        }              
%>									
              			</select>	<font class="orange">*</font>
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;��Ʒ����</TD>
	  								<TD>
	  									<input type=text  v_type="" v_must=1 v_minlength=1 v_maxlength=600 v_name="��Ʒ����" name=note size=50 value="<%=note%>" maxlength=600></input> 	<font class="orange">*</font>
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;��ĳ��Ʒģ������</TD>
	  								<TD>
	  									<input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=10 v_name="����ģ�����"  name=mode_use value="<%=mode_use%>" maxlength=10 size="10" >
	  									<input type=text  name=use_name value="<%=use_name%>" maxlength=30 readonly  Class="InputGrey" >
										<input  type="button" class="b_text"  name="query_modeuse" onclick="queryModeUse()" value="ѡ��">
	  								</TD>
	  							</tr>
								<tr  id="nextModeTr" style="display:none">
	  								<TD class="blue">&nbsp;&nbsp;ָ�������ʷ�</TD>
	  								<TD>
	  									<input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=10 v_name="�����ʷ�"  name=next_mode value="<%=next_mode%>" maxlength=10 size="10">
	  									<input type=text  name=next_mode_name value="<%=next_mode_name%>" maxlength=30 readonly  Class="InputGrey" >
										<input  type="button" class="b_text"  name="query_nextmode" onclick="queryNextMode()" value="ѡ��">
	  								</TD>
	  							</tr>
	  						</table>
	  					</TD>
	  	        	</TR> 
	  	        
	            </TBODY>
	          	</TABLE>
	          	<TABLE  cellSpacing="0">
	  			  <TR >
	  				<TD height="30" align="right" width="60%" id="footer"> 
	          	 	    <input name="nextButton" type="button" class="b_foot" value="��һ��" onClick= "submitAdd()" >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button"  class="b_foot" value="��  ��" onClick="window.location='f5238_1.jsp'" >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button" class="b_foot"  value="��  ��" onClick="removeCurrentTab()" >

						<input style="display:none" class="b_foot_long" type="button" name="yearInfoButt" value="������Ϣδ����" onclick="opYearInfo();">
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  	<%@ include file="/npage/include/footer.jsp" %>
	  </form>
</body>
</html>

<script language="javascript">
<%if(op_code.equals("5237")){%>
   rdShowMessageDialog("��ע��˽������ڵ����ʷ����ò��ԣ�");
<%}%>

</script>
