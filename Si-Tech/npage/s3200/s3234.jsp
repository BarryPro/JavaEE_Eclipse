<%
/********************
 version v2.0
 开发商 si-tech
 update wuxy@2011-7-21
********************/
%>
              
<%
  String opCode = "3234";
  String opName = "查询集团网外号码列表";
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	

<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.config.INIT_DATA"%>
<%

        ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
        String[][] baseInfoSession = (String[][])arrSession.get(0);
        String[][] otherInfoSession = (String[][])arrSession.get(2);
        String loginNo =(String)session.getAttribute("workNo");
        String loginName = (String)session.getAttribute("workName");
        String orgCode = (String)session.getAttribute("orgCode");
        String ip_Addr = (String)session.getAttribute("ipAddr");

        String regionCode = (String)session.getAttribute("regCode");
        String regionName = regionCode;

        String GroupId = baseInfoSession[0][21];
        String OrgId = baseInfoSession[0][23];
				
				
				System.out.println("-------------------orgCode----------------"+orgCode);
				System.out.println("-------------------GroupId----------------"+GroupId);
				System.out.println("-------------------OrgId------------------"+OrgId);


%>
<%

    int isGetDataFlag = 1;  //0：正确,其他错误. add by yl.
    String errorMsg ="";
    String tmpStr="";
    String insql = "";

dataLabel:
    while(1==1){

    isGetDataFlag = 0;
 break;
 }


     errorMsg = "取数据错误："+Integer.toString(isGetDataFlag);

     //System.out.println(errorMsg);
%>

<%if( isGetDataFlag != 0 ){%>
<script language="JavaScript">
	
<!--
    rdShowMessageDialog("<%=errorMsg%>");
    window.close();
    window.opener.focus();
//-->
</script>
<%}%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>查询集团网外号码列表</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../css/jl.css" rel="stylesheet" type="text/css">

<script language="JavaScript">

function commitJsp()
    {
        if(document.all.TGrpId.value=="")
    	{
    	  rdShowMessageDialog("请输入集团号");
    	  document.all.TGrpId.focus();
    	  return false;
    	}
		else if( document.all.TGrpId.value.length != 10 )
    	{
    	  rdShowMessageDialog("集团号只能是10位");
    	  document.all.TGrpId.value = "";
    	  document.all.TGrpId.focus();
    	  return false;
    	}

	    document.frm.action="s3234Cfm.jsp";
	  
	    document.frm.submit();
    }
   
   function resetJsp()
       {
       	
       	  document.all.TGrpId.value="";
       	  document.all.TGrpId.focus();
       	
       }

</script>

</head>


<body>
<form name="frm" method="post" action="">
 <%@ include file="/npage/include/header.jsp" %>                         
<div class="title">
		<div id="title_zi">查询集团网外号码列表</div>
	</div>
        <table  cellspacing="0" >

          <tr >
            <td nowrap  class=blue>集团号</td>
                  <td >
                    <input type="text" name="TGrpId" size="20" maxlength="10"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) DoCheck();" >
                  </td>
                  <td >&nbsp;</td>
                  <td >&nbsp; </td>
          </tr>
          
          <tr>
            <td id="footer" colspan="4"> <div align="center"> &nbsp;
                <input name="confirm" type="button" class="b_foot" value="确认" onClick="commitJsp()">
                &nbsp;
                <input name="reset" type="button"  class="b_foot"  value="清除" onClick="resetJsp()">
                &nbsp;
                <input name="back" onClick="removeCurrentTab()"  class="b_foot" type="button"  value="关闭">
                &nbsp; </div></td>
          </tr>
        </table>
 

   
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

