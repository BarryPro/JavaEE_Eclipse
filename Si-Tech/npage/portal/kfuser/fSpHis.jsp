<%
  /* 修改历史
   * 修改日期 2009-05-19     修改人  libina     修改目的  增加业务点击统计（报表）
   * 修改日期 2009-06-14     修改人  libina     修改目的  配合添加日期选择按钮
 　*/
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
  
  String SQL1 = "select to_char(sysdate,'yyyymm') from dual";/*报表数据@年月表@libina@20090519*/
  
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
<title>历史订购关系查询</title>
<!------------------------------------
   -对页面表格进行排序需要使用的js脚本	
-------------------------------------->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery.tablesorter.js"></script>

<script language="javascript">
    /***********************************
	 *add by zhanghonga@20090314
	 *解决用户要求:面板上“历史信息查询”，点击“变更时间”可进行排序.最差方法按照变更时间进行倒排序.
	 *(以下代码删除之后,对原页面无任何影响)
	 ***********************************/
	
	$(document).ready(function() 
    	{ 
    		/***********************************
    		  *tablesorter()的参数可以为空,如果为空,页面初始化的时候显示默认的排序效果;
    		  *sortList:[[3,1]]表示从表格按照第四列降序排列.其中第一个参数"3"表示下标从0开始的第四列,第二个参数:0升序,1降序
    		  *如果需要页面初始化的时候同时按照几列排列,使用sortList:[[0,0],[1,0]]这样的形式
    		************************************/
    		 try{
        	$("#myTable").tablesorter({
        		sortList:[[12,1]]	
        	});
        	
        	/***********************************
        	 *在所有的th上附加样式,使得鼠标移上去后,变成别的形状,例如"手"形的形状
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
				<div id="Operation_Title"><B>历史订购关系查询</B></div>
				<DIV id="Operation_Table">
        <div class="title">历史信息</div>
	
	
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="myTable">
		<thead>
      <tr> 
    	   <th>号码类型</th>
         <th>号码类型名称</th>
         <th>号码</th>
         <th>PortalCode代码</th>
         <th>业务类型</th>
         <th>业务类型名称</th>
         <th>企业代码</th>
         <th>企业名称</th>
         <th>业务代码</th> 
         <th>业务名称</th>
         <th>操作类型</th> 
         <th>订购时间</th>
         <th>操作时间</th> 
         <th>有效时间</th> 
         <th>订购方式</th> 
         <th>第三放号码</th>
         <th>收费方式</th>
         <th>服务费</th>
      </tr>
    </thead>
  <tbody>
<%
	for(int i=0;i<result.length;i++){
	
	/********************************
	  *简单地把时间格式转化下
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
	  System.out.println("开始记录报表");
	  System.out.println("服务调用结果："+retCode+"/"+retMsg);
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
  String SQL2 = "insert into DLOGMANOPR"+result1[0][0]+" values(sysdate,'"+phone_no+"','"+workNo+"','03002',"+successFlag+",'03002','0','SP业务历史查询')";
%>  
    <wtc:service name="sPubModify" outnum="3">
			<wtc:param value="<%=SQL2%>"/>
			<wtc:param value="dbcall"/>
		</wtc:service>
<%
  System.out.println("记录报表结束");
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
