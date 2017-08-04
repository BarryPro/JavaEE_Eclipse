<%
  /*
   * 功能:兑换发票1321
   * 版本: 1.0
   * 日期: 2009/1/16
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.amd.viewbean.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="com.sitech.util.MoneyUtil"%>
<%@ page import="java.text.*" %>
<script language="javascript">
		
	</script>
<%

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

	String opCode = "1321";
	String opName = "收据兑换月消费发票 ";
	MoneyUtil mon = new MoneyUtil();
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	String phoneNo = (String)request.getParameter("phoneNo");
	
	String i_contract_no = request.getParameter("contract_no");
	String i_year_month = request.getParameter("year_month");
	String i_year_month_end = request.getParameter("year_month_end");
	String i_begin_ym = request.getParameter("begin_ym");
	String i_begin_ym_end =request.getParameter("begin_ym_end");
	String nopass = (String)session.getAttribute("password");
	String i_money = request.getParameter("i_money");
	String i_money_small = request.getParameter("i_money_small");
	String i_bill_money = request.getParameter("i_bill_money");
	String i_bill_no = request.getParameter("i_bill_no");

	String d1_s = (new DecimalFormat("0.00")).format(Double.parseDouble(i_money_small) );
	
	double d1 =  Double.parseDouble(d1_s) ;

	String d2_s = (new DecimalFormat("0.00")).format(Double.parseDouble(i_bill_money) );
	double d2 = Double.parseDouble(d2_s) ;
	String cust_name = request.getParameter("cust_name");
	String check_seq = request.getParameter("check_seq");
	String check_count = request.getParameter("check_count");
	
	//long ll_new = Long.parseLong(check_seq)+1;
 
	String s_flag = request.getParameter("s_flag");
	
	//Long ll = request.getParameter("ll");
%>
	<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept"/>
<%	
   
	String return_code = "0";
	boolean canPrint = false;
    boolean canPrint2 = false;
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    String year = dateStr.substring(0,4);
	String month = dateStr.substring(4,6);
	String day = dateStr.substring(6,8);
	
 

	String[] inParas = new String[6];
	inParas[0] = i_contract_no;
	inParas[1] = i_year_month;
	inParas[2] = i_year_month_end;
	inParas[3] = i_begin_ym;
	inParas[4] = i_begin_ym_end;
	inParas[5] =workno;
 
	 canPrint = true;
%>
 				
 

<%if (!canPrint) {%>
   <script language="JavaScript">
     
     window.location="s1321_3.jsp";
   </script>
<% } else {%>
<SCRIPT language="JavaScript">
<!--
function ifprint(){
 
	printInDB();
 }

<%
    ///liuxmc add  发票电子化添加入库服务 开始
%>
    function printInDB(){
<%
      String i_paymoney = request.getParameter("paymoney");
      double yingsou = 0.00;  
      

      
    	String[] inParas0 = new String[15];
			inParas0[0] = realKey+"";
			inParas0[1] = loginAccept;
			inParas0[2] = opCode;
	    inParas0[3] = workno;
	    inParas0[4] = dateStr;
	    inParas0[5] = phoneNo;//服务号码
	    inParas0[6] = i_contract_no;
	    String sm_name="";
	    if(sm_name == null || sm_name.trim().length() == 0){
	    	sm_name = "品牌：";
	    }
	    inParas0[7] = sm_name;
 
	    inParas0[8] = i_paymoney;
	    //inParas0[9] = out_result15[0][0].trim();
	 
		inParas0[9] = "营业员姓名：" + workname;
 
%>
			//alert("第二次入库");
			var myPacket = new AJAXPacket("PrintInvoiceInDB_1321.jsp","正在进行发票底联入库操作，请稍候......");
<%    
			for(int k=0;k<inParas0.length ;k++){
%>
				myPacket.data.add("inPut"+"<%=k%>","<%=inParas0[k]%>");
<%
			}			
%>
			
			core.ajax.sendPacket(myPacket);
			myPacket=null;
    }
    
    function doProcess(packet){
			var results = packet.data.findValueByName("result");
			var fphm_new =  packet.data.findValueByName("fphm_new");
			//alert(results);
			if(results == "1"){
				rdShowMessageDialog("电子发票入库失败,s1300PrintInDB服务返回结果为空.",0);
				document.location.replace("s1321_3.jsp");
				return;
			}
			
			if(results!="000000"){
				rdShowMessageDialog("电子发票入库失败！返回代码："+results,0);
				document.location.replace("s1321_3.jsp");
				return;
			}
			else
				{
					  

		 
		 if(rdShowConfirmDialog("当前发票号码是"+fphm_new+",是否打印发票?")==1)
		 {
			 try {
              <% 
                
                String d3 = (new DecimalFormat("0.00")).format(d1 + d2 - yingsou);
                
                out.println("printctrl.Setup(0)");
                out.println("printctrl.StartPrint()");
                out.println("printctrl.PageStart()");
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
						var localPath = "C:/billLogo.jpg";
						printctrl.DrawImage(localPath,8,10,40,18);//左上右下
					<%
				}
				// begin
				
				//out.println("printctrl.Print(20, 10, 9, 0,'"+year+month+day+"')");
	       //out.println("printctrl.Print(50, 10, 9, 0,'邮电通信业')");
				  out.println("printctrl.Print(20, 10, 9, 0,'"+year+month+day+"')");
				  out.println("printctrl.Print(85, 10, 9, 0,'邮电通信业')");
				  
				  %>
					printctrl.Print(110,10, 9, 0, "本次发票号码:"+fphm_new);	  
				  <%
			 
				    
				  out.println("printctrl.Print(13, 12, 9, 0,'"+"防伪码："+ran+"')");
				  out.println("printctrl.Print(13, 13, 9, 0,'"+"工    号："+workno+"')");
				  out.println("printctrl.Print(72, 13, 9, 0,'"+"操作流水："+loginAccept+"')");
				  out.println("printctrl.Print(115, 13, 9, 0,'业务名称：等额发票兑换月消费发票')");	
				 
				  out.println("printctrl.Print(13, 14, 9, 0,'客户名称："+cust_name+"')");	
				  out.println("printctrl.Print(115, 14, 9, 0,'卡    号：')");	
			 
				  out.println("printctrl.Print(13, 15, 9, 0,'手机号码："+phoneNo+"')");
				  out.println("printctrl.Print(72, 15, 9, 0,'协议号码："+i_contract_no+"')");
				  out.println("printctrl.Print(115, 15, 9, 0,'支票号码："+i_bill_no+"')");
				  
				  out.println("printctrl.Print(13, 16, 9, 0,'合计金额：(大写)"+i_money+"')");
				  out.println("printctrl.Print(115, 16, 9, 0,'(小写)￥"+d1+"')");
				  out.println("printctrl.Print(13, 17, 9, 0,'(项目)')");
				  out.println("printctrl.Print(13,18,9,0,'"+"交话费："+"')");
					if (d1 == 0) 
					{
						out.println("printctrl.Print(13,19,9,0,'"+"现金：" + " 0.00" +"')");
						out.println("printctrl.Print(13,20,9,0,'"+"支票：" + d3 +"')");  
					}
					else
					{
						out.println("printctrl.Print(13,19,9,0,'"+"现金：" + d3 +"')");
						out.println("printctrl.Print(13,20,9,0,'"+"支票：" + " 0.00" +"')");
					}
				  out.println("printctrl.Print(13, 21, 9, 0,'换发票时的余额发票')");
				 
				  out.println("printctrl.Print(13, 30, 9, 0,'开票："+workname+"')");
				  out.println("printctrl.Print(42, 30, 9, 0,'收款：')");
				  out.println("printctrl.Print(80, 30, 9, 0,'复核：')");
			// end

    
                
                out.println("printctrl.PageEnd()");
                out.println("printctrl.StopPrint()");
            %>
           	rdShowMessageDialog("打印成功!",2);
             document.location.replace("s1321_3.jsp");
           } catch(e) {
           } finally {
	              }
		 }
		 else
		 { 
			return false;
		 }

           
         
         }

			
		}

  
</SCRIPT>
<html>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.dll#version=1,1,0,5" style="display:none;"
id="printctrl"
VIEWASTEXT>
</OBJECT>
<body onload="ifprint()">
<form action="" name="form" method="post">
</form>
</body>
</html>

<% } 
 
%>