<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-10-13
********************/
%>
              
<%
  String opCode = "3206";
  String opName = "VPMN���Ų�ѯ";
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
      rdShowMessageDialog("�����뼯�ź�");
      document.all.TGrpId.focus();
      return false;
    }
    else if(isNaN(document.all.TGrpId.value))
    {
       rdShowMessageDialog("���ź�ֻ��������");
       document.all.TGrpId.value = "";
       document.all.TGrpId.focus();
       return false;
    }
	else if( document.all.TGrpId.value.length != 10 )
    {
      rdShowMessageDialog("���ź�ֻ����10λ");
      document.all.TGrpId.value = "";
      document.all.TGrpId.focus();
      return false;
    }
    if (document.form.busyType[2].checked == true)
	{
        document.form.action="s3206BaseInfo.jsp";
        document.form.TBackNote.value = "���Ż�����Ϣ��ѯ";
	}
	if (document.form.busyType[1].checked == true)
	{
        document.form.action="s3206Fee.jsp";
        document.form.TBackNote.value = "���ŷ�����Ϣ��ѯ";
	}
	if (document.form.busyType[0].checked == true)
	{
        document.form.action="s3206All.jsp";
        document.form.TBackNote.value = "����ȫ����Ϣ��ѯ";
	}

	form.submit();
  }
 </script> 
 
<title>�������ƶ�ͨ��-������Ϣ��ѯ</title>
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
		<div id="title_zi">VPMN���Ų�ѯ</div>
	</div>
              <table cellspacing=0>
                <tr> 
                  <td class=blue>��ѯ��ʽ </td>
                  <td colspan=3> 
                    <input name="busyType" type="radio" value="3" checked>
										ȫ����Ϣ
                    <input name="busyType" type="radio" value="2" >
                    ������Ϣ 
                    <input name="busyType" type="radio" value="1" >
                    ������Ϣ  </td>
             
                <tr> 
                  <td nowrap  class=blue>���ź�</td>
                  <td > 
                    <input type="text" name="TGrpId" size="20" maxlength="10"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) DoCheck();" >
                  </td>
                  <td >&nbsp;</td>
                  <td >&nbsp; </td>
                </tr>
                <tr> 
                  <td  nowrap  class=blue>�û���ע </td>
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
                <input type="button" name="Submit1"  class="b_foot" value="��ѯ" onclick="DoCheck()" >
                <input type="reset" name="reset1" class="b_foot" value="���" >
                <input type="button" name="return" class="b_foot" value="�ر�" onClick="removeCurrentTab()">
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
