<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-19 页面改造,修改样式
*
********************/
%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>套餐优惠详情</TITLE>
</HEAD>
<%
		String opCode = "1270";
		String opName = "套餐优惠详情";
		String mode_code = WtcUtil.repNull(request.getParameter("mode_code"));        //得到输入参数 mode_code
		String region_code = WtcUtil.repNull(request.getParameter("region_code"));      //得到输入参数 region_code 
		String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
		String oret_code="";
		String oret_msg="";
        //String sqlStr ="select a.mode_name,c.type_name,b.detail_code ,b.note from sBillModeCode a ,sBillModeDetail b ,sBillDetName c where a.region_code='"+region_code+"' and a.mode_code ='"+mode_code+"' and b.region_code=a.region_code and b.mode_code=a.mode_code and c.detail_type=b.detail_type";
        String sqlStr = "select a.offer_name,a.OFFER_COMMENTS from product_offer a where a.offer_id = '"+mode_code+"'";
		System.out.println(sqlStr);
%>
		<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="data" scope="end" />
  
    <%@ include file="/npage/include/header_pop.jsp" %>     	
		<div class="title">
			<div id="title_zi">套餐优惠详情</div>
		</div>
      
  		<TABLE id=thetab cellSpacing="0">
			   <tr align="center">
        		        <th>可选套餐名称</th>
						<th>明细名称</th>
			   </tr>
						<%
									String tbclass="";
						      for(int y=0;y<data.length;y++){
						      	if(y%2==0){
						      		tbclass="Grey";
						      	}else{
						      		tbclass="";	
						      	}
						%>
						
						  <tr align="center">
						<%    
						      for(int j=0;j<data[y].length;j++){
						%>
						
										<td class="<%=tbclass%>"><%= data[y][j]%></td>
						<%
									}
						%>
						</tr>
						<%
						    }
						%>
          </TABLE>
          
		   <TABLE cellSpacing="0">
          <TBODY>
            <TR> 
              <TD id="footer">
			  				<input class="b_foot" name=close  onClick="parent.window.close()" type=button value=关闭>
              </TD>
            </TR>
          </TBODY>
        </TABLE>
        <%@ include file="/npage/include/footer_simple.jsp" %>
			</HTML>
