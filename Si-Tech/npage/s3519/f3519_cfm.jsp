<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-15
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	String opCode = (String)request.getParameter("opCode");				
	String opName = (String)request.getParameter("opName");
	String grp_id = request.getParameter("grp_id");     				//集团用户编号
	String login_accept = request.getParameter("login_accept"); 		//操作流水
    String sysnote = request.getParameter("sysnote");           		//系统备注
    String tonote  = request.getParameter("tonote");           			//用户操作备注
    String iProduct_Code   = request.getParameter("product_code");     //集团主产品代码
    String iProduct_Append = request.getParameter("product_append");   //集团附加产品代码
    String iProduct_Prices = request.getParameter("product_prices");   //产品价格代码
    String iProduct_Type   = request.getParameter("product_type");     //产品类型
    String iService_Code   = request.getParameter("service_code");     //服务代码
    String iService_Attr   = request.getParameter("service_attr");     //服务属性
    String custId = request	.getParameter("cust_id");			//客户ID
    String gongnengfee   = request.getParameter("gongnengfee");
    
  
    System.out.println("444444444444444444444444444444444444444444"+gongnengfee);
	
	
	
	
	String[][] result = new String[][]{};
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList retArray = new ArrayList();
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String regionCode = org_code.substring(0,2);
	
	String pass = (String)session.getAttribute("password");
	
	int i=0,j=0,k=0;
    i = iProduct_Code.indexOf("|"); //得到主产品代码
    iProduct_Code = iProduct_Code.substring(0, i);

    for (i=0,j=1; i<iProduct_Append.length(); i++) { //统计附加产品数量
        if (iProduct_Append.charAt(i) == ',')
            j++;
    }

    String[] ProdAppend = new String[j+1]; //将附加产品、产品价格、产品属性分解到数组中
    String[] ProdPrice = new String[j+1];
    String[] ProdAttr = new String[j+1];
    ProdAppend[0] = iProduct_Code;
    ProdPrice[0] = "";
    ProdAttr[0] = "";
    for(i=1; i<j+1; i++) {
        k = iProduct_Append.indexOf(',');
        if (k > 0)
            ProdAppend[i] = iProduct_Append.substring(0, k);
        else
            ProdAppend[i] = iProduct_Append;
        ProdPrice[i] = "";
        ProdAttr[i] = "";
        //iProduct_Append = iProduct_Append.substring(k+1);
    }
	
	ArrayList paramsIn = new ArrayList();
	paramsIn.add(new String[]{work_no    });//0
	paramsIn.add(new String[]{pass    });
    paramsIn.add(new String[]{"3519"         });
    paramsIn.add(new String[]{tonote         });
    paramsIn.add(new String[]{login_accept     });
    paramsIn.add(new String[]{sysnote        });
    paramsIn.add(new String[]{ip_Addr    });
    paramsIn.add(new String[]{grp_id         });
    paramsIn.add(new String[]{iProduct_Code         });
    paramsIn.add(new String[]{gongnengfee });//9
    paramsIn.add(ProdAppend         );//10
    paramsIn.add(iProduct_Prices     );//10//11
    paramsIn.add(ProdAttr        );
    paramsIn.add(new String[]{iProduct_Type         });
    paramsIn.add(new String[]{iService_Code     });
    paramsIn.add(new String[]{iService_Attr        });
    
	
	
	//System.out.println("paramsIn[9]="+ProdAppend.length);
	System.out.println("paramsIn[15]="+gongnengfee);
	//System.out.println("paramsIn[10]="+iProduct_Prices.length);
	//System.out.println("paramsIn[11]="+ProdAttr.length);
	System.out.println("paramsIn[12]="+iProduct_Type);
	System.out.println("paramsIn[13]="+iService_Code);
	System.out.println("paramsIn[14]="+iService_Attr);
	
	
	//String[] ret = impl.callService("s3519Cfm",paramsIn,"1", "region", regionCode);
	
	%>
    <wtc:service name="s3519Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s3519CfmCode" retmsg="s3519CfmMsg" outnum="1" >
    	<wtc:param value="<%=work_no%>"/>
        <wtc:param value="<%=pass%>"/> 
        <wtc:param value="3519"/>
        <wtc:param value="<%=tonote%>"/>
        <wtc:param value="<%=login_accept%>"/>
        
        <wtc:param value="<%=sysnote%>"/>
        <wtc:param value="<%=ip_Addr%>"/>
        <wtc:param value="<%=grp_id%>"/>
        <wtc:param value="<%=iProduct_Code%>"/>
        <wtc:param value="<%=gongnengfee%>"/>
        
        <wtc:params value="<%=ProdAppend%>"/>
        <wtc:param value="<%=iProduct_Prices%>"/>
        <wtc:params value="<%=ProdAttr%>"/>
        <wtc:param value="<%=iProduct_Type%>"/>
        <wtc:param value="<%=iService_Code%>"/>
        
        <wtc:param value="<%=iService_Attr%>"/>
    </wtc:service>
    <wtc:array id="s3519CfmArr" scope="end"/>
    <%
    
	String retCode= s3519CfmCode;
	String retMsg = s3519CfmMsg;
	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
	//int errCode = impl.getErrCode();
	
	String errMsg = retMsg;
	//String loginAccept = "";
	if (retCode.equals("000000"))
	{
	

%>
 
<script language="JavaScript">
	rdShowMessageDialog("集团用户产品变更成功！",2);
	window.location="f3519.jsp";
	//history.go(-1);
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("集团用户产品变更失败!(<%=errMsg%>",0);
	history.go(-1);
</script>
<%}

	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&retMsgForCntt="+retMsg
		+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+login_accept+"&pageActivePhone="+grp_id
		+"&opBeginTime="+opBeginTime+"&contactId="+grp_id+"&contactType=grp";
%>
	<jsp:include page="<%=url%>" flush="true" />
