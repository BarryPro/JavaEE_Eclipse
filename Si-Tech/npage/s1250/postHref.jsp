<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.*" %>

<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.io.*"%>

<%
	String postFlag = "";
	String postType = "05";
	String postName = "";
	String postAddr = "";
	String post_zip = "";
	String fax_no = "";
	String mail_addr = "";
	String post_note = "增加用户联系方式";
	String Phone_no = request.getParameter("Ed_Phone_no");

	SPubCallSvrImpl post = new SPubCallSvrImpl();
	String  inputParsm [] = new String[2];
	inputParsm[0] = "5001";
	inputParsm[1] = Phone_no;
	String [] cussidArr=post.callService("sPCSelService",inputParsm,"8","phone",Phone_no);
	if(post.getErrCode() == 0)
	{
		postFlag =  cussidArr[0];
		postName =  cussidArr[2];
		postAddr =  cussidArr[3];
		post_zip =  cussidArr[4];
		fax_no = cussidArr[5];
		mail_addr = cussidArr[6];
		post_note = cussidArr[7];		
	}

//----------------------------------------------------------
  
%>	


<HTML><HEAD><TITLE>积分兑奖</TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_image.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_single.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/date/iOffice_Popup.js"></script>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0">
<script language=javascript>


 
 function chkSim()
  {
  
    
     
       //alert(document.all.pphoneno.value);
   	var myPacket = new RPCPacket("chgSim.jsp","正在查询客户，请稍候......");
	myPacket.data.add("phoneNo",jtrim(document.all.phoneno.value));
	myPacket.data.add("opCode",jtrim(document.all.op_code.value));
	core.rpc.sendPacket(myPacket);
	delete(myPacket);
  }

function blank()
{
  //window.returnValue="";
  window.close();
}
function PostCfm()
{

if(check(s1250))
{ 

   s1250.action='sMarkPostCfm.jsp';
    window.close();
  
  }
}
 //-->
</script>

<!--**************************************************************************************-->
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0" background="<%=request.getContextPath()%>/images/jl_background_2.gif">
      <FORM method=post name="s1250" action="sMarkPostCfm.jsp" onKeyUp="chgFocus(s1250)">
<input type="hidden" name="Phone_no" value="<%=Phone_no%>">
<input class="hidden" type="hidden" name=postType readonly maxlength=20 value="">
<input class="hidden" type="hidden" name=post_note readonly maxlength=20 value="">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="30%"> 
            <table width="400" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="42"><img src="<%=request.getContextPath()%>/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="400"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td background="<%=request.getContextPath()%>/images/jl_background_4.gif"><font color="FFCC00"><b>积分兑奖</b></font></td>
                      <td><img src="<%=request.getContextPath()%>/images/jl_ico_3.gif" width="250" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="70%"> 
            <table border="0" cellspacing="0" cellpadding="1" align="right">
              <tr>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>

<table width="462" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
<TR bgcolor="#EEEEEE"> 
            <TD colspan="4" height="15"></TD>
                   
	</TR>
   <TR bgcolor="#EEEEEE"> 
            <TD align="left" width=16%>邮寄姓名: </TD>
            <TD width="34%">
              
              <input name=postName class="button" v_must="1" v_maxlength=60 v_type="string" v_name="邮寄姓名" value="<%=postName%>" onBlur="if(this.value!=''){if(checkElement('postName')==false){return false;}}"  maxlength="60" index="9">  
            </TD>
            <TD align="left" width=16%>邮寄标记:</TD>
            <TD width="34%">
		 <select name="postFlag" class="button" index="15">
		 <option value="0" selected >邮寄</option>
                 <option value="1">传真</option>
                 <option value="2">电子邮件</option>
                </select>
            </TD>         
	</TR>
	   <TR bgcolor="#EEEEEE"> 
            <TD align="left" width=16%>邮 编: </TD>
            <TD width="34%">
                 <input name="post_zip" type="text" v_must="0" v_type="zip" v_name="邮寄编码" onBlur="if(this.value!=''){if(checkElement('post_zip')==false){return false;}}" class="button" maxlength="6" index="16" value="<%=post_zip%>">  
            </TD>
            <TD align="left" width=16%>邮寄地址:</TD>
            <TD width="34%">
		 <input type="text" class="button" v_must="0" v_name="邮寄地址" v_type="string" name="postAddr" onBlur="if(this.value!=''){if(checkElement('postAddr')==false){return false;}}" index="17" value="<%=postAddr%>" >
            </TD>         
	</TR>
	</TR>
	   <TR bgcolor="#EEEEEE"> 
            <TD align="left" width=16%>传真号: </TD>
            <TD width="34%">
                  <input type="text" class="button" name="fax_no" v_must="0"  v_type="phone" v_name="传真号"  index="18" onBlur="if(this.value!=''){if(checkElement('fax_no')==false){return false;}}"  value="<%=fax_no%>" >
            </TD>
            <TD align="left" width=16%>E_Mail地址:</TD>
            <TD width="34%">
		 <input type="text" class="button" name="mail_addr"  v_name="E_Mail地址" index="18" onBlur="if(this.value!=''){if(checkElement('mail_addr')==false){return false;}}" value="<%=mail_addr%>" >
            </TD>         
	</TR>
  </table>


<!------------------------------------------------------>
    <TABLE width="462" border=0 align=center cellpadding="4" cellSpacing=1>
    <TBODY>
        <TR bgcolor="#EEEEEE"> 
            <TD align=center bgcolor="#EEEEEE">
             
                <input class="button" name=commit type=submit value="确认" onClick="PostCfm()" >&nbsp;
                <input class="button" name=back onClick="blank()" style="cursor:hand" type=button value=返回>&nbsp;
            </TD>
        </TR>
    </TBODY>
    </TABLE>
  
  <!------------------------> 
  <input type="hidden" name="modeCode" >
  <input type="hidden" name="modeName" >
  <!------------------------>  
</FORM>
</BODY></HTML>    

