<%
  /* �޸���ʷ
   * �޸����� 2009-05-19     �޸���  libina     �޸�Ŀ��  ����ҵ����ͳ�ƣ�����
   * �޸����� 2009-06-14     �޸���  libina     �޸�Ŀ��  ����������ѡ��ť
 ��*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode=org_code.substring(0,2);
  String phone_no = (String)session.getAttribute("activePhone");
  String time_begin = request.getParameter("time_begin").trim();
	String time_end = request.getParameter("time_end").trim();
	
	time_begin = time_begin.substring(0, 8);
	time_end   = time_end.substring(0, 8);
  
  int year  = Integer.parseInt(time_end.substring(0, 4));
  int month = Integer.parseInt(time_end.substring(4, 6));
  int day   = Integer.parseInt(time_end.substring(6, 8));
  
  if(day == 28){
  	if(month == 2){
  	  day   = 1;
  	  month = 3;	  
  	}else{
  	  day = 29;	
  	}
  }else if(day == 30){
    if(month == 4 || month == 6 || month == 9 || month == 11){
    	day = 1;
    	month = month + 1;
    }else{
    	day = 31;
    }
  }else if(day == 31){
  	 day = 1;
  	 if(month == 12){
  	    year  = year+1;
  	    month = 1 ;	
  	 }else{
  	 	  month = month + 1;	
  	 }
  }else{
    day = day + 1;	
  }
  
  time_end = year+"";
  
  if(month <10 ){
  	time_end = time_end + "0"+ month;
  }else{
  	time_end = time_end + month;
  }
  
  if(day <10 ){
  	time_end = time_end + "0"+ day;
  }else{
  	time_end = time_end + day;
  }
  
  System.out.println("time_end+++++++++++"+time_end);
  
  String SQL1 = "select to_char(sysdate,'yyyymm') from dual";/*��������@���±�@libina@20090519*/
  
	String workNo = (String)session.getAttribute("workNo");
%>
<wtc:service name="sHW_1927Cfm"  routerKey="region"  routerValue="<%=regionCode%>"  outnum="35">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=phone_no%>"/>
	<wtc:param value="<%=time_begin%>"/>
	<wtc:param value="<%=time_end%>"/>
</wtc:service>
<wtc:array id="result" start="6" length="29"  scope="end"/>
<%
	System.out.println("###phone_no->"+phone_no);
%>
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<HTML>
<HEAD>
<title>��ʷ������ϵ��ѯ</title>
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
    		 try{
        	$("#myTable").tablesorter({
        		sortList:[[12,1]]	
        	});
        	
        	/***********************************
        	 *�����е�th�ϸ�����ʽ,ʹ���������ȥ��,��ɱ����״,����"��"�ε���״
        	 ***********************************/
        	$("th").css({cursor:"hand"}); 
        	 }catch(e){
  
  }
    	}
    );  
 
	</script>
</head>
<body>
<form action="#" method="post" name="form1" >
	<div id="Main">
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
			<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
				<div id="Operation_Title"><B>��ʷ������ϵ��ѯ</B></div>
				<DIV id="Operation_Table">
        <div class="title">��ʷ��Ϣ</div>
	
	
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="myTable">
		<thead>
      <tr> 
    	   <th>��������</th>
         <th>������������</th>
         <th>����</th>
         <th>PortalCode����</th>
         <th>ҵ������</th>
         <th>ҵ����������</th>
         <th>��ҵ����</th>
         <th>��ҵ����</th>
         <th>ҵ�����</th> 
         <th>ҵ������</th>
         <th>��������</th> 
         <th>����ʱ��</th>
         <th>����ʱ��</th> 
         <th>��Чʱ��</th> 
         <th>������ʽ</th> 
         <th>�����ź���</th>
         <th>�շѷ�ʽ</th>
         <th>�����</th>
      </tr>
    </thead>
  <tbody>
<%
	for(int i=0;i<result.length;i++){
	
	/********************************
	  *�򵥵ذ�ʱ���ʽת����
	*********************************/
	try{
		if(result[i][11]!=null&&!result[i][11].equals("")){
			String tempStr = result[i][11];
			if(tempStr.length()>13){
				result[i][11] = tempStr.substring(0,8)+" "+tempStr.substring(8,10)+":"+tempStr.substring(10,12)+":"+tempStr.substring(12,14);
			}			
		}
		
		if(result[i][12]!=null&&!result[i][12].equals("")){
			String tempStr = result[i][12];
			if(tempStr.length()>13){
				result[i][12] = tempStr.substring(0,8)+" "+tempStr.substring(8,10)+":"+tempStr.substring(10,12)+":"+tempStr.substring(12,14);
			}
		}
		
		if(result[i][13]!=null&&!result[i][13].equals("")){
			String tempStr = result[i][13];
			if(tempStr.length()>13){
				result[i][13] = tempStr.substring(0,8)+" "+tempStr.substring(8,10)+":"+tempStr.substring(10,12)+":"+tempStr.substring(12,14);
			}
		}
	}catch(Exception ex){
		
	}		
	
%>
  
      <tr> 
    	   <td><%=((result[i][0]==null||result[i][0].equals(""))?"&nbsp;":result[i][0])%></td>
         <td><%=((result[i][1]==null||result[i][1].equals(""))?"&nbsp;":result[i][1])%></td>
         <td><%=((result[i][2]==null||result[i][2].equals(""))?"&nbsp;":result[i][2])%></td>
         <td><%=((result[i][3]==null||result[i][3].equals(""))?"&nbsp;":result[i][3])%></td>
         <td><%=((result[i][4]==null||result[i][4].equals(""))?"&nbsp;":result[i][4])%></td>
         <td><%=((result[i][5]==null||result[i][5].equals(""))?"&nbsp;":result[i][5])%></td>
         <td><%=((result[i][6]==null||result[i][6].equals(""))?"&nbsp;":result[i][6])%></td>
         <td><%=((result[i][7]==null||result[i][7].equals(""))?"&nbsp;":result[i][7])%></td>
         <td><%=((result[i][8]==null||result[i][8].equals(""))?"&nbsp;":result[i][8])%></td> 
         <td><%=((result[i][9]==null||result[i][9].equals(""))?"&nbsp;":result[i][9])%></td>
         <td><%=((result[i][22]==null||result[i][22].equals(""))?"&nbsp;":result[i][22])%></td> 
         <td><%=((result[i][11]==null||result[i][11].equals(""))?"&nbsp;":result[i][11])%></td>
         <td><%=((result[i][12]==null||result[i][12].equals(""))?"&nbsp;":result[i][12])%></td> 
         <td><%=((result[i][13]==null||result[i][13].equals(""))?"&nbsp;":result[i][13])%></td> 
         <td><%=((result[i][28]==null||result[i][28].equals(""))?"&nbsp;":result[i][28])%></td> 
         <td><%=((result[i][15]==null||result[i][15].equals(""))?"&nbsp;":result[i][15])%></td>
         <td><%=((result[i][18]==null||result[i][18].equals(""))?"&nbsp;":result[i][18])%></td>
         <td><%=((result[i][27]==null||result[i][27].equals(""))?"&nbsp;":result[i][27])%></td>
      </tr>		
<%	
	}
	  System.out.println("��ʼ��¼����");
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
  String SQL2 = "insert into DLOGMANOPR"+result1[0][0]+" values(sysdate,'"+phone_no+"','"+workNo+"','03002',"+successFlag+",'03002','0','SPҵ����ʷ��ѯ')";
%>  
    <wtc:service name="sPubModify" outnum="3">
			<wtc:param value="<%=SQL2%>"/>
			<wtc:param value="dbcall"/>
		</wtc:service>
<%
  System.out.println("��¼�������");
%>    

  </tbody>
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
