<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-------------------------------------------->
<!---����   2008-7-7                     	---->
<!---����   zhouzy                        ---->
<!---����   f1500_qryCntt           			---->
<!---����   �ͻ�ͳһ�Ӵ���ѯ          		---->
<!-------------------------------------------->        
<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%
	String cust_name  = request.getParameter("custName");
	String workNo=request.getParameter("workNo");
	String orgCode=request.getParameter("orgCode");
	String phoneNo=request.getParameter("phoneNo");
	String opCode = "3794";
	String opName="�Ӵ�������Ϣ��ѯ";
	String sqlStr="";	
	String beginDateStr = (new java.text.SimpleDateFormat("yyyy-MM-").format(new java.util.Date()))+"01 00:00:00";
	String endDateStr = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
%>

<HTML><HEAD><TITLE>�Ӵ�������Ϣ��ѯ</TITLE>
<script language="JavaScript">
	function commitJsp()
{		
		//if(!check(f1500qryCntt)){
			//return false;
		//}
	if(document.all.phoneNo.value=="")
	{
		rdShowMessageDialog("������Ӵ�ID");
		return false;
	}
    page = "f3794_22.jsp";
    f1500qryCntt.action=page;
    f1500qryCntt.method="post";
    f1500qryCntt.submit();
}
</script>
</HEAD>
<body>
<FORM name="f1500qryCntt">	
<%@ include file="/npage/include/header.jsp" %>
 <div class="title"><div id="title_zi">�Ӵ�������Ϣ��ѯ</div></div>
        <table cellSpacing=0>
         <tr>
                <td width="17%" class="blue">�Ӵ�ID</td>
				  <td width="83%" colspan= '3'><input type="text" name= 'phoneNo' id = 'phoneNo' value= ''></td>
         </tr>
 
          <tr> 
      	    <td id="footer" colspan="4">
      	    &nbsp; <input class="b_foot" name=submits onClick="commitJsp()" type=button value=��ѯ>	
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="parent._exttabref.removeTab('<%=opCode%>')" type=button value=�ر�>
    	      &nbsp; 
    	    </td>
          </tr>
      </table>
      <input type="hidden" name="phoneNo" value="<%=phoneNo%>">
      <input type="hidden" name="workNo" value="<%=workNo%>">
      <input type="hidden" name="orgCode" value="<%=orgCode%>">
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

