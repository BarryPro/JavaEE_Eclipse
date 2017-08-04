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
		System.out.println("realKey："+realKey);
		String bill_type = "2";
	// 20090421 liyan 根据张怀韬申告要求，将备注字段打印开始列更改为5.
	  String ifRed = request.getParameter("ifRed");
    String contractno = request.getParameter("contractno");
    String workNo = request.getParameter("workno");
    String payAccept = request.getParameter("payAccept");
    String total_date = request.getParameter("total_date");
    String op_code = "d340";
    String smphoneNo = request.getParameter("phoneNo");
    System.out.println("phoneNo==="+smphoneNo);
    String[][] favInfo = (String[][])session.getAttribute("favInfo");   //数据格式为String[0][0]---String[n][0]
    String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
		String regionCode = org_code.substring(0,2);
		String groupId = (String)session.getAttribute("groupId");
		//xl add for chengll需求
		//String prtFlag = request.getParameter("prtFlag");
		//String jtcpmc = request.getParameter("jtcpmc");
		//String check_seq =  request.getParameter("check_seq");
		//String s_flag =  request.getParameter("s_flag");
		//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAA check_seq is "+check_seq);

		//xl add 发票号码
		int i_count_cwt=0;
		String check_seq = request.getParameter("ocpy_begin_no");
		//发票代码 从qidx取得
		String s_invoice_code = request.getParameter("s_invoice_code");
		String s_flag = "N";//默认都是新版发票 需要手动打印logo 到时候跟市场部确认
		String bill_code = request.getParameter("bill_code");
		String s_yyt_name="";
    String printNote = "0";
 		String sm_name  =request.getParameter("s_sm_name");
  	String s_sm_code =request.getParameter("s_sm_code");
		String s_id_no=request.getParameter("s_id_no");
		String phoneNo = smphoneNo;
		//xl add backnote
    String backnote = request.getParameter("backnote");
    int infoLen = favInfo.length;
    String tempStr = null;
    for (int i = 0; i < infoLen; i++) {
        tempStr = (favInfo[i][0]).trim();
        if (tempStr.equals("a092")) printNote = "1";
    }

    String print_note = "0";

    String smop_code = request.getParameter("opCode");
    System.out.println("smop_code=" + smop_code);
    if (smop_code == null || smop_code == "") {
        smop_code = "0000";
    }
    if (smop_code.equals("1302") ||smop_code.equals("d340") ) {
    //    String smSql = "select decode(sm_code,'zn','神州行','gn','全球通','dn','动感地带') from dcustmsg where phone_no= '" + smphoneNo + "' and substr(run_code,2,1)<'a'";


		//xl add 根据组织节点查询营业厅名称
		String[] inParam_yyt = new String[2];
		inParam_yyt[0]="select group_name from dchngroupmsg where group_id=:s_group_id";
		inParam_yyt[1]="s_group_id="+groupId;
	 
		//hq add 根据contract_no查询id_no
		String[] inParam_idno = new String[2];
		inParam_idno[0]="select to_char(a.id_no),to_char(b.phone_no) from dconusermsg a,dcustmsg b where a.id_no=b.id_no and "
		 +"a.serial_no='0' and a.bill_order ='99999999' and a.contract_no=:s_contract_no";
		inParam_idno[1]="s_contract_no="+contractno;

	
%>

	<wtc:service name="TlsPubSelCrm"  outnum="1" >
		<wtc:param value="<%=inParam_yyt[0]%>"/>
		<wtc:param value="<%=inParam_yyt[1]%>"/>
	</wtc:service>
	<wtc:array id="yyt_name_arr" scope="end" />
		
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
		<wtc:param value="<%=inParam_idno[0]%>"/>
		<wtc:param value="<%=inParam_idno[1]%>"/>
	</wtc:service>
	<wtc:array id="id_no_arr" scope="end" />
<%
		if(yyt_name_arr!=null&&yyt_name_arr.length>0)
		{
			s_yyt_name = yyt_name_arr[0][0];
		}
	
			if(id_no_arr!=null&&id_no_arr.length>0){
        	s_id_no = id_no_arr[0][0];
        	phoneNo = id_no_arr[0][1].trim();
      }

        if (printNote.equals("0")) {
            print_note = "0";
        } else {
           // print_note = request.getParameter("print_note");
		    print_note = "0";
        }
		
    }
	/*xl 为d340增加returnPage */
	
	//huxl 车务通		
	String returnPage ="";
	if(smop_code.equals("d340")){
		returnPage = "s1300_group.jsp";
		//xl add 判断是否是车务通 i_count_cwt
		String[] inParam_cwt = new String[2];
		inParam_cwt[0]="SELECT to_char(count(1)) FROM dproductorderdet b, dproductcharacter c WHERE c.character_number = '1109037709'  AND c.character_value = '451002'  AND c.product_order_id = b.product_order_id and b.id_no=:s_id_no";
		inParam_cwt[1]="s_id_no="+s_id_no;
		%>
		<wtc:service name="TlsPubSelCrm"  outnum="1">
			<wtc:param value="<%=inParam_cwt[0]%>"/>
			<wtc:param value="<%=inParam_cwt[1]%>"/>
		</wtc:service>
		<wtc:array id="s_cwt" scope="end" />
		<%
		if(s_cwt.length>0)
		{
			i_count_cwt=Integer.parseInt(s_cwt[0][0]);	
		}
		//end of 判断
	}
	else{
		returnPage =  "s1300.jsp";
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
		String s_pay_note="";
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
			/*
			if(s_flag.equals("O"))
			{
				%>
				<%
			}
			if(s_flag.equals("N"))
			{
				%>
					printctrl.DrawImage(localPath,8,10,40,18);//左上右下
 
				<%
			}*/
		%>
		//printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,'20130202');
		printctrl.DrawImage(localPath,8,10,40,18);//左上右下
        printctrl.Print(20, 10, 9, 0, "开票日期:<%=year%>年<%=month%>月<%=day%>日");
		printctrl.Print(115, 10, 9, 0, "本次发票号码:<%=check_seq%>"); 
        /*******************************************/
        //printctrl.Print(13, 12, 9, 0, "防伪码：<%=ran%>");

		//printctrl.Print(13, 13, 9, 0, "工    号：<%=result[0][1]%>");
        //printctrl.Print(72, 13, 9, 0, "操作流水：<%=result[0][15]%>");
		printctrl.Print(13, 12, 9, 0, "客户名称:<%=result[0][4]%>");
		printctrl.Print(13, 13, 9, 0, "业务类别:<%=result[0][2]%>");
		<%
			if(i_count_cwt>0)
			{
				%>
					printctrl.Print(115, 13, 9, 0, "客户品牌:社区矫正");	
				<%
			}
			else
			{
				%>
					printctrl.Print(115, 13, 9, 0, "客户品牌:<%=sm_name%>");
				<%
			}	
		%>
		

		printctrl.Print(13, 15, 9, 0, "用户号码：<%=phoneNo%>");	
		printctrl.Print(48, 15, 9, 0, "协议号码：<%=result[0][6]%>");
		printctrl.Print(82, 15, 9, 0, "话费账期:<%=year+month%>");
		printctrl.Print(115, 15, 9, 0, "合同号:");

		printctrl.Print(115, 16, 9, 0, "支票号:<%=result[0][7]%>");
		printctrl.Print(115, 17, 9, 0, "集团统付号码: <%=result[0][6]%>");
		//printctrl.Print(16, 18, 9, 0, "通信服务费合计:");
		printctrl.Print(16, 18, 9, 0, "本次发票金额:(小写)￥<%=result[0][9].trim()%> 大写金额合计:<%=result[0][8]%>");
		printctrl.Print(16, 20, 9, 0, "<%=result[0][11]%>");//备注 
		printctrl.Print(16, 21, 9, 0, "<%=result[0][12]%>");//备注 
		printctrl.Print(16, 22, 9, 0, "<%=result[0][13]%>");//备注 
		printctrl.Print(16, 23, 9, 0, "<%=result[0][14]%>");//备注
		//printctrl.Print(16, 22, 9, 0, "备注1"<br>"备注2"<br>");//备注 
		//xl add for 孙博宇
		<%
				System.out.println("cccccccccccccccccccccccccccccccccccccccccccccc test print here backnote is "+backnote);
				if(backnote!=null && (!backnote.equals("")))
				{
					%>
						printctrl.Print(16, 11, 9, 0, "<%=backnote%>");//备注
					<%
				}
		%>
		//end of 孙博宇
		//hanfeng
		printctrl.Print(16, 24, 9, 0, "注意：本次已开具的发票金额，我公司不再提供月结发票和增值税专用发票。");//备注
		
		     /********tianyang add at 20090928 for POS缴费需求****start*****/
     /* result[0][17] 为 "1"  是pos缴费(冲正) */
     <%if (result[0][17] != null && result[0][17].equals("1")) {%>
	     		printctrl.Print(13, 25, 9, 9, "<%=result[0][18].trim()%>");/*商户名称（中英文)*/
				printctrl.Print(13, 26, 9, 9, "<%=result[0][29].trim()%>");/*交易卡号（屏蔽）*/
				printctrl.Print(72, 26, 9, 9, "<%=result[0][19].trim()%>");/*商户编码*/
				printctrl.Print(115, 26, 9, 9, "<%=result[0][24].trim()%>");/*批次号*/
				printctrl.Print(13, 27, 9, 9, "<%=result[0][21].trim()%>");/*发卡行号*/
				printctrl.Print(72, 27, 9, 9, "<%=result[0][20].trim()%>");/*终端编码*/
				printctrl.Print(115, 27, 9, 9, "<%=result[0][27].trim()%>");/*授权号*/
				printctrl.Print(13, 28, 9, 9, "<%=result[0][25].trim()%>");/*回应日期时间*/
				printctrl.Print(72, 28, 9, 9, "<%=result[0][26].trim()%>");/*参考号*/
				printctrl.Print(115, 28, 9, 9, "<%=result[0][28].trim()%>");/*流水号*/
				printctrl.Print(13, 29, 9, 9, "<%=result[0][22].trim()%>");/*收单行号*/
				printctrl.Print(115, 29, 9, 9, "签字：");
     <%}%>
     /********tianyang add at 20090928 for POS缴费需求****end*******/
 
		
		//xl add 开票：                    收款：                     复核：
		printctrl.Print(13, 30, 9, 0, "流水号：<%=result[0][15]%>");
		printctrl.Print(54, 30, 9, 0, "开票人：<%=workname%>");
		printctrl.Print(85, 30, 9, 0, "工号：<%=workNo%>");
		printctrl.Print(110, 30, 9, 0, "营业厅：<%=s_yyt_name%>");
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
	
	//发票电子化添加入库服务
	//inParas0[0] = realKey+"";
		String[] inParas0 = new String[29];
		//inParas0[0] = realKey+"";
		inParas0[0] = result[0][15];//流水
		inParas0[1] = smop_code;//
		inParas0[2] = workNo;
		inParas0[3] = total_date;//没有用
		inParas0[4] = phoneNo;
		inParas0[5] = s_id_no;//id_no 只是入表用 实在不行在程序里自己取一下
		inParas0[6] = result[0][6];//contract_no
		 
		inParas0[7] = realKey+"";//防伪码
		System.out.println("=============sm_name====================="+sm_name);
		//xl add 发票预占状态变更入参 begin
		//发票号码 发票金额 地市 group_id 备注 发票代码 
		inParas0[8] = check_seq;//发票号码;
		inParas0[9] = bill_code;//发票代码;
		inParas0[10] =s_sm_code;//品牌
		inParas0[11] = result[0][9];//小写金额
		inParas0[12] = result[0][8];//大写金额
		inParas0[13] = s_pay_note ;
		
		//本次缴费金额 这个得看样张都有啥
		//xl add 发票预占状态变更入参 end


		//inParas0[14] ="1";//发票打印
		inParas0[14] = "";//增值税的
		inParas0[15] = "0";//增值税的
		inParas0[16] = "0";//增值税的
		inParas0[17] = "0";//打印年月
		inParas0[18] = result[0][4];//cust_name
		inParas0[19] = "";
		inParas0[20] = "";
		inParas0[21] = "";
		inParas0[22] = "";
		inParas0[23] = "";
		inParas0[24] = regionCode;
		inParas0[25] = groupId; 
		inParas0[26] = ifRed;
		inParas0[27] ="0";//通用机打 
		 

		System.out.println("====执行 s1300PrintInDB 开始=======");
		String[][] result2 = new String[][]{};
		//打印的时候 按流水更新状态 预占的更新为已打印
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
		System.out.println("====执行 szg12InDB 结束=======");
		if(RetResult.length > 0)
		{
			result2 = RetResult;
			if((result2[0][0]!="000000")&&!result2[0][0].equals("000000"))
			{
				%>
					<script language="JavaScript">
					    rdShowMessageDialog("电子发票入库失败,错误代码"+"<%=result2[0][0]%>"+",错误原因:"+"<%=result2[0][1]%>".",0);
					    document.location.replace("<%=returnPage%>");
					</script>
        <%			
			}
			
		}
		else if(RetResult == null || RetResult.length == 0){
%>
					<script language="JavaScript">
					    rdShowMessageDialog("电子发票入库失败,szg12InDB_pt服务返回结果为空.",0);
					    document.location.replace("<%=returnPage%>");
					</script>
<%			
		}
			
		//////////////////////////////////////////////
				}else{
%>
					<script language="JavaScript">
					    rdShowMessageDialog("发票打印失败,s1300Print服务返回结果为空.错误代码:"+"<%=return_code%>"+"<br>请使用补打发票交易打印发票!",0);
					    document.location.replace("<%=returnPage%>");
					</script>
<%
				}
		} else {//s1300Print服务调用失败
%>
		<script language="JavaScript">
		    rdShowMessageDialog("s1300Print发票打印错误,请使用补打发票交易打印发票!<br>错误代码：'<%=return_code%>'，错误信息：'<%=error_msg%>'",0);
		    document.location.replace("<%=returnPage%>");
		</script>
<%
    }
%>
