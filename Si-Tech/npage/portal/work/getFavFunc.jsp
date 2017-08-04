<%
   /*
   * 功能: 查询营业员常用功能
　 * 版本: v1.0
　 * 日期: 2008年4月18日
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
     String workNo = (String)session.getAttribute("workNo");
     String org_code = (String)session.getAttribute("orgCode");
		 String regionCode=org_code.substring(0,2);
		 String cssPath = WtcUtil.repNull((String)session.getAttribute("themePath"));
%>

<wtc:service name="sIndexFuncSel" outnum="7" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<div class="itemContent">
	<div id="content">
  	<table cellpadding="0" cellspacing="0" class="list">
       <%if(retCode.equals("000000")){
		      if(result.length>0){
		          int rows=0;
		            rows=result.length/3;	 
		            if(result.length%3!=0)  rows+=1;           
		                     for(int j=0;j<rows;j++){
		                     	out.print("<tr class=\'jiange\'>");
		                        for(int k=0;k<3;k++)
		                        	{  
		                        		if((k+j*3)>=result.length)  
		                        		{
		                        			out.print("<td>&nbsp;&nbsp;&nbsp;</td>");
		                        		}  
		                        		else
		                        		{     
		                           %>   
		                            
                                  <td>
                                    <div id="commonFunction<%=k%><%=j%>"  onMouseOver="showFunctionButn(this)" onmouseout="hiddenFunctionButn(this)" >
                                      <%=result[k+3*j][1]%>
                                      
                                      <img class='hideEl' src='/nresources/<%=cssPath%>/images/cha.gif'   style='cursor:hand'  width='15' height='15' style="display:none" v_commonFunctionValue= "<%=result[k+3*j][0]%>"  v_commonFunctionSelCls="<%=result[k+3*j][6]%>" onclick="deleteCommonFunction(this)">
                                    </div>
                                  </td>
                                </div>
                               <%
                                   }
                                  }//end of for
                                  out.print("</tr>");
                              }//end of for
                           }                     
                }
              %>      	
    </table>
  </div>
</div>
