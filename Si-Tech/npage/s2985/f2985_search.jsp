 <%
   /*
   * 功能: 参数集明细配置
　 * 版本: v1.0
　 * 日期: 2008/05/12
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期:2009/05/14   修改人:leimd   修改目的:适应新需求
 　*/
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%
	String regionCode=(String)session.getAttribute("regCode");
	String opName = "参数集明细配置列表";
  	String  param_set=request.getParameter("param_set");
	int len=0;
	String sqlStr1="";
	sqlStr1 = "select a.param_code,b.param_name from sBizParamDetail a,sBizParamCode b where a.param_code=b.param_code and a.param_set like '%"+param_set+"%'";

%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMessage">
	<wtc:sql><%=sqlStr1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="rows" scope="end"/>
<%		
	
	if(rows.length>0)
	{	
	      System.out.println("rows.length="+rows.length);
      
        len=rows.length;
      }
	else{
%>    
		<script language=javascript>	
			rdShowMessageDialog("查询参数集出错或不存在！!",0);
			//document.location.replace("<%=request.getContextPath()%>/npage/s2985/f2985.jsp");
		</script>
<%
		}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script language=javascript>   
 	
	onload=function() {
		self.status="";
	 	core.ajax.onreceive = doProcess;
	}
	
//处理rpc返回结果
function doProcess(packet) {	
	  self.status="";	

	 var qryType=packet.data.findValueByName("rpcType");
	 var errCode=packet.data.findValueByName("errCode");
	 var errMsg=packet.data.findValueByName("errMsg");
	
 if(qryType == "checkParamSet"){	 
	 if(errCode == "000000")
	    {
		  rdShowMessageDialog("返回信息："+errMsg + "<br>返回代码："+errCode,1);
		  document.form1.AddBtn.disabled=false; 
		  document.form1.allSelectt.disabled=false;
		  document.form1.noSelectt.disabled=false;
		  //document.form1.param_set.readOnly=true;
		 // document.form1.checkP.disabled=true;
	   }else
	   	   {		   	   	
	   	   rdShowMessageDialog("错误信息："+errMsg + "<br>错误代码："+errCode, 0);
	        }
      }	
}	 
</script>
</head>
<body>

       <table cellspacing="0">
				
			<TR> 
					
				      <TD colspan='16' class="blue"><B>参数集查询列表</B></TD> 
				    
				                 	                             	              
        	</TR>
			<TR> 
					
			      	<TD colspan='8' class="blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;参数代码</TD> 
			      	<TD colspan='8' class="blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;参数名称</TD>
				                 	                             	              
        	</TR>
					<%
				  for(int i = 0; i < len; i++)
					{
			        %>
				        <TR>
					         <TD colspan='8' class="blue">	
						           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=rows[i][0].trim()%>
						                 
                  </TD>
					        <TD colspan='8' class="blue">
					              &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<%=rows[i][1].trim()%>   
					                  
					        </TD>	
					 	                
					    </TR>
				        <%
						}
				        %>
				</table>
	  
	 </body>
	</html>
		
