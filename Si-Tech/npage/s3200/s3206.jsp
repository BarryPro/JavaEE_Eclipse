<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-10-13
********************/
%>
              
<%
  String opCode = "3206";
  String opName = "VPMN集团查询";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 




<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	  String org_code = (String)session.getAttribute("orgCode");
	  String nopass = (String)session.getAttribute("password");
	
	
%>
<HTML><HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>


<script language="JavaScript">

 function DoCheck()
 {

    if(document.all.TGrpId.value=="")
    {
      rdShowMessageDialog("请输入集团号");
      document.all.TGrpId.focus();
      return false;
    }
    else if(isNaN(document.all.TGrpId.value))
    {
       rdShowMessageDialog("集团号只能是数字");
       document.all.TGrpId.value = "";
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
    if (document.form.busyType[2].checked == true)
	{
        document.form.action="s3206BaseInfo.jsp";
        document.form.TBackNote.value = "集团基本信息查询";
	}
	if (document.form.busyType[1].checked == true)
	{
        document.form.action="s3206Fee.jsp";
        document.form.TBackNote.value = "集团费用信息查询";
	}
	if (document.form.busyType[0].checked == true)
	{
        document.form.action="s3206All.jsp";
        document.form.TBackNote.value = "集团全部信息查询";
	}

	form.submit();
  }
 </script> 
 
<title>黑龙江移动通信-集团信息查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<BODY>
<FORM action="" method="post" name="form">
	<%@ include file="/npage/include/header.jsp" %>  
<input type="hidden" name="Op_Code"  value="3206">
<input type="hidden" name="WorkNo"  value="<%=workno%>">
<input type="hidden" name="WorkName"  value="<%=workname%>">
<input type="hidden" name="NoPass" value="<%=nopass%>">
<input type="hidden" name="OrgCode" value="<%=org_code%>">
	<div class="title">
		<div id="title_zi">VPMN集团查询</div>
	</div>
              <table cellspacing=0>
                <tr> 
                  <td class=blue>查询方式 </td>
                  <td colspan=3> 
                    <input name="busyType" type="radio" value="3" checked>
										全部信息
                    <input name="busyType" type="radio" value="2" >
                    话费信息 
                    <input name="busyType" type="radio" value="1" >
                    基本信息  </td>
             
                <tr> 
                  <td nowrap  class=blue>集团号</td>
                  <td > 
                    <input type="text" name="TGrpId" size="20" maxlength="10"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) DoCheck();" >
                  </td>
                  <td >&nbsp;</td>
                  <td >&nbsp; </td>
                </tr>
                <tr> 
                  <td  nowrap  class=blue>用户备注 </td>
                  <td colspan="3"> 
                    <input  type="text" name="TBackNote" size="60" >
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          </tbody> 
        </table>
        <TABLE  cellSpacing="0" >
          <TR > 
            <TD noWrap colspan="6" id="footer"> 
              <div align="center"> 
                <input type="button" name="Submit1"  class="b_foot" value="查询" onclick="DoCheck()" >
                <input type="reset" name="reset1" class="b_foot" value="清除" >
                <input type="button" name="return" class="b_foot" value="关闭" onClick="removeCurrentTab()">
              </div>
            </TD>
          </TR>
        </TABLE>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script language="JavaScript">
document.form.TGrpId.focus();
</script>
</body>
</html>
