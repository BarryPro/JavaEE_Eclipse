<%
/********************
version v2.0
������: si-tech
liyan 20080805 Ӧ���ʽ����ϵͳ@ӪҵԱ�Ͻ����ѯ
չʾ���� op_code=4928
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>ӪҵԱ�Ͻ����ѯ</title>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
    String workNoFromSession=(String)session.getAttribute("workNo");
	//String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	     workNoFlag=true;

    String work_no = (String)session.getAttribute("workNo");
    String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));	
    String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</head>
<body >
<form name="frm" method="POST" action="f4928Qry.jsp" >
	<%@ include file="/npage/include/header.jsp" %>
<input type=hidden name=opCode value="<%=opCode%>">
<input type=hidden name=opName value="<%=opName%>">
	<div class="title">
        		<div id="title_zi">ӪҵԱ�Ͻ����ѯ</div>
        	</div>
      <table >
     	<tr >
           <TD class="blue">��ʼʱ�䣺&nbsp;<input type="text" v_type="date" v_name="��ʼʱ��" class="button" name="begin_time" value=<%=dateStr%> size="17" maxlength="8" v_type="0_9" v_name="��ʼʱ��" v_must=1  ></TD>
           <TD class="blue">����ʱ�䣺&nbsp;<input type="text" v_type="date" v_name="����ʱ��" class="button" name="end_time" value=<%=dateStr%> size="17" maxlength="8" v_type="0_9" v_name="����ʱ��" v_must=1  ></TD>
       </tr>
	   <tr>
           <td colspan="2" ><div align="center">

           </div></td>
       </tr>
       		
          <TR id="footer">

        <TD colspan=6>
               <input class="b_foot" type=button name="confirm" value="��ѯ" onClick="doCfm(this)" index="2">
               <input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
      		     <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">

        </TD>

    </TR>
      
       <tr><td colspan="2" ><font color="#FF0000">ע����ѯ�����������ͨ��������δͨ�����������Ѿ���յ����ݡ�</font></td></tr>

      </table>
 <%@ include file="/npage/include/footer.jsp" %>
   </form>
</body>
</html>

<script language="JavaScript">
function doCfm()
 {
	//�ж�ʱ���Ƿ���Ч
	if(!check(frm))
	{
		return false;
	}
	var begin_time=document.frm.begin_time.value;
	var end_time=document.frm.end_time.value;
	/*
	if (isValidYYYYMMDD(document.frm.begin_time.value) != 0)
    {
	  	rdShowMessageDialog("��ʼʱ���ʽ����! <br>ӦΪ��YYYYMMDD ");
	  	document.frm.begin_time.focus();
	  	return false;
    }*/
	if(begin_time>end_time)
	{
		rdShowMessageDialog("��ʼʱ�䲻�ɱȽ���ʱ���");
		return false;
	}
	document.frm.submit();
	return true;
}
</script>