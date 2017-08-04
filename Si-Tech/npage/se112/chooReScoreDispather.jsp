<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%
	String meansId = request.getParameter("meansId");
	String vCurPoint=request.getParameter("vCurPoint");
	String subScore=request.getParameter("subScore");
	String brandId=request.getParameter("brandId");
	String resourcefee=request.getParameter("resourcefee");
	String isRealName=request.getParameter("isRealName");
	String xml = request.getParameter("cashInfo");
	String gScore = request.getParameter("gScore");
	System.out.println("----------------chooReScoreDispather.jsp.vCurPoint=" + vCurPoint);
	System.out.println("----------------chooReScoreDispather.jsp.subScore ="+subScore);
	System.out.println("----------------chooReScoreDispather.jsp.cashInfo ="+xml);
	System.out.println("----------------chooReScoreDispather.jsp.resourcefee ="+resourcefee);
	System.out.println("----------------chooReScoreDispather.jsp.gScore ="+gScore);
	System.out.println("----------------chooReScoreDispather.jsp.isRealName ="+isRealName);
 	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%	
	
	Iterator cashInfoIt =null;
	String payMoney ="";
	List cashInfoList = null;
	
		if(null != mb){
		cashInfoList = mb.getList("OUT_DATA.H01");
		System.out.println("_________cashInfo________" + cashInfoList.toString());
		
		if(null!=cashInfoList){
			cashInfoIt =cashInfoList.iterator();
		}
		
		if(null!=cashInfoIt){
		
			while(cashInfoIt.hasNext()){
				
				Map stMap = mb.isMap(cashInfoIt.next());
				if(null==stMap) continue;
	
				payMoney=(String)stMap.get("PAY_MONEY") == null?"":(String)stMap.get("PAY_MONEY");
				System.out.println("-----------------payMoney ="+payMoney);
			}
		}
	}
 %>
<html>
<head>
	</head>
	<body>
		<form name ="reScore" action="chooReScore.jsp"  method="post">
			<input name ="reScore" id="reScore" type="hidden"/>
			<input name ="meansId" id="meansId" type="hidden" value = "<%=meansId%>"/>
			<input name ="vCurPoint" id="vCurPoint" type="hidden" value = "<%=vCurPoint%>"/>
			<input name ="subScore" id="subScore" type="hidden" value = "<%=subScore%>"/>
			<input name ="brandId" id="brandId" type="hidden" value = "<%=brandId%>"/>
			<input name ="payMoney" id="payMoney" type="hidden" value = "<%=payMoney%>"/>
			<input name ="resourcefee" id="resourcefee" type="hidden" value = "<%=resourcefee%>"/>
			<input name ="gScore" id="gScore" type="hidden" value = "<%=gScore%>"/>
			<input name ="isRealName" id="isRealName" type="hidden" value = "<%=isRealName%>"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].reScore.value= parent.document.getElementById("global_reScore_h").value;
		 		document.forms[0].submit();
		 }
	</script>
</html>