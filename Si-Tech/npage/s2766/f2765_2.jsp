<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
	//��ȡ�û�session��Ϣ
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //����
	String workName = baseInfo[0][3];               //��������
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     //��½����
	
	Logger logger = Logger.getLogger("f2765_1.jsp");
	
	String op_name ="�����ʵ���ӡ";
	
	
	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	String result[][] = new String[][]{};
	
	ArrayList retArray = new ArrayList();
  String sqlStr="";
	sqlStr = "select show_mode,mode_name from sBillListDefine where default_flag='0'";
	//retArray = callView.sPubSelect("2",sqlStr);
	//result = (String[][])retArray.get(0);
	%>
		<wtc:pubselect name="TlsPubSelBoss"  outnum="2">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="retList" scope="end" />
  <%
  result=retList;
	boolean  nextFlag=false;
	
	String action=request.getParameter("action");//�ύ����ҳ��
	String contract_no = "";
	String phone_no="";
	String in_print_type1="";
	String qryType="";
	String result1[][]= new String[][]{};
	if (action!=null&&action.equals("select")){
		
	phone_no=request.getParameter("phone_no");
	contract_no=request.getParameter("contract_no");
	in_print_type1=request.getParameter("in_print_type1");  
	qryType=request.getParameter("qryType");

	if(in_print_type1.equals("0"))
	{
	sqlStr = "select show_mode  from dBillListDetail where contract_no = '?' and mode_type='0'";
	}
	else
	{
		sqlStr = "select show_mode from dBillListDetail where  cust_id = '?' and mode_type='0'";
	}
	
	
	
	//retArray = callView.sPubSelect("1",sqlStr);
	//result1 = (String[][])retArray.get(0);
	 %>
		<wtc:pubselect name="TlsPubSelBoss"  outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
			<wtc:param value="<%=contract_no%>"/>
		</wtc:pubselect>
		<wtc:array id="retList" scope="end" />
  <%
    result1 =retList;
	//System.out.println("11="+result1[0][0]);
	nextFlag=true;
	}
	
%>	

<html>
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../css/style.css" type="text/css">
<script language="JavaScript" src="../../js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script language=javascript>
	function doQuery()
	{		
		if(!check(form1))
		return false;
		
		document.form1.action = "f2765_2.jsp?action=select";
		document.form1.submit(); 
	}
	
	function doSubmit()
	{
		if(!check(form1))
		return false;
		
		if(document.form1.print_date.value=="")
		{
			rdShowMessageDialog('��ӡ���²���Ϊ��!');
		  return false;
		}
		
		document.form1.print_date.value = document.form1.print_date.value+"01";
		
		if(validDate(document.form1.print_date)==false) 
		return false; 
		
		document.form1.print_date.value=document.form1.print_date.value.substring(0,6);
		
		document.form1.action = "f2765cfm_2.jsp";
		document.form1.submit();
	}
	
function isKeyNumberdot(ifdot) 
{       
   		 var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
		if(ifdot==0)
			if(s_keycode>=48 && s_keycode<=57)
				return true;
			else 
				return false;
   		 else
    		{
			if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
				{
		     			 return true;
				}
			else if(s_keycode==45)
				{
		   		 		rdShowMessageDialog('���������븺ֵ,����������!');
		    				return false;
				}
				else
			 		 return false;
   		 }       
}

function isNumberString (InString,RefString)
{
if(InString.length==0) return (false);
for (Count=0; Count < InString.length; Count++)  {
	TempChar= InString.substring (Count, Count+1);
	if (RefString.indexOf (TempChar, 0)==-1)  
	return (false);
}
return (true);
}


	function getcount()
	{
		if(document.all.qryType.value=="0"){
			if( form1.phone_no.value.length<10 || isNumberString(form1.phone_no.value,"1234567890")!=1 ) 
			{
				rdShowMessageDialog("�����뼯�ű��,����Ϊ10λ���� !!")
			  document.form1.phone_no.focus();
			  return false;
		  }else {
				var h=480;
				var w=650;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				var prop="dialogHeight:"+300+"px; dialogWidth:"+500+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
				var str=window.showModalDialog('getCust_id.jsp?phone_no='+document.form1.phone_no.value+'&in_print_type1='+document.form1.in_print_type1.value,"",prop);
				
				if( typeof(str) != "undefined" ){
					if (parseInt(str)==0){
						rdShowMessageDialog("û���ҵ���Ӧ���ʺţ�",0);
						document.form1.cfmButton1.disabled=true;
						document.form1.contract_no.value="";
						document.form1.phone_no.focus();
						return false;
					} else {
						document.form1.contract_no.value=str;
						document.form1.cfmButton1.disabled=false;
						return true;
					}
					document.form1.cfmButton1.disabled=false;
					return true;
				}
				else{
					rdShowMessageDialog("��Ӧ�ĺ���δ���� ��",0);
				}
			}
		}else{
			if(1==0)
		//	if( form1.phone_no.value.length<11 || isNumberString(form1.phone_no.value,"1234567890")!=1 || form1.phone_no.value.substring(0,2)!="20") 
			{
				rdShowMessageDialog("������20��ͷ���������,����Ϊ11λ����!!")
			  document.form1.phone_no.focus();
			  return false;
		  }else {
				var h=480;
				var w=650;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				var prop="dialogHeight:"+300+"px; dialogWidth:"+500+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
				var str=window.showModalDialog('getVirtualNo_2.jsp?phone_no='+document.form1.phone_no.value+'&in_print_type1='+document.form1.in_print_type1.value,"",prop);
				
				if( typeof(str) != "undefined" ){
					if (parseInt(str)==0){
						rdShowMessageDialog("û���ҵ���Ӧ���ʺţ�",0);
						document.form1.cfmButton1.disabled=true;
						document.form1.contract_no.value="";
						document.form1.phone_no.focus();
						return false;
					} else {
						document.form1.contract_no.value=str;
						document.form1.cfmButton1.disabled=false;
						return true;
					}
					document.form1.cfmButton1.disabled=false;
					return true;
				}
				else{
					rdShowMessageDialog("��Ӧ�ĺ���δ���� ��",0);
				}
			}
			
			
			
		}
	}

function doSel0()
	{
		form1.in_print_type1.value=0;
		form1.contract_no.value="";
		tbs1.style.display="";
		tbs2.style.display="none";
		//form1.Submit1.disabled=false;
		form1.in_print_type22.checked=false;
	}
	
	function doSel1()
	{
		form1.in_print_type1.value=1;
		form1.contract_no.value="";
		tbs1.style.display="none";
		tbs2.style.display="";
		form1.in_print_type11.checked=false;
		//form1.Submit1.disabled=false;
		
	}

	
	//��һ��
	function previouStep(){
		document.location.href="<%=request.getContextPath()%>/page/s2765/f2765_2.jsp";
	}
		function dingzhi(){
	
		document.location.href="f2760_1.jsp?contract_no="+document.form1.contract_no.value;
	}
	
	function chgQryType(obj){
		var qryType=obj.value;
		if(qryType=="0"){
			document.getElementById("qryName").innerText="���ź��룺";
			document.all.phone_no.value="";
			document.all.phone_no.maxLength="10";
		}else{
			document.getElementById("qryName").innerText="������룺";
			document.all.phone_no.value="";
			document.all.phone_no.maxLength="11";
		}
	}
</script>

</head>

<body bgcolor="#FFFFFF" text="#000000" background="/images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
    
<form action="" name="form1"  method="post">
 							<input type="hidden" name = "op_code" value = "2765">
            	<input type="hidden" name = "workNo" value = "<%=workNo%>">
            	<input type="hidden" name = "org_code" value = "<%=org_code%>">
            	<input type="hidden" name = "in_print_type1" value="0">
  <table width="767" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
  <tr>
      <td background="<%=request.getContextPath()%>/images/jl_background_1.gif" bgcolor="#E8E8E8">
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr>
          <td align="right" width="45%">
            <p><img src="<%=request.getContextPath()%>/images/jl_chinamobile.gif" width="226" height="26"></p>
            </td>
            <td width="55%" align="right"><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">���ţ�<%=workNo%><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">����Ա��<%=workName%></td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr>
            <td align="right" background="<%=request.getContextPath()%>/images/jl_background_3.gif" height="69">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="<%=request.getContextPath()%>/images/jl_logo.gif"></td>
                <td align="right"><img src="<%=request.getContextPath()%>/images/jl_head_1.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr>
          <td align="right" width="73%">
            <table width="535" border="0" cellspacing="0" cellpadding="0">
              <tr>
                 <td width="42"><img src="<%=request.getContextPath()%>/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                    <td background="<%=request.getContextPath()%>/images/jl_background_4.gif"><font color="FFCC00"><b>�����ʵ���ӡ</b></font></td>
                     <td><img src="<%=request.getContextPath()%>/images/jl_ico_3.gif" width="389" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="27%">
            <table border="0" cellspacing="0" cellpadding="4" align="right">
              <tr>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_4.gif" width="60" height="50"></td>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_5.gif" width="60" height="50"></td>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>            	
					<table width="98%" align="center" id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0" >
							<tr bgcolor="#F5F5F5" align="left" colspan=5>
								<td  colspan=4>��ѯ������
									&nbsp;&nbsp;	&nbsp;&nbsp;	&nbsp;&nbsp;<select name="qryType"  onchange="chgQryType(this)" <% if(nextFlag){out.println("disabled");} %>>
									<!--	<option value="0">���ű��</option>-->
										<option value="1">���ź���</option>
									</select >
                </td>
              </tr>
							<!--		<tr bgcolor="#F5F5F5" align="left" colspan=5>
								<td width="35%" colspan="4">��ӡ��ʽ��
									<input type="radio" name="in_print_type11" onclick="doSel0()" value="0" checked >���ʻ���ӡ
							<input type="radio" name="in_print_type22" onclick="doSel1()" value="1" >���ͻ���ӡ
                </td>
              </tr>-->
					  <tr bgcolor="#F5F5F5" align="left" colspan=5>
              	<td width=15% id="qryName">���ź��룺</td>
              	<td width=35%>           	
              		<input type="text" name="phone_no"   maxlength=12 <% if(nextFlag){out.println("readonly");}%> size="16">
                  <input type="button" class="button" name="Submit1" value="��ѯ" onClick="getcount()" <% if(nextFlag){out.println("disabled");} %>>
                </td>
              
                <TD width=15%>
                	<div id=tbs1 style=display="">
                		�ʻ�ID��
                	</div> 
                	<div id=tbs2 style=display="none">
                		�ͻ�ID��
                	</div>  	
                </TD>
							 
              	<td align="left" width=35%>
          	    <input type="text"  v_type="int"  v_must=1 v_minlength=1 v_maxlength=14 v_name="ID"  name="contract_no" maxlength=14 <% if(nextFlag){out.println("readonly");}%>  size="15">
             	  <input name="Submit1" id="cfmButton1" type="button" class="button"   onKeyUp="if(event.keyCode==13)doQuery();" onMouseUp="doQuery();" style="cursor:hand" disabled value="��ѯ" <% if(nextFlag){out.println("disabled");} %>>&nbsp;
              	</td>
              </tr>
      <%
      if(nextFlag)
      {
      %>
      <TR bgcolor="#F5F5F5" id="line_1" > 
            	<td >ģ����룺</td>
            	<td>
            	
            	
              	<select name=show_mode_select  >
              		<%
              			  out.println("<option  value='moren'><font size=2>Ĭ��ģ��</font></option>");
              		for(int i=0;i<result1.length;i++)
									{
									
											out.println("<option  value='" + result1[i][0] + "'><font size=2>" +result1[i][0] + "</font></option>");
									
									}
										
								
              		%>
              	</select>
              </td>
              <TD >��ӡ���£�</TD>
              <td align="left">
          	    <input type="text"   name="print_date"  maxlength=6>(��ʽ:yyyymm)
              </td>          
      </TR>
      <TR bgcolor="#F5F5F5" id="line_1" align="center"> 
 	  	 	   <td colspan="4" align="center" >
 	  	 	   	<input class="button" name="previous" style="cursor:hand" type=button value="��һ��" onclick="previouStep()">&nbsp;
 	  	 	   	<input class="button" name="dingzhi1" style="cursor:hand" type=button value="�˵�����" onclick="dingzhi()">&nbsp;
 	  		    <input name="Submit1" id="print" type="button" class="button"   onclick="return doSubmit()" style="cursor:hand" value="��ӡ" >&nbsp;
 	  		    <input name="Submit3" id="cfmButton3" type="button" class="button"   onclick="return window.close()" style="cursor:hand" value="�ر�" >&nbsp;
	         </td>
	    </TR>
	    	<script language='jscript'>
				document.form1.in_print_type1.value="<%=in_print_type1%>";	    		
				document.form1.phone_no.value="<%=phone_no%>";
				document.form1.contract_no.value="<%=contract_no%>";
				document.form1.qryType.value="<%=qryType%>";
				document.form1.contract_no.value="<%=contract_no%>";

				if(document.form1.in_print_type1.value=="0")
				{
					form1.in_print_type1.value=0;
					tbs1.style.display="";
					tbs2.style.display="none";
					form1.in_print_type11.checked=true;
					form1.in_print_type22.checked=false;
					form1.in_print_type11.disabled=true;
					form1.in_print_type22.disabled=true;
				}else
				{
					form1.in_print_type1.value=1;
					tbs1.style.display="none";
					tbs2.style.display="";
					form1.in_print_type11.checked=false;
					form1.in_print_type22.checked=true;
					form1.in_print_type11.disabled=true;
					form1.in_print_type22.disabled=true;
				}
				if(document.form1.qryType.value=="0"){
					document.getElementById("qryName").innerText="���ű�ţ�";
					document.all.phone_no.maxLength="10";
				}
				else{
					document.getElementById("qryName").innerText="������룺";
					document.all.phone_no.maxLength="11";
				}
			</script> 
			
			</TABLE>
	     <%
      }
      %>
      
     <%
      if(!nextFlag)
      {
      %>
      
      <TABLE width="98%" align="center" bgcolor="#FFFFFF" cellspacing="1" border="0" >
				<TR bgcolor="#F5F5F5"> 
				    <TD height="30" align="center"> 
				    	<input class="button" name="previous" style="cursor:hand" type=button value="���" onclick="document.form1.reset()">&nbsp;
				      <input name="backButton"  type="button" class="button" onClick="window.close()" style="cursor:hand" value="�ر�">&nbsp;
				    </TD>
				</TR>
      </TABLE>
      
      <%}%>
 
  </div>
	<%@ include file="../public/foot.jsp" %>
</form>
</body>
</html>

