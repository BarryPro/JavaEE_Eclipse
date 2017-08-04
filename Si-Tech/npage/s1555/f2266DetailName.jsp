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
    String awardcode = WtcUtil.repNull(request.getParameter("awardcode"));
    String strRegionCode = WtcUtil.repNull(request.getParameter("regioncode"));
    String id_sno = WtcUtil.repNull(request.getParameter("id_sno"));
    String yuyuestr = WtcUtil.repNull(request.getParameter("yuyuestr"));
    String changeDetailTypeValue = WtcUtil.repNull(request.getParameter("changeDetailTypeValue")); //yuanqs add 2010/10/28 9:42:32 分层需求
    String opFlagValue = WtcUtil.repNull(request.getParameter("opFlagValue")); //yuanqs add 2010/11/11 15:59:37 分层需求
    if("".equals(changeDetailTypeValue)||"0000".equals(changeDetailTypeValue)) {
    		changeDetailTypeValue = "1', '2', '3";
    }
	// liyan 20090716 modify
    // String sqlStr = "select award_detail_code,award_detail_code||' --> '||award_detail_name from sawarddetail  where award_code ='" + awardcode + "' and region_code='" + strRegionCode + "'";
//yuanqs add 2010/10/28 9:17:36 分层需求
		String typeSql = "SELECT active_kind_code, active_kind_name FROM DBGIFTRUN.SCHNRESACTIVEKIND"; //查询奖品分类
		System.out.println("奖品分类" + typeSql + "====yuanqs");
//yuanqs add 2010/10/28 9:17:47 分层需求
		String sqlStr = "";
		if("02".equals(opFlagValue)) {
		  sqlStr =
				"select b.award_detail_code,b.award_detail_code||' --> '||b.award_detail_name" +
				"      from dbgiftrun.schnresactivecode  a,sawarddetail b, DBGIFTRUN.SCHNRESACTIVEKINDCFG c, DBGIFTRUN.SCHNRESACTIVEKIND d " +
				"     where b.award_code ='" + awardcode + "'" +
				"         and b.region_code='" + strRegionCode + "'"+
				"         and a.child_code = b.award_code ||b.award_detail_code" +
				"         and a.valid_flag=1 " + 
				"					and a.active_code = c.active_code " +
				"					and c.active_kind_code = d.active_kind_code " + 
				" 				and d.active_kind_code in ( '" + changeDetailTypeValue + "' ) order by op_time desc ";
			
		} else {
			
			if(yuyuestr.equals("yes")) {
			
			  					sqlStr =" select  tt.award_code,tt.award_name from (select b.op_time,b.award_detail_code as award_code,b.award_detail_code ||' --> '|| b.award_detail_name as award_name from dbgiftrun.schnresactivecode a, sawarddetail b "
					       +" where b.award_code = '" + awardcode + "'  and b.region_code = '" + strRegionCode + "' and a.child_code = b.award_code || b.award_detail_code and a.valid_flag = 1 "
					       +" union all SELECT  s.op_time,s.action_code as award_code, s.action_code ||' --> '|| s.res_act_name as award_name "
					       +" from wmarketawardnew s WHERE s.id_no = '"+id_sno+"' AND s.flag = 'N' ) tt GROUP BY tt.award_code, tt.award_name  ORDER BY MAX(op_time) DESC";

			 }else if(yuyuestr.equals("chaxun")) {
					

			 					 sqlStr =" select  tt.award_code,tt.award_name from (select b.op_time,b.award_detail_code as award_code,b.award_detail_code ||' --> '|| b.award_detail_name as award_name from dbgiftrun.schnresactivecode a, sawarddetail b "
					       +" where b.award_code = '" + awardcode + "'  and b.region_code = '" + strRegionCode + "' and a.child_code = b.award_code || b.award_detail_code and a.valid_flag = 1 "
					       +" union all SELECT  s.op_time,s.action_code as award_code, s.action_code ||' --> '|| s.res_act_name as award_name "
					       +" from wmarketawardnew s WHERE s.id_no = '"+id_sno+"'  ) tt GROUP BY tt.award_code, tt.award_name  ORDER BY MAX(op_time) DESC";

			 		

			}else {
					sqlStr = "select b.award_detail_code,b.award_detail_code||' --> '||b.award_detail_name" +
					"      from dbgiftrun.schnresactivecode  a,sawarddetail b " +
					"     where b.award_code ='" + awardcode + "'" +
					"         and b.region_code='" + strRegionCode + "'"+
					"         and a.child_code = b.award_code ||b.award_detail_code" +
					"         and a.valid_flag=1 " + 
			 		" 			 order by op_time desc ";
				}
		}

    System.out.println("sqlStr=" + sqlStr);
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=strRegionCode%>" outnum="2">
    <wtc:sql><%=typeSql%>
    </wtc:sql>
		</wtc:pubselect>
		<wtc:array id="detailcodeType" scope="end"/>
			
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=strRegionCode%>" outnum="2">
    <wtc:sql><%=sqlStr%>
    </wtc:sql>
		</wtc:pubselect>
		<wtc:array id="tri_metaData" scope="end"/>
<%
		String tri_detailType = createArray("js_detail_type", detailcodeType.length); //yuanqs add 2010/10/28 9:21:14 分层需求
    String tri_metaDataStr = createArray("js_tri_metaDataStr", tri_metaData.length);
%>
<%
		//yuanqs add 2010/10/28 9:22:54 分层需求 begin
%>
<%=tri_detailType%>
<%
    for (int p = 0; p < detailcodeType.length; p++) {
        for (int q = 0; q < detailcodeType[p].length; q++) {
%>
					js_detail_type[<%=p%>][<%=q%>]="<%=detailcodeType[p][q]%>";
<%
        }
    }
%>
<%
		//yuanqs add 2010/10/28 9:23:36 分层需求 end
%>
<%=tri_metaDataStr%>
<%System.out.println("tri_metaData.length====" + tri_metaData.length);
    for (int p = 0; p < tri_metaData.length; p++) {
        for (int q = 0; q < tri_metaData[p].length; q++) {
%>
					js_tri_metaDataStr[<%=p%>][<%=q%>]="<%=tri_metaData[p][q]%>";
<%
        }
    }
%>
var response = new AJAXPacket();
response.data.add("rpc_page","awarddetailname");
response.data.add("detailcode",js_tri_metaDataStr);
response.data.add("detailType",js_detail_type);
core.ajax.receivePacket(response);
