<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/se179/public_title_name.jsp"%>
<%@ include file="/npage/se179/footer.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>

<HEAD>
<TITLE>套餐优惠详情</TITLE>
</HEAD>
<%
		String mode_code = request.getParameter("mode_code");        //得到输入参数 mode_code
		String region_code = request.getParameter("region_code");      //得到输入参数 region_code 
		String oret_code="";
		String oret_msg="";
		String login_no=request.getParameter("login_no");  
%>
		<s:service name="sMarkOffQry">
			<s:param name="ROOT">
				<s:param name="OfferId" type="string" value="<%=mode_code %>" />
				<s:param name="LoginNo" type="string" value="<%=login_no %>" />
			</s:param>
		</s:service>  
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
							        Map map = new HashMap();
									List feechagel = result.getList("OUT_DATA.BUSI_INFO");
									String[][] data= new String[feechagel.size()][2];  
									for(int i =0;i<feechagel.size();i++){     
									map = MapBean.isMap(feechagel.get(i));  
									if(map==null) {
									data[i][0]="";
									data[i][1]="";
									continue; }                                                                           
									String OfferName= (String)map.get("OfferName")== null?"":(String)map.get("OfferName");   
									String OfferComments= (String)map.get("OfferComments")== null?"":(String)map.get("OfferComments");  
									data[i][0]=OfferName;
									data[i][1]=OfferComments;
									}
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
              <TD id="footer" >
			  				<input class="b_foot" name=close  onClick="parent.window.close()" type=button value=关闭>
              </TD>
            </TR>
          </TBODY>
        </TABLE>
			</HTML>
