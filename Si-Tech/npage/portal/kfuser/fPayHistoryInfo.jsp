<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  /*
�� * �޸���ʷ
   * �޸����� 2009-05-19     �޸���  libina     �޸�Ŀ��  ����ҵ����ͳ�ƣ�����
   * �޸����� 2009-05-21     �޸���  libina     �޸�Ŀ��  �޸Ľɷ���Ϣ��ѯ����Ľ��շ�ʽ
   * �޸����� 2009-05-23     �޸���  libina     �޸�Ŀ��  �޸�������ѯ����
   * �޸����� 2009-06-14     �޸���  libina     �޸�Ŀ��  ��������ѡ��ť
 ��*/
%>
<%
  String phoneNo  = (String)session.getAttribute("activePhone");
  
  String begindate = request.getParameter("beginQueryDate");
  String enddate   = request.getParameter("endQueryDate");
  
  if(begindate==null || enddate==null){
  //���û�Ҫ��ӵ�ǰ������ǰ��ѯһ�����ڽɷѼ�¼
    Calendar cr = Calendar.getInstance();
    int yy = Integer.parseInt("" + cr.get(cr.YEAR));
    String s_year = cr.get(cr.MONTH) == 0 ? "" + (yy - 1) : "" + yy;
    String e_year = "" + cr.get(cr.YEAR);
    String e_month = cr.get(cr.MONTH) < 9 ? "0" + (cr.get(cr.MONTH)+1) : "" + (cr.get(cr.MONTH)+1);
    String s_month = "";
    if(cr.get(cr.MONTH) == 0){
      s_month = "12";
    }else if(cr.get(cr.MONTH) < 10){
      s_month = "0" + (cr.get(cr.MONTH));
    }else{
      s_month = "" + (cr.get(cr.MONTH));
    }
    String e_day = cr.get(cr.DATE) < 10 ? "0" + cr.get(cr.DATE) : "" + cr.get(cr.DATE);
    String s_day = "";
    if(cr.get(cr.DATE) == 31 || cr.get(cr.DATE) == 30 || cr.get(cr.DATE) == 29 ){
      if(cr.get(cr.MONTH) == 2){
        s_day = "28"; 
      }else if(cr.get(cr.DATE) != 29){
        s_day = "30";
      }
    }else{
      s_day = e_day;
    }
    begindate = s_year + s_month + s_day;
    enddate   = e_year + e_month + e_day;
  } 
  System.out.println(begindate);
  System.out.println(enddate);
  
  String SQL1 = "select to_char(sysdate,'yyyymm') from dual";/*��������@���±�@libina@20090519*/
  String login_no = (String)session.getAttribute("workNo");
%>
<wtc:service name="sHW_HandFee"  routerKey="phone" routerValue="<%=phoneNo%>" outnum="6">
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=begindate%>"/>
	<wtc:param value="<%=enddate%>"/>
</wtc:service>
  <wtc:array id="result0" start="0" length="1" scope="end"/>
	<wtc:array id="result1" start="1" length="1" scope="end"/>
	<wtc:array id="result2" start="2" length="1" scope="end"/>
	<wtc:array id="result3" start="3" length="1" scope="end"/>
	<wtc:array id="result4" start="4" length="1" scope="end"/>
	<wtc:array id="result5" start="5" length="1" scope="end"/>

<HTML>
<HEAD>
<title>�ɷ���Ϣ��ѯ</title>
<!------------------------------------
   -��ҳ�������������Ҫʹ�õ�js�ű�	
-------------------------------------->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery.tablesorter.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<%!
 public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date()) + " " + str;
	}	
%>
<script language="javascript">
    /***********************************
	 *add by zhanghonga@20090315
	 *����û�Ҫ��:�����ʱ�䡱�ɽ�������.���ձ��ʱ����е�����.
	 *(���´���ɾ��֮��,��ԭҳ�����κ�Ӱ��)
	 ***********************************/
	$(document).ready(function() 
    	{ 
    		/***********************************
    		  *tablesorter()�Ĳ�������Ϊ��,���Ϊ��,ҳ���ʼ����ʱ����ʾĬ�ϵ�����Ч��;
    		  *sortList:[[0,1]]��ʾ�ӱ���յ�һ�н�������.���е�һ������"0"��ʾ�±��0��ʼ�ĵ�һ��,�ڶ�������:0����,1����
    		  *�����Ҫҳ���ʼ����ʱ��ͬʱ���ռ�������,ʹ��sortList:[[0,0],[1,0]]��������ʽ
    		************************************/
        	$("#myTable").tablesorter({
        		sortList:[[0,1]]	
        	});
        	
        	/***********************************
        	 *�����е�th�ϸ�����ʽ,ʹ���������ȥ��,��ɱ����״,����"��"�ε���״
        	 ***********************************/
        	$("th").css({cursor:"hand"}); 
    	} 
	); 

	function doSubmitQuery(){
		if( document.sitechform.beginQueryDate.value == ""){
    	   showTip(document.sitechform.beginQueryDate,"��ʼʱ�䲻��Ϊ��");
    	   sitechform.beginQueryDate.focus();
    }else if(document.sitechform.endQueryDate.value == ""){
		     showTip(document.sitechform.endQueryDate,"����ʱ�䲻��Ϊ��");
    	   sitechform.endQueryDate.focus();
    }else if(document.sitechform.endQueryDate.value<=document.sitechform.beginQueryDate.value){
		     showTip(document.sitechform.endQueryDate,"����ʱ�������ڿ�ʼʱ��");
    	   sitechform.endQueryDate.focus();
    }else
    {
         document.sitechform.action="fPayHistoryInfo.jsp";
	       document.sitechform.submit();
    }
	}
	 
</script>
</head>
<body>
<form action="#" method="post" name="sitechform" >
	<div id="Main">
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
			<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
				<div id="Operation_Title"><B>�ɷ���Ϣ��ѯ</B></div>
				<DIV id="Operation_Table">
			        <div class="title">�ɷѲ�ѯ</div>
						<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="myTable">
							<thead>
						      <tr align="center"> 
						    	 <th>�ɷ�ʱ��</th>
						         <th>�ɷѵص�</th>
						         <th>�ɷѷ�ʽ</th>
						         <th>�ɷѽ��</th>
						         <th>��������</th>
						      </tr>
						    </thead>
<%
        System.out.println(phoneNo+"�ɷ���Ϣ��ѯ�����"+retCode);
        System.out.println(phoneNo+"�ɷ���Ϣ��ѯ���������"+result0[0][0]);
        if(Integer.parseInt(result0[0][0]) == 0){
        %>
        <tr>
        <td colspan="5" align="center" >
            û�з��������ļ�¼��
        </td>
        </tr>
        <%}
		  	for (int i=0;i<Integer.parseInt(result0[0][0]);i++){
			 %>
			 <tr align="center"> 
			 <% 
			    if(i%2==0){
			%>
						<td class="Grey"><%=result1[i][0]%></td>
						<td class="Grey"><%=result2[i][0]%></td>            
            <td class="Grey"><%=result3[i][0]%></td>
            <td class="Grey"><%=result4[i][0]%></td>
            <td class="Grey"><%=result5[i][0]%></td>        			    
			<%    
			  }else{
			%>
						<td><%=result1[i][0]%></td>
						<td><%=result2[i][0]%></td>             
            <td><%=result3[i][0]%></td>
            <td><%=result4[i][0]%></td>
            <td><%=result5[i][0]%></td>		
			<%  	
			  	}	  
		  %>
      </tr>
<%}
	  System.out.println("�����¼��ʼ��");
	  System.out.println("������ý����"+retCode+"/"+retMsg);
	  int successFlag = 1;
	  if("000000".equals(retCode)){
	     successFlag = 0;
	  }
%>
	
	<wtc:pubselect name="sPubSelect" outnum="1">
  	<wtc:sql><%=SQL1%></wtc:sql> 	
  </wtc:pubselect>
	<wtc:array id="result1" scope="end"/> 	
<%
  String SQL2 = "insert into DLOGMANOPR"+result1[0][0]+" values(sysdate,'"+phoneNo+"','"+login_no+"','01004',"+successFlag+",'01004','0','�ɷ���Ϣ��ѯ')";
%>  
    <wtc:service name="sPubModify" outnum="3">
			<wtc:param value="<%=SQL2%>"/>
			<wtc:param value="dbcall"/>
		</wtc:service>
<%
  System.out.println("�����¼����!");
%> 
						</table>
   						
					</div>
					<div id="Operation_Table"> 
						<div class="title">�������ѯʱ��</div>
						<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">	
						  <tr>					
							  <td align="right" width="15%"> ��ʼʱ�� </td>
                <td align="left" width="30%">
			            <input id="beginQueryDate" name ="beginQueryDate" type="text"  value="<%=getCurrDateStr("00:00:00")%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.beginQueryDate);return false;">
		              <img onclick="WdatePicker({el:$dp.$('beginQueryDate'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		              <font color="orange">*</font>
		            </td>
							  <td align="right" width="15%"> ����ʱ�� </td>
                <td align="left" width="30%">
			            <input id="endQueryDate" name ="endQueryDate" type="text"   value="<%=getCurrDateStr("23:59:59")%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endQueryDate);">
		              <img onclick="WdatePicker({el:$dp.$('endQueryDate'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		              <font color="orange">*</font>
		            </td> 	
		            <td align="center" width="10%"><input type="button" onclick="doSubmitQuery()" value="��ѯ" class="b_text"></td>            
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
