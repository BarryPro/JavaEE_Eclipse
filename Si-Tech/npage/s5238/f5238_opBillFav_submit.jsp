<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.s5010.viewBean.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.*"%>
<%@ page import="com.sitech.boss.pub.config.*"%>
<%@ page import="java.util.ArrayList"%>
<jsp:useBean id="s5010" class="com.sitech.boss.s5010.viewBean.S5010Impl" />
<script type="text/javascript" src="../../js/common/redialog/redialog.js"></script>
<%

	String error_msg="系统错误，请与系统管理员联系，谢谢!!";
	String error_code="444444";
	String[][] errCodeMsg = null;
	List al = null;
	boolean showFlag=false;	//showFlag表示是否有数据可供显示
  	int valid = 1;	//0:正确，1：系统错误，2：业务错误
  	
  	StringBuffer procSql = new StringBuffer();
  	String iOpType = "a";//操作类型
  	String iRegionCode = request.getParameter("regionCode");//地市代码 
    String typeButtonNum = request.getParameter("typeButtonNum");
	
	String iTotalCode = request.getParameter("totalCode");
	String iTotalName = request.getParameter("totalName");
	String iOrderCode = request.getParameter("orderCode");
	String iChatType1 = request.getParameter("chatType1");
	String iCallType1 = request.getParameter("callType1");
	String iRoamType1 = request.getParameter("roamType1");
	String iTollType1 = request.getParameter("tollType1");
	String iRateCodes1 = request.getParameter("rateCodes1");
	String iCityTypes1 = request.getParameter("cityTypes1");
	String iDataTypes1 = request.getParameter("dataTypes1");
	
	String iFeeType1 = request.getParameter("feeType1");
	String iFavCondType1 = request.getParameter("favCondType1");
	String iFavourType1 = request.getParameter("favourType1");
	String iTypeMode="";
	if( iFavourType1.equals("1") ){//打折
		iTypeMode = "0";
	}else{
		iTypeMode = request.getParameter("typeMode");
	}
	
	String iFavourCycle = request.getParameter("favourCycle");
	String iCycleUnit = request.getParameter("cycleUnit");
	
	String iStepVal1 = request.getParameter("stepVal1");
	String iFavoure1 = request.getParameter("favoure1");
	String iStepVal2 = request.getParameter("stepVal2");
	String iFavoure2 = request.getParameter("favoure2");	
	String iStepVal3 = request.getParameter("stepVal3");
	String iFavoure3 = request.getParameter("favoure3");
	String icOpTypeCond = iOpType;
	
		   
	String iTmpCondOrder = request.getParameter("tmpCondOrder");//
	String iTmpChatType = request.getParameter("tmpChatType");//
    String iTmpCallType = request.getParameter("tmpCallType");//
    String iTmpRoamType = request.getParameter("tmpRoamType");//
    String iTmpTollType = request.getParameter("tmpTollType");//
    String iTmpRateCodes = request.getParameter("tmpRateCodes");//
    String iTmpCityTypes = request.getParameter("tmpCityTypes");//
    String iTmpDataTypes = request.getParameter("tmpDataTypes");//
    String iTmpFeeType = request.getParameter("tmpFeeType");//
    String iTmpFavCondType = request.getParameter("tmpFavCondType");//
    String iTmpFavourType = request.getParameter("tmpFavourType");//
    String iTmpRelationExpr = request.getParameter("tmpRelationExpr");//
    String iTmpConditionStep = request.getParameter("tmpConditionStep");//
    String iTmpLocalExpr = request.getParameter("tmpLocalExpr");//

	String iLoginAccept = request.getParameter("login_accept");
	
	String iIpDialType = "*";// 
	String iIpInfoType = "*";//

	String iLoginNo = request.getParameter("loginNo");
	String iOpCode = request.getParameter("opCode");
	String iIpAddr = request.getParameter("IpAddr");
	String iOpNote = request.getParameter("opNote");
    String iSysNote = iOpNote;
    
	String returnCodeFromProc="444444";
	

 

 //在此处形成存储过程的串,这样可以调用一个函数就可以了。

 procSql.append(" prc_5238_billFavCfm('" + iLoginNo+ "'");
 procSql.append(",'" + iOpCode+ "'");
 procSql.append(",'" + iRegionCode+ "'");
 procSql.append(",'" + iOpType+ "'");
 procSql.append(",'" + iTotalCode+ "'");
 procSql.append(",'" + iTotalName+ "'");
 procSql.append(", " + iOrderCode+ " ");
 
 procSql.append(",'" + iChatType1+ "'");
 procSql.append(",'" + iCallType1+ "'");
 procSql.append(",'" + iRoamType1+ "'");
 procSql.append(",'" + iTollType1+ "'"); 
 procSql.append(",'" + iRateCodes1+ "'");
 procSql.append(",'" + iCityTypes1+ "'");
 procSql.append(",'" + iDataTypes1+ "'");
 procSql.append(",'" + iFavCondType1+ "'"); 
 procSql.append(",'" + iFeeType1+ "'");
 procSql.append(",'" + iFavourType1+ "'");
 procSql.append(",'" + iTypeMode+ "'");
 procSql.append(", " + iFavourCycle+ " ");
 procSql.append(", " + iCycleUnit+ " ");  
 procSql.append(", " + iStepVal1+ " "); 
 procSql.append(", " + iFavoure1+ " "); 
 procSql.append(", " + iStepVal2+ " "); 
 procSql.append(", " + iFavoure2+ " "); 
 procSql.append(", " + iStepVal3+ " "); 
 procSql.append(", " + iFavoure3+ " ");  
 
 procSql.append(",'" + icOpTypeCond+ "'"); 
 procSql.append(",'" + iTmpCondOrder+ "'"); 
 procSql.append(",'" + iTmpChatType+ "'"); 
 procSql.append(",'" + iTmpCallType+ "'"); 
 procSql.append(",'" + iTmpRoamType+ "'"); 
 procSql.append(",'" + iTmpTollType+ "'"); 
 procSql.append(",'" + iTmpRateCodes+ "'");
 procSql.append(",'" + iTmpCityTypes+ "'");
 procSql.append(",'" + iTmpDataTypes+ "'");
 procSql.append(",'" + iTmpFavCondType+ "'"); 
 procSql.append(",'" + iTmpFeeType+ "'");
 procSql.append(",'" + iTmpFavourType+ "'");
 procSql.append(",'" + iIpDialType+ "'");
 procSql.append(",'" + iIpInfoType+ "'");
 procSql.append(",'" + iTmpRelationExpr+ "'");
 procSql.append(",'" + iTmpConditionStep+ "'");
 procSql.append(",'" + iTmpLocalExpr+ "'");

 procSql.append(",'" + iSysNote + "'");
 procSql.append(",'" + iOpNote + "'");
 procSql.append(",'" + iIpAddr + "'");

 procSql.append("," + iLoginAccept + "");
 



 System.out.println("f5238_confirm.jsp:procSql="+procSql.toString());
 
  al = s5010.get_spubproccfm( procSql.toString() );

 if( al == null ){
 		System.out.println("======jsp5238:array is null!!===");
		valid = 1;
	}else{

		errCodeMsg = (String[][])al.get(0);
		error_code = errCodeMsg[0][0];
		//if( !error_code.equals(INIT_DATA.SUCC_CODE) ){
		if( Integer.parseInt(error_code) != 0){
			valid = 2;
			error_msg= SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errCodeMsg[0][0]));
		}else{
			valid = 0;
		}
	}

%>

<%
if(valid != 0)
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("<%=error_code%>" + "[" + "<%=errCodeMsg[0][1]%>" + "]" ,0);
	        history.go(-1);
        </script>
<%	}
	else
	{
%>
		<script language='javascript'>
			window.opener.form1.typeButton<%=typeButtonNum%>.disabled=false;
        	window.opener.form1.typeButton<%=typeButtonNum%>.value="已配置";
			window.close();
        </script>
<%
	}
%>








