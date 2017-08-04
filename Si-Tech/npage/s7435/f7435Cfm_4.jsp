
<%
/********************
 * version v3.0
 * 开发商: si-tech
 * 功  能：7435 - 集团产品订购控制表配置
 * 描  述：调用服务sApnInfo处理配置表SapnInfo的增、删、改、查
 * author: chendx @ 2009-10-12
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
	
	String regCode = request.getParameter("apnInfoRegCode");
	String smCode = request.getParameter("apnInfoSmCode");
	String apnCode = request.getParameter("apnInfoApnCode");
	String apnId = request.getParameter("apnInfoApnId");
	String termType = request.getParameter("apnInfoTermType");
	String roamType = request.getParameter("apnInfoRoamType");
	String otherCode = request.getParameter("apnInfoOtherCode");
	String validFlag = request.getParameter("apnInfoValidFlag");
	String requestType = request.getParameter("apnInfoRequestType");
	String proSpecNo = request.getParameter("apnInfoProSpecNo");
			
	String[] delArr = request.getParameterValues("apnInfoCheck");
	int delLength = 0;
	if(delArr != null){
	    delLength = delArr.length;
	}
	
	String[] in_regCodeArr = null;
	String[] in_smCodeArr = null;
	String[] in_apnCodeArr = null;
	String[] in_apnIdArr = null;
	String[] in_termTypeArr = null;
	String[] in_roamTypeArr = null;	
	String[] in_otherCodeArr = null;
	String[] in_requestTypeArr = null;
	String[] in_proSpecNoArr = null;
	
	String in_validFlag = "";
	
	String regCodeTmp = "";
	String smCodeTmp = "";
	String apnCodeTmp = "";
	String apnIdTmp = "";
	String termTypeTmp = "";
	String roamTypeTmp = "";
	String otherCodeTmp = "";
	String requestTypeTmp = "";
	String proSpecNoTmp = "";


	
	if("00".equals(opType)){//删除
			in_regCodeArr = new String[delLength];
			in_smCodeArr = new String[delLength];
			in_apnCodeArr = new String[delLength];
			in_apnIdArr = new String[delLength];
			in_termTypeArr = new String[delLength];
			in_roamTypeArr = new String[delLength];
			in_otherCodeArr = new String[delLength];
			in_requestTypeArr = new String[delLength];
			in_proSpecNoArr = new String[delLength];
	    	
	    for(int i=0;i<delLength;i++){
	        regCodeTmp = request.getParameter("apnInfoRegCode"+delArr[i]);
	        System.out.println("###>in_regCodeArr["+i+"]="+regCodeTmp);
	        in_regCodeArr[i] = regCodeTmp;
	        
	        smCodeTmp = request.getParameter("apnInfoSmCode"+delArr[i]);
	        System.out.println("###>in_smCodeArr["+i+"]="+smCodeTmp);
	        in_smCodeArr[i] = smCodeTmp;	
	        
	        apnCodeTmp = request.getParameter("apnInfoApnCode"+delArr[i]);
	        System.out.println("###>in_apnCodeArr["+i+"]="+apnCodeTmp);
	        in_apnCodeArr[i] = apnCodeTmp;
	        
	        apnIdTmp = request.getParameter("apnInfoApnId"+delArr[i]);
	        System.out.println("###>in_apnIdArr["+i+"]="+apnIdTmp);
	        in_apnIdArr[i] = apnIdTmp;
	        
	        termTypeTmp = request.getParameter("apnInfoTermType"+delArr[i]);
	        System.out.println("###>in_termTypeArr["+i+"]="+termTypeTmp);
	        in_termTypeArr[i] = termTypeTmp;
	        
	        roamTypeTmp = request.getParameter("apnInfoRoamType"+delArr[i]);
	        System.out.println("###>in_roamTypeArr["+i+"]="+roamTypeTmp);
	        in_roamTypeArr[i] = roamTypeTmp;
	        
	        otherCodeTmp = request.getParameter("apnInfoOtherCode"+delArr[i]);
	        System.out.println("###>in_otherCodeArr["+i+"]="+otherCodeTmp);
	        in_otherCodeArr[i] = otherCodeTmp;
	        
	        requestTypeTmp = request.getParameter("apnInfoRequestType"+delArr[i]);
	        System.out.println("###>in_requestTypeArr["+i+"]="+requestTypeTmp);
	        in_requestTypeArr[i] = requestTypeTmp;
	        
	        proSpecNoTmp = request.getParameter("apnInfoProSpecNo"+delArr[i]);
	        System.out.println("###>in_proSpecNoArr["+i+"]="+proSpecNoTmp);
	        in_proSpecNoArr[i] = proSpecNoTmp;
      
	    }  
		   	in_validFlag = "";
    }else if("01".equals(opType) || "02".equals(opType)){//修改、新增
			in_regCodeArr = new String[1];
			in_smCodeArr = new String[1]; 
			in_apnCodeArr = new String[1];
			in_apnIdArr = new String[1];
			in_termTypeArr = new String[1];
			in_roamTypeArr = new String[1];	
			in_otherCodeArr = new String[1];
			in_requestTypeArr = new String[1];
			in_proSpecNoArr = new String[1];   	
			    	
			in_regCodeArr[0] = regCode;
			in_smCodeArr[0] = smCode;
			in_apnCodeArr[0] = apnCode;
			in_apnIdArr[0] = apnId;
			in_termTypeArr[0] = termType;
			in_roamTypeArr[0] = roamType;
			in_otherCodeArr[0] = otherCode;
			in_requestTypeArr[0]= requestType;
			in_proSpecNoArr[0] =proSpecNo;
			in_validFlag =validFlag;    		
    }
try{     
%>
    <wtc:service name="sApnInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
			<wtc:param value="<%=opType%>"/> 
			<wtc:param value="<%=validFlag%>"/>   	
			<wtc:params value="<%=in_regCodeArr%>"/>
			<wtc:params value="<%=in_smCodeArr%>"/>
			<wtc:params value="<%=in_apnCodeArr%>"/>
			<wtc:params value="<%=in_apnIdArr%>"/>
			<wtc:params value="<%=in_termTypeArr%>"/>
			<wtc:params value="<%=in_roamTypeArr%>"/>
			<wtc:params value="<%=in_otherCodeArr%>"/>
			<wtc:params value="<%=in_requestTypeArr%>"/> 
			<wtc:params value="<%=in_proSpecNoArr%>"/>   	
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
    System.out.println("调用服务sApnInfo失败!");
    e.printStackTrace();
%>
    <script type="text/javascript">
        rdShowMessageDialog("调用服务失败！");
        history.go(-1);
    </script>
<%
}
%>