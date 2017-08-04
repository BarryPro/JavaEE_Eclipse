<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-03 页面改造,修改样式
     *
     ********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%!
    public static String createArray(String aimArrayName, int xDimension) {
        String stringArray = "var " + aimArrayName + " = new Array(";
        int flag = 1;
        for (int i = 0; i < xDimension; i++) {
            if (flag == 1) {
                stringArray = stringArray + "new Array()";
                flag = 0;
                continue;
            }
            if (flag == 0) {
                stringArray = stringArray + ",new Array()";
            }
        }

        stringArray = stringArray + ");";
        return stringArray;
    }
%>
<%
	String awardcode = WtcUtil.repNull(request.getParameter("awardcode"));
	String detailcode = WtcUtil.repNull(request.getParameter("detailcode"));
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String  strActiveCode = "";			//促销品活动代码
	
	System.out.println("awardcode="+awardcode);
	System.out.println("detailcode="+detailcode);
	
	//从促销品管理系统取奖品代码
	String sqlStr = "select a.grade_code, a.grade_code||' --> '||a.grade_name "+
					 "from dbgiftrun.sChnActiveGrade a,dbgiftrun.schnresactivecode b "+
					 "where a.active_code=b.ACTIVE_CODE "+
					 "	and b.child_code = '"+awardcode+detailcode+"' and b.valid_flag='1' "+
					 " 	order by a.grade_code";
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
    <wtc:sql><%=sqlStr%>
    </wtc:sql>
		</wtc:pubselect>
		<wtc:array id="tri_metaData" scope="end"/>
<%
	String tri_metaDataStr = createArray("js_tri_metaDataStr",tri_metaData.length);
%>
		<%=tri_metaDataStr%>
<%   
  for(int p=0;p<tri_metaData.length;p++)
  {
	  for(int q=0;q<tri_metaData[p].length;q++)
	  {
%>
        js_tri_metaDataStr[<%=p%>][<%=q%>]="<%=tri_metaData[p][q]%>";
<%
	  }
  }
%>
var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("rpc_page","awardresgradename");
response.data.add("res_grade_name",js_tri_metaDataStr);
core.ajax.receivePacket(response);