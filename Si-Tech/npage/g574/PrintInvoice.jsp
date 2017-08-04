<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-08-19 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%
	//20100528 liuxmc 添加发票防伪码
		java.util.Random r = new java.util.Random();
		int ran = r.nextInt(9999);
		int ran1 = r.nextInt(10)*1000;
		if((ran+"").length()<4){
			ran = ran+ran1;
		}
		int key = 99999;
		int realKey = ran ^ key;
		System.out.println("EEEEEEEEEEEEEEEEEEEE realKey："+realKey);
		
		String bill_type = "2";
	/////////////////////////////////
		String groupId = (String)session.getAttribute("groupId");
	// 20090421 liyan 根据张怀韬申告要求，将备注字段打印开始列更改为5.
    String contractno = request.getParameter("contractno");
    String workNo = request.getParameter("workno");
    String payAccept = request.getParameter("payAccept");
    String total_date = request.getParameter("total_date");
    String op_code = "1302";
    String smphoneNo = request.getParameter("phoneNo");
    System.out.println("aaaaaaaaaaaaaaaaaaffffffffffffffffff  add testfaaaaaaaaaafffffffffffffffffffffffffffffffff  phoneNo==="+smphoneNo);
    String[][] favInfo = (String[][])session.getAttribute("favInfo");   //数据格式为String[0][0]---String[n][0]
    String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String s_sm_name = request.getParameter("s_sm_name");;
    String s_sm_code = request.getParameter("s_sm_code");
    String printNote = "0";
    String ifRed="2";
	String bill_code = request.getParameter("bill_code");
    int infoLen = favInfo.length;
    String tempStr = null;
    for (int i = 0; i < infoLen; i++) {
        tempStr = (favInfo[i][0]).trim();
        if (tempStr.equals("a092")) printNote = "1";
    }
    //路由
	String regionCode = org_code.substring(0,2);

    String print_note = "0";
	
	//xl add 发票号码
	String id_no = request.getParameter("id_no");
	String check_seq = request.getParameter("check_seq");
	String s_flag = request.getParameter("s_flag");

    String smop_code = "g574";//request.getParameter("opCode");
    System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA smop_code=" + smop_code);
    String sm_name = "";
    if (smop_code == null || smop_code == "") {
        smop_code = "0000";
    }
 
	//xl add 根据10648号段取id_no 和 phone_no
	String s_id_no="";
	String s_phone_old="";
	String[] inParam = new String[2];
	inParam[0] ="select to_char(a.id_no),to_char(b.phone_no) from dconusermsg a,dcustmsg b where a.id_no=b.id_no and  a.serial_no='0' and a.bill_order ='99999999' and a.contract_no=:s_contract_no";
	inParam[1] = "s_contract_no="+contractno;
%>
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
		<wtc:param value="<%=inParam[0]%>"/>
		<wtc:param value="<%=inParam[1]%>"/>
	</wtc:service>
	<wtc:array id="sm_name_arr" scope="end" />
<%
	if(sm_name_arr.length>0)
	{
		s_id_no=sm_name_arr[0][0];
		s_phone_old=sm_name_arr[0][1];
	}
 
	/*xl 为1303增加returnPage */
	String returnPage ="";
	if(smop_code.equals("1303")){
		returnPage = "s1300_6.jsp";
	}
	else{
		returnPage =  "g574_1.jsp";
	}
    
    if (request.getParameter("returnPage") != null) {
        returnPage = request.getParameter("returnPage");
    }

    String printtype = "0";
    if (request.getParameter("printtype") != null) {
        printtype = request.getParameter("printtype");
    }


    String year = total_date.substring(0, 4);
    String month = total_date.substring(4, 6);
    String day = total_date.substring(6, 8);

    String[] inParas = new String[4];
    inParas[0] = workNo;
    inParas[1] = contractno;
    inParas[2] = total_date;
    inParas[3] = payAccept;

    //CallRemoteResultValue value = viewBean.callService("1", org_code.substring(0, 2), "s1300Print", "17", inParas);
%>

	<wtc:service name="s1300Print" routerKey="phone" routerValue="<%=smphoneNo%>" outnum="33" >
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
		
<%
		
		
		String return_code = "999999";
		String temp[]=new String[10];
		String info=new String();
		int record=0;
		if(result!=null&&result.length>0){
			 return_code = result[0][0];
		
			
		   
		   
		}

    String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
	System.out.println("return_code===="+return_code);
    if (return_code.equals("000000")) {
    		String phoneNo = "";
    		if(result!=null&&result.length>0){
		    		phoneNo = result[0][5].trim();
		        if (phoneNo.equals("99999999999")){
		            phoneNo = "";
		        }
	
		   int length1=result[0][16].length();
			 if(length1>0)
			 {
			 int size=60;
			 System.out.println("-------------------------"+result[0][16].length());
			 info=result[0][16].trim();
			 System.out.println("-------------------------"+result[0][16]);
			 record=length1/size;
			 System.out.println("-------------------------"+record);
			 for(int j=0;j<=record;j++)
			 {
			 if(info.length()>=size)
			 {
			 temp[j]=info.substring(0,size);
		   info=info.substring(size);
		   }
		   else
		   temp[j]=info;
		   System.out.println("-------------------------"+j+"  "+temp[j]);
		   
		   
		  
		   }
		   }
%>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<SCRIPT language="JavaScript">
    function printInvoice()
    {
        var localPath = "C:/billLogo.jpg";
		//alert(2);
        printctrl.Setup(0);
        printctrl.StartPrint();
        printctrl.PageStart();
		var rowInit = 7;
		var fontSizeInit = 9;//字体大小
		var fontType = "宋体";//字体
		var fontStrongInit = 0;//字体粗细
		var vR = 0;
		var lineSpace = 0;
        //alert(3);
        /*20100528 liuxmc 添加发票防伪码*/
		<%
			if(s_flag.equals("O"))
			{
				%>
					//printctrl.Print(12, 9, 51, 20, "老版")
				<%
			}
			if(s_flag.equals("N"))
			{
				%>
					//printctrl.Print(12, 9, 51, 20, "新版");
					//getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
					//printctrl.DrawImage(localPath,300,120,560,190);
					//printctrl.DrawImage(localPath,21,10,43,16);//左上右下
					//printctrl.DrawImage(localPath,8,10,40,18);//左上右下
 
				<%
			}
		%>
		printctrl.DrawImage(localPath,8,10,40,18);//左上右下
		//printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,'20130202');
        printctrl.Print(20, 10, 9, 0, "<%=year+month+day%>");
		printctrl.Print(85, 10, 9, 0, "邮电通信业");
		printctrl.Print(110,10, 9, 0, "本次发票号码：<%=check_seq%>");
        /*******************************************/
        printctrl.Print(13, 12, 9, 0, "防伪码：<%=ran%>");

		printctrl.Print(13, 13, 9, 0, "工    号：<%=result[0][1]%>");
        printctrl.Print(72, 13, 9, 0, "操作流水：<%=result[0][15]%>");
 

    <%if (printtype.equals("0")) {%>
        printctrl.Print(115, 13, 9, 0, "业务名称：<%=result[0][2]%>");
    <%} else {%>
        printctrl.Print(115, 13, 9, 0, "业务名称：补打<%=result[0][2]%>");
    <%}%>

     

        printctrl.Print(13, 14, 9, 0, "客户名称：<%=result[0][4]%>");
		printctrl.Print(115, 14, 9, 0, "卡    号：");   
    <%if (!print_note.equals("0")) {%>
        printctrl.Print(13, 15, 9, 0, "<%=print_note%>--缴费");
    <%}%>

        printctrl.Print(13, 15, 9, 0, "物联网号码：<%=smphoneNo%>");

        printctrl.Print(50, 15, 9, 0, "<%=sm_name%>");
        printctrl.Print(72, 15, 9, 0, "协议号码：<%=result[0][6]%>");
        printctrl.Print(115, 15, 9, 0, "支票号码：<%=result[0][7]%>");

        printctrl.Print(13, 16, 9, 0, "合计金额：(大写)<%=result[0][8]%>");
        printctrl.Print(115, 16, 9, 0, "(小写)￥<%=result[0][9].trim()%>");
		
        printctrl.Print(13, 17, 9, 0, "(项目)");
        printctrl.Print(13, 19, 9, 0, "<%=result[0][11]%>");
        printctrl.Print(13, 20, 9, 0, "<%=result[0][12]%>");
        printctrl.Print(13, 21, 9, 0, "<%=result[0][13]%>");
        printctrl.Print(13, 22, 9, 0, "<%=result[0][14]%>");
		<%
		 if(length1>0){
       for(int i=0;i<=record;i++)
        {
        %>
        printctrl.Print(13, "<%=(i*1.5+23.5)%>", 10, 0, "<%=temp[i]%>");
        <%
        if(i==record){
        %>
         //printctrl.Print(13,"<%=(i+29)%>", 9, 0, "<%=workname%>");
        <%
        }
        }
        }
      else{
        %>
        //printctrl.Print(13,29, 9, 0, "<%=workname%>");
        <%}	
		%>

     /********tianyang add at 20090928 for POS缴费需求****start*****/
     /* result[0][17] 为 "1"  是pos缴费(冲正) */
     <%if (result[0][17] != null && result[0][17].equals("1")) {%>
	     		printctrl.Print(13, 25, 9, 9, "<%=result[0][18].trim()%>");/*商户名称（中英文)*/
				printctrl.Print(13, 26, 9, 9, "<%=result[0][29].trim()%>");/*交易卡号（屏蔽）*/
				printctrl.Print(73, 26, 9, 9, "<%=result[0][19].trim()%>");/*商户编码*/
				printctrl.Print(119, 26, 9, 9, "<%=result[0][24].trim()%>");/*批次号*/
				printctrl.Print(13, 27, 9, 9, "<%=result[0][21].trim()%>");/*发卡行号*/
				printctrl.Print(73, 27, 9, 9, "<%=result[0][20].trim()%>");/*终端编码*/
				printctrl.Print(119, 27, 9, 9, "<%=result[0][27].trim()%>");/*授权号*/
				printctrl.Print(13, 28, 9, 9, "<%=result[0][25].trim()%>");/*回应日期时间*/
				printctrl.Print(73, 28, 9, 9, "<%=result[0][26].trim()%>");/*参考号*/
				printctrl.Print(119, 28, 9, 9, "<%=result[0][28].trim()%>");/*流水号*/
				printctrl.Print(13, 29, 9, 9, "<%=result[0][22].trim()%>");/*收单行号*/
				printctrl.Print(119, 29, 9, 9, "签字：");
     <%}%>
     /********tianyang add at 20090928 for POS缴费需求****end*******/

				//ZLC测试 验证信息
		
		//xl add 开票：                    收款：                     复核：
		printctrl.Print(13, 30, 9, 0, "开票：<%=workname%>");
		printctrl.Print(37, 30, 9, 0, "收款：");
		printctrl.Print(60, 30, 9, 0, "复核：");
		//alert(4);
        printctrl.PageEnd();
        printctrl.StopPrint();
        //alert(5);
    }

    function ifprint()
    {
      //alert(1);
        printInvoice();
        document.location.replace("<%=returnPage%>");
    }
</SCRIPT>

<body onload="ifprint()">
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.dll#version=1,1,0,5" style="display:none;"
id="printctrl"
VIEWASTEXT>
</OBJECT>
 
</body>     
</html>

<%
	
		String[] inParas0 = new String[28];
		//inParas0[0] = realKey+"";
		inParas0[0] = result[0][15];//流水
		inParas0[1] = smop_code;//
		inParas0[2] = workNo;
		inParas0[3] = "";//没有用
		inParas0[4] = s_phone_old;
		inParas0[5] = s_id_no;//id_no 只是入表用 实在不行在程序里自己取一下
		inParas0[6] = contractno;//contract_no
		 
		inParas0[7] = "";//支票号码
		System.out.println("=============sm_name====================="+sm_name);
		//xl add 发票预占状态变更入参 begin
		//发票号码 发票金额 地市 group_id 备注 发票代码 
		inParas0[8] = check_seq;//发票号码;
		inParas0[9] = bill_code;//发票代码;
		inParas0[10] =s_sm_code;//品牌
		inParas0[11] = "";//小写金额
		inParas0[12] = "";//大写金额
		inParas0[13] = "" ;
		inParas0[14] ="1"; 
		inParas0[15] = ""; 
		inParas0[16] = "0"; 
		inParas0[17] = "0"; 
		inParas0[18] = "0"; 
		inParas0[19] = ""; 
		inParas0[20] = "";
		inParas0[21] = "";
		inParas0[22] = "";
		inParas0[23] = "";
		inParas0[24] = regionCode;
		inParas0[25] = groupId; 
		inParas0[26] = ifRed;
		inParas0[27] ="0";//通用机打 
		String[][] result2 = new String[][]{};
	%>		
			<wtc:service name="sinvoiceInDB" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
				<wtc:param value="<%=inParas0[0]%>"/>
				<wtc:param value="<%=inParas0[1]%>"/>
				<wtc:param value="<%=inParas0[2]%>"/>
				<wtc:param value="<%=inParas0[3]%>"/>
				<wtc:param value="<%=inParas0[4]%>"/>
				<wtc:param value="<%=inParas0[5]%>"/>
				<wtc:param value="<%=inParas0[6]%>"/>
				<wtc:param value="<%=inParas0[7]%>"/>
				<wtc:param value="<%=inParas0[8]%>"/>
				<wtc:param value="<%=inParas0[9]%>"/>
				<wtc:param value="<%=inParas0[10]%>"/>
				<wtc:param value="<%=inParas0[11]%>"/>
				<wtc:param value="<%=inParas0[12]%>"/>
				<wtc:param value="<%=inParas0[13]%>"/>
				<wtc:param value="<%=inParas0[14]%>"/>
				<wtc:param value="<%=inParas0[15]%>"/>
				<wtc:param value="<%=inParas0[16]%>"/>
				<wtc:param value="<%=inParas0[17]%>"/>
				<wtc:param value="<%=inParas0[18]%>"/>
				<wtc:param value="<%=inParas0[19]%>"/>
				<wtc:param value="<%=inParas0[20]%>"/>
				<wtc:param value="<%=inParas0[21]%>"/>
				<wtc:param value="<%=inParas0[22]%>"/>
				<wtc:param value="<%=inParas0[23]%>"/>
				<wtc:param value="<%=inParas0[24]%>"/>
				<wtc:param value="<%=inParas0[25]%>"/>
				<wtc:param value="<%=inParas0[26]%>"/>
				<wtc:param value="<%=inParas0[27]%>"/>
			</wtc:service>
			<wtc:array id="RetResult" scope="end"/>
	<%
			System.out.println("====执行 s1300PrintInDB 结束=======");
			if(RetResult.length > 0)
			{
				result2 = RetResult;
				if((result2[0][0]!="000000")&&!result2[0][0].equals("000000"))
				{
					%>
						<script language="JavaScript">
							rdShowMessageDialog("电子发票入库失败,营业员没有录入发票号码或者录入的发票号码已经打印完毕.",0);
							document.location.replace("<%=returnPage%>");
						</script>
			<%			
				}
				
			}
			else if(RetResult == null || RetResult.length == 0){
	%>
						<script language="JavaScript">
							rdShowMessageDialog("电子发票入库失败,s1300PrintInDB服务返回结果为空.",0);
							document.location.replace("<%=returnPage%>");
						</script>
	<%			
			}
	
	
	//liuxmc add  发票电子化添加入库服务

				}else{
%>
					<script language="JavaScript">
					    rdShowMessageDialog("发票打印失败,s1300Print服务返回结果为空.<br>请使用补打发票交易打印发票!",0);
					    document.location.replace("<%=returnPage%>");
					</script>
<%
				}
		} else {
%>
		<script language="JavaScript">
		    rdShowMessageDialog("发票打印错误,请使用补打发票交易打印发票!<br>错误代码：'<%=return_code%>'，错误信息：'<%=error_msg%>'",0);
		    document.location.replace("<%=returnPage%>");
		</script>
<%
    }
%>
