<%
   /*
   * ����: ���ѹ�ϵ��ѯ
�� * �汾: v1.0
�� * ����: 2009/02/05
�� * ����: wuxy
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
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
	int recordNum = 0;
	int iQuantity = 0;
	String[][] result1 = new String[][]{};
		

	String favCond = request.getParameter("favCond");
	String favValue = request.getParameter("favValue");
	String begin_time=request.getParameter("begin_time")==null?"":request.getParameter("begin_time");
	String end_time=request.getParameter("end_time")==null?"":request.getParameter("end_time");
	String queryType = request.getParameter("queryType");
	
	System.out.println("favCond= " + favCond);
	System.out.println("favValue= " + favValue);
	System.out.println("begin_time= " + begin_time);
	System.out.println("end_time= " + end_time);
	String in_contract_pay = "";    //�����˻� 0
	String in_unit_id = "";	        //���ű�� 1
	String in_phone_no = "";  	    //��Ա���� 2		
	if(!(favCond.equals(""))&&(favCond.equals("1")))
	{
		 in_unit_id = favValue;
	}
	else if(!(favCond.equals(""))&&(favCond.equals("0")))
	{
		in_contract_pay = favValue;
	}
	else if(!(favCond.equals(""))&&(favCond.equals("2")))
	{
		in_phone_no = favValue;
	}


%>
    <wtc:service name="s3489EXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="16" >
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
    result1 = retArr1;
	recordNum = result1.length;//5��14��
	
	if (retCode1.equals("000000") && result1[0][0]!=null && result1[0][0].trim().length() == 0)
	recordNum = 0;
    
    if (retArr1.length>0 && retCode1.equals("000000")){
	        result1 = retArr1;
	        //for(int iii=0;iii<result1[0].length;iii++){
          //  out.print("["+iii+"]:"+result1[0][iii]+"<br>");
          //} 
	        
	        recordNum = Integer.parseInt(result1[0][15].trim());
	    }
    
    
  if(retArr1==null || retArr1.length == 0)
  {
%>
  	<script language="javascript">
		rdShowMessageDialog("û�в鵽��ؼ�¼��");
	</script>
<%
  }	 
%>	
	
<script language="JavaScript">

 function print_xls()
	 {
	 	window.open('f5095_2_printxls.jsp?orgCode=<%=orgCode%>&loginNo=<%=loginNo%>&favCond=<%=favCond%>&favValue=<%=favValue%>');
	
	}
				
</script>
<html>
<head>
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
		<table  id="tabList" cellspacing="0">
			<tr>
				<td colspan=12 style='border-right:1.0pt solid black'> �����˻���<%=df.format(Float.parseFloat(retArr1.length < 1?"0":retArr1[0][0]))%> Ԫ</td>
				
		    </tr>			
			<tr>	
				<th nowrap align='center'><div ><b>�����˺�</b></div>     </th>	
				<th nowrap align='center'><div ><b>��Ա�ֻ�����</b></div> </th>		
				<th nowrap align='center'><div ><b>��������</b></div>     </th>
				<th nowrap align='center'><div ><b>������������</b></div> </th>
				<th nowrap align='center'><div ><b>���ſͻ�����</b></div> </th>
				<th nowrap align='center'><div ><b>���ѿ�ʼʱ��</b></div> </th>
				<th nowrap align='center'><div ><b>���ѽ���ʱ��</b></div> </th>
				<th nowrap align='center'><div ><b>�˵��޶�</b></div>     </th>
				<th nowrap align='center'><div ><b>ͣ����־</b></div>     </th>
				<th nowrap align='center'><div ><b>��������</b></div>     </th>
				<th nowrap align='center'><div ><b>����ʱ�� </b></div>    </th>
				<th nowrap align='center'><div ><b>�������� </b></div>    </th>
			</tr>
	  <%	
		for(int i = 0; i < retArr1.length; i++)
		{
	  %>			
			<tr>				
				<td nowrap align='center'><%=retArr1[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=retArr1[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=retArr1[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=retArr1[i][4].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=retArr1[i][5].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=retArr1[i][6].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=retArr1[i][7].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=retArr1[i][8].trim()%>&nbsp;</td>              
				<td nowrap align='center'><%=retArr1[i][9].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=retArr1[i][10].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=retArr1[i][11].trim()%>&nbsp;</td>
				
    <%     if(retArr1[i][12].trim().equals("a"))  {      %>
				<td nowrap align='center'>����&nbsp;</td>
	<%     }else if (retArr1[i][12].trim().equals("u"))  { %>
	            <td nowrap align='center'>�޸�&nbsp;</td>
	<%     }else if(retArr1[i][12].trim().equals("d")) { %>
	            <td nowrap align='center'>ɾ��&nbsp;</td>
	<%     }else if(retArr1[i][12].trim().equals("U")) { %>
	             <td nowrap align='center'>ԤԼ���½���&nbsp;</td> 
	<%     }else {                                      %>
	            <td nowrap align='center'><%=retArr1[i][12].trim()%>&nbsp;</td>
	<%     }                                            %>
	
	          
			</tr>
	<%
		}
	%>	
	
		
			
			<!--
			<tr>	
				
				<td colspan="12" id="footer">
					<div id="page0" style="position:relative;font-size:12px;">
					&nbsp;&nbsp;
					<%	
		               //Page pg = new Page(iPageNumber,iPageSize,recordNum);
			           //PageView view = new PageView(request,out,pg); 
		               //view.setVisible(true,true,0,0);     
					%>
					</div>
				</td>
					
				
			</tr>-->
					
					
		</table>
		<%
					Page pg = new Page(iPageNumber,iPageSize,recordNum);
					PageView view = new PageView(request,out,pg);
					
		%>
		<div style="position:relative;font-size:12px" align="center">
<%
    view.setVisible(true,true,0,0);      
%>
		</div>	
		<!--<table cellSpacing="0" id="pageDis" style="display:
		<%
		//if(recordNum<=iPageSize){
		//	out.println(" none ");
		//}
		%>
		">
	    	<tr>
		        <td colspan="12" align=center>
				<div id="page0" style="position:relative;font-size:12px;">
					&nbsp;&nbsp;
					<%	
		              // Page pg = new Page(iPageNumber,iPageSize,recordNum);
			          // PageView view = new PageView(request,out,pg); 
		               //view.setVisible(true,true,0,0);     
					%>
					</div>
				</td>
			</tr>
		</table>	
	</div>   -->
</form>
</body>
</html>