<%
/********************
 * version v3.0
 * 开发商: si-tech
 * 功  能：7435 - 集团产品订购控制表配置
 * 描  述：调用服务sSmLimitSrv处理配置表cGrpSmLimit的增、删、改、查
 * author: qidp @ 2009-06-29
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>


<%
	String opCode="7435";
	String opName="集团产品订购控制表配置";
	
	String regionCode = (String)session.getAttribute("regCode");
	
	String tableName = request.getParameter("tableName");//操作的表名
	String opType = request.getParameter("opType");//操作类型：00-删除 01-修改 02-新增
	
	String smCode = request.getParameter("grpSmSmCode");
	String limitType = request.getParameter("grpSmLimitType");
	String limitValue = request.getParameter("grpSmLimitValue");
	String limitFlag = request.getParameter("grpSmLimitFlag");
	
	String[] delArr = request.getParameterValues("grpSmCheck");
	int delLength = 0;
	if(delArr != null){
	    delLength = delArr.length;
	}
	
	String[] in_smCodeArr = null;
	String[] in_limitTypeArr = null;
	String[] in_limitValueArr = null;
	String in_limitFlag = "";
	
	String smCodeTmp = "";
	String limitTypeTmp = "";
	String limitValueTmp = "";
	
	if("00".equals(opType)){//删除
	    in_smCodeArr = new String[delLength];
    	in_limitTypeArr = new String[delLength];
    	in_limitValueArr = new String[delLength];
    	
	    for(int i=0;i<delLength;i++){
	        smCodeTmp = request.getParameter("grpSmSmCode"+delArr[i]);
	        System.out.println("###>in_smCodeArr["+i+"]="+smCodeTmp);
	        in_smCodeArr[i] = smCodeTmp;
	        
	        limitTypeTmp = request.getParameter("grpSmLimitType"+delArr[i]);
	        System.out.println("###>in_limitTypeArr["+i+"]="+limitTypeTmp);
	        in_limitTypeArr[i] = limitTypeTmp;
	        
	        limitValueTmp = request.getParameter("grpSmLimitValue"+delArr[i]);
	        System.out.println("###>in_limitValueArr["+i+"]="+limitValueTmp);
	        in_limitValueArr[i] = limitValueTmp;
	    }
	    in_limitFlag = "";
    }else if("01".equals(opType) || "02".equals(opType)){//修改、新增
        in_smCodeArr = new String[1];
    	in_limitTypeArr = new String[1];
    	in_limitValueArr = new String[1];
    	
    	in_smCodeArr[0] = smCode;
    	in_limitTypeArr[0] = limitType;
    	in_limitValueArr[0] = limitValue;
    	in_limitFlag = limitFlag;
    }

try{
%>
    <wtc:service name="sSmLimitSrv" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
    	<wtc:param value="<%=opType%>"/>
    	<wtc:param value="<%=in_limitFlag%>"/>
    	<wtc:params value="<%=in_smCodeArr%>"/>
        <wtc:params value="<%=in_limitTypeArr%>"/>
        <wtc:params value="<%=in_limitValueArr%>"/>
    </wtc:service>
    <wtc:array id="retArr" scope="end"/>
<%
    if("000000".equals(retCode)){
%>
        <script type="text/javascript">
            rdShowMessageDialog("业务处理成功！",2);
            location.href = "f7435_1.jsp";
        </script>
<%
    }else{
%>
        <script type="text/javascript">
            rdShowMessageDialog("业务处理失败：<%=retCode%><br/>[<%=retMsg%>]",0);
            history.go(-1);
        </script>
<%
    }
}catch(Exception e){
    System.out.println("调用服务sSmLimitSrv失败!");
    e.printStackTrace();
%>
    <script type="text/javascript">
        rdShowMessageDialog("调用服务失败！");
        history.go(-1);
    </script>
<%
}
%>