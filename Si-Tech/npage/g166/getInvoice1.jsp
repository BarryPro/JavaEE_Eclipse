<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-07
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%	
        response.setHeader("Pragma","No-Cache"); 
	    response.setHeader("Cache-Control","No-Cache");
        response.setDateHeader("Expires", 0); 
%>
<%
    String opCode = "g166";
    String opName = "������Ϣ��ѯ";
	String utype = request.getParameter("utype");
	String yyt = request.getParameter("yyt");
	String qxmc = request.getParameter("qxmc");
	String ds = request.getParameter("ds");
	String outNum = "5";
	String[] inParas2 = new String[2];
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAA "+utype);
	if(utype.equals("0"))
	{
		System.out.println("QQQQQQ ӪҵԱ");
		%>
			<script language="javascript">
				//alert("ӪҵԱ�Ĳ���!");
				window.close();
			</script>
		<%
	}
	else
	{
		if(utype.equals("1"))
	{
		System.out.println("QQQQQQ Ӫҵ��");//Ӫҵ��ȡ���� ӪҵԱ��level=0
		inParas2[0]="select to_char(invoice_id),to_char(invoice_no) from dLossInvoice where type_id='2' and group_id in (select group_id from dchngroupinfo where parent_group_id=:utype) and level_type='0' and flag='Y'";
		inParas2[1]="utype= "+yyt;
	}
	if(utype.equals("2"))
	{
		System.out.println("QQQQQQ ����");//����ȡ���� Ӫҵ����level=1
		inParas2[0]="select to_char(invoice_id),to_char(invoice_no) from dLossInvoice where type_id='2' and group_id in (select group_id from dchngroupinfo where parent_group_id=:utype) and level_type='1' and flag='Y'";
		inParas2[1]="utype= "+qxmc;
	}
	if(utype.equals("3"))
	{
		//����ȡ���� ���صĵ�level=2
		String ds1 = ds.substring(2,7);
		inParas2[0]="select to_char(invoice_id),to_char(invoice_no) from dLossInvoice where type_id='2' and group_id in (select group_id from dchngroupinfo where parent_group_id=:utype) and level_type='2' and flag='Y'";
		inParas2[1]="utype= "+ds1;
		System.out.println("QQQQQQ ���� "+inParas2[0]+" and where����is "+inParas2[1]);
	}
	
	String incoiceno=""; 
	String incoiceid="";
%>
   <wtc:service name="TlsPubSelBoss"   retcode="retCode" retmsg="retMsg" outnum="2" >
    	<wtc:param value="<%=inParas2[0]%>"/>
    	<wtc:param value="<%=inParas2[1]%>"/> 
    </wtc:service>
    <wtc:array id="result" scope="end"/>
 
 	 
    

 
<%  
	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@ result.length is "+result.length+" and inParas2[0] is "+inParas2[0]+" and inParas2[1] is "+inParas2[1]);
	if(result.length ==0)
	{
		%>
			<script language="javascript">
				//alert("�޲�ѯ���!");
				window.close();
			</script>
		<%
	}
	else if ((result.length  )==1 ) { %>      
 	<SCRIPT LANGUAGE="JavaScript">
        window.returnValue='';
        <%if (result.length == 1) {%>
            var temp = new Array();
            temp[0] = '<%=result[0][0].trim()%>';
	        temp[1] = '<%=result[0][1].trim()%>';
	         
		    window.returnValue = temp;
			window.close();		    
		<%}   %>
 	</SCRIPT>
<%  } else { %>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>������BOSS-�ʺŲ�ѯ</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script language="JavaScript">
window.returnValue='';
function selAccount() {
	if(typeof(document.frm.account)!="undefined"){
	   for(i=0;i<document.frm.account.length;i++) {    
		  if (document.frm.account[i].checked==true) {
	 	    var temp = new Array();
	        temp[0] = document.frm.account[i].value;
		    temp[1] = document.frm.pno.value; 
			//alert(temp);
			window.returnValue = temp;
	        break;
		  }
	   }		
	}
   window.close();
}
</script>

</head>

<BODY>
<form name="frm" method="post" action="">
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>
<input type="hidden" name="pno" value="">
      
   
  <table cellSpacing=0>
    <tr> 
      <th> 
        <div align="center">&nbsp;</div>
      </th>
      <th> 
        <div align="center">��Ʊ����</div>
      </th>
      <th> 
        <div align="center">��Ʊ����</div>
      </th>
	   

    </tr>
    <% for(int i=0; i < result.length  ; i++)
	{
		%>
			<tr> 
			  <td > 
				<div align="center"> 
				  <input type="radio" name="account" value="<%=result[i][0].trim()%>" onClick="JavaScript:document.frm.pno.value='<%=result[i][1]%>'">
				</div>
			  </td>
			  <td > 
				<div align="center"><%=result[i][0]%></div>
			  </td>
			  <td > 
				<div align="center"><%=result[i][1]%></div>
			  </td>
			   
			   
			</tr>
    <%}%>

	 
 
    <tr> 
      <td id="footer" colspan="6"> 
          <input class="b_foot" type="button" name="Button" value="ȷ��" onClick="selAccount()">
          <input class="b_foot" type="button" name="return" value="����" onClick="window.close()">
      </td>
    </tr>
  </table>
  <%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>
<%}%>
<%	}
	%>
	

