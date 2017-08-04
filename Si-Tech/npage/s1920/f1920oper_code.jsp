<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-04 页面改造,修改样式
     *
     ********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String org_code = (String)session.getAttribute("orgCode");
		String region_code = org_code.substring(0,2);
		
		String verifyType=request.getParameter("verifyType");
		String busytype=request.getParameter("busytype");
		System.out.println("verifyType="+verifyType);
		
		String[][] callData = null;
		String[][] modeData = null;
		String stringArray=null;
		String modeArray=null;
		if(verifyType.equals("opercode")){
			String sqlStr="select oprcode,oprname from oneboss.SOBBIZOPERCODE where bizlist like '%"+busytype+"%' order by oprcode";
			System.out.println("###################f1920oper_code.jsp->sqlStr->"+sqlStr);
%>
				<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>" outnum="2">
		    <wtc:sql><%=sqlStr%>
		    </wtc:sql>
				</wtc:pubselect>
				<wtc:array id="baseArr" scope="end"/>
<%			
			 stringArray = "var arrMsg = new Array(";
			if(baseArr!=null){
				callData=baseArr;
				int flag = 1;
				for (int i=0;i<baseArr.length; i++) {
		      if (flag == 1) {
			        stringArray += "new Array()";
			        flag = 0;
		      }else if (flag == 0) {
		        	stringArray += ",new Array()";
		      }
		    }
			}
	    stringArray += ");";

			String modesqlStr="select paper_code,paper_name from sPaperGiftCfg where award_code= '"+busytype+"' and op_code='1920' and region_code='"+region_code+"' and valid_flag='Y'";
			System.out.println("modesqlStr="+modesqlStr);
%>
				<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>" outnum="2">
		    <wtc:sql><%=sqlStr%>
		    </wtc:sql>
				</wtc:pubselect>
				<wtc:array id="baseArr2" scope="end"/>
<%				
			 modeArray = "var modearrMsg = new Array(";
			if(baseArr2!=null){
				modeData=baseArr2;
				int flagmode = 1;
				for (int i = 0; i < baseArr2.length; i++) {
		      if (flagmode == 1) {
		        modeArray += "new Array()";
		        flagmode = 0;
		      }else if (flagmode == 0) {
		        modeArray += ",new Array()";
		      }
		    }
			}
	    modeArray += ");";
		}
%> 
		<%=stringArray%>
		<%=modeArray%>
<%
for(int i = 0 ; i < callData.length ; i ++){
  for(int j = 0 ; j < callData[i].length ; j ++){
		if(callData[i][j].trim().equals("") || callData[i][j] == null){
		   callData[i][j] = "";
		}
		System.out.println("####################->f1920oper_code->callData["+i+"]["+j+"]=[" + callData[i][j].trim() + "]");
%>
		arrMsg[<%=i%>][<%=j%>] = "<%=callData[i][j].trim()%>";
<%
  }
}
%>  

<%
for(int i = 0 ; i < modeData.length ; i ++){
  for(int j = 0 ; j < modeData[i].length ; j ++){
		if(modeData[i][j].trim().equals("") || modeData[i][j] == null){
		   modeData[i][j] = "";
		}
		System.out.println("modeData["+i+"]["+j+"]=[" + modeData[i][j].trim() + "]");
%>
		modearrMsg[<%=i%>][<%=j%>] = "<%=modeData[i][j].trim()%>";
<%
  }
}
%>  
var response = new AJAXPacket();
response.data.add("verifyType","opercode");
response.data.add("errorCode","0");
response.data.add("errorMsg","success");
response.data.add("backArrMsg",arrMsg );
response.data.add("modeArrMsg",modearrMsg );
core.ajax.receivePacket(response);
