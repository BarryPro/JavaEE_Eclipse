<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-14 ҳ�����,�޸���ʽ
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String[] mon = new String[]{""};
	
    Calendar cal = Calendar.getInstance(Locale.getDefault());
		cal.set(Integer.parseInt(dateStr.substring(0,4)),(Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
		for(int i=0;i<=0;i++)
    {
        if(i!=0)
        {
          mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
          cal.add(Calendar.MONTH,-1);
        }
        else
          mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
      }        

	String opCode = "1500";
  String opName = "�ۺ���Ϣ��ѯ֮�û����ֲ�ѯ";
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String id_no  = request.getParameter("idNo");
	String phoneNo  = request.getParameter("phoneNo");
	String cust_name  = request.getParameter("custName");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	//add by diling for ��ȫ�ӹ��޸ķ����б�
	String password = (String) session.getAttribute("password");
	
	String opCode4 = "4966";
	//����ʱ�� �Ż����� �Ż����� ���ѻ��� ����ģ�� �������� ��ע
		
%>
	<wtc:service name="sMarkMsgQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum=
"16">
        <wtc:param value="0"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=work_no%>"/>
        <wtc:param value="<%=password%>"/>
        <wtc:param value="<%=phoneNo%>"/>
        <wtc:param value=""/>
        </wtc:service>
        <wtc:array id="mainQryArr" scope="end"/>
        	
     <wtc:service name="sMarkExchQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum=
"16">
        <wtc:param value="0"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=work_no%>"/>
        <wtc:param value=""/>
        <wtc:param value="<%=phoneNo%>"/>
        <wtc:param value=""/>
        <wtc:param value="19900101"/>
        <wtc:param value="<%=dateStr%>"/>
        </wtc:service>
        <wtc:array id="MarkExchArr" scope="end"/>		
<!--
		<wtc:service name="s4966Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode4" retmsg="retMsg4" outnum="8" >
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=opCode4%>"/>
		</wtc:service>
		<wtc:array id="result4" scope="end"/>
-->	

<%
	if (mainQryArr.length<1) {
%>
		<script language="JavaScript">
			rdShowMessageDialog("û�з�������������!");
			history.go(-1);
		</script>
<%	
		return;
		}
		
%>

<script>
function doCheck()
{	
	if( document.f1500_dMarkMsg.endMonth.value<document.f1500_dMarkMsg.beginMonth.value) 
	{	
		rdShowMessageDialog("��������ȷ�Ĳ�ѯ������");
		document.f1500_dMarkMsg.beginMonth.select();
		return false;
	} else {
		document.f1500_dMarkMsg.action="f1500_dMarkMsg2.jsp";
		f1500_dMarkMsg.submit();
	}
	return true;
}
</script>

<HTML><HEAD><TITLE>�ͻ�Ѫֵ��ѯ</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_dMarkMsg">
<%@ include file="/npage/include/header.jsp" %> 

		<input type="hidden" value="<%=phoneNo%>" name="phoneNo">
    	
		<div class="title">
			<div id="title_zi">�û���Ϣ</div>
		</div>
    <table cellspacing="0">
      <TBODY>
        <tr>
          <td class="blue" width="13%">�ֻ�����</td>
          <td width="20%"><%=phoneNo%>&nbsp;</td>                  
          <td class="blue" width="13%">�ͻ���ʶ</td>
          <td width="20%"><%=id_no%>&nbsp;</td>
          <td class="blue" width="13%">����ʱ��</td>
          <td width="20%"><%=mainQryArr[0][7]%>&nbsp;</td>
        </tr>
        <tr>
          <td class="blue">��ǰѪֵ</td>
          <td><%=mainQryArr[0][0]%>&nbsp;</td>
          <td class="blue">�� �� ֵ</td>
          <td><%=mainQryArr[0][1]%>&nbsp;</td>                  
          <td class="blue">��ǰ����</td>
          <td><%=mainQryArr[0][2]%>&nbsp;</td>
				</tr>
        <tr>
          <td class="blue">����Ѫֵ</td>
          <td><%=mainQryArr[0][5]%>&nbsp;</td>
		  <td class="blue">����ʱ��</td>
		  <td><%=mainQryArr[0][13]%></td>
          <td class="blue">����ʱ��</td>
          <td><%=mainQryArr[0][8]%>&nbsp;</td>
<!--          
        </tr>
          <td class="blue">2006�꼰��ǰѪֵ</td>
          <td><%=result4[0][4]%>&nbsp;</td>
 		  <td class="blue"><%=result4[0][2]%>��Ѫֵ</td>
 		  <td><%=result4[0][6]%></td>
          <td class="blue"><%=result4[0][3]%>��Ѫֵ</td>
          <td><%=result4[0][7]%>&nbsp;</td>
        </tr>
        <tr>
          <td class="blue" style="color:red;font-weight: bold"><%=result4[0][1]%>��Ѫֵ(����Ѫֵ����<%=result4[0][3]%>��ĩ����)</td>
          <td style="color:red;font-weight: bold" font-weight: bold><%=result4[0][5]%>&nbsp;</td>
 		  <td class="blue">&nbsp;</td>
 		  <td>&nbsp;</td>
          <td class="blue">&nbsp;</td>
          <td>&nbsp;</td>          
        </tr>        
-->               
        <tr>
          <td class="blue">��ʼ����</td>
          <td>
        	 	<input class="text" name="beginMonth" value="<%=mon[0]%>" maxlength="6" size=21 style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">
        	</td>
          <td class="blue">��������</td>
          <td colspan="3">
          	<input class="text" name="endMonth" value="<%=mon[0]%>" maxlength="6" size=21 style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">&nbsp;&nbsp;&nbsp;&nbsp;
         		<input type="button" class="b_text" name="Button1" value="��ѯѪֵ���ɼ�¼" onclick="doCheck()">
         	</td>
        </tr>
      </TBODY>
		</TABLE>
    </div>
    
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">������ϸ</div>
			</div>
	    <table cellspacing="0">
	      <tr align="center"> 
	        <th>����ʱ��</th>
	        <th>�Ż�����</th>
	        <th>�Ż�����</th>
	        <th>����Ѫֵ</th>
	        <th>����ģ��</th>  
	        <th>��������</th>
	        <th>������ע</th>  
	      </tr>
		<%
			String tbClass="";
			for(int y=0;y<MarkExchArr.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
		%>
		
				<tr align="center">
					<td class="<%=tbClass%>"><%=MarkExchArr[y][8]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][1]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][3]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][2]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][5]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][6]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][9]%>&nbsp;</td>
				</tr>
		<%
		    }
		%>
	</table>

      
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab(<%=opCode%>)" type=button value=�ر�>
    	    </td>
          </tr>
        </tbody> 
      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>

