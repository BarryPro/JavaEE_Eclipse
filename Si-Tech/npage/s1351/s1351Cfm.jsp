   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-25
********************/
%>
              
<%
  String opCode = "3479";
  String opName = "新帐单打印";
%>              

<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.Calendar"%>
<%
String s_flag1 = request.getParameter("s_flag1");//0不加密 1加密
String workno = (String)session.getAttribute("workNo");
String regionCode = (String)session.getAttribute("regCode");

System.out.println("---------------------------s1351Cfm.jsp-----------------------sss----s_flag1 is "+s_flag1);
DecimalFormat df = new DecimalFormat("#0.00");
String sm_code = new String();
String printway=request.getParameter("printway");//打印方式 0-手机号码 1-账户号码
String phoneNo = request.getParameter("phoneNo");
System.out.println("phoneNo="+phoneNo);
String contract_no = request.getParameter("contract_no");
System.out.println("contract_no="+contract_no);
String contract_no_sign = contract_no;
String beginDate= request.getParameter("beginDate");

String custPasswd = WtcUtil.repNull(request.getParameter("password"));//用户帐户密码
System.out.println("---------------------------custPasswd---------------------------"+custPasswd+" and printway is "+printway);
System.out.println("wxy="+custPasswd);
String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
String ny = dateStr.substring(0,4);
String nm = dateStr.substring(4,6);
String nd = dateStr.substring(6,8);
Calendar cd = Calendar.getInstance();
Calendar cr = Calendar.getInstance();
cr.setTime(new Date());
String crd = cr.get(cr.DATE) < 10 ? "0" + cr.get(cr.DATE) : "" + cr.get(cr.DATE);
String zy = beginDate.substring(0,4);
String zm = beginDate.substring(4,6);
cd.clear();
cd.set(cd.YEAR,Integer.parseInt(zy));
cd.set(cd.MONTH,Integer.parseInt(zm)-1);
String zdf = cd.getActualMinimum(cd.DAY_OF_MONTH) < 10 ? "0" + cd.getActualMinimum(cd.DAY_OF_MONTH) : "" + cd.getActualMinimum(cd.DAY_OF_MONTH);
String zdl = cd.getActualMaximum(cd.DAY_OF_MONTH) < 10 ? "0" + cd.getActualMaximum(cd.DAY_OF_MONTH) : "" + cd.getActualMaximum(cd.DAY_OF_MONTH);
String errCode="";
String sql="";
String errMsg="";
String rtnPage = "/npage/s1351/f1351.jsp";
String password="";
int row_count = 51;
int num=0;
int i = 0;
int j = 0;
int k=0;
//xl add for jiyu
String s_name="";
int i_length=0;
 
 
	 		
  	
 
	  String[][] temfavStr= (String[][])session.getAttribute("favInfo");
  	String[] favStr=new String[temfavStr.length];
  	for( i=0;i<favStr.length;i++)
  	{
   		favStr[i]=temfavStr[i][0].trim();
  	}	
  	boolean pwrf=false;
 	
	  
  			
 	 
  
	String id_no="";
	String[] args=new String[4];
	args[0]=phoneNo;
	args[1]=beginDate;
	args[2]=contract_no;
	args[3]=workno;
	String phoneNo1=phoneNo;
	String contract_no1=new String();
	contract_no1=contract_no;
	String tempSQL1="select sm_code from dmarkmsg";
	tempSQL1=tempSQL1+beginDate.trim()+" where id_no='?'";
	String[][] resultTemp1=new String[1][1];
	//resultTemp1=(String[][])coTemp1.spubqry32("1",tempSQL1).get(0);
	//xl add for jiyu 密码校验姓名是否加密 begin
	//判断输入的是账号 还是手机号码
	String[] inParas = new String[2];
	if(printway=="0" ||printway.equals("0"))
	{
		System.out.println("cccccccccccccccccccccc 手机号码查询");
		inParas[0]="select trim(cust_name),to_char(length(trim(cust_name))) FROM dcustdoc a,dcustmsg b where a.cust_id = b.cust_id and b.phone_no= :s_phone_no";
		inParas[1]="s_phone_no="+phoneNo;
	}
	else
	{
		System.out.println("cccccccccccccccccccccc 账户号码查询");//'13029066931' '201509'
		inParas[0]="select trim(cust_name),to_char(length(trim(cust_name))) FROM dcustdoc where cust_id= (SELECT b.con_cust_id  FROM dCustConMsg a,dConMsg b WHERE  b.contract_no=:s_contract_no and a.cust_id=b.con_cust_id and a.contract_no=b.contract_no and to_number(to_char(a.begin_time,'YYYYMM'))<=:s_year_month)";
		inParas[1]="s_contract_no="+contract_no+",s_year_month="+beginDate;
	}
	
	//end of jiyu
	%>
	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode41" retmsg="retMsg41" outnum="2">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
	</wtc:service>
	<wtc:array id="result_name" scope="end" />
	<%
		if(result_name.length>0)
	    {
			s_name=result_name[0][0];
			i_length= Integer.parseInt(result_name[0][1]);
	    }
		//0不加密 1加密 s_flag1
		if(s_flag1=="1" ||s_flag1.equals("1"))
	    {
			if(i_length==2)
			{
				s_name=s_name.substring(0,1)+"*";
			}
			else if(i_length==3)
			{
				s_name=s_name.substring(0,1)+"**";
			}
			else if(i_length==4)
			{
				s_name=s_name.substring(0,2)+"**";
			}
			else
			{
				s_name=s_name.substring(0,2)+"******";
			}
		}
		System.out.println("sssssssssssssssssssssssssssss s_name is "+s_name+" and i_length is "+i_length);
	%>
	<wtc:pubselect name="TlsPubSelBoss" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=tempSQL1%></wtc:sql>
 	   <wtc:param value="<%=id_no.trim()%>"/>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>	
	
	<%
	resultTemp1 = result_t2;
	if(resultTemp1.length>0)
	sm_code=resultTemp1[0][0];
	//ArrayList result2=impl.callFXService("s3479",args,"25");
	%>
	
    <wtc:service name="s3479" outnum="26" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=args[0]%>" />
			<wtc:param value="<%=args[1]%>" />	
			<wtc:param value="<%=args[2]%>" />
			<wtc:param value="<%=args[3]%>" />		
		</wtc:service>

	<wtc:array id="r_return_code" scope="end" start="0"  length="1" />	
	<wtc:array id="r_cust_name" scope="end" start="1"  length="1" />	 
	<wtc:array id="r_post_name" scope="end" start="2"  length="2" />
	<wtc:array id="r_cust_addr" scope="end" start="4"  length="1" />
	<wtc:array id="r_fee_sum" scope="end" start="5"  length="1" />
	<wtc:array id="r_fee_item" scope="end" start="6"  length="1" />
	<wtc:array id="r_fee_money" scope="end" start="7"  length="1" />
	<wtc:array id="r_fee_level" scope="end" start="8"  length="1" />
	<wtc:array id="r_pay_other" scope="end" start="9"  length="1" />
	<wtc:array id="r_other_pay" scope="end" start="10"  length="1" />
	<wtc:array id="r_account_item" scope="end" start="11"  length="1" />
	<wtc:array id="r_account_money" scope="end" start="12"  length="1" />
	<wtc:array id="r_account_sum" scope="end" start="13"  length="1" />
	<wtc:array id="r_score_item" scope="end" start="14"  length="1" />
	<wtc:array id="r_score_value" scope="end" start="15"  length="1" />
	<wtc:array id="r_remain_score" scope="end" start="16"  length="1" />
	<wtc:array id="r_clean_score" scope="end" start="17"  length="1" />
	<wtc:array id="r_service" scope="end" start="18"  length="1" />
	<wtc:array id="r_service_code" scope="end" start="19"  length="1" />
	<wtc:array id="r_busi_name" scope="end" start="20"  length="1" />
	<wtc:array id="r_replace_fee" scope="end" start="21"  length="1" />
	<wtc:array id="r_replace_sum" scope="end" start="22"  length="1" />
	<wtc:array id="r_sm_name" scope="end" start="23"  length="1" />
	<wtc:array id="r_return_msg" scope="end" start="24"  length="1" />
		
	<%
 
	errCode=code2;
	errMsg=msg2;
	System.out.println("--------------errCode-------------s1351.jsp----------------"+errCode);
	System.out.println("errCode="+errCode+"  errMsg="+errMsg);
	System.out.println("errCode="+r_return_code[0][0]+"  errMsg="+r_return_msg[0][0]);
	if(!errCode.equals("000000"))
	{  
%>
		<script>		
			rdShowMessageDialog('<%=errCode%>:<%=errMsg%>',0);
			history.go(-1);
		</script>
<%
  }
  else
  {
		String[][] emo_list=new String[row_count/3+1][3];
		String[][] emo_list1=new String[row_count/3+1][3];
		String[][] emo_list2=new String[row_count/3+1][3];
		for(i=0;i<row_count/3+1;i++)
		{
	  	if(j>=row_count)
	   			break;
	    if(num>=r_fee_item.length)
	    {
	    	 
	 	     break;
	 	   }
	  		emo_list[i][0] = r_fee_item[num][0];
	  		emo_list[i][1] = r_fee_money[num][0];
	  		emo_list[i][2] = r_fee_level[num][0];
	  		num++;
	  	j++;
  	}
  	k=0;
		for(i=0;i<row_count/3+1;i++)
		{
	 		if(j>=row_count)
	 				break;
	 		if(num>=r_fee_item.length)
	 		{
	 		  
	   	    break;
	   	}
	   	emo_list1[i][0]=r_fee_item[num][0];
	   	emo_list1[i][1] = r_fee_money[num][0];
	  	emo_list1[i][2] = r_fee_level[num][0];
	  	num++;
			j++;
		}
		k=0;
		for(i=0;i<row_count/3+1;i++)
		{
			if(j>=row_count)
		 		 break;
			if(num>=r_fee_item.length)
			{
			 
	   	    break;
	   	}
	   	emo_list2[i][0]=r_fee_item[num][0];
	   	emo_list2[i][1] = r_fee_money[num][0];
	  	emo_list2[i][2] = r_fee_level[num][0];
	  	num++;
	    j++;
  	}

		int max_row = 0;
		if(r_account_item.length > r_score_item.length)
		{
			max_row = r_account_item.length;
		}
		else
		{
			max_row = r_score_item.length;
		}

		String[][] emo_conlist = new String[max_row][2];
		String[][] emo_marklist = new String[max_row][2];
		for(i=0;i<max_row;i++)
		{
			if(i >= r_account_item.length)
					break;
			emo_conlist[i][0] = r_account_item[i][0];
			emo_conlist[i][1] = r_account_money[i][0];
		}
		if(phoneNo.equals("")||phoneNo==null){}
		else
		{
			for(i=0;i<max_row;i++)
			{
				if(i >= r_score_item.length)
						break;
				emo_marklist[i][0] = r_score_item[i][0];
				emo_marklist[i][1] = r_score_value[i][0];	
			}
		}
%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>

	<meta http-equiv=Content-Type content="text/html; charset=gb2312">
	<meta name=ProgId content=Excel.Sheet>
	<meta name=Generator content="Microsoft Excel 11">
	<link rel=File-List href="1.files/filelist.xml">
	<link rel=Edit-Time-Data href="1.files/editdata.mso">
	<link rel=OLE-Object-Data href="1.files/oledata.mso">
	<link href='print.css' rel='stylesheet' type='text/css'>
	<style>
	@media print
	{
		body{font-size:1px}
		INPUT {display:none}
		select {display:none}
		.noplay{display:none}
	}
	</style>
	<script language="javascript" >
		var arrD = new Array();
		var arrC = new Array();
		var arrV = new Array();	
		onload = function()
		{
			document.all.printbody.style.zoom = "85%";
			document.all.control.style.zoom = "125%";
			getPD();
		}
	function getPD()
	{
			var ColrArray = new Array("navajowhite","mistyrose","orchid","powderblue","seagreen","aqua","violet","seashell","mediumaquamarine","gold");
<%
			for(i=0;i<r_fee_item.length;i++)
			{
				if(r_fee_level[i][0].equals("2"))
				{
					continue;
				}
				if("优惠费".equals(r_fee_item[i][0]))
				{
				    continue;
				}
%>				
				arrD[<%=i%>] = "<%=r_fee_item[i][0]%>";
				arrV[<%=i%>] = "<%=r_fee_money[i][0]%>";
<%
			}
%>
				xx("ARPU/上月费用构成");			
	}
	function xx(x)
	{
		var myChart=document.all.ChartSpace1;
		myChart.Clear();
		var a=myChart.Charts.Add(0);   // 就是图对象的实例化
		var c=myChart.Constants;       //
		a.Type=c.chChartTypeBar3D;//chChartTypeColumnClustered3D;
		a.ProjectionMode = c.chProjectionModeOrthographic;//投射方式.使用这种投影的优点是垂直线条保持垂直，使某些图表易于阅读。
		a.ChartDepth = "20";//深度比
		var paPlotArea = a.PlotArea;
		paPlotArea.BackWall.Thickness = 1;
		paPlotArea.BackWall.Interior.SetSolid("white");
		paPlotArea.SideWall.Thickness = 1;
		paPlotArea.SideWall.Interior.SetSolid("#FEFEFE");
		paPlotArea.Floor.Thickness = 1;
		paPlotArea.Floor.Interior.SetSolid("#FEFEFE");
		a.DirectionalLightInclination  = 0;//指定方向性光源相对于指定图表 X-Z 平面的旋转角度
		a.DirectionalLightRotation   = 0;//指定三维图表的方向性光源的旋转角度
		a.LightNormal = 0;//指定三维图表中从 90 度射出的光照量。
		a.HasLegend=false;
		myChart.HasSelectionMarks=true;
		myChart.AllowFiltering=true;
		myChart.AllowPropertyToolbox=true;
		var cs=a.SeriesCollection.Add(0);
		a.HasTitle = false;		
    	cs.Caption="金额(元)";
		cs.SetData(c.chDimCategories,c.chDataLiteral,arrD);
		cs.SetData(c.chDimValues,c.chDataLiteral,arrV);
		var dlSeries1Labels = cs.DataLabelsCollection.Add();
		dlSeries1Labels.NumberFormat = "0.00";
		dlSeries1Labels.HasCategoryName = false;
		dlSeries1Labels.HasValue = false;	
	}	
	function doPrint()
	{
		var   hkey_root,hkey_path,hkey_key;   
		hkey_root="HKEY_CURRENT_USER";   
		hkey_path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";   
		//设置网页打印的页眉页脚为空   
		try
		{   
		   var   RegWsh   =   new   ActiveXObject("WScript.Shell");   
		   hkey_key="header";   
		   RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"");   
		   hkey_key="footer";   
		   RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"");
		}catch(e)
		{}
  	factory.printing.header   =   ""  ; 
    factory.printing.footer   =   ""   ;
    factory.printing.portrait   =   true ;  
    factory.printing.leftMargin   =  0   ;
    factory.printing.topMargin   =   5   ;
    factory.printing.rightMargin   =   0  ; 
    factory.printing.bottomMargin   =   1.5  ;
		document.all.WebBrowser.ExecWB(6,6)
	 }	
	 function modZoom(x)
	 {
			document.all.printbody.style.zoom = x;
			if(x == "65%")
				document.all.control.style.zoom = "145%";
			if(x == "70%")
				document.all.control.style.zoom = "140%";
			if(x == "75%")
				document.all.control.style.zoom = "135%";
			if(x == "80%")
				document.all.control.style.zoom = "130%";
			if(x == "85%")
				document.all.control.style.zoom = "125%";	
		}
		function doView()
		{
	  	factory.printing.header   =    ""  ; 
    	factory.printing.footer   =   ""   ;
    	factory.printing.portrait   =   true ;  
    	factory.printing.leftMargin   =  0   ;
   	 	factory.printing.topMargin   =   5   ;
    	factory.printing.rightMargin   =   0  ; 
    	factory.printing.bottomMargin   =   1.5  ;
			document.all.WebBrowser.ExecWB(7,1); 
		}	
		</script>
</head>

	<body id="printbody" style="margin-left:0px;margin-top:0px" link=blue vlink=purple >
		<div id="article">
			<table x:str border=0 cellpadding=0 cellspacing=0 width=962 style='border-collapse:
 						collapse;table-layout:fixed;width:722pt'>
 				<col width=72 style='width:54pt' >
 				<col width=119 style='mso-width-source:userset;mso-width-alt:3808;width:89pt'>
 				<col width=187 style='mso-width-source:userset;mso-width-alt:5984;width:140pt'>
 				<col width=119 style='mso-width-source:userset;mso-width-alt:3808;width:89pt'>
 				<col width=18 style='mso-width-source:userset;mso-width-alt:576;width:14pt'>
 				<col width=89 style='mso-width-source:userset;mso-width-alt:2848;width:67pt'>
 				<col width=121 style='mso-width-source:userset;mso-width-alt:3872;width:91pt'>
 				<col width=146 style='mso-width-source:userset;mso-width-alt:4672;width:110pt'>
 				<col width=91 style='mso-width-source:userset;mso-width-alt:2912;width:68pt'>
 				<tr height=19 style='height:14.25pt'>
  			<td height=19 class=xl70 width=72 style='height:14.25pt;width:54pt'>　</td>
  			<td class=xl70 width=119 style='width:89pt'>　</td>
  			<td class=xl70 width=187 style='width:140pt'>　</td>
  			<td class=xl70 width=119 style='width:89pt'>　</td>
  			<td class=xl70 width=18 style='width:14pt'>　</td>
  			<td class=xl70 width=89 style='width:67pt'>　</td>
  			<td class=xl70 width=121 style='width:91pt'>　</td>
  			<td width=146 style='width:110pt' align=left valign=top>
<%
				String title_first = new String("本月末帐户余额为");
				String title_second = new String("本月末结余");
				String title_third = new String("本月末帐户余额");
				String image = new String();
				if(sm_code.equals("z0")||sm_code.equals("z1")||sm_code.equals("z2")||sm_code.equals("zn")||sm_code.equals("gn")||sm_code.equals("dn"))
				{  	
					if(sm_code.equals("z0")||sm_code.equals("z1")||sm_code.equals("z2")||sm_code.equals("zn"))
							image = "image005.jpg";
					if(sm_code.equals("gn"))
							image = "image007.jpg";
					if(sm_code.equals("dn"))
							image = "image006.jpg";
%>	
 					<![if !vml]><span style='mso-ignore:vglayout;
  				position:absolute;z-index:2;margin-left:44px;margin-top:17px;width:99px;
  				height:36px'><img width=99 height=36 src="./1.files/image002.jpg" v:shapes="Picture_x0020_2"></span><![endif]><span
  				style='mso-ignore:vglayout2'>
<%
				}
%>  
 	 <table cellpadding=0 cellspacing=0>
   	<tr>
    	<td height=19 class=xl70 width=146 style='height:14.25pt;width:110pt'>　</td>
    </tr>
   </table>
   </span></td>
      <td class=xl71 width=91 style='width:68pt'>　</td>
 	<tr height=34 style='height:25.5pt'>
  		<td height=34 class=xl70 style='height:25.5pt'>　</td>
  		<td colspan=7 class=xl72 >中国移动通信客户帐单</td>
  		<td class=xl73>　</td>
 	</tr>
 	<tr height=19 style='height:14.25pt'>
  		<td height=19 class=xl70 style='height:14.25pt'>　</td>
  		<td class=xl74>　</td>
  		<td class=xl74>　</td>
  		<td class=xl74>　</td>
  		<td class=xl74>　</td>
  		<td class=xl74>　</td>
  		<td class=xl74>　</td>
  		<td class=xl74>　</td>
  		<td class=xl70>　</td>
 	</tr>
 	<tr height=19 style='height:14.25pt'>
  		<td height=19 class=xl75 style='height:14.25pt'>　</td>
  		<td class=xl76 colspan="3"><span style='mso-spacerun:yes'>&nbsp;</span>客户姓名： <%=s_name%></td>
  		<td class=xl77>　</td>
  		<td class=xl76 x:str="                 "><span
  				style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  				</span><span style='display:none'><span
  				style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span></td>
<%
    	if((phoneNo==null)||("".equals(phoneNo)))
   		{
%>  
  			<td class=xl78 colspan="2">帐户号码： <%=contract_no1%></td>
<% 		}
  		else
  		{
%>
  			<td class=xl78 colspan="2">手机号码： <%=phoneNo%></td>
<%
 			}
%>
  		<td class=xl79>　</td>
 	</tr>

 	<tr height=19 style='height:14.25pt'>
  		<td height=19 class=xl75 style='height:14.25pt'>　</td>
  		<td class=xl76 colspan=3 style='mso-ignore:colspan'><span
  				style='mso-spacerun:yes'>&nbsp;</span>计费周期： <%=zy%>年 <%=zm%>月 <%=zdf%>日 至<span
  				style='mso-spacerun:yes'>&nbsp; </span><%=zy%>年 <%=zm%>月 <%=zdl%>日</td>
  		<td class=xl78>　</td>
  		<td class=xl80>　</td>
 			<td class=xl81 colspan=2 style='mso-ignore:colspan'>打印日期：<span
  				style='mso-spacerun:yes'> </span><%=ny%> 年 <%=nm%> 月 <%=nd%> 日</td>
  		<td class=xl82>　</td>
 	</tr>
 	<tr height=20 style='height:15.0pt'>
  		<td height=20 class=xl75 style='height:15.0pt'>　</td>
  		<td class=xl83>　</td>
  		<td class=xl83>　</td>
  		<td class=xl83>　</td>
  		<td class=xl83>　</td>
  		<td class=xl83>　</td>
  		<td class=xl83>　</td>
  		<td class=xl83>　</td>
  		<td class=xl82>　</td>
 	</tr>
 	<tr height=19 style='height:14.25pt'>
  		<td height=19 class=xl84 style='height:14.25pt'>　</td>
  		<td colspan=7 class=xl85 style='font-weight:700;border-right:1.0pt solid black'>费用信息</td>
  		<td class=xl88>　</td>
 	</tr>
 	<tr height=19 style='height:14.25pt'>
  		<td height=19 class=xl70 style='height:14.25pt'>　</td>
  		<td colspan=2 class=xl89 style='border-right:.5pt solid black'><span
  				style='mso-spacerun:yes'>&nbsp;</span>费用项目<span
  				style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  				</span>金额/元</td>
  		<td colspan=3 class=xl91 style='border-right:.5pt solid black;border-left:
  				none'>费用项目<span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  				</span>金额/元</td>
 			<td colspan=2 class=xl91 style='border-right:1.0pt solid black;border-left:
  				none'>费用项目<span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 					 </span>金额/元</td>
 			<td class=xl94>　</td>
 	</tr>
<%
		String title_style = null;
		String value_style = null;
		String title_style1 = null;
		String value_style1 = null;
		String title_style2 = null;
		String value_style2 = null;
		for(i=0;i<emo_list.length;i++)
		{ 
%>
		 <tr>
<%
			if((emo_list[i][2]==null?"":emo_list[i][2]).equals("1"))
			{
				title_style = "xl99";
				value_style = "xl100";
			}
			else
			{
				title_style = "xl102";
				value_style = "xl98";
			}
			if((emo_list1[i][2]==null?"":emo_list1[i][2]).equals("1"))
			{
				title_style1 = "xl99";
				value_style1 = "xl100";
			}
			else
			{
				title_style1 = "xl102";
				value_style1 = "xl98";
			}
			if((emo_list2[i][2]==null?"":emo_list2[i][2]).equals("1"))
			{
				title_style2 = "xl99";
				value_style2 = "xl100";
			}
			else
			{
				title_style2 = "xl102";
				value_style2 = "xl98";
			}
%>
		 		 <td class=xl70>　</td>
		  	 <td class=<%=title_style%>><%=emo_list[i][0]==null?"":emo_list[i][0]%></td>
<%
      if("".equals(emo_list[i][1]))
      {
%>
      	 <td class=<%=value_style%>><%=emo_list[i][1]==null?"":emo_list[i][1]%></td>		
<%    }
      else
      {
%>  
		     <td class=<%=value_style%>><%=emo_list[i][1]==null?"":emo_list[i][1]+"元"%></td>
<%    
			}
%>
		  	 <td class=<%=title_style1%>><%=emo_list1[i][0]==null?"":emo_list1[i][0]%></td>
		     <td class=xl76>　</td>
		     <td class=<%=value_style1%>><%=emo_list1[i][1]==null?"":emo_list1[i][1]+"元"%></td>
		     <td class=<%=title_style2%>><%=emo_list2[i][0]==null?"":emo_list2[i][0]%></td>
		     <td class=<%=value_style2%>><%=emo_list2[i][1]==null?"":emo_list2[i][1]+"元"%></td>
		     <td class=xl101>　</td>
		 </tr>			
<%	
		}
%>
		  <td class=xl70>　</td>
		  <td class=xl102> </td>
		  <td class=xl98> </td>
		  <td class=xl102> </td>
		  <td class=xl76>　</td>
		  <td class=xl98> </td>

				<td class=xl99> </td>
				<td class=xl100> </td>

		  <td class=xl101>　</td>
 	<tr height=20 style='height:15.0pt'>
  		<td height=20 class=xl70 style='height:15.0pt'>　</td>
  		<td colspan=7 class=xl109 style='border-right:1.0pt solid black'
  				x:str=" ">费用合计：<%=df.format(Float.parseFloat(r_fee_sum.length < 1?"0":r_fee_sum[0][0]))%> 元<span
  				style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
  		<td class=xl106>　</td>
 	</tr>
 	<tr height=20 style='height:15.0pt'>
  		<td height=20 class=xl70 style='height:15.0pt'>　</td>
  		<td class=xl112 style='border-top:none'>　</td>
  		<td class=xl113 style='border-top:none'>　</td>
  		<td class=xl113 style='border-top:none'>　</td>
  		<td class=xl114 style='border-top:none'>　</td>
  		<td class=xl113 style='border-top:none'>　</td>
  		<td class=xl113 style='border-top:none'>　</td>
  		<td class=xl113 style='border-top:none'>　</td>
  		<td class=xl106>　</td>
 	</tr>
 	<tr height=19 style='height:14.25pt'>
  		<td height=19 class=xl70 style='height:14.25pt'>　</td>
  		<td colspan=3 class=xl115 style='font-weight:700;border-right:1.0pt solid black'>帐户信息</td>
  		<td class=xl118 style='border-left:none'>　</td>
  		<td colspan=3 class=xl115 style='font-weight:700;border-right:1.0pt solid black;border-left:
  				none'>积分信息</td>
  		<td class=xl119>　</td>
 	</tr>
 	<tr height=19  style='height:14.25pt'>
  		<td height=19 class=xl70 style='height:14.25pt'>　</td>
  		<td class=xl120 style='border-top:none'>帐户项目</td>
  		<td class=xl121 style='border-top:none'>　</td>
  		<td class=xl122 style='border-top:none' x:str="金额/元 ">金额/元<span
  				style='mso-spacerun:yes'>&nbsp;</span></td>
  		<td class=xl123 style='border-left:none'>　</td>
  		<td colspan=2 class=xl120 style='border-left:none'>积分项目</td>
  		<td class=xl122 style='border-top:none'>积分值</td>
 			<td class=xl119>　</td>
 	</tr>
<%
	for(i=0;i<max_row;i++)
	{
%>
 		<tr height=19 style='height:14.25pt'>
  		<td height=19 class=xl81 style='height:14.25pt'>　</td>
  		<td colspan=2 class=xl139><%=emo_conlist[i][0]==null?"":emo_conlist[i][0]%></td>
  		<td class=xl133><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span><%=emo_conlist[i][1]==null?"":emo_conlist[i][1]+"元"%></td>
  		<td class=xl134 style='border-left:none'>　</td>
  		<td colspan=2 class=xl139 style='border-left:none'><%=emo_marklist[i][0]==null?"":emo_marklist[i][0]%></td>
  		<td class=xl129 x:num><span style='mso-spacerun:yes'>&nbsp;</span><%=emo_marklist[i][1]==null?"":emo_marklist[i][1]+"分"%></td>
  		<td class=xl130>　</td>
 		</tr>
<%
	 }
%>
 		<tr height=19 style='height:14.25pt'>
  		<td height=19 class=xl81 style='height:14.25pt'>　</td>
  		<td colspan=2 class=xl139>费用合计</td>
  		<td class=xl133><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span><%=df.format(Float.parseFloat(r_fee_sum.length < 1?"0":r_fee_sum[0][0]))%>元</td>
  		<td class=xl134 style='border-left:none'>　</td>
  		<td colspan=2 class=xl139 style='border-left:none'> </td>
  		<td class=xl129 x:num><span style='mso-spacerun:yes'>&nbsp;</span> </td>
  		<td class=xl130>　</td>
 		</tr>
  	<tr height=19 style='height:14.25pt'>
  		<td height=19 class=xl81 style='height:14.25pt'>　</td>
  		<td class=xl143><%=title_second%></td>
 			<td class=xl144>　</td>
  		<td class=xl145><span
  				style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
      System.out.println("月末帐户余额＝"+r_account_sum[0][0]);
    
%>  		
			</span><%=df.format(Float.parseFloat(r_account_sum.length < 1?"0":r_account_sum[0][0]))%><font class="font19">元</font><font class="font20"><span
  				style='mso-spacerun:yes'>&nbsp;</span></font></td>
				
  		<td class=xl128 style='border-left:none'>　</td>
<%
      if((phoneNo==null)||("".equals(phoneNo))||(r_score_item.length<1))
      {
%>
      	<td class=xl146 colspan=2 style='mso-ignore:colspan'></td>
  			<td class=xl148></td>
<%
      }
      else
      {
%>  
 		 <!--xl add-->
		 <%
			if(r_clean_score!=null && r_clean_score.length!=0)
			{
				if(r_clean_score[0][0]=="new" ||"new".equals(r_clean_score[0][0]) )
				{
					%>
					<td class=xl146 colspan=2 style='mso-ignore:colspan'>当前可用积分合计</td>
			 <td class=xl148><%=r_remain_score.length < 1?"0":r_remain_score[0][0]%><font class="font19">分</font></td>  
					<%	
				}
				else
				{
						%>  
				 <td class=xl146 colspan=2 style='mso-ignore:colspan'>本月末剩余积分</td>
			 <td class=xl148><%=r_remain_score.length < 1?"0":r_remain_score[0][0]%><font class="font19">分</font></td>  
					<%
				}
			}
			 
		 %>
		   
<%
      }
%>  
   		<td class=xl130>　</td>
 		</tr>
 		<tr height=20 style='height:15.0pt'>
  		<td height=20 class=xl81 style='height:15.0pt'>　</td>
  		<td colspan=3 class=xl149 style='border-right:1.0pt solid black'
  				x:str=""><%=title_third%>: <%=df.format(Float.parseFloat(r_account_sum.length < 1?"0":r_account_sum[0][0]))%> 元<span
  				style='mso-spacerun:yes'>&nbsp; </span><span
  				style='mso-spacerun:yes'>&nbsp;</span></td>
  		<td class=xl152 style='border-left:none'>　</td>
<% 
    if((phoneNo==null)||("".equals(phoneNo))||(r_score_item.length<1))
    {
%>
  	 	<td colspan=3 class=xl153 style='border-right:1.0pt solid black;border-left:
  				none'><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  				</span></td>
<%  
     }
     else
     {
%>
  		<!--xl add-->
		<%
			if(r_clean_score!=null && r_clean_score.length!=0)
			{
				if(r_clean_score[0][0]=="new" ||"new".equals(r_clean_score[0][0]))
				{
				%>
				<td colspan=3 class=xl109 style='border-right:1.0pt solid black;border-left:
					none'> </td>
				<%
				}
				else
				{
					%>
					<td colspan=3 class=xl109 style='border-right:1.0pt solid black;border-left:
					none'>年底清零积分<span
					style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</span><%=r_clean_score.length < 1?"0":r_clean_score[0][0]%>分</td>
					<%
				}
			}
		%>
	 
<%
     }
%>
  	<td class=xl130>　</td>
 	</tr>
 	<tr height=20 style='height:15.0pt'>
  	<td height=20 class=xl81 style='height:15.0pt'>　</td>
  	<td class=xl156 style='border-top:none'>　</td>
  	<td class=xl157 style='border-top:none'>　</td>
  	<td class=xl157 style='border-top:none'>　</td>
  	<td class=xl158>　</td>
  	<td class=xl159 style='border-top:none'>　</td>
  	<td class=xl159 style='border-top:none'>　</td>
  	<td class=xl159 style='border-top:none'>　</td>
  	<td class=xl130>　</td>
 	</tr>
 	<tr height=19 style='height:14.25pt'>
  	<td height=19 class=xl84 style='height:14.25pt'>　</td>
  	<td class=xl160 colspan=2 style='mso-ignore:colspan'><span
  			style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  			</span>消费分析图</td>
  	<td class=xl162 style='border-top:none'>　</td>
  	<td class=xl162 style='border-top:none'>　</td>
  	<td class=xl162 colspan=2 style='mso-ignore:colspan'><span
  			style='mso-spacerun:yes'>&nbsp;&nbsp; </span>部分代收信息费明细</td>
  	<td class=xl163 style='border-top:none'>　</td>
  	<td class=xl71>　</td>
 	</tr>
 	<tr height=20 style='height:15.0pt'>
  	<td height=20 class=xl84 style='height:15.0pt'>　</td>
  	<td class=xl164 colspan=2 rowspan=<%=r_service.length+3%>>
		<OBJECT id="ChartSpace1" classid="clsid:0002E556-0000-0000-C000-000000000046" style="" border="0" VIEWASTEXT width="300" height="220">
		</OBJECT>  	
  	</td>
  	<td class=xl77>服务商(SP)</td>
  	<td class=xl77>　</td>
  	<td class=xl76><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span>服务代码</td>
  	<td class=xl77><span style='mso-spacerun:yes'>&nbsp;</span>订购业务名称</td>
  	<td class=xl165>费用/元</td>
 	 	<td class=xl166>　</td>
 	</tr>
<%
    
   
    
 		for(i=0;i<r_service.length;i++)
 		{		
%>
 		<tr height=20 style='height:15.0pt'>
  		<td height=20 class=xl84 style='height:20.0pt'>　</td>
  		<td class=xl77><%=(r_service[i][0].length()<=16?r_service[i][0]:r_service[i][0].substring(0,16))%></td>
 			<td class=xl77>　</td>
 			<td class=xl77><span style='mso-spacerun:yes'>&nbsp;</span><%=r_service_code[i][0]%></td>
  		<td class=xl77><%=(r_busi_name[i][0].length()<=18?r_busi_name[i][0]:r_busi_name[i][0].substring(0,18))%></td>
  		<td class=xl167 x:num="10"><%=df.format(Float.parseFloat(r_replace_fee[i][0]))%></td>
  		<td class=xl166>　</td> 
  	</tr>
<%	
 		 }
 
%>
 		<tr height=20 style='height:15.0pt'>
  		<td height=20 class=xl84 style='height:15.0pt'>　</td>
  		<td colspan=4 class=xl77 style='mso-ignore:colspan'>　</td>
  		<td class=xl165>　</td>
  		<td class=xl166>　</td>
 		</tr>
 		<tr height=20 style='height:15.0pt'>
  		<td height=20 class=xl84 style='height:15.0pt'>　</td>
      <td class=xl170><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;
  		</span>合计:</td>
  		<td class=xl170>　</td>
  		<td class=xl170>　</td>
  		<td class=xl170>　</td>
  		<td class=xl171 x:num="20"><%=df.format(Float.parseFloat(r_replace_sum.length < 1?"0":r_replace_sum[0][0]))%> 元</td>
  		<td class=xl166>　</td>          		
 		</tr>
 		<tr height=25 style='height:24pt'>
  		<td height=25 class=xl84 style='height:24pt'>　</td>
 			<td colspan=7 class=xl172 style='border-right:1.0pt solid black'>备注：1、本月即本计费周期月。2、本月新增积分根据上月帐单费用合计费用计算，仅当您结清本月费用后才生效。3、本月新增积分及部分代收信息费明细每月3日后体现。</td>
  		<td class=xl166>　</td>
 		</tr>
 		<tr height=21 style='height:15.75pt'>
  		<td height=21 colspan=8 class=xl175 style='height:15.75pt;mso-ignore:colspan'>　</td>
  		<td class=xl81>　</td>
 		</tr>
 		<![if supportMisalignedColumns]>
 		<tr height=0 style='display:none'>
  		<td width=72 style='width:54pt'></td>
  		<td width=119 style='width:89pt'></td>
  		<td width=187 style='width:140pt'></td>
  		<td width=119 style='width:89pt'></td>
  		<td width=18 style='width:14pt'></td>
  		<td width=89 style='width:67pt'></td>
  		<td width=121 style='width:91pt'></td>
  		<td width=146 style='width:110pt'></td>
  		<td width=91 style='width:68pt'></td>
 		</tr>
 		<![endif]>
  </table>
</div>
<span id="control">
	 <center>
			<input class='button' name=print type=button value=打印 onClick='doPrint();'> 
			<input class='button' name=goback type=button value=返回 onClick='history.go(-1);'>
   </center>
<object ID='WebBrowser' style="display:none" WIDTH=0 HEIGHT=0 CLASSID='CLSID:8856F961-340A-11D0-A96B-00C04FD705A2' VIEWASTEXT></object>
<object id=factory viewastext style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
  codebase="smsx.cab#Version=6,3,436,14">
</object>
</span>
</body>
</html>
<%   
     
    }
 
 
 
 
%>
