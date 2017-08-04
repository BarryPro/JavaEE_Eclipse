<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-06
 ********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>

<!--包含所需java 文件 及class-->
<%@ page import="com.sitech.moudle.UserInfo"%>
<%@ page import="com.sitech.boss.pub.config.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.StringTokenizer"%>

<body>
	<%

			String service_name = "";
			String sLoginNo = "";
			String loginName = "";

			ArrayList retArray = new ArrayList();
			//ArrayList arr = (ArrayList) session.getAttribute("allArr");
			//String[][] baseInfo = (String[][]) arr.get(0);
			sLoginNo = (String)session.getAttribute("workNo");
			loginName = (String)session.getAttribute("workName");
			String org_code = (String)session.getAttribute("orgCode");
			String regionCode = org_code.substring(0, 2);
			String districtCode = org_code.substring(2, 4);
			//String[][] userPass = (String[][]) arr.get(4);
			String password = (String)session.getAttribute("password");
			String selfIp = request.getRemoteAddr();
			String[][] power = (String[][])session.getAttribute("favInfo");//power
			String[] tempPower = new String[power.length];
			for (int i = 0; i < power.length; i++) {
				tempPower[i] = power[i][0];
			}
			UserInfo userInfo = new UserInfo();
			userInfo.setIp_address(selfIp);
			userInfo.setLoginName(loginName);
			userInfo.setOrg_code(org_code);
			userInfo.setPassword(password);
			userInfo.setPower(tempPower);
			userInfo.setRegionCode(regionCode);
			userInfo.setSLoginNo(sLoginNo);
			userInfo.setDistrictCode(districtCode);
			userInfo.setGroup_id((String)session.getAttribute("groupId"));
			userInfo.setOrg_id((String)session.getAttribute("orgId"));
			%>


<%  
    /*yanpx@20100903为客服 不打印免填单添加 开始*/
    String accountType = (String)session.getAttribute("accountType"); //1 为营业工号 2 为客服工号
    /*结束*/
    String pageName="IPTV用户信息变更";
    String opCode = "9130";
	String message="";
	String error_msg = "";
    String[] retStr = new String[] {};
    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
    String error_code = "";
    Logger logger = Logger.getLogger("f9130cfm.jsp");

			int errCode = -1;
			String errMsg = "";
             
			String sys_note = ""; 
			String phone_no = request.getParameter("phone_no");
			String id_no = request.getParameter("id_no");
			String deal_flag = request.getParameter("deal_flag");
			String note = request.getParameter("note");
			String loginGrpId = request.getParameter("loginGrpId");
			String sm_code = request.getParameter("sm_code");
			String belong_code = request.getParameter("belong_code");
			String tfc_code = request.getParameter("tfc_code");
			String add_mode = request.getParameter("add_mode");
			String op_time = request.getParameter("op_time");
			String id_type = request.getParameter("opType");
			String cust_id = request.getParameter("cust_id");
			String swtch_type_list = request.getParameter("switch_type_list");
			String swtch_type=request.getParameter("switch_type");
			String flag199=request.getParameter("flag199");

			 System.out.println("swtch_type_list"+swtch_type_list);
			 System.out.println("swtch_type"+swtch_type);
			 System.out.println("flag199"+flag199);

			sys_note=phone_no+"用户梦网业务变更";
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=phone_no%>" id="seq"/>
<%
String loginAccept = seq;
System.out.println("loginAccept === "+loginAccept);
            

			String hand_fee="0";
			//-----for print
			String bill_year = "";
			String bill_month = "";
    %>

	<%
	
	    try
    {		
			StringTokenizer token=new StringTokenizer(swtch_type_list,"|");
			StringTokenizer tokenop=new StringTokenizer(swtch_type,"|");
			
			int length=token.countTokens();
			int lengthop=tokenop.countTokens();
			System.out.println(length);
			String temp[]=new String [length];
			String fieldValue[]=new String [lengthop];


			int i=0;
			//解析名字字符串
			while (token.hasMoreElements()){
				temp[i]=(String)token.nextElement();
				System.out.println("temp["+i+"]"+temp[i]);
				fieldValue[i]=request.getParameter("f"+temp[i]);//利用名字取得传递来的参数
				
				System.out.println("fieldValue["+i+"]"+fieldValue[i]);
				i++;
			}
			i=0;
			while (tokenop.hasMoreElements() ){
				fieldValue[i]=(String)tokenop.nextElement();
				System.out.println("fieldValue["+i+"]"+fieldValue[i]);
				i++;
			}
			
			
			
		String number = request.getParameter("f199");
		if("1".equals(number))
		{
			;
		}
		//liuyl修改 增加Mobile Market和Widget信息开关
		//qucc  修改 删除手机动画业务
		else
		{
			number= "6";
		}
	//niyue  updated,................20091113 ↓
	//else
		//{
	    //number= "5";
		//}
System.out.println("number value = "+number);
			ArrayList paramsIn = new ArrayList();

            paramsIn.add(new String[]{org_code         });
            paramsIn.add(new String[]{sLoginNo         });
            paramsIn.add(new String[]{password     });
            paramsIn.add(new String[]{selfIp        });
            paramsIn.add(new String[]{opCode       });
            paramsIn.add(new String[]{phone_no        });
            paramsIn.add(new String[]{id_no         });
            paramsIn.add(new String[]{note         });
            paramsIn.add(new String[]{belong_code        });
            paramsIn.add(new String[]{sm_code         });
            paramsIn.add(new String[]{cust_id         });
            paramsIn.add(new String[]{sys_note         });
            paramsIn.add(swtch_type_list );
            paramsIn.add(swtch_type                    );
            paramsIn.add(number                    );
            paramsIn.add(flag199                    );
            

			//传入参数数组
            //retStr = callView.callService("s9130Cfm", paramsIn, "2");
	/*System.out.println("9130~~~~org_code~~~~"+org_code);
	System.out.println("9130~~~~sLoginNo~~~~"+sLoginNo);
	System.out.println("9130~~~~password~~~~"+password);
	System.out.println("9130~~~~selfIp~~~~"+selfIp);
	System.out.println("9130~~~~opCode~~~~"+opCode);
	System.out.println("9130~~~~phone_no~~~~"+phone_no);
	System.out.println("9130~~~~id_no~~~~"+id_no);
	System.out.println("9130~~~~note~~~~"+note);
	System.out.println("9130~~~~belong_code~~~~"+belong_code);
	System.out.println("9130~~~~sm_code~~~~"+sm_code);
	System.out.println("9130~~~~cust_id~~~~"+cust_id);
	System.out.println("9130~~~~sys_note~~~~"+sys_note);
	
	System.out.println("9130~~~~swtch_type_list~~~~"+swtch_type_list);
	System.out.println("9130~~~~swtch_type~~~~"+swtch_type);
	System.out.println("9130~~~~number~~~~"+number);
	System.out.println("9130~~~~flag199~~~~"+flag199);*/


%>
<wtc:service name="s1984Cfm" routerKey="phone" routerValue="<%=phone_no%>" retcode="s9130CfmCode" retmsg="s9130CfmMsg" outnum="2" >
	<wtc:param value="<%=org_code%>"/>
	<wtc:param value="<%=sLoginNo%>"/> 
    <wtc:param value="<%=password%>"/> 
    <wtc:param value="<%=selfIp%>"/> 
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=phone_no%>"/>
    <wtc:param value="<%=id_no%>"/>
    <wtc:param value="<%=note%>"/>
    <wtc:param value="<%=belong_code%>"/>
    <wtc:param value="<%=sm_code%>"/>
    <wtc:param value="<%=cust_id%>"/>
    <wtc:param value="<%=sys_note%>"/>
        
    <wtc:param value="<%=swtch_type_list%>"/>
    <wtc:param value="<%=swtch_type%>"/>
    <wtc:param value="<%=number%>"/>
    <wtc:param value="<%=flag199%>"/>
</wtc:service>
<wtc:array id="s9130CfmArr" scope="end"/>
<%
        //callView.printRetValue();
        errCode = Integer.parseInt(s9130CfmCode);
        error_msg= s9130CfmMsg;
//----------------------------
 System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
    String url = "/npage/contact/onceCnttInfo.jsp?opCode="+"9130"+"&retCodeForCntt="+s9130CfmCode+"&retMsgForCntt="+s9130CfmMsg
    +"&opName="+"信息服务开关"+"&workNo="+sLoginNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phone_no+"&opBeginTime="+opBeginTime+"&contactId="+phone_no+"&contactType=user";
%>
    <jsp:include page="<%=url%>" flush="true" />
<%
    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
//----------------------------
    }catch(Exception e){
		e.printStackTrace();
        logger.error("Call s9130Cfm is Failed!");
        errCode = 1;    
        error_msg= "调用服务出现异常";    
        System.out.println("exception:"+e.toString()); 
    }   
	
	%>


<html>
	<head>
		<OBJECT classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05" codebase="/ocx/printatl.dll#version=1,0,0,1" id="printctrl" style="DISPLAY: none" VIEWASTEXT>
		</OBJECT>
		<script language="JavaScript">
			function Cancel(){
  				window.location.href="f9130_info.jsp?activePhone=<%=phone_no%>";
  			}
  		</script>
	</head>
	<body onload="ifprint()">

	</body>
</html>

<!------------------------------------->

<SCRIPT language="JavaScript">
function ifprint() {
	var temp="<%=errCode%>";
	
	if(temp==0){
		rdShowMessageDialog("<%=error_msg%> 办理后24小时生效",2);
		if("<%=accountType%>"=="2"){
			window.location.href="f9130_info.jsp?activePhone=<%=phone_no%>";
		}else{
			showPrtDlg();
		}
	}else{
		rdShowMessageDialog("<%=error_msg%>",0);
		window.location.href="f9130_info.jsp?activePhone=<%=phone_no%>";
	}


}
function showPrtDlg()
{

   var h=105;
   var w=260;
   var t=screen.availHeight-h-20;
   var l=screen.availWidth/2-w/2;
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
   var ret=rdShowConfirmDialog("是否打印电子免填单？");
    if(typeof(ret)!="undefined")
    {
        if(ret==1)                      //点击认可
        {
   
            conf();                          
        }
        else if(ret==0)                 //点击取消,问是否提交
        {    
            window.location.href="f9130_info.jsp?activePhone=<%=phone_no%>"                 
        }
    }
}


function conf()
{
   var h=200;
   var w=300;
   var t=screen.availHeight-h-20;
   var l=screen.availWidth/2-w/2;

var infoStr="";


infoStr+="<%=sLoginNo%>"+"|";
infoStr+="<%=loginName%>"+"|";

infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";


infoStr+= "<%=phone_no%>"+"|";
infoStr+="<%=swtch_type_list%>"+"|";
infoStr+="<%=swtch_type%>"+"|";

dirtPate = "/npage/s9130/f9130_info.jsp?activePhone=<%=phone_no%>";
location="/npage/s9130/f9130_print.jsp?retInfo="+infoStr+"&dirtPage=/npage/s9130/f9130_info.jsp?activePhone=<%=phone_no%>";
//ret_value=window.showModalDialog("f9130_print.jsp?busi_type="+busi_type+"&work_no="+work_no+"&accept_no="+accept_no+"&date="+date+"&phone="+phone+"&cust_name="+cust_name+"&swtch_type_list="+swtch_type_list+"&swtch_type="+swtch_type,"",prop);																												//点击确认，调用打印页面
//ret_value=window.showModalDialog("f9130_print.jsp?retInfo="+infoStr","",prop);

  //window.location = location;
 }
</SCRIPT>

</SCRIPT>
