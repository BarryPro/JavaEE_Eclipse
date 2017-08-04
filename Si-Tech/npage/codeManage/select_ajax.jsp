<%request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %> 

<%
	String reg_code = request.getParameter("reg_code")	;
	String iregion_code = request.getParameter("iregion_code")	;
	String regionCode = (String)session.getAttribute("regCode");
	String sqlStr = "";
	if (iregion_code.equals("ZZ"))
				{
					 sqlStr = "select bullet_code,bullet_code from dsysbullet group by bullet_code having count(region_code) =(select count(region_code) from sregioncode)";
				}
			else
				{
					if (reg_code.equals("01")||
						reg_code.equals("02")||
						reg_code.equals("03")||
						reg_code.equals("04")||
						reg_code.equals("05")||
						reg_code.equals("06")||
						reg_code.equals("07")||
						reg_code.equals("08")||
						reg_code.equals("09")
						)
					{
							 sqlStr = "select distinct region_code,bullet_code from dsysbullet where region_code =  "+"'"+iregion_code+"' and bull_region ='"+reg_code +"'   order by bullet_code desc";
					}
					else
					{
							 sqlStr = "select distinct region_code,bullet_code from dsysbullet where region_code =  "+"'"+iregion_code+"'  order by bullet_code desc";
					}
					
				}
				
%>

<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=sqlStr%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="tri_metaData" scope="end"/>
var js_tri_metaDataStr = new Array();		
<%   
  for(int p=0;p<tri_metaData.length;p++)
  {
  %>
  js_tri_metaDataStr[<%=p%>] = new Array();
  <%
	  for(int q=0;q<tri_metaData[p].length;q++)
	  {
%>
	
        js_tri_metaDataStr[<%=p%>][<%=q%>]="<%=tri_metaData[p][q]%>";
<%
	  }
  }
%>
var response = new AJAXPacket();
response.data.add("rpc_page","chg_city");
response.data.add("tri_list",js_tri_metaDataStr);
core.ajax.receivePacket(response);



