<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>"农信通"业务查询 </title>
<%
    String workNoFromSession=(String)session.getAttribute("workNo");
	String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;

    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = baseInfoSession[0][2];
    String loginName = baseInfoSession[0][3];
    String org_Code = baseInfoSession[0][16];

	String[][] temfavStr=(String[][])arrSession.get(3);
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
     favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
    if(Pub_lxd.haveStr(favStr,"a272"))
	  pwrf=true;
%>
<%
/*
  comImpl co=new comImpl();
 
  String sql = " select  unique sale_type,sale_type||'-->'||trim(sal_name) from sSaleType ";
  System.out.println("sql====="+sql);
  ArrayList agentCodeArr = co.spubqry32("2",sql);
  String[][] agentCodeStr = (String[][])agentCodeArr.get(0);
  */
%>

  </script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<link href="../../css/jl.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../js/common/common_check.js"></script>
<script type="text/javascript" src="../../js/common/common_util.js"></script>
<script type="text/javascript" src="../../js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="/page/s3000/js/S3000.js"></script>
<script language=javascript>
  onload=function()
  {
    document.all.srv_no.focus();
  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
 if(!check(frm)) return false; 
// var radio1 = document.getElementsByName("opFlag");
  //for(var i=0;i<radio1.length;i++)
 // {
    //if(radio1[i].checked)
	//{
	  //var opFlag = radio1[i].value;
	  //if(opFlag=="one")
	  //{
	 var js_pwFlag="<%=pwrf%>";
	  	if(js_pwFlag=="false"){
	  		if(jtrim(document.all.cus_pass.value).length==0){
	  			rdShowMessageDialog("用户密码不能为空！");
		 			document.all.cus_pass.focus();
		 			return false;
		 		}
	  	}   
	    	frm.action="f7165_1.jsp";
	    	document.all.opcode.value="7164";
	    	
	 
  frm.submit();	
  return true;
}
function opchange(){
	

	 if(document.all.opFlag[0].checked==true) 
	{
	  	
	  	document.all.backaccept_id.style.display = "none";
	  }else {
	  	document.all.backaccept_id.style.display = "";
	  	
	  }

}
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" background="../../images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
 <input type="hidden" name="opcode" >
<table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
 <td background="../../images/jl_background_1.gif">

     <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="45%"> 
            <p><img src="../../images/jl_chinamobile.gif" width="226" height="26"></p>
            </td>
          <td width="55%" align="right"><img src="../../images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">工号：<%=work_no%><img src="../../images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">操作员：<%=loginName%></td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" background="../../images/jl_background_3.gif" height="69"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="../../images/jl_logo.gif"></td>
                <td align="right"><img src="../../images/jl_head_1.gif"></td>
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
                <td width="42"><img src="../../images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td background="../../images/jl_background_4.gif" nowrap><font color="FFCC00"><b>"农信通"业务查询 </b></font></td>
                      <td><img src="../../images/jl_ico_3.gif" width="389" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            
          </td>
          <td width="27%"> 
            <table border="0" cellspacing="0" cellpadding="4" align="right">
              <tr>
                <td><img src="../../images/jl_ico_4.gif" width="60" height="50"></td>
                <td><img src="../../images/jl_ico_5.gif" width="60" height="50"></td>
                <td><img src="../../images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>

      <table width="98%" border="0" cellspacing="1" align="center" bgcolor="#FFFFFF">
          <tr> 
              <td colspan="4" bgcolor="#eeeeee" nowrap>&nbsp;</td>
          </tr>
          <!--
	  <TR bgcolor="#EEEEEE"> 
	          <TD width="16%">操作类型：</TD>
              <TD width="34%">
		<input type="radio" name="opFlag" value="one" onclick="opchange()" checked >申请&nbsp;&nbsp;
		<input type="radio" name="opFlag" value="two" onclick="opchange()" >冲正
	          </TD>
	          <TD width="16%"></TD>
		      </TD>
         </TR>   
         --> 
         <tr> 
            <td width="16%" bgcolor="#eeeeee" nowrap> 
              <div align="left">手机号码：</div>
            </td>
            <td nowrap bgcolor="#eeeeee" width="34%"> 
            <div align="left"> 
                <input class="button"  type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  v_name="服务号码" maxlength="11" index="0">
                <font color="#FF0000">*</font></div>
            </td>
            <td nowrap bgcolor="#eeeeee" width="16%"> 
              <div align="left">用户密码：</div>
            </td>
            <%if(pwrf) {%>
              <TD bgcolor="#eeeeee" width=34%>
			     <input type="password" class="button" name="cus_pass" size="20" maxlength="8" disabled> 		    
		      </TD>
			 <% } else { %>
				  <td nowrap bgcolor="#eeeeee" width="34%"> 
					<div align="left">
						  <jsp:include page="/page/common/pwd_1.jsp">
							  <jsp:param name="width1" value="16%"  />
							  <jsp:param name="width2" value="34%"  />
							  <jsp:param name="pname" value="cus_pass"  />
							  <jsp:param name="pwd" value="12345"  />
						 </jsp:include>
					</div>
				  </td>
			 <%}%>
         </tr>
         
           <td class=Lable bgcolor="#eeeeee" nowrap colspan="4">&nbsp;</td>
         </tr>
         <tr bgcolor="e8e8e8"> 
            <td colspan="5" > 
              <div align="center"> 
              <input class="button" type=button name="confirm" value="查询" onClick="doCfm(this)" index="2">    
              <input class="button" type=button name=back value="清除" onClick="frm.reset()">
		      <input class="button" type=button name=qryP value="关闭" onClick="window.close();">
              </div>
           </td>
        </tr>
      </table>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
  </td>
  </tr>
  </table>
    <%@ include file="../../page/common/pwd_comm.jsp" %>
   </form>
</body>
</html>