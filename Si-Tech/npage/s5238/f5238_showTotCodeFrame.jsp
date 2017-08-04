<% 
  /*
   * 功能: 显示优惠条件信息
　 * 版本: v1.00
　 * 日期: 2007/01/23
　 * 作者: shibo
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   *  
 　*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<%
	//读取用户session信息
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //工号
	String workName = baseInfo[0][3];               	//工号姓名
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     	//登陆密码
	String regionCode=org_code.substring(0,2);
	
	//获取从上页得到的信息
	String login_accept = request.getParameter("login_accept");	
	String region_code = request.getParameter("region_code");	
	String total_code = request.getParameter("total_code");	
	
	int errCode=0;
    String errMsg="";
	
%>
<html>
<head>
<title>无标题文档</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css"  rel="stylesheet" type="text/css">
<script>
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form target="middle" action="" method="post" name="form2">
<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
  	<tr>
    	<td>
      		<table width="731"  border="0" id="mainThree" align="center" bordercolor="#D6D3CE" bgcolor="#ffffff" cellspacing="1">
      		  	
      		  	<%
			
				SPubCallSvrImpl callView = new SPubCallSvrImpl();
				ArrayList retArray = new ArrayList();
				String[] paramsIn=new String[6];
				paramsIn[0]=workNo;
				paramsIn[1]=nopass;
				paramsIn[2]="5238";
				paramsIn[3]=login_accept;
				paramsIn[4]=region_code;
				paramsIn[5]=total_code;
				
				retArray=callView.callFXService("s5238_TotConShw",paramsIn,"10");	
				callView.printRetValue();
				errCode = callView.getErrCode();
				errMsg = callView.getErrMsg();
				if(errCode==0)
				{
					String[][]sOut_region_code=(String[][])retArray.get(0);              //地区代码                    
					String[][]sOut_total_code =(String[][])retArray.get(1);              //优惠代码                    
					String[][]sOut_order_code=(String[][])retArray.get(2);               //优惠顺序                     
					String[][]sOut_condition_order=(String[][])retArray.get(3);          //优惠条件顺序                
					String[][]sOut_favcond_type=(String[][])retArray.get(4);             //优惠条件类型                
					String[][]sOut_favour_condition=(String[][])retArray.get(5);         //优惠条件                    
					String[][]sOut_cond_attr=(String[][])retArray.get(6);                //条件属性                    
					String[][]sOut_relation_expr=(String[][])retArray.get(7);            //关系表达式                  
					String[][]sOut_condition_step=(String[][])retArray.get(8);           //条件阀值                    
					String[][]sOut_local_expr=(String[][])retArray.get(9);               //多服务代码优惠条件(条件关系)
	
					String sOut_favcond_type_name="";
					for(int i=0;i<sOut_favcond_type.length;i++)
					{
						if(sOut_favcond_type[i][0].equals("0"))
						{
							sOut_favcond_type_name="0-本月话费";
						}
						else if(sOut_favcond_type[i][0].equals("9"))
						{
							sOut_favcond_type_name="9-本月优惠";
						}
						else if(sOut_favcond_type[i][0].equals("3"))
						{
							sOut_favcond_type_name="3-用户属性";
						}
						else if(sOut_favcond_type[i][0].equals("2"))
						{
							sOut_favcond_type_name="2-帐务信息";
						}
						else if(sOut_favcond_type[i][0].equals("5"))
						{
							sOut_favcond_type_name="5-月底优惠";
						}
							
				%> 
					<tr bgcolor="F5F5F5" height="20">
                		<td align="center" width="89" height="20" ><%=sOut_favcond_type_name%></td>
                		<td align="center" width="59" height="20" ><%=sOut_order_code[i][0]%></td>
                		<td align="center" width="90" height="20" ><%=sOut_condition_order[i][0]%></td>
                		<td align="center" width="59" height="20" ><%=sOut_local_expr[i][0]%></td>
                		<td align="left" width="199" height="20"><input type="text" value="<%=sOut_favour_condition[i][0]%>" size="30" readonly></td>
                		<td align="left" width="110" height="20"><input type="text" value="<%=sOut_cond_attr[i][0]%>" size="15" readonly></td>
                		<td align="center" width="76" height="20" ><%=sOut_relation_expr[i][0]%></td>
                		<td align="center" width="41" height="20" ><%=sOut_condition_step[i][0]%></td>
			    	</tr>
			    	<%
					}	
				}
				else
				{	
				%>        
					<script language="javascript">
						rdShowMessageDialog("错误代码：<%=errCode%>,错误信息：<%=errMsg%>");
					</script>       
				<%            
				}
			
				%>               	
      		</table>
		</td>
  	</tr>
</table>
</form>	
</body>
</html>  
