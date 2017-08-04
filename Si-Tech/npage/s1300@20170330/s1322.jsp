 
<%@ page errorPage="/page/common/errorpage.jsp" %>

<%@ page contentType="text/html;charset=GB2312"%>
 
<%@ page import="com.sitech.boss.s1310.viewBean.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
 
<%
    response.setHeader("Pragma","No-Cache"); 
    response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
     
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String workno = baseInfo[0][2];
	String workname = baseInfo[0][3];
	String org_code = baseInfo[0][16];
	String belongName = baseInfo[0][16];
	String[][] password = (String[][])arr.get(4);//读取工号密码 
	String pass = password[0][0];
	String[][] info1 = (String[][])arr.get(1);
	// xl add for 发票号码 begin
	String check_seq="";
	String s_flag="";
	String result_check[][]=new String[][]{};
	String[] inParam2 = new String[2];
	inParam2[0]="select to_char(S_INVOICE_NUMBER) from WLOGININVOICE where LOGIN_NO = :workNo";
	inParam2[1]="workNo="+workno;
	String sqlStr ="select to_char(S_INVOICE_NUMBER),flag from WLOGININVOICE where LOGIN_NO = '?'";
	%>
	<wtc:pubselect name="TlsPubSelCrm"   outnum="3">
	  	<wtc:sql><%=sqlStr%>
	</wtc:sql>
	<wtc:param value="<%=workno%>"/>
	</wtc:pubselect >
	<wtc:array id="retList"   scope="end" />
<%
	result_check = retList;

	if(retList.length != 0)
	{
		check_seq=result_check[0][0];
		s_flag = result_check[0][1];
		System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAa check_seq is "+check_seq);
	}
	// xl add for 发票号码 end
%>
<HTML>
<HEAD>
<script language="JavaScript" src="/js/common/redialog/redialog.js"></script>
<script language="JavaScript" src="/page/s1300/common_1300.js"></script>
<script language="JavaScript">
<!--	
function docheck() {
   if (document.mainForm.tem1.value.length == 0) {
      rdShowMessageDialog("集团名称不能为空，请重新输入 !!")
      document.mainForm.tem1.focus();
      return false;
   }
   
   if (document.mainForm.tem8.value.length == 0) {
      rdShowMessageDialog("合计金额不能为空，请重新输入 !!")
      document.mainForm.tem8.focus();
      return false;
   }
   //xl add
   if (document.mainForm.seq_num.value.length == 0) {
      rdShowMessageDialog("发票序列号不能为空，请重新输入 !!")
      document.mainForm.seq_num.focus();
      return false;
   }
   //xl add for 发票提示信息
	var prtFlag=0;
    //prtFlag = rdShowConfirmDialog("催欠冲正成功！是否打印发票？");
	prtFlag=rdShowConfirmDialog("当前发票号码是"+"<%=check_seq%>"+",是否打印发票?");
	if (prtFlag==1){
		document.getElementById("check_s").value="<%=check_seq%>";
		document.getElementById("s_flag").value="<%=s_flag%>";
		//s_flag
		document.mainForm.submit(); 
	} else { 
		return false;
	}

	
   
} 

function doclear1(){
 	 mainForm.reset();
}

function doqry()
{
	var unit_id = document.mainForm.vir_no.value;
	var begin_ym = document.mainForm.begin_ym.value;
	var end_ym = document.mainForm.end_ym.value;
	if(unit_id=="")
	{
		rdShowMessageDialog("请输入虚拟集团编号!");
		return false;
	}
	else if (begin_ym=="")
	{
		rdShowMessageDialog("请输入查询开始年月!");
		return false;
	}
	else if (end_ym=="")
	{
		rdShowMessageDialog("请输入查询结束年月!");
		return false;
	}
	else
	{
		document.mainForm.action="s1322qry.jsp?unit_id="+unit_id+"&begin_ym="+begin_ym+"&end_ym="+end_ym;
		document.mainForm.submit();
	}
	
}
-->
</script> 
<title>黑龙江BOSS-集团打印发票</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css" rel="stylesheet" type="text/css">
</head>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0" onLoad="" background="/images/jl_background_2.gif">
<form action="s1322_print.jsp" method="post" name="mainForm"  >
<table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
      <td background="/images/jl_background_1.gif" bgcolor="#E8E8E8"> 
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="45%"> 
            <p><img src="/images/jl_chinamobile.gif" width="226" height="26"></p>
            </td>
            <td width="55%" align="right"><img src="/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">
            工号：<%=workno%><img src="/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">
            操作员：<%=workname%></td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
            <td align="right" background="/images/jl_background_3.gif" height="69"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="/images/jl_logo.gif"></td>
                <td align="right"><img src="/images/jl_head_1.gif"></td>
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
                 <td width="42"><img src="/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                     <td background="/images/jl_background_4.gif"><font color="FFCC00"><b>集团打印发票</b></font></td>
                     <td><img src="/images/jl_ico_3.gif" width="389" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="27%"> 
            <table border="0" cellspacing="0" cellpadding="4" align="right">
              <tr>
                <td><img src="/images/jl_ico_4.gif" width="60" height="50"></td>
                <td><img src="/images/jl_ico_5.gif" width="60" height="50"></td>
                <td><img src="/images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
        <table width="98%" border=0 align="center" cellspacing=0 cellpadding="0" bgcolor="#FFFFFF">
          <tbody> 
          <tr> 
            <td>
              <table width="100%" border=0 align="center" cellspacing=1 cellpadding="4" bgcolor="#FFFFFF">
                <tbody> 
                <tr bgcolor="649ECC"> 
                  <td width="13%">操作类型：</td>
                  <td width="87%" colspan="3"> 
                    打印发票 
                   </td>
                 </tr>   
                </tbody> 
              </table>
            </td>
          </tr>
          <tr >
            <td>
              <table width=100% border=0 align="center" cellspacing=1 bgcolor="#FFFFFF">
                
				<tr bgcolor="#E8E8E8">
                  <td width="13%" nowrap>虚拟集团号码：</td>
                  <td width="35%" colspan=3> 
				  
                    <input class="button" value="" type="text" name="vir_no" maxlength="40">
					<font color="#FF0000"> *</font>
					
                  </td>
                 
				  
                </tr>
				
				<tr bgcolor="#E8E8E8">
                  <td width="13%" nowrap>查询开始年月日(YYYYMMDD)</td>
                  <td width="35%"> 
                    <input class="button" type="text"   name="begin_ym" maxlength=8 >
					<font color="#FF0000"> *</font>
				 
				  </td>
				  <td width="13%" nowrap>查询结束年月日(YYYYMMDD)</td>
                  <td width="35%"> 
                    <input class="button" type="text"   name="end_ym"  maxlength=8>
					<font color="#FF0000"> *</font>
					<input type="button" value="查询" onclick="doqry()">
				  </td>
                </tr>

				<tr bgcolor="#E8E8E8">
                  <td width="13%" nowrap>集团名称：</td>
                  <td width="35%"> 
				  <!--xl 申告需求23741，对集团名称进行长度限制，跟boss库保持一致，最大长度为40个汉字-->
                    <input class="button" value="" type="text" name="tem1" maxlength="40">
			 
                  </td>
                  <td width="13%" nowrap>移动台号：</td>
                  <td width="35%"> 
                    <input class="button" type="text" value="" name="tem2" onKeyPress="return isKeyNumberdot(0)">
				  </td>
                </tr>

				<tr bgcolor="#E8E8E8"> 
                  <td width="13%" nowrap>协议号码：</td>
                  <td width="35%"> 
                    <input class="button" type="text" value="" name="tem3" onKeyPress="return isKeyNumberdot(0)">
				  </td>
                  <td width="13%" nowrap>支票号码：</td>
                  <td width="35%"> 
                    <input class="button" type="text" value="" name="tem4" onKeyPress="return isKeyNumberdot(0)">
				  </td>
                </tr>
				<!--xl add-->
				<tr bgcolor="#E8E8E8"> 
                  <td width="13%" nowrap>发票序列号：</td>
                  <td width="35%"> 
                    <input class="button" type="text" value="" name="seq_num" onKeyPress="return isKeyNumberdot(0)">
					 
				  </td>
                  <td width="13%" nowrap>合计金额：</td>
                  <td width="35%"> 
                    <input class="button" type="text" value="" name="tem8" onKeyPress="return isKeyNumberdot(2)">
				 
				  </td>
                </tr>
				<!--end add-->
				<tr bgcolor="#E8E8E8"> 
                  <td width="13%" nowrap>项目1：</td>
                  <td colspan="3"> 
                    <input class="button" type="text" value="" size="83" name="tem5">
				  </td>                  
                </tr>

                <tr bgcolor="#E8E8E8"> 
                  <td width="13%" nowrap>项目2：</td>
                  <td colspan="3"> 
                    <input class="button" type="text" value="" size="83" name="tem6">
				  </td>                  
                </tr>

				<tr bgcolor="#E8E8E8"> 
                  <td width="13%" nowrap>项目3：</td>
                  <td colspan="3"> 
                    <input class="button" type="text" value="" size="83" name="tem7">
				  </td>                  
                </tr>


				<input type="hidden" id="check_s" name="check_q"> 
				<input type="hidden" id="s_flag" name="s_flag1"> 

				<tr bgcolor="#E8E8E8"> 
                  <td width="13%" nowrap>备  注：</td>
                  <td colspan="3"> 
                    <input class="button" type="text" value="" size="83" name="tem9">
				  </td>                  
                </tr>
              </table>
            </td>
          </tr>
          </tbody> 
        </table>
        <TABLE width="98%" height=27 border=0 align="center" cellSpacing="1" bgcolor="#FFFFFF">
          <TR > 
            <TD noWrap bgcolor="#E8E8E8"   align="center"> 
			<!--
                 <input type="button" name="query"  class="button" value="打印" onclick="docheck()" index="9">
                &nbsp;
			-->	
                <input type="button" name="return1" class="button" value="清除" onclick="doclear()" index="10">
                &nbsp;
                <input type="button" name="return2" class="button" value="关闭" onClick="window.close()" index="13">
             </TD>
          </TR>
        </TABLE>
      <p>&nbsp;</p>
    </td>
  </tr>
</table>
</form>
 </BODY>
</HTML>