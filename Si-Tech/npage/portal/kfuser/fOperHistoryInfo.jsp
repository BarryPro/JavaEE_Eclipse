<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  /*
�� * �޸���ʷ
   * �޸����� 2009-05-19     �޸���  libina     �޸�Ŀ��  ����ҵ����ͳ�ƣ�����
   * �޸����� 2009-05-32     �޸���  libina     �޸�Ŀ��  ����������TD��ʾ�쳣������
 ��*/
%>
<%
  String phoneNo  = (String)session.getAttribute("activePhone");
  Calendar cr = Calendar.getInstance();
  int yy = Integer.parseInt("" + cr.get(cr.YEAR)) - 2;
  String year = "" + yy;
  String year1 = "" + cr.get(cr.YEAR);
  String crm = cr.get(cr.MONTH) < 10 ? "0" + (cr.get(cr.MONTH)+1) : "" + (cr.get(cr.MONTH)+1);
  String crd = cr.get(cr.DATE) < 10 ? "0" + cr.get(cr.DATE) : "" + cr.get(cr.DATE);
  String begindate = year+crm+crd + " 00:00:00";
  String enddate = year1+crm+crd + " 23:59:59"; 
  
  String SQL1 = "select to_char(sysdate,'yyyymm') from dual";/*��������@���±�@libina@20090519*/
  String login_no = (String)session.getAttribute("workNo");
%>
<wtc:service name="sHW_HisQuery"  routerKey="phone" routerValue="<%=phoneNo%>" outnum="15">
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=begindate%>"/>
	<wtc:param value="<%=enddate%>"/>
</wtc:service>
<HTML>
<HEAD>
<title>��ʷ��Ϣ��ѯ���</title>

<!------------------------------------
   -��ҳ�������������Ҫʹ�õ�js�ű�	
-------------------------------------->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery.tablesorter.js"></script>

<script language="javascript">
    /***********************************
	 *add by zhanghonga@20090314
	 *����û�Ҫ��:����ϡ���ʷ��Ϣ��ѯ������������ʱ�䡱�ɽ�������.�������ձ��ʱ����е�����.
	 *(���´���ɾ��֮��,��ԭҳ�����κ�Ӱ��)
	 ***********************************/
	$(document).ready(function() 
    	{ 
    		/***********************************
    		  *tablesorter()�Ĳ�������Ϊ��,���Ϊ��,ҳ���ʼ����ʱ����ʾĬ�ϵ�����Ч��;
    		  *sortList:[[3,1]]��ʾ�ӱ���յ����н�������.���е�һ������"3"��ʾ�±��0��ʼ�ĵ�����,�ڶ�������:0����,1����
    		  *�����Ҫҳ���ʼ����ʱ��ͬʱ���ռ�������,ʹ��sortList:[[0,0],[1,0]]��������ʽ
    		************************************/
        	$("#myTable").tablesorter({
        		sortList:[[3,1]]	
        	});
        	
        	/***********************************
        	 *�����е�th�ϸ�����ʽ,ʹ���������ȥ��,��ɱ����״,����"��"�ε���״
        	 ***********************************/
        	$("th").css({cursor:"hand"}); 
    	} 
	); 


    /***********************************
	 *add by zhanghonga@20090314
	 *����û�Ҫ��:���Ӱ���ʱ��Σ��£���ѯ���Ե�һ����ѯ��������������ɸѡ
	 *(���´���ɾ��֮��,��ԭҳ�����κ�Ӱ��)
	 ***********************************/	
	function doSubmitQuery(){
		var beginQueryDate = $("#beginQueryDate").val();	
		var endQueryDate = $("#endQueryDate").val();
		var myTable = $("#myTable")[0];
		
		if(!forDate($("#beginQueryDate")[0])){
			return false;
		}
		
		if(!forDate($("#endQueryDate")[0])){
			return false;
		}
		
		if(beginQueryDate>endQueryDate){
			rdShowMessageDialog("��ʼʱ�䲻�ܴ��ڽ���ʱ��",0);
			return false;
		}
		
		$("td[@impDate]").each(
			function(i){
				if(this.impDate.substring(0,6)<beginQueryDate||this.impDate.substring(0,6)>endQueryDate){
					myTable.rows[i+1].style.display = "none";		
				}else{
					myTable.rows[i+1].style.display = "block";
				}
			}
		);
	}
	
	
    /***********************************
	 *add by zhanghonga@20090314
	 *����û�Ҫ��:���Ӱ���ʱ��Σ��£���ѯ���Ե�һ����ѯ��������������ɸѡ
	 *��ʾһ�β�ѯ������������
	 ***********************************/	
	function doShowAllQuery(){
		$("td[@impDate]").each(
			function(i){
				$("#myTable")[0].rows[i+1].style.display = "block";
			}
		);		
	}
</script>
</head>
<body>
<form action="#" method="post" name="form1" >
	<div id="Main">
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
			<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
				<div id="Operation_Title"><B>��ʷ��Ϣ��ѯ���</B></div>
				<DIV id="Operation_Table">
        			<div class="title">��ʷ��Ϣ</div>
						<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="myTable">
							<thead> 
						      <tr> 
						    	 <th>�������</th>
						         <th>�������</th>
						         <th>����</th>
						         <th>���ʱ��</th>
						         <th>������ˮ</th>
						         <th>������</th>
						         <th>�����ע</th>
						         <th>�ֽ𸶿�</th> 
						         <th>������</th>
						         <th>ѡ�ŷ�</th> 
						         <th>������</th>
						         <th>������</th> 
						         <th>��������</th> 
						         <th>SIM����</th> 
						      </tr>
						     </thead> 
							<tbody>
							<wtc:iter id="rows" start="1" length="14" indexId="i" >
							<tr>
							<td align="center" title="<%=rows[0]%>"><%=rows[0]%></td>
							<td align="center" title="<%=rows[1]%>"><%="".equals(rows[1])?"&nbsp;":rows[1]%></td>
							<td align="center" title="<%=rows[2]%>"><%=rows[2]%></td>
							<td align="center" title="<%=rows[3]%>" impDate="<%=rows[3]%>"><%=rows[3]%></td>
							<td align="center" title="<%=rows[4]%>"><%=rows[4]%></td>
							<td align="center" title="<%=rows[5]%>"><%=rows[5]%></td>
							<td align="center" title="<%=rows[6]%>"><%=rows[6]%></td>
							<td align="center" title="<%=rows[7]%>"><%=rows[7]%></td>
							<td align="center" title="<%=rows[8]%>"><%=rows[8]%></td>
							<td align="center" title="<%=rows[9]%>"><%=rows[9]%></td>
							<td align="center" title="<%=rows[10]%>"><%=rows[10]%></td>
							<td align="center" title="<%=rows[11]%>"><%=rows[11]%></td>
							<td align="center" title="<%=rows[12]%>"><%=rows[12]%></td>
							<td align="center" title="<%=rows[13]%>"><%=rows[13]%></td>
							</tr>
							</wtc:iter>
							</tbody> 
							</table>
						</div>
<%
	  System.out.println("�����¼��ʼ@libina@20090519");
	  System.out.println("������ý����"+retCode+"/"+retMsg);
	  int successFlag = 1;
	  if("0".equals(retCode)){
	     successFlag = 0;
	  }
%>
	
	<wtc:pubselect name="sPubSelect" outnum="1">
  	<wtc:sql><%=SQL1%></wtc:sql> 	
  </wtc:pubselect>
	<wtc:array id="result1" scope="end"/> 	
<%
  String SQL2 = "insert into DLOGMANOPR"+result1[0][0]+" values(sysdate,'"+phoneNo+"','"+login_no+"','01001',"+successFlag+",'01001','0','��ʷ��Ϣ��ѯ')";
%>  
    <wtc:service name="sPubModify" outnum="3">
			<wtc:param value="<%=SQL2%>"/>
			<wtc:param value="dbcall"/>
		</wtc:service>
<%
  System.out.println("�����¼����@libina@20090519");
%>    
						<div id="Operation_Table"> 
							<div class="title">����������</div>
							<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
								<tr>
									<td class="blue" width="10%">��ʼ����</td>
									<td width="20%">
										<input type="text" name="beginQueryDate" id="beginQueryDate" maxlength="6" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" v_format="yyyyMM" onKeyDown="if(event.keyCode==13){doSubmitQuery()}">&nbsp;&nbsp;
									</td>
									<td class="blue" width="10%">��������</td>
									<td>
										<input type="text" name="endQueryDate" id="endQueryDate" maxlength="6" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" v_format="yyyyMM" onKeyDown="if(event.keyCode==13){doSubmitQuery()}">&nbsp;&nbsp;
										<input type="button" onclick="doSubmitQuery()" value="��ѯ" class="b_text">&nbsp;
										<input type="button" onclick="doShowAllQuery()" value="��ʾȫ������" class="b_text">
									</td>
								</tr>
							</table> 	
						</div>            
					</DIV>
		  </td>
          <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
        </tr>
        <tr>
          <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
          <td valign="bottom"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
            <tr>
              <td height="1"></td>
            </tr>
          </table></td>
          <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
        </tr>
  </table>
</DIV>

			</FORM>
		</body>
</html>
