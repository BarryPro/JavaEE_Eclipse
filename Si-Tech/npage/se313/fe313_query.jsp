<%
  /*
   * ����:Ӫҵ����mac��ַ��ɾ����ѯ�������
   * �汾: 1.0
   * ����: 2011/10/10
   * ����: diling
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="java.io.*"%>


<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		
		String opCode = "e313";
		String opName = "Ӫҵ����mac��ַ��ɾ��";

		String regionCode = (String)session.getAttribute("orgCode");
		
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regionCode" routerValue="<%=regionCode%>" id="printAccept"/>
<%

		/**************** ��ҳ���� ********************/
		int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
		int iPageSize = 10;
		int iStartPos = (iPageNumber-1)*iPageSize;
		System.out.println("iStartPos================"+iStartPos);
		int iEndPos = iPageNumber*iPageSize;
		System.out.println("iEndPos================"+iEndPos);
		/**********************************************/	
			
		SPubCallSvrImpl impl = new SPubCallSvrImpl();
		
		String[][] allNumStr = new String[][]{};
		String[][] result1 = new String[][]{};
		
		//String groupId1 = (String)session.getAttribute("groupId");
		String groupId1 = (String)request.getParameter("groupId");
        System.out.println("groupId1====e313============"+groupId1);
        //��ѯ�ܼ�¼��
		String sqlStr = "SELECT COUNT(*) FROM DCHNGROUPMSG A, DTOWNMACBINDNEW B"
		                + " WHERE A.GROUP_ID = B.GROUP_ID AND B.GROUP_ID = '"+groupId1+"' ORDER BY MAC_ADDR";
		             
	  //��ѯ���� 
        String sqlStr1 = "SELECT B.GROUP_ID, A.GROUP_NAME, B.MAC_ADDR,B.IP_ADDR,B.TRANS_MODE FROM DCHNGROUPMSG A, DTOWNMACBINDNEW B" 
                        + " WHERE A.GROUP_ID = B.GROUP_ID AND B.GROUP_ID = '"+groupId1+"' ORDER BY MAC_ADDR";      
     
	%>
			
        <wtc:pubselect name="sPubSelect" routerKey="regionCode" routerValue="<%=regionCode%>" outnum="1" retcode="retCode" retmsg="retMsg">
            <wtc:sql><%=sqlStr%></wtc:sql>         
        </wtc:pubselect>
        <wtc:array id="retList" scope="end"/>   
        
         <wtc:pubselect name="sPubSelect" routerKey="regionCode" routerValue="<%=regionCode%>" outnum="5" retcode="retCode1" retmsg="retMsg1">
            <wtc:sql><%=sqlStr1%></wtc:sql>         
        </wtc:pubselect>
        <wtc:array id="retList1" scope="end"/>
      <%
            if(!("000000").equals(retCode)){
            System.out.println("==========û�ɹ�����=============");
      %>
                <script language="JavaScript">
                    rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
		            return false;
                </script>
      <%
        }else{
            if(!"000000".equals(retCode1)){
      %>
            <script language="JavaScript">
                rdShowMessageDialog("������룺"+retCode1+"<br>������Ϣ��"+retMsg1,0);
	            return false;
            </script>
      <%
            }else{
                System.out.println("==========�ɹ��ˣ���=============");
                System.out.println("retcode================"+retCode);
                 System.out.println("retMsg================"+retMsg);
    			allNumStr = retList;
    			System.out.println("allNumStr = " + allNumStr[0][0]);
    		    result1   = retList1;
%>
<html>
<head>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>
<script language="JavaScript">
function delInfoDetail(i)
{ 
	var tempMacAddr         = "macAddr"+i;
	var temMacAddr          = document.form1(tempMacAddr).value;
	var tempGroupId         = "groupId"+i;
	var temGroupId          = document.form1(tempGroupId).value;
  //alert("temGroupId======"+temGroupId);
  if(rdShowConfirmDialog('ȷ��Ҫɾ��������Ϣ��')==1)
	{
		document.form1.action="fe313_del.jsp?"+"macAddr="+temMacAddr+"&groupId="+temGroupId;
 	  form1.submit();
	}
}

</script>
<body>
<form name="form1" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title">
		<div id="title_zi">Ӫҵ����mac��ַ�����ò�ѯ�������</div>
	</div>
  <table id="table_1" cellspacing="0" >
		<tr>
			<th nowrap>Ӫҵ������</th>
			<th nowrap>Ӫҵ������</th>
			<th nowrap>mac��ַ</th>
			<th nowrap>IP��ַ</th>
			<th nowrap>���䷽ʽ</th>
			<th nowrap>����</th> 
	  </tr> 
		<%
			if(result1.length == 0)
			{
				out.println("<tr height='25' align='center'><td colspan='4'>");
				out.println("<font class='orange'>û���κμ�¼��</font>");
				out.println("</td></tr>");
			}else if(result1.length>0){
			for(int i = iStartPos; i < Math.min(iEndPos,result1.length); i++)
			{
	%>			
			<tr>
				<td class="blue" align="left" nowrap><%=result1[i][0].trim()%>&nbsp;</td>
				<td class="blue" align="left" nowrap><%=result1[i][1].trim()%>&nbsp;</td>
				<td class="blue" align="left" nowrap><%=result1[i][2].trim()%>&nbsp;</td>
				<td class="blue" align="left" nowrap><%=result1[i][3].trim()%>&nbsp;</td>
				<td class="blue" align="left" nowrap><%=result1[i][4].trim()%>&nbsp;</td>
				<td class="blue" align="left" nowrap>
					<input name="del<%=i%>" class="b_text" type="button" value="ɾ��" onClick="delInfoDetail(<%=i%>)" >&nbsp;
					<input type=hidden name="opCode" value="<%=opCode%>"></input>
				  <input type=hidden name=groupId<%=i%> value="<%=result1[i][0]%>"></input>
				  <input type=hidden name=groupName<%=i%> value="<%=result1[i][1]%>"></input>
				  <input type=hidden name=macAddr<%=i%> value="<%=result1[i][2]%>"></input>
				  <input type="hidden" name="iLoginAccept" value="<%=printAccept%>">
				  
				</td>
				
				
		 </tr>
	<%
				}
			}
	%>		
	    <tr>
	    	<td colspan="10" align="center">
					<div id="page0" style="position:relative;font-size:12px;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           			<%	
					    //ʵ�ַ�ҳ
					    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
					    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
						  PageView view = new PageView(request,out,pg); 
					   	view.setVisible(true,true,0,0);      
					%>
					</div>
				</td>
	    </tr>
	    
			<tr> 
				<td align="center" id="footer" colspan="10"> 
					<input type="button" name="return" class="b_foot" value="����" onclick="location='fe313_main.jsp'" />
				</td>
	    </tr>
	</table>

<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>  
<%
}
}
%>