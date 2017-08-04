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
		String project_code = request.getParameter("project_code") == null ? "" : request.getParameter("project_code");
    String awardcode = request.getParameter("awardcode") == null ? "" : request.getParameter("awardcode");
    String strRegionCode = request.getParameter("regioncode") == null ? "" : request.getParameter("regioncode");
    String isFlag = request.getParameter("isFlag");
    String ret_page = "";
		String[] inParas = new String[2];
		if("G".equals(isFlag)){ // ²éÑ¯µÈ¼¶
			inParas[0] = "SELECT grade_code,grade_code||' --> '||grade_name FROM ssalegrade where project_code=:project_code order by grade_code";
  		inParas[1] = "project_code=" + project_code;
  		ret_page = "grade_code";
		}else{
			System.out.println("==========="+awardcode);
			inParas[0] = "SELECT to_char(project_code),project_code||' --> '||project_name FROM sSaleProject where type_code like :type_code and region_code=:region_code order by project_code desc";
  		inParas[1] = "type_code=" + awardcode +",region_code=" + strRegionCode;
  		ret_page = "awarddetailname";
		}
%>
			<wtc:service name="TlsPubSelCrm"  outnum="2" retcode="retCode1" retmsg="regMsg1">
			<wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>
			</wtc:service>
			<wtc:array id="tri_metaData" scope="end"/>
<%
    String tri_metaDataStr = createArray("js_tri_metaDataStr", tri_metaData.length);
%>
<%=tri_metaDataStr%>
<%
    for (int p = 0; p < tri_metaData.length; p++) {
        for (int q = 0; q < tri_metaData[p].length; q++) {
%>
					js_tri_metaDataStr[<%=p%>][<%=q%>]="<%=tri_metaData[p][q]%>";
<%
        }
    }
%>
var response = new AJAXPacket();
response.data.add("rpc_page","<%=ret_page%>");
response.data.add("detailcode",js_tri_metaDataStr);
core.ajax.receivePacket(response);
