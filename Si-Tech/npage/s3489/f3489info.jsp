<%
   /*
   * ����: ͳ����ϵ��ѯ
�� * �汾: v1.0
�� * ����: 2009/02/05
�� * ����: wuxy
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   * 2009-09-15    qidp        �°漯�Ų�Ʒ����
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="java.text.DecimalFormat"%>

<%
		Logger logger = Logger.getLogger("f3489info.jsp");
		 
		String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
		String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
		String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
		String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
		String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
		DecimalFormat df = new DecimalFormat("#0.00");
		
		String opCode = "3489";
	    String opName = "ͳ���͸��ѹ�ϵ������ѯ";
	
		/**************** ��ҳ���� ********************/
		int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	  int iPageSize = 10;
	  int iStartPos = (iPageNumber-1)*iPageSize;
	  int iEndPos = iPageNumber*iPageSize;
	  String vStartPos = ""+iStartPos;
	  String vEndPos = ""+iEndPos;
	/**********************************************/
	String[][] result1 = new String[][]{};
	    String[][] result = new String[][]{};

		
        String queryType = request.getParameter("queryType");
        String favCond = request.getParameter("favCond");
        String favValue = request.getParameter("favValue");
        String begin_time=request.getParameter("begin_time")==null?"":request.getParameter("begin_time");
        String end_time=request.getParameter("end_time")==null?"":request.getParameter("end_time");
	    
	    System.out.println("queryType= " + queryType);
        System.out.println("favCond= " + favCond);
        System.out.println("favValue= " + favValue);
        System.out.println("begin_time= " + begin_time);
        System.out.println("end_time= " + end_time);
		
        String in_contract_pay = "";    //�����˻� 0
        String in_unit_id = "";	        //���ű�� 1
        String in_phone_no = "";  	    //��Ա���� 2
		
        if(!(favCond.equals(""))&&(favCond.equals("0")))
        {
            in_contract_pay = favValue;
        }
        else if(!(favCond.equals(""))&&(favCond.equals("1")))
        {
            in_unit_id = favValue;
        }
        else if(!(favCond.equals(""))&&(favCond.equals("2")))
        {
            in_phone_no = favValue;
        }
	 int recordNum = 0;
	  try
	  {
	  	%>
	  	    <wtc:service name="s3489EXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="18" >
                <wtc:param value="<%=opCode%>"/>
                <wtc:param value="<%=loginNo%>"/>
                <wtc:param value="<%=queryType%>"/> 
                <wtc:param value="<%=in_contract_pay%>"/> 
                <wtc:param value="<%=in_unit_id%>"/> 
                <wtc:param value="<%=in_phone_no%>"/> 
                <wtc:param value="<%=begin_time%>"/> 
                <wtc:param value="<%=end_time%>"/> 
                <wtc:param value="<%=vStartPos%>" />
    	        <wtc:param value="<%=vEndPos%>" />
            </wtc:service>
            <wtc:array id="retArr1" scope="end"/>
        <%
  		    System.out.println("# return from f3489info.jsp by s3489EXC -> retCode = " + retCode1);
  		    System.out.println("# return from f3489info.jsp by s3489EXC -> retMsg  = " + retMsg1);
  		    System.out.println("# return from f3489info.jsp by s3489EXC -> retArr  = " + retArr1.length);
  		    if (retArr1.length>0 && retCode1.equals("000000")){
  		        result1 = retArr1;
  		        recordNum = Integer.parseInt(result1[0][15].trim());
  		    }
	  }catch(Exception e)	
	  {
	    e.printStackTrace();
	    %>
          	<script language="javascript">
                rdShowMessageDialog("��ѯʧ�ܣ�",0);
    										 	
    		</script>
    	<%
	  	System.out.println("\n==================\n error1");
	  }
	  
	  if(result1==null || result1.length == 0)
	  {
    %>
      	<script language="javascript">
            rdShowMessageDialog("û�в鵽��ؼ�¼��");
										 	
		</script>
	<%
	  }	 
	%>	

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>


<script type=text/javascript>
		
	//���ƴ�����ƶ�
	function initAd() 
	{		
		document.all.page0.style.posLeft = -200;
		document.all.page0.style.visibility = 'visible'
		MoveLayer('page0');
	}
	
	function MoveLayer(layerName) 
	{
		var x = 10;
		var x = document.body.scrollLeft + x;		
		eval("document.all." + layerName + ".style.posLeft = x");
		setTimeout("MoveLayer('page0');", 20);
	}
</script>

<body>

<form name="form1" method="post" action="">	
<div id="Operation_Table">
		<table id="tabList" cellspacing=0>
			<tr>	
				<th nowrap>ͳ���˺�</th>
				<th nowrap>ͳ���˻����</th>
				<th nowrap>��Ա�ֻ�����</th>	
				<th nowrap>��������</th>
				<th nowrap>������������</th>
				<th nowrap>���ſͻ�����</th>
				<th nowrap>ͳ����ʼʱ��</th>
				<th nowrap>ͳ������ʱ��</th>
				<th nowrap>ͳ�����</th>
				<th nowrap>��������</th>
				<th nowrap>����ʱ�� </th>
				<th nowrap>�������� </th>
			</tr>
	  <%	
		for(int i = 0; i < result1.length; i++)
		{
		    String tdClass = "";
            if (i%2==0){
                tdClass = "Grey";
            }
	  %>			
			<tr>				
				<td class='<%=tdClass%>'><%=result1[i][0].trim()%></td>
				<td class='<%=tdClass%>'><%=result1[i][1].trim()%></td>
				<td class='<%=tdClass%>'><%=result1[i][2].trim()%></td>
				<td class='<%=tdClass%>'><%=result1[i][3].trim()%></td>
				<td class='<%=tdClass%>'><%=result1[i][4].trim()%></td>
				<td class='<%=tdClass%>'><%=result1[i][5].trim()%></td>
				<td class='<%=tdClass%>'><%=result1[i][6].trim()%></td>
				<td class='<%=tdClass%>'><%=result1[i][7].trim()%></td>
	<%     if(result1[i][8].trim().equals("1")){        %>
				<td class='<%=tdClass%>'>ȫ��</td>
	<%     }else{                          %>
	            <td class='<%=tdClass%>'><%=result1[i][8].trim()%></td>
	<%        }                          %>
				<td class='<%=tdClass%>'><%=result1[i][9].trim()%></td>
				<td class='<%=tdClass%>'><%=result1[i][10].trim()%></td>
				
    <%     if(result1[i][11].trim().equals("a"))  {      %>
				<td class='<%=tdClass%>'>����</td>
	<%     }else if (result1[i][11].trim().equals("u"))  { %>
	            <td class='<%=tdClass%>'>�޸�</td>
	<%     }else if(result1[i][11].trim().equals("d")) { %>
	            <td class='<%=tdClass%>'>ɾ��</td>
	<%     }else if(result1[i][11].trim().equals("i")) {  %>
	            <td class='<%=tdClass%>'>ͳ����ƷԤ���޸�</td>
	<%     }else {                                      %>
	            <td class='<%=tdClass%>'><%=result1[i][11].trim()%></td>
	<%     }                                            %>
	
	          
			</tr>
	<%
		}
	%>	

	</table>
		<%
			Page pg = new Page(iPageNumber,iPageSize,recordNum);
			PageView view = new PageView(request,out,pg);
					
		%>
			<div style="position:relative;font-size:12px" align="center">
		<%
		    view.setVisible(true,true,0,0);      
		%>
				

		<!--</table>		
		<table cellspacing="0" id=contentList>
	<tr>
	 <td>
<%	
    //int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    //int iQuantity = 500;
    //System.out.println("<"+iPageNumber+">,<"+iPageSize+">,<"+recordNum+">");
    //Page pg = new Page(iPageNumber,iPageSize,recordNum);
	 // PageView view = new PageView(request,out,pg); 
   //	view.setVisible(true,true,0,0);       
%>
     </TD>
    </TR>
 </TABLE>-->
	</div>   
</form>
</body>
</html>
