<%
   /*
   * ����: BBOSSǩԼ��ϵ��������ѯ
�� * �汾: v1.0
�� * ����: 2008/09/17
�� * ����: sunzg
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   * 2009-09-10     qidp        �����°��Ʒ����
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
		Logger logger = Logger.getLogger("f5095info.jsp");
		 
		String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
		String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
		String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
		String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
		String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
		
		String opCode = "3488";
	    String opName = "BBOSSǩԼ��ϵ��������ѯ";
	
		/**************** ��ҳ���� ********************/
		int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	  int iPageSize = 10;
	  int iStartPos = (iPageNumber-1)*iPageSize;
	  int iEndPos = iPageNumber*iPageSize;
	  String vStartPos = ""+iStartPos;
	  String vEndPos = ""+iEndPos;
	/**********************************************/

		String[][] result1 = new String[][]{};

        String favCond = request.getParameter("favCond");
        String favValue = request.getParameter("favValue");
	  
		System.out.println("favCond= " + favCond);
		System.out.println("favValue= " + favValue);
    
    int recordNum = 0;
	  try
	  {
	  	%>
	  	    <wtc:service name="s3488EXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="15" >
                <wtc:param value="<%=opCode%>"/>
                <wtc:param value="<%=loginNo%>"/>
                <wtc:param value="<%=favCond%>"/> 
                <wtc:param value="<%=favValue%>"/> 
                <wtc:param value="<%=vStartPos%>" />
    	          <wtc:param value="<%=vEndPos%>" />
            </wtc:service>
            <wtc:array id="retArr1" scope="end"/>
        <%
  	   	 
  		    if (retArr1.length>0 && retCode1.equals("000000")){
  		        result1 = retArr1;
  		        
  		        recordNum = Integer.parseInt(result1[0][12].trim());
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
	  System.out.println("result1==null || result1.length == 0:::"+(result1==null || result1.length == 0));
    %>
      	<script language="javascript">
            rdShowMessageDialog("û�в鵽��ؼ�¼��",0);
				</script>
	 <%
	  }	 
	  %>	
	
<script language="JavaScript">
 function print_xls()
	 {
	 	window.open('f5095_2_printxls.jsp?orgCode=<%=orgCode%>&loginNo=<%=loginNo%>&favCond=<%=favCond%>&favValue=<%=favValue%>&totalNum=<%=recordNum%>&opcode=<%=opCode%>');
	
	}
				
</script>
<html>
<head>
<META content="text/html; charset="GBK" http-equiv=Content-Type>
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

<body style="overflow-x:hidden;overflow-y:auto">

<form name="form1" method="post" action="">	
<div id="Operation_Table">
		<table id="tabList" cellspacing=0>			
			<tr>				
				<th nowrap>���ű���</th>
				<th nowrap>��ҵ����</th>
				<th nowrap>ҵ�����</th>
				<th nowrap>ҵ������</th>
				<th nowrap>���ŷ������</th>
				<th nowrap>�ֻ�����</th>
				<th nowrap>��������</th>
				<th nowrap>����״̬</th>
				<th nowrap>������ </th>
				<th nowrap>����ʱ��</th>
				<th nowrap>����ʱ��</th>
			</tr>
	  <%	
		for(int i = 0; i < result1.length; i++)
		{   System.out.println("in FOR :"+i);
		    String tdClass="";
		    if(i%2==0){
		        tdClass="Grey";
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
				<td class='<%=tdClass%>'><%=result1[i][8].trim()%></td>
				<td class='<%=tdClass%>'><%=result1[i][9].trim()%></td>
	     <%
	            if(result1[i][7].trim().equals("�Ѵ���"))
	            {
	     %>
				  <td nowrap class='<%=tdClass%>'><%=result1[i][10].trim()%></td>
       <%
                }
                else
                {
       %>
    			  <td nowrap>&nbsp;</td>
       <%         
                }
       %>
			</tr>
	<%
		}
	%>	
</table>
	<table cellspacing="0" id=contentList>
	<tr>
	 <td>
<%	
    //int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    //int iQuantity = 500;
    System.out.println("<"+iPageNumber+">,<"+iPageSize+">,<"+recordNum+">");
    Page pg = new Page(iPageNumber,iPageSize,recordNum);
	  PageView view = new PageView(request,out,pg); 
   	view.setVisible(true,true,0,0);       
%>
     </TD>
    </TR>
 </TABLE>
		
		<table cellspacing=0>				
			
			<tr id="footer" >	
				<td nowrap colspan='11'>
					 <input class="b_foot_long" name="prtxls"  type=button value="����XLS�ļ�" onclick="print_xls()" style="cursor:hand">
				</td>
				
			</tr>
		</table>		
</div>
</form>
</body>
</html>