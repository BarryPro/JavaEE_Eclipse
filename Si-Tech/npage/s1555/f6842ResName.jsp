<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-03 页面改造,修改样式
     *
     ********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
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
  String strLoginNo = (String)session.getAttribute("workNo");
  String  strGradeCode = WtcUtil.repNull(request.getParameter("gradecode"));
	String  awardcode = WtcUtil.repNull(request.getParameter("awardcode"));
	String  detailcode = WtcUtil.repNull(request.getParameter("detailcode"));

	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String  strActiveCode = "";			//促销品活动代码

	System.out.println("awardcode="+awardcode);
	System.out.println("detailcode="+detailcode);
	System.out.println("strGradeCode="+strGradeCode);

	//从促销品管理系统取活动代码
	String sqlStr = "select active_code from dbgiftrun.schnresactivecode where child_code='"+awardcode+detailcode+"' and valid_flag='1'";
	System.out.println("sqlStr="+sqlStr);
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
    <wtc:sql><%=sqlStr%>
    </wtc:sql>
		</wtc:pubselect>
		<wtc:array id="res_metaData" scope="end"/>
<%
  if (res_metaData.length >0)
  {
  	strActiveCode = res_metaData[0][0];
	}else{
		strActiveCode = "999999999";
	}

	//从促销品管理系统取奖品代码
	sqlStr = "select b.res_code,b.res_code||' --> '||b.res_name "+
					 "from dbgiftrun.sChnActiveGrade a,dbgiftrun.rs_code_info b,dbgiftrun.rs_chngroup_rel c,dbgiftrun.sChnActiveGradecfg d "+
 					 "where a.GRADE_CODE = d.GRADE_CODE "+
 					 		"and d.RES_CODE = b.RES_CODE "+
							"and d.group_id=c.parent_group_id "+
							"and c.group_id=(select group_id from dloginmsg where login_no='"+strLoginNo+"') "+
							"and a.active_code='"+strActiveCode+ "' "+
							"and a.grade_code='"+strGradeCode+"' "+
							"and d.PACKAGE_FLAG = 'N' "+
					 "union all "+
					 "select 'P'||d.PACKAGE_CODE,'P'||d.PACKAGE_CODE||' --> '||d.PACKAGE_NAME "+
					 "from dbgiftrun.sChnActiveGrade a,dbgiftrun.rs_chngroup_rel b,dbgiftrun.sChnActiveGradecfg c,dbgiftrun.RS_PROGIFT_PACKAGE_INFO d "+
					 "where a.GRADE_CODE = c.GRADE_CODE "+
 							"and c.RES_CODE= d.PACKAGE_CODE "+
							"and c.group_id=b.parent_group_id "+
							"and b.group_id=(select group_id from dloginmsg where login_no='"+strLoginNo+"') "+
							"and a.active_code="+strActiveCode+ " "+
							"and a.grade_code='"+strGradeCode+"' "+
							"and c.PACKAGE_FLAG = 'Y' "+
							"and d.valid_flag=1 " +
					 "order by res_code";
					 // liyan 20090716 add  and d.valid_flag=1
		System.out.println("##################################f2266ResName->sqlStr->"+sqlStr);
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
		response.data.add("rpc_page","awardresname");
		response.data.add("res_name",js_tri_metaDataStr);
		core.ajax.receivePacket(response);
